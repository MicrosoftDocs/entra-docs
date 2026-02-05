---
title: Require remediation for risky users
description: Create Conditional Access policies using Microsoft Entra ID Protection user risk.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 10/30/2025
ms.author: sarahlipsey
author: shlipsey3
manager: dougeby
ms.reviewer: lhuangnorth, cokoopma
---
# Require remediation for risky users

Organizations with Microsoft Entra ID P2 licenses can create Conditional Access policies incorporating [Microsoft Entra ID Protection user risk detections](~/id-protection/concept-identity-protection-risks.md). This policy enables end users to self-remediate and unblock themselves, increasing their productivity while reducing incidents sent to your help desk or security operations teams.  

## User exclusions

[!INCLUDE [entra-policy-exclude-user](../../includes/entra-policy-exclude-user.md)]

[!INCLUDE [entra-policy-deploy-template](../../includes/entra-policy-deploy-template.md)]

## Require risk remediation

This risk remediation policy covers both password-based and passwordless users.

[!INCLUDE [conditional-access-policy-user-risk](../../includes/conditional-access-policy-user-risk.md)]

## Related content

- [Require reauthentication every time](../../identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
- [Remediate risks and unblock users](../../id-protection/howto-identity-protection-remediate-unblock.md)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [Sign-in risk-based Conditional Access](policy-risk-based-sign-in.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions](concept-conditional-access-report-only.md)