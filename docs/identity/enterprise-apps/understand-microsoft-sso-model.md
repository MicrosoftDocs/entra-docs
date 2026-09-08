---
title: Understand Microsoft's SSO model
description: Learn how Microsoft Entra ID implements single sign-on (SSO) as a centralized identity platform for both SAML and OpenID Connect protocols.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: concept-article
ms.date: 06/04/2026
ms.author: jomondi
ms.reviewer: hkinyunyu
ms.custom: enterprise-apps-article, msecd-doc-authoring-1013
ai-usage: ai-assisted

# Customer intent: As an ISV application developer or identity administrator, I want to understand how Microsoft Entra ID implements SSO at the platform level so I can design applications that integrate effectively with Microsoft's identity services.
---

# Understand Microsoft's SSO model

Microsoft Entra ID is a central identity platform. It provides single sign-on (SSO) across apps that use different authentication protocols. This article explains how Microsoft Entra ID implements SSO at the platform level and what that means for app integration.

## Microsoft Entra ID as a central identity platform

Microsoft Entra ID is a central identity provider. It authenticates users and issues identity tokens to apps. It gives users one sign-in experience, and it supports different protocols to deliver identity information to apps.

Users sign in through Microsoft Entra ID once. The platform can then assert their identity to many apps without asking them to sign in again. Authentication policies, security controls, and user credentials live in one place. Each app receives identity information in its own protocol format.

The key idea: authentication is unified across the platform. Protocols like Security Assertion Markup Language (SAML) and OpenID Connect (OIDC) differ only in how they package and deliver that identity information after authentication.

## How Microsoft Entra handles authentication for SAML and OIDC

Microsoft Entra ID uses the same authentication stages whether an app uses [SAML](~/identity-platform/single-sign-on-saml-protocol.md) or [OpenID Connect](~/identity-platform/v2-protocols-oidc.md).

### Shared authentication stages

**User authentication**: Microsoft Entra ID verifies user credentials. Users can sign in with a password, multifactor authentication, or a passwordless method. This step is the same for every app, whatever protocol it uses.

**Policy enforcement**: The platform checks Conditional Access policies, device compliance, and other security controls. These checks run after sign-in but before Microsoft Entra ID issues any tokens or assertions.

**Identity determination**: Microsoft Entra ID decides which identity information to include. It bases this on the app's configuration and on the user's profile and group memberships. For more detail, see [Authenticate applications and users](~/architecture/authenticate-applications-and-users.md).

### Protocol divergence

After authentication and policy checks, the two protocols differ in how they package and deliver identity information.

**SAML applications** receive SAML assertions in XML format. Each assertion holds identity information and attributes, is digitally signed, and travels in SAML protocol messages.

**OpenID Connect applications** receive JSON Web Tokens (JWTs) that hold identity claims. These tokens follow the [OAuth 2.0 authorization code flow](~/identity-platform/v2-oauth2-auth-code-flow.md) and OpenID Connect specs for structure and delivery.

The authentication and authorization decisions are the same. Only the format and delivery differ, based on the app's protocol.

## Shared enforcement and policy layer

Microsoft Entra ID applies the same security policies and access controls to every app, whatever protocol it uses. This enforcement happens before Microsoft Entra ID issues any tokens or assertions.

**[Conditional Access policies](~/identity/conditional-access/overview.md)** weigh factors like user location, device compliance, sign-in risk, and app sensitivity. A policy can require extra authentication, block access, or allow access under set conditions. The platform enforces these policies for SAML and OpenID Connect apps alike.

**[Multifactor authentication (MFA)](~/identity/authentication/concept-mfa-howitworks.md)** applies during sign-in, before any protocol-specific token is issued. Whether an app uses SAML or OIDC, users see the same MFA prompts, based on their assigned policies.

**Device-based policies** check device compliance, registration status, and device-based Conditional Access rules. These checks run during sign-in and apply the same way for every app protocol.

This shared policy layer keeps security controls and access decisions consistent across all your apps, whatever mix of SAML and OpenID Connect you use.

## Configuration model: applications, tenants, and protocol settings

Microsoft Entra ID uses a structured configuration model to manage app integrations and protocol-specific settings. A tenant is an organization's dedicated Microsoft Entra ID instance.

**[Application objects](~/identity-platform/app-objects-and-service-principals.md)** are the global definition of an app. An application object holds the app's authentication requirements, supported protocols, and basic configuration. It defines what the app can do.

**Service principals** represent the app within a specific tenant. When someone adds the app to a tenant, Microsoft Entra ID creates a service principal. The service principal holds tenant-specific configuration, user assignments, and protocol settings. Because the app object and service principal are separate, your app can use different configurations in different customer tenants.

**Protocol configuration** lives at the service principal level, so SAML and OpenID Connect settings are tenant-specific. These settings include:
- SAML assertion attributes and NameID formats
- OpenID Connect scopes and claims mapping
- Redirect URIs and protocol-specific endpoints
- Certificate and key configuration for token signing

This configuration model lets ISV apps support [multiple tenants](~/identity-platform/single-and-multi-tenant-apps.md), each with its own protocol preferences and configuration.

## Supported endpoints and protocols

Microsoft Entra ID provides tenant-specific endpoints. Apps use these endpoints for authentication and token requests.

**[OpenID Connect endpoints](~/identity-platform/v2-protocols-oidc.md)** follow standard OAuth 2.0 and OpenID Connect patterns. Their tenant-specific URLs include the tenant identifier. These endpoints handle authorization and token requests. They also publish discovery metadata, so apps can configure themselves automatically.

**[SAML configuration](~/identity-platform/single-sign-on-saml-protocol.md)** uses metadata-based discovery. Microsoft Entra ID publishes tenant-specific SAML metadata that lists the available endpoints, certificate information, and protocol capabilities. Apps read this metadata to configure their SAML settings automatically.

Both protocols use tenant-scoped endpoints, so each tenant has its own set of URLs for authentication. This isolation keeps each request in the right organizational context and makes sure tokens carry the correct tenant-specific information.

## Supported SSO patterns and flow initiation

Microsoft Entra ID supports service provider (SP) initiated flows for both [SAML](~/identity-platform/single-sign-on-saml-protocol.md) and OpenID Connect apps. In an SP-initiated flow, the user starts at the app. The app then redirects them to Microsoft Entra ID to sign in.

For SAML apps, Microsoft Entra ID also supports identity provider (IdP) initiated flows. The user starts from Microsoft Entra ID, such as the My Apps portal, and Microsoft Entra ID redirects them to the app with an assertion that's already authenticated.

OpenID Connect follows [OAuth 2.0 authorization flows](~/identity-platform/v2-oauth2-auth-code-flow.md). Web apps typically use the authorization code flow, and mobile and single-page apps use the flow that fits them.

## Next steps

Continue by planning how you'll integrate SSO with Microsoft Entra ID:

- [Plan your SSO integration approach](plan-sso-deployment.md)
