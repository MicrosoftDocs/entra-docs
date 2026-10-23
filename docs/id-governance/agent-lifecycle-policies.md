---
title: Entra Agent ID lifecycle policies
description: Configure Microsoft Entra Agent ID lifecycle policies to automate lifecycle management of agent identities
author: chiragdayani
ms.author: chiragdayani
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 10/06/2026
ai-usage: ai-generated

#customer intent: As an identity or security administrator, I want to configure agent identity lifecycle policies so that I can manage inactive or orphaned agent identities.
---

# Entra Agent ID lifecycle policies (preview)

AI agent adoption is accelerating, resulting in a growing number of agent identities with access to critical resources. Without clear lifecycle controls, these identities can persist beyond their usefulness and introduce security risk. Keeping agent identities around when they are no longer needed can lead to security incidents, as forgotten identities can become easy targets for attackers, while agent identities without clear accountability may continue to retain access indefinitely. As organizations deploy more AI agents, these risks become amplified. Security and identity administrators therefore need automated lifecycle management to avoid agent proliferation to manage unmonitored, inactive and orphaned agent identities 

> [!IMPORTANT]
> Agent ID lifecycle policy is in preview. Preview features are provided without a service-level agreement and aren't recommended for production workloads. Certain features might not be supported or might have limited capabilities.

## Prerequisites

### License requirements

[!INCLUDE [licensing-agent-id-governance](../includes/licensing-agent-id-governance.md)]

### Roles

One of the following roles:

- [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator)
- [AI Administrator](../identity/role-based-access-control/permissions-reference.md#ai-administrator)

## Create an agent lifecycle policy

Create a policy to define which agent identities should be evaluated and what happens when an agent identity doesn't meet an enabled rule.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) or [AI Administrator](../identity/role-based-access-control/permissions-reference.md#ai-administrator).
1. Browse to **ID Governance** > **Lifecycle Workflows** > **Lifecycle Policies** > **Agent IDs**.
1. Select **New policy**.
1. Enter a unique policy name and description.
1. Enable the lifecycle policy.
1. Select the scope of agent identities that needs to be governed by the policy.
1. Configure one or more lifecycle rules:
   - Periodic reconfirmation
   - Minimum sponsor requirement
   - Inactivity monitoring
1. Choose a policy action and, if needed, configure a grace period.
1. Review the notification behavior.
1. Optionally, add one or more fallback recipients to receive lifecycle notifications when an agent identity has no accountable representative, such as a sponsor or owner.
1. Review the configuration, and then select **Save**.
1. If multiple Agent ID lifecycle policies exist, configure the policy priority.

After you create the policy, our system periodically evaluates the agent identities within its scope. When an agent identity violates any enabled lifecycle policy rule, the identity enters the configured notification and enforcement process.

## Configure lifecycle rules

Each Agent ID lifecycle policy can contain one or more rules. Configure the rules that represent your organization's requirements for continued use and accountability.

### Configure periodic reconfirmation

Use periodic reconfirmation to verify that an agent identity is still needed.

1. Enable **Periodic reconfirmation**.
1. Configure the reconfirmation frequency i.e. how often sponsor or owner must re-confirm that the agent identity is still required (between 30 and 730 days).

If the agent identity isn't reconfirmed within the configured timeframe, the configured policy actions trigger so that the accountable representatives can take action via the Manage Agents experience (https://myaccount.microsoft.com/agents)

### Configure minimum sponsor requirements

Use the minimum sponsor requirement to ensure that each agent identity has clear accountability.

1. Enable **Minimum sponsor requirement**.
1. Specify the minimum number of sponsors required for each agent identity.

If an agent identity has fewer than the configured number of sponsors, the configured policy actions trigger, so that the available accountable representatives can take action to add / update the sponsors via the Manage Agents experience (https://myaccount.microsoft.com/agents), to ensure the agent identity is not disabled / deleted. In case the agent identity has no accountability, then the fallback recipient is notified.

### Configure inactivity monitoring

Use inactivity monitoring to identify stale and unused agent identities.

1. Enable **Inactivity monitoring**.
1. Specify the inactivity duration.
1. Define how long an agent identity can remain inactive before the configured policy actions are triggered.

If an agent identity has been inactive for more than the configured duration i.e. no tokens have been issued for the identity during that time, the configured policy actions trigger, so that the accountable representatives can take appropriate action.

## Configure policy actions

Policy actions define what actions can be taken when an agent identity does not satisfy the policy requirements

| Action | Result |
| --- | --- |
| **Disable** | Disables the agent identity and prevents future sign-ins or usage. |
| **Delete** | Soft Deletes the agent identity. |
| **Disable and delete** | Disables the agent identity immediately and then deletes it after the configurable grace period.

1. Select the action that should be taken for the agent identities which do not fulfill the organizational policy rules.
1. If you select **Disable and delete**, specify the number of days when delete action triggers after the disablement is completed.
1. To give accountable representatives time to remediate a policy violation, enable the grace period and specify its duration.
1. Review the selected action before you create or update the policy.

## Configure notifications

Notifications inform accountable representatives which lifecycle policy rule was violated by an agent identity and which policy action will be triggered if the required action is not executed.

1. Review the notifications sent to sponsors, owners, or other accountable representatives.
1. Add one or more fallback recipients when notifications need to reach someone if an agent identity has no sponsor or owner.
1. Confirm that the notification schedule gives recipients enough time to remediate the violation before the disable / delete action is triggered.

If the violation isn't remediated within the configured timeframe, Lifecycle Workflows automatically executes the policy action.

## Set policy priority

You can create multiple agent identity lifecycle policies with different scopes, rules, and actions. Policy priority determines which policy applies when an agent identity is included in more than one policy.

1. Open the list of agent identity lifecycle policies.
1. Review policies with overlapping agent identity scopes.
1. Move the policy that should take precedence above the other matching policies.
1. Review the scopes again before you enable broad enforcement.

The highest-priority matching policy applies to the agent identity.

## Verify the policy

Validate the policy with a limited set of test agent identities before you apply it broadly.

1. Select **Specific agents** as the policy scope.
1. Add a small set of test agent identities.
1. For periodic reconfirmation testing, use the minimum allowed frequency of 30 days.
1. Confirm that sponsors or other configured recipients receive the expected notifications.
1. In the [Manage Agents experience](https://myaccount.microsoft.com/agents), verify that a sponsor can reconfirm/ extend, or disable the agent identity.
1. Any unremediated violation results in the configured policy action after the applicable timeframe and grace period.

## How policy enforcement works

Lifecycle policy uses the following process to evaluate and enforce an agent identity lifecycle policy:

1. **Scope evaluation:** identifies the agent identities included in the policy scope.
1. **Rule evaluation:** evaluates each enabled policy rule. An agent identity becomes noncompliant when it violates any enabled rule.
1. **Notification:** notifies the applicable sponsors, owners, or fallback recipients.
1. **Enforcement:** If the violation isn't remediated within the configured timeframe, Lifecycle Workflows disables, deletes, or disables and then deletes the agent identity according to the policy configuration.

| Rule violation | Notification recipient | Action Required |
| --- | --- | --- |
| Reconfirmation overdue | Sponsor or owner or fallback recipient | Disable if no longer needed or reconfirm that the agent identity is still required by clicking on 'Extend' in Manage Agents experience |
| Minimum sponsor requirement not met | Sponsor or owner or fallback recipient | Update sponsors in Manage Agents experience |
| Inactive beyond the configured threshold | Sponsor or accountable representative | Disable if no longer needed or make it active by interacting with it |


## Related content

- [Governing Agent Identities](agent-id-governance-overview.md)
- [Microsoft Entra ID Governance licensing fundamentals](licensing-fundamentals.md)
- [Manage agents in the end-user experience](/entra/agent-id/manage-agent-identities-end-user)
