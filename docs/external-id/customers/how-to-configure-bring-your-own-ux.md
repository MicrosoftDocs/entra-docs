---
title: Configure Bring Your Own UX authentication
description: Configure the authentication website, Microsoft Graph beta settings, and browser handoff for Bring Your Own UX in Microsoft Entra External ID.
author: adamstoffel
ms.author: adamstoffel
ms.topic: how-to
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-generated

#customer intent: As an application developer, I want to configure Bring Your Own UX so that my self-hosted authentication page can participate in the relying application's authorization flow.
---

# Configure Bring Your Own UX authentication

Configure Bring Your Own UX (BYO UX) in Microsoft Entra External ID so your authentication website can receive the browser handoff, handle authentication, and return control to the service. This guide covers website hosting, Microsoft Graph beta configuration, and browser completion.

Before you begin, confirm that you have the tenant, hosting, and administrative access listed in [Prerequisites](#prerequisites).

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[!INCLUDE [bring-your-own-ux-preview](../includes/bring-your-own-ux-preview.md)]

## Prerequisites

- Use a Microsoft Entra External ID external tenant with a [DNS-verified custom domain](how-to-custom-url-domain.md).
- Have a relying-application registration in that tenant for an OAuth 2.0 or OpenID Connect authorization-code flow, and access to manage its user-flow association.
- Have an HTTPS endpoint that your team hosts and that can receive a browser form POST.
- For BYO UX configuration, use an account with the **Global Administrator** role in the external tenant and a Graph token with the required [application-update permissions](/graph/api/application-update?view=graph-rest-beta&preserve-view=true#permissions).
- For session persistence changes, use an account with the **Conditional Access Administrator** role or equivalent permissions.

The administrative permissions are for configuration, not the page's runtime. Limit privileged access to the time needed for configuration. Keep the setup Graph token out of the self-hosted page.

## Identify the application and its URLs

Record the registration prerequisites and URLs needed by your authentication website. Keep the relying application's reply URL separate from the self-hosted page: Microsoft Entra External ID sends different information to each destination.

1. Record the external tenant's GUID and the relying application's application ID. Use the tenant GUID in Microsoft Entra service URL paths rather than `/common`.
1. Confirm that the relying application has a registered web-type reply URL. Both public and confidential applications use this type of `redirect_uri` for BYO UX.
1. Choose the self-hosted page URL. Microsoft Entra External ID sends the initial BYO UX form POST to this URL, not to the OAuth reply URL.
1. Record the tenant's verified custom-domain service authority. Use it for authorization, all Native Authentication API calls, including proxy upstream URLs, and the returned finish link. This requirement applies to Microsoft Entra service URLs, not application callback or resource URLs.

The relying application uses the same OAuth or Microsoft Authentication Library (MSAL) integration as a Microsoft-hosted flow. It validates the final OAuth response and redeems the authorization code. Use the maintained [authorization-code flow](~/identity-platform/v2-oauth2-auth-code-flow.md) and [MSAL guidance](~/identity-platform/msal-overview.md), rather than a separate BYO UX application implementation. Keep confidential-client credentials on the server.

<a id="prepare-the-customer-hosted-page"></a>

## Prepare the self-hosted page

The page can use your choice of language or framework. Its endpoint needs to accept the authorization handoff and complete authentication through the same top-level browser flow.

1. Choose an absolute HTTPS URL with a DNS hostname. The hostname must equal or be a subdomain of a DNS-verified custom domain owned by the tenant.
1. Check that the URL contains no user information or fragment. IP-address, loopback, and Microsoft-owned hostnames aren't allowed.
1. Configure the page's request handler to receive `application/x-www-form-urlencoded` POST data containing `context` and `initialResponse`. The [handoff reference](reference-bring-your-own-ux.md#authorization-handoff) describes their encoding and contents.
1. Keep credentials and transaction tokens out of request-body logging, analytics, exception details, and support captures.
1. Serve the page with `Referrer-Policy: strict-origin`. Preserve the browser-generated `Origin` header containing the page's HTTPS origin when the browser submits the finish form.

The page's domain and the API's domain can differ. Both must meet the same tenant's domain-ownership checks; the page's `Origin` doesn't have to equal the finish request host.

When the page and authentication API have different origins, configure an application-controlled proxy to handle browser API requests and CORS preflights. A shared parent domain doesn't make two origins the same. The browser-facing proxy URL is a transport route, not the Microsoft Entra service authority; upstream API URLs still use the tenant's verified custom domain. Follow the [shared browser integration and CORS guidance](~/identity-platform/concept-native-authentication-cors.md).

Restrict the proxy to the expected authentication authority and routes. Preserve returned URLs, query parameters, request and response bodies, retry guidance, and diagnostic IDs. Keep caching disabled and TLS validation enabled. The top-level browser finish form isn't an API fetch and doesn't use the API proxy's CORS handling.

## Associate authentication configuration with the application

Configure the page for the relying application through Microsoft Graph beta. The Microsoft Entra admin center doesn't provide BYO UX setup. The application's user-flow configuration determines the available sign-up and sign-in behavior.

1. [Associate the application with the user flow](how-to-user-flow-add-application.md) for the journeys you provide.
1. Record the app registration's **Object ID**. The Microsoft Graph application-update route uses this value, not the **Application (client) ID**.
1. Send a `PATCH` request to `https://graph.microsoft.com/beta/applications/<object-id>` with the authorized Graph token and `Content-Type: application/json`. Use the following body, replacing `<byoux-page-url>` with your HTTPS self-hosted page URL. Keep the separately registered OAuth reply URL unchanged.

    ```json
    {
      "web": {
        "customAuthenticationUx": {
          "loginPageUrl": "<byoux-page-url>",
          "isEnabled": true
        }
      }
    }
    ```

Select methods using the [BYO UX journey scope](concept-bring-your-own-ux.md#common-policy-boundaries-and-supported-journeys) and [authentication-method guidance](concept-authentication-methods-customers.md). Shared API operations don't establish support for every method or policy combination.

## Configure session persistence

BYO UX doesn't support user opt-in for **Stay signed in?**. Configure persistence at the tenant level to control browser-session persistence and suppress that Microsoft-hosted prompt.

- Use the Conditional Access **Persistent browser session** control as described in [Control the Stay signed in? prompt](how-to-user-flow-sign-up-sign-in-customers.md#control-the-stay-signed-in-prompt).

## Connect the page to the browser flow

Start the browser flow from the relying application's existing OAuth or MSAL integration, then handle the website's side of the handoff.

1. Require and decode `context` and `initialResponse` on the self-hosted page. Validate the tenant and client IDs in `context` against your configuration, and handle whichever action is returned in `initialResponse`.
1. Use the returned actions and links to perform authentication through the Native Authentication API. Resolve relative links against the configured custom-domain service authority, not the page's origin. Validate destinations before sending authentication data.
1. Use each response to determine the next action. When it returns a new continuation token, replace the previous token and its links together for the active transaction.
1. If the current token expires or the service requires a restart, stop the transaction and start a new authorization request from the relying application.
1. When the service returns `state: continue`, submit the latest unexpired token as the `continuation_token` form field to the returned BYO UX finish link through top-level browser navigation.
1. Show a clear error for malformed initialization, missing essential links, or unsupported required actions. Don't treat these conditions as successful authentication or automatically replay a credential submission.

Matching tenant/client IDs and decoded handoff data don't authenticate the sender or establish user intent. Microsoft Entra External ID validates protected continuation state. The relying application retains its normal OAuth response and state validation.

For the wire contract, see the [BYO UX API and protocol reference](reference-bring-your-own-ux.md). API operations use JSON requests; finish uses a browser form POST, not `fetch`, XHR, an iframe, or a server-to-server call. Let the browser generate `Origin` and handle Microsoft Entra cookies. Don't read or manually forward HTTP-only cookies.

## Verify the configured integration

Validate the browser flow and its security boundaries before making your page available to customers.

1. Verify that an eligible authorization request reaches the configured self-hosted page with both initialization fields.
1. Check the tenant-verified custom domain in each Microsoft Entra service URL, including OAuth, native authentication, proxy upstream, and finish URLs. Verify the tenant GUID in service paths and preserve returned paths and query parameters.
1. Exercise each enabled sign-up, sign-in, and password-recovery journey, including email one-time-passcode sign-in and email or SMS recovery. Test available handoff and inline recovery entries.
1. Verify registered-factor challenges and inline multifactor authentication (MFA) registration when requested. Continue handling returned actions after sign-up, credential verification, or password updates.
1. Verify that completion returns the authorization response to the registered reply URL, with the response transport and application state from the original OAuth request.
1. Check invalid passcodes, continuation-token expiry, service-directed restart, cancellation, and ambiguous network failures. Ensure that the page gives a usable error and doesn't automatically replay credential verification or password updates.
1. Test existing-session bypass, browser Back/Forward, restored pages, and form resubmission. Verify that session persistence follows the configured policy and stale pages restart rather than replay old tokens.
1. Confirm that diagnostics retain request IDs, correlation IDs, trace IDs, and timestamps without credentials, tokens, passcodes, or personal data.

## Remove the BYO UX configuration

Remove the custom authentication configuration when you no longer want the application to use the page.

- Use the same Microsoft Graph beta application `PATCH` route and set `web.customAuthenticationUx` to `null`.

    ```json
    {
      "web": {
        "customAuthenticationUx": null
      }
    }
    ```

## Related content

- [Bring Your Own UX authentication overview](concept-bring-your-own-ux.md)
- [BYO UX API and protocol reference](reference-bring-your-own-ux.md)
