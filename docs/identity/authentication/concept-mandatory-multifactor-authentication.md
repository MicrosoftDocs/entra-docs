---
title: Mandatory Microsoft Entra multifactor authentication (MFA) 
description: Plan for mandatory multifactor authentication for users who sign in to Azure and other management portals
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 08/14/2024
ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: nashahid

# Customer intent: As an identity administrator, I want to plan for mandatory MFA for users who sign in to Azure portal.
---
# Planning for mandatory multifactor authentication for Azure and other administration portals 

At Microsoft, we're committed to providing our customers with the highest level of security. That's why, starting in 2024, we'll enforce mandatory multifactor authentication (MFA) for all Azure sign-in attempts. This topic covers which applications are affected and how to prepare for manadatory MFA. 

## Scope of enforcement 

This section covers applications and accounts that have a mandatory MFA requirement.

### Applications 

| Application Name | App ID | Enforcement phase |
|------------------|---------------------------------------|------|
| [Azure portal](/azure/azure-portal/)     | c44b4083-3bb0-49c1-b47d-974e53cbdf3c  | Second half of 2024 |
| [Microsoft Entra admin center](https://aka.ms/MSEntraPortal) | c44b4083-3bb0-49c1-b47d-974e53cbdf3c | Second half of 2024 |
| [Microsoft Intune admin center](https://aka.ms/IntunePortal) | c44b4083-3bb0-49c1-b47d-974e53cbdf3c | Second half of 2024 |
| [Azure command-line interface (Azure CLI)](/cli/azure/) | 04b07795-8ddb-461a-bbee-02f9e1bf7b46 | Early 2025 |
| [Azure PowerShell](/powershell/azure/) | 1950a258-227b-4e31-a9cf-717495945fc2 | Early 2025 |
| [Azure mobile app](/azure/azure-portal/mobile-app/overview)  | 0c1307d4-29d6-4389-a11c-5cbe7f65d7fa | Early 2025 |
| [Infrastructure as Code (IaC) tools](/devops/deliver/what-is-infrastructure-as-code) | Use Azure CLI or Azure PowerShell IDs | Early 2025 | 

### Accounts 

All users who sign into the [applications](#applications) listed previously to perform any Create, Read, Update, or Delete (CRUD) operation will require MFA when the enforcement begins. End users who access application, websites, or services hosted on Azure, but don't sign into the listed applications, aren't required to use MFA. The authentication requirements for end users is controlled by the application, website, or service owner. 

Workload identities, such as managed identities and service principals, aren't impacted by MFA enforcement. If user identities sign in as a service account to run automation (including scripts or other automated tasks), those user identities need to sign in with MFA once enforcement begins. User identities aren't recommended for automation. You should migrate those user identities to [workload identities](~/workload-id/workload-identities-overview.md). 

Break glass or emergency access accounts are also required to sign in with MFA once enforcement begins. We recommend updating these accounts to use passkey (FIDO2) or configure certificate-based authentication for MFA. Both methods satisfy the MFA requirement. 

## Enforcement phases 

The enforcement of MFA will roll out in two phases: 

- **Phase 1**: Starting in the second half of 2024, MFA will be required to sign in to the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center. The enforcement will gradually roll out to all tenants worldwide. This phase will not impact other Azure clients such as Azure CLI, Azure PowerShell, Azure mobile app, or IaC tools.  

- **Phase 2**: Beginning in early 2025, MFA enforcement gradually begins for sign in to Azure CLI, Azure PowerShell, Azure mobile app, and IaC tools. Some customers may use a user account in Entra ID as a service account. It is recommended to migrate these user-based service accounts to [secure cloud based service accounts](/entra/architecture/secure-service-accounts) with [workload identities](~/workload-id/workload-identities-overview.md). 

## Notification channels 

Microsoft will notify all Microsoft Entra Global Administrators through the following channels: 

- Email: Global Administrators who have configured an email address will be informed by email of the upcoming MFA enforcement and the actions required to be prepared. 

- Service health notification: Global Administrators will receive a service health notification through the Azure portal, with the tracking ID of **4V20-VX0**. This notification will contain the same information as the email. Global Administrators can also subscribe to receive service health notifications through email. 

- Portal notification: Global Administrators will see a notification in the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center when they sign in. The portal notification links to this topic for more information about the mandatory MFA enforcement. 

- Microsoft 365 message center: Global Administrators will also see a message in the Microsoft 365 message center with the same information as the email and service health notification. 

## Prepare for multifactor authentication 

All users who access the admin portals and Azure clients listed in [applications](#applications) must be set up to use MFA. All users who access any administration portal should use MFA.

Use the resources below to set up MFA for your users: 

- Learn about [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) and the different [authentication methods](~/identity/authentication/concept-authentication-methods.md) available for use. 
- Enable users for one or more [MFA methods](~/identity/authentication/concept-authentication-methods.md)
- Prefer more secure [phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md) 
- If you don’t require MFA in your tenant today, there are several options available to set it up (listed in preferred order): 
  - Use [Conditional Access](~/identity/conditional-access/overview.md) policies (in [report-only mode](~/identity/conditional-access/concept-conditional-access-report-only.md) to start) targeting: 
    - All users 
      - While in report-only mode don't configure exceptions. This will more closely mirror the enforcement pattern of Azure MFA program. 
    - [Microsoft administration portals](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#microsoft-admin-portals) (includes portals in scope for this Azure MFA enforcement) 
    - [Require multifactor authentication](~/identity/conditional-access/concept-conditional-access-grant.md#require-multifactor-authentication) or if you want more granular control, use [authentication strengths](~/identity/conditional-access/concept-conditional-access-grant.md#require-authentication-strength)
  - Enable [Security defaults](~/fundamentals/security-defaults.md)
- Review information to help configure and deploy MFA:
  - [Secure sign-in events with Microsoft Entra multifactor ](~/identity/authentication/tutorial-enable-azure-mfa.md)
  - [Plan a Microsoft Entra multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
  - Learn about [phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md) in Microsoft Entra ID
  - Use the [MFA wizard for Microsoft Entra ID](https://aka.ms/EntraIDMFAWizard)
- Use the resources below to help you identify which users are signing into Azure with and without MFA: 
  - Use [PowerShell](https://aka.ms/AzMFA) to export a list of users and their authentication methods 
  - Use the [Multifactor Authentication Gaps workbook](~/identity/monitoring-health/workbook-mfa-gaps.md) 
  - Use these application IDs in your queries: 
    - Azure portal: c44b4083-3bb0-49c1-b47d-974e53cbdf3c 
    - Azure CLI: 04b07795-8ddb-461a-bbee-02f9e1bf7b46 
    - Azure PowerShell: 1950a258-227b-4e31-a9cf-717495945fc2 
    - Azure mobile app: 0c1307d4-29d6-4389-a11c-5cbe7f65d7fa 

### External authentication methods and identity providers 

Support for external MFA solutions is in preview with [external authentication methods](https://aka.ms/EAMAdminDocs), and can be used to meet the MFA requirement. The legacy Conditional Access custom controls preview won't satisfy the MFA requirement. You should migrate to the external authentication methods preview to use an external solution with Microsoft Entra ID.  

If you are using a federated Identity Provider (IdP), such as Active Directory Federation Services, and your MFA provider is integrated directly with this federated IdP, the federated IdP must be configured to send an MFA claim. 

## Requesting additional time to prepare for enforcement 

We understand that some customers may need more time to prepare for this MFA requirement. Microsoft allows grace periods for customers with complex environments or technical barriers. 

Between 8/15/2024 and 10/15/2024, Global Administrators can go to the [Azure portal](https://aka.ms/managemfaforazure) to postpone the start date of enforcement for their tenant to 3/15/2025. Global Administrators must have [elevated access](https://aka.ms/enableelevatedaccess) before postponing the start date of MFA enforcement on this page.  

Global Administrators must perform this action for every tenant for which they would like to postpone the start date of enforcement.  

By postponing the start date of enforcement, you take extra risk because accounts that access Microsoft services like the Azure portal are highly valueable targets for threat actors. We recommend all tenants up MFA now to secure cloud resources.  