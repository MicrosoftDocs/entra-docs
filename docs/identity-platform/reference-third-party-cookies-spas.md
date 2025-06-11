---
title: How to handle third-party cookie blocking in browsers
description: Single-page app (SPA) authentication when third-party cookies are no longer allowed.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 03/14/2022
ms.reviewer: ludwignick; emilylauber
ms.service: identity-platform
ms.topic: concept-article
ms.custom: sfi-image-nochange
#Customer intent: As a web application developer, I want to understand how to handle third-party cookie blocking in browsers, so that I can implement the appropriate authentication patterns and ensure that users can sign in successfully even when third-party cookies are blocked.
---

# How to handle third-party cookie blocking in browsers

Many browsers block _third-party cookies_, cookies on requests to domains other than the domain shown in the browser's address bar. These cookies are also known as _cross-domain cookies_. This block breaks the implicit flow and requires new authentication patterns to successfully sign in users. In the Microsoft identity platform, we use the authorization code flow with Proof Key for Code Exchange (PKCE) and refresh tokens to keep users signed in when third-party cookies are blocked. This authorization code flow with Proof Key for Code Exchange approach is recommended over the implicit flow.

## What is Intelligent Tracking Protection (ITP) and Privacy Sandbox?

Apple Safari has an on-by-default privacy protection feature called [Intelligent Tracking Protection](https://webkit.org/tracking-prevention-policy/), or *ITP*. Chrome has a browser privacy initiative named the [Privacy Sandbox](https://developers.google.com/privacy-sandbox/overview). These initiatives encompass many different browser privacy efforts by the browsers and have different timelines. Both efforts block "third-party" cookies on requests that cross domains, with Safari and Brave block third-party cookies by default. Chrome recently announced that they'll start [blocking third-party cookies by default](https://privacysandbox.com/open-web/#the-privacy-sandbox-timeline). Privacy Sandbox includes changes to [partitioned storage](https://developers.google.com/privacy-sandbox/3pcd/storage-partitioning) as well as third-party cookie blocking. 

A common form of user tracking is done by loading an iframe to third-party site in the background and using cookies to correlate the user across the Internet. Unfortunately, this pattern is also the standard way of implementing the [implicit flow](v2-oauth2-implicit-grant-flow.md) in single-page apps (SPAs). A browser that blocks third-party cookies to protect user privacy can also block the functionality of a SPA. Use of the implicit flow in SPAs is no longer recommended due to the blocking of third-party cookies and the security risks associated with it.

The solution outlined in this article works in all of these browsers, or anywhere third-party cookies are blocked.

## Overview of the solution

To continue authenticating users in SPAs, app developers must use the [authorization code flow](v2-oauth2-auth-code-flow.md). In the auth code flow, the identity provider issues a code, and the SPA redeems the code for an access token and a refresh token. When the app requires new tokens, it can use the [refresh token flow](v2-oauth2-auth-code-flow.md#refresh-the-access-token) to get new tokens. Microsoft Authentication Library (MSAL) for JavaScript v2.0 and higher, implements the authorization code flow for SPAs and, with minor updates, is a drop-in replacement for MSAL.js 1.x. See the [migration guide](migrate-spa-implicit-to-auth-code.md) for moving a SPA from implicit to auth code flow.

For the Microsoft identity platform, SPAs and native clients follow similar protocol guidance:

- Use of a [PKCE code challenge](https://tools.ietf.org/html/rfc7636)
  - PKCE is *required* for SPAs on the Microsoft identity platform. PKCE is *recommended* for native and confidential clients.
- No use of a client secret

SPAs have two more restrictions:

- [The redirect URI must be marked as type `spa`](v2-oauth2-auth-code-flow.md#redirect-uris-for-single-page-apps-spas) to enable CORS on login endpoints.
- Refresh tokens issued through the authorization code flow to `spa` redirect URIs have a 24-hour lifetime rather than a 90-day lifetime.

:::image type="content" source="media/v2-oauth-auth-code-spa/oauth-code-spa.svg" alt-text="Diagram showing the OAuth 2 authorization code flow between a single-page app and the security token service endpoint." border="false":::

## Performance and UX implications

Some applications using the implicit flow attempt sign-in without redirecting by opening a login iframe using `prompt=none`. In most browsers, this request responds with tokens for the currently signed-in user (assuming consent is granted). This pattern meant applications didn't need a full page redirect to sign the user in, improving performance and user experience - the user visits the web page and is signed in already. Because `prompt=none` in an iframe is no longer an option when third-party cookies are blocked, applications must adjust their sign-in patterns to have an authorization code issued.

Without third-party cookies, there are two ways of accomplishing sign-in:

- **Full page redirects**
  - On the first load of the SPA, redirect the user to the sign-in page if no session already exists (or if the session is expired). The user's browser visits the login page, presents the cookies containing the user session, and is then redirected back to the application with the code and tokens in a fragment.
  - The redirect does result in the SPA being loaded twice. Follow best practices for caching of SPAs so that the app isn't downloaded in-full twice.
  - Consider having a pre-load sequence in the app that checks for a login session and redirects to the login page before the app fully unpacks and executes the JavaScript payload.
- **Popups**
  - If the user experience (UX) of a full page redirect doesn't work for the application, consider using a popup to handle authentication.
  - When the popup finishes redirecting to the application after authentication, code in the redirect handler will store the auth code, and tokens in local storage for the application to use. MSAL.js supports popups for authentication, as do most libraries.
  - Browsers are decreasing support for popups, so they might not be the most reliable option. User interaction with the SPA before creating the popup might be needed to satisfy browser requirements.

Apple [describes a popup method](https://webkit.org/blog/8311/intelligent-tracking-prevention-2-0/) as a temporary compatibility fix to give the original window access to third-party cookies. While Apple may remove this transferal of permissions in the future, it will not impact the guidance here.
     
Here, the popup is being used as a first party navigation to the login page so that a session is found and an auth code can be provided. This should continue working into the future.

Developers can continue to use `prompt=none` with the expectation that they see a higher rate of *interacion_required* errors when third-party cookies are blocked. The recommendation is to always have an [interactive method fallback](msal-js-prompt-behavior.md), if failures during silent token acquisition occur.

### Using iframes

A common pattern in web apps is to use an iframe to embed one app inside another: the top-level frame handles authenticating the user and the application hosted in the iframe can trust that the user is signed in, fetching tokens silently using the implicit flow. However, there are a couple of caveats to this assumption irrespective of whether third-party cookies are enabled or blocked in the browser.

Silent token acquisition no longer works when third-party cookies are blocked - the application embedded in the iframe must switch to using popups to access the user's session as it can't navigate to the login page within an embedded frame.

You can achieve single sign-on between iframed and parent apps with same-origin *and* cross-origin JavaScript script API access by passing a user (account) hint from the parent app to the iframed app. For more information, see [Using MSAL.js in iframed apps](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/iframe-usage.md) in the MSAL.js repository on GitHub.

## Security implications of refresh tokens in the browser

Cross-site scripting (XSS) attacks or compromised JS packages can steal the refresh token and use it remotely until it expires or is revoked. Application developers are responsible for reducing their application's risk to cross-site scripting. In order to minimize the risk of stolen refresh tokens, SPAs are issued tokens valid for 24 hours only. After 24 hours, the app must acquire a new authorization code via a top-level frame visit to the login page.

This limited-lifetime refresh token pattern was chosen as a balance between security and degraded UX. Without refresh tokens or third-party cookies, the authorization code flow (as recommended by the [OAuth security best current practices draft](https://tools.ietf.org/html/draft-ietf-oauth-security-topics-14)) becomes onerous when new or additional tokens are required. A full page redirect or popup is needed for every single token, every time a token expires (every hour usually, for the Microsoft identity platform tokens).

## User type specific mitigations 

Not all users and applications are uniformly affected by third-party cookies. There are some scenarios where due to architecture or device management, silent calls to renew tokens can be done without third-party cookies. 

For *managed enterprise device* scenarios, certain browser and platform combinations have support for [device Conditional Access](/azure/active-directory/conditional-access/concept-conditional-access-conditions#supported-browsers). Applying device identity minimizes the need for third-party cookies as the authentication state can come from the device instead of the browser.  

For *Azure AD B2C application* scenarios, customers can set up a [custom login domain](/azure/active-directory-b2c/custom-domain?pivots=b2c-user-flow) to match the application's domain. Browsers wouldn't block third-party cookies in this scenario as the cookies remain in the same domain (such as `login.contoso.com` to `app.contoso.com`).

## Limitations on Front-Channel Logout without third-party cookies
When signing a user out from a SPA, MSAL.js recommends using the [popup or redirect logout method](scenario-spa-sign-in.md?tabs=javascript2#sign-out-with-a-pop-up-window). While this clears the authentication session on the server and in browser storage, there's a risk that without access to third-party cookies, not all federated applications will see a sign-out at the same time. This is a known limitation of the [OpenID Front-Channel Logout 1.0 specification](https://openid.net/specs/openid-connect-frontchannel-1_0.html#ThirdPartyContent). What this means for users is that existing access tokens for other applications for the same user will continue to be valid till their expiration time. A user could log out of application A in tab A, but application B in tab B will still appear as logged in for the access token's remaining valid time. When application B's token expires and a call is made to the server to get a new token, application B receives a response from the server that the session is expired and prompt for the user to authenticate.

Microsoft's sign-out page and [internet privacy best practices](https://support.microsoft.com/en-us/windows/protect-your-privacy-on-the-internet-ffe36513-e208-7532-6f95-a3b1c8760dfa) recommend that users close all browser windows after logging out of an application.

## Next steps

For more information about authorization code flow and MSAL.js, see:

- [Authorization code flow](v2-oauth2-auth-code-flow.md).
- [MSAL.js 2.0 quickstart](quickstart-v2-javascript-auth-code.md).
