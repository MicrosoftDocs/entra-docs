---
title: SaaS App configuration guides for Microsoft Entra ID
description: Configure Microsoft Entra single sign-on integration with a variety of third-party software as a service application.

author: nguhiu
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: landing-page

ms.date: 05/20/2025
ms.author: gideonkiratu
ms.reviewer: celested

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directions on Microsoft so that I can control who has access to Directions on Microsoft, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# SaaS App configuration guides for Microsoft Entra ID

To help integrate your cloud-enabled [software as a service (SaaS)](https://azure.microsoft.com/overview/what-is-saas/) and on-premises applications with Microsoft Entra ID, we have developed a collection of articles that walk you through configuration.

For a list of all SaaS apps that have been preintegrated into Microsoft Entra ID, see the [Microsoft Entra Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/azure-active-directory-apps). For a list of applications that can be integrated with Microsoft Entra ID Governance, see [Microsoft Entra ID Governance integrations](~/id-governance/apps.md).

Microsoft Entra can be integrated with many other applications, using standards such as OpenID Connect, SAML, SCIM, SQL, and LDAP. If you're using an application that isn't listed, and it's a SaaS, then use the [application network portal](~/identity/enterprise-apps/v2-howto-app-gallery-listing.md) to request a [SCIM](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md) enabled application to be added to the gallery for automatic provisioning or a SAML / OIDC enabled application to be added to the gallery for SSO. For integration with other applications, see [integrating applications with Microsoft Entra ID](~/id-governance/identity-governance-applications-integrate.md).


## Quick links

Some of the popular integrations include the applications in the following table.

| Logo | Application article for single sign-on | Application article for user provisioning |
| :--- | :--- | :--- |
| ![logo-Atlassian Cloud](./media/tutorial-list/entra-saas-atlassian-cloud-tutorial.png)| [Atlassian Cloud](atlassian-cloud-tutorial.md)| [Atlassian Cloud - User Provisioning](atlassian-cloud-provisioning-tutorial.md)|
| ![logo-ServiceNow](./media/tutorial-list/entra-saas-servicenow-tutorial.png)| [ServiceNow](servicenow-tutorial.md)|[ServiceNow - User Provisioning](servicenow-provisioning-tutorial.md)|
| ![logo-Slack](./media/tutorial-list/entra-saas-slack-tutorial.png)| [Slack](slack-tutorial.md)|[Slack - User Provisioning](slack-provisioning-tutorial.md)|
| ![logo-SuccessFactors](./media/tutorial-list/entra-saas-successfactors-tutorial.png)| [SuccessFactors](successfactors-tutorial.md)| [SuccessFactors - User Provisioning](./sap-successfactors-inbound-provisioning-tutorial.md) |
| ![logo-Workday](./media/tutorial-list/entra-saas-workday-tutorial.png)| [Workday](workday-tutorial.md)| [Workday - User Provisioning](workday-inbound-tutorial.md)|

To find more articles for SaaS apps, use the table of contents on the left. The list is divided into single sign on and provisioning articles.

## Cloud Integrations

| Logo | Application article for single sign-on | Application article for user provisioning |
| :--- | :--- | :--- |
| ![logo-Amazon Web Services (AWS) Console](./media/tutorial-list/entra-saas-amazon-web-service-tutorial.png)| [Amazon Web Services (AWS) Console](amazon-web-service-tutorial.md)| [Amazon Web Services (AWS) Console - Role Provisioning](amazon-web-service-tutorial.md#configure-azure-ad-sso) |
| ![logo-Alibaba Cloud Service (Role based SSO)](./media/tutorial-list/entra-saas-alibaba-tutorial.png)| [Alibaba Cloud Service (Role based SSO)](alibaba-cloud-service-role-based-sso-tutorial.md)| |
| ![logo-Google Cloud Platform](./media/tutorial-list/entra-saas-google-apps-tutorial.png)| [Google Cloud Platform](google-apps-tutorial.md)| [Google Cloud Platform - User Provisioning](g-suite-provisioning-tutorial.md) |
| ![logo-Salesforce](./media/tutorial-list/entra-saas-salesforce-tutorial.png)| [Salesforce](salesforce-tutorial.md)| [Salesforce - User Provisioning](salesforce-provisioning-tutorial.md) |
| ![logo-SAP Cloud Identity Services](./media/tutorial-list/entra-saas-sapboc-tutorial.png)| [SAP Cloud Identity Services](sap-hana-cloud-platform-identity-authentication-tutorial.md)|[SAP Cloud Identity Services - Provisioning](./sap-cloud-platform-identity-authentication-provisioning-tutorial.md) |

## Related content

To learn more about application management, see [What is application management](~/identity/enterprise-apps/what-is-application-management.md).
