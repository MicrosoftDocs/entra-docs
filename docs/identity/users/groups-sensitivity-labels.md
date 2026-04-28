---
title: Assign sensitivity labels to Microsoft Entra security groups (preview)
description: Learn how to apply sensitivity labels to cloud security groups in Microsoft Entra ID for consistent classification and governance.
ms.topic: how-to
ms.date: 03/25/2026
ai-usage: ai-assisted
---

# Assign sensitivity labels to Microsoft Entra security groups (preview)

Microsoft Entra ID lets you apply sensitivity labels to cloud security groups when those labels are published in the Microsoft Purview portal and configured for use with groups and sites. This feature doesn't apply to on-premises security groups.

This capability extends the existing sensitivity label support for Microsoft 365 groups to Microsoft Entra security groups, enabling consistent classification and governance across your organization's group types. The same labels configured for Microsoft 365 groups and sites in Microsoft Purview also apply to cloud security groups. No separate label configuration is required.

> [!NOTE]
> These group types aren't supported: security groups synced from on-premises Active Directory, Exchange managed security groups, and groups with dynamic membership.

> [!IMPORTANT]
> This feature is in preview. Certain behaviors, including the ability to change labels once they're set and enforcement for high-privilege roles, might change before general availability. To configure this feature, there must be at least one active Microsoft Entra ID P1 license in your Microsoft Entra organization.

## Key differences from Microsoft 365 group labeling

Sensitivity labels for cloud security groups share the same underlying label infrastructure as Microsoft 365 groups, but there are important behavioral differences:

| **Behavior** | **Microsoft 365 groups** | **Cloud security groups (preview)** |
|---|---|---|
| **Label mutability** | Labels can be changed or removed by group owners and admins at any time. | **Labels are immutable** once applied. Labels can't be changed or removed. |
| **Label assignment** | Available at group creation or on existing groups. | Available at group creation or on existing groups. To label a group with child groups, remove all child groups first, apply the label, and then add the child groups back. |
| **Membership validation** | Membership additions are validated against label policies. | Membership additions are validated against label policies. Existing membership is validated against label guest policy on first assignment of label. |
| **Nesting support** | Microsoft 365 groups don't support nesting. | Supported, but child groups must have labels that are equally or more restrictive than the parent group's label. For details, see [Nesting behavior with labeled groups](#nesting-behavior-with-labeled-groups). |
| **Admin / high-privilege bypass** | Admins respect label policies. | During preview, certain built-in admin roles and apps with specific permissions **can bypass label enforcement.** For the full list, see [Known limitations](#known-limitations-preview). This behavior might change before general availability. |

> [!NOTE]
> Sensitivity labels for mail-enabled security groups and distribution lists aren't supported.

## Why labels are immutable in preview

Microsoft 365 groups are collaboration constructs that apply membership to shared content and workloads such as SharePoint, Teams, and Exchange. In contrast, Microsoft Entra ID security groups are authorization primitives, which are security principals that Microsoft Entra ID and downstream access control systems evaluate for membership.

When a sensitivity label applied to a cloud security group forbids guest access, **Microsoft Entra ID must validate effective membership at evaluation time**. Effective membership includes both direct group members and members inherited transitively through nested groups. Validation ensures that no guests are present at any level of the group hierarchy.

Security groups are used directly in authorization decisions such as Conditional Access scoping, application access, and resource permissions. Their labeled membership represents a bundle of entitlements whose enforcement depends on Microsoft Entra ID's membership resolution and validation logic, not solely on administrative governance practices. **Current validation processes apply only on group creation or when a label is first assigned.** Extending these validation processes for other scenarios is in progress.

> [!WARNING]
> Changes to a sensitivity label's protection policies in Microsoft Purview take effect immediately on all security groups that use that label. For example, if you change a label from blocking guest access to allowing it, all groups with that label immediately permit guest membership. Conversely, tightening a policy takes effect immediately as well. Deleting a label in Purview removes it, and its protections, from all labeled groups. Before you modify or delete a label, carefully evaluate the impact on existing security groups.

## Known limitations (preview)

During preview, the following limitations apply:

- **Label immutability:** Once applied, a label can't be changed or removed. Choose labels carefully before you apply them.
- **High-privilege bypass:** The following admin roles and application permissions can bypass label policy enforcement when adding members. This behavior might change before general availability.

  **Admin roles:** Global Administrator, User Administrator, Groups Administrator, Directory Writers, Exchange Administrator, SharePoint Administrator, SharePoint Advanced Management Administrator, Teams Administrator, Yammer Administrator, Helpdesk Administrator, Service Support Administrator

  **Application permissions:** `Group.ReadWrite.All`, `Directory.ReadWrite.All`, `Directory.ReadWriteAdvanced.All`, `GroupMember.ReadWrite.All`

- **No nested group labeling:** You can't apply a label to a security group that contains nested groups. Remove all nested groups first, apply the label, label the child groups individually, and then add them back. Child group labels must be compatible with the parent.
- **Dynamic membership groups:** Security groups with dynamic membership aren't supported.
- **Mail-enabled security groups and distribution lists:** Not supported.

## Prerequisites

Before you can assign sensitivity labels to cloud security groups, ensure the following conditions are met:

1. Your organization has at least one active **Microsoft Entra ID P1** or P2 license (or Microsoft 365 E3/E5).
1. The `EnableMIPLabels` setting is set to `True` for cloud security groups in your tenant directory settings.
1. Sensitivity labels are published in the Microsoft Purview portal with the **Groups & Sites** scope enabled.
1. Labels are synchronized to Microsoft Entra ID by using the `Execute-AzureAdLabelSync` cmdlet. Labels can take up to 24 hours after synchronization to become available.
1. Microsoft Graph PowerShell SDK is installed.

## Enable sensitivity label support in PowerShell

To apply sensitivity labels to cloud security groups, you must enable the feature by creating or updating tenant-level directory settings. Cloud security groups use the `Group.Security` settings template, which is separate from the `Group.Unified` template used for Microsoft 365 groups.

> [!NOTE]
> If you already enabled sensitivity labels for Microsoft 365 groups, you still need to complete these steps to enable them for cloud security groups. The two group types use separate directory setting templates.

1. Open a PowerShell prompt and install the Graph modules required to run the cmdlets.

   ```powershell
   Install-Module Microsoft.Graph -Scope CurrentUser
   Install-Module Microsoft.Graph.Beta -Scope CurrentUser
   ```

1. Connect to your tenant.

   ```powershell
   Connect-MgGraph -Scopes "Directory.ReadWrite.All"
   ```

1. Create the tenant-level directory settings for cloud security groups. Use the `Group.Security` template ID.

   ```powershell
   $params = @{
       templateId = "d209f6fa-3839-4d70-b83f-60b1c64d0e8f"
       values = @(
           @{
               name = "AllowToAddGuests"
               value = "True"
           }
           @{
               name = "EnableMIPLabels"
               value = "True"
           }
       )
   }
   New-MgBetaDirectorySetting -BodyParameter $params
   ```

1. Verify the settings were created.

   ```powershell
   (Get-MgBetaDirectorySetting | Where-Object {
       $_.DisplayName -eq "Group.Security"
   }).Values
   ```

   You should see `EnableMIPLabels` = `True` in the output.

**If the settings already exist and you need to update them:**

```powershell
$Setting = Get-MgBetaDirectorySetting -Search DisplayName:"Group.Security"
$params = @{
    Values = @(
        @{
            Name = "EnableMIPLabels"
            Value = "True"
        }
    )
}
Update-MgBetaDirectorySetting -DirectorySettingId $Setting.Id `
    -BodyParameter $params
```

If you receive a `Request_BadRequest` error, the settings already exist. Use `Get-MgBetaDirectorySetting | Format-List` to find the correct setting ID, then issue the `Update-MgBetaDirectorySetting` cmdlet with that ID.

You also need to synchronize your sensitivity labels to Microsoft Entra ID. For instructions, see [Enable sensitivity labels for containers and synchronize labels](/purview/sensitivity-labels-teams-groups-sites#how-to-enable-sensitivity-labels-for-containers-and-synchronize-labels) in the Purview documentation.

## Assign a label to a new security group in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Groups Administrator.
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups** > **New group**.
1. On the New Group page, select **Security** as the group type.
1. Fill out the required information and select a sensitivity label from the **Sensitivity label** dropdown.

   > [!WARNING]
   > Once a sensitivity label is applied and the group is created, the label can't be changed or removed. Verify the label aligns with your intended access and usage policy before you proceed. This behavior might change before general availability.

1. Add owners and members as needed. If the selected label includes a policy that blocks guest access, you can't add guest members.
1. Select **Create** to save your changes.

The group is created and the membership restrictions associated with the selected label are enforced.

## Assign a label to an existing security group in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Groups Administrator.
1. Select **Microsoft Entra ID**.
1. Select **Groups** > **All groups**, then select the group you want to label.
1. On the group's page, select **Properties**.
1. Select a sensitivity label from the **Sensitivity label** dropdown.

   > [!WARNING]
   > Once applied, the label can't be changed or removed. If the group's current membership conflicts with the selected label's policy (for example, the group contains guests and the label blocks guest access), the save operation fails. Resolve the conflict before you apply the label.

1. Select **Save** to apply your changes.

You can also assign labels to security groups from the [My Groups portal](https://myaccount.microsoft.com/groups).

## Assign a label using PowerShell or Microsoft Graph

### Apply a label to a new security group

```powershell
$param = @{
    description = "Your Group Description"
    displayName = "Your Group Name"
    mailEnabled = $false
    securityEnabled = $true
    mailNickname = "YourGroupNickName"
    assignedLabels = @(
        @{ "LabelId" = "<labelID>" }
    )
}
New-MgBetaGroup @param
```

To retrieve available label IDs, use the List sensitivityLabels Microsoft Graph API.

### Apply a label to an existing security group

```powershell
$assignedLabels = @(
    @{ "LabelId" = "<labelID>" }
)
Update-MgBetaGroup -GroupId <groupId> -AssignedLabels $assignedLabels
```

### Add a member to a labeled security group

```powershell
$userUPN = "user1@domain.com"
$user = Get-MgBetaUser -UserId $userUPN
$odataID = "https://graph.microsoft.com/v1.0/directoryObjects/" + $user.Id
New-MgBetaGroupMemberByRef -GroupId <groupId> -OdataId $odataID
```

When you add members to a labeled group, Microsoft Entra ID validates that the new member complies with the label's restrictions. If validation fails (for example, adding a guest to a group with a no-guests policy), the operation is blocked and an error is returned.

## Nesting behavior with labeled groups

When working with nested groups and sensitivity labels, the following rules apply:

- **You can't label a group that currently contains nested groups.** To label a parent group, remove all nested (child) groups first, apply the label to the parent, and then add the child groups back.
- **Child groups must have a compatible label.** When you add a child group back to a labeled parent, the child group's label must be at least as restrictive as the parent's label. A child group with a less restrictive label (lower priority) can't be added as a member of a more restrictive parent group.
- **Unlabeled groups cannot be nested under a labeled parent.** If the parent group has a label, all child groups must also be labeled with a compatible label before they can be added.

### Steps to label a parent group with nested groups

1. Remove all nested groups from the parent group.
1. Apply the desired label to the parent group.
1. Apply labels to each child group (labels must be equal to or more restrictive than the parent's label).
1. Add the labeled child groups back to the parent group.

## Troubleshooting

### Sensitivity labels aren't available for assignment on a security group

The sensitivity label option appears for cloud security groups only when all the following conditions are met:

1. The organization has an active Microsoft Entra ID P1 license.
1. `EnableMIPLabels` is set to `True` in the `Group.Security` directory settings.
1. Sensitivity labels are published in the Microsoft Purview portal for this Microsoft Entra organization.
1. Labels are synchronized to Microsoft Entra ID by using the `Execute-AzureAdLabelSync` cmdlet. Labels can take up to 24 hours after synchronization to become available.
1. The sensitivity label scope is configured for **Groups & Sites**.
1. The group is a Cloud Security group with **assigned** membership type (not dynamic).
1. The current signed-in user has sufficient privileges to assign sensitivity labels (group owner or at least a Groups Administrator) and is within the scope of the sensitivity label publishing policy.

### Label assignment fails due to membership conflict

If you attempt to apply a label whose policy conflicts with the group's current membership, the operation fails with an error. Common scenarios include:

- **Applying a label that blocks guest access to a group that contains guest members.** Resolution: Remove the guest members, then apply the label.
- **Applying any label to a group that contains nested groups.** Resolution: Remove all nested groups, apply the label, label the child groups, and then add them back.

### Member addition fails due to label conflict

If you attempt to add a member (guest or nested group) to a cloud security group whose label policy conflicts with the group's current membership, the operation fails with an error. Common scenarios include:

- **Adding a guest member to a group with a label that blocks guest access.** Resolution: You can't add guests to a group whose label doesn't allow guest access.
- **Adding an unlabeled nested group to a labeled parent group.** Resolution: Apply a label to the nested group that's equally or more restrictive than the parent group's label, then add the nested group.
- **Adding a nested group with a less restrictive label to a parent group.** Resolution: The nested group must have a label that's equally or more restrictive than the parent group's label. If the nested group has a less restrictive label, you can't add it.

### The label cannot be changed or removed

During preview, sensitivity labels on cloud security groups are immutable. Once you apply a label, it can't be modified or removed. If you need to change the label, create a new security group with the desired label and migrate the membership.

### Known issue: assignedLabels not returned in PowerShell

There's a known issue where the `assignedLabels` property might not be populated when you query a group through PowerShell. As a workaround, use Microsoft Graph Explorer or the Graph API directly:

```http
GET https://graph.microsoft.com/v1.0/groups/{groupId}?$select=assignedLabels
```

or

```http
GET https://graph.microsoft.com/v1.0/groups/{groupId}/assignedlabels
```
