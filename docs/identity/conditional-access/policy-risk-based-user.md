---
title: Enforce Password Changes for Elevated User Risk
description: Learn how to create Conditional Access policies using Microsoft Entra ID Protection to enforce secure password changes for users with elevated risk.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 10/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth, cokoopma
---
# Require a secure password change for elevated user risk

Microsoft works with researchers, law enforcement, security teams at Microsoft, and other trusted sources to find leaked username and password pairs. Organizations with Microsoft Entra ID P2 licenses can create Conditional Access policies that incorporate [Microsoft Entra ID Protection user risk detections](~/id-protection/concept-identity-protection-risks.md). 

Use this policy with [Microsoft Entra Password Protection](../authentication/concept-password-ban-bad.md) to block known weak passwords, their variants, and specific terms in your organization. Using Microsoft Entra Password Protection ensures that changed passwords are stronger.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Enable with Conditional Access policy

[!INCLUDE [conditional-access-policy-user-risk](../../includes/conditional-access-policy-user-risk.md)]

## Related content

- [Require reauthentication every time](../../identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
- [Remediate risks and unblock users](../../id-protection/howto-identity-protection-remediate-unblock.md)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [Sign-in risk-based Conditional Access](policy-risk-based-sign-in.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions](concept-conditional-access-report-only.md)
- [Configure cross-tenant access settings](/entra/external-id/cross-tenant-access-settings-b2b-collaboration#to-change-inbound-trust-settings-for-mfa-and-device-claims)
