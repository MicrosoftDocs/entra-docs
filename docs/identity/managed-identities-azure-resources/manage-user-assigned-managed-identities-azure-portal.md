---
title: Manage user-assigned managed identities using the Azure portal
description: Manage user-assigned managed identities using the Azure portal.
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 09/09/2025
ms.author: shermanouko
---

# Manage user-assigned managed identities using the Azure portal

[!INCLUDE [introduction-section](./includes/manage-user-assigned-identity-intro.md)]

In this article, you learn how to create, list, delete, or assign a role to a user-assigned managed identity by using the Azure portal.

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](overview.md). Be sure to review the [difference between a system-assigned and user-assigned managed identity](overview.md#managed-identity-types).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before you continue.

## Create a user-assigned managed identity

To create a user-assigned managed identity, your account needs the [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role assignment.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the search box, enter **Managed Identities**. Under **Services**, select **Managed Identities**.
1. Select **Add**, and enter values in the following boxes in the **Create User Assigned Managed Identity** pane:
    - **Subscription**: Choose the subscription to create the user-assigned managed identity under.
    - **Resource group**: Choose a resource group to create the user-assigned managed identity in, or select **Create new** to create a new resource group.
    - **Region**: Choose a region to deploy the user-assigned managed identity, for example, **West US**.
    - **Name**: Enter the name for your user-assigned managed identity, for example, UAI1.

   [!INCLUDE [ua-character-limit](~/includes/managed-identity-ua-character-limits.md)]

   :::image type="content" source="media/how-manage-user-assigned-managed-identities/create-user-assigned-managed-identity-portal.png" alt-text="Screenshot that shows the Create User Assigned Managed Identity pane.":::

1. Select **Review + create** to review the changes.
1. Select **Create**.

## List user-assigned managed identities

To list or read a user-assigned managed identity, your account needs to have either [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) or [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role assignments.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the search box, enter **Managed Identities**. Under **Services**, select **Managed Identities**.
1. A list of the user-assigned managed identities for your subscription is returned. To see the details of a user-assigned managed identity, select its name.
1. You can now view the details about the managed identity as shown in the image.

   :::image type="content" source="media/how-manage-user-assigned-managed-identities/list-user-assigned-managed-identity-portal.png" alt-text="Screenshot that shows the list of user-assigned managed identity.":::

## Delete a user-assigned managed identity

To delete a user-assigned managed identity, your account needs the [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role assignment. Deleting a user-assigned identity doesn't remove it from the resource it was assigned to.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Select the user-assigned managed identity, and select **Delete**.
1. Under the confirmation box, select **Yes**.


   :::image type="content" source="media/how-manage-user-assigned-managed-identities/delete-user-assigned-managed-identity-portal.png" alt-text="Screenshot that shows the Delete user-assigned managed identities.":::

## Manage access to user-assigned managed identities

In some environments, administrators choose to limit who can manage user-assigned managed identities. Administrators can implement this limitation using [built-in](/azure/role-based-access-control/built-in-roles#identity) RBAC roles. You can use these roles to grant a user or group in your organization rights over a user-assigned managed identity.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the search box, enter **Managed Identities**. Under **Services**, select **Managed Identities**.
1. A list of the user-assigned managed identities for your subscription is returned. Select the user-assigned managed identity that you want to manage.
1. Select **Access control (IAM)**.
1. Choose **Add role assignment**.

   :::image type="content" source="media/how-manage-user-assigned-managed-identities/role-assign.png" alt-text="Screenshot that shows the user-assigned managed identity access control screen.":::

1. In the **Add role assignment** pane, choose the role to assign and choose **Next**.
1. Choose who should have the role assigned.

## Related content

[Assign a managed identity access to a resource by using the Azure portal](/azure/role-based-access-control/role-assignments-portal-managed-identity)
