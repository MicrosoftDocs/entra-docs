---
title: Deprecated memberOf preview for dynamic membership groups
description: Learn about the deprecated memberOf preview for dynamic membership groups in Microsoft Entra ID and find guidance for moving to MemberOf Next.
ms.topic: concept-article
ms.date: 11/16/2026
ms.reviewer: mbhargav
ms.custom: it-pro
ai-usage: ai-assisted
# Customer intent: As an IT admin, I want to understand the deprecated memberOf preview and find its replacement, so that I can move existing configurations to MemberOf Next.
---

# Deprecated memberOf preview for dynamic membership groups

> [!IMPORTANT]
> The earlier `memberOf` preview was deprecated in favor of **MemberOf Next**. The earlier preview ended on **November 3, 2026**. Dynamic membership groups, dynamic administrative units, and entitlement management auto-assignment policies that still used the earlier preview stopped updating and remained in their last known state.
>
> For current capabilities, requirements, and setup instructions, see [Use MemberOf Next and Transitive Reports To in dynamic membership groups (preview)](groups-dynamic-rule-advanced.md). To move existing groups to MemberOf Next, see [Move existing MemberOf groups to MemberOf Next](groups-dynamic-rule-advanced.md#move-existing-memberof-groups-to-memberof-next).

The earlier `memberOf` preview in Microsoft Entra ID enabled admins to create dynamic membership groups and administrative units that populated by adding members of other groups. Apps that couldn't read group-based membership previously could read the flattened membership of these `memberOf` groups. These groups could also be used for licensing assignments.

The following diagram illustrates how the earlier preview populated Dynamic-Group-A with direct members of Security-Group-X and Security-Group-Y. Members of nested groups inside Security-Group-X and Security-Group-Y weren't included in Dynamic-Group-A.

:::image type="content" source="./media/groups-dynamic-rule-member-of/member-of-diagram.png" alt-text="Diagram that shows how the memberOf attribute worked in the deprecated preview.":::

The earlier preview was available through the Azure portal, Microsoft Graph, and PowerShell. Source groups could be security groups, Microsoft 365 groups, or groups synced from on-premises Active Directory.

## Preview limitations

The following limitations applied to the deprecated preview. For the limitations of its replacement, see [MemberOf Next and Transitive Reports To preview limitations](groups-dynamic-rule-advanced.md#preview-limitations).

- The earlier preview was intended only for test environments because it could affect dynamic group processing across the tenant.
- Each Microsoft Entra tenant was limited to 500 dynamic groups that used the `memberOf` attribute. These groups counted toward the total dynamic group quota of 15,000.
- Each dynamic group could reference up to 50 source groups.
- Only direct members of source groups were included. Members of nested groups weren't included.
- A `memberOf` dynamic group couldn't define the membership of another `memberOf` dynamic group.
- The `memberOf` attribute couldn't be combined with other rules or operators.
- The dynamic group rule builder and rule validation weren't supported for `memberOf`.
- Large numbers of groups or frequent membership updates could slow dynamic membership processing for the tenant.
- Membership didn't automatically update when a source group was deleted. Affected users or devices remained members until the rule was modified.
- The earlier preview was available only in the public cloud.

## Move to MemberOf Next

MemberOf Next replaces the earlier preview with separate processing on a twice-daily schedule. It requires Microsoft Entra ID Governance and Standard priority. The name shown in the product and the rule syntax are unchanged.

For migration requirements and instructions, see [Move existing MemberOf groups to MemberOf Next](groups-dynamic-rule-advanced.md#move-existing-memberof-groups-to-memberof-next). For current setup instructions and guidance for dynamic administrative units, see [Use MemberOf Next and Transitive Reports To in dynamic membership groups (preview)](groups-dynamic-rule-advanced.md).

## Related content

- [Use MemberOf Next and Transitive Reports To in dynamic membership groups (preview)](groups-dynamic-rule-advanced.md).
- [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md).
- [Understand and manage dynamic group processing in Microsoft Entra ID](manage-dynamic-group.md).
