---
title: Microsoft Entra ID Protection to Detect Protected Resource Risks
description: Learn how identity administrators use real-time risk detection features in Microsoft Entra ID Protection to grant user access to protected resources.
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.service: entra-id-protection
ms.topic: concept-article
ms.date: 08/21/2025

#CustomerIntent: As an identity administrator, I want use real-time risk detection features in Microsoft Entra ID Protection so that I can grant user access to protected resources.
---
# Microsoft Entra ID Protection scenario: real-time risk detection for protected resources

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Entra ID Protection to detect, investigate, and remediate identity-based risks.

An overview of the guidance begins with [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-poc-guide-intro.md).

Detailed guidance continues with these scenarios:

- [Bring identity risk-related telemetry into security investigations](id-protection-poc-investigate.md)
- [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-poc-remediate.md)

This article helps identity administrators use real-time risk detection features in Microsoft Entra ID Protection to grant user access to protected resources. To set up your PoC for this scenario, begin with [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-poc-guide-intro.md). Then follow the detailed guidance in this article.

Perform the following steps for real-time risk detection with Microsoft Entra ID Protection:

1. [Configure risk policies](#configure-risk-policies).
1. [Investigate and remediate risks](#investigate-and-remediate-risks).
1. [Monitor and tune policies](#monitor-and-tune-policies).

## Configure risk policies

To [configure and enable risk policies](../id-protection/howto-identity-protection-configure-risk-policies.md), factor both types of [risk policies](../id-protection/concept-identity-protection-policies.md) in Microsoft Entra Conditional Access. If you enabled legacy risk policies in Microsoft Entra ID Protection, plan to [migrate them to Conditional Access](../id-protection/howto-identity-protection-configure-risk-policies.md#migrate-to-conditional-access).

1. Set up the following key foundational policies.

   - [User risk policy](../id-protection/howto-identity-protection-configure-risk-policies.md): Trigger actions (such as require a secure password change for high-risk users).
   - [Sign-in risk policy](../id-protection/howto-identity-protection-configure-risk-policies.md#sign-in-risk-policy-in-conditional-access): Evaluate each sign-in attempt and enforce controls such as multifactor authentication (MFA) or block access.
   - [MFA registration policy](../id-protection/howto-identity-protection-configure-mfa-policy.md): Ensure user enrollment in MFA before they become risky.
  
1. Test policies with nonadmin test users before you fully deploy your solution.
1. Automate your solution with Conditional Access and Microsoft-managed Conditional Access policies. Automation is critical for scaling protection across large environments.
1. Risk signals from Microsoft Entra ID Protection feed into [Conditional Access policies](../identity/conditional-access/policy-all-users-mfa-strength.md) and [Microsoft-managed Conditional Access policies](../identity/conditional-access/managed-policies.md). Consider these options for your scenario:

   - Require [MFA](../identity/authentication/tutorial-enable-azure-mfa.md) for sign-in risk or secure password reset for user risk [based on risk level](../identity/authentication/tutorial-risk-based-sspr-mfa.md).
   - To prevent lockouts, [exclude emergency access accounts](../identity/role-based-access-control/security-emergency-access.md).
   - [Apply policies to workload identities](../identity/conditional-access/workload-identity.md) like service principals.

## Investigate and remediate risks

To [investigate and remediate risks](../id-protection/howto-identity-protection-remediate-unblock.md), use the Microsoft Entra ID Protection dashboards and reports.

1. Review reports for [risky users](../id-protection/howto-identity-protection-investigate-risk.md#risky-users-report), [risky sign-ins](../id-protection/howto-identity-protection-investigate-risk.md#risky-sign-ins-report), and [risk detections](../id-protection/howto-identity-protection-investigate-risk.md#risk-detections-report).
1. To immediately view impact in sign-in logs, use the [Impact analysis of risk-based access policies workbook](../id-protection/workbook-risk-based-policy-impact.md). It helps you understand your environment before you enable policies that might block your users from signing in, require MFA, or perform a secure password change. It also provides you with a breakdown for the date range of the sign-ins that you select.
1. Begin [initial triage](../id-protection/howto-identity-protection-investigate-risk.md#initial-triage) of your findings. Take manual actions such as dismissing false positives or confirming compromise.
1. Make decisions based on the [investigation and risk remediation framework](../id-protection/howto-identity-protection-investigate-risk.md#investigation-and-risk-remediation-framework).
1. Use [Microsoft Graph PowerShell](../id-protection/howto-identity-protection-graph-api.md) or APIs for bulk actions.

For deeper analysis, [export risk data](../id-protection/howto-export-risk-data.md) to security information and event management (SIEM) tools (such as Microsoft Sentinel) or [Log Analytics](../id-protection/howto-export-risk-data.md#log-analytics).

## Monitor and tune policies

Monitor the impact of policies using these features:

1. Use the [Impact analysis of risk-based access policies workbook](../id-protection/workbook-risk-based-policy-impact.md) for trend analysis.
1. To simulate policy effects, enable [report-only mode in Conditional Access](../identity/conditional-access/concept-conditional-access-report-only.md).
1. To manage user risk and risk detections, configure automated [Microsoft Entra ID Protection notifications](../id-protection/howto-identity-protection-configure-notifications.md), such as the users at risk detected email or weekly digest email.
1. To reduce false positives and improve the accuracy of Microsoft Entra ID Protection risk calculations for a specific tenant, configure named locations (such as VPN IP ranges).

## Next steps

- [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-poc-guide-intro.md)
- [Bring identity risk-related telemetry into security investigations](id-protection-poc-investigate.md)
- [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-poc-remediate.md)
