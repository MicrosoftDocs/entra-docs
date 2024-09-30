---
title: Mandatory Microsoft Entra multifactor authentication (MFA) 
description: Plan for mandatory multifactor authentication for users who sign in to Azure and other management portals.
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 09/24/2024
ms.author: justinha
author: najshahid
manager: amycolannino
ms.reviewer: nashahid, gkinasewitz

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

Workload identities, such as managed identities and service principals, aren't impacted by [Phase 1](#enforcement-phases) of the MFA enforcement. If user identities sign in as a service account to run automation (including scripts or other automated tasks), those user identities need to sign in with MFA once enforcement begins. User identities aren't recommended for automation. You should migrate those user identities to [workload identities](~/workload-id/workload-identities-overview.md). 

Break glass or emergency access accounts are also required to sign in with MFA once enforcement begins. We recommend updating these accounts to use [passkey (FIDO2)](~/identity/authentication/how-to-enable-passkey-fido2.md) or configure [certificate-based authentication](~/identity/authentication/how-to-certificate-based-authentication.md) for MFA. Both methods satisfy the MFA requirement. 

## Implementation
 
This requirement for MFA at sign-in is implemented for admin portals. Microsoft Entra ID [sign-in logs](~/identity/monitoring-health/concept-sign-ins.md) shows it as the source of the MFA requirement. 

This requirement is implemented on top of any access policies you’ve configured in your tenant. For example, if your organization chose to retain Microsoft’s [security defaults](~/fundamentals/security-defaults.md), and you currently have security defaults enabled, your users don't see any changes as MFA is already required for Azure management. If your tenant is using [Conditional Access](~/identity/conditional-access/overview.md) policies in Microsoft Entra and you already have a Conditional Access policy through which users sign into Azure with MFA, then your users don't see a change. Similarly, any restrictive Conditional Access policies that target Azure and require stronger authentication, such as phishing-resistant MFA, continue to be enforced. Users don't see any changes.

## Enforcement phases 

The enforcement of MFA rolls out in two phases: 

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

- For a tutorial about how to set up Microsoft Entra MFA, see [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](~/identity/authentication/tutorial-enable-azure-mfa.md).
- If you don’t require MFA in your tenant today, there are several options available to set it up (listed in preferred order): 
  - Use [Conditional Access](~/identity/conditional-access/overview.md) policies. Start in [report-only mode](~/identity/conditional-access/concept-conditional-access-report-only.md) and target **All users**. In report-only mode, don't configure exceptions. This configuration more closely mirrors the enforcement pattern of Microsoft Entra MFA program. 
    - [Microsoft administration portals](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#microsoft-admin-portals) (includes portals in scope for this Microsoft Entra MFA enforcement) 
    - [Require multifactor authentication](~/identity/conditional-access/concept-conditional-access-grant.md#require-multifactor-authentication) or if you want more granular control, use [authentication strengths](~/identity/conditional-access/concept-conditional-access-grant.md#require-authentication-strength)
  - If you sign in to the Microsoft 365 admin center, use the [MFA wizard for Microsoft Entra ID](https://aka.ms/EntraIDMFAWizard).
  - If you don't have a Microsoft Entra ID P1 or P2 license, you can enable [security defaults](~/fundamentals/security-defaults.md). Users are prompted for MFA as needed, but you can't define your own rules to control the behavior.
  - If your license doesn't include Conditional Access and you don't want to use security defaults, you can configure [per-user MFA](~/identity/authentication/howto-mfa-userstates.md). When you enable users individually, they perform MFA each time they sign in. An Authentication Administrator can enable some exceptions.
  
Use the followng resources to find users who sign in with and without MFA: 

- To identify user sign-ins that aren't protected by MFA, use the [Multifactor Authentication Gaps workbook](~/identity/monitoring-health/workbook-mfa-gaps.md).
- To export a list of users and their authentication methods, use [PowerShell](https://aka.ms/AzMFA).

If you run queries to analyze user sign-ins, use the application IDs of the [applications](#applications) listed previously. 

### External authentication methods and identity providers 

Support for external MFA solutions is in preview with [external authentication methods](https://aka.ms/EAMAdminDocs), and can be used to meet the MFA requirement. The legacy Conditional Access custom controls preview won't satisfy the MFA requirement. You should migrate to the external authentication methods preview to use an external solution with Microsoft Entra ID.  

If you're using a federated Identity Provider (IdP), such as Active Directory Federation Services, and your MFA provider is integrated directly with this federated IdP, the federated IdP must be configured to send an MFA claim. 

## Request more time to prepare for enforcement 

We understand that some customers may need more time to prepare for this MFA requirement. Microsoft is allowing customers with complex environments or technical barriers to postpone the enforcement for their tenants until March 15, 2025. 

Between August 15, 2024 and October 15, 2024, Global Administrators can go to the [Azure portal](https://aka.ms/managemfaforazure) to postpone the start date of enforcement for their tenant to March 15, 2025. Global Administrators must have [elevated access](https://aka.ms/enableelevatedaccess) before postponing the start date of MFA enforcement on this page.  

Global Administrators must perform this action for every tenant for which they would like to postpone the start date of enforcement.  

By postponing the start date of enforcement, you take extra risk because accounts that access Microsoft services like the Azure portal are highly valuable targets for threat actors. We recommend all tenants set up MFA now to secure cloud resources.  

## FAQs

**Question**: If the tenant is only used for testing, is MFA required? 

**Answer**: Yes, every Azure tenant will require MFA, there are no exceptions. 

**Question**: Is MFA mandatory for all users or only administrators? 

**Answer**: All users who sign in to any of the [applications](#applications) listed previously are required to complete MFA, regardless of any adminstrator roles that are activated or eligible for them, or any [user exclusions](~/identity/conditional-access/policy-all-users-mfa-strength.md#user-exclusions) that are enabled for them.

**Question**: Will I need to complete MFA if I choose the option to Stay signed in?

**Answer**: Yes, even if you choose **Stay signed in**, you're required to complete MFA before you can sign in to any these [applications](#applications).

**Question**: Will the enforcement apply to B2B guest accounts?

**Answer**: Yes, MFA has to be adhered either from the partner resource tenant, or the user's home tenant if it's set up properly to send MFA claims to the resource tenant by using cross-tenant access. 

**Question**: How can we comply if we enforce MFA by using another identity provider or MFA solution, and we don't enforce by using Microsoft Entra MFA? 

**Answer**: The identity provider solution needs to be configured properly to send the multipleauthn claim to Entra ID. For more information, see [Microsoft Entra multifactor authentication external method provider reference](concept-authentication-external-method-provider.md). 

**Question**: Will phase 1 or phase 2 of mandatory MFA impact my ability to sync with Microsoft Entra Connect or Microsoft Entra Cloud Sync?

**Answer**: No. The syncronization service account isn't affected by the manadatory MFA requirement. Only [applications](#applications) listed previously require MFA for sign in. 

**Question**: Will I be able to opt out? 

There's no way to opt out. This security motion is critical to all safety and security of the Azure platform and is being repeated across cloud vendors. For example, see [Secure by Design: AWS to enhance MFA requirements in 2024](https://aws.amazon.com/blogs/security/security-by-design-aws-to-enhance-mfa-requirements-in-2024/). 
 
An option to postpone the enforcement start date is available for customers. Between August 15, 2024 and October 15, 2024, Global Administrators can go to the [Azure portal](https://aka.ms/managemfaforazure) to postpone the start date of enforcement for their tenant to March 15, 2025. Global Administrators must have [elevated access](https://aka.ms/enableelevatedaccess) before postponing the start date of MFA enforcement on this page and they must perform this action for every tenant for which they would like to postpone the start date of enforcement.

 
**Question**: Can I test MFA before Azure enforces the policy to ensure nothing breaks? 

**Answer**: Yes, you can [test their MFA](~/identity/authentication/tutorial-enable-azure-mfa.md#test-microsoft-entra-multifactor-authentication) through the manual setup process for MFA. We encourage you to set this up and test. If you use Conditional Access to enforce MFA, you can use Conditional Access templates to test your policy. For more information, see [Require multifactor authentication for admins accessing Microsoft admin portals](~/identity/conditional-access/policy-old-require-mfa-admin-portals.md). If you run a free edition of Microsoft Entra ID, you can enable [security defaults](~/fundamentals/security-defaults.md). 

**Question**: What if I already have MFA enabled, what happens next? 

**Answer**: Customers that already require MFA for their users who access the applications listed previously don't see any change. If you only require MFA for a subset of users, then any users not already using MFA will now need to use MFA when they sign in to the applications. 

**Question**: How can I review MFA activity in Microsoft Entra ID? 

**Answer**: To review details about when a user is prompted to sign-in with MFA, use the Microsoft Entra sign-ins report. For more information, see [Sign-in event details for Microsoft Entra multifactor authentication](howto-mfa-reporting.md).

**Question**: What if I have a "break glass" scenario? 

**Answer**: We recommend updating these accounts to use [passkey (FIDO2)](~/identity/authentication/how-to-enable-passkey-fido2.md) or configure [certificate-based authentication](~/identity/authentication/how-to-certificate-based-authentication.md) for MFA. Both methods satisfy the MFA requirement. 
 

**Question**: What if I don’t receive an email about enabling MFA before it was enforced, and then I get locked-out. How should I resolve it?  

**Answer**: Users should not be locked out, but they may get a message that prompts them to enable MFA once enforcement for their tenant has started. If the user is locked out, there may be other issues. For more information, see [Account has been locked](https://support.microsoft.com/en-us/account-billing/account-has-been-locked-805e8b0d-4141-29b2-7b65-df6ff6c9ce27).  


## Next steps


Review the following topics to learn more about how to configure and deploy MFA:

- [Secure sign-in events with Microsoft Entra multifactor](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Plan a Microsoft Entra multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
- [Phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md)
- [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) 
- [Authentication methods](~/identity/authentication/concept-authentication-methods.md)

