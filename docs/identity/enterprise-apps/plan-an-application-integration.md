---
title: Get started integrating Microsoft Entra ID with apps
description: This article is a getting started guide for integrating Microsoft Entra ID with on-premises applications, and cloud applications.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: concept-article

ms.date: 12/05/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: enterprise-apps

#customer intent: As an IT admin responsible for integrating applications with Microsoft Entra ID, I want to understand the process and requirements for integrating applications, so that I can successfully manage user access and authentication for these applications.
---

# Integrating Microsoft Entra ID with applications getting started guide

This article summarizes the process for integrating applications with Microsoft Entra ID. Each of the following sections contains a brief summary of a more detailed article so you can identify which parts of this getting started guide are relevant to you.

To download in-depth deployment plans, see [Next steps](#next-steps).

## Take inventory

Before integrating applications with Microsoft Entra ID, it's important to know where you are and where you want to go. The following questions are intended to help you think about your Microsoft Entra application integration project.

### Application inventory

- Where are all of your applications? Who owns them?
- What kind of authentication do your applications require?
- Who needs access to which applications?
- Do you want to deploy a new application?
  - Will you build it in-house and deploy it on an Azure compute instance?
  - Will you use one that is available in the Azure Application Gallery?

### User and group inventory

- Where do your user accounts reside?
  - On-premises Active Directory
  - Microsoft Entra ID
  - Within a separate application database that you own
  - In unsanctioned applications
  - All of the listed options
- What permissions and role assignments do individual users currently have? Do you need to review their access or are you sure that your user access and role assignments are appropriate now?
- Are groups already established in your on-premises Active Directory?
  - How are your groups organized?
  - Who are the group members?
  - What permissions/role assignments do the groups currently have?
- Will you need to clean up user/group databases before integrating? (This is an important question. Garbage in, garbage out.)

### Access management inventory

- How do you currently manage user access to applications? Does that need to change?  Have you considered other ways to manage access, such as with [Azure RBAC](/azure/role-based-access-control/role-assignments-portal) for example?
- Who needs access to what?

Maybe you don't have the answers to all of these questions up front but that's okay. This guide can help you answer some of those questions and make some informed decisions.

### Find unsanctioned cloud applications with Cloud Discovery

As mentioned the previous section, there might be applications that your organization manages until now. As part of the inventory process, it's possible to find unsanctioned cloud applications. See
[Set up Cloud Discovery](/defender-cloud-apps/set-up-cloud-discovery).

<a name='integrating-applications-with-azure-ad'></a>

## Integrating applications with Microsoft Entra ID

The following articles discuss the different ways applications integrate with Microsoft Entra ID, and provide some guidance.

- [Determining which Active Directory to use](~/fundamentals/whatis.md)
- [Using applications in the Azure application gallery](what-is-single-sign-on.md)
- [Integrating SaaS applications tutorials list](~/identity/saas-apps/tutorial-list.md)

<a name='capabilities-for-apps-not-listed-in-the-azure-ad-gallery'></a>

## Capabilities for apps not listed in the Microsoft Entra gallery

You can add any application that already exists in your organization, or any third-party application  from a vendor who isn't already part of the Microsoft Entra gallery. Depending on your [license agreement](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing), the following capabilities are available:

- Self-service integration of any application that supports [Security Assertion Markup Language (SAML) 2.0](https://wikipedia.org/wiki/SAML_2.0) identity providers (SP-initiated or IdP-initiated)
- Self-service integration of any web application that has an HTML-based sign-in page using [password-based SSO](./plan-sso-deployment.md#password-based-sso)
- Self-service connection of applications that use the [System for Cross-Domain Identity Management (SCIM) protocol for user provisioning](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md)
- Ability to add links to any application in the [Office 365 app launcher](https://support.microsoft.com/office/meet-the-microsoft-365-app-launcher-79f12104-6fed-442f-96a0-eb089a3f476a) or [My Apps](https://myapplications.microsoft.com/)

If you're looking for developer guidance on how to integrate custom apps with Microsoft Entra ID, see [Authentication Scenarios for Microsoft Entra ID](~/identity-platform/authentication-vs-authorization.md). When you develop an app that uses a modern protocol like [OpenId Connect/OAuth](~/identity-platform/v2-protocols.md) to authenticate users, register it with the Microsoft identity platform. You can register by using the [App registrations](~/identity-platform/quickstart-register-app.md) experience in the Azure portal.

### Authentication Types

Each of your applications might have different authentication requirements. With Microsoft Entra ID, signing certificates can be used with applications that use SAML 2.0, WS-Federation, or OpenID Connect Protocols and Password Single Sign On. For more information about application authentication types, see [Managing certificates for federated single sign-on in Microsoft Entra ID](./tutorial-manage-certificates-for-federated-single-sign-on.md) and [Password based single sign on](what-is-single-sign-on.md).

<a name='enabling-sso-with-azure-ad-app-proxy'></a>

### Enabling SSO with Microsoft Entra application proxy

With Microsoft Entra application proxy, you can provide access to applications located inside your private network securely, from anywhere and on any device. After you install a private network connector within your environment, it can be easily configured with Microsoft Entra ID.

### Integrating custom applications

If you want to add your custom application to the Azure Application Gallery, see [Publish your app to the Microsoft Entra app gallery](~/identity/enterprise-apps/v2-howto-app-gallery-listing.md).

## Managing access to applications

The following articles describe ways you can manage access to applications once they're integrated with Microsoft Entra ID using Microsoft Entra Connectors and Microsoft Entra ID.

- [Managing access to apps using Microsoft Entra ID](what-is-access-management.md)
- [Automating with Microsoft Entra Connectors](~/identity/app-provisioning/user-provisioning.md)
- [Assigning users to an application](./assign-user-or-group-access-portal.md)
- [Assigning groups to an application](./assign-user-or-group-access-portal.md)
- [Sharing accounts](~/identity/users/users-sharing-accounts.md)

## Next steps

For in-depth information, you can download Microsoft Entra deployment plans from [GitHub](~/architecture/deployment-plans.md). For gallery applications, you can download deployment plans for single sign-on, Conditional Access, and user provisioning through the [Microsoft Entra admin center](https://entra.microsoft.com).

To download a deployment plan from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
2. Select **Enterprise Applications** | **Pick an App** | **Deployment Plan**.
