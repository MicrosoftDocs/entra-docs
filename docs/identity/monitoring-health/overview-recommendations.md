---
title: What are Microsoft Entra recommendations?
description: Provides a general overview of Microsoft Entra recommendations so you can keep your tenant secure and healthy.
author: shlipsey3
manager: femila
ms.service: entra-id
ms.topic: overview
ms.subservice: monitoring-health
ms.date: 05/30/2025
ms.author: sarahlipsey
ms.reviewer: jadedsouza 
ms.custom: sfi-ga-nochange
# Customer intent: As a Microsoft Entra administrator, I want guidance to so that I can keep my Microsoft Entra tenant in a healthy state.
---
# What are Microsoft Entra recommendations?

Keeping track of all the settings and resources in your tenant can be overwhelming. The Microsoft Entra recommendations feature helps monitor the status of your tenant so you don't have to. These recommendations help ensure your tenant is in a secure and healthy state while also helping you maximize the value of the features available in Microsoft Entra ID.

Microsoft Entra recommendations now include *Identity Secure Score* recommendations. These recommendations provide similar insights into the security of your tenant. For more information, see [What is Identity Secure Score](concept-identity-secure-score.md). 

All these Microsoft Entra recommendations provide you with personalized insights with actionable guidance to:

- Help you identify opportunities to implement identity best practices.
- Improve the state of your Microsoft Entra tenant.
- Optimize the configurations for your scenarios.

This article gives you an overview of how you can use Microsoft Entra recommendations.

## How does it work?

On a daily basis, Microsoft Entra ID analyzes the configuration of your tenant. During this analysis, Microsoft Entra ID compares the configuration of your tenant with security best practices and recommendation data. If a recommendation is flagged as applicable to your tenant, the recommendation appears in the **Recommendations** section of the Microsoft Entra identity overview area.

![Screenshot of the Overview page of the tenant with the Recommendations option highlighted.](./media/overview-recommendations/recommendations-overview.png) 

Each recommendation contains a description, a summary of the value of addressing the recommendation, and a step-by-step action plan. If applicable, impacted resources associated with the recommendation are listed, so you can resolve each affected area. If a recommendation doesn't have any associated resources, the impacted resource type is *Tenant level*, so your step-by-step action plan impacts the entire tenant and not just a specific resource.

## Recommendations overview table

The recommendations listed in the following table are currently available in public preview or general availability the types of resources addressed by the recommendation, and more. The license requirements for recommendations in public preview are subject to change. The table provides links to available documentation for those recommendations that required separate guidance.

| Recommendation | Impacted resources | Availability | Identity Secure Score | Target roles for email notifications |
| --- | --- | --- | --- | --- |
| AAD Connect Deprecated | Tenant | Preview | No | Hybrid Identity Administrator |
| Configure VPN integration | | Tenant | Preview | Yes | |
| [Convert per-user MFA to Conditional Access MFA](recommendation-turn-off-per-user-mfa.md) | Users | Generally available | No | Security Administrator |
| Designate more than one Global Administrator | Users | Generally available | Yes | Global Administrator |
| Do not allow users to grant consent to unreliable applications | Tenant | Generally available | Yes | Global Administrator |
| Do not expire passwords | Tenant | Generally available | Yes | Global Administrator |
| Edit misconfigured certificate templates access control lists | Applications | Preview | Yes | |
| Edit misconfigured enrollment agent certificate template | Applications | Preview | Yes | | 
| Enable password hash sync if hybrid | Tenant | Generally available | Yes | Hybrid Identity Administrator |
| Enable policy to block legacy authentication | Users | Generally available | Yes | Conditional Access Administrator, Security Administrator |
| Enable self-service password reset | Users | Generally available | Yes | Authentication Policy Administrator |
| Ensure all users can complete multifactor authentication | Users | Generally available | Yes | Conditional Access Administrator, Security Administrator |
| [Migrate applications from AD FS to Microsoft Entra ID](recommendation-migrate-apps-from-adfs-to-azure-ad.md) | Applications | Generally available | No | Application Administrator, Authentication Administrator Hybrid Identity Administrator |
| [Migrate applications from the retiring Azure AD Graph APIs to Microsoft Graph](recommendation-migrate-to-microsoft-graph-api.md) | Applications | Preview | No | Application Administrator |
| [Migrate from ADAL to MSAL](recommendation-migrate-from-adal-to-msal.md) | Applications | Generally available | No | Application Administrator |
| [Migrate from MFA server to Microsoft Entra MFA](recommendation-migrate-to-microsoft-entra-mfa.md) | Tenant | Generally Available | No | Global Administrator |
| [Migrate service principals from the retiring Azure AD Graph APIs to Microsoft Graph](recommendation-migrate-to-microsoft-graph-api.md) | Applications | Preview | No | Application Administrator |
| [Migrate to Microsoft Authenticator](recommendation-migrate-to-authenticator.md) | Users | Preview | No | Global Administrator | 
| [Minimize MFA prompts from known devices](recommendation-mfa-from-known-devices.md) | Users | Generally available | No | Global Administrator |
| Modify unsecure Kerberos delegations to prevent impersonation | Applications | Preview | Yes | |
| Protect all users with a sign-in risk policy | Users | Generally available | Yes | Conditional Access Administrator, Security Administrator |
| Protect all users with a user risk policy | Users | Generally available | Yes | Conditional Access Administrator, Security Administrator |
| Protect and manage local admin passwords with Microsoft LAPS | Users | Preview | Yes | |
| [Protect your tenant with Insider Risk Conditional Access policy](recommendation-insider-risk-condition.md) | Users | Generally available | Yes | Conditional Access Administrator, Security Administrator |
| Remove dormant accounts from sensitive groups | Users | Preview | Yes | |
| Remove unsafe permissions on sensitive Microsoft Entra Connect accounts | Users | Preview | Yes | | 
| [Remove unused applications](recommendation-remove-unused-apps.md) | Applications | Preview | No | Application Administrator |
| [Remove unused credentials from applications](recommendation-remove-unused-credential-from-apps.md) | Applications | Preview | No | Application Administrator |
| [Renew expiring application credentials](recommendation-renew-expiring-application-credential.md) | Applications | Preview | No | Application Administrator |
| [Renew expiring service principal credentials](recommendation-renew-expiring-service-principal-credential.md) | Applications | Preview | No | Application Administrator |
| Replace Enterprise or Domain Admin account for Microsoft Entra Connect AD DS Connector | Users | Preview | Yes | |
| Require MFA for administrative roles | Users | Generally available | Yes | Conditional Access Administrator, Security Administrator |
| Reversible passwords found in GPOs | Users | Preview | Yes | | 
| Review inactive users with Access Reviews | Users | Preview | No | Identity Governance Administrator |
| Rotate password for Entra Connect AD DS Connector account | Users | Preview | Yes | |
| Secure and govern your apps with automatic user and group provisioning | Applications | Preview | No | Application Administrator, IT Governance Administrator |
| Stop clear text credentials exposure | | Preview | Yes | |
| Stop weak cipher usage | Tenant | Preview | Yes | |
| Use least privileged administrative roles | Users | Generally available | Yes | Privileged Role Administrator |
| Verify App Publisher | Applications | Preview | No | Global Administrator |

Microsoft Entra only displays the recommendations that apply to your tenant, so you might not see all supported recommendations listed.

## Identity Secure Score

Your Identity Secure Score, which appears at the top of the page, is a numerical representation of the health of your tenant. Recommendations that apply to the Identity Secure Score are given individual scores in the table at the bottom of the page. You can filter the list of recommendations to only the Identity Secure Score recommendations using the **Security** filter card. Identity Secure Score recommendations include *secure score points*, which are calculated as an overall score based on several security factors.

These scores add up to generate your Identity Secure Score. For more information, see [What is Identity Secure Score](concept-identity-secure-score.md).

![Screenshot of the Identity Secure Score.](./media/overview-recommendations/identity-secure-score.png)

## Are Microsoft Entra recommendations related to Azure Advisor?

The Microsoft Entra recommendations feature is the Microsoft Entra specific implementation of [Azure Advisor](/azure/advisor/advisor-overview), which is a personalized cloud consultant that helps you follow best practices to optimize your Azure deployments. Azure Advisor analyzes your resource configuration and usage data to recommend solutions that can help you improve the cost effectiveness, performance, reliability, and security of your Azure resources.

Microsoft Entra recommendations use similar data to support you with the roll-out and management of Microsoft's best practices for Microsoft Entra tenants to keep your tenant in a secure and healthy state. The Microsoft Entra recommendations feature provides a holistic view into your tenant's security, health, and usage. 

## Email notifications (preview)

Microsoft Entra recommendations now generate email notifications when a new recommendation is generated. This new preview feature sends emails to a predetermined set of roles for each recommendation. For example, recommendations that are associated with the health of your tenant's applications are sent to users who have the Application Administrator role.

If your organization is using Privileged Identity Management (PIM), the recipients must be elevated to the role indicated in order to receive the email notification. If no one is actively assigned to the role, no emails are sent. For this reason, we recommend checking the recommendations regularly to ensure that you're aware of any new recommendations.