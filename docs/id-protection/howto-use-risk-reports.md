---
title: Reading the ID Protection Risk Reports
description: Learn how to access, filter, and use the Microsoft Entra ID Protection risk reports to mark users and sign-ins as risky or confirmed compromised.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 09/29/2025

author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera 
ms.reviewer: cokoopma
---
# How to read the ID Protection risk reports

Microsoft Entra ID Protection automatically remediates many risky sign-ins and users, but sometimes you need to investigate issues yourself. The reports in Identity Protection help you quickly identify and respond to potential threats. This article shows you how to read and use these reports more effectively.

## Access the risk reports

The ID Protection Dashboard provides a summary of important insights that you can use at any time to identify potential risks.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader).
1. Browse to **ID Protection** > **Dashboard**.
1. Select a report from the ID Protection navigation menu.

Each report launches with a list of all detections for the period shown at the top of the report. You can filter and add or remove columns based on your preference. Download the data in .CSV or .JSON format for further processing. To integrate the reports with SEIM tools for further analysis, see [Configure diagnostic settings](../identity/monitoring-health/howto-configure-diagnostic-settings.md).

## View details and take action

Select an entry in a report to view more details, which differ based on the report you're viewing. From the details pane you can also take action on the selected user or sign-in.  You can select one or multiple entries and either confirm the risk or dismiss it. You can also start a password reset flow from the user. These capabilities have different role requirements, so if an option is greyed out, you need a higher privileged role. For more information, see [ID Protection required roles](overview-identity-protection.md#required-roles).

### Risky users

The details of a selected risky user provide information on the risk that was remediated, dismissed, or is still currently at risk and needs investigation. You're also provided details about the associated risk detections.

A user becomes a risky user when:

- They have one or more risky sign-ins.
- They have one or more [risks](concept-identity-protection-risks.md) detected on their account, like leaked credentials.

> [!TIP]
> If you have Security Copilot, you have access to a **[summary in natural language](../fundamentals/copilot-entra-risky-user-summarization.md)** including: why the user risk level was elevated, guidance on how to mitigate and respond, and links to other helpful items or documentation. 

**Risky users details** include:
- User ID
- Recent risky sign-ins
- Detections not linked to a sign-in
- Risk history

The **Risk history tab** shows the events that led to a user risk change in the last 90 days. This list includes risk detections that increased the user's risk. It can also include user or admin remediation actions that lowered the user's risk; for example, a user resetting their password or an admin dismissing the risk.

[!INCLUDE [id-protection-admin-action-user](../includes/id-protection-admin-action-user.md)]

### Risky sign-ins

The Risky sign-ins report lists sign-ins that are at risk, confirmed compromised, confirmed safe, dismissed, or remediated. The details pane provides more information about the sign-in attempt that might help during an investigation, such as real-time and aggregate risk levels associated with sign-in attempts and the detection types triggered.

**Risky sign-ins details** include:
- The application the user was trying to access
- Conditional Access policies applied
- MFA details
- Device, application, and location information
- Risk state, risk level, and the source of the risk detection (ID Protection or Microsoft Defender for Endpoint)

The **Risky sign-ins report** contains filterable data for up to the past 30 days (one month). ID Protection evaluates risk for all authentication flows, whether it's interactive or non-interactive. The Risky sign-ins report shows both interactive and non-interactive sign-ins. To modify this view, use the "sign-in type" filter.

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-sign-ins-report.png" alt-text="Screenshot showing the Risky sign-ins report." lightbox="media/howto-identity-protection-investigate-risk/risky-sign-ins-report.png":::

[!INCLUDE [id-protection-admin-action-sign-in](../includes/id-protection-admin-action-sign-in.md)]

To learn more about when to take each of these actions, see [How does Microsoft use my risk feedback](howto-identity-protection-risk-feedback.md#how-does-microsoft-use-my-risk-feedback)

### Risky Workload IDs

A [workload identity](../workload-id/workload-identities-overview.md) is an identity that allows an application access to resources, sometimes in the context of a user. From the Risky Workload ID details page you can access service principal sign-in and audit logs for further analysis.

> [!IMPORTANT]
> Full risk details and risk-based access controls are available to Workload Identities Premium customers; however, customers without the **[Workload Identities Premium](../workload-id/workload-identities-faqs.md)** licenses still receive all detections with limited reporting details.

**Risky Workload IDs details** include:
- Service principal ID
- Risk state and risk level
- Risk history

### Risk detections

The Risk detections report provides insights into the various risk detections associated with users and sign-ins. This includes information about the type of risk detected, the user or sign-in it pertains to, and the current status of the risk. From the details pane you can also access the associated user risk report, the user's sign-ins, and risk detections.

**Risk detections details** include:
- Detection type
- Risk state, risk level, and risk detail
- Attack type
- Source of the risk detection (ID Protection or Microsoft Defender for Endpoint)

The Risk detections report contains filterable data for up to the past 90 days (three months).

:::image type="content" source="media/howto-identity-protection-investigate-risk/risk-detections-report.png" alt-text="Screenshot showing the Risk detections report." lightbox="media/howto-identity-protection-investigate-risk/risk-detections-report.png":::

With the information provided by the Risk detections report, administrators can find:

- Information about each risk detection
- Attack type based on MITRE ATT&CK framework
- Other risks triggered at the same time
- Sign-in attempt location
- Link out to more detail from Microsoft Defender for Cloud Apps.

Administrators can then choose to return to the user's risk or sign-ins report to take actions based on information gathered.

> [!NOTE]
> Our system might detect that the risk event that contributed to the user risk score was a false positive or the user risk was remediated with policy enforcement such as completing an MFA prompt or secure password change. Therefore, our system will dismiss the risk state and a risk detail of “AI confirmed sign-in safe” will surface and it will no longer contribute to the user's risk.
