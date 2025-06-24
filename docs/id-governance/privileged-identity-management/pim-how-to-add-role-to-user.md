---
title: Assign Microsoft Entra roles in PIM
description: Learn how to assign Microsoft Entra roles in Privileged Identity Management (PIM).
author: barclayn
manager: pmwongera
ms.service: entra-id-governance
ms.topic: how-to
ms.subservice: privileged-identity-management
ms.date: 12/19/2024
ms.author: barclayn
ms.reviewer: shaunliu
ms.custom: subject-rbac-steps, sfi-ga-nochange, sfi-image-nochange
---

# Assign Microsoft Entra roles in Privileged Identity Management

With Microsoft Entra ID, a Global Administrator can make **permanent** Microsoft Entra admin role assignments. These role assignments can be created using the [Microsoft Entra admin center](~/identity/role-based-access-control/permissions-reference.md) or using [PowerShell commands](/powershell/module/azuread/#directory_roles).

The Microsoft Entra Privileged Identity Management (PIM) service also allows Privileged Role Administrators to make permanent admin role assignments. Additionally, Privileged Role Administrators can make users **eligible** for Microsoft Entra admin roles. An eligible administrator can activate the role when they need it, and then their permissions expire once they're done.

Privileged Identity Management support both built-in and custom Microsoft Entra roles. For more information on Microsoft Entra custom roles, see [Role-based access control in Microsoft Entra ID](~/identity/role-based-access-control/custom-overview.md).

>[!Note]
>When a role is assigned, the assignment:
>- Can't be assigned for a duration of less than five minutes
>- Can't be removed within five minutes of it being assigned

## Assign a role

Follow these steps to make a user eligible for a Microsoft Entra admin role.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Microsoft Entra roles**.

1. Select **Roles** to see the list of roles for Microsoft Entra permissions.

    :::image type="content" source="./media/pim-how-to-add-role-to-user/roles-list.png" alt-text="Screenshot of the Roles page with the Add assignments action selected.":::

1. Select **Add assignments** to open the **Add assignments** page.

1. Select **Select a role** to open the **Select a role** page.

    :::image type="content" source="./media/pim-how-to-add-role-to-user/select-role.png" alt-text="Screenshot showing the new assignment pane.":::

1. Select a role you want to assign, select a member to whom you want to assign to the role, and then select **Next**.

    [!INCLUDE [rbac-assign-roles-guest-user-note](../../includes/rbac-assign-roles-guest-user-note.md)]

1. In the **Assignment type** list on the **Membership settings** pane, select **Eligible** or **Active**.

    - **Eligible** assignments require the member of the role to perform an action to use the role. Actions might include performing a multifactor authentication (MFA) check, providing a business justification, or requesting approval from designated approvers.

    - **Active** assignments don't require the member to perform any action to use the role. Members assigned as active always have the privileges assigned to the role.

1. To specify a specific assignment duration, add a start and end date and time boxes. When finished, select **Assign** to create the new role assignment.

    - **Permanent** assignments have no expiration date. Use this option for permanent workers who frequently need the role permissions.

    - **Time-bound** assignments expire at the end of a specified period. Use this option with temporary or contract workers, for example, whose project end date and time are known.

    :::image type="content" source="./media/pim-how-to-add-role-to-user/start-and-end-dates.png" alt-text="Screenshot showing Memberships settings - date and time.":::

1. After the role is assigned, an assignment status notification is displayed.

    :::image type="content" source="./media/pim-how-to-add-role-to-user/assignment-notification.png" alt-text="Screenshot showing a new assignment notification.":::

## Assign a role with restricted scope

For certain roles, the scope of the granted permissions can be restricted to a single admin unit, service principal, or application. This procedure is an example if assigning a role that has the scope of an administrative unit. For a list of roles that support scope via administrative unit, see [Assign roles with administrative unit scope](../../identity/role-based-access-control/manage-roles-portal.md). This feature is currently being rolled out to Microsoft Entra organizations.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Roles & admins**.

1. Select the **User Administrator**.

    :::image type="content" source="./media/pim-how-to-add-role-to-user/add-assignment.png" alt-text="Screenshot showing the Add assignment command is available when you open a role in the portal.":::

1. ​Select **Add assignments**.

    :::image type="content" source="./media/pim-how-to-add-role-to-user/add-scope.png" alt-text="Screenshot showing when a role supports scope, you can select a scope.":::

1. On the **Add assignments** page, you can:

   - Select a user or group to be assigned to the role
   - Select the role scope (in this case, administrative units)
   - Select an administrative unit for the scope

For more information about creating administrative units, see [Add and remove administrative units](~/identity/role-based-access-control/admin-units-manage.md).

## Assign a role using Microsoft Graph API

For more information about Microsoft Graph APIs for PIM, see [Overview of role management through the privileged identity management (PIM) API](/graph/api/resources/privilegedidentitymanagementv3-overview).

For permissions required to use the PIM API, see [Understand the Privileged Identity Management APIs](pim-apis.md). 

### Eligible with no end date

This example shows an HTTP request to create an eligible assignment with no end date. For details on the API commands including request samples in languages such as C# and JavaScript, see [Create roleEligibilityScheduleRequests](/graph/api/rbacapplication-post-roleeligibilityschedulerequests).

#### HTTP request

````HTTP
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleEligibilityScheduleRequests
Content-Type: application/json

{
    "action": "adminAssign",
    "justification": "Permanently assign the Global Reader to the auditor",
    "roleDefinitionId": "f2ef992c-3afb-46b9-b7cf-a126ee74c451",
    "directoryScopeId": "/",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "scheduleInfo": {
        "startDateTime": "2022-04-10T00:00:00Z",
        "expiration": {
            "type": "noExpiration"
        }
    }
}
````

#### HTTP response

This example shows a response. The response object shown here might be shortened for readability.

````HTTP
HTTP/1.1 201 Created
Content-Type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleEligibilityScheduleRequests/$entity",
    "id": "42159c11-45a9-4631-97e4-b64abdd42c25",
    "status": "Provisioned",
    "createdDateTime": "2022-05-13T13:40:33.2364309Z",
    "completedDateTime": "2022-05-13T13:40:34.6270851Z",
    "approvalId": null,
    "customData": null,
    "action": "adminAssign",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "roleDefinitionId": "f2ef992c-3afb-46b9-b7cf-a126ee74c451",
    "directoryScopeId": "/",
    "appScopeId": null,
    "isValidationOnly": false,
    "targetScheduleId": "42159c11-45a9-4631-97e4-b64abdd42c25",
    "justification": "Permanently assign the Global Reader to the auditor",
    "createdBy": {
        "application": null,
        "device": null,
        "user": {
            "displayName": null,
            "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
    },
    "scheduleInfo": {
        "startDateTime": "2022-05-13T13:40:34.6270851Z",
        "recurrence": null,
        "expiration": {
            "type": "noExpiration",
            "endDateTime": null,
            "duration": null
        }
    },
    "ticketInfo": {
        "ticketNumber": null,
        "ticketSystem": null
    }
}
````

### Active and time-bound

The example shows an HTTP request to create a time bound active assignment. For details on the API commands including request samples in languages such as C# and JavaScript, see [Create roleAssignmentScheduleRequests](/graph/api/rbacapplication-post-roleassignmentschedulerequests).

#### HTTP request

````HTTP
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignmentScheduleRequests 

{
    "action": "adminAssign",
    "justification": "Assign the Exchange Recipient Administrator to the mail admin",
    "roleDefinitionId": "31392ffb-586c-42d1-9346-e59415a2cc4e",
    "directoryScopeId": "/",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "scheduleInfo": {
        "startDateTime": "2022-04-10T00:00:00Z",
        "expiration": {
            "type": "afterDuration",
            "duration": "PT3H"
        }
    }
}
````

#### HTTP response

This example shows the response. The response object shown here might be shortened for readability.

````HTTP
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleAssignmentScheduleRequests/$entity",
    "id": "ac643e37-e75c-4b42-960a-b0fc3fbdf4b3",
    "status": "Provisioned",
    "createdDateTime": "2022-05-13T14:01:48.0145711Z",
    "completedDateTime": "2022-05-13T14:01:49.8589701Z",
    "approvalId": null,
    "customData": null,
    "action": "adminAssign",
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "roleDefinitionId": "31392ffb-586c-42d1-9346-e59415a2cc4e",
    "directoryScopeId": "/",
    "appScopeId": null,
    "isValidationOnly": false,
    "targetScheduleId": "ac643e37-e75c-4b42-960a-b0fc3fbdf4b3",
    "justification": "Assign the Exchange Recipient Administrator to the mail admin",
    "createdBy": {
        "application": null,
        "device": null,
        "user": {
            "displayName": null,
            "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
    },
    "scheduleInfo": {
        "startDateTime": "2022-05-13T14:01:49.8589701Z",
        "recurrence": null,
        "expiration": {
            "type": "afterDuration",
            "endDateTime": null,
            "duration": "PT3H"
        }
    },
    "ticketInfo": {
        "ticketNumber": null,
        "ticketSystem": null
    }
}
````

## Update or remove an existing role assignment

Follow these steps to update or remove an existing role assignment. **Microsoft Entra ID P2 or Microsoft Entra ID Governance licensed customers only**: Don't assign a group as Active to a role through both Microsoft Entra ID and Privileged Identity Management (PIM). For a detailed explanation, see [Known issues](~/identity/role-based-access-control/groups-concept.md#known-issues).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Microsoft Entra roles**. 

1. Select **Roles** to see the list of roles for Microsoft Entra ID.

1. Select the role that you want to update or remove.

1. Find the role assignment on the **Eligible roles** or **Active roles** tabs.

    :::image type="content" source="./media/pim-how-to-add-role-to-user/remove-update-assignments.png" alt-text="Screenshot showing how to update or remove role assignment.":::

1. Select **Update** or **Remove** to update or remove the role assignment.

## Remove eligible assignment via Microsoft Graph API

This example shows an HTTP request to revoke an eligible assignment to a role from a principal. For details on the API commands including request samples in languages such as C# and JavaScript, see [Create roleEligibilityScheduleRequests](/graph/api/rbacapplication-post-roleeligibilityschedulerequests).

### Request

````HTTP
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleEligibilityScheduleRequests 

{ 
    "action": "AdminRemove", 
    "justification": "abcde", 
    "directoryScopeId": "/", 
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222", 
    "roleDefinitionId": "88d8e3e3-8f55-4a1e-953a-9b9898b8876b" 
} 
````

### Response

````HTTP
{ 
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleEligibilityScheduleRequests/$entity", 
    "id": "fc7bb2ca-b505-4ca7-ad2a-576d152633de", 
    "status": "Revoked", 
    "createdDateTime": "2021-07-15T20:23:23.85453Z", 
    "completedDateTime": null, 
    "approvalId": null, 
    "customData": null, 
    "action": "AdminRemove", 
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222", 
    "roleDefinitionId": "88d8e3e3-8f55-4a1e-953a-9b9898b8876b", 
    "directoryScopeId": "/", 
    "appScopeId": null, 
    "isValidationOnly": false, 
    "targetScheduleId": null, 
    "justification": "test", 
    "scheduleInfo": null, 
    "createdBy": { 
        "application": null, 
        "device": null, 
        "user": { 
            "displayName": null, 
            "id": "5d851eeb-b593-4d43-a78d-c8bd2f5144d2" 
        } 
    }, 
    "ticketInfo": { 
        "ticketNumber": null, 
        "ticketSystem": null 
    } 
} 
````

## Next steps

- [Configure Microsoft Entra admin role settings in Privileged Identity Management](pim-how-to-change-default-settings.md)