---
title: Embedded native authentication CORS concepts
description: Understand CORS and proxy requirements for SPAs with Embedded native authentication and BYO UX websites, and why native Android and iOS calls don't need CORS.
ms.topic: concept-article
ms.custom: msecd-doc-authoring-1030
ms.date: 11/17/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want to understand browser proxy requirements so that I can plan a native authentication integration that preserves the API contract.
---

# Embedded native authentication CORS concepts

Cross-Origin Resource Sharing (CORS) controls whether browser code can read a response from another origin. Single-page applications (SPAs) with Embedded native authentication and Bring Your Own UX (BYO UX) websites need a proxy or edge CORS policy for cross-origin calls to the Native Authentication API.

Android and iOS apps that call the API through native HTTP transports don't need CORS or a CORS proxy. They call the configured service authority directly. The requirements in this article apply to browser requests, not those native API calls.

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

## Why browser CORS applies

A browser app and its tenant authentication endpoint typically have different origins. For cross-origin requests, the browser checks the server's CORS response headers before exposing the response to application code.

An origin includes the scheme, host, and port. Sharing a parent domain doesn't make two origins the same.

The API's JSON `POST` requests and password-update `PUT` requests require a preflight check. The browser sends `OPTIONS` with the requested method and headers before sending the authentication request. A header such as `client-request-id` also triggers preflight. Form-encoded OAuth requests are part of the same integration; their method and headers determine whether preflight is required.

Browser code remains subject to CORS even when it runs in an embedded webview. CORS governs browser response access; caller authentication and abuse prevention require separate controls.

## Why a proxy is required

The native authentication service handles `OPTIONS` before parsing the API request or invoking its credential action. It returns an empty HTTP `200`. When the request includes `Origin`, the service advertises the action's accepted methods and echoes requested headers in `Access-Control-Allow-Headers`. No additional preflight feature flag is needed.

The service doesn't supply `Access-Control-Allow-Origin` or `Access-Control-Allow-Credentials`. Your proxy or edge supplies the explicit allowed-origin policy. It can forward the service's preflight response or answer a validated preflight locally. An HTML error page with an outer HTTP `200` isn't a successful preflight response.

The proxy preserves the API operations, bodies, and transaction state. Forwarding or omitting the upstream `Origin` header is an implementation choice, not a universal requirement to remove it. Apply your choice consistently and check authorization, native operations, and token exchange together.

## Service authority and proxy transport

For the browser integrations covered in this article, Embedded native authentication and BYO UX service API URLs use a tenant-verified custom authentication domain and the tenant GUID:

```text
https://<tenant-verified-custom-domain>/<tenant-GUID>
```

For example, the service authority might be `https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee`. A local transport prefix might instead be `http://localhost:3001/api`. These values serve different purposes:

| Value | Purpose |
| --- | --- |
| **Service authority** | Identifies the tenant's authentication service. Configure this custom domain and tenant GUID as the upstream authority and validate service-returned links against it. |
| **Transport prefix** | Identifies the browser-facing proxy. It can replace the authority portion of a validated API request for transport, but doesn't change the service authority or transaction. |

With that local prefix, a service path of `/<tenant-GUID>/api/v2.0/signin/start` maps to `/api/api/v2.0/signin/start`. The first `/api` is the proxy prefix; the second belongs to the service path. OAuth requests similarly map to `/api/oauth2/v2.0/authorize-challenge` or `/api/oauth2/v2.0/token`.

For these browser integrations, don't configure a `ciamlogin.com` address as the application's service API authority. Platform-managed origin routing behind a verified custom domain doesn't replace this requirement. Non-browser clients using native HTTP transports don't require a custom domain. See [Configure the API authority](how-to-native-authentication-configure-app.md#configure-the-api-authority).

## Proxy contract

Configure these settings in your reverse proxy. Forward API bodies and service status codes directly.

| Setting | Configuration |
| --- | --- |
| **Upstream authority** | Set `https://<tenant-verified-custom-domain>/<tenant-GUID>` as the fixed destination. For a custom-domain edge, use the platform's documented service-origin configuration. |
| **Routes** | Allow `/api/v2.0/*`, `/oauth2/v2.0/authorize-challenge`, and `/oauth2/v2.0/token` under the tenant-GUID prefix. |
| **Methods and preflight** | Enable `POST`, password-update `PUT`, and `OPTIONS`. Handle preflight locally or forward it to the service. Approve only configured methods and headers; return `Access-Control-Allow-Methods: POST, PUT`. |
| **Browser origin** | Set `Access-Control-Allow-Origin` to your app's exact origin, such as `https://app.contoso.com`. Return it only for matching `Origin` requests, including on error responses. |
| **Allowed request headers** | Set `Access-Control-Allow-Headers` to `Content-Type, Accept, client-request-id`. For Microsoft Authentication Library (MSAL) clients, also allow `x-client-sku`, `x-client-ver`, `x-client-os`, `x-client-cpu`, `x-client-current-telemetry`, and `x-client-last-telemetry`. |
| **Exposed response headers** | Set `Access-Control-Expose-Headers` to `Retry-After, client-request-id, x-ms-request-id, x-ms-clitelem`. |
| **Caching** | Disable proxy and CDN caching. Add `Cache-Control: no-store` to every response. |
| **Redirects and failures** | Disable automatic upstream redirects and remove response `Location` headers. Return explicit proxy errors for connection failures and timeouts. |

The [API reference](reference-native-authentication.md) defines the operation-specific methods, headers, request bodies, and responses.

## Proxy implementations

Choose an implementation that fits your hosting environment and meets the same contract:

- [Local proxy](how-to-native-authentication-cors-local.md) for JavaScript sample development.
- [Azure Functions proxy](how-to-native-authentication-cors-azure-functions.md) with an adapted HTTP-trigger handler.
- [Azure Front Door proxy](how-to-native-authentication-cors-front-door.md) on the tenant's custom authentication domain.

The JavaScript SDK's `customAuth.authApiProxyUrl` doesn't remap absolute HAL links. Use CORS policy at the custom-domain edge for those SDK requests. The local and Functions recipes instead show a custom-client transport that validates and maps service links.

The local proxy binds to a loopback interface and isn't a shared hosting recipe. For a deployed proxy, also review capacity, cost, access controls, diagnostics retention, and recovery procedures for your environment.

## Related content

- [Fetch Standard CORS protocol](https://fetch.spec.whatwg.org/#http-cors-protocol).
- [Embedded native authentication flow](concept-native-authentication-flow.md).
- [The Native Authentication API reference](reference-native-authentication.md).
