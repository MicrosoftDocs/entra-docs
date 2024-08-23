---
title: Tokens and claims overview
description: Learn about the basics of security tokens in the Microsoft identity platform.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: curation-claims
ms.date: 03/20/2024
ms.reviewer: jmprieur, saeeda, ludwignick
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an application developer, I want to understand the basic concepts of security tokens in the Microsoft identity platform.
---

# Tokens and claims overview

A centralized identity provider is especially useful for apps that have worldwide users who don't necessarily sign in from the enterprise's network. The Microsoft identity platform authenticates users and provides security tokens, such as access tokens, refresh tokens, and ID tokens. Security tokens allow a client application to access protected resources on a resource server. 

- **Access token** - An access token is a security token issued by an authorization server as part of an OAuth 2.0 flow. It contains information about the user and the resource for which the token is intended. The information can be used to access web APIs and other protected resources. Resources validate access tokens to grant access to a client application. For more information, see [Access tokens in the Microsoft identity platform](access-tokens.md).
- **Refresh token** - Because access tokens are valid for only a short period of time, authorization servers sometimes issue a refresh token at the same time the access token is issued. The client application can then exchange this refresh token for a new access token when needed. For more information, see [Refresh tokens in the Microsoft identity platform](refresh-tokens.md).
- **ID token** - ID tokens are sent to the client application as part of an OpenID Connect flow. They can be sent alongside or instead of an access token. ID tokens are used by the client to authenticate the user. To learn more about how the Microsoft identity platform issues ID tokens, see [ID tokens in the Microsoft identity platform](id-tokens.md).

Many enterprise applications use SAML to authenticate users. For information on SAML assertions, see [SAML token reference](reference-saml-tokens.md).

## Validate tokens

It's up to the application for which the token was generated, the web app that signed in the user, or the web API being called to validate the token. The authorization server signs the token with a private key. The authorization server publishes the corresponding public key. To validate a token, the app verifies the signature by using the authorization server public key to validate that the signature was created using the private key. For more information, check out the [Secure applications and APIs by validating claims](/entra/identity-platform/claims-validation) article.

We recommend you use the supported [Microsoft Authentication Libraries (MSAL)](/entra/identity-platform/msal-overview) whenever possible. This implements the acquisition, refresh, and validation of tokens for you. It also implements standards-compliant discovery of tenant settings and keys using the tenant’s OpenID well-known discovery document. MSAL supports many different application architectures and platforms including .NET, JavaScript, Java, Python, Android, and iOS.

Tokens are valid for only a limited amount of time, so the authorization server frequently provides a pair of tokens. An access token is provided, which accesses the application or protected resource. A refresh token is provided, which is used to refresh the access token when the access token is close to expiring.

Access tokens are passed to a web API as the bearer token in the `Authorization` header. An app can provide a refresh token to the authorization server. If the user access to the app wasn't revoked, it receives a new access token and a new refresh token. When the authorization server receives the refresh token, it issues another access token only if the user is still authorized.

## JSON Web Tokens and claims

The Microsoft identity platform implements security tokens as JSON Web Tokens (JWTs) that contain *claims*. Since JWTs are used as security tokens, this form of authentication is sometimes called *JWT authentication*.

A claim provides assertions about one entity, such as a client application or resource owner, to another entity, such as a resource server. A claim might also be referred to as a JWT claim or a JSON Web Token claim.

Claims are name or value pairs that relay facts about the token subject. For example, a claim might contain facts about the security principal that the authorization server authenticated. The claims present in a specific token depend on many things, such as the type of token, the type of credential used to authenticate the subject, and the application configuration.

Applications can use claims for the following various tasks:

* Validate the token
* Identify the token subject's tenant
* Display user information
* Determine the subject's authorization

A claim consists of key-value pairs that provide the following types of information:

* Security token server that generated the token
* Date when the token was generated
* Subject (like the user, but not daemons)
* Audience, which is the app for which the token was generated
* App (the client) that asked for the token

## Token endpoints and issuers

Microsoft Entra ID supports two tenant configurations: A workforce configuration that’s intended for internal use and manages employees and business guests, and a [customer configuration](/entra/external-id/customers/concept-supported-features-customers) which is optimized for isolating consumers and partners in a restricted external-facing directory. While the underlying identity service is identical for both tenant configurations, the login domains and token issuing authority for external tenants is different. This allows applications to keep workforce and external ID workflows separated if needed.

Microsoft Entra workforce tenants authenticate at login.microsoftonline.com with tokens issued by *sts.windows.net*. Workforce tenant tokens are generally interchangeable across tenants and multi-tenant applications so long as underlying trust relationships permit this interoperability. Microsoft Entra external tenants use tenanted endpoints of the form *{tenantname}.ciamlogin.com*. Applications registered to external tenants must be aware of this separation to receive and validate tokens correctly.

Every Microsoft Entra tenant publishes a standards-compliant well-known metadata. This document contains information about the issuer name, the authentication and authorization endpoints, supported scopes and claims. For external tenants, the document is publicly available at: *https://{tenantname}.ciamlogin.com/{tenantid}/v2.0/.well-known/openid-configuration*. This endpoint returns an issuer value *https://{tenantid}.ciamlogin.com/{tenantid}/v2.0*.

## Authorization flows and authentication codes

Depending on how your client is built, it can use one or several of the authentication flows supported by the Microsoft identity platform. The supported flows can produce various tokens and authorization codes and require different tokens to make them work. The following table provides an overview.

| Flow | Requires | ID token | Access token | Refresh token | Authorization code |
|------|----------|----------|--------------|---------------|--------------------|
| [Authorization code flow](v2-oauth2-auth-code-flow.md) | | x | x | x | x |
| [Hybrid OIDC flow](v2-protocols-oidc.md#protocol-diagram-access-token-acquisition)| | x | | | x |
| [Refresh token redemption](v2-oauth2-auth-code-flow.md#refresh-the-access-token) | Refresh token | x | x | x | |
| [On-behalf-of flow](v2-oauth2-on-behalf-of-flow.md) | Access token | x | x| x | |
| [Client credentials](v2-oauth2-client-creds-grant-flow.md) | | | x (App only) | | |

## See also

* [OAuth 2.0](./v2-protocols.md)
* [OpenID Connect](v2-protocols-oidc.md)

## Next steps

* To learn about the basic concepts of authentication and authorization, see [Authentication vs. authorization](authentication-vs-authorization.md).
