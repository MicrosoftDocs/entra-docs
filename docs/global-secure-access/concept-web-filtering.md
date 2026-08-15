---
title: Web filtering in Global Secure Access (V2)
description: "Learn how the V2 web filtering object model works in Microsoft Entra Internet Access, including policies, rules, destination matching, and V1 coexistence."
ms.topic: concept-article
ms.date: 07/21/2026
ms.subservice: entra-internet-access
ai-usage: ai-assisted
---

# Web filtering in Global Secure Access (V2)

Web filtering in Microsoft Entra Internet Access lets you control internet access for your organization based on website categorization, Uniform Resource Locators (URLs), and fully qualified domain names (FQDNs). The V2 object model aligns web filtering with the same policy structure used by other Global Secure Access security features, giving you a single, consistent way to author and manage filtering rules.

This article explains what changes in the V2 model, how policies and rules are structured, how destination matching works, and how V2 coexists with the earlier V1 (web content filtering) model. To configure web filtering, see [How to configure Global Secure Access web content filtering](how-to-configure-web-content-filtering.md).

## Overview

The V2 object model is the platform foundation for all newer Global Secure Access Internet Access Policies. Newer policy types, such as Threat Intelligence, file type and content filtering, and Cloud Firewall, are authored in this model, where a single policy contains multiple rules per security profile.

Historically, web filtering used a separate V1 model (also referred to as web content filtering, or the OMv1 model) with a different management flow. Bringing web filtering into the V2 model provides one consistent authoring and management experience across all Global Secure Access filtering features.

> [!NOTE]
> As part of the V2 model, the feature name changes from Web Content Filtering to Web Filtering. Existing V1 web content filtering policies continue to function unchanged until you migrate them.

## What's new in V2

The V2 object model introduces two major changes to how you author and manage web filtering.

### A single policy with multiple rules

In V1, you could create multiple web content filtering policies and link several of them to a security profile. In V2, a security profile contains a single web filtering policy that holds multiple rules. Instead of creating a new policy for each intent, you add a rule to the policy.

This structure mirrors the structure used by other V2 security features, so the authoring experience is the same regardless of which filtering capability you configure.

The two models also differ in where the action lives and in how they behave when no rule matches:

- In V1, a policy has no default action. It acts only when one of its rules matches, and the action is defined on the policy while its rules carry destinations only.
- In V2, each rule carries its own action, and the policy defines a default action that applies when no rule matches. As a result, a V2 policy always produces an outcome, whereas a V1 policy takes effect only on a match.

The following table compares how policies are structured in each model.

| Aspect | V1 (web content filtering) | V2 (web filtering) |
| --- | --- | --- |
| Policies per security profile | Multiple policies can be linked. | Exactly one policy. |
| Default action | None. The policy acts only if a rule matches. | Yes. Applied when no rule matches. |
| Where the action is defined | On the policy. Rules carry destinations only. | On each rule, plus a policy default action. |

### FQDN destinations are handled as URLs

In V1, web filtering supported three separate destination types (FQDN, URL, and web category), and each type matched traffic differently. In V2, the standalone FQDN type is removed. FQDN destinations are expressed as URL destinations and follow the URL user experience and matching logic.

The following table summarizes the destination match types available in each model.

| Destination type | V1 (web content filtering) | V2 (web filtering) |
| --- | --- | --- |
| Web category | Supported. | Supported. |
| URL | Supported. | Supported. |
| FQDN | Supported as a distinct type. | Expressed as a URL destination. |

## Policies, rules, and security profiles

Understanding how the V2 objects relate helps you plan your filtering configuration.

- **Rule**: The unit that defines a destination (web category or URL) and the action to take (**Allow** or **Block**). Rules are evaluated in priority order within a policy.
- **Policy**: A single web filtering policy contains one or more rules once configured. In V2, a security profile contains one web filtering policy. Each policy also defines a default action, which is the behavior applied when no rule in the policy matches.
- **Security profile**: A grouping of filtering policies that you link to a Microsoft Entra Conditional Access policy to make enforcement user-aware and context-aware. For more information, see [How to configure Global Secure Access web content filtering](how-to-configure-web-content-filtering.md).

Conditional Access remains the delivery mechanism for user and context awareness. Security profiles are referenced by profile identifier (GUID) in Conditional Access session controls, and those references remain valid across the transition to V2.

## Author a web filtering policy

You create a web filtering policy in the Microsoft Entra admin center by browsing to **Global Secure Access** > **Secure** > **Web Filtering Policies (V2)** and selecting **Create policy**. The create experience is organized into **Basics**, **Policy settings**, and **Review** tabs.

- On the **Basics** tab, you provide a name and description for the policy. The page also shows the policy evaluation order across Global Secure Access security modules.
- On the **Policy settings** tab, you set the **Default action**, which is the predefined behavior applied when no rules in the policy match. You can set the default action to **Allow** or **Block**.
- On the **Review** tab, you confirm the policy configuration before you create it.

> [!NOTE]
> A new policy is created without any rules. After you create the policy, add rules to define the destinations and actions it enforces.

## Add rules to a policy

After the policy exists, you add web filtering rules to it. Each rule defines the traffic it matches and the action to take when it matches.

A web filtering rule includes the following settings:

- **Rule name, description, and priority**: Rules are evaluated in priority order within the policy.
- **Status**: Enable or disable the rule.
- **Source** (optional): Scope the rule to a session type, such as User or Agent.
- **HTTP method request** (optional): Scope the rule to specific HTTP methods.
- **Destination matching**: Specify the URLs, FQDNs, and web categories the rule applies to.
- **Rule action**: Set the rule to **Allow** or **Block**.

## Destination matching behavior

Web category matching is unchanged between V1 and V2. URL matching behavior is important to understand, especially for destinations that were previously authored as FQDNs.

- **URL matching**: A URL destination scopes the rule to the address you enter and its sub-paths.
- **Former FQDN destinations**: Because the FQDN type is expressed as a URL in V2, a destination that was previously an exact FQDN match is evaluated using URL logic. A migrated FQDN destination can match sub-paths of the address rather than only the exact host.

> [!IMPORTANT]
> When you author a former FQDN destination as a URL in V2, matching behavior can differ from the V1 FQDN behavior. Review your destinations to confirm they match the traffic you intend.

## How V2 coexists with V1

You can adopt V2 without interrupting your existing web filtering enforcement. The models are designed to run side by side during the transition.

- **Higher priority for V2**: V2 web filtering policies are evaluated at a higher priority than V1 web content filtering policies.
- **Evaluation in series**: When both a V1 and a V2 policy apply, both modules run in series until you remove the V1 policy. For how a match in one module affects the other, see [How evaluation works across V1 and V2](#how-evaluation-works-across-v1-and-v2).
- **Consistent logging**: Matches are recorded using the existing traffic logs schema, including web category and the profile, policy, and rule names and identifiers. To review traffic, browse to **Global Secure Access** > **Monitor** > **Traffic logs**.

## How evaluation works across V1 and V2

When a user has both V1 and V2 policies applied, Global Secure Access evaluates them as two separate modules that run in sequence, not as one merged policy set:

1. The V2 module runs first. It finds the first security profile applicable to the user that contains a V2 web filtering policy and produces an outcome: either a matched rule's action or, if no rule matches, the policy's default action. A V2 policy always produces an outcome.
1. The V1 module runs second, only if V2 didn't block. If the V2 outcome is **Block**, the request is blocked and evaluation stops. If the V2 outcome is **Allow**, evaluation falls through to the V1 module, which evaluates all V1 policies linked to the user's profiles in priority order and applies the final action.

The key consequence is that **Block** and **Allow** aren't symmetric across the two modules:

- A V2 **Block** is terminal. It takes effect regardless of any V1 policy, and regardless of profile priority.
- A V2 **Allow** (including an explicit rule match) isn't terminal. It only means that the V2 module has no objection, and a V1 policy can still block the same traffic.

In short, a V2 policy can add blocks that override V1, but it can't force-allow traffic that a V1 policy blocks.

> [!IMPORTANT]
> Because both modules evaluate across all of the user's applicable profiles rather than stopping at the highest-priority profile, a V2 **Block** on a lower-priority profile can override an **Allow** on a higher-priority profile. Review the following examples before you run a mixed V1/V2 configuration.

**Example 1: A V2 Block overrides a higher-priority V1 Allow.** Profile 1 (priority 100) has a V1 policy that allows `espn.com` and no V2 policy. Profile 2 (priority 200) has a V2 policy that blocks the Sports category. The V2 module skips Profile 1 (no V2 policy), evaluates Profile 2's V2 **Block**, and blocks the request to `espn.com`. Profile 1's higher priority doesn't apply, because the V2 module runs first and **Block** is terminal.

**Example 2: An explicit V2 Allow doesn't override a V1 Block.** Profile 1 (priority 100) has a V2 rule that explicitly allows `example.com`. Profile 2 (priority 200) has a V1 policy that blocks `example.com`. The V2 module matches the explicit **Allow**, but **Allow** isn't terminal, so evaluation falls through to the V1 module, which blocks `example.com`. The explicit V2 **Allow** is overridden.

> [!NOTE]
> After you create a V2 web filtering policy, the V1 web content filtering experience becomes update-and-delete only. You can edit or remove existing V1 policies, but you can't create new ones. To return to authoring V1 policies, remove all V2 web filtering policies.

## Next steps

- [Migrate web content filtering policies from V1 to V2](how-to-migrate-web-content-filtering-policies.md)
- [How to configure Global Secure Access web content filtering](how-to-configure-web-content-filtering.md)
