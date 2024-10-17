---
title: Assign Azure resource roles in Privileged Identity Management
description: Learn how to assign Azure resource roles in Privileged Identity Management (PIM).
author: barclayn
ms.author: barclayn
manager: amycolannino
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 01/22/2024
ms.subservice: privileged-identity-management

---

# Assign Azure resource roles in Privileged Identity Management

With Microsoft Entra Privileged Identity Management (PIM), you can manage the built-in Azure resource roles, and custom roles, including (but not limited to):

- Owner
- User Access Administrator
- Contributor
- Security Admin
- Security Manager

> [!NOTE]
> Users or members of a group assigned to the Owner or User Access Administrator subscription roles, and Microsoft Entra Global Administrators that enable subscription management in Microsoft Entra ID have Resource administrator permissions by default. These administrators can assign roles, configure role settings, and review access using Privileged Identity Management for Azure resources. A user can't manage Privileged Identity Management for Resources without Resource administrator permissions. View the list of [Azure built-in roles](/azure/role-based-access-control/built-in-roles).

Privileged Identity Management support both built-in and custom Azure roles. For more information on Azure custom roles, see [Azure custom roles](/azure/role-based-access-control/custom-roles).

## Role assignment conditions

You can use the Azure attribute-based access control (Azure ABAC) to add conditions on eligible role assignments using Microsoft Entra PIM for Azure resources. With Microsoft Entra PIM, your end users must activate an eligible role assignment to get permission to perform certain actions. Using conditions in Microsoft Entra PIM enables you not only to limit a user's role permissions to a resource using fine-grained conditions, but also to use Microsoft Entra PIM to secure the role assignment with a time-bound setting, approval workflow, audit trail, and so on.

>[!Note]
>When a role is assigned, the assignment:
>- Can't be assigned for a duration of less than five minutes
>- Can't be removed within five minutes of it being assigned

Currently, the following built-in roles can have conditions added:

- [Storage Blob Data Contributor](/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor)
- [Storage Blob Data Owner](/azure/role-based-access-control/built-in-roles#storage-blob-data-owner)
- [Storage Blob Data Reader](/azure/role-based-access-control/built-in-roles#storage-blob-data-reader)

For more information, see [What is Azure attribute-based access control (Azure ABAC)](/azure/role-based-access-control/conditions-overview).

## Assign a role

Follow these steps to make a user eligible for an Azure resource role.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Access Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

1. Browse to **Identity governance** > **Privileged Identity Management** > **Azure resources**.

1. Select the **resource type** you want to manage. Start at either the **Management group** dropdown or the **Subscriptions** dropdown, and then further select **Resource groups** or **Resources** as needed. Click the Select button for the resource you want to manage to open its overview page.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-list.png" alt-text="Screenshot that shows how to select Azure resources.":::

1. Under **Manage**, select **Roles** to see the list of roles for Azure resources.

1. Select **Add assignments** to open the **Add assignments** pane.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-roles.png" alt-text="Screenshot of Azure resources roles.":::

1. Select a **Role** you want to assign.
1. Select **No member selected** link to open the **Select a member or group** pane.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-select-role.png" alt-text="Screenshot of the new assignment pane.":::

1. Select a member or group you want to assign to the role and then choose **Select**.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-select-member-or-group.png" alt-text="Screenshot that demonstrates how to select a member or group pane.":::

1. On the **Settings** tab, in the **Assignment type** list, select **Eligible** or **Active**.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-membership-settings-type.png" alt-text="Screenshot of add assignments settings pane.":::

    Microsoft Entra PIM for Azure resources provides two distinct assignment types:

    - **Eligible** assignments require the member to activate the role before using it. Administrator may require role member to perform certain actions before role activation, which might include performing a multi-factor authentication (MFA) check, providing a business justification, or requesting approval from designated approvers.

    - **Active** assignments don't require the member to activate the role before usage. Members assigned as active have the privileges assigned ready to use. This type of assignment is also available to customers that don't use Microsoft Entra PIM.

1. To specify a specific assignment duration, change the start and end dates and times.

1. If the role has been defined with actions that permit assignments to that role with conditions, then you can select **Add condition** to add a condition based on the principal user and resource attributes that are part of the assignment.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/new-assignment-conditions.png" alt-text="Screenshot of the new assignment conditions pane.":::
    
    Conditions can be entered in the expression builder. 

    :::image type="content" source="./media/pim-resource-roles-assign-roles/new-assignment-condition-expression.png" alt-text="Screenshot of the new assignment condition built from an expression.":::

1. When finished, select **Assign**.

1. After the new role assignment is created, a status notification is displayed.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-new-assignment-notification.png" alt-text="Screenshot of a new assignment notification.":::

## Assign a role using ARM API

Privileged Identity Management supports Azure Resource Manager (ARM) API commands to manage Azure resource roles, as documented in the [PIM ARM API reference](/rest/api/authorization/role-eligibility-schedule-requests). For the permissions required to use the PIM API, see [Understand the Privileged Identity Management APIs](pim-apis.md).

The following example is a sample HTTP request to create an eligible assignment for an Azure role.

### Request

````HTTP
PUT https://management.azure.com/providers/Microsoft.Subscription/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleEligibilityScheduleRequests/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e?api-version=2020-10-01-preview
````

### Request body

````JSON
{
  "properties": {
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "roleDefinitionId": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleDefinitions/c8d4ff99-41c3-41a8-9f60-21dfdad59608",
    "requestType": "AdminAssign",
    "scheduleInfo": {
      "startDateTime": "2022-07-05T21:00:00.91Z",
      "expiration": {
        "type": "AfterDuration",
        "endDateTime": null,
        "duration": "P365D"
      }
    },
    "condition": "@Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'",
    "conditionVersion": "1.0"
  }
}
````

### Response

Status code: 201

````HTTP
{
  "properties": {
    "targetRoleEligibilityScheduleId": "b1477448-2cc6-4ceb-93b4-54a202a89413",
    "targetRoleEligibilityScheduleInstanceId": null,
    "scope": "/providers/Microsoft.Subscription/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
    "roleDefinitionId": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleDefinitions/c8d4ff99-41c3-41a8-9f60-21dfdad59608",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "principalType": "User",
    "requestType": "AdminAssign",
    "status": "Provisioned",
    "approvalId": null,
    "scheduleInfo": {
      "startDateTime": "2022-07-05T21:00:00.91Z",
      "expiration": {
        "type": "AfterDuration",
        "endDateTime": null,
        "duration": "P365D"
      }
    },
    "ticketInfo": {
      "ticketNumber": null,
      "ticketSystem": null
    },
    "justification": null,
    "requestorId": "a3bb8764-cb92-4276-9d2a-ca1e895e55ea",
    "createdOn": "2022-07-05T21:00:45.91Z",
    "condition": "@Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'",
    "conditionVersion": "1.0",
    "expandedProperties": {
      "scope": {
        "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
        "displayName": "Pay-As-You-Go",
        "type": "subscription"
      },
      "roleDefinition": {
        "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/roleDefinitions/c8d4ff99-41c3-41a8-9f60-21dfdad59608",
        "displayName": "Contributor",
        "type": "BuiltInRole"
      },
      "principal": {
        "id": "a3bb8764-cb92-4276-9d2a-ca1e895e55ea",
        "displayName": "User Account",
        "email": "user@my-tenant.com",
        "type": "User"
      }
    }
  },
  "name": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
  "id": "/providers/Microsoft.Subscription/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/providers/Microsoft.Authorization/RoleEligibilityScheduleRequests/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
  "type": "Microsoft.Authorization/RoleEligibilityScheduleRequests"
}
````

## Update or remove an existing role assignment

Follow these steps to update or remove an existing role assignment.

1. Open **Microsoft Entra Privileged Identity Management**.

1. Select **Azure resources**.

1. Select the **resource type** you want to manage. Start at either the **Management group** dropdown or the **Subscriptions** dropdown, and then further select **Resource groups** or **Resources** as needed. Click the Select button for the resource you want to manage to open its overview page.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-list.png" alt-text="Screenshot that shows how to select Azure resources to update.":::

1. Under **Manage**, select **Roles** to list the roles for Azure resources. The following screenshot lists the roles of an Azure Storage account. Select the role that you want to update or remove.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-update-select-role.png" alt-text="Screenshot that shows the roles of an Azure Storage account.":::

1. Find the role assignment on the **Eligible roles** or **Active roles** tabs.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-update-remove.png" alt-text="Screenshot demonstrates how to update or remove role assignment." lightbox="./media/pim-resource-roles-assign-roles/resources-update-remove.png":::

1. To add or update a condition to refine Azure resource access, select **Add** or **View/Edit** in the **Condition** column for the role assignment. Currently, the Storage Blob Data Owner, Storage Blob Data Reader, and Storage Blob Data Contributor roles in Microsoft Entra PIM are the only roles that can have conditions added.

1. Select **Add expression** or **Delete** to update the expression. You can also select **Add condition** to add a new condition to your role.

    :::image type="content" source="./media/pim-resource-roles-assign-roles/resources-abac-update-remove.png" alt-text="Screenshot that demonstrates how to update or remove attributes of a role assignment." lightbox="./media/pim-resource-roles-assign-roles/resources-abac-update-remove.png":::

    For information about extending a role assignment, see [Extend or renew Azure resource roles in Privileged Identity Management](pim-resource-roles-renew-extend.md).

## Next steps

- [Configure Azure resource role settings in Privileged Identity Management](pim-resource-roles-configure-role-settings.md)
- [Assign Microsoft Entra roles in Privileged Identity Management](pim-how-to-add-role-to-user.md)
