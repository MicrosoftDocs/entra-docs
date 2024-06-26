--- 
author: barclayn
ms.author: barclayn
ms.date: 06/03/2024
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - devx-track-azurepowershell
---

## Use Azure RBAC to assign a managed identity access to another resource using PowerShell

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

To run the scripts in this example, you have two options:
- Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top-right corner of code blocks.
- Run scripts locally by installing the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell), then sign in to Azure using `Connect-AzAccount`. 

1. Enable managed identity on an Azure resource, [such as an Azure VM](~/identity/managed-identities-azure-resources/how-to-configure-managed-identities.md).

1. Give the Azure virtual machine (VM) access to a storage account. 
   1. Use [Get-AzVM](/powershell/module/az.compute/get-azvm) to get the service principal for the VM named `myVM`, which was created when you enabled managed identity. 
   1. Use [New-AzRoleAssignment](/powershell/module/az.resources/new-azroleassignment) to give the VM **Reader** access to a storage account called `myStorageAcct`:

    ```azurepowershell-interactive
    $spID = (Get-AzVM -ResourceGroupName myRG -Name myVM).identity.principalid
    New-AzRoleAssignment -ObjectId $spID -RoleDefinitionName "Reader" -Scope "/subscriptions/<mySubscriptionID>/resourceGroups/<myResourceGroup>/providers/Microsoft.Storage/storageAccounts/<myStorageAcct>"
    ```
