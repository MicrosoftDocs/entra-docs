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

## Related content

- [Require reauthentication every time](~/identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
- [Remediate risks and unblock users](~/id-protection/howto-identity-protection-remediate-unblock.md)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [Sign-in risk-based Conditional Access](policy-risk-based-sign-in.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions](concept-conditional-access-report-only.md)

