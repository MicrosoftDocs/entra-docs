---
title: Understand the stages of migrating application authentication from AD FS to Microsoft Entra ID
description: Migrating application authentication from AD FS to Microsoft Entra ID in four stages. Plan your move, test configurations, and secure apps.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: concept-article

ms.date: 04/29/2025
ms.author: jomondi
ms.reviewer: alamaral
ms.custom: not-enterprise-apps

#customer intent: As an IT admin currently using AD FS for application authentication, I want to understand the stages and process of migrating to Microsoft Entra ID, so that I can plan and execute a successful migration and take advantage of the benefits provided by Microsoft Entra ID.
---

# Understand the stages of migrating application authentication from AD FS to Microsoft Entra ID

Microsoft Entra ID offers a universal identity platform that provides your people, partners, and customers a single identity to access applications and collaborate from any platform and device. Microsoft Entra ID has a full suite of identity management capabilities. Standardizing your application authentication and authorization to Microsoft Entra ID provides these benefits.

## Types of apps to migrate

Your applications might use modern or legacy protocols for authentication. When you plan your migration to Microsoft Entra ID, consider migrating the apps that use modern authentication protocols (such as SAML and OpenID Connect) first.

These apps can be reconfigured to authenticate with Microsoft Entra ID either via a built-in connector from the Azure App Gallery. They can also be reconfigured by registering the custom application in Microsoft Entra ID.

Apps that use older protocols can be integrated using [Application Proxy](~/identity/app-proxy/overview-what-is-app-proxy.md) or any of our [Secure Hybrid Access (SHA) partners](secure-hybrid-access-integrations.md).

For more information, see:

- [Using Microsoft Entra application proxy to publish on-premises apps for remote users](~/identity/app-proxy/overview-what-is-app-proxy.md).
- [What is application management?](what-is-application-management.md)
- [AD FS application activity report to migrate applications to Microsoft Entra ID](migrate-adfs-application-activity.md).
- [Monitor AD FS using Microsoft Entra Connect Health](~/identity/hybrid/connect/how-to-connect-health-adfs.md).

## The migration process

During the process of moving your app authentication to Microsoft Entra ID, test your apps and configuration. We recommend that you continue to use existing test environments for migration testing before you move to the production environment. If a test environment isn't currently available, you can set one up using [Azure App Service](https://azure.microsoft.com/services/app-service/) or [Azure Virtual Machines](https://azure.microsoft.com/free/virtual-machines/search/?OCID=AID2000128_SEM_lHAVAxZC&MarinID=lHAVAxZC_79233574796345_azure%20virtual%20machines_be_c__1267736956991399_kwd-79233582895903%3Aloc-190&lnkd=Bing_Azure_Brand&msclkid=df6ac75ba7b612854c4299397f6ab5b0&ef_id=XmAptQAAAJXRb3S4%3A20200306231230%3As&dclid=CjkKEQiAhojzBRDg5ZfomsvdiaABEiQABCU7XjfdCUtsl-Abe1RAtAT35kOyI5YKzpxRD6eJS2NM97zw_wcB), depending on the architecture of the application.

You might choose to set up a separate test Microsoft Entra tenant on which to develop your app configurations.

Your migration process might look like this:

### Stage 1 – Current state: The production app authenticates with AD FS

:::image type="content" source="media/migrate-adfs-apps-stages/stage-1.png" alt-text="Diagram showing migration stage 1.":::

### Stage 2 – (Optional) Point a test instance of the app to the test Microsoft Entra tenant

Update the configuration to point your test instance of the app to a test Microsoft Entra tenant, and make any required changes. The app can be tested with users in the test Microsoft Entra tenant. During the development process, you can use tools such as [Fiddler](https://www.telerik.com/fiddler) to compare and verify requests and responses.

If it isn't feasible to set up a separate test tenant, skip this stage and point a test instance of the app to your production Microsoft Entra tenant as described in Stage 3 below.

:::image type="content" source="media/migrate-adfs-apps-stages/stage-2.png" alt-text="Diagram showing migration stage 2.":::

### Stage 3 – Point a test instance of the app to the production Microsoft Entra tenant

Update the configuration to point your test instance of the app to your production Microsoft Entra tenant. You can now test with users in your production tenant. If necessary, review the section of this article on transitioning users.

:::image type="content" source="media/migrate-adfs-apps-stages/stage-3.png" alt-text="Diagram showing migration stage 3.":::

### Stage 4 – Point the production app to the production Microsoft Entra tenant

Update the configuration of your production app to point to your production Microsoft Entra tenant.

:::image type="content" source="media/migrate-adfs-apps-stages/stage-4.png" alt-text="Diagram showing migration stage 4.":::

 Apps that authenticate with AD FS can use Active Directory groups for permissions. Use [Microsoft Entra Connect Sync](~/identity/hybrid/connect/how-to-connect-sync-whatis.md) to sync identity data between your on-premises environment and Microsoft Entra ID before you begin migration. Verify those groups and membership before migration so that you can grant access to the same users when the application is migrated.

## Line of business apps

Your line-of-business apps are apps that your organization developed or apps that are a standard packaged product.

Line-of-business apps that use OAuth 2.0, OpenID Connect, or WS-Federation can be integrated with Microsoft Entra ID as [app registrations](~/identity-platform/quickstart-register-app.md). Integrate custom apps that use SAML 2.0 or WS-Federation as [non-gallery applications](add-application-portal.md) on the enterprise applications page in the [Microsoft Entra admin center](https://entra.microsoft.com/#home).

## Related content

[Configure SAML-based single sign-on](migrate-adfs-saml-based-sso.md).
