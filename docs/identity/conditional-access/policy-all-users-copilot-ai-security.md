---
title: Conditional Access protections for Generative AI
description: Protecting Gen AI services like Microsoft Security Copilot and Microsoft 365 Copilot with Conditional Access

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth
---
# Protect AI with Conditional Access policy

[Generative Artificial Intelligence (AI)](/ai/playbook/technology-guidance/generative-ai/) services like [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot) and [Microsoft 365 Copilot](/copilot/microsoft-365/) when used appropriately bring value to your organization. Protecting these services from misuse can be accomplished with existing features like Microsoft Entra Conditional Access policy.

Applying Conditional Access policy to these Generative AI services can be accomplished through your existing policies that target all resources for [all users](policy-all-users-mfa-strength.md), risky [users](policy-risk-based-user.md) or [sign-ins](policy-risk-based-sign-in.md), and users with [insider risk](policy-risk-based-insider-block.md). 

This article shows you how to target specific Generative AI services like Microsoft Security Copilot and Microsoft 365 Copilot for policy enforcement.

## Create targetable service principals using PowerShell

To individually target these Generative AI services, organizations must create the following service principals to make them available in the Conditional Access app picker. The following steps show how to add these service principals using the [New-MgServicePrincipal](/powershell/module/microsoft.graph.applications/new-mgserviceprincipal) cmdlet, part of the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation).

```PowerShell
# Connect with the appropriate scopes to create service principals
Connect-MgGraph -Scopes "Application.ReadWrite.All"

# Create service principal for the service Enterprise Copilot Platform (Microsoft 365 Copilot)
New-MgServicePrincipal -AppId fb8d773d-7ef8-4ec0-a117-179f88add510

# Create service principal for the service Security Copilot (Microsoft Security Copilot) 
New-MgServicePrincipal -AppId bb5ffd56-39eb-458c-a53a-775ba21277da
```

## Create Conditional Access policies

As an organization adopting services like Microsoft 365 Copilot and Microsoft Security Copilot, you want to ensure access is only by those users who meet your security requirements. For example:

- All users of Generative AI services must complete phishing-resistant MFA
- All users of Generative AI services must access from a compliant device when insider risk is moderate
- All users of Generative AI services are blocked when insider risk is elevated 

> [!TIP]
> The following Conditional Access policies target the [standalone experiences, not embedded experiences](/copilot/security/experiences-security-copilot#standalone-and-embedded-experiences).

### User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

### All users of Generative AI services must complete phishing-resistant MFA

The following steps help create a Conditional Access policy to require all users do multifactor authentication using the authentication strength policy.

> [!WARNING]
> If you use [external authentication methods](/entra/identity/authentication/how-to-authentication-external-method-manage), these are currently incompatible with authentication strength and you should use the **[Require multifactor authentication](concept-conditional-access-grant.md#require-multifactor-authentication)** grant control.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**
   1. Under **Exclude** select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, select:
   1. **Enterprise Copilot Platform** fb8d773d-7ef8-4ec0-a117-179f88add510 (Microsoft 365 Copilot)
   1. **Security Copilot** bb5ffd56-39eb-458c-a53a-775ba21277da (Microsoft Security Copilot)
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the built-in **Phishing-resistant MFA** authentication strength from the list.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

### All users of Generative AI services must access from a compliant device when insider risk is moderate

> [!TIP]
> Configure [adaptive protection](/purview/insider-risk-management-adaptive-protection) before you create the following policy.
> 
> Without a [compliance policy created in Microsoft Intune](/mem/intune/protect/create-compliance-policy) this Conditional Access policy will not function as intended. Create a compliance policy first and ensure you have at least one compliant device before proceeding.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**
   1. Under **Exclude**:
      1. Select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
      1. Select **Guest or external users** and choose the following:
         1. **B2B direct connect users**.
         1. **Service provider users**.
         1. **Other external users**.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, select:
   1. **Enterprise Copilot Platform** fb8d773d-7ef8-4ec0-a117-179f88add510 (Microsoft 365 Copilot)
   1. **Security Copilot** bb5ffd56-39eb-458c-a53a-775ba21277da (Microsoft Security Copilot)
1. Under **Conditions** > **Insider risk**, set **Configure** to **Yes**. 
   1. Under **Select the risk levels that must be assigned to enforce the policy**. 
      1. Select **Moderate**.
      1. Select **Done**.
1. Under **Access controls** > **Grant**.
   1. Select **Require device to be marked as compliant**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

### All users of Generative AI services are blocked when insider risk is elevated 

> [!TIP]
> Configure [adaptive protection](/purview/insider-risk-management-adaptive-protection) before you create the following policy.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**:
      1. Select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
      1. Select **Guest or external users** and choose the following:
         1. **B2B direct connect users**.
         1. **Service provider users**.
         1. **Other external users**.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, select:
   1. **Enterprise Copilot Platform** fb8d773d-7ef8-4ec0-a117-179f88add510 (Microsoft 365 Copilot)
   1. **Security Copilot** bb5ffd56-39eb-458c-a53a-775ba21277da (Microsoft Security Copilot)
1. Under **Conditions** > **Insider risk**, set **Configure** to **Yes**. 
   1. Under **Select the risk levels that must be assigned to enforce the policy**. 
      1. Select **Elevated**.
      1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related content

- [Manage Microsoft 365 for iOS and Android with Microsoft Intune](/intune/intune-service/apps/manage-microsoft-office#copilot-with-enterprise-data-protection)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
- [Secure Generative AI with Microsoft Entra](../../architecture/secure-generative-ai.md)
- [Microsoft Purview data security and compliance protections for generative AI apps](/purview/ai-microsoft-purview)
- [Considerations for Microsoft Purview AI Hub and data security and compliance protections for Copilot](/purview/ai-microsoft-purview-considerations)
- [Apply principles of Zero Trust to Microsoft Copilot](/security/zero-trust/copilots/zero-trust-microsoft-copilot)
- [Apply principles of Zero Trust to Microsoft 365 Copilot](/security/zero-trust/copilots/zero-trust-microsoft-365-copilot#step-2-deploy-or-validate-your-identity-and-access-policies)
- [Apply principles of Zero Trust to Microsoft Security Copilot](/security/zero-trust/copilots/zero-trust-microsoft-copilot-for-security)
