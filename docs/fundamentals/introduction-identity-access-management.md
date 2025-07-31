---
title: What is identity and access management (IAM)?
description:  Learn what identity and access management (IAM) is, why it's important, and how it works.  Learn about authentication and authorization, single sign-on (SSO), and multifactor authentication (MFA). Learn about SAML, Open ID Connect (OIDC), and OAuth 2.0 and other authentication and authorization standards, tokens, and more.
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby

ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 03/13/2025
ms.reviewer: 
---
# What is identity and access management (IAM)?

In this article, you learn some of the fundamental concepts of Identity and Access Management (IAM), why it's important, and how it works.

Identity and access management ensures that the right people, machines, and software components get access to the right resources at the right time. First, the person, machine, or software component proves they're who or what they claim to be. Then, the person, machine, or software component is allowed or denied access to or use of certain resources.

To learn about the basic terms and concepts, see [Identity fundamentals](./identity-fundamental-concepts.md).



## How IAM works

This section provides an overview of the authentication and authorization process and the more common standards.

### Authenticating, authorizing, and accessing resources

Let's say you have an application that signs in a user and then accesses a protected resource.

:::image type="content" source="./media/introduction-identity-access-management/openid-oauth.svg" alt-text="Diagram that shows the user authentication and authorization process for accessing a protected resource using an identity provider." :::

1. The user (resource owner) initiates an authentication request with the identity provider/authorization server from the client application.

1. If the credentials are valid, the identity provider/authorization server first sends an ID token containing information about the user back to the client application.

1. The identity provider/authorization server also obtains end-user consent and grants the client application authorization to access the protected resource. Authorization is provided in an access token, which is also sent back to the client application.

1. The access token is attached to subsequent requests made to the protected resource server from the client application.

1. The identity provider/authorization server validates the access token.  If successful the request for protected resources is granted, and a response is sent back to the client application.

For more information, read [Authentication and authorization](~/identity-platform/authentication-vs-authorization.md#authentication-and-authorization-using-the-microsoft-identity-platform).

### Authentication and authorization standards

These are the most well-known and commonly used authentication and authorization standards:

#### OAuth 2.0

OAuth is an open-standards identity management protocol that provides secure access for websites, mobile apps, and Internet of Things and other devices. It uses tokens that are encrypted in transit and eliminates the need to share credentials. OAuth 2.0, the latest release of OAuth, is a popular framework used by major social media platforms and consumer services, from Facebook and LinkedIn to Google, PayPal, and Netflix. To learn more, read about [OAuth 2.0 protocol](~/identity-platform/v2-protocols.md).
#### OpenID Connect (OIDC)

With the release of the OpenID Connect (which uses public-key encryption), OpenID became a widely adopted authentication layer for OAuth. Like SAML, OpenID Connect (OIDC) is widely used for single sign-on (SSO), but OIDC uses REST/JSON instead of XML. OIDC was designed to work with both native and mobile apps by using REST/JSON protocols. The primary use case for SAML, however, is web-based apps. To learn more, read about [OpenID Connect protocol](~/identity-platform/v2-protocols.md).

#### JSON web tokens (JWTs)

JWTs are an open standard that defines a compact and self-contained way for securely transmitting information between parties as a JSON object. JWTs can be verified and trusted because they’re digitally signed. They can be used to pass the identity of authenticated users between the identity provider and the service requesting the authentication. They also can be authenticated and encrypted. To learn more, read [JSON Web Tokens](~/identity-platform/v2-protocols.md#tokens).

#### Security Assertion Markup Language (SAML)

SAML is an open standard utilized for exchanging authentication and authorization information between, in this case, an IAM solution and another application. This method uses XML to transmit data and is typically the method used by identity and access management platforms to grant users the ability to sign in to applications that have been integrated with IAM solutions. To learn more, read [SAML protocol](~/identity-platform/saml-protocol-reference.md).

#### System for Cross-Domain Identity Management (SCIM)

Created to simplify the process of managing user identities, SCIM provisioning allows organizations to efficiently operate in the cloud and easily add or remove users, benefitting budgets, reducing risk, and streamlining workflows. SCIM also facilitates communication between cloud-based applications.  To learn more, read [Develop and plan provisioning for a SCIM endpoint](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md?toc=/active-directory/develop/toc.json&bc=/active-directory/develop/breadcrumb/toc.json).

#### Web Services Federation (WS-Fed)

WS-Fed was developed by Microsoft and used extensively in their applications, this standard defines the way security tokens can be transported between different entities to exchange identity and authorization information. To learn more, read [Web Services Federation Protocol](/openspecs/windows_protocols/ms-adfsod/204de335-ea34-4f9b-ae73-8b7d4c8152d1).

## Next steps

To learn more, see:

- [Single sign-on (SSO)](~/identity/enterprise-apps/what-is-single-sign-on.md)
- [Multifactor authentication (MFA)](~/identity/authentication/concept-mfa-howitworks.md)
- [Authentication vs authorization](~/identity-platform/authentication-vs-authorization.md)
- [OAuth 2.0 and OpenID Connect](~/identity-platform/v2-protocols.md)
- [App types and authentication flows](~/identity-platform/authentication-flows-app-scenarios.md)
- [Security tokens](~/identity-platform/security-tokens.md)
