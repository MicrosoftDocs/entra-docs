---
title: Require remediation for risky users
description: Create Conditional Access policies using Microsoft Entra ID Protection user risk.
ms.topic: how-to
ms.date: 10/06/2026
author: tilarso
ms.author: tilarso
ms.custom: msecd-doc-authoring-108
ai-usage: ai-assisted
#customer intent: As an administrator, I want to choose a user-risk remediation policy so that risky users can regain access through an appropriate remediation flow.
ms.reviewer: lhuangnorth, cokoopma
---
# Require remediation for risky users


## Overview

Organizations with Microsoft Entra ID P2 licenses can create Conditional Access policies incorporating [Microsoft Entra ID Protection user risk detections](~/id-protection/concept-identity-protection-risks.md). This policy enables end users to self-remediate and unblock themselves, increasing their productivity while reducing incidents sent to your help desk or security operations teams.  

## User exclusions

[!INCLUDE [entra-policy-exclude-user](../../includes/entra-policy-exclude-user.md)]

[!INCLUDE [entra-policy-deploy-template](../../includes/entra-policy-deploy-template.md)]

## Require risk remediation

This risk remediation policy covers both password-based and passwordless users.

[!INCLUDE [conditional-access-policy-user-risk](../../includes/conditional-access-policy-user-risk.md)]

## Remediate risk with identity verification

Identity verification provides a separate risk-remediation path. Before configuring the policy, [create an identity verification profile](../authentication/concept-authentication-verified-id.md#create-and-manage-identity-verification-profiles) with **Profile purpose** set to **All** or **Verification** and a provider and credential type that support your risk scenario. For tenant-issued credentials, select **Verification**. Use [Configure risk policies](../../id-protection/howto-identity-protection-configure-risk-policies.md) to configure the policy, test the user journey, and check the remediation outcome.

Review [Identity verification licensing](../../fundamentals/licensing.md#identity-verification) for the requirements that apply to this remediation path. Don't assume that the user-risk policy license requirement above covers every identity verification capability.

Don't substitute the **Require risk remediation** steps above for identity verification configuration. That control covers password-based and passwordless users and doesn't automatically use identity verification.

Use the risk conditions supported for identity verification in your tenant. Resource-access verification and risk remediation are different outcomes: check both the verification result and the applicable risk outcome in your pilot. Don't assume that every successful identity verification clears every risk state.

Preserve emergency access and approved user exclusions when configuring identity verification for risk remediation. Report-only mode evaluates which policies could apply without triggering identity verification. Don't interpret report-only results as actual identity verification or cleared risk. Conduct enforcement and remediation tests separately with approved pilot users before expanding scope.

## Related content

- [Require reauthentication every time](../../identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
- [Remediate risks and unblock users](../../id-protection/howto-identity-protection-remediate-unblock.md)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [Sign-in risk-based Conditional Access](policy-risk-based-sign-in.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions](concept-conditional-access-report-only.md)