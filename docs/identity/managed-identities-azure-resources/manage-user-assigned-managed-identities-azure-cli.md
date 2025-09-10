---
title: Manage user-assigned managed identities using the Azure CLI
description: Manage user-assigned managed identities using the Azure CLI.
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 09/09/2025
ms.author: shermanouko
---

# Manage user-assigned managed identities using the Azure CLI

[!INCLUDE [introduction-section](./includes/manage-user-assigned-identity-intro.md)]

In this article, you learn how to create, list, delete, or assign a role to a user-assigned managed identity by using the Azure CLI.

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](overview.md). Be sure to review the [difference between a system-assigned and user-assigned managed identity](overview.md#managed-identity-types).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before you continue.

## Prepare your environment

[!INCLUDE [azure-cli-prepare-your-environment-no-header.md](~/../docs/reusable-content/azure-cli/azure-cli-prepare-your-environment-no-header.md)]

To modify user permissions when you use an app service principal by using the CLI, you must provide the service principal more permissions in the Azure Active Directory Graph API because portions of the CLI perform GET requests against the Graph API. Otherwise, you might end up receiving an "Insufficient privileges to complete the operation" message. 

To do this step, 

1. Go into the **App registration** in Microsoft Entra ID, select your app, select **API permissions**, and scroll down and select **Azure Active Directory Graph**.
1. Select **Application permissions**, and then add the appropriate permissions.

## Create a user-assigned managed identity

To create a user-assigned managed identity, your account needs the [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role assignment.

1. Use the `az identity create` command to create a user-assigned managed identity. The `-g` parameter specifies the resource group where to create the user-assigned managed identity. The `-n` parameter specifies its name.
1. Replace the `<RESOURCE GROUP>` and `<USER ASSIGNED IDENTITY NAME>` parameter values with your own values.

    [!INCLUDE [ua-character-limit](~/includes/managed-identity-ua-character-limits.md)]

    ```azurecli-interactive
    az identity create -g <RESOURCE GROUP> -n <USER ASSIGNED IDENTITY NAME>
    ```

## List user-assigned managed identities

To list or read a user-assigned managed identity, your account needs the [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) or [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role assignment.

To list user-assigned managed identities, use the `az identity list` command. Replace the `<RESOURCE GROUP>` value with your own value.

```azurecli-interactive
az identity list -g <RESOURCE GROUP>
```

In the JSON response, user-assigned managed identities have the `"Microsoft.ManagedIdentity/userAssignedIdentities"` value returned for the key `type`.

`"type": "Microsoft.ManagedIdentity/userAssignedIdentities"`

## Delete a user-assigned managed identity

To delete a user-assigned managed identity, your account needs the [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role assignment.

To delete a user-assigned managed identity, 

1. use the `az identity delete` command. The `-n` parameter specifies its name. The `-g` parameter specifies the resource group where the user-assigned managed identity was created.
1. Replace the `<USER ASSIGNED IDENTITY NAME>` and `<RESOURCE GROUP>` parameter values with your own values.

    ```azurecli-interactive
    az identity delete -n <USER ASSIGNED IDENTITY NAME> -g <RESOURCE GROUP>
    ```

    Deleting a user-assigned managed identity won't remove the reference from any resource it was assigned to. Remove those from the resource itself. For example, for a VM or virtual machine scale set, use the `az vm/vmss identity remove` command.

## Related content

For a full list of Azure CLI identity commands, see [az identity](/cli/azure/identity).
