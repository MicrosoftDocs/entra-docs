---
title: Configure an Azure Front Door CORS proxy
description: Adapt the Azure Front Door CORS proxy template for Embedded native authentication with a custom-domain authority, explicit browser policy, and uncached API routes.
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 11/13/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want a custom-domain CORS edge so that my browser application can call the Native Authentication API without changing its transaction contract.
---

# Configure an Azure Front Door CORS proxy for embedded native authentication

Configure Cross-Origin Resource Sharing (CORS) on your tenant's verified custom authentication domain with Azure Front Door. Start with a configured app and tenant domain setup. The edge forwards preflight and credential requests to the service; it doesn't need a separate origin just to answer `OPTIONS`.

Use these CORS rules for single-page applications with Embedded native authentication and Bring Your Own UX (BYO UX) websites. Android and iOS apps using native HTTP transports don't require CORS configuration.

<a id="local-draft-azure-front-door-native-authentication-proxy"></a>

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

<a id="configure-a-production-cors-proxy-for-native-authentication"></a>

## Prerequisites

- An Azure subscription and permission to deploy subscription-scoped templates, create the resource group, and manage its Front Door and monitoring resources. Use a scoped deployment role. If you use **Contributor** for this one-time provisioning task, limit the assignment's scope and duration, for example with [Privileged Identity Management](~/id-governance/privileged-identity-management/pim-resource-roles-assign-roles.md).
- Completion of [Configure an app for Embedded native authentication](how-to-native-authentication-configure-app.md).
- A custom domain verified in your external tenant and associated with a custom URL domain. Complete the tenant-configuration steps in [Enable custom URL domains](~/external-id/customers/how-to-custom-url-domain.md), and record the tenant GUID.
- Permission to manage the custom domain's DNS `CNAME` and `TXT` records.
- Git and [Azure Developer CLI](/azure/developer/azure-developer-cli/install-azd).

The deployment creates a Front Door profile, endpoint, origin group, service origin, custom domain with a managed certificate, rule set, and Log Analytics workspace. Review [Front Door pricing](https://azure.microsoft.com/pricing/details/frontdoor/) and monitoring costs. Standard is the sample default; Premium is also supported by its module. Neither tier selection adds a firewall policy to this template.

## Get the template

Use the [template revision](https://github.com/Azure-Samples/ms-identity-extid-cors-proxy-frontdoor/tree/d0111daba8c2674eab3c9819691c66caa3a96d63). This procedure creates a new profile. If the domain already uses Front Door, apply the equivalent API route and rule changes in that profile's infrastructure. Don't create a competing domain association or replace working DNS.

1. Get the source:

    ```powershell
    git clone https://github.com/Azure-Samples/ms-identity-extid-cors-proxy-frontdoor.git
    Set-Location .\ms-identity-extid-cors-proxy-frontdoor
    git checkout d0111daba8c2674eab3c9819691c66caa3a96d63
    ```

1. Initialize an Azure Developer CLI environment:

    ```powershell
    azd init
    ```

<a id="preserve-the-upstream-api-contract"></a>

## Configure the custom-domain API route

The pinned template outputs an `onmicrosoft.com` tenant path and matches `/*`. Change the API route and output to use your tenant GUID while keeping the documented service-origin configuration behind the custom domain.

1. In `infra\main.bicep`, add:

    ```bicep
    @description('Directory tenant ID, a GUID, for the custom authentication domain.')
    param tenantId string
    ```

1. In that file's `frontDoor` module parameters, add `tenantId: tenantId`. Keep `customDomain` as your tenant-verified authentication host. The module's existing `originUrl` remains the tenant's platform service host; it isn't an application-facing API authority.
1. In the `frontDoor` module declaration, add `dependsOn: [logAnalytics]` alongside `name`, `scope`, and `params`. Its diagnostic setting uses the workspace created by the `logAnalytics` module.
1. To select a tier explicitly, add `frontDoorSkuName: 'Standard_AzureFrontDoor'` or `frontDoorSkuName: 'Premium_AzureFrontDoor'` to the same module parameters. The module defaults to Standard when this value is omitted.
1. Replace the `CORS_PROXY_ENDPOINT` output with:

    ```bicep
    output CORS_PROXY_ENDPOINT string = 'https://${customDomain}/${tenantId}'
    ```

1. In `infra\modules\frontdoor.bicep`, add `param tenantId string`. Replace the `frontDoorRoute` resource's `patternsToMatch` and `supportedProtocols`, and disable its HTTP redirect:

    ```bicep
    patternsToMatch: [
      '/${tenantId}/api/v2.0/*'
      '/${tenantId}/oauth2/v2.0/authorize-challenge'
      '/${tenantId}/oauth2/v2.0/token'
    ]
    supportedProtocols: [
      'Https'
    ]
    httpsRedirect: 'Disabled'
    ```

1. Keep `forwardingProtocol: 'HttpsOnly'`, `linkToDefaultDomain: 'Disabled'`, and the custom-domain association. Don't add an origin path or URL rewrite: the service receives the original tenant-GUID path and query.
1. In `frontDoorOrigin.properties`, set `enforceCertificateNameCheck: true`. Keep `hostName` and `originHostHeader` set to the template's `originUrl`, as required by the [custom URL domain configuration](~/external-id/customers/how-to-custom-url-domain.md). Don't point this origin back to the same custom domain's Front Door endpoint.
1. Leave `cacheConfiguration` absent from the route and don't add a caching rule override. [Omitting this object disables route caching](/azure/templates/microsoft.cdn/profiles/afdendpoints/routes). Front Door proxies non-`GET` requests rather than caching them, but the explicit disabled configuration also covers other responses on the API route.
1. In the same file's `audit` resource, set `enabled: false` for `FrontdoorAccessLog`. Keep metrics enabled. Access logs can record full authentication URLs; don't enable them without a reviewed data-handling policy.

These are API-only routes. Keep hosted browser sign-in, fallback, and callback routing separate if your application uses those experiences. Don't widen this CORS route to `/*` to make an unrelated browser redirect work.

<a id="configure-the-preflight-capable-origin"></a>

## Configure the CORS and header rules

The service returns empty HTTP `200` native preflight before parsing or credential mutation, without an additional feature flag. Front Door supplies `Access-Control-Allow-Origin`. Replace the sample's unrestricted requested-method and requested-header reflection with explicit values.

1. Replace `infra\modules\frontdoor-rules-cors.bicep` with the following module:

    ```bicep
    param frontDoorProfileName string
    param corsAllowedOrigin string

    var requestHeadersToRemove = [
      'Proxy-Authorization'
    ]
    var responseHeadersToRemove = [
      'Access-Control-Allow-Origin'
      'Access-Control-Allow-Credentials'
      'Location'
    ]
    var requestHeaderActions = [for header in requestHeadersToRemove: {
      name: 'ModifyRequestHeader'
      parameters: {
        headerAction: 'Delete'
        headerName: header
        value: ''
        typeName: 'DeliveryRuleHeaderActionParameters'
      }
    }]
    var responseHeaderActions = [for header in responseHeadersToRemove: {
      name: 'ModifyResponseHeader'
      parameters: {
        headerAction: 'Delete'
        headerName: header
        value: ''
        typeName: 'DeliveryRuleHeaderActionParameters'
      }
    }]

    resource frontDoorProfile 'Microsoft.Cdn/profiles@2024-09-01' existing = {
      name: frontDoorProfileName
    }
    resource frontDoorRuleSet 'Microsoft.Cdn/profiles/ruleSets@2024-09-01' = {
      name: 'CORSRuleSet'
      parent: frontDoorProfile
    }
    resource requestBoundary 'Microsoft.Cdn/profiles/ruleSets/rules@2024-09-01' = {
      name: 'RequestBoundary'
      parent: frontDoorRuleSet
      properties: {
        order: 1
        conditions: []
        matchProcessingBehavior: 'Continue'
        actions: requestHeaderActions
      }
    }
    resource responseBoundary 'Microsoft.Cdn/profiles/ruleSets/rules@2024-09-01' = {
      name: 'ResponseBoundary'
      parent: frontDoorRuleSet
      properties: {
        order: 2
        conditions: []
        matchProcessingBehavior: 'Continue'
        actions: concat(responseHeaderActions, [
          {
            name: 'ModifyResponseHeader'
            parameters: {
              headerAction: 'Overwrite'
              headerName: 'Cache-Control'
              value: 'no-store'
              typeName: 'DeliveryRuleHeaderActionParameters'
            }
          }
        ])
      }
    }
    resource corsProxyRule 'Microsoft.Cdn/profiles/ruleSets/rules@2024-09-01' = {
      name: 'CORSRule'
      parent: frontDoorRuleSet
      properties: {
        order: 3
        conditions: [
          {
            name: 'RequestHeader'
            parameters: {
              operator: 'Equal'
              selector: 'Origin'
              matchValues: [corsAllowedOrigin]
              typeName: 'DeliveryRuleRequestHeaderConditionParameters'
            }
          }
          {
            name: 'RequestMethod'
            parameters: {
              operator: 'Equal'
              matchValues: ['POST', 'PUT', 'OPTIONS']
              typeName: 'DeliveryRuleRequestMethodConditionParameters'
            }
          }
        ]
        actions: [
          {
            name: 'ModifyResponseHeader'
            parameters: {
              headerAction: 'Overwrite'
              headerName: 'Access-Control-Allow-Origin'
              value: corsAllowedOrigin
              typeName: 'DeliveryRuleHeaderActionParameters'
            }
          }
          {
            name: 'ModifyResponseHeader'
            parameters: {
              headerAction: 'Overwrite'
              headerName: 'Access-Control-Allow-Methods'
              value: 'POST, PUT'
              typeName: 'DeliveryRuleHeaderActionParameters'
            }
          }
          {
            name: 'ModifyResponseHeader'
            parameters: {
              headerAction: 'Overwrite'
              headerName: 'Access-Control-Allow-Headers'
              value: 'Content-Type, Accept, client-request-id, x-client-sku, x-client-ver, x-client-os, x-client-cpu, x-client-current-telemetry, x-client-last-telemetry'
              typeName: 'DeliveryRuleHeaderActionParameters'
            }
          }
          {
            name: 'ModifyResponseHeader'
            parameters: {
              headerAction: 'Overwrite'
              headerName: 'Access-Control-Expose-Headers'
              value: 'Retry-After, client-request-id, x-ms-request-id, x-ms-clitelem'
              typeName: 'DeliveryRuleHeaderActionParameters'
            }
          }
        ]
      }
    }

    output frontDoorRuleSetId string = frontDoorRuleSet.id
    ```

1. Set `corsAllowedOrigin` to one exact browser origin, including its scheme and any nondefault port. For additional origins, add separate exact-match rules with unique names and orders after the two boundary rules. Don't replace the value with `*` or an unchecked request-header variable.
1. Review any application-specific API header before adding its exact name to the allowed-header value. Don't enable browser credential sharing. Keep the existing route association with `corsRules.outputs.frontDoorRuleSetId`.

The request rule removes `Proxy-Authorization` so client credentials for the edge aren't forwarded to the service. It forwards `Authorization` unchanged. The response rule removes upstream CORS grants and redirect locations, and adds `Cache-Control: no-store`. The final rule grants the configured browser origin access, including on service errors. An unexpected upstream redirect retains its status but has no `Location` for a browser to follow; handle it as an API failure without replaying credentials.

Cookie handling is separate from CORS. This recipe passes `Cookie` and `Set-Cookie` through. To make the route cookie-free, add `Cookie` to `requestHeadersToRemove` and `Set-Cookie` to `responseHeadersToRemove`, after confirming that your application and service don't rely on them.

These rules define browser CORS permission, not caller authentication. An unapproved browser origin gets no allowed-origin header, but CORS doesn't block all requests from reaching the service. Non-browser callers can supply an `Origin` header, and the service still validates operation methods. This configuration doesn't establish an unbypassable abuse-protection boundary.

<a id="configure-azure-front-door"></a>

## Deploy Azure Front Door

Supply the tenant and DNS values, then connect the verified custom domain to this endpoint.

1. Replace `infra\main.parameters.json` with:

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "environmentName": { "value": "${AZURE_ENV_NAME}" },
        "location": { "value": "${AZURE_LOCATION}" },
        "corsAllowedOrigin": { "value": "${CORS_ALLOWED_ORIGIN}" },
        "tenantSubdomain": { "value": "${TENANT_SUBDOMAIN}" },
        "customDomain": { "value": "${CUSTOM_DOMAIN}" },
        "tenantId": { "value": "${EXTERNAL_TENANT_ID}" }
      }
    }
    ```

1. Set the values for your deployment. `CUSTOM_DOMAIN` is a host name, not a full URL. `EXTERNAL_TENANT_ID` is the external tenant GUID, not necessarily the tenant used for your Azure subscription.

    ```powershell
    azd env set CORS_ALLOWED_ORIGIN "https://app.contoso.com"
    azd env set TENANT_SUBDOMAIN "contoso-external"
    azd env set CUSTOM_DOMAIN "login.contoso.com"
    azd env set EXTERNAL_TENANT_ID "aaaabbbb-0000-cccc-1111-dddd2222eeee"
    azd auth login
    azd up
    ```

1. Select the subscription and location when prompted. Read the deployment outputs:

    ```powershell
    azd env get-values
    ```

1. Create the custom domain's `CNAME` record pointing to `FRONTDOOR_ENDPOINT`. Use `CUSTOM_DOMAIN_DNS_TXT_DOMAIN`, `CUSTOM_DOMAIN_DNS_TXT_NAME`, and `CUSTOM_DOMAIN_DNS_TXT_VALUE` for the domain-validation `TXT` record, before `CUSTOM_DOMAIN_DNS_EXPIRY`.
1. In the Azure portal, open the Front Door profile's **Domains** page. Confirm domain validation, endpoint and route association, and the managed certificate are ready before sending authentication traffic. Use the actual DNS zone's relative record name if your DNS provider expects it.
1. Configure the application with the adapted `CORS_PROXY_ENDPOINT`, such as `https://login.contoso.com/<tenant-GUID>`. For this edge deployment, the service authority and browser transport prefix have the same value: use it for `auth.authority` and `customAuth.authApiProxyUrl`, and add the custom domain host to `auth.knownAuthorities`.

Don't use `FRONTDOOR_ENDPOINT`, the managed service-origin host, or the old `onmicrosoft.com` path as the application's service authority. The JavaScript SDK retains absolute HAL URLs: valid links already use the custom domain and receive its CORS policy. `authApiProxyUrl` doesn't rewrite them.

For a custom client, validate absolute and relative service-returned links against the custom domain and tenant-GUID prefix. Preserve the remaining path, query, method IDs, and current continuation token. For an SDK client, verify that its requests stay on this custom-domain route and check how it validates returned links.

## Validate the deployed proxy

Check preflight and actual responses on the custom domain, not the default Front Door hostname.

1. Send a credential-free preflight probe:

    ```powershell
    $authority = "https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee"
    $origin = "https://app.contoso.com"
    curl.exe --include --request OPTIONS "$authority/api/v2.0/signin/start" --header "Origin: $origin" --header "Access-Control-Request-Method: POST" --header "Access-Control-Request-Headers: content-type,client-request-id"
    ```

    Expect the service's empty HTTP `200` response with the edge's exact allowed origin, allowed methods and headers, and no credentials header. A generic HTML error page with HTTP `200` isn't a successful preflight.

1. Repeat with an unapproved origin and confirm that no `Access-Control-Allow-Origin` remains. An unsupported requested method or header must not receive the browser's required CORS permission.
1. In browser developer tools, check JSON `POST`, password-update `PUT`, form-encoded authorization and token exchange, returned-link routing, and the journeys your app implements, including any polling.
1. Confirm that non-success service statuses, error bodies, and `Retry-After` reach the client. Check that authentication responses, including errors, aren't cached, and that no API redirect is followed.
1. Check that the default endpoint and unrelated tenant paths don't match this API route. The route and CORS checks validate this path, not every service access path.

## Operate the proxy safely

Use the [shared proxy contract](concept-native-authentication-cors.md#proxy-contract) when reviewing changes to this deployment.

1. Monitor availability, request volume, latency, throttling, and errors with metrics. Keep credentials, tokens, full authentication URLs, and bodies out of diagnostics, and limit access and retention for any reviewed logs.
1. Keep the allowed origins, headers, route patterns, disabled caching, and TLS configuration in the infrastructure source. Review changes and have a previous working configuration available for rollback. Don't automatically retry ambiguous credential or password-update requests.

## Clean up resources

Remove only the environment created for this proxy when you no longer need it.

1. Switch the application away from this transport. Remove or restore this deployment's DNS records before deleting the endpoint, so you don't leave a dangling `CNAME`. Keep any tenant domain-verification records that are still required.
1. From this sample checkout and Azure Developer CLI environment, run:

    ```powershell
    azd down
    ```

1. Review the deletion prompt and remove only this environment's resources. Keep your tenant, app registration, and any preexisting Front Door profile or custom-domain resources.

## Related content

- [Embedded native authentication CORS concepts](concept-native-authentication-cors.md).
- [Azure Front Door Standard/Premium CORS](/azure/frontdoor/standard-premium/troubleshoot-cross-origin-resources).
- [Azure Front Door caching](/azure/frontdoor/front-door-caching).
