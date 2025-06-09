---
title: Sign-in risk-based multifactor authentication
description: Create Conditional Access policies using Microsoft Entra ID Protection sign-in risk.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: lhuangnorth, cokoopma
---
# Require multifactor authentication for elevated sign-in risk

Most users have a normal behavior that can be tracked, when they fall outside of this norm it could be risky to allow them to just sign in. You might want to block that user or maybe ask them to perform multifactor authentication to prove that they're really who they say they are. 

A sign-in risk represents the probability that a given authentication request isn't the identity owner. Organizations with Microsoft Entra ID P2 licenses can create Conditional Access policies incorporating [Microsoft Entra ID Protection sign-in risk detections](~/id-protection/concept-identity-protection-risks.md). 

The Sign-in risk-based policy protects users from registering MFA in risky sessions. If users aren't registered for MFA, their risky sign-ins are blocked, and they see an AADSTS53004 error.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Enable with Conditional Access policy

[!INCLUDE [conditional-access-policy-sign-in-risk](../../includes/conditional-access-policy-sign-in-risk.md)]

## Related content

- [Require reauthentication every time](~/identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
- [Remediate risks and unblock users](~/id-protection/howto-identity-protection-remediate-unblock.md)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [User risk-based Conditional Access](policy-risk-based-user.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions](concept-conditional-access-report-only.md)
