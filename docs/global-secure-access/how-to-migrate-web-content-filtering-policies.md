---
title: Migrate web content filtering policies from V1 to V2
description: "Use the guided experience in Global Secure Access to migrate web content filtering (V1) policies to the web filtering (V2) object model without interrupting enforcement."
ms.topic: how-to
ms.date: 08/14/2026
ms.subservice: entra-internet-access
ai-usage: ai-assisted

#customer intent: As a Global Secure Access administrator, I want to migrate my existing web content filtering (V1) policies to the web filtering (V2) model so that I can manage filtering with a single policy and consistent authoring experience.
---

# Migrate web content filtering policies from V1 to V2

Global Secure Access provides a guided experience to migrate your existing web content filtering (V1) policies to the web filtering (V2) object model. Migration aggregates the V1 policies linked to a security profile into rules under a single, enabled V2 web filtering policy. It preserves each policy's destinations, action, and priority while maintaining continuous enforcement, so you don't have to recreate policies by hand. Because V1 and V2 evaluate policies differently, the combined outcome across profiles might change after migration.

This article explains how the migration experience works, which scenarios are supported and unsupported, what migration does to your policies, and how to monitor migration status. For a conceptual overview of the V2 model, see [Web filtering in Global Secure Access (V2)](concept-web-filtering.md).

## Overview

In V1, a security profile can contain multiple web content filtering policies. In V2, a security profile contains a single web filtering policy that holds multiple rules. Migration bridges these models: each V1 policy linked to a profile becomes a rule under one new V2 policy.

Migration reuses the original V1 policy priority values as rule priorities and maintains continuous enforcement during the transition. Review the resulting V2 policy and validate its behavior because evaluation across multiple security profiles differs between V1 and V2.

> [!NOTE]
> Existing V1 web content filtering policies continue to function unchanged until you migrate them. As part of the V2 model, the feature name changes from Web Content Filtering to Web Filtering.

## Prerequisites

- The Global Secure Access Administrator role to manage web filtering policies and security profiles.
- One or more existing V1 web content filtering policies linked to a security profile.
- A review of the V2 concepts before you migrate. For more information, see [Web filtering in Global Secure Access (V2)](concept-web-filtering.md).

## How the guided migration works

The migration experience is surfaced on the **Security profiles** page. When your tenant is eligible, a banner notifies you that you can migrate your web content filtering policies to the V2 framework and provides an entry point to the guided experience.

You can also reach the experience from the **Web Content Filtering Policies** page, where a banner directs you to **Security profiles** to view and migrate eligible profiles.

### How security profiles are categorized

The migration experience groups your security profiles into three categories, each with explanatory text so you know what action, if any, is required.

| Category | Description |
| --- | --- |
| Eligible security profiles | Profiles that have at least one linked V1 web content filtering policy and don't contain any V2 web filtering policy. These profiles can be migrated automatically. |
| Ineligible security profiles | Profiles that already contain a V2 web filtering policy alongside V1 policies. These profiles can't be migrated automatically and require manual handling. |
| Profiles that don't require migration | Profiles that don't have any linked V1 web content filtering policies. No action is needed. |

Each category lists profiles in a table with the profile name, priority, policy count, state, and last modified date.

### Start the migration

Selecting the migration action migrates all eligible profiles in a single operation. Before the migration runs, you confirm that you want to proceed. After you start the migration, the migration action is disabled to prevent it from running more than once.

## What migration does to your policies

For each eligible security profile, migration performs the following actions:

- Creates a single new, enabled V2 web filtering policy.
- Adds each linked V1 policy as a rule under that V2 policy, preserving its destinations, action, and priority.
- Links the new V2 policy to the security profile and removes the V1 policy links, so there's no gap in enforcement.

### Naming applied to migrated objects

So you can recognize migrated content, the migration workflow applies a consistent naming standard.

| Object | Naming standard |
| --- | --- |
| Policy name | `Migrated-WebFilteringPolicy` |
| Rule name | `Migrated-WebFilteringPolicyRule-[v1PolicyName]` |
| Rule description | `This rule was created by Microsoft as a part of the v2 policy update and enforces the actions defined in the following original (v1) policy: [v1PolicyName]/[v1PolicyDescription]` |

Any description on the original V1 policy is appended to the migrated rule's description.

### Example

A tenant with two V1 web filtering policies, `WebFiltering-Allow` and `WebFiltering-Block`, is migrated to:

- Policy: `Migrated-WebFilteringPolicy`
- Rule 1: `Migrated-WebFilteringPolicyRule-WebFiltering-Allow`
- Rule 2: `Migrated-WebFilteringPolicyRule-WebFiltering-Block`

## Supported and unsupported scenarios

### Supported

- Automatic migration of security profiles that contain one or more linked V1 web content filtering policies and no V2 web filtering policy.
- Migration of multiple eligible profiles in a single action.

### Unsupported

- Profiles that contain both V1 and V2 web filtering policies can't be migrated automatically. To make such a profile eligible, remove its V2 web filtering policy and then run migration, or handle the migration manually.

> [!IMPORTANT]
> The FQDN destination type doesn't exist in V2. When a V1 FQDN policy is migrated, its destination is expressed as a URL and follows URL matching logic, which can match sub-paths rather than only the exact host. Review migrated FQDN destinations to confirm they match the traffic you intend. For more information, see [Web filtering in Global Secure Access (V2)](concept-web-filtering.md).

## V1 and V2 coexistence during migration

After a V2 web filtering policy exists in your tenant, you can no longer create new V1 web content filtering policies. You can only edit or delete existing V1 policies. To return to authoring V1 policies, remove all V2 web filtering policies. A security profile can't contain both V1 and V2 web filtering policies at the same time.

## How migration can change enforcement outcomes

Migration preserves each individual policy's configuration, but because V1 and V2 are evaluated by different modules with different rules, the combined outcome for a user can change after you migrate one or more profiles. This change happens because of two structural differences:

- V1 policies stack across all profiles; a V2 policy doesn't. In V1, every policy linked to every applicable profile is evaluated. In V2, only the first profile that has a V2 policy is consulted. Profiles below it aren't evaluated by the V2 module.
- A V2 policy always produces an outcome (a matched rule or its default action), whereas a V1 policy acts only when a rule matches.

For details about how the two modules run in sequence, see [Web filtering in Global Secure Access (V2)](concept-web-filtering.md). Review the following scenarios and revalidate enforcement after you migrate.

### A V1 allow-all can stop shadowing a block after migration

**Before migration**: Profile 1 (priority 100) has a V1 allow-all policy and no V2 policy. Profile 2 (priority 200) has a V2 policy with a default of **Allow**, plus a V1 policy that blocks Sports. Everything is allowed, including Sports, because Profile 1's higher-priority V1 allow-all matches first in the V1 module, so Profile 2's V1 Sports block never takes effect.

**After migration**: Profile 1 is migrated and now has only a V2 policy (default **Allow**) with no V1 policy. Profile 2 is unchanged. Now everything except Sports is allowed. Profile 1's V2 default **Allow** falls through (not terminal), but because Profile 1 no longer has a V1 allow-all, Profile 2's V1 Sports block is now the only match in the V1 module, so Sports is blocked.

### Stacked V1 blocks might not all survive migration

**Before migration**: Profile 1 (priority 100) has a V1 policy that blocks Gambling. Profile 2 (priority 200) has a V1 policy that blocks Sports. Both categories are blocked, because the V1 module stacks across all profiles.

**After migration**: Both profiles are migrated to V2 (each a V2 **Block** for its category with a default of **Allow**). Now only Gambling is blocked. The V2 module evaluates only Profile 1 (the first profile with a V2 policy): Gambling is blocked, but Sports falls through to Profile 1's default **Allow**. Profile 2's Sports block is never reached, because V2 doesn't stack across profiles.

> [!IMPORTANT]
> If you rely on stacked V1 policies across multiple profiles to block different categories, migrating those profiles independently can drop blocks that were previously enforced. Consolidate the intended blocks into rules on the single V2 policy of the first applicable profile, and validate outcomes in **Traffic logs** after you migrate.

### Other behaviors to watch

- **Only the first V2 profile is consulted.** If a user has V2 policies on multiple profiles, every profile below the first one with a V2 policy is ignored by the V2 module.
- **The V2 default action is a global lever.** If the first applicable V2 profile's policy defaults to **Block**, all traffic that isn't explicitly allowed is terminally blocked and the V1 module never runs. A default of **Allow** sends everything through to the V1 module.
- **"First profile with a V2 policy" isn't the same as global priority.** A lower-priority profile's V2 policy takes effect over a higher-priority profile that simply has no V2 policy.

## Monitor migration status

After you start migration, the experience shows a status indicator that you can leave and return to:

- **In progress**: Migration is running. You can navigate away and return; the status continues to reflect the correct state.
- **Complete**: Migration finished. The experience lists the security profiles that were migrated successfully.
- **Failed**: One or more profiles couldn't be migrated. The experience explains the reason and lists the profiles that weren't migrated so you can address them.

## Troubleshoot migration

If a profile can't be migrated, the experience surfaces a message describing why. Common cases include the following:

| Scenario | What it means |
| --- | --- |
| Profile already migrated | The profile already contains a web filtering policy and can't be automatically migrated. Complete the migration manually. |
| No V1 policies to migrate | The profile doesn't contain linked V1 web content filtering policies, so there's nothing to migrate. |
| Data or configuration issue | The profile can't be automatically migrated because of a data issue, for example, an invalid policy reference, missing or duplicate priorities, or an invalid web category. Complete the migration manually. |

## Microsoft-managed migration

Migration is delivered in two phases:

- **Self-service migration**: You migrate your own eligible security profiles by using the guided experience.
- **Microsoft-managed migration**: After V1 deprecation is announced and a timeline is published, Microsoft migrates any remaining profiles on your behalf, including attached and unattached V1 policies, so all tenants are transitioned to V2 with no loss of policy data and no interruption to enforcement.

## Next steps

- [Web filtering in Global Secure Access (V2)](concept-web-filtering.md)
- [How to configure Global Secure Access web content filtering](how-to-configure-web-content-filtering.md)
