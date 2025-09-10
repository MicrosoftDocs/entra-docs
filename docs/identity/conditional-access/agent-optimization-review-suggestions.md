---
title: Review suggestions from the Conditional Access optimization agent
description: Learn how to review and apply suggestions provided by the Security Copilot for Microsoft Entra optimization agent.
ms.author: sarahlipsey
author: shlipsey3
ms.reviewer: lhuangnorth
manager: pmwongera
ms.date: 08/25/2025
ms.update-cycle: 180-days
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.custom: security-copilot
ms.collection: msec-ai-copilot
---

# How to review and apply suggestions from the Conditional Access optimization agent

The Microsoft Entra Conditional Access optimization agent provides suggestions to create or update Conditional Access policies and creates reports for activity related to those policies. The suggestions vary based on what the agent finds. As the administrator, you need to review the suggestions and decide what to do.

This article provides an overview of the logic behind the suggestions and reports and how to review and act on those suggestions.

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](overview.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- You must have the appropriate Microsoft Entra role.
   - [Security Reader](../../identity/role-based-access-control/permissions-reference.md#security-reader) and [Global Reader](../../identity/role-based-access-control/permissions-reference.md#global-reader) roles can *view the agent and any suggestions, but can't take any actions*.
   - [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator), [Security Administrator](../../identity/role-based-access-control/permissions-reference.md#security-administrator), and [Global Administrator](../../identity/role-based-access-control/permissions-reference.md#global-administrator) roles can *view the agent and take action on the suggestions*.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).
- Device-based controls require [Microsoft Intune licenses](/intune/intune-service/fundamentals/licenses).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security).

### Limitations

- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs.
- The agent currently runs as the user who enables it.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.
- The agent can review up to 150 users and 100 applications in a single run.

## How it works

The agent might run and:

- Not identify any unprotected users or recommend any changes
- Create a new Conditional Access policy *in report-only mode*
- Suggest modifying an existing policy
- Suggest consolidating overlapping policies
- Identify a spike or dip in activity related to an existing policy

We want to provide as much information as possible about the logic used to identify the suggestions because Conditional Access policies can be complex. With each suggestion, the agent provides detailed reasoning, policy impact summaries, and details of the policy. As a best practice, review the information provided before applying a suggestion or changing a report-only policy to an active policy.

## Review suggestions and agent logic

Select **Review suggestion** to review a thorough overview of the suggestion, including the logic used to identify the suggestion and the potential impact of the policy.

### Policy details

The default view of the suggestion provides the policy details, including a high-level description at the top followed by the details that are used in the policy.

:::image type="content" source="media/agent-optimization-review-suggestions/review-suggestions-details.png" alt-text="Screenshot of the agent with the policy suggestion details open." lightbox="media/agent-optimization-review-suggestions/review-suggestions-details-expanded.png":::

### Policy impact

From the details panel that opens, select **Policy impact** to see a visualization of the potential impact of the policy.

Adjust the filters and the display as needed. Select a point on the graph to see a sample of the data that the policy affects. For example, for a policy to require multifactor authentication (MFA), the graph shows a sample of sign-in events where the Conditional Access policy wasn't applied. For more information, see [Policy impact](concept-conditional-access-report-only.md#reviewing-results).

### View agent's full activity

To see a detailed summary of the agent's activity and how it calculated the suggestion, select **View agent's full activity**. The agent's activity assesses policy drift, or gaps in policy coverage, for users and apps. The agent also looks for policies that can be merged or consolidated.

The **Summary of agent activity** is a natural language description of the activity illustrated in the **Agent activity map**. These details can help you understand the logic behind the suggestion so you can make an informed decision about whether to apply the suggestion.

:::image type="content" source="media/agent-optimization-review-suggestions/agent-activity-detail.png" alt-text="Screenshot of the agent activity map." lightbox="media/agent-optimization-review-suggestions/agent-activity-detail-expanded.png":::

### Review policy changes

If the agent suggests modifying an existing policy, select **Review policy changes** to see the details of the recommended change. This page lists the users, target resources, and other details of the policy that will change if you apply the suggestion.

- Policy details are provided as both a list of all the details that are changing and a JSON view of the entire policy, with the changes highlighted.
- For policy changes that affect users or applications, you can download a JSON file of the users and applications affected by the policy change.

### Deep analysis (Preview)

The Conditional Access optimization agent provides deep analysis of your tenant's policies where the controls include MFA. The deep analysis capability reviews the targeted users, groups, and roles of the policy with focus on exclusions.

## Apply suggestions

The experience for applying the suggestion depends on whether the agent created a new policy in report-only mode or suggests modifying an existing policy.

### Modify an existing policy

The agent could suggest modifying an existing policy or consolidating overlapping policies. After reviewing the details and impact of the policy change, you can apply the suggestion to the policy.

- From the **Policy details** page, select **Apply suggestion** to apply the changes to the policy.

:::image type="content" source="media/agent-optimization-review-suggestions/policy-update-details.png" alt-text="Screenshot of a modify policy details page with the apply suggestion button highlighted." lightbox="media/agent-optimization-review-suggestions/policy-update-details.png":::

- From the **Review policy changes** page, you can also select **Approve suggested changes** from the bottom of the page.

:::image type="content" source="media/agent-optimization-review-suggestions/approve-suggested-changes.png" alt-text="Screenshot of the review policy page with the approve suggested changes button highlighted." lightbox="media/agent-optimization-review-suggestions/approve-suggested-changes.png":::

### Turn on a new policy

When the agent suggests a new policy, it creates the policy in report-only mode. After reviewing the policy impact, you can turn on the policy directly from the agent experience or from the Conditional Access policies list.

- Select **Turn on policy** to have the agent apply the changes to the policy *in report-only mode*.

:::image type="content" source="media/agent-optimization-review-suggestions/turn-on-policy.png" alt-text="Screenshot of the policy details with the turn on policy button highlighted." lightbox="media/agent-optimization-review-suggestions/turn-on-policy.png":::

- From Conditional Access, select the policy and then change the **Enable policy** toggle from **Report-only** to **On**.

:::image type="content" source="media/agent-optimization-review-suggestions/report-only-mode-toggle.png" alt-text="Screenshot of the report-only mode toggle in Conditional Access." lightbox="media/agent-optimization-review-suggestions/report-only-mode-toggle.png":::

> [!TIP]
> As a best practice, organizations should exclude their break-glass accounts from policy to avoid being locked out due to misconfiguration.

> [!WARNING]
> Policies in report-only mode that require a compliant device might prompt users on macOS, iOS, and Android devices to select a device certificate during policy evaluation, even though device compliance isn't enforced. These prompts might repeat until the device is compliant. To prevent end users from receiving prompts during sign-in, exclude device platforms Mac, iOS, and Android from report-only policies that perform device compliance checks.

## Review policy reports (Preview)

The Conditional Access optimization agent also detects spikes and dips in activity related to existing policies. These anomalies often indicate a misconfiguration of a policy that needs to be investigated. If the agent identifies a significant change in activity, a report appears in the list of suggestions. In the **Actions taken by agent** column, you'll see **Suggested policy review** as the value.

> [!IMPORTANT]
> The policy reports in the Conditional Access Optimization agent are currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

To view a policy review report:

1. Select **Review suggestion** to view the details of the suggested policy review.
1. On the policy details page, select **Review report**. A detailed report with a visualization of the activity related to the policy appears.

    :::image type="content" source="media/agent-optimization-review-suggestions/agent-policy-report-button.png" alt-text="Screenshot of the policy details for a report with the Review report button highlighted." lightbox="media/agent-optimization-review-suggestions/agent-policy-report-button.png":::

1. Review the report and investigate the policy as needed.

1. From the policy details page, select **Mark suggestion as reviewed** or **Snooze for 14 days**. Optionally, you can add notes about what you learned and any changes you made to the related policy.