---
title: Plan for mandatory Microsoft Entra multifactor authentication (MFA)
description: Plan for mandatory multifactor authentication for users who sign in to Azure and other management portals.
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 07/29/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: nashahid, gkinasewitz
ms.custom: sfi-ga-nochange
# Customer intent: As an identity administrator, I want to plan for mandatory MFA for users who sign in to Azure portal.
---
# Planning for mandatory multifactor authentication for Azure and other admin portals 

At Microsoft, we're committed to providing our customers with the highest level of security. One of the most effective security measures available to them is multifactor authentication (MFA). [Research by Microsoft](https://www.microsoft.com/security/blog/2019/08/20/one-simple-action-you-can-take-to-prevent-99-9-percent-of-account-attacks) shows that MFA can block more than 99.2% of account compromise attacks. 

That's why, starting in 2024, we'll enforce mandatory MFA for all Azure sign-in attempts. For more background about this requirement, see our [blog post](https://aka.ms/azuremfablogpost). This topic covers which applications and accounts are affected, how enforcement gets rolled out to tenants, and other common questions and answers.

> [!Important]
> If a user can't sign in to Azure and other admin portals after rollout of mandatory MFA, a Global Administrator can run a script to postpone the MFA requirement and allow users to sign in. For more information, see [How to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory multifactor authentication (MFA) requirement for the the Azure portal, Microsoft Entra admin center, or Microsoft Intune admin center](how-to-unlock-users-for-mandatory-multifactor-authentication.md).

There's no change for users if your organization already enforces MFA for them, or if they sign in with stronger methods like passwordless or passkey (FIDO2). To verify that MFA is enabled, see [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md). 

## Scope of enforcement 
 
The scope of enforcement includes when enforcement is planned to occur, which applications plan to enforce MFA, applications that are out of scope, and which accounts have a mandatory MFA requirement.

### Enforcement phases 

> [!NOTE]
> The date of enforcement for Phase 2 has changed to September 15, 2025.

The enforcement of MFA for applications rolls out in two phases. 

#### Applications that enforce MFA in phase 1 

Starting in October 2024, MFA is required for accounts that sign in to the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center to perform any Create, Read, Update, or Delete (CRUD) operation. The enforcement will gradually roll out to all tenants worldwide. Starting in February 2025, MFA enforcement gradually begins for sign in to Microsoft 365 admin center. Phase 1 won't impact other Azure clients such as Azure CLI, Azure PowerShell, Azure mobile app, or IaC tools.  

#### Applications that enforce MFA in phase 2 

Starting September 15, 2025, MFA enforcement will gradually begin for accounts that sign in to Azure CLI, Azure PowerShell, Azure mobile app, IaC tools, and REST API endpoints to perform any Create, Update, or Delete operation. Read operations won't require MFA. 

Some customers may use a user account in Microsoft Entra ID as a service account. It's recommended to migrate these user-based service accounts to [secure cloud based service accounts](/entra/architecture/secure-service-accounts) with [workload identities](~/workload-id/workload-identities-overview.md). 


### Applications

The following table lists affected apps, app IDs, and URLs for Azure. 

| Application Name | App ID | Enforcement starts |
|------------------|---------------------------------------|------|
| [Azure portal](/azure/azure-portal/)     | c44b4083-3bb0-49c1-b47d-974e53cbdf3c  | Second half of 2024 |
| [Microsoft Entra admin center](https://aka.ms/MSEntraPortal) | c44b4083-3bb0-49c1-b47d-974e53cbdf3c | Second half of 2024 |
| [Microsoft Intune admin center](https://aka.ms/IntunePortal) | c44b4083-3bb0-49c1-b47d-974e53cbdf3c | Second half of 2024 |
| [Azure command-line interface (Azure CLI)](/cli/azure/) | 04b07795-8ddb-461a-bbee-02f9e1bf7b46 | September 15, 2025 |
| [Azure PowerShell](/powershell/azure/) | 1950a258-227b-4e31-a9cf-717495945fc2 | September 15, 2025 |
| [Azure mobile app](/azure/azure-portal/mobile-app/overview)  | 0c1307d4-29d6-4389-a11c-5cbe7f65d7fa | September 15, 2025 |
| [Infrastructure as Code (IaC) tools](/devops/deliver/what-is-infrastructure-as-code) | Use Azure CLI or Azure PowerShell IDs | September 15, 2025 | 
| [REST API (Control Plane)](/azure/azure-resource-manager/management/control-plane-and-data-plane#control-plane) | N/A | September 15, 2025 | 
| [Azure SDK](/azure/developer/intro/azure-developer-create-resources#azure-sdk-and-rest-apis) | N/A | September 15, 2025 | 

The following table lists affected apps and URLs for Microsoft 365. 

| Application Name | URL | Enforcement starts |
|------------------|---------------------------------------|------|
| Microsoft 365 admin center | `https://portal.office.com/adminportal/home` | February 2025 |
| Microsoft 365 admin center | `https://admin.cloud.microsoft` | February 2025 |
| Microsoft 365 admin center | `https://admin.microsoft.com` | February 2025 |

### Accounts 

All accounts that sign in to perform operations cited in the [applications section](#applications) must complete MFA when the enforcement begins. Users aren't required to use MFA if they access other applications, websites, or services hosted on Azure. Each application, website, or service owner listed earlier controls the authentication requirements for users. 

Break glass or emergency access accounts are also required to sign in with MFA once enforcement begins. We recommend that you update these accounts to use [passkey (FIDO2)](~/identity/authentication/how-to-enable-passkey-fido2.md) or configure [certificate-based authentication](~/identity/authentication/how-to-certificate-based-authentication.md) for MFA. Both methods satisfy the MFA requirement. 

Workload identities, such as managed identities and service principals, aren't impacted by [either phase](#enforcement-phases) of this MFA enforcement. If user identities are used to sign in as a service account to run automation (including scripts or other automated tasks), those user identities need to sign in with MFA once enforcement begins. User identities aren't recommended for automation. You should migrate those user identities to [workload identities](~/workload-id/workload-identities-overview.md).

### Client libraries

The OAuth 2.0 Resource Owner Password Credentials (ROPC) token grant flow is incompatible with MFA. After MFA is enabled in your Microsoft Entra tenant, ROPC-based APIs used in your applications throw exceptions. For more information about how to migrate from ROPC-based APIs in [Microsoft Authentication Libraries (MSAL)](/entra/msal/), see [How to migrate away from ROPC](/entra/identity-platform/v2-oauth-ropc#how-to-migrate-away-from-ropc). For language-specific MSAL guidance, see the following tabs.

### [.NET](#tab/dotnet)

Changes are required if you use the [Microsoft.Identity.Client](https://www.nuget.org/packages/Microsoft.Identity.Client) package and one of the following APIs in your application. The public client API is **deprecated** [as of the 4.73.1 release](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet/blob/main/CHANGELOG.md):

- [IByUsernameAndPassword.AcquireTokenByUsernamePassword](/dotnet/api/microsoft.identity.client.ibyusernameandpassword.acquiretokenbyusernamepassword) (confidential client API)
- [PublicClientApplication.AcquireTokenByUsernamePassword](/dotnet/api/microsoft.identity.client.publicclientapplication.acquiretokenbyusernamepassword) (public client API) [deprecated]

### [Go](#tab/go)

Changes are required if you use the [microsoft-authentication-library-for-go](https://pkg.go.dev/github.com/AzureAD/microsoft-authentication-library-for-go) module and one of the following APIs in your application:

- [Client.AcquireTokenByUsernamePassword](https://pkg.go.dev/github.com/AzureAD/microsoft-authentication-library-for-go@v1.4.0/apps/confidential#Client.AcquireTokenByUsernamePassword) (confidential client API)
- [Client.AcquireTokenByUsernamePassword](https://pkg.go.dev/github.com/AzureAD/microsoft-authentication-library-for-go@v1.4.0/apps/public#Client.AcquireTokenByUsernamePassword) (public client API)

### [Java](#tab/java)

Changes are required if you use the [msal4j](https://central.sonatype.com/artifact/com.microsoft.azure/msal4j) package and the following API in your application:

[PublicClientApplication.acquireToken(UserNamePasswordParameters parameters)](/java/api/com.microsoft.aad.msal4j.publicclientapplication#com-microsoft-aad-msal4j-publicclientapplication-acquiretoken(com-microsoft-aad-msal4j-usernamepasswordparameters))

### [Node.js](#tab/js)

Changes are required if you use the [@azure/msal-node](https://www.npmjs.com/package/@azure/msal-node) package and one of the following APIs in your application. These APIs are [**deprecated** as of the `3.2.3` release](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-node/CHANGELOG.md#323-1).

- [ClientApplication.acquireTokenByUsernamePassword](/javascript/api/@azure/msal-node/clientapplication#@azure-msal-node-clientapplication-acquiretokenbyusernamepassword)
- [IConfidentialClientApplication.acquireTokenByUsernamePassword](/javascript/api/@azure/msal-node/iconfidentialclientapplication#@azure-msal-node-iconfidentialclientapplication-acquiretokenbyusernamepassword)
- [IPublicClientApplication.acquireTokenByUsernamePassword](/javascript/api/@azure/msal-node/ipublicclientapplication#@azure-msal-node-ipublicclientapplication-acquiretokenbyusernamepassword)

### [Python](#tab/python)

Changes are required if you use the [msal](https://pypi.org/project/msal/) package and the following API in your application:

[ClientApplication.acquire_token_by_username_password](/python/api/msal/msal.application.clientapplication#msal-application-clientapplication-acquire-token-by-username-password)

---

The same general MSAL guidance applies to the Azure Identity libraries. The `UsernamePasswordCredential` class provided in those libraries uses MSAL ROPC-based APIs. For language-specific guidance, see the following tabs.

### [.NET](#tab/dotnet)

Changes are required if you use the [Azure.Identity](https://www.nuget.org/packages/Azure.Identity) package and do one of the following things in your application:

- Use [DefaultAzureCredential](/dotnet/api/azure.identity.defaultazurecredential) or [EnvironmentCredential](/dotnet/api/azure.identity.environmentcredential) with the following two environment variables set:
    - `AZURE_USERNAME`
    - `AZURE_PASSWORD`
- Using `UsernamePasswordCredential` ([**deprecated** as of the `1.14.0-beta.2` release](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#1140-beta2-2025-03-11))

### [Go](#tab/go)

Changes are required if you use the [azidentity](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azidentity) module and do one of the following things in your application:

- Use [DefaultAzureCredential](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azidentity#DefaultAzureCredential) or [EnvironmentCredential](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azidentity#EnvironmentCredential) with the following two environment variables set:
    - `AZURE_USERNAME`
    - `AZURE_PASSWORD`
- Using [UsernamePasswordCredential](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azidentity#UsernamePasswordCredential) ([**deprecated** as of the `1.9.0` release](https://github.com/Azure/azure-sdk-for-go/blob/main/sdk/azidentity/CHANGELOG.md#190-2025-04-08))

### [Java](#tab/java)

Changes are required if you use the [azure-identity](https://central.sonatype.com/artifact/com.azure/azure-identity) package and do one of the following things in your application:

- Use [DefaultAzureCredential](/java/api/com.azure.identity.defaultazurecredential) or [EnvironmentCredential](/java/api/com.azure.identity.environmentcredential) with the following two environment variables set:
    - `AZURE_USERNAME`
    - `AZURE_PASSWORD`
- Using [UsernamePasswordCredential](/java/api/com.azure.identity.usernamepasswordcredential) ([**deprecated** as of the `1.16.0-beta.1` release](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#1160-beta1-2025-03-13))

### [Node.js](#tab/js)

Changes are required if you use the [@azure/identity](https://www.npmjs.com/package/@azure/identity) package and do one of the following things in your application:

- Use [DefaultAzureCredential](/javascript/api/@azure/identity/defaultazurecredential) or [EnvironmentCredential](/javascript/api/@azure/identity/environmentcredential) with the following two environment variables set:
    - `AZURE_USERNAME`
    - `AZURE_PASSWORD`
- Using [UsernamePasswordCredential](/javascript/api/@azure/identity/usernamepasswordcredential) ([**deprecated** as of the `4.8.0` release](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/identity/identity/CHANGELOG.md#480-2025-03-11))

### [Python](#tab/python)

Changes are required if you use the [azure-identity](https://pypi.org/project/azure-identity) package and do one of the following things in your application:

- Use [DefaultAzureCredential](/python/api/azure-identity/azure.identity.defaultazurecredential) or [EnvironmentCredential](/python/api/azure-identity/azure.identity.environmentcredential) with the following two environment variables set:
    - `AZURE_USERNAME`
    - `AZURE_PASSWORD`
- Using [UsernamePasswordCredential](/python/api/azure-identity/azure.identity.usernamepasswordcredential) ([**deprecated** as of the `1.21.0` release](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/identity/azure-identity/CHANGELOG.md#1210-2025-03-11))

---

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
 
This requirement for MFA at sign-in is implemented for admin portals and other [applications](#applications). Microsoft Entra ID [sign-in logs](~/identity/monitoring-health/concept-sign-ins.md) shows it as the source of the MFA requirement. 

Mandatory MFA isn't configurable. It's implemented separately from any access policies configured in the tenant. 

For example, if your organization chose to retain Microsoft's [security defaults](~/fundamentals/security-defaults.md), and you currently have security defaults enabled, your users don't see any changes as MFA is already required for Azure management. If your tenant is using [Conditional Access](~/identity/conditional-access/overview.md) policies in Microsoft Entra and you already have a Conditional Access policy through which users sign into Azure with MFA, then your users don't see a change. Similarly, any restrictive Conditional Access policies that target Azure and require stronger authentication, such as phishing-resistant MFA, continue to be enforced. Users don't see any changes.

## Notification channels 

Microsoft will notify all Microsoft Entra Global Administrators through the following channels: 

- Email: Global Administrators who configured an email address will be informed by email of the upcoming MFA enforcement and the actions required to be prepared. 

- Service health notification: Global Administrators receive a service health notification through the Azure portal, with the tracking ID of **4V20-VX0**. This notification contains the same information as the email. Global Administrators can also subscribe to receive service health notifications through email. 

- Portal notification: A notification appears in the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center when they sign in. The portal notification links to this topic for more information about the mandatory MFA enforcement. 

- Microsoft 365 message center: A message appears in the Microsoft 365 message center with message ID: **MC862873**. This message has the same information as the email and service health notification. 

After enforcement, a banner appears in the [Azure portal](https://aka.ms/managemfaforazure):

:::image type="content" border="true" source="media/concept-mandatory-multifactor-authentication/enforcement-banner.png" alt-text="Screenshot of a banner in Microsoft Entra multifactor authentication that shows mandatory MFA is enforced."

## External authentication methods and identity providers 

Support for external MFA solutions is in preview with [external authentication methods](https://aka.ms/EAMAdminDocs), and can be used to meet the MFA requirement. The legacy Conditional Access custom controls preview doesn't satisfy the MFA requirement. You should migrate to the external authentication methods preview to use an external solution with Microsoft Entra ID.

If you're using a federated Identity Provider (IdP), such as Active Directory Federation Services, and your MFA provider is integrated directly with this federated IdP, the federated IdP must be configured to send an MFA claim. For more information, see [Expected inbound assertions for Microsoft Entra MFA](how-to-mfa-expected-inbound-assertions.md).

## Request more time to prepare for Phase 1 MFA enforcement 

We understand that some customers may need more time to prepare for this MFA requirement. Microsoft allows customers with complex environments or technical barriers to postpone the enforcement of Phase 1 for their tenants until September 30, 2025. 

For each tenant where they want to postpone the start date of enforcement, a Global Administrator can go to the [https://aka.ms/managemfaforazure](https://aka.ms/managemfaforazure) to select a start date. 

>[!Caution]
>
>By postponing the start date of enforcement, you take extra risk because accounts that access Microsoft services like the Azure portal are highly valuable targets for threat actors. We recommend all tenants set up MFA now to secure cloud resources.

If you never previously signed in to the Azure portal with MFA, you're prompted to complete MFA to sign in, or postpone MFA enforcement. This screen is displayed only once. For more information about how to set up MFA, see [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md).

:::image type="content" border="true" source="media/concept-mandatory-multifactor-authentication/mandatory.png" alt-text="Screenshot of prompt to confirm mandatory MFA."

If you select **Postpone MFA**, the date of MFA enforcement will be one month in the future, or Sept 30, 2025, whichever is earlier. After you sign in, you can change the date at [https://aka.ms/managemfaforazure](https://aka.ms/managemfaforazure). To confirm that you want to proceed with the postponement request, click **Confirm postponement**. A Global Administrator must [elevate access](https://aka.ms/enableelevatedaccess) to postpone the start date of MFA enforcement.  

:::image type="content" border="true" source="media/concept-mandatory-multifactor-authentication/postpone.png" alt-text="Screenshot of how to postpone mandatory MFA."

## Request more time to prepare for Phase 2 MFA enforcement 

Microsoft allows customers with complex environments or technical barriers to postpone the enforcement of Phase 2 for their tenants until July 1st, 2026. You can request more time to prepare for Phase 2 MFA enforcement at [https://aka.ms/postponePhase2MFA](https://aka.ms/postponePhase2MFA). Choose another start date, and click **Apply**. 

>[!NOTE]
> If you postpone the start of Phase 1, the start of Phase 2 is also postponed to the same date. You can choose a later start date for Phase 2. 

:::image type="content" border="true" source="media/concept-mandatory-multifactor-authentication/postpone-phase-two.png" alt-text="Screenshot of how to postpone mandatory MFA for phase two."

## Prepare for Phase 2 MFA enforcement

To prepare for Phase 2 MFA enforcement, you can self-enforce MFA by using built-in definitions in Azure Policy. To learn more and follow a step-by-step overview to apply these policy assignments in your environment, see [Tutorial: Apply MFA self-enforcement through Azure Policy](/azure/governance/policy/tutorials/mfa-enforcement).

## FAQs

**Question**: If the tenant is only used for testing, is MFA required? 

**Answer**: Yes, every Azure tenant will require MFA, with no exception for test environments.  

**Question**: How does this requirement impact the Microsoft 365 admin center?

**Answer**: Mandatory MFA will roll out to the Microsoft 365 admin center starting in February 2025. Learn more about the mandatory MFA requirement for the Microsoft 365 admin center on the blog post [Announcing mandatory multifactor authentication for the Microsoft 365 admin center](https://techcommunity.microsoft.com/t5/microsoft-365-blog/microsoft-will-require-mfa-to-access-the-microsoft-365-admin/ba-p/4232568). 

**Question**: Is MFA mandatory for all users or only administrators? 

**Answer**: All users who sign in to any of the [applications](#applications) listed previously are required to complete MFA, regardless of any administrator roles that are activated or eligible for them, or any [user exclusions](~/identity/conditional-access/policy-all-users-mfa-strength.md#user-exclusions) that are enabled for them.

**Question**: Do I need to complete MFA if I choose the option to **Stay signed in**?

**Answer**: Yes, even if you choose **Stay signed in**, you're required to complete MFA before you can sign in to these [applications](#applications).

**Question**: Does the enforcement apply to B2B guest accounts?

**Answer**: Yes, MFA has to be adhered either from the partner resource tenant, or the user's home tenant if it's set up properly to send MFA claims to the resource tenant by using cross-tenant access. 

**Question**: Does the enforcement apply to Azure for US Government or Azure sovereign clouds?

**Answer**: Microsoft enforces mandatory MFA only in the public Azure cloud. Microsoft doesn't currently enforce MFA in Azure for US Government or other Azure sovereign clouds. 

**Question**: How can we comply if we enforce MFA by using another identity provider or MFA solution, and we don't enforce by using Microsoft Entra MFA? 

**Answer**: Third-party MFA can be integrated directly with Microsoft Entra ID. For more information, see [Microsoft Entra multifactor authentication external method provider reference](concept-authentication-external-method-provider.md). Microsoft Entra ID can be optionally configured with a federated Identity provider. If so, the identity provider solution needs to be configured properly to send the multipleauthn claim to Microsoft Entra ID. For more information, see [Satisfy Microsoft Entra ID multifactor authentication (MFA) controls with MFA claims from a federated IdP](how-to-mfa-expected-inbound-assertions.md). 

**Question**: Will mandatory MFA impact my ability to sync with Microsoft Entra Connect or Microsoft Entra Cloud Sync?

**Answer**: No. The synchronization service account isn't affected by the mandatory MFA requirement. Only [applications](#applications) listed earlier require MFA for sign in. 

**Question**: Will I be able to opt out? 

**Answer**: There's no way to opt out. This security motion is critical to all safety and security of the Azure platform and is being repeated across cloud vendors. For example, see [Secure by Design: AWS to enhance MFA requirements in 2024](https://aws.amazon.com/blogs/security/security-by-design-aws-to-enhance-mfa-requirements-in-2024/). 
 
An option to postpone the enforcement start date is available for customers. Global Administrators can go to the [Azure portal](https://aka.ms/managemfaforazure) to postpone the start date of enforcement for their tenant. Global Administrators must have [elevated access](https://aka.ms/enableelevatedaccess) before they postpone the start date of MFA enforcement on this page. They must perform this action for each tenant that needs postponement.
 
**Question**: Can I test MFA before Azure enforces the policy to ensure nothing breaks? 

**Answer**: Yes, you can [test their MFA](~/identity/authentication/tutorial-enable-azure-mfa.md#test-microsoft-entra-multifactor-authentication) through the manual setup process for MFA. We encourage you to set this up and test. If you use Conditional Access to enforce MFA, you can use Conditional Access templates to test your policy. For more information, see [Require multifactor authentication for admins accessing Microsoft admin portals](~/identity/conditional-access/policy-old-require-mfa-admin-portals.md). If you run a free edition of Microsoft Entra ID, you can enable [security defaults](~/fundamentals/security-defaults.md). 

**Question**: What if I already have MFA enabled, what happens next? 

**Answer**: Customers that already require MFA for their users who access the applications listed earlier don't see any change. If you only require MFA for a subset of users, then any users not already using MFA will now need to use MFA when they sign in to the applications. 

**Question**: How can I review MFA activity in Microsoft Entra ID? 

**Answer**: To review details about when a user is prompted to sign in with MFA, use the Microsoft Entra sign-in logs. For more information, see [Sign-in event details for Microsoft Entra multifactor authentication](howto-mfa-reporting.md).

**Question**: What if I have a "break glass" scenario?  

**Answer**: We recommend updating these accounts to use [passkey (FIDO2)](~/identity/authentication/how-to-enable-passkey-fido2.md) or configure [certificate-based authentication](~/identity/authentication/how-to-certificate-based-authentication.md) for MFA. Both methods satisfy the MFA requirement. 
 
**Question**: What if I don't receive an email about enabling MFA before it was enforced, and then I get locked-out. How should I resolve it? 

**Answer**: Users shouldn't be locked out, but they may get a message that prompts them to enable MFA once enforcement for their tenant has started. If the user is locked out, there may be other issues. For more information, see [Account has been locked](https://support.microsoft.com/account-billing/account-has-been-locked-805e8b0d-4141-29b2-7b65-df6ff6c9ce27).  


## Related content

Review the following topics to learn more about how to configure and deploy MFA:

- [How to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory multifactor authentication (MFA) requirement for the the Azure portal, Microsoft Entra admin center, or Microsoft Intune admin center](how-to-unlock-users-for-mandatory-multifactor-authentication.md)
- [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md)
- [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Secure sign-in events with Microsoft Entra multifactor](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Plan a Microsoft Entra multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
- [Phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md)
- [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) 
- [Authentication methods](~/identity/authentication/concept-authentication-methods.md)

