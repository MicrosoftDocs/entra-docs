---
author: barclayn
ms.author: barclayn
ms.date: 05/27/2024
ms.topic: include
ms.custom:
  - devx-track-azurepowershell
---

In this article, using PowerShell, you learn how to perform the managed identities for Azure resources operations on a virtual machine scale set:

- Enable and disable the system-assigned managed identity on a virtual machine scale set
- Add and remove a user-assigned managed identity on a virtual machine scale set

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](~/identity/managed-identities-azure-resources/overview.md). **Be sure to review the [difference between a system-assigned and user managed assigned identity](~/identity/managed-identities-azure-resources/overview.md#managed-identity-types)**.

- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.

- To perform the management operations in this article, your account needs the following Azure role-based access control assignments:

    > [!NOTE]
    > No additional Microsoft Entra directory role assignments required.

    - [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) to create a virtual machine scale set and enable and remove system-assigned managed and/or user-assigned managed identity from a virtual machine scale set.
    - [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role to create a user-assigned managed identity.
    - [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) role to assign and remove a user-assigned managed identity from and to a virtual machine scale set.

- To run the example scripts, you have two options:
    - Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top-right corner of code blocks.
    - Run scripts locally by installing the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell), then sign in to Azure using `Connect-AzAccount`. 

## System-assigned managed identity

In this section, you learn how to enable and remove a system-assigned managed identity using Azure PowerShell.

### Enable system-assigned managed identity during the creation of an Azure virtual machine scale set

To create a virtual machine scale set with the system-assigned managed identity enabled:

1. Refer to *Example 1* in the [New-AzVmssConfig](/powershell/module/az.compute/new-azvmssconfig) cmdlet reference article to create a virtual machine scale set with a system-assigned managed identity.  Add the parameter `-IdentityType SystemAssigned` to the `New-AzVmssConfig` cmdlet:

    ```azurepowershell-interactive
    $VMSS = New-AzVmssConfig -Location $Loc -SkuCapacity 2 -SkuName "Standard_A0" -UpgradePolicyMode "Automatic" -NetworkInterfaceConfiguration $NetCfg -IdentityType SystemAssigned`
    ```

### Enable system-assigned managed identity on an existing Azure virtual machine scale set

If you need to enable a system-assigned managed identity on an existing Azure virtual machine scale set:

1. Make sure the Azure account you're using belongs to a role that gives you write permissions on the virtual machine scale set, such as "Virtual Machine Contributor".
   
1. Retrieve the virtual machine scale set properties using the [`Get-AzVmss`](/powershell/module/az.compute/get-azvmss) cmdlet. Then to enable a system-assigned managed identity, use the `-IdentityType` switch on the [Update-AzVmss](/powershell/module/az.compute/update-azvmss) cmdlet:

   ```azurepowershell-interactive
   Update-AzVmss -ResourceGroupName myResourceGroup -Name -myVmss -IdentityType "SystemAssigned"
   ```

### Disable the system-assigned managed identity from an Azure virtual machine scale set

If you have a virtual machine scale set that no longer needs the system-assigned managed identity but still needs user-assigned managed identities, use the following cmdlet:

1. Make sure your account belongs to a role that gives you write permissions on the virtual machine scale set, such as "Virtual Machine Contributor".

1. Run the following cmdlet:

   ```azurepowershell-interactive
   Update-AzVmss -ResourceGroupName myResourceGroup -Name myVmss -IdentityType "UserAssigned"
   ```

1. If you have a virtual machine scale set that no longer needs system-assigned managed identity and it has no user-assigned managed identities, use the following command:

    ```azurepowershell-interactive
    Update-AzVmss -ResourceGroupName myResourceGroup -Name myVmss -IdentityType None
    ```
    
## User-assigned managed identity

In this section, you learn how to add and remove a user-assigned managed identity from a virtual machine scale set using Azure PowerShell.

### Assign a user-assigned managed identity during creation of an Azure virtual machine scale set

Creating a new virtual machine scale set with a user-assigned managed identity isn't currently supported via PowerShell. See the next section on how to add a user-assigned managed identity to an existing virtual machine scale set. Check back for updates.

### Assign a user-assigned managed identity to an existing Azure virtual machine scale set

To assign a user-assigned managed identity to an existing Azure virtual machine scale set:

1. Make sure your account belongs to a role that gives you write permissions on the virtual machine scale set, such as "Virtual Machine Contributor".

1. Retrieve the virtual machine scale set properties using the `Get-AzVM` cmdlet. Then to assign a user-assigned managed identity to the virtual machine scale set, use the `-IdentityType` and `-IdentityID` switch on the [Update-AzVmss](/powershell/module/az.compute/update-azvmss) cmdlet. Replace `<VM NAME>`, `<SUBSCRIPTION ID>`, `<RESROURCE GROUP>`, `<USER ASSIGNED ID1>`, `USER ASSIGNED ID2` with your own values.

   [!INCLUDE [ua-character-limit](~/includes/managed-identity-ua-character-limits.md)]

   ```azurepowershell-interactive
   Update-AzVmss -ResourceGroupName <RESOURCE GROUP> -Name <VMSS NAME> -IdentityType UserAssigned -IdentityID "<USER ASSIGNED ID1>","<USER ASSIGNED ID2>"
   ```

### Remove a user-assigned managed identity from an Azure virtual machine scale set

If your virtual machine scale set has multiple user-assigned managed identities, you can remove all but the last one using the following commands. Be sure to replace the `<RESOURCE GROUP>` and `<VIRTUAL MACHINE SCALE SET NAME>` parameter values with your own values. The `<USER ASSIGNED IDENTITY NAME>` is the user-assigned managed identity's name property, which should remain on the virtual machine scale set. This information can be found in the identity section of the virtual machine scale set using `az vmss show`:

```azurepowershell-interactive
Update-AzVmss -ResourceGroupName myResourceGroup -Name myVmss -IdentityType UserAssigned -IdentityID "<USER ASSIGNED IDENTITY NAME>"
```
If your virtual machine scale set doesn't have a system-assigned managed identity and you want to remove all user-assigned managed identities from it, use the following command:

```azurepowershell-interactive
Update-AzVmss -ResourceGroupName myResourceGroup -Name myVmss -IdentityType None
```
If your virtual machine scale set has both system-assigned and user-assigned managed identities, you can remove all the user-assigned managed identities by switching to use only system-assigned managed identity.

```azurepowershell-interactive
Update-AzVmss -ResourceGroupName myResourceGroup -Name myVmss -IdentityType "SystemAssigned"
```

## Next steps

- [Managed identities for Azure resources overview](~/identity/managed-identities-azure-resources/overview.md)
- For the full Azure VM creation Quickstarts, see:
  
  - [Create a Windows virtual machine with PowerShell](/azure/virtual-machines/windows/quick-create-powershell) 
  - [Create a Linux virtual machine with PowerShell](/azure/virtual-machines/linux/quick-create-powershell)
  
