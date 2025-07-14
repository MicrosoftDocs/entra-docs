---
title: Overview of the Microsoft Entra application gallery
description: Explore the Microsoft Entra application gallery for seamless SaaS integration with preconfigured SSO and user provisioning. Enhance cloud app deployment.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: overview
ms.date: 12/06/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: enterprise-apps, sfi-image-nochange
#customer intent: As an IT admin, I want to easily find and deploy pre-integrated SaaS applications from the Microsoft Entra application gallery, so that I can provide users with a seamless single sign-on experience and automate user provisioning.
---

# Overview of the Microsoft Entra application gallery

The Microsoft Entra application gallery is a collection of software as a service (SaaS) [applications](~/identity-platform/app-objects-and-service-principals.md) that are preintegrated with Microsoft Entra ID. The collection contains thousands of applications that make it easy to deploy and configure [single sign-on (SSO)](~/identity-platform/single-sign-on-saml-protocol.md) and [automated user provisioning](~/identity/app-provisioning/user-provisioning.md).

To find the gallery when signed into your tenant, browse to **Entra ID** > **Enterprise apps** > **All applications** > **New application**.

The applications available from the gallery follow the SaaS model that allows users to connect to and use cloud-based applications over the Internet. Common examples are email, calendaring, and office tools (such as Microsoft Office 365).

The following are benefits of using applications available in the gallery:

- Users find the best possible SSO experience for the application.
- Configuration of the application is simple and minimal.
- A quick search finds the needed application.
- Free, Basic, and Premium Microsoft Entra users can all use the application.
- Users can easily find [step-by-step configuration tutorials](~/identity/saas-apps/tutorial-list.md) that are available for onboarding gallery applications.

## Applications in the gallery

The gallery contains thousands of applications that are preintegrated into Microsoft Entra ID. When using the gallery, you choose from using applications from specific cloud platforms, featured applications, or you search for the application that you want to use.

### Search for applications

If you don’t find the application that you're looking for in the featured applications, you can search for a specific application by name.

:::image type="content" source="media/overview-application-gallery/search-applications.png" alt-text="Screenshot showing the search options on the Microsoft Entra application gallery pane in the Microsoft Entra admin center.":::

When searching for an application, you can also specify specific filters, such as single sign-on options, automated provisioning, and categories. 

- **Single sign-on options** – You can search for applications that support these SSO options: SAML, OpenID Connect (OIDC), Password, or Linked. For more information about these options, see [Plan a single sign-on deployment in Microsoft Entra ID](plan-sso-deployment.md).
- **User account management** – The only option available is [automated provisioning](~/identity/app-provisioning/user-provisioning.md).
- **Categories** – When an application is added to the gallery it can be classified in a specific category. Many categories are available such as **Business management**, **Collaboration**, or **Education**.

### Cloud platforms

Applications that are specific to major cloud platforms, such as AWS, Google, or Oracle can be found by selecting the appropriate platform.

:::image type="content" source="media/overview-application-gallery/cloud-applications.png" alt-text="Screenshot showing the cloud application options on the Microsoft Entra application gallery pane in the Microsoft Entra admin center.":::

### On-premises applications

There are five ways on-premises applications can be connected to Microsoft Entra ID. One is using Microsoft Entra application proxy for single sign-on. If your application supports single-sign on via SAML or Kerberos, then from the on-premises section of the Microsoft Entra gallery, you can undertake the following tasks:

- Configure Application Proxy to enable remote access to an on-premises application.
- Use the documentation to learn more about how to use Application Proxy to secure remote access to on-premises applications.
- Manage any private network connectors that you created.

:::image type="content" source="media/overview-application-gallery/on-premises-applications.png" alt-text="Screenshot showing the on-premises application options on the Microsoft Entra application gallery pane in the Microsoft Entra admin center.":::

If your application uses Kerberos and also requires group memberships, then you can populate Windows Server AD groups from corresponding groups in Microsoft Entra. For more information, see [group writeback with Microsoft Entra Cloud Sync](~/identity/hybrid/group-writeback-cloud-sync.md).

The second is using the provisioning agent to provision to an on-premises application that has its own user store and doesn't rely upon Windows Server AD. You can configure provisioning to [on-premises applications that support SCIM](../app-provisioning/on-premises-scim-provisioning.md), that use [SQL databases](../app-provisioning/on-premises-sql-connector-configure.md), that use an [LDAP directory](../app-provisioning/on-premises-ldap-connector-configure.md), or support a [SOAP or REST provisioning API](../app-provisioning/on-premises-web-services-connector.md).

The third is using Microsoft Entra Private Access, by configuring a Global Secure Access app for per-app connections. For more information, see [Learn about Microsoft Entra Private Access](/entra/global-secure-access/concept-private-access).

The fourth is to use the application's own connector. If you have [`SAP S/4HANA On-premise`](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-sap-s-4hana-on-premise), then provision users from Microsoft Entra ID to SAP Cloud Identity Directory. SAP Cloud Identity Services then provisions the users that are in the SAP Cloud Identity Directory into the downstream SAP applications, such as `SAP S/4HANA On-Premise`, through the SAP cloud connector. For more information, see [plan deploying Microsoft Entra for user provisioning with SAP source and target apps](../app-provisioning/plan-sap-user-source-and-target.md).

The fifth is to use a third party integration technology. In cases where an application doesn't support standards such as SCIM, partners have custom ECMA connectors and SCIM gateways to integrate Microsoft Entra ID with more applications, including on-premises applications. For more information, see the list of [available partner-driven integrations](../app-provisioning/partner-driven-integrations.md#available-partner-driven-integrations).

### Featured applications

A collection of featured applications is listed by default when you open the Microsoft Entra gallery. Each application is marked with a symbol to enable you to identify whether it supports federated SSO or automated provisioning.

:::image type="content" source="media/overview-application-gallery/featured-applications.png" alt-text="Screenshot showing the featured applications on the Microsoft Entra application gallery pane in the Microsoft Entra admin center.":::

- **Federated SSO** - When you set up [SSO](what-is-single-sign-on.md) to work between multiple identity providers, it results to federation. An SSO implementation based on federation protocols improves security, reliability, user experiences, and implementation. Some applications implement federated SSO as SAML-based or as OIDC-based. For SAML applications, when you select create, the application is added to your tenant. For OIDC applications, the administrator must first sign up or sign-in on the application's website to add the application to Microsoft Entra ID.
- **Provisioning** - Microsoft Entra ID to SaaS [application provisioning](~/identity/app-provisioning/user-provisioning.md) refers to automatically creating user identities and roles in the SaaS applications that users need access to.

## Create your own application

When you select the **Create your own application** link near the top of the pane, you see a new pane that lists the following choices:

- **Register an application to integrate with Microsoft Entra ID (App you’re developing)** – This choice is meant for developers who want to work on the integration of their application that uses OpenID Connect with Microsoft Entra ID. This choice doesn’t provide an opportunity to publish your application to the gallery. It’s only for development purposes to work on integration.
- **Integrate any other application you don’t find in the gallery (Non-gallery)** – This choice is meant for an administrator to make a SAML-based application that isn't in the gallery available to users in their organization. By integrating the application, the administrator can configure, secure, and monitor its use. This choice doesn’t provide a way to publish the application to the gallery. It does provide secure access to the application for users in your tenant.
- **Configure Application Proxy for secure remote access to an on-premises application** – This choice is meant for an administrator to enable SSO and secure remote access for web applications hosted on-premises by connecting with Application Proxy.

## Request new gallery application

After you successfully integrate an application with Microsoft Entra ID and thoroughly tested it, you file a request for it to be added to the gallery. Publishing an application to the gallery from the portal isn't supported but there's a process that you can follow to request it to be added. For more information about publishing to the gallery, select [Request new gallery application](~/identity/enterprise-apps/v2-howto-app-gallery-listing.md).

## Next steps

- Get started by adding your first enterprise application with the [Quickstart: Add an enterprise application](add-application-portal.md).
