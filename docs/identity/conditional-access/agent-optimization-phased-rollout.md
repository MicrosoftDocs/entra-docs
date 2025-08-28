---
title: Conditional Access optimization agent phased rollout
description: Learn about the phased rollout capability for the Security Copilot for Microsoft Entra optimization agent.
ms.author: sarahlipsey
author: shlipsey3
manager: pmwongera

ms.reviewer: lhuangnorth
ms.date: 08/28/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
ms.custom: security-copilot
ms.collection: msec-ai-copilot
---
# Conditional Access optimization agent phased rollout

The Conditional Access optimization agent for Microsoft Entra includes a phased rollout capability that helps organizations deploy new Conditional Access policies safely and efficiently. This Microsoft Security Copilot feature in Microsoft Entra enables administrators to introduce policies gradually, monitor their impact, and minimize disruptions. This phased rollout capability provides gradual deployment of new policies to minimize the chance of widespread disruption to end users and reduce the need for manual analysis and planning, saving weeks of effort. As with all aspects of the Conditional Access Optimization Agent, administrators retain full control of the policy changes, such as group selection and rollout pacing. Clear reasoning for the rollout plan is also provided to maintain transparency.

This article explains how the phased rollout process works, outlines prerequisites, and describes the built-in safeguards that help ensure a smooth deployment.

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](overview.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
- [Global Reader](../../identity/role-based-access-control/permissions-reference.md#global-reader) and [Security Reader](../../identity/role-based-access-control/permissions-reference.md#security-reader) roles can view the agent and any suggestions, but can't take any actions.
- [Global Administrator](../../identity/role-based-access-control/permissions-reference.md#global-administrator), [Security Administrator](../../identity/role-based-access-control/permissions-reference.md#security-administrator), and [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) roles can view the agent and take action on the suggestions.
- Tenants must have at least five defined groups that are currently used in Conditional Access policies for the agent to generate a phased rollout plan.

## How it works

When the Conditional Access optimization agent creates a new policy in report-only mode, it can suggest turning on the policy with a phased rollout. The agent analyzes sign-in data and existing policies to define a phased rollout plan.

Policies that are intended to apply to *all users* and need to be turned on are eligible for a phased rollout. Because there are five distinct phases to a rollout plan, you must have at least five groups for the rollout plan to apply.

There are three main steps in the phased rollout process:

1. [Agent creates a report-only policy with a phased rollout](#agent-creates-a-report-only-policy-with-a-phased-rollout)
1. [Administrator reviews, edits, and accepts the rollout plan](#administrator-reviews-edits-and-accepts-the-rollout-plan)
1. [Agent or Administrator executes the rollout plan](#agent-or-administrator-executes-the-rollout-plan)

You can review the groups included in each phase and the number of days between each phase and make changes before and during the phased rollout. At any time during the rollout, you can choose to have the plan executed by the agent or you can manually execute each phase of the plan.

Regardless of how the plan is executed or if you made changes to the plan, when the first phase starts, a *new* policy is created and turned on for the groups included in the first phase. The original report-only mode policy remains intact.

## Agent creates a report-only policy with a phased rollout

The agent creates a report-only policy and builds a separate phased rollout plan. The rollout plans include five phases, starting with small, low-risk groups and progressing to larger, high-risk groups.

:::image type="content" source="media/agent-optimization-phased-rollout/phased-rollout-suggestions.png" alt-text="Screenshot of the agent suggestions with a phased rollout type highlighted." lightbox="media/agent-optimization-phased-rollout/phased-rollout-suggestions-expanded.png":::

In the list of suggestions from the agent, look for **Suggested phased rollout** in the **Actions taken by agent** column.

### Administrator reviews, edits, and accepts the rollout plan

Administrators need to review the details of the plan, including the groups included in each phase, the timing of each phase, and how the plan will be executed.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).

1. Browse to **Conditional Access Optimization Agent** and select the **Review suggestions** button for a policy suggestion that includes a phased rollout.

1. From the policy details page, select **Review phases**.

    :::image type="content" source="media/agent-optimization-phased-rollout/phased-rollout-review-phases-button.png" alt-text="Screenshot of a phased rollout policy suggestion." lightbox="media/agent-optimization-phased-rollout/phased-rollout-review-phases-button.png":::

1. Select **Edit Groups** to edit the groups included in the phase.

    :::image type="content" source="media/agent-optimization-phased-rollout/phased-rollout-edit-groups-button.png" alt-text="Screenshot of the phases that can be edited with the edit groups button highlighted." lightbox="media/agent-optimization-phased-rollout/phased-rollout-edit-groups-button.png":::

1. Select the down arrow on the **Automatically roll out phases** button to select an execution mode.
    - **Automatically roll out phases**: Agent automatically rolls out each phase, based on timing and impact signals.
    - **Manually roll out phases**: Administrator manually advances each phase of the rollout.

    :::image type="content" source="media/agent-optimization-phased-rollout/phased-rollout-execution-mode-button.png" alt-text="Screenshot of the phases that can be edited with the edit groups button highlighted." lightbox="media/agent-optimization-phased-rollout/phased-rollout-execution-mode-button.png":::

> [!TIP]
> You can intervene at any time with automatic and manual rollout plans. You can also change execution modes at any time during rollout.

To adjust the time between phases:

1. Browse to the **Settings** tab from the Conditional Access Optimization Agent.
1. Adjust the days between phases in the **Phased rollout** section.
1. Select the **Save** button to apply the changes.

For more information, review the [Phased rollout settings](agent-optimization.md#phased-rollout).

## Agent or administrator executes the approved rollout plan

The options available to manage the phased rollout are different for automatic and manual execution.

### Automatically roll out phases

If you selected automatic rollout, the agent automatically executes the plan by creating a new, enabled policy that applies to all groups in the first phase. Once the rollout starts, several controls appear to manage the rollout.

The agent deploys the policy to the groups in the next phases based on the defined schedule. At any time during the phased rollout, you can pause the execution of the plan or choose to manually roll out the remaining phases.

:::image type="content" source="media/agent-optimization-phased-rollout/phased-rollout-automatic-details.png" alt-text="Screenshot of an automatically executed phased rollout." lightbox="media/agent-optimization-phased-rollout/phased-rollout-automatic-details.png":::

You can continue to monitor between each phase of the rollout to ensure the policy does what's expected. While the policy is being rolled out, the original report-only policy remains in report-only mode for the remaining phases. After the phased rollout is complete, the agent recommends deleting the report-only policy the next time it runs, so you can maintain a clean policy list.

### Manually roll out phases

If you chose to manually execute the phased rollout plan, you're provided several options to manage each step.

:::image type="content" source="media/agent-optimization-phased-rollout/phased-rollout-manual-details.png" alt-text="Screenshot of a phased rollout plan in manual execution mode." lightbox="media/agent-optimization-phased-rollout/phased-rollout-manual-details.png":::

You must select the **Move to next phase** to advance each phase of the rollout. At any phase you can revert to the previous phase or opt to have the agent automatically roll out the remaining phases.

## Built-in safeguards

Once the phased rollout begins, you can't update the policy's grant controls. If changes are made to the grant controls, the phased rollout is canceled. If more than 10% of sign-ins are blocked by the new policy during any phase, the rollout is immediately paused. The administrator is notified so the details can be reviewed and potentially modified.

## Frequently asked questions

### How does the phased rollout capability work?

After selecting the groups that each phase will apply to, the agent creates a duplicate Conditional Access policy that only includes the group of the first phase. The original Conditional Access policy persists in report-only mode and targets all users, so you can continue to collect data. When the deployment advances to the next phase, the batch of groups is added to the enabled Conditional Access policy. The agent monitors how each stage affects the sign-ins associated with this policy. If the success rate drops below 90%, the phased rollout stops and the enabled policy is placed back into report-only mode. You can then review the logs to determine why sign-ins were failing before attempting the phased rollout again.

### Do I have to turn on phased rollout?

The phased rollout capability is turned on by default. To turn it off, go to the **Settings** tab on the Conditional Access Optimization Agent page. Under **Phased rollout**, switch the toggle to **Off**.

## Related content

- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
- [Conditional Access optimization agent overview](agent-optimization.md)