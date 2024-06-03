--- 
author: barclayn 
ms.author: barclayn
ms.date: 06/03/2024 
ms.topic: include
---

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](./overview.md). Be sure to review the [difference between a system-assigned and user-assigned managed identity](./overview.md#managed-identity-types).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.
- To run the example scripts, you have two options:
    - Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top-right corner of code blocks.
    - Run scripts locally by installing the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell), then sign in to Azure using `Connect-AzAccount`. 

## Use Azure RBAC to assign a managed identity access to another resource

1. Enable managed identity on an Azure resource, [such as an Azure VM](how-to-configure-managed-identities.md).

1. In this example, you'll give an Azure virtual machine (VM) access to a storage account. First you use [Get-AzVM](/powershell/module/az.compute/get-azvm) to get the service principal for the VM named `myVM`, which was created when you enabled managed identity. Then, use [New-AzRoleAssignment](/powershell/module/az.resources/new-azroleassignment) to give the VM **Reader** access to a storage account called `myStorageAcct`:

    ```azurepowershell-interactive
    $spID = (Get-AzVM -ResourceGroupName myRG -Name myVM).identity.principalid
    New-AzRoleAssignment -ObjectId $spID -RoleDefinitionName "Reader" -Scope "/subscriptions/<mySubscriptionID>/resourceGroups/<myResourceGroup>/providers/Microsoft.Storage/storageAccounts/<myStorageAcct>"
    ```
