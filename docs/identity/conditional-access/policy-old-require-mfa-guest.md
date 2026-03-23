---
title: Require MFA for guest users with Conditional Access
description: Create a custom Conditional Access policy requiring guest users perform multifactor authentication.
ms.topic: how-to
ms.date: 03/10/2026
ms.reviewer: lhuangnorth
---
# Require multifactor authentication for guest access

> [!WARNING]
> This article describes a Conditional Access policy that uses the **Require multifactor authentication** grant control. For external users who authenticate with Microsoft Entra ID, consider using **authentication strength** policies to specify which MFA methods are accepted. For more information, see [Require multifactor authentication strength for external users](policy-guests-mfa-strength.md). Authentication strength policies don't apply to email one-time passcode, SAML/WS-Fed, or Google federation users — for those scenarios, continue using the **Require multifactor authentication** grant control.

Require guest users perform multifactor authentication when accessing your organization's resources. Some organizations might be ready to move to stronger authentication methods for their guest users. These organizations might choose to implement a policy like the one described in the article [Require multifactor authentication strength for external users](policy-guests-mfa-strength.md).

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All guest and external users**
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
   1. Under **Exclude**, select any applications that don't require multifactor authentication.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require multifactor authentication**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Next steps

[Conditional Access templates](concept-conditional-access-policy-common.md)

[Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
