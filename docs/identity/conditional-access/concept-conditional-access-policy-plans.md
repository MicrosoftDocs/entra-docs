---
title: What are Microsoft Entra Conditional Access policy plans? (preview)
description: Learn how Microsoft Entra Conditional Access policy plans reduce duplicated targeting and exclusions by grouping related enforcement rules under shared conditions.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
ms.date: 10/21/2026

ms.author: etbasser
author: ebasseri
ms.reviewer: celested
ai-usage: ai-assisted
#customer intent: As a Conditional Access administrator, I want to understand policy plans so that I can organize related rules and manage their shared targeting and exclusions.
---
# What are Microsoft Entra Conditional Access policy plans? (preview)

Microsoft Entra Conditional Access policy plans group related rules under shared assignments and conditions. Administrators can define common targeting and exclusions once, then configure each rule for a specific scenario. Use a plan to organize related controls around a security objective, such as requiring compliant devices or securing agent activity.

> [!IMPORTANT]
> Conditional Access policy plans are in preview. Preview features are available under the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) and might not have all the capabilities of generally available features.

## Why use policy plans?

### Reduce policy sprawl

An organization might maintain separate Conditional Access policies for Windows, macOS, iOS, and Android when each platform requires different settings. Those policies can repeat the same user targeting and emergency access exclusions. Changes to that shared targeting must then be made in each policy.

With a plan, shared targeting is defined once and automatically applies to every scenario within that plan. Adding or removing an emergency access group in one place updates the shared targeting for all rules in the plan.

### Eliminate duplicated exclusions

Emergency access accounts, trusted service accounts, and privileged workstations appear in exclusion lists across many policies. Missed exclusions are a common source of unintended lockouts. Plans let administrators define these exclusions once, at the plan level, so no individual rule can accidentally omit them.

### Scale for Global Secure Access

Organizations that deploy Global Secure Access often need hundreds of network-scoped rules that target the same user population and application set. Plans allow the shared targeting to be defined once, with each rule focused only on the specific network scope it governs.

### Apply consistent controls to agent activity

Agent identities can act with their own permissions or on behalf of a user by using the user's permissions. A plan can define a shared condition, such as high agent risk, and use separate rules to protect agent users and autonomous agents. Without a plan, each scenario requires a standalone policy that repeats the shared condition.

## How plans work

A plan has three parts:

- **Plan details**: Specify a name, description, optional tags, and individual or group owners. These details help teams understand the plan's purpose, accountability, and the potential impact of future changes. Designating owners doesn't affect who has permission to edit the plan, and plan details don't affect policy enforcement at runtime.
- **Shared conditions**: Define optional include and exclude targeting that applies broadly. Shared conditions can include identities; resources such as applications; user actions; authentication context; risk levels; device platforms; network locations; and client app types.
- **Rules**: Define the individual enforcement scenarios within the plan. Each rule adds the assignments and conditions that are specific to the scenario, along with its grant and session controls. Every policy plan must have at least one rule.

> [!NOTE]
> Select **All resources** at the rule level. This assignment isn't available in shared conditions.

### How shared conditions affect rules

Shared conditions and rule conditions combine additively:

- **Targeting at the plan level is inherited.** If the plan targets group A, every rule in the plan inherits that scope. A rule can't narrow the plan's targeting, but it can add exclusions of its own. For this reason, you can target **All users** in rules but not in shared conditions.
- **Identity type must be consistent.** Shared conditions can't mix identity types. A plan that targets users can't also target agents at the plan level. To cover multiple identity types in one plan, leave the identity assignment to the rules. For example, one rule can target users and another can target agents.
- **Inclusions and exclusions accumulate.** If the plan excludes emergency access groups A and B, and a rule also excludes group C, the effective exclusion list is A, B, and C. An exclusion set at the plan level can never be overridden or removed by a rule. This design ensures consistency across every rule in the plan.

## Runtime enforcement

At sign-in time, Conditional Access combines a rule's conditions with the plan's shared conditions, if any, to form the complete targeting for that rule. Each rule is then evaluated as an independent enforcement decision in the same way as a standalone policy. Each rule appears separately in sign-in logs.

> [!NOTE]
> During preview, policy plans that target users with Location as a condition will be issued one-hour access tokens without instant IP enforcement check. For more information, see [Named location limitations](concept-continuous-access-evaluation.md#named-location-limitations).

## Relationship to existing Conditional Access policies

Plans are an addition to the existing Conditional Access policy model, not a replacement. Your existing policies continue to work as they do today, with no changes required.

During sign-in evaluation, the Conditional Access engine evaluates both existing policies and policy plan rules. Every applicable policy and every applicable rule must be satisfied for access to be granted. There's no interaction or precedence between them. They accumulate independently.

| Capability | Existing policy | Policy plans and rules |
| --- | --- | --- |
| Targeting | Defined per policy and duplicated across policies | Shared conditions are defined once at the plan level and inherited by all rules, or defined per rule |
| Change management | Each policy is updated individually | A single change to the plan's shared conditions propagates to all rules |
| Policy templates | One template per policy | Combine multiple templates into a single plan, or deploy one template per plan |

## Required roles

To create, modify, or delete a policy plan, sign in with the Conditional Access Administrator role.

## License requirements

For license requirements, see [Conditional Access license requirements](overview.md#license-requirements).

## Next steps

- [Create a Conditional Access policy plan](how-to-create-conditional-access-policy-plan.md)
- [Migrate Conditional Access policies to a policy plan](how-to-migrate-conditional-access-policy-plan.md)
