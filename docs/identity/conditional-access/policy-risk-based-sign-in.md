---
title: Sign-in risk-based multifactor authentication
description: Protect your organization by implementing Conditional Access policies that address sign-in risks using Microsoft Entra ID Protection.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 10/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth, cokoopma
---
# Require multifactor authentication for elevated sign-in risk

Most users have normal behavior that can be tracked. When their behavior falls outside this norm, it might be risky to let them sign in. You might want to block the user or ask them to complete multifactor authentication to confirm their identity. 

Sign-in risk represents the likelihood that an authentication request isn't from the identity owner. Organizations with Microsoft Entra ID P2 licenses can create Conditional Access policies incorporating [Microsoft Entra ID Protection sign-in risk detections](~/id-protection/concept-identity-protection-risks.md). 

The sign-in risk-based policy prevents users from registering MFA during risky sessions. If users aren't registered for MFA, their risky sign-ins are blocked, and they receive an AADSTS53004 error.

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
- [Configure cross-tenant access settings](/entra/external-id/cross-tenant-access-settings-b2b-collaboration#to-change-inbound-trust-settings-for-mfa-and-device-claims)
