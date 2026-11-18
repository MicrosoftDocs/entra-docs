---
title: Configure an Azure Functions CORS proxy
description: Adapt and deploy the Azure Functions CORS proxy sample for Embedded native authentication with a tenant-verified custom-domain authority.
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 11/13/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want an Azure Functions CORS proxy so that my browser application can call the Native Authentication API through a bounded transport.
---

# Configure an Azure Functions CORS proxy for embedded native authentication

Use an Azure Functions HTTP trigger for Cross-Origin Resource Sharing (CORS) between your custom browser client and the Native Authentication API. Start with a configured app and tenant-verified custom domain. This guide adapts the sample's handler and configuration, then deploys its Flex Consumption infrastructure.

CORS applies to browser API calls from single-page applications with Embedded native authentication and Bring Your Own UX (BYO UX) websites. Native Android and iOS HTTP clients don't need this CORS proxy.

<a id="local-draft-azure-functions-cors-proxy-for-native-authentication"></a>

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

## Prerequisites

- An Azure subscription and permission to deploy subscription-scoped templates and create the resource group. The template also creates Azure role assignments, so the deployment identity needs `Microsoft.Authorization/roleAssignments/write` at the resource scopes. **Contributor** alone doesn't grant that action; use an appropriately scoped role-assignment operator rather than granting tenant-wide administration.
- Completion of [Configure an app for Embedded native authentication](how-to-native-authentication-configure-app.md).
- A working [tenant-verified custom authentication domain](~/external-id/customers/how-to-custom-url-domain.md), the tenant GUID, and the exact browser origin, such as `https://app.contoso.com`.
- Node.js 22, npm, Git, and [Azure Developer CLI](/azure/developer/azure-developer-cli/install-azd).
- An Azure location supported by both Flex Consumption and the sample's `location` parameter.

The template creates a function app, Flex Consumption plan, storage, managed identity, virtual network, storage private endpoints, Application Insights, and Log Analytics. Review [Azure Functions pricing](https://azure.microsoft.com/pricing/details/functions/) and the costs of those supporting resources.

The managed identity uses **Storage Blob Data Owner** on the storage account and **Monitoring Metrics Publisher** on Application Insights. These grants don't authenticate callers of the anonymous HTTP trigger.

## Get the sample

Use the [sample revision](https://github.com/Azure-Samples/ms-identity-extid-cors-proxy-function/tree/613e76012b61098e37d4bc51ae68c1d6a36954c3). Make the following changes in your own checkout, not in an already running deployment.

1. Get the source:

    ```powershell
    git clone https://github.com/Azure-Samples/ms-identity-extid-cors-proxy-function.git
    Set-Location .\ms-identity-extid-cors-proxy-function
    git checkout 613e76012b61098e37d4bc51ae68c1d6a36954c3
    ```

1. Initialize an Azure Developer CLI environment:

    ```powershell
    azd init
    ```

## Configure preflight and forwarding

The pinned handler constructs a `ciamlogin.com` host and an `onmicrosoft.com` tenant path from `TENANT_SUBDOMAIN`. That isn't the current custom-domain/GUID authority contract. Keep the sample's HTTP trigger and Axios transport, but change the authority and forwarding policy.

1. Replace `src\functions\httpProxyFunction.js` with the following handler. `SERVICE_AUTHORITY` and `CORS_ALLOWED_ORIGIN` are settings added by this guide, not settings supplied by the unchanged sample.

    ```javascript
    const { app } = require("@azure/functions");
    const axios = require("axios");

    const authority = new URL(process.env.SERVICE_AUTHORITY);
    const allowedOrigin = process.env.CORS_ALLOWED_ORIGIN;
    if (authority.protocol !== "https:" || authority.port ||
        authority.username || authority.password || authority.search || authority.hash ||
        /(^|\.)(ciamlogin\.com|onmicrosoft\.com|microsoftonline\.com)$/.test(authority.hostname) ||
        !/^\/[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}$/i.test(authority.pathname) ||
        new URL(allowedOrigin).origin !== allowedOrigin) {
        throw new Error("Configure an HTTPS custom authority, tenant GUID, and exact browser origin.");
    }
    const allowedHeaders = [
        "content-type", "accept", "client-request-id",
        "x-client-sku", "x-client-ver", "x-client-os", "x-client-cpu",
        "x-client-current-telemetry", "x-client-last-telemetry",
    ];
    const responseHeaders = [
        "content-type", "content-encoding", "retry-after",
        "client-request-id", "x-ms-request-id", "x-ms-clitelem",
    ];
    const oauthPaths = new Set([
        "/oauth2/v2.0/authorize-challenge",
        "/oauth2/v2.0/token",
    ]);
    function allows(path, method) {
        return (method === "POST" &&
            (path.startsWith("/api/v2.0/") || oauthPaths.has(path))) ||
            (method === "PUT" &&
            /^\/api\/v2\.0\/auth\/methods\/password\/[^/]+$/.test(path));
    }

    app.http("httpProxyFunction", {
        methods: ["POST", "PUT", "OPTIONS"],
        route: "{*path}",
        authLevel: "anonymous",
        handler: async request => {
            const headers = { "Cache-Control": "no-store", Vary: "Origin" };
            const fail = (status, error) => ({
                status,
                headers: { ...headers, "Content-Type": "application/json" },
                body: JSON.stringify({ error }),
            });
            if (request.headers.get("origin") !== allowedOrigin) {
                return fail(403, "proxy_origin_rejected");
            }
            headers["Access-Control-Allow-Origin"] = allowedOrigin;
            headers["Access-Control-Expose-Headers"] = responseHeaders.slice(2).join(", ");
            try {
                const incoming = new URL(request.url);
                const path = incoming.pathname;
                const rawTarget = request.url.match(/^https?:\/\/[^/?#]+([^#]*)$/i)?.[1];
                if (rawTarget === undefined) return fail(400, "proxy_path_rejected");
                const split = rawTarget.indexOf("?");
                const rawPath = (split < 0 ? rawTarget : rawTarget.slice(0, split)) || "/";
                const rawQuery = split < 0 ? "" : rawTarget.slice(split);
                if (path !== rawPath || incoming.search !== rawQuery ||
                    /[\\\u0000-\u0020]/.test(path) || /%(2f|5c|25)/i.test(path)) {
                    return fail(400, "proxy_path_rejected");
                }
                const target = new URL(`${authority.href}${path}${incoming.search}`);
                if (target.pathname !== `${authority.pathname}${path}` ||
                    target.search !== incoming.search || target.hash) {
                    return fail(400, "proxy_path_rejected");
                }
                const method = request.method === "OPTIONS"
                    ? request.headers.get("access-control-request-method") : request.method;
                if (!allows(path, method)) {
                    return fail(405, "proxy_method_or_path_rejected");
                }
                if (request.method === "OPTIONS") {
                    const requested = (request.headers.get("access-control-request-headers") || "")
                        .split(",").map(value => value.trim().toLowerCase()).filter(Boolean);
                    if (requested.some(value => !allowedHeaders.includes(value))) {
                        return fail(403, "proxy_header_rejected");
                    }
                    return {
                        status: 204,
                        headers: {
                            ...headers,
                            "Access-Control-Allow-Methods": "POST, PUT",
                            "Access-Control-Allow-Headers": allowedHeaders.join(", "),
                        },
                    };
                }
                const body = Buffer.from(await request.arrayBuffer());
                if (body.length > 1024 * 1024) {
                    return fail(413, "proxy_body_too_large");
                }
                const forwarded = { origin: allowedOrigin };
                for (const name of allowedHeaders) {
                    const value = request.headers.get(name);
                    if (value !== null) forwarded[name] = value;
                }
                const response = await axios.request({
                    url: target.href,
                    method: request.method,
                    headers: forwarded,
                    data: body,
                    timeout: 30_000,
                    maxBodyLength: 1024 * 1024,
                    maxContentLength: 1024 * 1024,
                    maxRedirects: 0,
                    proxy: false,
                    decompress: false,
                    responseType: "arraybuffer",
                    validateStatus: () => true,
                });
                if (response.status >= 300 && response.status < 400) {
                    return fail(502, "proxy_redirect_rejected");
                }
                for (const name of responseHeaders) {
                    if (response.headers[name] !== undefined) {
                        headers[name] = response.headers[name];
                    }
                }
                return { status: response.status, headers, body: response.data };
            } catch (error) {
                return fail(
                    ["ECONNABORTED", "ETIMEDOUT"].includes(error?.code) ? 504 : 502,
                    "proxy_upstream_failed"
                );
            }
        },
    });
    ```

1. If your application uses additional API headers, review and add their exact names to `allowedHeaders`. Don't add browser cookies, bearer authorization, function keys, or proxy credentials. The handler forwards the validated `Origin` consistently for native and OAuth calls.
1. Keep `extensions.http.routePrefix` set to `""` in `host.json`. The browser-facing paths are `/api/v2.0/...` and `/oauth2/v2.0/...`; the handler adds the configured tenant authority.

The handler answers validated preflight locally with HTTP `204`; it doesn't invoke an authentication operation. The service also supports empty HTTP `200` native preflight, without an additional feature flag. Neither behavior supplies your origin policy automatically.

The handler's 1-MiB request/response bounds and 30-second upstream timeout are proxy limits, not service limits. A rejected redirect, oversized response, or transport failure becomes an explicit proxy error. It isn't retried with the user's credentials.

## Adapt the deployment configuration

Wire the new settings into the existing infrastructure before deployment.

1. In `infra\main.bicep`, replace the `tenantSubdomain` parameter and its description with:

    ```bicep
    @description('HTTPS tenant-verified custom-domain authority, including the tenant GUID.')
    param serviceAuthority string
    ```

1. In the same file's `proxy` module, change `runtimeVersion` from `'20'` to `'22'`. Replace `appSettings` and `corsAllowedOrigins` with:

    ```bicep
    appSettings: {
      SERVICE_AUTHORITY: serviceAuthority
      CORS_ALLOWED_ORIGIN: corsAllowedOrigin
    }
    corsAllowedOrigins: []
    ```

    The handler owns CORS in this configuration. The empty platform allowlist avoids a second preflight policy and removes the sample's extra Azure portal origin.

1. Add `'22'` to the `runtimeVersion` allowed values in `infra\core\host\functions-flexconsumption.bicep`. Keep its other values. Node.js 22 is a [supported Functions runtime](/azure/azure-functions/functions-versions).
1. Replace `infra\main.parameters.json` with the following mapping. This also removes the pinned sample's trailing-space `"tenantSubdomain "` key.

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "environmentName": { "value": "${AZURE_ENV_NAME}" },
        "location": { "value": "${AZURE_LOCATION}" },
        "corsAllowedOrigin": { "value": "${CORS_ALLOWED_ORIGIN}" },
        "serviceAuthority": { "value": "${SERVICE_AUTHORITY}" }
      }
    }
    ```

1. In `host.json`, replace the `logging` object with the following settings. Keep the existing extension bundle and empty HTTP route prefix. These settings disable automatic request and dependency capture, which can record full authentication URLs.

    ```json
    {
      "logLevel": {
        "default": "Warning",
        "Host.Results": "None",
        "Host.Aggregator": "None"
      },
      "applicationInsights": {
        "enableDependencyTracking": false,
        "samplingSettings": { "isEnabled": true }
      }
    }
    ```

<a id="deploy-the-test-proxy"></a>

## Deploy the proxy

Supply your own nonsecret domain and origin values, then deploy the adapted project.

1. Set the added environment value and the existing CORS input:

    ```powershell
    azd env set SERVICE_AUTHORITY "https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee"
    azd env set CORS_ALLOWED_ORIGIN "https://app.contoso.com"
    ```

1. Sign in to Azure Developer CLI and deploy:

    ```powershell
    azd auth login
    azd up
    ```

1. Select the subscription and a supported location when prompted. Record the HTTPS endpoint printed for the `proxy` service. `SERVICE_PROXY_NAME` and `AZURE_FUNCTION_NAME` identify the deployed function app.
1. Configure your custom client's service authority as the custom-domain/GUID authority. Use the function's HTTPS endpoint as its transport prefix, without a tenant path or an added `/api` prefix. The [local guide's checked transport helper](how-to-native-authentication-cors-local.md#route-the-browsers-requests) can use this endpoint as `proxyPrefix`.

The function endpoint is a transport prefix, not your service authority. A request to `<function-endpoint>/api/v2.0/signin/start` forwards to `https://<custom-domain>/<tenant-GUID>/api/v2.0/signin/start`. Validate service-returned links against the custom authority before mapping them to this transport.

The JavaScript SDK's `customAuth.authApiProxyUrl` doesn't remap absolute HAL links and has no supported URL-rewrite setting. Setting `authApiProxyUrl` to the Functions endpoint alone doesn't route all SDK requests through the proxy. For SDK calls that retain absolute service links, configure [CORS policy at the custom-domain edge](how-to-native-authentication-cors-front-door.md).

## Verify the deployed proxy

Check the browser-facing endpoint and the complete authentication journey.

1. Send a credential-free preflight probe, replacing the endpoint and allowed origin:

    ```powershell
    $proxy = "https://<function-host>"
    $origin = "https://app.contoso.com"
    curl.exe --include --request OPTIONS "$proxy/api/v2.0/signin/start" --header "Origin: $origin" --header "Access-Control-Request-Method: POST" --header "Access-Control-Request-Headers: content-type,client-request-id"
    ```

    Expect HTTP `204`, the exact allowed origin, allowed methods and headers, and no credentials header. Repeat with an unapproved origin or header and confirm rejection.

1. In browser developer tools, check JSON `POST` and password-update `PUT` preflight. Confirm that authorization challenge and token exchange retain their form encoding and that current returned links remain on the configured tenant route.
1. Complete the journeys your app implements, including any additional authentication and password-update polling. Confirm that service errors, status codes, and `Retry-After` reach the client unchanged.
1. Check that cookies and proxy secrets aren't forwarded, responses have `Cache-Control: no-store`, and diagnostics contain no authentication bodies or full URLs. Check explicit failure behavior without replaying credentials.

## Clean up resources

Remove only the environment created for this proxy when you no longer need it.

1. Point the application back to its previous transport or remove the test configuration.
1. From this sample checkout and Azure Developer CLI environment, run:

    ```powershell
    azd down
    ```

1. Review the deletion prompt and remove only this environment's resources. Keep your preexisting tenant, app registration, custom authentication domain, and any separate custom-domain hosting resources.

## Related content

- [Embedded native authentication CORS concepts](concept-native-authentication-cors.md).
- [Secure Azure Functions](/azure/azure-functions/security-concepts).
