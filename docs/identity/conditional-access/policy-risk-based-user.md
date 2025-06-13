---
title: User risk-based password change
description: Create Conditional Access policies using Microsoft Entra ID Protection user risk.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: lhuangnorth, cokoopma
---
# Require a secure password change for elevated user risk

Microsoft works with researchers, law enforcement, various security teams at Microsoft, and other trusted sources to find leaked username and password pairs. Organizations with Microsoft Entra ID P2 licenses can create Conditional Access policies incorporating [Microsoft Entra ID Protection user risk detections](~/id-protection/concept-identity-protection-risks.md). 

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Enable with Conditional Access policy

[!INCLUDE [conditional-access-policy-user-risk](../../includes/conditional-access-policy-user-risk.md)]

### Considerations for cloud and hybrid users

- Both cloud and hybrid users can complete a secure password change with SSPR only if they can perform MFA. For users that aren't registered, this option isn't available.
- Hybrid users can complete a password change from an on-premises or hybrid joined Windows device, when password hash synchronization and the [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting is enabled.

### Allow on-premises password reset to remediate user risks

If your organization has a hybrid environment, you can allow on-premises password changes to reset user risks with [password hash synchronization](../identity/hybrid/connect/whatis-phs.md). You must enable password hash synchronization *before* users can self-remediate in those scenarios.

- Risky hybrid users can self-remediate without administrator intervention. When the user changes their password on-premises, user risk is automatically remediated within Microsoft Entra ID Protection, resetting the current user risk state.
- Organizations can proactively deploy [user risk policies that require password changes](howto-identity-protection-configure-risk-policies.md#user-risk-policy-in-conditional-access) to protect their hybrid users. This option strengthens your organization's security posture and simplifies security management by ensuring that user risks are promptly addressed, even in complex hybrid environments.

> [!NOTE]
> Allowing on-premises password change to remediate user risk is an opt-in only feature. Customers should evaluate this feature before enabling it in production environments. We recommend customers secure the on-premises password change process. For example, require multifactor authentication before allowing users to change their password on-premises using a tool like [Microsoft Identity Manager's Self-Service Password Reset Portal](/microsoft-identity-manager/working-with-self-service-password-reset).

To allow on-premises password change to reset user risk:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator).
1. Browse to **Protection** > **Identity Protection** > **Settings**.
1. Check the box to **Allow on-premises password change to reset user risk** and select **Save**.

:::image type="content" source="media/howto-identity-protection-remediate-unblock/allow-on-premises-password-reset-user-risk.png" alt-text="Screenshot showing the location of the Allow on-premises password change to reset user risk checkbox." lightbox="media/howto-identity-protection-remediate-unblock/allow-on-premises-password-reset-user-risk.png":::

## Related content

- [Require reauthentication every time](~/identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
- [Remediate risks and unblock users](~/id-protection/howto-identity-protection-remediate-unblock.md)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [Sign-in risk-based Conditional Access](policy-risk-based-sign-in.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions](concept-conditional-access-report-only.md)

