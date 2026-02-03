---
title: ID Protection Risk Reports
description: Learn how to access, filter, and use the Microsoft Entra ID Protection risk reports to mark users and sign-ins as risky or confirmed compromised.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 11/05/2025

author: shlipsey3
ms.author: sarahlipsey
ms.reviewer: chuqiaoshi
---
# Microsoft Entra ID Protection risk reports

Microsoft Entra ID Protection helps protect your organization by automatically detecting and responding to identity-based risks. While automated remediation handles many threats, some situations require manual investigation and action. The ID Protection risk reports provide the insights you need to identify, investigate, and respond to potential security threats affecting your users, sign-ins, and workload identities.

## Access the risk reports

The [ID Protection Dashboard](id-protection-dashboard.md) provides a summary of important insights that you can use at any time to identify potential risks.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader).
1. Browse to **ID Protection** > **Dashboard**.
1. Select a report from the ID Protection navigation menu.

:::image type="content" source="media/concept-risk-reports/dashboard.png" alt-text="Screenshot showing the Microsoft Entra ID Protection dashboard." lightbox="media/concept-risk-reports/dashboard-expanded.png":::


Each report launches with a list of all detections for the period shown at the top of the report. You can filter and add or remove columns based on your preference. Download the data in .CSV or .JSON format for further processing. To integrate the reports with Security Information and Event Management (SIEM) tools for further analysis, see [Configure diagnostic settings](../identity/monitoring-health/howto-configure-diagnostic-settings.md).

## View details and take action

Select an entry in a report to view more details, which differ based on the report you're viewing. From the details pane, you can also take action on the selected user or sign-in. You can select one or multiple entries and either confirm the risk or dismiss it. You can also start a password reset flow from the user. These capabilities have different role requirements, so if an option is greyed out, you need a higher privileged role. For more information, see [ID Protection required roles](overview-identity-protection.md#required-roles).

### Risky users

The details of a selected risky user provide information on the risk that was remediated, dismissed, or is still currently at risk and needs investigation. You're also provided details about the associated risk detections. For a detailed overview, see [Risky user report](concept-risky-user-report.md).

A user becomes a risky user when:

- They have one or more risky sign-ins.
- They have one or more [risks](concept-identity-protection-risks.md) detected on their account, like leaked credentials.

#### Security Copilot

If you also have Security Copilot, you have access to a [summary in natural language](../security-copilot/entra-risky-user-summarization.md) for scenarios such as why the user risk level was elevated and guidance on how to mitigate and respond.

### Risky sign-ins

The Risky sign-ins report lists sign-ins that are at risk, confirmed compromised, confirmed safe, dismissed, or remediated. The details pane provides more information about the sign-in attempt that might help during an investigation, such as real-time and aggregate risk levels associated with sign-in attempts and the detection types triggered.

**Risky sign-ins details** include:
- The application the user was trying to access
- Conditional Access policies applied
- MFA details
- Device, application, and location information
- Risk state, risk level, and the source of the risk detection (ID Protection or Microsoft Defender for Endpoint)

The **Risky sign-ins** report contains filterable data for up to the past 30 days (one month). ID Protection evaluates risk for all authentication flows, whether it's interactive or non-interactive. The Risky sign-ins report shows both interactive and non-interactive sign-ins. To modify this view, use the "sign-in type" filter.

:::image type="content" source="media/concept-risk-reports/risky-sign-ins-report.png" alt-text="Screenshot showing the Risky sign-ins report." lightbox="media/concept-risk-reports/risky-sign-ins-report.png":::

[!INCLUDE [id-protection-admin-action-sign-in](../includes/id-protection-admin-action-sign-in.md)]

To learn more about when to take each of these actions, see [How does Microsoft use my risk feedback](howto-identity-protection-risk-feedback.md#how-does-microsoft-use-my-risk-feedback)

### Risky agents

ID Protection can help you identify risky agents in your organization. This report includes all identities within the [Microsoft Entra Agent ID](../agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents.md) platform. The **Risky Agents** report provides an overview of the risk detections for each agent, with tools to help you take action directly from the report.

**Risky agent details** include:
- Agent display name
- Risk state and risk level
- Agent type
- Agent sponsors

An agent becomes a risky agent when it has one or more risk events detected on its account. For more information, see [ID Protection for agents](concept-risky-agents.md).

### Risky Workload IDs

A [workload identity](../workload-id/workload-identities-overview.md) is an identity that allows an application access to resources, sometimes in the context of a user. From the Risky Workload ID details page, you can access service principal sign-in and audit logs for further analysis.

> [!IMPORTANT]
> Full risk details and risk-based access controls are available to Workload Identities Premium customers; however, customers without a **[Workload Identities Premium](../workload-id/workload-identities-faqs.md)** license still receive all detections with limited reporting details.

**Risky Workload IDs details** include:
- Service principal ID
- Risk state and risk level
- Risk history

### Risk detections

The Risk detections report provides insights into the various risk detections associated with users and sign-ins. The details include information about the type of risk detected, the user, or sign-in it pertains to, and the current status of the risk. From the details pane, you can also access the associated user risk report, the user's sign-ins, and risk detections.

**Risk detections details** include:
- Detection type
- Risk state, risk level, and risk detail
- Attack type
- Source of the risk detection (ID Protection or Microsoft Defender for Endpoint)

The Risk detections report contains filterable data for up to the past 90 days (three months).

:::image type="content" source="media/concept-risk-reports/risk-detections-report.png" alt-text="Screenshot showing the Risk detections report." lightbox="media/concept-risk-reports/risk-detections-report.png":::

With the information provided by the Risk detections report, administrators can find:

- Information about each risk detection
- Attack type based on MITRE ATT&CK framework
- Other risks triggered at the same time
- Sign-in attempt location
- Link to more detail from Microsoft Defender for Cloud Apps
- [Agent detections](concept-risky-agents.md) (Preview)

Administrators can then choose to return to the user's risk or sign-ins report to take actions based on information gathered.

> [!NOTE]
> Our system might detect that:
> - the risk event that contributed to the risk score was a false positive; or
> - the risk was remediated with policy enforcement, such as completing an MFA prompt or secure password change.
>
> Therefore, our system dismisses the risk state and a risk detail of "AI confirmed sign-in safe" surfaces and no longer contributes to the user's risk.