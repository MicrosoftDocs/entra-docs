---
title: Tokens in the Microsoft identity platform - comprehensive guide
description: Complete guide to understanding, implementing, and securing tokens in Microsoft identity platform including access tokens, ID tokens, refresh tokens, claims, validation, and configuration.
author: garrodonnell
ms.author: godonnell
ms.date: 02/06/2026
ms.reviewer: ludwignick
ms.service: identity-platform
ms.topic: concept-article
ai-usage: ai-assisted
#Customer intent: As a developer building applications with Microsoft identity platform, I want a comprehensive guide to tokens, so that I can understand all aspects of token usage, validation, claims, and security in one place.
---

# Tokens in the Microsoft identity platform - comprehensive guide

This comprehensive guide covers everything you need to know about tokens in the Microsoft identity platform. Use the sections below to navigate to specific topics, or scroll through for a complete understanding of how tokens work, their structure, claims, validation, customization, and lifecycle management.

## In this guide

- [Token fundamentals](#token-fundamentals)
- [Access tokens](#access-tokens)
- [ID tokens](#id-tokens)
- [Refresh tokens](#refresh-tokens)
- [Token formats and versions](#token-formats-and-versions)
- [Claims reference](#claims-reference)
- [Token validation](#token-validation)
- [Claims customization](#claims-customization)
- [Token lifetime configuration](#token-lifetime-configuration)
- [Authorization flows](#authorization-flows)
- [Security best practices](#security-best-practices)

---

## Token fundamentals

A centralized identity provider is especially useful for apps that have worldwide users who don't necessarily sign in from the enterprise's network. The Microsoft identity platform authenticates users and provides security tokens, such as access tokens, refresh tokens, and ID tokens. Security tokens allow a client application to access protected resources on a resource server.

### Token types overview

The Microsoft identity platform supports three primary token types:

- **Access token** - An access token is a security token issued by an authorization server as part of an OAuth 2.0 flow. It contains information about the user and the resource for which the token is intended. The information can be used to access web APIs and other protected resources. Resources validate access tokens to grant access to a client application.

- **ID token** - ID tokens are sent to the client application as part of an OpenID Connect flow. They can be sent alongside or instead of an access token. ID tokens are used by the client to authenticate the user and contain claims that carry information about the user.

- **Refresh token** - Because access tokens are valid for only a short period of time, authorization servers sometimes issue a refresh token at the same time the access token is issued. The client application can then exchange this refresh token for a new access token when needed.

### JSON Web Tokens and claims

The Microsoft identity platform implements security tokens as JSON Web Tokens (JWTs) that contain *claims*. Since JWTs are used as security tokens, this form of authentication is sometimes called *JWT authentication*.

A claim provides assertions about one entity, such as a client application or resource owner, to another entity, such as a resource server. A claim might also be referred to as a JWT claim or a JSON Web Token claim.

Claims are name or value pairs that relay facts about the token subject. For example, a claim might contain facts about the security principal that the authorization server authenticated. The claims present in a specific token depend on many things, such as the type of token, the type of credential used to authenticate the subject, and the application configuration.

Applications can use claims for various tasks:

- Validate the token
- Identify the token subject's tenant
- Display user information
- Determine the subject's authorization

A claim consists of key-value pairs that provide the following types of information:

- Security token server that generated the token
- Date when the token was generated
- Subject (like the user, but not daemons)
- Audience, which is the app for which the token was generated
- App (the client) that asked for the token

### Token endpoints and issuers

Microsoft Entra ID supports two tenant configurations: A workforce configuration that's intended for internal use and manages employees and business guests, and a [customer configuration](/entra/external-id/customers/concept-supported-features-customers) which is optimized for isolating consumers and partners in a restricted external-facing directory. While the underlying identity service is identical for both tenant configurations, the sign in domains and token issuing authority for external tenants is different. This allows applications to keep workforce and external ID workflows separated if needed.

Microsoft Entra workforce tenants authenticate at login.microsoftonline.com with tokens issued by *sts.windows.NET*. Workforce tenant tokens are interchangeable across tenants and multitenant applications so long as underlying trust relationships permit this interoperability. Microsoft Entra external tenants use endpoints of the form `{tenantname}.ciamlogin.com`. Applications registered to external tenants must be aware of this separation to receive and validate tokens correctly.

Every Microsoft Entra tenant publishes a standards-compliant well-known metadata document. This document contains information about the issuer name, the authentication and authorization endpoints, supported scopes and claims. For external tenants, the document is publicly available at: `https://{tenantname}.ciamlogin.com/{tenantid}/v2.0/.well-known/openid-configuration`. This endpoint returns an issuer value `https://{tenantid}.ciamlogin.com/{tenantid}/v2.0`.

---

## Access tokens

Access tokens are a type of security token designed for authorization, granting access to specific resources on behalf of an authenticated user. Information in access tokens determines whether a user has the right to access a particular resource, similar to keys unlocking specific doors in a building. These individual pieces of information that make up tokens are called claims. Therefore, they are sensitive credentials and pose a security risk if not handled correctly. Access tokens differ from ID tokens which serve as proof of authentication.

### Understanding access tokens

Access tokens enable clients to securely call protected web APIs. Although client applications can receive and use access tokens, they should be treated as opaque strings. The client application shouldn't attempt to validate access tokens. The resource server should validate the access token before accepting it as proof of authorization. The contents of the token are intended only for the API, which means that access tokens must be treated as opaque strings. For validation and debugging purposes *only*, developers can decode JWTs using a site like [jwt.ms](https://jwt.ms). Tokens that a Microsoft API receives might not always be a JWT that can be decoded.

Clients should use the token response data that's returned with the access token for details on what's inside it. When the client requests an access token, the Microsoft identity platform also returns some metadata about the access token for the consumption of the application. This information includes the expiry time of the access token and the scopes for which it's valid. This data allows the application to do intelligent caching of access tokens without having to parse the access token itself.

> [!NOTE]
> All documentation in this section, except where noted, applies only to tokens issued for registered APIs. It doesn't apply to tokens issued for Microsoft-owned APIs, nor can those tokens be used to validate how the Microsoft identity platform issues tokens for a registered API.

### Access token ownership

An access token request involves two parties: the client, who requests the token, and the resource (Web API) that accepts the token. The resource that the token is intended for (its *audience*) is defined in the `aud` claim in a token. Clients use the token but shouldn't understand or attempt to parse it. Resources accept the token.

The Microsoft identity platform supports issuing any token version from any version endpoint. For example, when the value of `requestedAccessTokenVersion` is `2`, a client calling the v1.0 endpoint to get a token for that resource receives a v2.0 access token.

Resources always own their tokens using the `aud` claim and are the only applications that can change their token details.

### Access token lifetime

The default lifetime of an access token is variable. When issued, the Microsoft identity platform assigns a random value ranging between 60-90 minutes (75 minutes on average) as the default lifetime of an access token. The variation improves service resilience by spreading access token demand over a time, which prevents hourly spikes in traffic to Microsoft Entra ID.

Tenants that don't use Conditional Access have a default access token lifetime of two hours for clients such as Microsoft Teams and Microsoft 365.

Adjust the lifetime of an access token to control how often the client application expires the application session, and how often it requires the user to reauthenticate (either silently or interactively). To override the default access token lifetime variation, use [Configurable token lifetime (CTL)](#token-lifetime-configuration).

Apply default token lifetime variation to organizations that have Continuous Access Evaluation (CAE) enabled. Apply default token lifetime variation even if the organizations use CTL policies. The default token lifetime for long lived token lifetime ranges from 20 to 28 hours. When the access token expires, the client must use the refresh token to silently acquire a new refresh token and access token.

Organizations that use [Conditional Access sign-in frequency (SIF)](~/identity/conditional-access/concept-session-lifetime.md#user-sign-in-frequency) to enforce how frequently sign-ins occur can't override default access token lifetime variation. When organizations use SIF, the time between credential prompts for a client can range from the sign-in frequency interval to the token lifetime that ranges from 60 - 90 minutes plus the sign-in frequency interval.

Here's an example of how default token lifetime variation works with sign-in frequency. Let's say an organization sets sign-in frequency to occur every hour. When the token has lifetime ranging from 60-90 minutes due to token lifetime variation, the actual sign-in interval occurs anywhere between 1 hour to 2.5 hours.

If a user with a token with a one hour lifetime performs an interactive sign-in at 59 minutes, there's no credential prompt because the sign-in is below the SIF threshold. If a new token has a lifetime of 90 minutes, the user wouldn't see a credential prompt for another hour and a half. During a silent renewal attempt, Microsoft Entra ID requires a credential prompt because the total session length has exceeded the sign-in frequency setting of 1 hour. In this example, the time difference between credential prompts due to the SIF interval and token lifetime variation would be 2.5 hours.

### When to validate access tokens

Not all applications should validate tokens. Only in specific scenarios should applications validate a token:

- Web APIs must validate access tokens sent to them by a client. They must only accept tokens containing one of their AppId URIs as the `aud` claim.
- Web apps must validate ID tokens sent to them by using the user's browser in the hybrid flow, before allowing access to a user's data or establishing a session.

If none of the previously described scenarios apply, there's no need to validate the token. Public clients like native, desktop, or single-page applications don't benefit from validating ID tokens because the application communicates directly with the IDP where SSL protection ensures the ID tokens are valid. They shouldn't validate the access tokens, as they are for the web API to validate, not the client.

APIs and web applications must only validate tokens that have an `aud` claim that matches the application. Other resources may have custom token validation rules. For example, you can't validate tokens for Microsoft Graph according to these rules due to their proprietary format. Validating and accepting tokens meant for another resource is an example of the [confused deputy](https://cwe.mitre.org/data/definitions/441.html) problem.

---

## ID tokens

ID tokens are a security token that serves as proof of authentication, confirming that a user is successfully authenticated. Information in ID tokens enables the client to verify that a user is who they claim to be, similar to name tags at a conference. The authorization server issues ID tokens that contain claims that carry information about the user. They can be sent alongside or instead of an access token, and are always JWT (JSON Web Token) format.

### Understanding ID tokens

ID tokens differ from access tokens, which serve as proof of authorization. Confidential clients should validate ID tokens. You shouldn't use an ID token to call an API.

Third-party applications are intended to understand ID tokens. Do not use ID tokens for authorization purposes. Access tokens are used for authorization. The claims provided by ID tokens can be used for UX inside your application, as keys in a database, and providing access to the client application.

### ID token lifetime

By default, an ID token is valid for one hour - after one hour, the client must acquire a new ID token.

You can adjust the lifetime of an ID token to control how often the client application expires the application session, and how often it requires the user to authenticate again either silently or interactively. For more information, see [Token lifetime configuration](#token-lifetime-configuration).

### Validating ID tokens

To validate an ID token, your client can check whether the token has been tampered with. It can also validate the issuer to ensure that the correct issuer has sent back the token. Because ID tokens are always a JWT token, many libraries exist to validate these tokens - you should use one of these libraries rather than doing it yourself. Only confidential clients should validate ID tokens.

Public applications (code running entirely on a device or network you don't control such as a user's browser or their home network) don't benefit from validating the ID token. In this instance, a malicious user can intercept and edit the keys used for validation of the token.

The following JWT claims should be validated in the ID token after validating the signature on the token. Your token validation library may also validate the following claims:

- Timestamps: the `iat`, `nbf`, and `exp` timestamps should all fall before or after the current time, as appropriate.
- Audience: the `aud` claim should match the app ID for your application.
- Nonce: the `nonce` claim in the payload must match the nonce parameter passed into the `/authorize` endpoint during the initial request.

---

## Refresh tokens

A refresh token is used to obtain new access and refresh token pairs when the current access token expires. When a client acquires an access token to access a protected resource, the client also receives a refresh token.

### Understanding refresh tokens

Refresh tokens are also used to acquire extra access tokens for other resources. Refresh tokens are bound to a combination of user and client, but aren't tied to a resource or tenant. A client can use a refresh token to acquire access tokens across any combination of resource and tenant where it has permission to do so. Refresh tokens are encrypted and only the Microsoft identity platform can read them.

### Refresh token lifetime

Refresh tokens have a longer lifetime than access tokens. The default lifetime for the refresh tokens are as follows:

- **24 hours** for single-page applications.
- **24 hours** for apps that use email one-time passcode authentication flow.
- **90 days** for all other scenarios.

Refresh tokens replace themselves with a fresh token upon every use. The Microsoft identity platform doesn't revoke old refresh tokens when used to fetch new access tokens. Securely delete the old refresh token after acquiring a new one. Refresh tokens need to be stored safely like access tokens or application credentials.

> [!NOTE]
> Refresh tokens sent to a redirect URI registered as `spa` expire after 24 hours. Additional refresh tokens acquired using the initial refresh token carry over that expiration time, so apps must be prepared to rerun the authorization code flow using an interactive authentication to get a new refresh token every 24 hours. Users don't have to enter their credentials and usually don't even see any related user experience, just a reload of your application. The browser must visit the sign-in page in a top-level frame to show the login session. This is due to [privacy features in browsers that block third party cookies](reference-third-party-cookies-spas.md).

### Refresh token expiration and revocation

Refresh tokens automatically expire once the lifetime period elapses. Additionally, they can be revoked by the sign-in service at any time before their expiration. Your app should handle such revocations gracefully by redirecting the user to an interactive sign-in prompt to reauthenticate and obtain a new token.

The server can revoke refresh tokens because of a change in credentials, user action, or admin action. Refresh tokens fall into two classes: tokens issued to confidential clients (the rightmost column) and tokens issued to public clients (all other columns).

| Change | Password-based cookie | Password-based token | Non-password-based cookie | Non-password-based token | Confidential client token |
| ------ | --------------------- | -------------------- | ------------------------- | ------------------------ | ------------------------- |
| Password expires | Stays alive | Stays alive | Stays alive | Stays alive | Stays alive |
| Password changed by user | Revoked | Revoked | Stays alive | Stays alive | Stays alive |
| User does SSPR | Revoked | Revoked | Stays alive | Stays alive | Stays alive |
| Admin resets password (Azure portal) | Revoked | Revoked | Stays alive | Stays alive | Stays alive |
| Admin resets password (Microsoft Entra admin center) | Revoked | Revoked | Stays alive | Revoked | Revoked |
| Admin resets password (M365 admin center) | Revoked | Revoked | Stays alive | Revoked | Revoked |
| User revokes their refresh tokens | Revoked | Revoked | Revoked | Revoked | Revoked |
| Admin revokes all refresh tokens for a user | Revoked | Revoked | Revoked | Revoked | Revoked |
| Single sign-out | Revoked | Stays alive | Revoked | Stays alive | Stays alive |

> [!NOTE]
> Refresh tokens are not revoked for B2B users in their resource tenant. The token needs to be revoked in the home tenant.

---

## Token formats and versions

There are two versions of tokens available in the Microsoft identity platform: v1.0 and v2.0. These versions determine the claims that are in the token and make sure that a web API can control the contents of the token.

### Access token versions

Web APIs have one of the following versions selected as a default during registration:

- v1.0 for Microsoft Entra-only applications
- v2.0 for applications that support consumer accounts

Set the version for applications by providing the appropriate value to the `requestedAccessTokenVersion` setting in the [app manifest](reference-app-manifest.md#manifest-reference). The values of `null` and `1` result in v1.0 tokens, and the value of `2` results in v2.0 tokens.

#### Sample v1.0 access token

The following example shows a v1.0 token (the keys are changed and personal information is removed, which prevents token validation):

```text
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Imk2bEdrM0ZaenhSY1ViMkMzbkVRN3N5SEpsWSIsImtpZCI6Imk2bEdrM0ZaenhSY1ViMkMzbkVRN3N5SEpsWSJ9.eyJhdWQiOiJlZjFkYTlkNC1mZjc3LTRjM2UtYTAwNS04NDBjM2Y4MzA3NDUiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9mYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTUyMjIyOS8iLCJpYXQiOjE1MzcyMzMxMDYsIm5iZiI6MTUzNzIzMzEwNiwiZXhwIjoxNTM3MjM3MDA2LCJhY3IiOiIxIiwiYWlvIjoiQVhRQWkvOElBQUFBRm0rRS9RVEcrZ0ZuVnhMaldkdzhLKzYxQUdyU091TU1GNmViYU1qN1hPM0libUQzZkdtck95RCtOdlp5R24yVmFUL2tES1h3NE1JaHJnR1ZxNkJuOHdMWG9UMUxrSVorRnpRVmtKUFBMUU9WNEtjWHFTbENWUERTL0RpQ0RnRTIyMlRJbU12V05hRU1hVU9Uc0lHdlRRPT0iLCJhbXIiOlsid2lhIl0sImFwcGlkIjoiNzVkYmU3N2YtMTBhMy00ZTU5LTg1ZmQtOGMxMjc1NDRmMTdjIiwiYXBwaWRhY3IiOiIwIiwiZW1haWwiOiJBYmVMaUBtaWNyb3NvZnQuY29tIiwiZmFtaWx5X25hbWUiOiJMaW5jb2xuIiwiZ2l2ZW5fbmFtZSI6IkFiZSAoTVNGVCkiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC83MmY5ODhiZi04NmYxLTQxYWYtOTFhYi0yZDdjZDAxMjIyNDcvIiwiaXBhZGRyIjoiMjIyLjIyMi4yMjIuMjIiLCJuYW1lIjoiYWJlbGkiLCJvaWQiOiIwMjIyM2I2Yi1hYTFkLTQyZDQtOWVjMC0xYjJiYjkxOTQ0MzgiLCJyaCI6IkkiLCJzY3AiOiJ1c2VyX2ltcGVyc29uYXRpb24iLCJzdWIiOiJsM19yb0lTUVUyMjJiVUxTOXlpMmswWHBxcE9pTXo1SDNaQUNvMUdlWEEiLCJ0aWQiOiJmYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkiLCJ1bmlxdWVfbmFtZSI6ImFiZWxpQG1pY3Jvc29mdC5jb20iLCJ1dGkiOiJGVnNHeFlYSTMwLVR1aWt1dVVvRkFBIiwidmVyIjoiMS4wIn0.D3H6pMUtQnoJAGq6AHd
```

#### Sample v2.0 access token

The following example shows a v2.0 token (the keys are changed and personal information is removed, which prevents token validation):

```text
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Imk2bEdrM0ZaenhSY1ViMkMzbkVRN3N5SEpsWSJ9.eyJhdWQiOiI2ZTc0MTcyYi1iZTU2LTQ4NDMtOWZmNC1lNjZhMzliYjEyZTMiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vNzJmOTg4YmYtODZmMS00MWFmLTkxYWItMmQ3Y2QwMTFkYjQ3L3YyLjAiLCJpYXQiOjE1MzcyMzEwNDgsIm5iZiI6MTUzNzIzMTA0OCwiZXhwIjoxNTM3MjM0OTQ4LCJhaW8iOiJBWFFBaS84SUFBQUF0QWFaTG8zQ2hNaWY2S09udHRSQjdlQnE0L0RjY1F6amNKR3hQWXkvQzNqRGFOR3hYZDZ3TklJVkdSZ2hOUm53SjFsT2NBbk5aY2p2a295ckZ4Q3R0djMzMTQwUmlvT0ZKNGJDQ0dWdW9DYWcxdU9UVDIyMjIyZ0h3TFBZUS91Zjc5UVgrMEtJaWpkcm1wNjlSY3R6bVE9PSIsImF6cCI6IjZlNzQxNzJiLWJlNTYtNDg0My05ZmY0LWU2NmEzOWJiMTJlMyIsImF6cGFjciI6IjAiLCJuYW1lIjoiQWJlIExpbmNvbG4iLCJvaWQiOiI2OTAyMjJiZS1mZjFhLTRkNTYtYWJkMS03ZTRmN2QzOGU0NzQiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhYmVsaUBtaWNyb3NvZnQuY29tIiwicmgiOiJJIiwic2NwIjoiYWNjZXNzX2FzX3VzZXIiLCJzdWIiOiJIS1pwZmFIeVdhZGVPb3VZbGl0anJJLUtmZlRtMjIyWDVyclYzeERxZktRIiwidGlkIjoiNzJmOTg4YmYtODZmMS00MWFmLTkxYWItMmQ3Y2QwMTFkYjQ3IiwidXRpIjoiZnFpQnFYTFBqMGVRYTgyUy1JWUZBQSIsInZlciI6IjIuMCJ9.pj4N-w_3Us9DrBLfpCt
```

### ID token versions

The v1.0 and v2.0 ID tokens have differences in the information they carry. The version is based on the endpoint from where it was requested. New applications should use the v2.0.

- v1.0: `https://login.microsoftonline.com/common/oauth2/authorize`
- v2.0: `https://login.microsoftonline.com/common/oauth2/v2.0/authorize`

#### Sample v1.0 ID token

```text
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyIsImtpZCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyJ9.eyJhdWQiOiJiMTRhNzUwNS05NmU5LTQ5MjctOTFlOC0wNjAxZDBmYzljYWEiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9mYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkvIiwiaWF0IjoxNTM2Mjc1MTI0LCJuYmYiOjE1MzYyNzUxMjQsImV4cCI6MTUzNjI3OTAyNCwiYWlvIjoiQVhRQWkvOElBQUFBcXhzdUIrUjREMnJGUXFPRVRPNFlkWGJMRDlrWjh4ZlhhZGVBTTBRMk5rTlQ1aXpmZzN1d2JXU1hodVNTajZVVDVoeTJENldxQXBCNWpLQTZaZ1o5ay9TVTI3dVY5Y2V0WGZMT3RwTnR0Z2s1RGNCdGsrTExzdHovSmcrZ1lSbXY5YlVVNFhscGhUYzZDODZKbWoxRkN3PT0iLCJhbXIiOlsicnNhIl0sImVtYWlsIjoiYWJlbGlAbWljcm9zb2Z0LmNvbSIsImZhbWlseV9uYW1lIjoiTGluY29sbiIsImdpdmVuX25hbWUiOiJBYmUiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC83MmY5ODhiZi04NmYxLTQxYWYtOTFhYi0yZDdjZDAxMWRiNDcvIiwiaXBhZGRyIjoiMTMxLjEwNy4yMjIuMjIiLCJuYW1lIjoiYWJlbGkiLCJub25jZSI6IjEyMzUyMyIsIm9pZCI6IjA1ODMzYjZiLWFhMWQtNDJkNC05ZWMwLTFiMmJiOTE5NDQzOCIsInJoIjoiSSIsInN1YiI6IjVfSjlyU3NzOC1qdnRfSWN1NnVlUk5MOHhYYjhMRjRGc2dfS29vQzJSSlEiLCJ0aWQiOiJmYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkiLCJ1bmlxdWVfbmFtZSI6IkFiZUxpQG1pY3Jvc29mdC5jb20iLCJ1dGkiOiJMeGVfNDZHcVRrT3BHU2ZUbG40RUFBIiwidmVyIjoiMS4wIn0=.UJQrCA6qn2bXq57qzGX_-D3HcPHqBMOKDPx4su1yKRLNErVD8xkxJLNLVRdASHqEcpyDctbdHccu6DPpkq5f0ibcaQFhejQNcABidJCTz0Bb2AbdUCTqAzdt9pdgQvMBnVH1xk3SCM6d4BbT4BkLLj10ZLasX7vRknaSjE_C5DI7Fg4WrZPwOhII1dB0HEZ_qpNaYXEiy-o94UJ94zCr07GgrqMsfYQqFR7kn-mn68AjvLcgwSfZvyR_yIK75S_K37vC3QryQ7cNoafDe9upql_6pB2ybMVlgWPs_DmbJ8g0om-sPlwyn74Cc1tW3ze-Xptw_2uVdPgWyqfuWAfq6Q
```

View this v1.0 sample token in [jwt.ms](https://jwt.ms/#id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyIsImtpZCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyJ9.eyJhdWQiOiJiMTRhNzUwNS05NmU5LTQ5MjctOTFlOC0wNjAxZDBmYzljYWEiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9mYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkvIiwiaWF0IjoxNTM2Mjc1MTI0LCJuYmYiOjE1MzYyNzUxMjQsImV4cCI6MTUzNjI3OTAyNCwiYWlvIjoiQVhRQWkvOElBQUFBcXhzdUIrUjREMnJGUXFPRVRPNFlkWGJMRDlrWjh4ZlhhZGVBTTBRMk5rTlQ1aXpmZzN1d2JXU1hodVNTajZVVDVoeTJENldxQXBCNWpLQTZaZ1o5ay9TVTI3dVY5Y2V0WGZMT3RwTnR0Z2s1RGNCdGsrTExzdHovSmcrZ1lSbXY5YlVVNFhscGhUYzZDODZKbWoxRkN3PT0iLCJhbXIiOlsicnNhIl0sImVtYWlsIjoiYWJlbGlAbWljcm9zb2Z0LmNvbSIsImZhbWlseV9uYW1lIjoiTGluY29sbiIsImdpdmVuX25hbWUiOiJBYmUiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC83MmY5ODhiZi04NmYxLTQxYWYtOTFhYi0yZDdjZDAxMWRiNDcvIiwiaXBhZGRyIjoiMTMxLjEwNy4yMjIuMjIiLCJuYW1lIjoiYWJlbGkiLCJub25jZSI6IjEyMzUyMyIsIm9pZCI6IjA1ODMzYjZiLWFhMWQtNDJkNC05ZWMwLTFiMmJiOTE5NDQzOCIsInJoIjoiSSIsInN1YiI6IjVfSjlyU3NzOC1qdnRfSWN1NnVlUk5MOHhYYjhMRjRGc2dfS29vQzJSSlEiLCJ0aWQiOiJmYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkiLCJ1bmlxdWVfbmFtZSI6IkFiZUxpQG1pY3Jvc29mdC5jb20iLCJ1dGkiOiJMeGVfNDZHcVRrT3BHU2ZUbG40RUFBIiwidmVyIjoiMS4wIn0=.UJQrCA6qn2bXq57qzGX_-D3HcPHqBMOKDPx4su1yKRLNErVD8xkxJLNLVRdASHqEcpyDctbdHccu6DPpkq5f0ibcaQFhejQNcABidJCTz0Bb2AbdUCTqAzdt9pdgQvMBnVH1xk3SCM6d4BbT4BkLLj10ZLasX7vRknaSjE_C5DI7Fg4WrZPwOhII1dB0HEZ_qpNaYXEiy-o94UJ94zCr07GgrqMsfYQqFR7kn-mn68AjvLcgwSfZvyR_yIK75S_K37vC3QryQ7cNoafDe9upql_6pB2ybMVlgWPs_DmbJ8g0om-sPlwyn74Cc1tW3ze-Xptw_2uVdPgWyqfuWAfq6Q).

#### Sample v2.0 ID token

```text
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjFMVE16YWtpaGlSbGFfOHoyQkVKVlhlV01xbyJ9.eyJ2ZXIiOiIyLjAiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vOTEyMjA0MGQtNmM2Ny00YzViLWIxMTItMzZhMzA0YjY2ZGFkL3YyLjAiLCJzdWIiOiJBQUFBQUFBQUFBQUFBQUFBQUFBQUFJa3pxRlZyU2FTYUZIeTc4MmJidGFRIiwiYXVkIjoiNmNiMDQwMTgtYTNmNS00NmE3LWI5OTUtOTQwYzc4ZjVhZWYzIiwiZXhwIjoxNTM2MzYxNDExLCJpYXQiOjE1MzYyNzQ3MTEsIm5iZiI6MTUzNjI3NDcxMSwibmFtZSI6IkFiZSBMaW5jb2xuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiQWJlTGlAbWljcm9zb2Z0LmNvbSIsIm9pZCI6IjAwMDAwMDAwLTAwMDAtMDAwMC02NmYzLTMzMzJlY2E3ZWE4MSIsInRpZCI6IjkxMjIwNDBkLTZjNjctNGM1Yi1iMTEyLTM2YTMwNGI2NmRhZCIsIm5vbmNlIjoiMTIzNTIzIiwiYWlvIjoiRGYyVVZYTDFpeCFsTUNXTVNPSkJjRmF0emNHZnZGR2hqS3Y4cTVnMHg3MzJkUjVNQjVCaXN2R1FPN1lXQnlqZDhpUURMcSFlR2JJRGFreXA1bW5PcmNkcUhlWVNubHRlcFFtUnA2QUlaOGpZIn0.1AFWW-Ck5nROwSlltm7GzZvDwUkqvhSQpm55TQsmVo9Y59cLhRXpvB8n-55HCr9Z6G_31_UbeUkoz612I2j_Sm9FFShSDDjoaLQr54CreGIJvjtmS3EkK9a7SJBbcpL1MpUtlfygow39tFjY7EVNW9plWUvRrTgVk7lYLprvfzw-CIqw3gHC-T7IK_m_xkr08INERBtaecwhTeN4chPC4W3jdmw_lIxzC48YoQ0dB1L9-ImX98Egypfrlbm0IBL5spFzL6JDZIRRJOu8vecJvj1mq-IUhGt0MacxX8jdxYLP-KUu2d9MbNKpCKJuZ7p8gwTL5B7NlUdh_dmSviPWrw
```

View this v2.0 sample token in [jwt.ms](https://jwt.ms/#id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjFMVE16YWtpaGlSbGFfOHoyQkVKVlhlV01xbyJ9.eyJ2ZXIiOiIyLjAiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vOTEyMjA0MGQtNmM2Ny00YzViLWIxMTItMzZhMzA0YjY2ZGFkL3YyLjAiLCJzdWIiOiJBQUFBQUFBQUFBQUFBQUFBQUFBQUFJa3pxRlZyU2FTYUZIeTc4MmJidGFRIiwiYXVkIjoiNmNiMDQwMTgtYTNmNS00NmE3LWI5OTUtOTQwYzc4ZjVhZWYzIiwiZXhwIjoxNTM2MzYxNDExLCJpYXQiOjE1MzYyNzQ3MTEsIm5iZiI6MTUzNjI3NDcxMSwibmFtZSI6IkFiZSBMaW5jb2xuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiQWJlTGlAbWljcm9zb2Z0LmNvbSIsIm9pZCI6IjAwMDAwMDAwLTAwMDAtMDAwMC02NmYzLTMzMzJlY2E3ZWE4MSIsInRpZCI6IjkxMjIwNDBkLTZjNjctNGM1Yi1iMTEyLTM2YTMwNGI2NmRhZCIsIm5vbmNlIjoiMTIzNTIzIiwiYWlvIjoiRGYyVVZYTDFpeCFsTUNXTVNPSkJjRmF0emNHZnZGR2hqS3Y4cTVnMHg3MzJkUjVNQjVCaXN2R1FPN1lXQnlqZDhpUURMcSFlR2JJRGFreXA1bW5PcmNkcUhlWVNubHRlcFFtUnA2QUlaOGpZIn0.1AFWW-Ck5nROwSlltm7GzZvDwUkqvhSQpm55TQsmVo9Y59cLhRXpvB8n-55HCr9Z6G_31_UbeUkoz612I2j_Sm9FFShSDDjoaLQr54CreGIJvjtmS3EkK9a7SJBbcpL1MpUtlfygow39tFjY7EVNW9plWUvRrTgVk7lYLprvfzw-CIqw3gHC-T7IK_m_xkr08INERBtaecwhTeN4chPC4W3jdmw_lIxzC48YoQ0dB1L9-ImX98Egypfrlbm0IBL5spFzL6JDZIRRJOu8vecJvj1mq-IUhGt0MacxX8jdxYLP-KUu2d9MbNKpCKJuZ7p8gwTL5B7NlUdh_dmSviPWrw).

---

## Claims reference

Access tokens and ID tokens are [JSON web tokens (JWT)](https://wikipedia.org/wiki/JSON_Web_Token). JWTs contain the following pieces:

- **Header** - Provides information about how to validate the token including information about the type of token and its signing method.
- **Payload** - Contains all of the important data about the user or application that's attempting to call the service.
- **Signature** - Is the raw material used to validate the token.

Each piece is separated by a period (`.`) and separately Base64 encoded.

### Header claims

Both access tokens and ID tokens contain header claims that provide information for token validation.

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `typ`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String - always `JWT`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates that the token is a JWT.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `alg`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates the algorithm used to sign the token, for example, `RS256`.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `kid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Specifies the thumbprint for the public key used for validating the signature of the token. Emitted in both v1.0 and v2.0 tokens.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `x5t`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Functions the same (in use and value) as `kid`. `x5t` is a legacy claim emitted only in v1.0 tokens for compatibility purposes.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

### Access token claims

Claims are present only if a value exists to fill it. An application shouldn't take a dependency on a claim being present. Examples include `pwd_exp` (not every tenant requires passwords to expire) and `family_name` ([client credential](v2-oauth2-client-creds-grant-flow.md) flows are on behalf of applications that don't have names). The access token always contains sufficient claims for access evaluation.

The Microsoft identity platform uses some claims to help secure tokens for reuse. The description of `Opaque` marks these claims as not being for public consumption. These claims may or may not appear in a token, and new ones may be added without notice.

> [!IMPORTANT]
> Applications shouldn't take hard dependency on claims being present or in specific order. New claims can be added or a claim can be changed from optional to required as new features are supported.

#### Core access token payload claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Authorization considerations| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | ------------------------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `aud`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, an Application ID URI or GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Identifies the intended audience of the token. In v2.0 tokens, this value is always the client ID of the API. In v1.0 tokens, it can be the client ID or the resource URI used in the request. The value can depend on how the client requested the token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | This value must be validated, reject the token if the value doesn't match the intended audience.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `iss`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a security token service (STS) URI| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Identifies the STS that constructs and returns the token, and the Microsoft Entra tenant of the authenticated user. If the token issued is a v2.0 token (see the `ver` claim), the URI ends in `/v2.0`. The GUID that indicates that the user is a consumer user from a Microsoft account is `9188040d-6c67-4c5b-b112-36a304b66dad`.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The application can use the GUID portion of the claim to restrict the set of tenants that can sign in to the application, if applicable.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `idp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, usually an STS URI| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Records the identity provider that authenticated the subject of the token. This value is identical to the value of the Issuer claim unless the user account isn't in the same tenant as the issuer, such as guests. Use the value of `iss` if the claim isn't present. For personal accounts being used in an organizational context (for instance, a personal account invited to a Microsoft Entra tenant), the `idp` claim may be 'live.com' or an STS URI containing the Microsoft account tenant `9188040d-6c67-4c5b-b112-36a304b66dad`. This claim is emitted in federated domain scenarios involving guests users and should always be sent in managed domain scenarios.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `iat`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | int, a Unix timestamp| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Specifies when the authentication for this token occurred.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `nbf`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | int, a Unix timestamp| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Specifies the time after which the JWT can be processed.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `exp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | int, a Unix timestamp| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Specifies the expiration time before which the JWT can be accepted for processing. A resource may reject the token before this time as well. The rejection can occur for a required change in authentication or when a token is revoked.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `sub`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The principal associated with the token. For example, the user of an application. This value is immutable, don't reassign or reuse. The subject is a pairwise identifier that's unique to a particular application ID. If a single user signs into two different applications using two different client IDs, those applications receive two different values for the subject claim. Using the two different values depends on architecture and privacy requirements.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | This value can be used to perform authorization checks, such as when the token is used to access a resource, and can be used as a key in database tables.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `oid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The immutable identifier for the requestor, which is the verified identity of the user or service principal. This ID uniquely identifies the requestor across applications. Two different applications signing in the same user receive the same value in the `oid` claim. The `oid` can be used when making queries to Microsoft online services, such as the Microsoft Graph. The Microsoft Graph returns this ID as the `id` property for a given user account. Because the `oid` allows multiple applications to correlate principals, to receive this claim for users use the `profile` scope. If a single user exists in multiple tenants, the user contains a different object ID in each tenant. Even though the user logs into each account with the same credentials, the accounts are different.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | This value can be used to perform authorization checks, such as when the token is used to access a resource, and can be used as a key in database tables.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `tid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Represents the tenant that the user is signing in to. For work and school accounts, the GUID is the immutable tenant ID of the organization that the user is signing in to. For sign-ins to the personal Microsoft account tenant (services like Xbox, Teams for Life, or Outlook), the value is `9188040d-6c67-4c5b-b112-36a304b66dad`. To receive this claim, the application must request the `profile` scope.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | This value should be considered in combination with other claims in authorization decisions.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `scp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a space separated list of scopes| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The set of scopes exposed by the application for which the client application has requested (and received) consent. Only included for user tokens.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The application should verify that these scopes are valid ones exposed by the application, and make authorization decisions based on the value of these scopes.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `roles`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Array of strings, a list of permissions| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The set of permissions exposed by the application that the requesting application or user has been given permission to call. The [client credential flow](v2-oauth2-client-creds-grant-flow.md) uses this set of permission in place of user scopes for application tokens. For user tokens, this set of values contains the assigned roles of the user on the target application.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | These values can be used for managing access, such as enforcing authorization to access a resource.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### Identity and authentication claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `amr`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | JSON array of strings, only present in v1.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Identifies the authentication method of the subject of the token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `acr`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a `0` or `1`, only present in v1.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | A value of `0` for the "Authentication context class" claim indicates the end-user authentication didn't meet the requirements of ISO/IEC 29115.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `acrs`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | JSON array of strings| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates the Auth Context IDs of the operations that the bearer is eligible to perform. Auth Context IDs can be used to trigger a demand for step-up authentication from within your application and services. Often used along with the `xms_cc` claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `preferred_username`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, only present in v2.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The primary username that represents the user. The value could be an email address, phone number, or a generic username without a specified format. Use the value for username hints and in human-readable UI as a username. To receive this claim, use the `profile` scope. Since this value is mutable, don't use it to make authorization decisions.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Provides a human-readable value that identifies the subject of the token. The value can vary, it's mutable, and is for display purposes only. To receive this claim, use the `profile` scope. Don't use this value to make authorization decisions.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### Application and client claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `appid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID, only present in v1.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The application ID of the client using the token. The application can act as itself or on behalf of a user. The application ID typically represents an application object, but it can also represent a service principal object in Microsoft Entra ID. `appid` may be used in authorization decisions.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `azp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID, only present in v2.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | A replacement for `appid`. The application ID of the client using the token. The application can act as itself or on behalf of a user. The application ID typically represents an application object, but it can also represent a service principal object in Microsoft Entra ID. `azp` may be used in authorization decisions.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `appidacr`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a `0`, `1`, or `2`, only present in v1.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates authentication method of the client. For a public client, the value is `0`. When you use the client ID and client secret, the value is `1`. When you use a client certificate for authentication, the value is `2`.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `azpacr`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a `0`, `1`, or `2`, only present in v2.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | A replacement for `appidacr`. Indicates the authentication method of the client. For a public client, the value is `0`. When you use the client ID and client secret, the value is `1`. When you use a client certificate for authentication, the value is `2`.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### Group and role claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `wids`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Array of [RoleTemplateID](~/identity/role-based-access-control/permissions-reference.md#all-roles) GUIDs| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Denotes the tenant-wide roles assigned to this user, from the section of roles present in [Microsoft Entra built-in roles](~/identity/role-based-access-control/permissions-reference.md#all-roles). The `groupMembershipClaims` property of the [application manifest](reference-app-manifest.md) configures this claim on a per-application basis. Set the claim to `All` or `DirectoryRole`. These values can be used for managing access, such as enforcing authorization to access a resource.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `groups`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | JSON array of GUIDs| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Provides object IDs that represent the group memberships of the subject. The `groupMembershipClaims` property of the [application manifest](reference-app-manifest.md) configures the groups claim on a per-application basis. A value of `null` excludes all groups, a value of `SecurityGroup` includes directory roles and Active Directory Security Group memberships, and a value of `All` includes both Security Groups and Microsoft 365 Distribution Lists. For other flows, if the number of groups the user is in goes over 150 for SAML and 200 for JWT, then Microsoft Entra ID adds an overage claim to the claim sources. The claim sources point to the Microsoft Graph endpoint that contains the list of groups for the user. These values can be used for managing access, such as enforcing authorization to access a resource.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `hasgroups`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Boolean| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | If present, always `true`, indicates whether the user is in at least one group. Indicates that the client should use the Microsoft Graph API to determine the groups (`https://graph.microsoft.com/v1.0/users/{userID}/getMemberObjects`) of the user.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `groups:src1`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | JSON object| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Includes a link to the full groups list for the user when token requests are too large for the token. For JWTs as a distributed claim, for SAML as a new claim in place of the `groups` claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### Special purpose claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `sid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Represents a unique identifier for a session and is generated when a new session is established.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `uti`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Token identifier claim, equivalent to `jti` in the JWT specification. Unique, per-token identifier that is case-sensitive.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `ver`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, either `1.0` or `2.0`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates the version of the access token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `xms_cc`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | JSON array of strings| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates whether the client application that acquired the token is capable of handling claims challenges. It's often used along with claim `acrs`. This claim is commonly used in Conditional Access and Continuous Access Evaluation scenarios. The resource server or service application that the token is issued for controls the presence of this claim in a token. A value of `cp1` in the access token is the authoritative way to identify that a client application is capable of handling a claims challenge.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `aio`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Opaque String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | An internal claim used by Microsoft Entra ID to record data for token reuse. Resources shouldn't use this claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `rh`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Opaque String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | An internal claim used by Azure to revalidate tokens. Resources shouldn't use this claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### v1.0 basic claims

The v1.0 tokens include the following claims if applicable, but not v2.0 tokens by default. To use these claims for v2.0, the application requests them using [optional claims](#claims-customization).

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `ipaddr`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The IP address the user authenticated from.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `onprem_sid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, in [SID format](/windows/win32/secauthz/sid-components)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | In cases where the user has an on-premises authentication, this claim provides their SID. Use this claim for authorization in legacy applications.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `pwd_exp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | int, a Unix timestamp| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates when the user's password expires.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `pwd_url`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | A URL where users can reset their password.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `in_corp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | boolean| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Signals if the client is signing in from the corporate network.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `nickname`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Another name for the user, separate from first or last name.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `family_name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Provides the last name, surname, or family name of the user as defined on the user object.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `given_name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Provides the first or given name of the user, as set on the user object.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `upn`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The username of the user. May be a phone number, email address, or unformatted string. Only use for display purposes and providing username hints in reauthentication scenarios.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `unique_name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, only present in v1.0 tokens| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Provides a human readable value that identifies the subject of the token. This value can be different within a tenant and use it only for display purposes.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

### Groups overage claim

Microsoft Entra ID limits the number of object IDs that it includes in the groups claim to stay within the size limit of the HTTP header. If a user is a member of more groups than the overage limit (150 for SAML tokens, 200 for JWT tokens), then Microsoft Entra ID doesn't emit the groups claim in the token. Instead, it includes an overage claim in the token that indicates to the application to query the Microsoft Graph API to retrieve the group membership of the user.

```JSON
{
    ...
    "_claim_names": {
        "groups": "src1"
    },
    "_claim_sources": {
        "src1": {
            "endpoint": "[Url to get this user's group membership from]"
        }   
    }
    ...
}
```

Use the `BulkCreateGroups.ps1` provided in the [App Creation Scripts](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/tree/master/5-WebApp-AuthZ/5-2-Groups/AppCreationScripts) folder to help test overage scenarios.

> [!NOTE]
> The URL returned is an Azure AD Graph URL (that is, graph.windows.NET). Instead of relying on this URL, services should instead use the `idtyp` optional claim (which identifies whether the token is an app or app+user token) to construct a Microsoft Graph URL for querying the full list of groups.

### ID token claims

ID tokens contain a subset of the claims found in access tokens, with a focus on user identity and authentication information.

#### Core ID token payload claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `aud`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, an App ID GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Identifies the intended recipient of the token. In `id_tokens`, the audience is your app's Application ID, assigned to your app in the Azure portal. This value should be validated. The token should be rejected if it fails to match your app's Application ID.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `iss`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, an issuer URI| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Identifies the issuer, or "authorization server" that constructs and returns the token. It also identifies the tenant for which the user was authenticated. If the token was issued by the v2.0 endpoint, the URI ends in `/v2.0`. The GUID that indicates that the user is a consumer user from a Microsoft account is `9188040d-6c67-4c5b-b112-36a304b66dad`. Your app should use the GUID portion of the claim to restrict the set of tenants that can sign in to the app, if applicable.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `iat`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | int, a Unix timestamp| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates when the authentication for the token occurred.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `idp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, usually an STS URI| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Records the identity provider that authenticated the subject of the token. This value is identical to the value of the issuer claim unless the user account isn't in the same tenant as the issuer - guests, for instance. If the claim isn't present, it means that the value of `iss` can be used instead. For personal accounts being used in an organizational context (for instance, a personal account invited to a tenant), the `idp` claim may be 'live.com' or an STS URI containing the Microsoft account tenant `9188040d-6c67-4c5b-b112-36a304b66dad`. This claim is emitted in federated domain scenarios involving guests users and should always be sent in managed domain scenarios.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `nbf`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | int, a Unix timestamp| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Identifies the time before which the JWT can't be accepted for processing.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `exp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | int, a Unix timestamp| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Identifies the expiration time on or after which the JWT can't be accepted for processing. In certain circumstances, a resource may reject the token before this time. For example, if a change in authentication is required or a token revocation has been detected.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `oid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The immutable identifier for an object, in this case, a user account. This ID uniquely identifies the user across applications - two different applications signing in the same user receives the same value in the `oid` claim. Microsoft Graph returns this ID as the `id` property for a user account. Because the `oid` allows multiple apps to correlate users, the `profile` scope is required to receive this claim. If a single user exists in multiple tenants, the user contains a different object ID in each tenant - they're considered different accounts, even though the user logs into each account with the same credentials. The `oid` claim is a GUID and can't be reused.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `sub`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The subject of the information in the token. For example, the user of an app. This value is immutable and can't be reassigned or reused. The subject is a pairwise identifier and is unique to an application ID. If a single user signs into two different apps using two different client IDs, those apps receive two different values for the subject claim. You may or may not want two values depending on your architecture and privacy requirements.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `tid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Represents the tenant that the user is signing in to. For work and school accounts, the GUID is the immutable tenant ID of the organization that the user is signing in to. For sign-ins to the personal Microsoft account tenant (services like Xbox, Teams for Life, or Outlook), the value is `9188040d-6c67-4c5b-b112-36a304b66dad`.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `nonce`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The nonce matches the parameter included in the original authorize request to the IDP. If it doesn't match, your application should reject the token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `ver`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, either 1.0 or 2.0| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates the version of the ID token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### User profile claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `preferred_username`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The primary username that represents the user. It could be an email address, phone number, or a generic username without a specified format. Its value is mutable and might change over time. Since it's mutable, this value can't be used to make authorization decisions. It can be used for username hints and in human-readable UI as a username. The `profile` scope is required to receive this claim. Present only in v2.0 tokens.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `email`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Present by default for guest accounts that have an email address. Your app can request the email claim for managed users (from the same tenant as the resource) using the `email` [optional claim](#claims-customization). This value isn't guaranteed to be correct and is mutable over time. Never use it for authorization or to save data for a user. If you require an addressable email address in your app, request this data from the user directly by using this claim as a suggestion or prefill in your UX. On the v2.0 endpoint, your app can also request the `email` OpenID Connect scope - you don't need to request both the optional claim and the scope to get the claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The `name` claim provides a human-readable value that identifies the subject of the token. The value isn't guaranteed to be unique, it can be changed, and should be used only for display purposes. The `profile` scope is required to receive this claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `family_name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Provides the last name, surname, or family name of the user as defined on the user object.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `given_name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Provides the first or given name of the user, as set on the user object.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### Hash validation claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `c_hash`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The code hash is included in ID tokens only when the ID token is issued with an OAuth 2.0 authorization code. It can be used to validate the authenticity of an authorization code. To understand how to do this validation, see the [OpenID Connect specification](https://openid.net/specs/openid-connect-core-1_0.html#HybridIDToken). This claim isn't returned on ID tokens from the /token endpoint.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `at_hash`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The access token hash is included in ID tokens only when the ID token is issued from the `/authorize` endpoint with an OAuth 2.0 access token. It can be used to validate the authenticity of an access token. To understand how to do this validation, see the [OpenID Connect specification](https://openid.net/specs/openid-connect-core-1_0.html#HybridIDToken). This claim isn't returned on ID tokens from the `/token` endpoint.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

#### Special purpose ID token claims

| Claim| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Format| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `roles`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Array of strings| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The set of roles that were assigned to the user who is logging in.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `sid`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String, a GUID| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Represents a unique identifier for a session and is generated when a new session is established.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `uti`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Token identifier claim, equivalent to `jti` in the JWT specification. Unique, per-token identifier that is case-sensitive.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `hasgroups`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Boolean| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | If present, always true, denoting the user is in at least one group. Indicates that the client should use the Microsoft Graph API to determine the user's groups (`https://graph.microsoft.com/v1.0/users/{userID}/getMemberObjects`).| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `groups:src1`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | JSON object| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | For token requests that aren't limited in length (see `hasgroups`) but still too large for the token, a link to the full groups list for the user is included. For JWTs as a distributed claim, for SAML as a new claim in place of the `groups` claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `aio`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Opaque String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | An internal claim that's used to record data for token reuse. Should be ignored.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `rh`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Opaque String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | An internal claim used to revalidate tokens. Should be ignored.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

### Use claims to reliably identify a user

When identifying a user, it's critical to use information that remains constant and unique across time. Legacy applications sometimes use fields like the email address, phone number, or UPN. All of these fields can change over time, and can also be reused over time. For example, when an employee changes their name, or an employee is given an email address that matches that of a previous, no longer present employee. Your application mustn't use human-readable data to identify a user. You can use extension claims provided by Microsoft, such as the `sub` and `oid` claims.

To correctly store information per-user, use `sub` or `oid` alone (which as GUIDs are unique), with `tid` used for routing or sharding if needed. If you need to share data across services, `oid` and `tid` is best as all apps get the same `oid` and `tid` claims for a user acting in a tenant. The `sub` claim is a pair-wise value that's unique. The value is based on a combination of the token recipient, tenant, and user. Two apps that request ID tokens for a user receive different `sub` claims, but the same `oid` claims for that user.

>[!NOTE]
> Don't use the `idp` claim to store information about a user in an attempt to correlate users across tenants. It doesn't work, as the `oid` and `sub` claims for a user change across tenants, by design, to ensure that applications can't track users across tenants.

Guest scenarios, where a user is homed in one tenant, and authenticates in another, should treat the user as if they're a brand new user to the service. Your documents and privileges in one tenant shouldn't apply in another tenant. This restriction is important to prevent accidental data leakage across tenants, and enforcement of data lifecycles. Evicting a guest from a tenant should also remove their access to the data they created in that tenant.

### Authentication method reference (AMR) values

Identities can authenticate in different ways, which may be relevant to the application. The `amr` claim is an array that can contain multiple items, such as `["mfa", "rsa", "pwd"]`, for an authentication that used both a password and the Authenticator app.

| Value| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| -----| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `pwd`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Password authentication, either a user's Microsoft password or a client secret of an application.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `rsa`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Authentication was based on the proof of an RSA key, for example with the [Microsoft Authenticator app](https://aka.ms/AA2kvvu). This value also indicates the use of a self-signed JWT with a service owned X509 certificate in authentication.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `otp`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | One-time passcode using an email or a text message.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `fed`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates the use of a federated authentication assertion (such as JWT or SAML).| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `wia`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Windows Integrated Authentication| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `mfa`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates the use of [Multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md). Includes the other authentication methods when this claim is present.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `ngcmfa`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Equivalent to `mfa`, used for provisioning of certain advanced credential types.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `wiaormfa`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The user used Windows or an MFA credential to authenticate.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `none`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Indicates no completed authentication.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

---

## Token validation

If the application needs to validate an ID token or an access token, it should first validate the signature of the token and the issuer against the values in the OpenID discovery document.

The Microsoft Entra middleware has built-in capabilities for validating access tokens. See [samples](sample-v2-code.md) to find one in the appropriate language. There are also several third-party open-source libraries available for JWT validation. For more information about authentication libraries and code samples, see the [authentication libraries](reference-v2-libraries.md). If your web app or web API is on ASP.NET or ASP.NET Core, use Microsoft.Identity.Web, which handles the validation for you.

### Validating v1.0 and v2.0 tokens

- When your web app/API is validating a v1.0 token (`ver` claim ="1.0"), it needs to read the OpenID Connect metadata document from the v1.0 endpoint (`https://login.microsoftonline.com/{example-tenant-id}/.well-known/openid-configuration`), even if the authority configured for your web API is a v2.0 authority.
- When your web app/API is validating a v2.0 token (`ver` claim ="2.0"), it needs to read the OpenID Connect metadata document from the v2.0 endpoint (`https://login.microsoftonline.com/{example-tenant-id}/v2.0/.well-known/openid-configuration`), even if the authority configured for your web API is a v1.0 authority.

The following examples suppose that your application is validating a v2.0 access token (and therefore reference the v2.0 versions of the OIDC metadata documents and keys). Just remove the "/v2.0" in the URL if you validate v1.0 tokens.

### Validate the issuer

[OpenID Connect Core](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation) says "The Issuer Identifier \[...\] MUST exactly match the value of the iss (issuer) Claim." For applications which use a tenant-specific metadata endpoint (like `https://login.microsoftonline.com/aaaabbbb-0000-cccc-1111-dddd2222eeee/v2.0/.well-known/openid-configuration` or `https://login.microsoftonline.com/contoso.onmicrosoft.com/v2.0/.well-known/openid-configuration`), this is all that is needed.

#### Single tenant applications

Single tenant applications are applications that support:
- Accounts in one organizational directory (**example-tenant-id** only): `https://login.microsoftonline.com/{example-tenant-id}`
- Personal Microsoft accounts only: `https://login.microsoftonline.com/consumers` (**consumers** being a nickname for the tenant 9188040d-6c67-4c5b-b112-36a304b66dad)

#### Multitenant applications

Microsoft Entra ID also supports multitenant applications. These applications support:
- Accounts in any organizational directory (any Microsoft Entra directory): `https://login.microsoftonline.com/organizations`
- Accounts in any organizational directory (any Microsoft Entra directory) and personal Microsoft accounts (for example, Skype, XBox): `https://login.microsoftonline.com/common`

For these applications, Microsoft Entra ID exposes tenant-independent versions of the OIDC document at `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration` and `https://login.microsoftonline.com/organizations/v2.0/.well-known/openid-configuration` respectively. These endpoints return an issuer value, which is a template parametrized by the `tenantid`: `https://login.microsoftonline.com/{tenantid}/v2.0`. Applications may use these tenant-independent endpoints to validate tokens from every tenant with the following stipulations:

1. Validate the signing key issuer
1. Instead of expecting the issuer claim in the token to exactly match the issuer value from metadata, the application should replace the `{tenantid}` value in the issuer metadata with the tenant ID that is the target of the current request, and then check the exact match (`tid` claim of the token).
1. Validate that the `tid` claim is a GUID and the `iss` claim is of the form `https://login.microsoftonline.com/{tid}/v2.0` where `{tid}` is the exact `tid` claim. This validation ties the tenant back to the issuer and back to the scope of the signing key creating a chain of trust.
1. Use `tid` claim when they locate data associated with the subject of the claim. In other words, the `tid` claim must be part of the key used to access the user's data.

### Validate the signature

A JWT contains three segments separated by the `.` character. The first segment is the **header**, the second is the **body**, and the third is the **signature**. Use the signature segment to evaluate the authenticity of the token.

Microsoft Entra ID issues tokens signed using the industry standard asymmetric encryption algorithms, such as RS256. The header of the JWT contains information about the key and encryption method used to sign the token:

```json
{
  "typ": "JWT",
  "alg": "RS256",
  "x5t": "H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a",
  "kid": "H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a"
}
```

The `alg` claim indicates the algorithm used to sign the token, while the `kid` claim indicates the particular public key that was used to validate the token.

At any given point in time, Microsoft Entra ID may sign an ID token using any one of a certain set of public-private key pairs. Microsoft Entra ID rotates the possible set of keys on a periodic basis, so write the application to handle those key changes automatically. A reasonable frequency to check for updates to the public keys used by Microsoft Entra ID is every 24 hours.

Acquire the signing key data necessary to validate the signature by using the [OpenID Connect metadata document](v2-protocols-oidc.md#fetch-the-openid-configuration-document) located at:

```
https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration
```

> [!TIP]
> Try this in a browser: [URL](https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration)

The following information describes the metadata document:

- Is a JSON object that contains several useful pieces of information, such as the location of the various endpoints required for doing OpenID Connect authentication.
- Includes a `jwks_uri`, which gives the location of the set of public keys that correspond to the private keys used to sign tokens. The JSON Web Key (JWK) located at the `jwks_uri` contains all of the public key information in use at that particular moment in time. [RFC 7517](https://tools.ietf.org/html/rfc7517) describes the JWK format. The application can use the `kid` claim in the JWT header to select the public key, from this document, which corresponds to the private key that has been used to sign a particular token. It can then do signature validation using the correct public key and the indicated algorithm.

> [!NOTE]
> Use the `kid` claim to validate the token. Though v1.0 tokens contain both the `x5t` and `kid` claims, v2.0 tokens contain only the `kid` claim.

Doing signature validation is outside the scope of this document. There are many open-source libraries available for helping with signature validation if necessary. However, the Microsoft identity platform has one token signing extension to the standards, which are custom signing keys.

If the application has custom signing keys as a result of using the [claims-mapping](./saml-claims-customization.md) feature, append an `appid` query parameter that contains the application ID. For validation, use `jwks_uri` that points to the signing key information of the application. For example: `https://login.microsoftonline.com/{tenant}/.well-known/openid-configuration?appid=00001111-aaaa-2222-bbbb-3333cccc4444` contains a `jwks_uri` of `https://login.microsoftonline.com/{tenant}/discovery/keys?appid=00001111-aaaa-2222-bbbb-3333cccc4444`.

### Validate the signing key issuer

Applications using the v2.0 tenant-independent metadata need to validate the signing key issuer.

The keys document exposed by Microsoft Entra ID v2.0 contains, for each key, the issuer that uses this signing key. For instance, the tenant-independent "common" key endpoint `https://login.microsoftonline.com/common/discovery/v2.0/keys` returns a document like:

```json
{
  "keys":[
    {"kty":"RSA","use":"sig","kid":"A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u","x5t":"A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u","n":"spv...","e":"AQAB","x5c":["MIID..."],"issuer":"https://login.microsoftonline.com/{tenantid}/v2.0"},
    {"kty":"RSA","use":"sig","kid":"C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w","x5t":"C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w","n":"wEM...","e":"AQAB","x5c":["MIID..."],"issuer":"https://login.microsoftonline.com/{tenantid}/v2.0"},
    {"kty":"RSA","use":"sig","kid":"E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y","x5t":"E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y","n":"rv0...","e":"AQAB","x5c":["MIID..."],"issuer":"https://login.microsoftonline.com/9188040d-6c67-4c5b-b112-36a304b66dad/v2.0"}
  ]
}
```

The application should use the `issuer` property of the keys document, associated with the key used to sign the token, in order to restrict the scope of keys:

- Keys that have an issuer value with a GUID like `https://login.microsoftonline.com/9188040d-6c67-4c5b-b112-36a304b66dad/v2.0` should only be used when the `iss` claim in the token matches the value exactly.
- Keys that have a templated issuer value like `https://login.microsoftonline.com/{tenantid}/v2.0` should only be used when the `iss` claim in the token matches this value after substituting the `tid` claim in the token for the `{tenantid}` placeholder.

Using tenant-independent metadata is more efficient for applications that accept tokens from many tenants.

> [!NOTE]
> With Microsoft Entra tenant-independent metadata, claims should be interpreted within the tenant, as under standard OpenID Connect, claims are interpreted within the issuer. That is, `{"sub":"ABC123","iss":"https://login.microsoftonline.com/{example-tenant-id}/v2.0","tid":"{example-tenant-id}"}` and `{"sub":"ABC123","iss":"https://login.microsoftonline.com/{another-tenand-id}/v2.0","tid":"{another-tenant-id}"}` describe different users, even though the `sub` is the same, because claims like `sub` are interpreted within the context of the issuer/tenant.

---

## Claims customization

Tokens that Microsoft Entra returns are kept smaller to ensure optimal performance by clients that request them. As a result, several claims are no longer present in the token by default and must be asked for specifically on a per-application basis through optional claims.

### Optional claims overview

You can configure optional claims for your application through the Microsoft Entra admin center's applications UI or manifest. In addition to the standard optional claims set, you can also configure tokens to include Microsoft Graph extensions.

> [!IMPORTANT]
> Access tokens are **always** generated using the manifest of the resource, not the client. In the request `...scope=https://graph.microsoft.com/user.read...`, the resource is the Microsoft Graph API. The access token is created using the Microsoft Graph API manifest, not the client's manifest. Changing the manifest for your application never causes tokens for the Microsoft Graph API to look different. To validate that your `accessToken` changes are in effect, request a token for your application, not another app.

### Configure optional claims in the Azure portal

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **App registrations**.
1. Choose the application for which you want to configure optional claims.
1. Under **Manage**, select **Token configuration**.
1. Select **Add optional claim**.
1. Select the token type you want to configure, such as *Access*.
1. Select the optional claims to add.
1. Select **Add**.

### Configure optional claims in the app manifest

1. Under **Manage**, select **Manifest**. A web-based manifest editor opens, allowing you to edit the manifest.
1. Add the following entry using the manifest editor:

    ```json
    "optionalClaims": {
        "idToken": [
            {
                "name": "auth_time",
                "essential": false
            }
        ],
        "accessToken": [
            {
                "name": "ipaddr",
                "essential": false
            }
        ],
        "saml2Token": [
            {
                "name": "upn",
                "essential": false
            },
            {
                "name": "extension_ab603c56068041afb2f6832e2a17e237_skypeId",
                "source": "user",
                "essential": false
            }
        ]
    }
    ```

1. When finished, select **Save**. Now the specified optional claims are included in the tokens for your application.

The `optionalClaims` object declares the optional claims requested by an application. An application can configure optional claims that are returned in ID tokens, access tokens, and SAML 2 tokens. The application can configure a different set of optional claims to be returned in each token type.

| Name| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Type| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| ------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | ------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `idToken`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Collection| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The optional claims returned in the JWT ID token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `accessToken`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Collection| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The optional claims returned in the JWT access token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `saml2Token`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Collection| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The optional claims returned in the SAML token.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

If supported by a specific claim, you can also modify the behavior of the optional claim using the `additionalProperties` field.

| Name| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Type| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Description| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| ------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | ------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | -------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `name`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Edm.String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The name of the optional claim.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `source`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Edm.String| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | The source (directory object) of the claim. There are predefined claims and user-defined claims from extension properties. If the source value is null, the claim is a predefined optional claim. If the source value is user, the value in the name property is the extension property from the user object.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `essential`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Edm.Boolean| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | If the value is true, the claim specified by the client is necessary to ensure a smooth authorization experience for the specific task requested by the end user. The default value is false.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| `additionalProperties`| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Collection (Edm.String)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Other properties of the claim. If a property exists in this collection, it modifies the behavior of the optional claim specified in the name property.| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

### Directory extension optional claims

In addition to the standard optional claims set, you can also configure tokens to include Microsoft Graph extensions. For more information, see [Add custom data to resources using extensions](/graph/extensibility-overview).

Optional claims support extension attributes and directory extensions. This feature is useful for attaching more user information that your app can use. For example, other identifiers or important configuration options that the user has set. If your application manifest requests a custom extension and an MSA user logs in to your app, these extensions aren't returned.

When configuring directory extension optional claims using the application manifest, use the full name of the extension (in the format: `extension_<appid>_<attributename>`). The `<appid>` is the stripped version of the appId (or Client ID) of the application requesting the claim.

Within the JWT, these claims are emitted with the following name format: `extn.<attributename>`. Within the SAML tokens, these claims are emitted with the following URI format: `http://schemas.microsoft.com/identity/claims/extn.<attributename>`

### Configure groups optional claims

This section covers the configuration options under optional claims for changing the group attributes used in group claims from the default group objectID to attributes synced from on-premises Windows Active Directory. You can configure groups optional claims for your application through the Azure portal or application manifest. Group optional claims are only emitted in the JWT for user principals. Service principals aren't included in group optional claims emitted in the JWT.

> [!IMPORTANT]
> The number of groups emitted in a token are limited to 150 for SAML assertions and 200 for JWT, including nested groups. For more information about group limits and important caveats for group claims from on-premises attributes, see [Configure group claims for applications](~/identity/hybrid/connect/how-to-connect-fed-group-claims.md).

Complete the following steps to configure groups optional claims using the Azure portal:

1. Select the application for which you want to configure optional claims.
1. Under **Manage**, select **Token configuration**.
1. Select **Add groups claim**.
1. Select the group types to return (**Security groups**, or **Directory roles**, **All groups**, and/or **Groups assigned to the application**):
    - The **Groups assigned to the application** option includes only groups assigned to the application. The **Groups assigned to the application** option is recommended for large organizations due to the group number limit in token. To change the groups assigned to the application, select the application from the **Enterprise applications** list. Select **Users and groups** and then **Add user/group**. Select the group(s) you want to add to the application from **Users and groups**.
    - The **All Groups** option includes **SecurityGroup**, **DirectoryRole**, and **DistributionList**, but not **Groups assigned to the application**.
1. Optional: select the specific token type properties to modify the groups claim value to contain on premises group attributes or to change the claim type to a role.
1. Select **Save**.

---

## Token lifetime configuration

You can configure the lifetime of access, ID, or Security Assertion Markup Language (SAML) tokens issued by the Microsoft identity platform. Token lifetimes can be set for all apps in your organization, multitenant applications, or specific service principals. Configuring token lifetimes for [managed identity service principals](~/identity/managed-identities-azure-resources/overview.md) isn't supported.

### License requirements

Using this feature requires a Microsoft Entra ID P1 license. To find the right license for your requirements, see [Comparing generally available features of the Free and Premium editions](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

Customers with [Microsoft 365 Business licenses](/office365/servicedescriptions/office-365-service-descriptions-technet-library) also have access to Conditional Access features.

### Token lifetime policies

In Microsoft Entra ID, policies define rules applied to individual applications or all applications in an organization. Each policy type has unique properties that determine how it is enforced on the object to which it's assigned.

A policy can be designated as the default for your organization, applying to all applications unless overridden by a higher-priority policy. Policies can also be assigned to specific applications, with priority varying by policy type.

> [!NOTE]
> Configurable token lifetime policy only applies to mobile and desktop clients that access SharePoint Online and OneDrive for Business resources, and doesn't apply to web browser sessions. To manage the lifetime of web browser sessions for SharePoint Online and OneDrive for Business, use the [Conditional Access session lifetime](~/identity/conditional-access/howto-conditional-access-session-lifetime.md) feature.

> [!NOTE]
> You might want to increase the token lifetime so that a script runs for more than an hour. Many Microsoft libraries, such as Microsoft Graph PowerShell SDK, extend the token lifetime as needed and you don't need to makes changes to the access token policy.

> [!NOTE]
> Configurable token lifetime policy is not supported for applications developed for personal Microsoft accounts (where `signInAudience` is set to `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount`).

### Access, ID, and SAML token lifetime properties

You can set token lifetime policies for access tokens, SAML tokens, and ID tokens.

#### Access tokens

Clients use access tokens to access a protected resource. An access token can be used only for a specific combination of user, client, and resource. Access tokens can't be revoked and are valid until their expiry. A malicious actor that obtains an access token can use it for extent of its lifetime. Adjusting the lifetime of an access token is a trade-off between improving system performance and increasing the amount of time that the client retains access after the user's account is disabled. Improved system performance is achieved by reducing the number of times a client needs to acquire a fresh access token.

The default lifetime of an access token is variable. When issued, an access token's default lifetime is assigned a random value ranging between 60-90 minutes (75 minutes on average). The default lifetime also varies depending on the client application requesting the token or if Conditional Access is enabled in the tenant.

#### SAML tokens

SAML tokens are used by many web-based SaaS applications, and are obtained using Microsoft Entra ID's SAML2 protocol endpoint. They're also consumed by applications using WS-Federation. The default lifetime of the token is 1 hour. From an application's perspective, the validity period of the token is specified by the NotOnOrAfter value of the `<conditions …>` element in the token. After the validity period of the token has ended, the client must initiate a new authentication request, which will often be satisfied without interactive sign in as a result of the Single Sign On (SSO) Session token.

The value of NotOnOrAfter can be changed using the `AccessTokenLifetime` parameter in a `TokenLifetimePolicy`. It will be set to the lifetime configured in the policy if any, plus a clock skew factor of five minutes.

The subject confirmation NotOnOrAfter specified in the `<SubjectConfirmationData>` element is not affected by the Token Lifetime configuration.

#### ID tokens

ID tokens are passed to websites and native clients. ID tokens contain profile information about a user. An ID token is bound to a specific combination of user and client. ID tokens are considered valid until their expiry. Usually, a web application matches a user's session lifetime in the application to the lifetime of the ID token issued for the user. You can adjust the lifetime of an ID token to control how often the web application expires the application session, and how often it requires the user to be reauthenticated with the Microsoft identity platform (either silently or interactively).

#### Configurable properties

Reducing the Access Token Lifetime property mitigates the risk of an access token or ID token being used by a malicious actor for an extended period of time. (These tokens can't be revoked.) The trade-off is that performance is adversely affected, because the tokens have to be replaced more often.

Access, ID, and SAML2 token configuration are affected by the following properties:

- **Property**: Access Token Lifetime
- **Policy property string**: AccessTokenLifetime
- **Affects**: Access tokens, ID tokens, SAML2 tokens
- **Default**:
    - Access tokens: varies, depending on the client application requesting the token. For example, continuous access evaluation (CAE) capable clients that negotiate CAE-aware sessions will see a long lived token lifetime (up to 28 hours).
    - ID tokens, SAML2 tokens: One hour
- **Minimum**: 10 minutes
- **Maximum**: One day

### Refresh and session token lifetime

You can't set token lifetime policies for refresh tokens and session tokens. For lifetime, time-out, and revocation information on refresh tokens, see [Refresh tokens](#refresh-tokens).

> [!IMPORTANT]
> As of January 30, 2021 you can't configure refresh and session token lifetimes. Microsoft Entra no longer honors refresh and session token configuration in existing policies. New tokens issued are set to the default configuration. You can still configure access, SAML, and ID token lifetimes after the refresh and session token configuration retirement.
>
> Existing token's lifetime won't be changed. After they expire, a new token will be issued based on the default value.
>
> If you need to continue to define the time period before a user is asked to sign in again, configure sign-in frequency in Conditional Access. To learn more about Conditional Access, read [Configure authentication session management with Conditional Access](~/identity/conditional-access/howto-conditional-access-session-lifetime.md).

---

## Authorization flows

Depending on how your client is built, it can use one or several of the authentication flows supported by the Microsoft identity platform. The supported flows can produce various tokens and authorization codes and require different tokens to make them work. The following table provides an overview.

| Flow| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Requires| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | ID token| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Access token| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Refresh token| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Authorization code| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| ------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | ----------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | ----------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | ---------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | --------------------| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| [Authorization code flow](v2-oauth2-auth-code-flow.md)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| [Implicit flow](v2-oauth2-implicit-grant-flow.md)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| [Refresh token redemption](v2-oauth2-auth-code-flow.md#refresh-the-access-token)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Refresh token| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| [On-behalf-of flow](v2-oauth2-on-behalf-of-flow.md)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | Access token| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |
| [Client credentials](v2-oauth2-client-creds-grant-flow.md)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | | x (App only)| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | || [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition) | |

---

## Security best practices

Interacting with tokens is a core piece of building applications to authorize users. In accordance with the [Zero Trust principle](zero-trust-for-developers.md) for least privileged access, it's essential that applications validate the values of certain claims present in the access token when performing authorization.

### Validate critical claims

Claims based authorization allows applications to ensure that the token contains the correct values for things such as the tenant, subject, and actor present in the token. To make sure that your authorization logic is secure, you must validate the following information in claims:

- The appropriate audience is specified for the token.
- The tenant ID of the token matches the ID of the tenant where data is stored.
- The subject of the token is appropriate.
- The actor (client app) is authorized.

> [!NOTE]
> Access tokens are only validated in the web APIs for which they were acquired by a client. The client shouldn't validate access tokens.

### Validate the audience

The `aud` claim identifies the intended audience of the token. Before validating claims, you must always verify that the value of the `aud` claim contained in the access token matches the Web API. The value can depend on how the client requested the token. The audience in the access token depends on the endpoint:

- For v2.0 tokens, the audience is the client ID of the web API. It's a GUID.
- For v1.0 tokens, the audience is one of the appID URIs declared in the web API that validates the token. For example, `api://{ApplicationID}`, or a unique name starting with a domain name (if the domain name is associated with a tenant).

For more information about the appID URI of an application, see [Application ID URI](security-best-practices-for-app-registration.md#application-id-uri-also-known-as-identifier-uri).

### Validate the tenant

Always check that the `tid` in a token matches the tenant ID used to store data with the application. When information is stored for an application in the context of a tenant, it should only be accessed again later in the same tenant. Never allow data in one tenant to be accessed from another tenant.

Validation of the tenant is the first step, but the checks on subject and actor described below are still necessary. If you intend to authorize all users in a tenant, it's strongly recommended to explicitly add these users into a group and authorize based on the group. For example, by only checking the tenant ID and the presence of an `oid` claim, your API could inadvertently authorize all service principals in that tenant in addition to users.

### Validate the subject

Determine if the token subject, such as the user (or application itself for an app-only token), is authorized.

You can either check for specific `sub` or `oid` claims, or you can check that the subject belongs to an appropriate role or group with the `roles`, `scp`, `groups`, `wids` claims. For example, use the immutable claim values `tid` and `oid` as a combined key for application data and determining whether a user should be granted access.

The `roles`, `groups` or `wids` claims can also be used to determine if the subject has authorization to perform an operation, although they aren't an exhaustive list of all of the ways a subject can be granted permissions. For example, an administrator may have permission to write to an API, but not a normal user, or the user may be in a group allowed to do some action. The `wid` claim represents the tenant-wide roles assigned to the user from the roles present in the Microsoft Entra built-in roles.

> [!WARNING]
> Never use claims like `email`, `preferred_username` or `unique_name` to store or determine whether the user in an access token should have access to data. These claims aren't unique and can be controllable by tenant administrators or sometimes users, which make them unsuitable for authorization decisions. They're only usable for display purposes. Also don't use the `upn` claim for authorization. While the UPN is unique, it often changes over the lifetime of a user principal, which makes it unreliable for authorization.

### Validate the actor

A client application that's acting on behalf of a user (referred to as the *actor*), must also be authorized. Use the `scp` claim (scope) to validate that the application has permission to perform an operation. The permissions in `scp` should be limited to what the user actually needs and follows the principles of [least privilege](secure-least-privileged-access.md).

However, there are occurrences where `scp` isn't present in the token. You should check for the absence of the `scp` claim for the following scenarios:

- Daemon apps / app only permission
- ID tokens

> [!NOTE]
> An application may handle app-only tokens (requests from applications without users, such as daemon apps) and want to authorize a specific application across multiple tenants, rather than individual service principal IDs. In that case, the `appid` claim (for v1.0 tokens) or the `azp` claim (for v2.0 tokens) can be used for subject authorization. However, when using these claims, the application must ensure that the token was issued directly for the application by validating the `idtyp` optional claim. Only tokens of type `app` can be authorized this way, as delegated user tokens can potentially be obtained by entities other than the application.

### Use Microsoft Authentication Libraries

We recommend you use the supported [Microsoft Authentication Libraries (MSAL)](/entra/identity-platform/msal-overview) whenever possible. This implements the acquisition, refresh, and validation of tokens for you. It also implements standards-compliant discovery of tenant settings and keys using the tenant's OpenID well-known discovery document. MSAL supports many different application architectures and platforms including .NET, JavaScript, Java, Python, Android, and iOS.

---

## Related content

- [Primary refresh tokens](~/identity/devices/concept-primary-refresh-token.md)
- [Invalidate refresh token](/powershell/module/microsoft.graph.beta.users.actions/invoke-mgbetainvalidatealluserrefreshtoken?view=graph-powershell-beta&preserve-view=true)
- [OAuth 2.0 and OpenID Connect protocols](./v2-protocols.md)
- [OpenID Connect on the Microsoft identity platform](v2-protocols-oidc.md)
- [Authentication vs. authorization](authentication-vs-authorization.md)
- [SAML token reference](reference-saml-tokens.md)
- [Signing key rollover](signing-key-rollover.md)
- [How to use continuous access evaluation enabled APIs](app-resilience-continuous-access-evaluation.md)
