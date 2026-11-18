---
title: Configure a local CORS proxy for Embedded native authentication
description: Configure a loopback CORS proxy for Embedded native authentication with a custom-domain upstream and bounded request forwarding.
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 11/13/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want a local CORS proxy so that I can develop a browser integration with native authentication.
---

# Configure a local CORS proxy for embedded native authentication

Configure a local Cross-Origin Resource Sharing (CORS) proxy for direct API or custom-client development. Start with a configured app and your tenant's verified custom authentication domain. The examples adapt the JavaScript sample's proxy files; they don't change how the SDK handles absolute HAL links. Keep the proxy on your development computer.

CORS applies to browser API calls from single-page applications with Embedded native authentication and Bring Your Own UX (BYO UX) websites. Native Android and iOS HTTP clients don't need this CORS proxy.

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

<a id="test-a-browser-cors-proxy-for-native-authentication"></a>

## Prerequisites

- An external tenant and a [configured application](how-to-native-authentication-configure-app.md).
- A [tenant-verified custom authentication domain](~/external-id/customers/how-to-custom-url-domain.md), such as `login.contoso.com`, and the tenant GUID.
- Node.js 22 and npm 10, or a supported sample toolchain from the [SDK quickstart](quickstart-native-authentication.md).
- The React Next.js sample from the [SDK quickstart](quickstart-native-authentication.md), for its local proxy files.
- A browser client that can validate and route service links through this transport.
- Ports 3000 and 3001 available for the application and proxy.

## Create the local proxy

The [sample revision](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/tree/49c4e250a1e6eb97e2b813e9fce6670c996a2808/typescript/native-auth/react-nextjs-sample) includes `proxy.config.js` and `cors.js`. Apply the following changes in your local sample checkout.

1. Replace `proxy.config.js` with the following configuration. Replace the example custom domain and tenant GUID with your values.

    ```javascript
    const tenantCustomDomain = "login.contoso.com";
    const tenantId = "aaaabbbb-0000-cccc-1111-dddd2222eeee";

    module.exports = {
        localApiPath: "/api",
        port: 3001,
        allowedOrigin: "http://localhost:3000",
        proxy: `https://${tenantCustomDomain}/${tenantId}`,
    };
    ```

1. Set `allowedOrigin` to the exact origin of your browser application. For example, use `http://localhost:4200` for an application on that port. Don't use a wildcard or include a path.
1. Replace `cors.js` with the following loopback implementation. It uses Node.js built-in modules, preserves JSON and form bodies, and doesn't follow upstream redirects.

    ```javascript
    const http = require("node:http");
    const https = require("node:https");
    const config = require("./proxy.config");

    const authority = new URL(config.proxy);
    const tenantPath = authority.pathname;
    const allowedHeaders = [
        "content-type", "accept", "client-request-id",
        "x-client-sku", "x-client-ver", "x-client-os", "x-client-cpu",
        "x-client-current-telemetry", "x-client-last-telemetry",
    ];
    const responseHeaders = [
        "content-type", "content-encoding", "retry-after", "client-request-id",
        "x-ms-request-id", "x-ms-clitelem",
    ];
    const oauthPaths = new Set([
        "/oauth2/v2.0/authorize-challenge",
        "/oauth2/v2.0/token",
    ]);

    if (authority.protocol !== "https:" || authority.port ||
        authority.username || authority.password || authority.search || authority.hash ||
        /(^|\.)(ciamlogin\.com|onmicrosoft\.com|microsoftonline\.com)$/.test(authority.hostname) ||
        !/^\/[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}$/i.test(tenantPath) ||
        new URL(config.allowedOrigin).origin !== config.allowedOrigin ||
        config.localApiPath !== "/api" ||
        !Number.isInteger(config.port) || config.port < 1024 || config.port > 65535) {
        throw new Error("Configure an HTTPS custom authority, tenant GUID, and exact browser origin.");
    }

    function allows(path, method) {
        return (method === "POST" &&
            (path.startsWith("/api/v2.0/") || oauthPaths.has(path))) ||
            (method === "PUT" &&
            /^\/api\/v2\.0\/auth\/methods\/password\/[^/]+$/.test(path));
    }

    const server = http.createServer(async (req, res) => {
        const headers = { "Cache-Control": "no-store", Vary: "Origin" };
        const reply = (status, error) => {
            if (!res.destroyed && !res.writableEnded) {
                res.writeHead(status, { ...headers, "Content-Type": "application/json" });
                res.end(JSON.stringify({ error }));
            }
        };
        if (req.headers.origin !== config.allowedOrigin ||
            ![`localhost:${config.port}`, `127.0.0.1:${config.port}`].includes(req.headers.host)) {
            return reply(403, "proxy_origin_rejected");
        }
        headers["Access-Control-Allow-Origin"] = config.allowedOrigin;
        headers["Access-Control-Expose-Headers"] = responseHeaders.slice(2).join(", ");

        try {
            const raw = req.url || "";
            const split = raw.indexOf("?");
            const path = split < 0 ? raw : raw.slice(0, split);
            const query = split < 0 ? "" : raw.slice(split);
            if (!path.startsWith(`${config.localApiPath}/`) ||
                /[\\#\u0000-\u0020]/.test(raw) || /%(2f|5c|25)/i.test(path)) {
                return reply(400, "proxy_path_rejected");
            }
            const apiPath = path.slice(config.localApiPath.length);
            const target = new URL(`${authority.href}${apiPath}${query}`);
            if (target.pathname !== `${tenantPath}${apiPath}` ||
                target.search !== query || target.hash) {
                return reply(400, "proxy_path_rejected");
            }
            const method = req.method === "OPTIONS"
                ? req.headers["access-control-request-method"] : req.method;
            if (!allows(apiPath, method)) {
                return reply(405, "proxy_method_or_path_rejected");
            }
            if (req.method === "OPTIONS") {
                const requested = String(req.headers["access-control-request-headers"] || "")
                    .split(",").map(value => value.trim().toLowerCase()).filter(Boolean);
                if (requested.some(value => !allowedHeaders.includes(value))) {
                    return reply(403, "proxy_header_rejected");
                }
                res.writeHead(204, {
                    ...headers,
                    "Access-Control-Allow-Methods": "POST, PUT",
                    "Access-Control-Allow-Headers": allowedHeaders.join(", "),
                });
                return res.end();
            }

            const chunks = [];
            let size = 0;
            for await (const chunk of req) {
                size += chunk.length;
                if (size > 1024 * 1024) {
                    return reply(413, "proxy_body_too_large");
                }
                chunks.push(chunk);
            }
            const forwarded = { origin: config.allowedOrigin };
            for (const name of allowedHeaders) {
                if (req.headers[name] !== undefined) {
                    forwarded[name] = req.headers[name];
                }
            }
            const upstream = https.request(target, {
                method: req.method,
                headers: forwarded,
            }, response => {
                if (response.statusCode >= 300 && response.statusCode < 400) {
                    response.resume();
                    return reply(502, "proxy_redirect_rejected");
                }
                for (const name of responseHeaders) {
                    if (response.headers[name] !== undefined) {
                        headers[name] = response.headers[name];
                    }
                }
                res.writeHead(response.statusCode, headers);
                response.on("error", () => res.destroy());
                response.pipe(res);
            });
            let timedOut = false;
            const timer = setTimeout(() => {
                timedOut = true;
                upstream.destroy(new Error("proxy_timeout"));
            }, 30_000);
            upstream.on("error", () => {
                clearTimeout(timer);
                if (res.headersSent) {
                    res.destroy();
                } else {
                    reply(timedOut ? 504 : 502, timedOut ? "proxy_timeout" : "proxy_upstream_failed");
                }
            });
            res.on("close", () => {
                clearTimeout(timer);
                upstream.destroy();
            });
            upstream.end(Buffer.concat(chunks));
        } catch {
            reply(502, "proxy_request_failed");
        }
    });
    server.requestTimeout = 30_000;
    server.headersTimeout = 10_000;
    server.listen(config.port, "127.0.0.1");
    ```

1. If your application adds a custom API header, review it and add its exact name to `allowedHeaders`. Don't forward browser cookies, `Authorization`, or proxy secrets. The example forwards the validated `Origin` consistently for native and OAuth calls.

The 1-MiB body bound and 30-second upstream deadline are local proxy limits, not native authentication service limits. The proxy rejects ambiguous path encodings instead of changing an operation's path.

## Start the proxy

Run the application and proxy in separate terminals in the sample directory. The transport helper in the next section is for a direct API or custom client, not an automatic change to the SDK's network implementation.

1. Start the proxy:

    ```bash
    npm run cors
    ```

1. In another terminal, run `npm run dev` for the React Next.js sample. Open `http://localhost:3000`.

## Route the browser's requests

Use the local proxy for browser transport without changing the service authority. The JavaScript SDK's `customAuth.authApiProxyUrl` doesn't remap absolute HAL links, and it has no supported URL-rewrite setting. Setting that option alone therefore doesn't route every SDK request through localhost. For SDK integration, use [CORS policy on the custom-domain edge](how-to-native-authentication-cors-front-door.md) and see [SDK compatibility](how-to-migrate-native-authentication-v1-v2.md#sdk-compatibility).

1. Configure your custom client's service authority as `https://<tenant-verified-custom-domain>/<tenant-GUID>`, matching `proxy.config.js`. Keep `http://localhost:3001/api` as a separate transport prefix.
1. Route requests through a checked transport helper such as the following. Replace the example authority with your configured authority. Use the helper from your custom client's API calls; it doesn't intercept or modify SDK calls.

    ```javascript
    const serviceAuthority = new URL(
        "https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee"
    );
    const proxyPrefix = "http://localhost:3001/api";

    function callService(href, method, contentType, body) {
        const rawPath = href.split(/[?#]/)[0];
        if (/[\\\u0000-\u0020]/.test(href) ||
            /%(2f|5c|25)/i.test(rawPath) ||
            /(?:^|\/)(?:\.|%2e){1,2}(?:\/|$)/i.test(rawPath)) {
            throw new Error("Ambiguous service link.");
        }
        const selected = new URL(href, `${serviceAuthority.href}/`);
        const query = href.includes("?") ? href.slice(href.indexOf("?")) : "";
        const prefix = `${serviceAuthority.pathname}/`;
        if (selected.protocol !== "https:" || selected.origin !== serviceAuthority.origin ||
            selected.username || selected.password || selected.hash ||
            selected.search !== query ||
            !selected.pathname.startsWith(prefix)) {
            throw new Error("Service link is outside the configured authority.");
        }
        const path = selected.pathname.slice(serviceAuthority.pathname.length);
        const nativePost = method === "POST" && path.startsWith("/api/v2.0/");
        const oauthPost = method === "POST" && [
            "/oauth2/v2.0/authorize-challenge", "/oauth2/v2.0/token",
        ].includes(path);
        const passwordPut = method === "PUT" &&
            /^\/api\/v2\.0\/auth\/methods\/password\/[^/]+$/.test(path);
        if (!nativePost && !oauthPost && !passwordPut) {
            throw new Error("Unsupported service operation.");
        }
        return fetch(`${proxyPrefix}${path}${selected.search}`, {
            method,
            headers: {
                "Content-Type": contentType,
                Accept: nativePost || passwordPut ? "application/hal+json" : "application/json",
            },
            body,
            credentials: "omit",
            cache: "no-store",
            redirect: "error",
        });
    }
    ```

1. Pass the operation's JSON or form-encoded body without changing its fields. For continuation requests, use the operation link and latest token from the same response. Handle non-success responses explicitly; the helper doesn't implement the authentication state machine or retry requests.

For example, `https://login.contoso.com/<tenant-GUID>/api/v2.0/signin/start` maps to `http://localhost:3001/api/api/v2.0/signin/start`. Don't remove the service's `/api/v2.0` segment. Treat an absolute link to another domain or tenant as a routing error and reject the request.

## Verify CORS and error behavior

This implementation answers validated preflight locally with HTTP `204`. The service can also answer native `OPTIONS` with an empty HTTP `200`, but doesn't supply the allowed-origin policy. Verify the browser-to-proxy exchange, including the status and required CORS response headers.

1. Open the browser's developer tools and confirm that your custom client's authentication requests use the local proxy, including requests selected through absolute and relative service links.
1. Check preflight for JSON `POST`, password-update `PUT`, and the headers your client sends. Confirm an exact `Access-Control-Allow-Origin`, the allowed method and headers, and no `Access-Control-Allow-Credentials`.
1. Complete the journeys your app implements, including authorization challenge, form-encoded token exchange, additional authentication, and password-reset polling. Confirm that returned links stay on the configured tenant route.
1. Check that an unapproved origin, an unsupported requested header, another tenant path, and an unsupported method fail without an upstream credential request.
1. Confirm that non-success responses reach the app with their status, body, and applicable retry guidance intact. Don't automatically replay credentials after an ambiguous failure.
1. Confirm that a redirect or unreachable upstream produces an explicit proxy failure. Check `Cache-Control: no-store` and keep authentication bodies out of diagnostics.

Don't change the loopback binding to publish this development server. For shared hosting, use a deployment that meets the [shared proxy contract](concept-native-authentication-cors.md#proxy-contract).

## Clean up resources

End the local test by signing out and stopping both processes.

1. Sign out of the sample.
1. Stop its application and proxy processes in their terminals.

Keep credentials and authentication responses out of saved diagnostics.

## Related content

- [Embedded native authentication CORS concepts](concept-native-authentication-cors.md).
- [Configure an app for Embedded native authentication](how-to-native-authentication-configure-app.md).
