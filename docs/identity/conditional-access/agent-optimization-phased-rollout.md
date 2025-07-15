---
title: Conditional Access optimization agent phased rollout
description: Learn about the phased rollout capability for the Security Copilot for Microsoft Entra optimization agent.
ms.author: sarahlipsey
author: shlipsey3
ms.reviewer: lhuangnorth
ms.date: 07/15/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
---
# Conditional Access optimization agent phased rollout

The Conditional Access optimization agent for Microsoft Entra includes a phased rollout capability that helps organizations deploy new Conditional Access policies more safely and efficiently. This Microsoft Security Copilot feature in Microsoft Entra enables administrators to introduce policies gradually, monitor their impact, and minimize disruptions. There are several benefits to this phased rollout capability:

- **User impact mitigation**: Gradual deployment minimizes the chance of widespread disruption to end users.
- **Operational efficiency**: Reduces the need for manual analysis and planning, saving weeks of effort.
- **Customization**: Administrators retain full control over group selection and rollout pacing.
- **Transparency**: The agent provides clear reasoning for group assignments and rollout decisions.

This article explains how the phased rollout process works, outlines prerequisites, and describes the built-in safeguards that help ensure a smooth deployment.

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](overview.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
- [Global Reader](../../identity/role-based-access-control/permissions-reference.md#global-reader) and [Security Reader](../../identity/role-based-access-control/permissions-reference.md#security-reader) roles can view the agent and any suggestions, but can't take any actions.
- [Global Administrator](../../identity/role-based-access-control/permissions-reference.md#global-administrator), [Security Administrator](../../identity/role-based-access-control/permissions-reference.md#security-administrator), and [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) roles can view the agent and take action on the suggestions.

## How it works

There are three main stages to the phased rollout process.

### Agent creates a report-only policy with a phased rollout

When the Conditional Access optimization agent creates a new policy in report-only mode, it can suggest turning on the policy with a phased rollout. The agent analyzes sign-in data and existing policies to define a phased rollout plan. Rollout plans include five phases, starting with small, low-risk groups and progressing to larger, high-risk groups.

### Administrator reviews and accepts the rollout plan

Administrators can accept the plan or modify details of the plan, such as the group assignments or the time between phases.

### Agent executes the approved rollout plan

The agent automatically executes the plan by creating a new, enabled policy that applies to all groups in the first phase. The agent deploys the policy to the groups in the next phases based on the defined schedule. You can continue to monitor between each phase of the rollout to ensure there are no unexpected results. While the policy is being rolled out, the policy remains in report-only mode so you can monitor the impact of the policy. After every phase is complete, the agent will recommend deleting the report-only policy the next time it runs, so you can maintain a clean policy list.

## Built-in safeguards

Once the phased rollout begins, you can't update the policy's grant controls. If changes are made to the grant controls, the phased rollout is canceled. If more than 10% of sign-ins are blocked by the new policy during any phase, the rollout is immediately paused. The administrator is notified so the details can be reviewed and potentially modified.