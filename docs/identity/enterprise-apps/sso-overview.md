---
title: Single sign-on (SSO) in Microsoft Entra ID
description: Comprehensive hub for single sign-on including SAML and OIDC SSO for enterprise applications, seamless SSO for hybrid environments, and application proxy SSO for remote access.
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: hub-page
ms.date: 02/03/2026
ai-usage: ai-assisted
---

# Single sign-on (SSO) in Microsoft Entra ID

Single sign-on (SSO) enables users to sign in once and access multiple applications without re-entering credentials. Microsoft Entra ID supports multiple SSO methods for different scenarios: modern cloud applications, hybrid environments, on-premises applications, and legacy systems.

This guide helps you choose the right SSO approach for your scenario and provides comprehensive implementation guidance.

## Choose your SSO method

Different applications and environments require different SSO approaches. Understanding your scenario helps you select the right method.

### Common scenarios

| Scenario | Recommended approach | Key benefit |
|----------|---------------------|-------------|
| Integrate cloud or SaaS applications | [SAML or OIDC SSO](#configure-sso-for-enterprise-applications) | Standard protocols, broad compatibility |
| Enable SSO for hybrid-joined devices | [Seamless SSO](#enable-seamless-sso-for-hybrid-environments) | Transparent authentication using Kerberos |
| Publish on-premises apps for remote access | [Application Proxy SSO](#configure-application-proxy-sso) | Secure remote access with SSO |
| Support legacy apps without modern auth | [Password-based SSO](#password-based-sso) | Works with any app, password vaulting |
| Develop custom applications | [Integrate with Microsoft identity platform](#protocol-references-for-developers) | OAuth 2.0, OpenID Connect, SAML |
| Enterprise app from gallery | [Use pre-configured gallery app](#configure-sso-for-enterprise-applications) | Simplified setup, tested integrations |

### Compare SSO methods

| SSO Method | How it works | Best for | Requirements |
|------------|--------------|----------|--------------|
| **SAML 2.0** | XML-based token exchange | Enterprise apps, established SaaS apps | SAML 2.0 support in application |
| **OpenID Connect (OIDC)** | OAuth 2.0 extension with ID tokens | Modern cloud apps, mobile apps | OIDC support in application |
| **Seamless SSO** | Kerberos ticket via Microsoft Entra Connect | Hybrid environments, domain-joined devices | Active Directory, Microsoft Entra Connect |
| **Password-based** | Microsoft Entra stores and replays credentials | Legacy apps without federation support | Browser extension (for user access) |
| **Linked** | Link to existing SSO | Apps with external SSO, custom launchers | None (just provides link) |
| **Kerberos (App Proxy)** | Kerberos Constrained Delegation | On-premises apps via remote access | App Proxy connector, domain join |

### Decision guidance

**Use SAML SSO if:**
- You're integrating enterprise SaaS applications
- The application supports SAML 2.0
- You need rich claim customization
- The application is in the Microsoft Entra gallery

**Use OIDC SSO if:**
- You're building or integrating modern applications
- You need mobile or single-page application support
- You want simpler, more modern authentication flows
- The application supports OpenID Connect

**Use Seamless SSO if:**
- You have on-premises Active Directory
- You want transparent authentication for domain-joined devices
- You're using password hash sync or pass-through authentication
- You want to avoid federation infrastructure

**Use Application Proxy SSO if:**
- You need secure remote access to on-premises applications
- You want to avoid VPN for application access
- The application supports Kerberos or header-based authentication

## Configure SSO for enterprise applications

Set up SAML or OIDC-based SSO for cloud applications and SaaS apps. Microsoft Entra ID supports thousands of pre-integrated applications in the application gallery, enabling SSO configuration in minutes rather than hours of custom integration work.

### Get started with enterprise app SSO

| Article | Description |
|---------|-------------|
| [What is single sign-on in Microsoft Entra ID?](what-is-single-sign-on.md) | Overview of SSO concepts, methods, and scenarios supported by Microsoft Entra ID. |
| [Overview of the Microsoft Entra application gallery](overview-application-gallery.md) | Understand pre-integrated gallery applications with simplified SSO configuration. |
| [Five steps to integrate your apps with Microsoft Entra ID](../fundamentals/five-steps-to-full-application-integration.md) | Strategic guidance for planning and implementing application integration. |

### Configure SAML-based SSO

| Article | Description |
|---------|-------------|
| [Quickstart: Add an enterprise application](add-application-portal.md) | Add an application from the gallery or register a custom application. |
| [Enable SAML single sign-on for an enterprise application](add-application-portal-setup-sso.md) | Configure SAML 2.0 SSO including certificates, attributes, and claims. |
| [Quickstart: Create and assign a user account](add-application-portal-assign-users.md) | Assign users or groups to applications and manage access. |

### Configure OIDC-based SSO

| Article | Description |
|---------|-------------|
| [Configure OIDC SSO for gallery and custom applications](add-application-portal-setup-oidc-sso.md) | Set up OpenID Connect SSO for modern applications and APIs. |

### Troubleshoot enterprise app SSO

| Article | Description |
|---------|-------------|
| [Debug SAML-based single sign-on to applications](debug-saml-sso-issues.md) | Diagnose and resolve SAML token, certificate, and configuration issues. |

## Enable Seamless SSO for hybrid environments

Seamless SSO provides transparent authentication for domain-joined devices accessing cloud resources. This feature works with password hash synchronization or pass-through authentication to eliminate repeated sign-in prompts for users on corporate networks.

### Understand Seamless SSO

| Article | Description |
|---------|-------------|
| [Microsoft Entra Connect: Seamless single sign-on](../hybrid/connect/how-to-connect-sso.md) | Overview of Seamless SSO functionality, benefits, and how it integrates with hybrid identity. |
| [How Seamless Single Sign-On works](../hybrid/connect/how-to-connect-sso-how-it-works.md) | Technical details of Kerberos ticket exchange and authentication flow. |

### Deploy Seamless SSO

| Article | Description |
|---------|-------------|
| [Quickstart: Microsoft Entra seamless single sign-on](../hybrid/connect/how-to-connect-sso-quick-start.md) | Step-by-step guide to enable Seamless SSO in Microsoft Entra Connect. |

### Troubleshoot Seamless SSO

| Article | Description |
|---------|-------------|
| [Troubleshoot Seamless Single Sign-On](../hybrid/connect/tshoot-connect-sso.md) | Resolve common Seamless SSO issues including Kerberos errors and computer account problems. |

## Configure Application Proxy SSO

Publish on-premises applications for secure remote access with single sign-on. Application Proxy eliminates the need for VPNs by providing secure, authenticated access to internal applications through Microsoft Entra ID.

### Get started with Application Proxy

| Article | Description |
|---------|-------------|
| [Publish on-premises apps with Microsoft Entra application proxy](../app-proxy/overview-what-is-app-proxy.md) | Overview of Application Proxy architecture, scenarios, and SSO capabilities. |

### Configure Kerberos-based SSO

| Article | Description |
|---------|-------------|
| [Kerberos-based single sign-on (SSO) with application proxy](../app-proxy/how-to-configure-sso-with-kcd.md) | Configure Kerberos Constrained Delegation for on-premises application SSO. |
| [Use Kerberos for SSO with Microsoft Entra Private Access](../global-secure-access/how-to-configure-kerberos-sso.md) | Enable Kerberos SSO through Global Secure Access for Zero Trust network access. |

## Password-based SSO

Use password vaulting for applications that don't support federated SSO protocols.

### When to use password-based SSO

- Application has HTML-based sign-in page
- Application doesn't support SAML, OIDC, or other federation protocols  
- You need quick SSO solution without application changes
- Users access via My Apps portal or browser extension

> [!NOTE]
> Password-based SSO requires users to install the My Apps browser extension. Modern federation protocols (SAML/OIDC) are preferred when supported by the application.

## Advanced SSO scenarios

### Manage multi-tenant access

| Article | Description |
|---------|-------------|
| [Use tenant restrictions to manage access to SaaS apps](tenant-restrictions.md) | Control which external tenants users can access while maintaining SSO. |

### Device authentication and SSO

| Article | Description |
|---------|-------------|
| [Understanding Primary Refresh Token (PRT)](../devices/concept-primary-refresh-token.md) | Learn how PRTs enable SSO across applications and services on Windows devices. |

## Protocol references for developers

Implement SSO in custom applications using standard protocols.

### SAML protocol

| Article | Description |
|---------|-------------|
| [Single sign-on SAML protocol](../identity-platform/single-sign-on-saml-protocol.md) | Detailed SAML 2.0 authentication request and response format for Microsoft Entra ID. |
| [How Microsoft identity platform uses the SAML protocol](../identity-platform/saml-protocol-reference.md) | Overview of SAML protocol support in Microsoft identity platform. |

### OpenID Connect protocol

See the [Microsoft identity platform documentation](../identity-platform/v2-protocols-oidc.md) for OpenID Connect implementation guidance.

## Related content

### Authentication and identity

- [What is Microsoft Entra ID?](../fundamentals/whatis.md)
- [Microsoft Entra authentication methods](../authentication/concept-authentication-methods.md)
- [Microsoft Entra Conditional Access](../conditional-access/overview.md)

### Application management

- [What is application management?](what-is-application-management.md)
- [Application properties](application-properties.md)
- [Plan an application deployment](plan-an-application-integration.md)

### Hybrid identity

- [What is hybrid identity?](../hybrid/whatis-hybrid-identity.md)
- [Federation with Microsoft Entra ID](../hybrid/connect/federation-overview.md)
- [Password management in Microsoft Entra ID](../authentication/overview-sspr.md)
- [Microsoft Entra Connect installation guide](../hybrid/connect/how-to-connect-install-roadmap.md)
- [Choose the right authentication method](../hybrid/connect/choose-ad-authn.md)
