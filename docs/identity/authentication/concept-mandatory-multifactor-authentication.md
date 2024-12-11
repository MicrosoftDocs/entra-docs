---
title: Plan for mandatory Microsoft Entra multifactor authentication (MFA) 
description: Plan for mandatory multifactor authentication for users who sign in to Azure and other management portals.
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/03/2024
ms.author: justinha
author: najshahid
manager: amycolannino
ms.reviewer: nashahid, gkinasewitz

# Customer intent: As an identity administrator, I want to plan for mandatory MFA for users who sign in to Azure portal.
---
# Planning for mandatory multifactor authentication for Azure and other admin portals 

At Microsoft, we're committed to providing our customers with the highest level of security. One of the most effective security measures available to them is multifactor authentication (MFA). [Research by Microsoft](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RW166lD) shows that MFA can block more than 99.2% of account compromise attacks. 

That's why, starting in 2024, we'll enforce mandatory multifactor authentication (MFA) for all Azure sign-in attempts. For more background about this requirement, check out our [blog post](https://aka.ms/azuremfablogpost). This topic covers which applications and accounts are affected, how enforcement gets rolled out to tenants, and other common questions and answers.

There's no change for users if your organization already enforces MFA for them, or if they sign in with stronger methods like passwordless or passkey (FIDO2). To verify that MFA is enabled, see [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md). 

## Scope of enforcement 
 
The scope of enforcement includes which applications plan to enforce MFA, when enforcement is planned to occur, and which accounts have a mandatory MFA requirement.

### Applications 

| Application Name | App ID | Enforcement phase |
|------------------|---------------------------------------|------|
| [Azure portal](/azure/azure-portal/)     | c44b4083-3bb0-49c1-b47d-974e53cbdf3c  | Second half of 2024 |
| [Microsoft Entra admin center](https://aka.ms/MSEntraPortal) | c44b4083-3bb0-49c1-b47d-974e53cbdf3c | Second half of 2024 |
| [Microsoft Intune admin center](https://aka.ms/IntunePortal) | c44b4083-3bb0-49c1-b47d-974e53cbdf3c | Second half of 2024 |
| [Microsoft 365 admin center](https://admin.microsoft.com) | 00000006-0000-0ff1-ce00-000000000000 | Early 2025 |
| [Azure command-line interface (Azure CLI)](/cli/azure/) | 04b07795-8ddb-461a-bbee-02f9e1bf7b46 | Early 2025 |
| [Azure PowerShell](/powershell/azure/) | 1950a258-227b-4e31-a9cf-717495945fc2 | Early 2025 |
| [Azure mobile app](/azure/azure-portal/mobile-app/overview)  | 0c1307d4-29d6-4389-a11c-5cbe7f65d7fa | Early 2025 |
| [Infrastructure as Code (IaC) tools](/devops/deliver/what-is-infrastructure-as-code) | Use Azure CLI or Azure PowerShell IDs | Early 2025 | 

### Accounts 

All users who sign into the [applications](#applications) listed earlier to perform any Create, Read, Update, or Delete (CRUD) operation must complete MFA when the enforcement begins. Users aren't required to use MFA if they access other applications, websites, or services hosted on Azure. Each application, website, or service owner listed earlier controls the authentication requirements for users. 

Break glass or emergency access accounts are also required to sign in with MFA once enforcement begins. We recommend that you update these accounts to use [passkey (FIDO2)](~/identity/authentication/how-to-enable-passkey-fido2.md) or configure [certificate-based authentication](~/identity/authentication/how-to-certificate-based-authentication.md) for MFA. Both methods satisfy the MFA requirement. 

Workload identities, such as managed identities and service principals, aren't impacted by [either phase](#enforcement-phases) of this MFA enforcement. If user identities are used to sign in as a service account to run automation (including scripts or other automated tasks), those user identities need to sign in with MFA once enforcement begins. User identities aren't recommended for automation. You should migrate those user identities to [workload identities](~/workload-id/workload-identities-overview.md).

### Migrate user-based service accounts to workload identities

We recommend customers discover user accounts that are used as service accounts begin to migrate them to workload identities. 
Migration often requires updating scripts and automation processes to use workload identities. 

Review [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md) to identify all user accounts, including user accounts being used as service accounts, that sign in to the [applications](#applications).

For more information about how to migrate from user-based service accounts to workload identities for authentication with these applications, see: 

- [Sign into Azure with a managed identity using the Azure CLI](/cli/azure/authenticate-azure-cli-managed-identity)
- [Sign into Azure with a service principal using the Azure CLI](/cli/azure/authenticate-azure-cli-service-principal)
- [Sign in to Azure PowerShell non-interactively for automation scenarios](/powershell/azure/authenticate-noninteractive) includes guidance for both managed identity and service principal use cases

Some customers apply Conditional Access policies to user-based service accounts. You can reclaim the user-based license, and add a [workload identities](~/workload-id/workload-identities-overview.md) license to apply [Conditional Access for workload identities](~/identity/conditional-access/workload-identity.md). 

## Implementation
 
This requirement for MFA at sign-in is implemented for admin portals. Microsoft Entra ID [sign-in logs](~/identity/monitoring-health/concept-sign-ins.md) shows it as the source of the MFA requirement. 

Mandatory MFA for admin portals isn't configurable. It's implemented separately from any access policies that you configured in your tenant. 

For example, if your organization chose to retain Microsoft’s [security defaults](~/fundamentals/security-defaults.md), and you currently have security defaults enabled, your users don't see any changes as MFA is already required for Azure management. If your tenant is using [Conditional Access](~/identity/conditional-access/overview.md) policies in Microsoft Entra and you already have a Conditional Access policy through which users sign into Azure with MFA, then your users don't see a change. Similarly, any restrictive Conditional Access policies that target Azure and require stronger authentication, such as phishing-resistant MFA, continue to be enforced. Users don't see any changes.

## Enforcement phases 

The enforcement of MFA rolls out in two phases: 

- **Phase 1**: Starting in the second half of 2024, MFA will be required to sign in to the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center. The enforcement will gradually roll out to all tenants worldwide. This phase won't impact other Azure clients such as Azure CLI, Azure PowerShell, Azure mobile app, or IaC tools.  

- **Phase 2**: Beginning in early 2025, MFA enforcement gradually begins for sign in to Azure CLI, Azure PowerShell, Azure mobile app, and IaC tools. Some customers may use a user account in Microsoft Entra ID as a service account. It's recommended to migrate these user-based service accounts to [secure cloud based service accounts](/entra/architecture/secure-service-accounts) with [workload identities](~/workload-id/workload-identities-overview.md). 

## Notification channels 

Microsoft will notify all Microsoft Entra Global Administrators through the following channels: 

- Email: Global Administrators who configured an email address will be informed by email of the upcoming MFA enforcement and the actions required to be prepared. 

- Service health notification: Global Administrators receive a service health notification through the Azure portal, with the tracking ID of **4V20-VX0**. This notification contains the same information as the email. Global Administrators can also subscribe to receive service health notifications through email. 

- Portal notification: A notification appears in the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center when they sign in. The portal notification links to this topic for more information about the mandatory MFA enforcement. 

- Microsoft 365 message center: A message appears in the Microsoft 365 message center with message ID: **MC862873**. This message has the same information as the email and service health notification. 

After enforcement, a banner appears in Microsoft Entra multifactor authentication:

:::image type="content" border="true" source="media/concept-mandatory-multifactor-authentication/enforcement-banner.png" alt-text="Screenshot of a banner in Microsoft Entra multifactor authentication that shows mandatory MFA is enforced."

## External authentication methods and identity providers 

Support for external MFA solutions is in preview with [external authentication methods](https://aka.ms/EAMAdminDocs), and can be used to meet the MFA requirement. The legacy Conditional Access custom controls preview doesn't satisfy the MFA requirement. You should migrate to the external authentication methods preview to use an external solution with Microsoft Entra ID.  

If you're using a federated Identity Provider (IdP), such as Active Directory Federation Services, and your MFA provider is integrated directly with this federated IdP, the federated IdP must be configured to send an MFA claim. For more information, see [Expected inbound assertions for Microsoft Entra MFA](how-to-mfa-expected-inbound-assertions.md).

## Request more time to prepare for enforcement 

We understand that some customers may need more time to prepare for this MFA requirement. Microsoft is allowing customers with complex environments or technical barriers to postpone the enforcement for their tenants until March 15, 2025. 

Between August 15, 2024 and October 15, 2024, Global Administrators can go to the [Azure portal](https://aka.ms/managemfaforazure) to postpone the start date of enforcement for their tenant to March 15, 2025. Global Administrators must have [elevated access](https://aka.ms/enableelevatedaccess) before postponing the start date of MFA enforcement on this page.  

Global Administrators must perform this action for every tenant where they want to postpone the start date of enforcement.  

By postponing the start date of enforcement, you take extra risk because accounts that access Microsoft services like the Azure portal are highly valuable targets for threat actors. We recommend all tenants set up MFA now to secure cloud resources.  

## FAQs

**Question**: If the tenant is only used for testing, is MFA required? 

**Answer**: Yes, every Azure tenant will require MFA, there are no exceptions. 

**Question**: How does this requirement impact the Microsoft 365 admin center?

**Answer**: Mandatory MFA will roll out to the Microsoft 365 admin center starting early in 2025. Learn more about the mandatory MFA requirement for the Microsoft 365 admin center on the blog post [Announcing mandatory multifactor authentication for the Microsoft 365 admin center](https://techcommunity.microsoft.com/t5/microsoft-365-blog/microsoft-will-require-mfa-to-access-the-microsoft-365-admin/ba-p/4232568). 

**Question**: Is MFA mandatory for all users or only administrators? 


**Answer**: All users who sign in to any of the [applications](#applications) listed previously are required to complete MFA, regardless of any administrator roles that are activated or eligible for them, or any [user exclusions](~/identity/conditional-access/policy-all-users-mfa-strength.md#user-exclusions) that are enabled for them.

**Question**: Will I need to complete MFA if I choose the option to **Stay signed in**?

**Answer**: Yes, even if you choose **Stay signed in**, you're required to complete MFA before you can sign in to these [applications](#applications).

**Question**: Will the enforcement apply to B2B guest accounts?

**Answer**: Yes, MFA has to be adhered either from the partner resource tenant, or the user's home tenant if it's set up properly to send MFA claims to the resource tenant by using cross-tenant access. 

**Question**: How can we comply if we enforce MFA by using another identity provider or MFA solution, and we don't enforce by using Microsoft Entra MFA? 

**Answer**: The identity provider solution needs to be configured properly to send the multipleauthn claim to Microsoft Entra ID. For more information, see [Microsoft Entra multifactor authentication external method provider reference](concept-authentication-external-method-provider.md). 

**Question**: Will phase 1 or phase 2 of mandatory MFA impact my ability to sync with Microsoft Entra Connect or Microsoft Entra Cloud Sync?

**Answer**: No. The synchronization service account isn't affected by the mandatory MFA requirement. Only [applications](#applications) listed earlier require MFA for sign in. 

**Question**: Will I be able to opt out? 

There's no way to opt out. This security motion is critical to all safety and security of the Azure platform and is being repeated across cloud vendors. For example, see [Secure by Design: AWS to enhance MFA requirements in 2024](https://aws.amazon.com/blogs/security/security-by-design-aws-to-enhance-mfa-requirements-in-2024/). 
 
An option to postpone the enforcement start date is available for customers. Between August 15, 2024 and October 15, 2024, Global Administrators can go to the [Azure portal](https://aka.ms/managemfaforazure) to postpone the start date of enforcement for their tenant to March 15, 2025. Global Administrators must have [elevated access](https://aka.ms/enableelevatedaccess) before they postpone the start date of MFA enforcement on this page. They must perform this action for each tenant that needs postponement.
 
**Question**: Can I test MFA before Azure enforces the policy to ensure nothing breaks? 

**Answer**: Yes, you can [test their MFA](~/identity/authentication/tutorial-enable-azure-mfa.md#test-microsoft-entra-multifactor-authentication) through the manual setup process for MFA. We encourage you to set this up and test. If you use Conditional Access to enforce MFA, you can use Conditional Access templates to test your policy. For more information, see [Require multifactor authentication for admins accessing Microsoft admin portals](~/identity/conditional-access/policy-old-require-mfa-admin-portals.md). If you run a free edition of Microsoft Entra ID, you can enable [security defaults](~/fundamentals/security-defaults.md). 

**Question**: What if I already have MFA enabled, what happens next? 

**Answer**: Customers that already require MFA for their users who access the applications listed earlier don't see any change. If you only require MFA for a subset of users, then any users not already using MFA will now need to use MFA when they sign in to the applications. 

**Question**: How can I review MFA activity in Microsoft Entra ID? 

**Answer**: To review details about when a user is prompted to sign in with MFA, use the Microsoft Entra sign-ins report. For more information, see [Sign-in event details for Microsoft Entra multifactor authentication](howto-mfa-reporting.md).

**Question**: What if I have a "break glass" scenario? 

**Answer**: We recommend updating these accounts to use [passkey (FIDO2)](~/identity/authentication/how-to-enable-passkey-fido2.md) or configure [certificate-based authentication](~/identity/authentication/how-to-certificate-based-authentication.md) for MFA. Both methods satisfy the MFA requirement. 
 

**Question**: What if I don’t receive an email about enabling MFA before it was enforced, and then I get locked-out. How should I resolve it?  

**Answer**: Users shouldn't be locked out, but they may get a message that prompts them to enable MFA once enforcement for their tenant has started. If the user is locked out, there may be other issues. For more information, see [Account has been locked](https://support.microsoft.com/account-billing/account-has-been-locked-805e8b0d-4141-29b2-7b65-df6ff6c9ce27).  


## Related content

Review the following topics to learn more about how to configure and deploy MFA:

- [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md)
- [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Secure sign-in events with Microsoft Entra multifactor](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Plan a Microsoft Entra multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
- [Phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md)
- [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) 
- [Authentication methods](~/identity/authentication/concept-authentication-methods.md)

