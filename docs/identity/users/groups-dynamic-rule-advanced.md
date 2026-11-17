---
title: Use MemberOf Next and Transitive Reports To in dynamic membership groups (preview)
description: Learn how to use MemberOf Next and Transitive Reports To to build dynamic membership groups from the members of other groups or from a manager's full reporting hierarchy in Microsoft Entra ID.
ms.topic: how-to
ms.date: 11/18/2026
ai-usage: ai-assisted
# Customer intent: As an IT admin, I want to build dynamic membership groups from members of other groups or from a manager's full reporting hierarchy, so that I don't have to maintain those memberships manually or with scripts.
---

# Use MemberOf Next and Transitive Reports To in dynamic membership groups (preview)

Simplify group management and reduce manual maintenance with two new capabilities for dynamic membership groups in Microsoft Entra ID, available with Microsoft Entra ID Governance:

- **MemberOf Next** is the new version of the [MemberOf capability](groups-dynamic-rule-member-of.md). It populates a dynamic membership group or dynamic administrative unit with the members of other groups that you choose. Microsoft Entra flattens the membership, so the group contains the users or devices themselves, not the groups. That means you can use the group in scenarios like app assignments.
- **Transitive Reports To** extends membership across a manager's entire reporting hierarchy, not just the manager's direct reports.

Use these capabilities to scope governance controls, including entitlement management auto-assignment policies and lifecycle workflows.

Groups that use MemberOf Next or Transitive Reports To update on a schedule, twice a day. You put a group on this schedule by setting its priority to **Standard**. Your existing dynamic membership groups aren't affected and keep working the way they do today.

> [!NOTE]
> In the Microsoft Entra admin center, in Microsoft Graph, and in the rule syntax, MemberOf Next is still called **MemberOf**, and the rule syntax hasn't changed. You don't need to rewrite your existing MemberOf rules. To move an existing MemberOf group to MemberOf Next, change the group's priority to **Standard**. For more information, see [Move existing MemberOf groups to MemberOf Next](#move-existing-memberof-groups-to-memberof-next) later in this article.

> [!IMPORTANT]
> MemberOf Next and Transitive Reports To are currently in PREVIEW. This information relates to a prerelease product that might be modified before it's released. Review the preview limitations before you use these rules.

## How Standard priority works

A group whose rule uses MemberOf Next or Transitive Reports To must use Standard priority. If a group's rule uses MemberOf Next or Transitive Reports To and the group isn't set to Standard priority, the group isn't processed and its membership isn't kept up to date. Standard priority groups are processed separately from the rest of your dynamic membership groups.

| | High priority (default) | Standard priority |
| --- | --- | --- |
| Used by | Rules based on user or device attributes, including the Direct Reports rule | Rules that use MemberOf Next or Transitive Reports To |
| When membership updates | As directory changes are processed | On a schedule, twice a day |
| License | Microsoft Entra ID P1 | Microsoft Entra ID Governance |

Here's what to expect from a Standard priority group:

- When you create the group, Microsoft Entra starts processing it right away, so you don't need to wait for the next scheduled update. How long the first update takes depends on how many members need to be added and on other activity in your tenant.
- After that, Microsoft Entra reevaluates the rule and updates the membership twice a day.
- A change in your directory, such as a new hire, a manager change, or a change to a source group, shows up in the group after the next scheduled update.

> [!IMPORTANT]
> Because Standard priority groups update on a schedule, their membership can be out of date until the next update. Don't use these groups when access must be granted or removed right away. For example, don't rely on a Standard priority group to immediately revoke a user's access.

## Prerequisites

- One of the following Microsoft Entra roles. Use the least privileged role that meets your needs.
  - [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
  - [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
  - [Intune Administrator](~/identity/role-based-access-control/permissions-reference.md#intune-administrator), for security groups only. This role can't manage Microsoft 365 groups.
  - [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
- Microsoft Entra ID Governance licenses in your tenant. See [License requirements](#license-requirements).

## License requirements

MemberOf Next and Transitive Reports To require Microsoft Entra ID Governance. Microsoft Entra ID Governance is also included in other Microsoft license plans. For the current list, see [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).

For member users in your tenant, you must have enough licenses that include Microsoft Entra ID Governance to cover:

- Each unique user who is a member of one or more dynamic membership groups that use MemberOf Next or Transitive Reports To.
- Each administrator who creates or configures these groups.

Count each user only once, even if they belong to multiple groups that use these capabilities or are also an administrator who configures them. You don’t need to assign these licenses to individual users.

For example, if these groups contain 1,000 unique member users and two administrators who aren’t included in those groups configure them, your tenant needs at least 1,002 licenses that include Microsoft Entra ID Governance.

Licensing requirements for other dynamic membership groups are unchanged. For more information, see [License requirements for dynamic membership groups](groups-dynamic-membership.md#license-requirements).

For licensing prerequisites for advanced dynamic groups capabilities, see [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).

If your tenant no longer has Microsoft Entra ID Governance licenses, groups that use these rules stop updating and show a processing error on the group's overview page.

## MemberOf Next

Use MemberOf Next when the people or devices you need are already in other groups, and you want a single group that includes all of their members. The groups whose members you include are called *source groups*. For example, create a project group that contains everyone in the *Project team* group and everyone in the *Security department* group. In that example, *Project team* and *Security department* are the source groups.

- Source groups must have assigned membership. A dynamic membership group can't be a source group. If a source group is changed to dynamic membership after you save the rule, processing for your group is paused and its membership can become out of date.
- MemberOf Next works with both users and devices. For users, the dynamic membership group can be a security group or a Microsoft 365 group. For devices, use a security group, because Microsoft 365 groups can contain only users.
- A user who is in more than one source group appears in the dynamic membership group once.
- Only direct members of a source group are included. If a source group contains another group, the members of that nested group aren't included.

### How MemberOf Next differs from the earlier memberOf preview

The earlier MemberOf preview was not scalable and could slow down dynamic membership group processing for every group in a tenant. MemberOf Next is rebuilt on a new processing architecture designed for large tenants.

Groups that use it run separately from your other dynamic membership groups, so they don't slow down processing for the rest of your tenant. They update on a predictable schedule, twice a day. You can also use up to 1,000 of these groups per tenant, twice the earlier limit, combine MemberOf with other conditions in one rule, and create rules with the rule builder.

What stays the same is the name you see in the product and the rule syntax, so your existing rules keep working.

| | Earlier memberOf preview | MemberOf Next |
| --- | --- | --- |
| Status | Ended November 3, 2026 | Public preview |
| Name in the admin center and rule syntax | MemberOf | MemberOf (unchanged) |
| Rule syntax | `user.memberOf -any (group.objectId -in [...])` | Same syntax. You can also combine it with other expressions. |
| Processing | Shared with all other dynamic membership groups | Separate, on Standard priority |
| Update timing | Not predictable | Twice a day |
| Effect on other dynamic membership groups | Could slow processing for the whole tenant | None |
| Groups per tenant | 500 | 1,000, shared with Transitive Reports To |
| Combine with other expressions in one rule | No | Yes |
| Rule builder | No, rule syntax box only | Yes |
| License | Microsoft Entra ID P1 | Microsoft Entra ID Governance |

MemberOf Next and Transitive Reports To are built for governance scenarios in large tenants and run on dedicated processing. That's why they're part of Microsoft Entra ID Governance.

For retirement and migration guidance for the earlier preview, see [Deprecated memberOf preview for dynamic membership groups](groups-dynamic-rule-member-of.md).

### Rule syntax

For a group of users:

```text
user.memberOf -any (group.objectId -in ['<groupObjectId1>', '<groupObjectId2>'])
```

For a group of devices:

```text
device.memberOf -any (group.objectId -in ['<groupObjectId1>', '<groupObjectId2>'])
```

Replace each placeholder with the object ID of a source group. The syntax is the same as in the earlier memberOf preview. With MemberOf Next, you can also combine the rule with other expressions. See [Combine MemberOf Next with other expressions](#combine-memberof-next-with-other-expressions) later in this article.

### Create a group with MemberOf Next

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Browse to **Entra ID** > **Groups** > **All groups**.
1. Select **New group**.
1. For **Group type**, select **Security** or **Microsoft 365**, and then enter a group name.
1. For **Membership type**, select **Dynamic User** or **Dynamic Device**.
1. For **Group priority**, select **Standard**.
1. Select **Add dynamic query**.
1. In the rule builder, open the **Operator** list and select **MemberOf**.
1. In **Value**, enter the object IDs of the source groups, separated by commas. The rule appears in the **Rule syntax** box.

    :::image type="content" source="./media/groups-dynamic-rule-advanced/member-of-rule-builder.png" alt-text="Screenshot of the dynamic membership rule builder with the MemberOf operator, a source group object ID, and the generated rule syntax.":::

1. Select **Save rule**, and then select **Create**.

### Combine MemberOf Next with other expressions

You can narrow a MemberOf Next rule with other expressions. For example, this rule includes members of a source group who are located in Redmond:

```text
user.memberOf -any (group.objectId -in ['77a8c4ab-f93d-47e7-8dd9-f464b2541342']) -and user.city -eq "Redmond"
```

After you select **MemberOf** in the rule builder, you can't add more expressions there. To add them, edit the rule in the **Rule syntax** box.

### Move existing MemberOf groups to MemberOf Next

If your tenant has Microsoft Entra ID Governance and has dynamic membership groups that use MemberOf from the earlier preview, you don't need to re-create the groups or rewrite their rules. Change each group's priority to **Standard**. The rule and the current members stay the same, and the group starts updating on the Standard priority schedule.

> [!IMPORTANT]
> Before you change a group's priority, check that every source group in its rule still exists. If a source group was deleted, remove its object ID from the rule first. A group whose rule references a source group that no longer exists can't be updated.

To change the priority of one group in the Microsoft Entra admin center:

1. Browse to **Entra ID** > **Groups** > **All groups**, and select the group.
1. Select **Properties**.
1. For **Group priority**, select **Standard**, and then select **Save**.

To change the priority with Microsoft Graph:

```http
PATCH https://graph.microsoft.com/beta/groups/{group-id}
Content-Type: application/json

{
  "dynamicMembershipPriority": "Standard"
}
```

To change the priority of every dynamic membership group in your tenant that uses MemberOf, you can use Microsoft Graph PowerShell. The following script requires version 2.41.2 or later of the `Microsoft.Graph.Authentication` and `Microsoft.Graph.Groups` modules. Before you run it, replace `<tenant-id>` with your tenant ID. The script shows how many groups it found, changes the priority of each group to Standard, and then lists each group's priority so that you can confirm the change.

```powershell
Import-Module Microsoft.Graph.Authentication -MinimumVersion 2.41.2 -ErrorAction Stop
Import-Module Microsoft.Graph.Groups -MinimumVersion 2.41.2 -ErrorAction Stop
Connect-MgGraph -TenantId "<tenant-id>" `
    -Scopes "Group.ReadWrite.All" -ErrorAction Stop

$groups = @(Get-MgGroup -All `
    -Filter "groupTypes/any(c:c eq 'DynamicMembership')" `
    -Property Id,DisplayName,MembershipRule `
    -ErrorAction Stop |
    Where-Object { $_.MembershipRule -match 'memberOf' })

Write-Host "Target groups: $($groups.Count)"

foreach ($group in $groups) {
    Invoke-MgGraphRequest -Method PATCH `
        -Uri "https://graph.microsoft.com/beta/groups/$($group.Id)" `
        -Body @{ dynamicMembershipPriority = "Standard" } `
        -ErrorAction Stop
}

foreach ($group in $groups) {
    Invoke-MgGraphRequest -Method GET `
        -Uri "https://graph.microsoft.com/beta/groups/$($group.Id)?`$select=id,displayName,dynamicMembershipPriority" `
        -ErrorAction Stop |
        ConvertTo-Json -Depth 5
}
```

## Transitive Reports To

Use Transitive Reports To when you need a group for a leader's whole organization. You choose one manager, and the group includes that manager's direct reports, their reports, and so on down the reporting hierarchy, up to 99 levels below the manager. When someone joins the organization, changes managers, or leaves, the next scheduled update adjusts the membership.

> [!NOTE]
> The manager is also added to the group.

### How Transitive Reports To compares to Direct Reports

| | Direct Reports | Transitive Reports To |
| --- | --- | --- |
| Who's included | The manager and the manager's direct reports | The manager and everyone below the manager, at every level |
| Combine with other expressions in one rule | No | Yes |
| Rule builder | No, rule syntax box only | Yes |
| Update timing | As directory changes are processed | Twice a day |

With the Direct Reports rule, a group for a leader's organization stops at the first level, so you need one group per manager or a script to cover the rest. Transitive Reports To covers the whole hierarchy with a single rule. Use Direct Reports when you need only one level.

### Rule syntax

The rule uses the following syntax:

```text
Transitive Reports To {objectID_of_manager}
```

Here's an example of a valid rule, where `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` is the object ID of the manager:

```text
Transitive Reports To aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

The following tips can help you use the rule properly:

- The manager ID is the object ID of the manager. You can find it in the manager's profile.
- The rule follows the **Manager** property at every level. If a user's manager isn't set or is wrong, that user and the people who report up through that user aren't included.

### Create a group with Transitive Reports To

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Browse to **Entra ID** > **Groups** > **All groups**.
1. Select **New group**.
1. For **Group type**, select **Security** or **Microsoft 365**, and then enter a group name.
1. For **Membership type**, select **Dynamic User**.
1. For **Group priority**, select **Standard**.
1. Select **Add dynamic query**.
1. In the rule builder, open the **Operator** list and select **TransitiveReportsTo**.
1. In **Value**, enter the manager's object ID. The rule appears in the **Rule syntax** box.

    :::image type="content" source="./media/groups-dynamic-rule-advanced/transitive-reports-to-rule-builder.png" alt-text="Screenshot of the dynamic membership rule builder with the TransitiveReportsTo operator, a manager object ID, and the generated rule syntax.":::

1. Select **Save rule**, and then select **Create**.

### Combine Transitive Reports To with other expressions

Unlike the Direct Reports rule, you can narrow a Transitive Reports To rule with other conditions. For example, this rule includes the people in a manager's organization who work in one country:

```text
Transitive Reports To aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb -and user.country -eq "United States"
```

After you select **TransitiveReportsTo** in the rule builder, you can't add more expressions there. To add them, edit the rule in the **Rule syntax** box.

Transitive Reports To works only with users. You can't use it to add devices to a group, and a rule that combines it with a device property, such as `device.deviceOSType`, is rejected.

## Dynamic administrative units

You can also use MemberOf Next in the membership rule of a dynamic administrative unit. The rule syntax is the same as for a group. An administrative unit that uses MemberOf Next must use Standard priority, and your tenant must have Microsoft Entra ID Governance. Administrative units that use MemberOf Next count toward the same limit of 1,000 as groups that use MemberOf Next or Transitive Reports To.

## Check whether a group is up to date

Open the group's page in the Microsoft Entra admin center to see its processing status and when the membership was last updated. If processing failed, the page shows the error. For more information, see [Check the processing status for a rule](groups-create-rule.md#check-the-processing-status-for-a-rule).

## Preview limitations

The following limitations apply during public preview.

### Limits

| Limit | Value |
| --- | --- |
| Groups and administrative units per tenant that use MemberOf Next or Transitive Reports To, combined | 1,000. After your tenant reaches this limit, you can't create more groups or administrative units that use these rules. |
| Source groups in one MemberOf Next rule | 50 |
| Levels of the reporting hierarchy below the manager that Transitive Reports To follows | 99 |

These limits also apply:

- These groups count toward the limit of 15,000 dynamic membership groups per tenant.
- Entitlement management auto-assignment policies that use MemberOf count toward the 1,000 limit.
- Dynamic administrative units that use MemberOf Next count toward the 1,000 limit.
- If a rule has more than 50 source groups, you can't save it.

### Rules

- A group that uses MemberOf Next or Transitive Reports To must use Standard priority. If the group isn't set to Standard priority, it isn't processed and its membership isn't kept up to date.
- Standard priority is available only for groups that use MemberOf Next or Transitive Reports To. A rule that uses only user or device attributes can't use Standard priority.
- MemberOf Next includes only the direct members of each source group. Members of nested groups aren't included. Source groups must have assigned membership. A dynamic membership group can't be a source group.
- You can't combine MemberOf Next or Transitive Reports To with the `-match` or `-notMatch` operators.
- In the rule builder, you can't add expressions after you select **MemberOf** or **TransitiveReportsTo**. Use the **Rule syntax** box.
- Transitive Reports To works only with users. You can't use it to add devices to a group or combine it with device properties.
- You can't use **Validate Rules** to test a rule that uses MemberOf Next or Transitive Reports To.
- If processing is paused for a group when you change its rule, the rule is saved without being checked. Any error appears on the group's page in the Microsoft Entra admin center after you resume processing.

### Timing

- Membership updates twice a day, not immediately. Don't use these groups when access must change right away.
- Directory changes take time to become available to membership processing. If you create a group right after you change manager assignments or create a source group, the group might not reflect those changes until the next scheduled update.

### If a group or manager in a rule can't be found

A rule can reference a group or manager that Microsoft Entra can't find. This happens when:

- The object ID in the rule is mistyped.
- The source group or manager was deleted.
- The source group or manager was created or restored recently, and the change hasn't reached membership processing yet.

Here's what happens:

- The dynamic membership group isn't updated in that run. Microsoft Entra tries again at each scheduled update.
- If the object becomes available, the group starts updating again at the next scheduled update. For example, if you restore a deleted source group, you don't need to change the rule.
- If the object ID is wrong or the object was permanently deleted, the group doesn't start updating again on its own. Edit the rule to remove or correct the object ID.

### Availability

- Available only in the Microsoft Entra public cloud. Not available in national clouds, such as Microsoft Azure Government or Microsoft Azure operated by 21Vianet.

## Frequently asked questions

### How is MemberOf Next different from the earlier MemberOf preview that ended?

The earlier MemberOf preview was not scalable and could slow down dynamic membership group processing for every group in a tenant. MemberOf Next is rebuilt on a new processing architecture designed for large tenants. Groups that use it run separately from your other dynamic membership groups, so they don't slow down processing for the rest of your tenant. They update on a predictable schedule, twice a day. You can also use up to 1,000 of these groups per tenant, twice the earlier limit, combine MemberOf with other conditions in one rule, and create rules with the rule builder.

### Do I need to rewrite my existing MemberOf rules?

No. MemberOf Next uses the same name in the product and the same rule syntax as the earlier preview to enable easier migration. If your tenant has Microsoft Entra ID Governance, change the group's priority to **Standard**.

### Do my existing dynamic membership groups change?

No. Existing dynamic membership groups keep their current priority and keep working the way they do today.

### How long does it take for a new group to get its members?

Microsoft Entra starts processing a new Standard priority group as soon as you create it. It doesn't wait for the next scheduled update. How long the first update takes depends on how many members need to be added and on other activity in your tenant. To see when the membership was last updated, open the group's overview page in the Microsoft Entra admin center and check **Last membership change**.

### Why isn't a new user in the group yet?

Standard priority groups update twice a day. A directory change shows up after the next scheduled update.

### Can I change when or how often Standard priority groups update?

No. The update schedule is managed by Microsoft. You can't change when or how often a Standard priority group updates.

### Can I use these groups for Conditional Access or other access scenarios?

Yes, as long as the scenario can wait for the next scheduled update. Don't use these groups when access must be granted or removed right away.

### What happens if I delete a source group or enter the wrong object ID?

The group stops updating until the object can be found or you correct the rule. Microsoft Entra tries again at each scheduled update.

## Related content

- [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md)
- [Create or update a dynamic membership group in Microsoft Entra ID](groups-create-rule.md)
- [Understand and manage dynamic group processing in Microsoft Entra ID](manage-dynamic-group.md)
