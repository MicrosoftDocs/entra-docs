---
title: Mandatory Microsoft Entra multifactor authentication (MFA) 
description: Plan for mandatory multifactor authentication for users who sign in to Azure and other management portals.
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 09/05/2024
ms.author: justinha
author: najshahid
manager: amycolannino
ms.reviewer: nashahid

# Customer intent: As an identity administrator, I want to plan for mandatory MFA for users who sign in to Azure portal.
---
# Planning for mandatory multifactor authentication for Azure and other admin portals 

At Microsoft, we're committed to providing our customers with the highest level of security. One of the most effective security measures available to them is multifactor authentication (MFA). [Research by Microsoft](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RW166lD) shows that MFA can block more than 99.2% of account compromise attacks. 

That's why, starting in 2024, we'll enforce mandatory multifactor authentication (MFA) for all Azure sign-in attempts. For more background about this requirement, check out our [blog post](https://aka.ms/azuremfablogpost). This topic covers which applications are affected and how to prepare for mandatory MFA.

## Scope of enforcement 
 
The scope of enforcement includes which applications plan to enforce MFA, when enforcement is planned to occur, and which accounts have a mandatory MFA requirement.

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

All users who sign into the [applications](#applications) listed previously to perform any Create, Read, Update, or Delete (CRUD) operation will require MFA when the enforcement begins. End users who access application, websites, or services hosted on Azure, but don't sign into the listed applications, aren't required to use MFA. The authentication requirements for end users are controlled by the application, website, or service owner. 

Workload identities, such as managed identities and service principals, aren't impacted by MFA enforcement. If user identities sign in as a service account to run automation (including scripts or other automated tasks), those user identities need to sign in with MFA once enforcement begins. User identities aren't recommended for automation. You should migrate those user identities to [workload identities](~/workload-id/workload-identities-overview.md). 

Break glass or emergency access accounts are also required to sign in with MFA once enforcement begins. We recommend updating these accounts to use [passkey (FIDO2)](~/identity/authentication/how-to-enable-passkey-fido2.md) or configure [certificate-based authentication](~/identity/authentication/how-to-certificate-based-authentication.md) for MFA. Both methods satisfy the MFA requirement. 

## Implementation
 
This requirement for MFA at sign-in is implemented by Azure. Microsoft Entra ID [sign-in logs](~/identity/monitoring-health/concept-sign-ins.md) will show it as the source of the MFA requirement. 

This requirement will be implemented on top of any access policies you’ve configured in your tenant. For example, if your organization chose to retain Microsoft’s [security defaults](~/fundamentals/security-defaults.md), and you currently have security defaults enabled, your users will see no change in behavior as MFA is already required for Azure management. If your tenant is using [Conditional Access](~/identity/conditional-access/overview.md) policies in Microsoft Entra and you already have a Conditional Access policy through which users sign into Azure with MFA, then your users will not see a change. Similarly, if you have existing more restrictive Conditional Access policies in place targeting Azure that require stronger authentication, such as phishing-resistant MFA, then those policies will continue to be enforced and your users will not see any changes.

## Enforcement phases 

The enforcement of MFA will roll out in two phases: 

- **Phase 1**: Starting in the second half of 2024, MFA will be required to sign in to the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center. The enforcement will gradually roll out to all tenants worldwide. This phase won't impact other Azure clients such as Azure CLI, Azure PowerShell, Azure mobile app, or IaC tools.  

- **Phase 2**: Beginning in early 2025, MFA enforcement gradually begins for sign in to Azure CLI, Azure PowerShell, Azure mobile app, and IaC tools. Some customers may use a user account in Microsoft Entra ID as a service account. It's recommended to migrate these user-based service accounts to [secure cloud based service accounts](/entra/architecture/secure-service-accounts) with [workload identities](~/workload-id/workload-identities-overview.md). 

## Notification channels 

Microsoft will notify all Microsoft Entra Global Administrators through the following channels: 

- Email: Global Administrators who have configured an email address will be informed by email of the upcoming MFA enforcement and the actions required to be prepared. 

- Service health notification: Global Administrators will receive a service health notification through the Azure portal, with the tracking ID of **4V20-VX0**. This notification contains the same information as the email. Global Administrators can also subscribe to receive service health notifications through email. 

- Portal notification: A notification appears in the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center when they sign in. The portal notification links to this topic for more information about the mandatory MFA enforcement. 

- Microsoft 365 message center: A message appears in the Microsoft 365 message center with the same information as the email and service health notification. 

## Prepare for multifactor authentication 

Regardless of any roles they have or don't have, all users who access the admin portals and Azure clients listed in [applications](#applications) must be set up to use MFA. All users who access any administration portal should use MFA. Use the following resources to set up MFA for your users. 

- For a tutorial about how to set up Microsoft Entra MFA, see [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](identity/authentication/tutorial-enable-azure-mfa.md).
- If you don’t require MFA in your tenant today, there are several options available to set it up (listed in preferred order): 
  - Use [Conditional Access](~/identity/conditional-access/overview.md) policies. Start in [report-only mode](~/identity/conditional-access/concept-conditional-access-report-only.md) and target **All users**. In report-only mode, don't configure exceptions. This configuration more closely mirrors the enforcement pattern of Microsoft Entra MFA program. 
    - [Microsoft administration portals](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#microsoft-admin-portals) (includes portals in scope for this Microsoft Entra MFA enforcement) 
    - [Require multifactor authentication](~/identity/conditional-access/concept-conditional-access-grant.md#require-multifactor-authentication) or if you want more granular control, use [authentication strengths](~/identity/conditional-access/concept-conditional-access-grant.md#require-authentication-strength)
  - If you sign in to the Microsoft 365 admin center, use the [MFA wizard for Microsoft Entra ID](https://aka.ms/EntraIDMFAWizard).
  - If you don;t have a Microsoft Entra ID P1 or P2 license, you can enable [security defaults](~/fundamentals/security-defaults.md).
  
Use the followng resources to find users whsign in with and without MFA: 

- To identify user sign-ins that are aren't protected by MFA, use the [Multifactor Authentication Gaps workbook](~/identity/monitoring-health/workbook-mfa-gaps.md).
- To export a list of users and their authentication methods, use [PowerShell](https://aka.ms/AzMFA).

Use these application IDs in your queries: 

- Azure portal: c44b4083-3bb0-49c1-b47d-974e53cbdf3c 
- Azure CLI: 04b07795-8ddb-461a-bbee-02f9e1bf7b46 
- Azure PowerShell: 1950a258-227b-4e31-a9cf-717495945fc2 
- Azure mobile app: 0c1307d4-29d6-4389-a11c-5cbe7f65d7fa 

### External authentication methods and identity providers 

Support for external MFA solutions is in preview with [external authentication methods](https://aka.ms/EAMAdminDocs), and can be used to meet the MFA requirement. The legacy Conditional Access custom controls preview won't satisfy the MFA requirement. You should migrate to the external authentication methods preview to use an external solution with Microsoft Entra ID.  

If you're using a federated Identity Provider (IdP), such as Active Directory Federation Services, and your MFA provider is integrated directly with this federated IdP, the federated IdP must be configured to send an MFA claim. 

## Request more time to prepare for enforcement 

We understand that some customers may need more time to prepare for this MFA requirement. Microsoft allows grace periods for customers with complex environments or technical barriers. 

Between 8/15/2024 and 10/15/2024, Global Administrators can go to the [Azure portal](https://aka.ms/managemfaforazure) to postpone the start date of enforcement for their tenant to 3/15/2025. Global Administrators must have [elevated access](https://aka.ms/enableelevatedaccess) before postponing the start date of MFA enforcement on this page.  

Global Administrators must perform this action for every tenant for which they would like to postpone the start date of enforcement.  

By postponing the start date of enforcement, you take extra risk because accounts that access Microsoft services like the Azure portal are highly valuable targets for threat actors. We recommend all tenants set up MFA now to secure cloud resources.  

## FAQs

**Question**: If the tenant is only used for testing, is MFA required? 

**Answer**: Yes, every Azure tenant will require MFA, there are no exceptions. 

**Question**: When will I learn that I need to enable MFA for Azure portal? 

**Answer**: Microsoft will notify Global Administrators about the expected enforcement date of your tenant(s) by email and through Azure Service Notifications, 60 days in advance. The countdown for enforcement for your tenant(s) does not begin until you have received this first notification from us.

**Question**: Will I be able to opt out? 

There is no default opt out process. This security motion is critical to all safety and security of the Azure platform and is being repeated across cloud vendors. See AWS announcement. 
 
We will allow a grace period for select customers with use cases where no workarounds are easily available and who need additional time (beyond the start date of enforcement for their tenants) to prepare for the MFA requirement at Azure sign-in. The first notification from us stating the enforcement date for your tenant(s) will also include a link to apply for the grace period. Additional details on customer types, use cases and scenarios that are eligible for grace period will be included in the notification. 

 
**Question**: Can I test MFA before Azure enforces the policy to ensure nothing breaks? 

**Answer**: Yes, the customer can test their MFA through the manual setup process for MFA. We encourage customers to set this up themselves and test, please work with your user community to extend their controls beyond the Azure portal and apply to CLI/API and other sign-ins. 
 

**Question**: What if I already has MFA enabled, what will happen next? 

**Answer**: Customers already requiring MFA for their users when accessing Azure portal will not experience any change in experience.  If you are only requiring MFA for a subset of users, then any users not already using MFA will now need to do so when signing in to Azure portal. 
 

**Question**: What if I have a "break glass" scenario? 

**Answer**: We recommend updating break glass accounts to use FIDO2 or certificate-based authentication (when configured as MFA) instead of relying only on a long password.  Both methods will satisfy the MFA requirements.
 

**Question**: What if I don’t receive an email about enabling MFA before it was enforced, and then I get locked-out. How should I resolve it?  

**Answer**: The user should not be locked out but received a messaging encouraging them to enable MFA with the MFA wizard. However, if the user is locked-out, there may be other issues that should be triaged using this procedure.  

 


## Next steps


Review the following topics to learn more about how tp configure and deploy MFA:

- [Secure sign-in events with Microsoft Entra multifactor](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Plan a Microsoft Entra multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
- [Phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md)
- [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) 
- [Authentication methods](~/identity/authentication/concept-authentication-methods.md)

