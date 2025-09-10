---
title: Use PowerShell to grant a managed identity access to a resource
description: Step-by-step instructions on using PowerShell to assign a managed identity access to an Azure resource or another resource.

author: SHERMANOUKO
manager: CelesteDG

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 06/03/2024
ms.author: shermanouko
---

# Use PowerShell to grant a managed identity access to a resource

This article shows you how to use PowerShell to give a managed identity access to an Azure resource. In this article, we use the example of an Azure virtual machine (Azure VM) managed identity accessing an Azure storage account. Once you've configured an Azure resource with a managed identity, you can then give the managed identity access to another resource, similar to any security principal.

## Prerequisites

- Be sure you've enabled managed identity on an Azure resource, such as an [Azure virtual machine](how-to-configure-managed-identities.md). 
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.

## Use Azure RBAC to assign a managed identity access to another resource using PowerShell

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

To run the scripts in this example, you have two options:

- Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top-right corner of code blocks.
- Run scripts locally by installing the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell), then sign in to Azure using `Connect-AzAccount`. 

1. Enable managed identity on an Azure resource, [such as an Azure VM](./how-to-configure-managed-identities.md).

1. Give the Azure virtual machine (VM) access to a storage account. 
   1. Use [Get-AzVM](/powershell/module/az.compute/get-azvm) to get the service principal for the VM named `myVM`, which was created when you enabled managed identity. 
   1. Use [New-AzRoleAssignment](/powershell/module/az.resources/new-azroleassignment) to give the VM **Reader** access to a storage account called `myStorageAcct`:

    ```azurepowershell-interactive
    $spID = (Get-AzVM -ResourceGroupName myRG -Name myVM).identity.principalid
    New-AzRoleAssignment -ObjectId $spID -RoleDefinitionName "Reader" -Scope "/subscriptions/<mySubscriptionID>/resourceGroups/<myResourceGroup>/providers/Microsoft.Storage/storageAccounts/<myStorageAcct>"
    ```

## Next steps

- [Configure an application to trust a managed identity](/entra/workload-id/workload-identity-federation-config-app-trust-managed-identity?toc=/entra/identity/managed-identities-azure-resources/toc.json)
- [Use Azure Resources Extension in Visual Studio (VS) Code for Managed Identities](./azure-resources-extension-managed-identities.md)
