---
title: Submit a request to publish your application
description: Learn how to publish your application in Microsoft Entra application gallery.
ms.topic: how-to

ms.date: 10/09/2024
ms.reviewer: jeedes
ms.custom: kr2b-contr-experiment, enterprise-apps-article

#customer intent: As a developer, I want to learn about the requirement for submitting my application to the Microsoft Entra application gallery, so that it can be publicly available for users to add to their tenants.
---

# Submit a request to publish your application in Microsoft Entra application gallery

You can publish applications you develop in the Microsoft Entra application gallery, which is a catalog of thousands of apps. When you publish your applications, they're made publicly available for users to add to their tenants. For more information, see [Overview of the Microsoft Entra application gallery](overview-application-gallery.md).

To publish your application in the Microsoft Entra application gallery, you need to complete the following tasks:

- Make sure that you complete the prerequisites.
- Create and publish documentation.
- Submit your application.
- Join the Microsoft partner network.

> [!NOTE]
> We're currently not accepting new SSO or provisioning requests while we focus on the [Secure Future Initiative](https://www.microsoft.com/security/blog/topic/secure-future-initiative/). Update requests for SSO are processed on a case-by-case basis. We aren't updating any SCIM (System for Cross-domain Identity Management) based User Provisioning applications for now. Enabling SCIM based user provisioning for the existing gallery application is also treated as a new application request.


## Prerequisites
To publish your application in the gallery, you must first read and agree to specific [terms and conditions](https://azure.microsoft.com/support/legal/active-directory-app-gallery-terms/).
- Implement support for *single sign-on (SSO)*. To learn more about supported options, see [Plan a single sign-on deployment](plan-sso-deployment.md).
    - We won't be onboarding any Password single sign-on applications anymore. Your application should support any of the Federation Protocols as mentioned in the point below.
	- For federated applications (SAML/WS-Fed), the application should preferably support [software-as-a-service (SaaS) model](https://azure.microsoft.com/overview/what-is-saas/) but it isn't mandatory and it can be an on-premises application as well. Enterprise gallery applications must support multiple user configurations and not any specific user.
	- For OpenID Connect, most applications work well as a multitenant application implementing the [Microsoft Entra consent framework](~/identity-platform/application-consent-experience.md). Refer to [this](~/identity-platform/howto-convert-app-to-be-multi-tenant.md) link to convert the application into multitenant. If your application requires extra per-instance configuration, such as customers needing to control their own secrets and certificates or instance configuration then you can publish a single-tenant Open ID Connect application. This type of application publishing is also supported in the Entra ID App Gallery now. But recommended option is to have a multitenant application in a true SaaS model.

- Provisioning is optional yet highly recommended. To learn more about Microsoft Entra SCIM, see [build a SCIM endpoint and configure user provisioning with Microsoft Entra ID](~/identity/app-provisioning/use-scim-to-provision-users-and-groups).
  

- To implement support of SCIM 2.0 Provisioning follow this tutorial: [build a SCIM endpoint and configure user provisioning with Microsoft Entra ID](~/identity/app-provisioning/use-scim-to-provision-users-and-groups).

    - If you already support SCIM 2.0 in your application, then you must support client credentials flow for authentication in SCIM. We aren't onboarding applications that use Basic authentication, long lived bearer tokens or using code grants for authentication. We recommend you to use Client Credentials flow as articulated [here](~/identity/app-provisioning/use-scim-to-provision-users-and-groups#oauth-20-client-credentials-grant-flow)
    - Make sure that you're testing the SCIM implementation and client credentials authentication flow using SCIM Validator tool. You can learn more about it from here: [Use the SCIM validator tool to validate your SCIM endpoint](~/identity/app-provisioning/scim-validator-tool).
    - Additionally you also need to test the provisioning implementation using the non-gallery application in Microsoft Entra ID. You can also test the Client Credentials flow using non-gallery application template. You can learn more about it from here: [Test user provisioning with a non-gallery application]([https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/identity/app-provisioning/use-scim-to-provision-users-and-groups.md#getting-started]).

You can sign up for a free, test Development account. It's free for 90 days and you get all of the premium Microsoft Entra features with it. You can also extend the account if you use it for development work: [Join the Microsoft 365 Developer Program](/office/developer-program/microsoft-365-developer-program).

## Create and publish documentation

### Provide app documentation for your site

Ease of adoption is an important factor for those people that make decisions about enterprise software. Documentation that's clear and easy to follow helps your users adopt technology and it reduces support costs.

Create documentation that includes the following information at minimum:

- An introduction to your SSO functionality
    - Protocols
    - Version and SKU
    - List of supported identity providers with documentation links
- Licensing information for your application
- Role-based access control for configuring SSO
- SSO Configuration Steps
    - UI configuration elements for SAML (Simple Assertion Markup Language) with expected values from the provider
    - Service provider information to be passed to identity providers
- If you use OIDC/OAuth, a list of permissions required for consent, with business justifications. Please use the least privileged permissions for your scenario.
- Testing steps for pilot users
- Troubleshooting information, including error codes and messages
- Support mechanisms for users
- Details about your SCIM endpoint, including supported resources and attributes

### App documentation on the Microsoft site

When your SAML application is added to the gallery, documentation is created that explains the step-by-step process. For an example, see [Tutorials for integrating SaaS applications with Microsoft Entra ID](~/identity/saas-apps/tutorial-list.md). This documentation is created based on your submission to the gallery. You can easily update the documentation if you make changes to your application by using your GitHub account.

For Open ID Connect application, there's no application specific documentation. We have only the generic [tutorial](~/identity-platform/v2-protocols-oidc.md) for all the OpenID Connect applications.

## Submit your application

After you've tested that your application works with Microsoft Entra ID, submit your application request in the [Microsoft Application Network portal](https://microsoft.sharepoint.com/teams/apponboarding/Apps).

If you see a "Request Access" page, then fill in the business justification and select **Request Access**.

After your account is added, you can sign in to the Microsoft Application Network portal and submit the request by selecting the **Submit Request (ISV)** tile on the home page. If you see the "Your sign-in was blocked" error while logging in, see [Troubleshoot sign-in to the Microsoft Application Network portal](troubleshoot-app-publishing.md).

### Implementation-specific options

On the application **Registration** form, select the feature that you want to enable. Select **OpenID Connect & OAuth 2.0**, **SAML 2.0/WS-Fed**, or **Password SSO(UserName & Password)** depending on the feature that your application supports.

If you're implementing a [SCIM](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md) 2.0 endpoint for user provisioning, select **User Provisioning (SCIM 2.0)**. Download the schema to provide in the onboarding request. For more information, see [Export provisioning configuration and roll back to a known good state](~/identity/app-provisioning/export-import-provisioning-configuration.md). The schema that you configured is used when testing the non-gallery application to build the gallery application.

If you wish to register an MDM (Microsoft Device Management) application in the Microsoft Entra application gallery, select **Register an MDM app**.

You can track application requests by customer name at the Microsoft Application Network portal. For more information, see [Application requests by Customers](https://microsoft.sharepoint.com/teams/apponboarding/Apps/SitePages/AppRequestsByCustomers.aspx).

## Update or Remove the application from the Gallery

You can submit your application update request in the [Microsoft Application Network portal](https://microsoft.sharepoint.com/teams/apponboarding/Apps).

If you see a "Request Access" page, then fill in the business justification and select **Request Access**.

After the account is added, you can sign in to the Microsoft Application Network portal and submit the request by selecting the **Submit Request (ISV)** tile on the home page and select **Update my application’s listing in the gallery** and select one of the following options as per your choice -

* If you want to update an application's SSO feature, select **Update my application’s Federated SSO feature**.

* If you want to update Password SSO feature, select **Update my application’s Password SSO feature**.

* If you want to upgrade your listing from Password SSO to Federated SSO, select **Upgrade my application from Password SSO to Federated SSO**.

* If you want to update an MDM listing, select **Update my MDM app**.

* If you want to update an existing User Provisioning integration, select **Improve my application’s User Provisioning feature**.

* If you want to remove the application from Microsoft Entra application gallery, select **Remove my application listing from the gallery**.

If you see the **Your sign-in was blocked** error while logging in, see [Troubleshoot sign-in to the Microsoft Application Network portal](troubleshoot-app-publishing.md).

## Join the Microsoft partner network

The Microsoft Partner Network provides instant access to exclusive programs, tools, connections, and resources. To join the network and create your go-to-market plan, see [Reach commercial customers](https://partner.microsoft.com/explore/commercial#gtm).

## Next steps

- Learn more about managing enterprise applications with [What is application management in Microsoft Entra ID?](what-is-application-management.md)