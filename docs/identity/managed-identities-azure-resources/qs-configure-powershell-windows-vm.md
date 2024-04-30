---
title: Configure managed identities on an Azure VM using PowerShell
description: Step-by-step instructions for configuring managed identities for Azure resources on an Azure VM using PowerShell.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: quickstart
ms.tgt_pltfrm: na
ms.date: 05/10/2023
ms.author: barclayn

ms.custom: devx-track-azurepowershell, mode-api, has-azure-ad-ps-ref, azure-ad-ref-level-one-done

---

# Configure managed identities for Azure resources on an Azure VM using PowerShell

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

Managed identities for Azure resources provide Azure services with an automatically managed identity in Microsoft Entra ID. You can use this identity to authenticate to any service that supports Microsoft Entra authentication, without having credentials in your code.

In this article, using PowerShell, you learn how to perform the following managed identities for Azure resources operations on an Azure VM.

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](overview.md). **Be sure to review the [difference between a system-assigned and user-assigned managed identity](overview.md#managed-identity-types)**.
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.
- To run the example scripts, you have two options:
    - Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top-right corner of code blocks.
    - Run scripts locally by installing the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell), then sign in to Azure using `Connect-AzAccount`. 

## System-assigned managed identity

In this section, we go over how to enable and disable the system-assigned managed identity using Azure PowerShell.

### Enable system-assigned managed identity during creation of an Azure VM

To create an Azure VM with the system-assigned managed identity enabled, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment.  No other Microsoft Entra directory role assignments are required.

1. Refer to one of the following Azure VM Quickstarts, completing only the necessary sections ("Sign in to Azure", "Create resource group", "Create networking group", "Create the VM").

    When you get to the "Create the VM" section, make a slight modification to the [New-AzVMConfig](/powershell/module/az.compute/new-azvm) cmdlet syntax. Be sure to add a `-IdentityType SystemAssigned` parameter to provision the VM with the system-assigned identity enabled, for example:

    ```azurepowershell-interactive
    $vmConfig = New-AzVMConfig -VMName myVM -IdentityType SystemAssigned ...
    ```

   - [Create a Windows virtual machine using PowerShell](/azure/virtual-machines/windows/quick-create-powershell)
   - [Create a Linux virtual machine using PowerShell](/azure/virtual-machines/linux/quick-create-powershell)

### Enable system-assigned managed identity on an existing Azure VM

To enable system-assigned managed identity on a VM that was originally provisioned without it, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment.  No other Microsoft Entra directory role assignments are required.

1. Retrieve the VM properties using the `Get-AzVM` cmdlet. Then to enable a system-assigned managed identity, use the `-IdentityType` switch on the [Update-AzVM](/powershell/module/az.compute/update-azvm) cmdlet:

   ```azurepowershell-interactive
   $vm = Get-AzVM -ResourceGroupName myResourceGroup -Name myVM
   Update-AzVM -ResourceGroupName myResourceGroup -VM $vm -IdentityType SystemAssigned
   ```

### Add VM system assigned identity to a group

After you have enabled system assigned identity on a VM, you can add it to a group.  The following procedure adds a VM's system assigned identity to a group.

1. Retrieve and note the `ObjectID` (as specified in the `Id` field of the returned values) of the VM's service principal:

   ```azurepowershell
   Get-AzADServicePrincipal -displayname "myVM"
   ```

1. Retrieve and note the `ObjectID` (as specified in the `Id` field of the returned values) of the group:

   ```azurepowershell
   Get-AzADGroup -searchstring "myGroup"
   ```

1. Add the VM's service principal to the group:

   ```azurepowershell
   New-MgGroupMember -GroupId "<Id of group>" -DirectoryObjectId "<Id of VM service principal>" 
   ```

## Disable system-assigned managed identity from an Azure VM

To disable system-assigned managed identity on a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment.  No other Microsoft Entra directory role assignments are required.

If you have a Virtual Machine that no longer needs the system-assigned managed identity but still needs user-assigned managed identities, use the following cmdlet:

1. Retrieve the VM properties using the `Get-AzVM` cmdlet and set the `-IdentityType` parameter to `UserAssigned`:

   ```azurepowershell-interactive
   $vm = Get-AzVM -ResourceGroupName myResourceGroup -Name myVM
   Update-AzVm -ResourceGroupName myResourceGroup -VM $vm -IdentityType "UserAssigned" -IdentityID "/subscriptions/<SUBSCRIPTION ID>/resourcegroups/<RESROURCE GROUP>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<USER ASSIGNED IDENTITY NAME>..."
   ```

If you have a virtual machine that no longer needs system-assigned managed identity and it has no user-assigned managed identities, use the following commands:

```azurepowershell-interactive
$vm = Get-AzVM -ResourceGroupName myResourceGroup -Name myVM
Update-AzVm -ResourceGroupName myResourceGroup -VM $vm -IdentityType None
```

## User-assigned managed identity

In this section, you learn how to add and remove a user-assigned managed identity from a VM using Azure PowerShell.

### Assign a user-assigned managed identity to a VM during creation

To assign a user-assigned identity to a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) and [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) role assignments. No other Microsoft Entra directory role assignments are required.

1. Refer to one of the following Azure VM Quickstarts, completing only the necessary sections ("Sign in to Azure", "Create resource group", "Create networking group", "Create the VM").

    When you get to the "Create the VM" section, make a slight modification to the [`New-AzVMConfig`](/powershell/module/az.compute/new-azvm) cmdlet syntax. Add the `-IdentityType UserAssigned` and `-IdentityID` parameters to provision the VM with a user-assigned identity.  Replace `<VM NAME>`,`<SUBSCRIPTION ID>`, `<RESROURCE GROUP>`, and `<USER ASSIGNED IDENTITY NAME>` with your own values.  For example:

    ```azurepowershell-interactive
    $vmConfig = New-AzVMConfig -VMName <VM NAME> -IdentityType UserAssigned -IdentityID "/subscriptions/<SUBSCRIPTION ID>/resourcegroups/<RESROURCE GROUP>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<USER ASSIGNED IDENTITY NAME>..."
    ```

    - [Create a Windows virtual machine using PowerShell](/azure/virtual-machines/windows/quick-create-powershell)
    - [Create a Linux virtual machine using PowerShell](/azure/virtual-machines/linux/quick-create-powershell)


### Assign a user-assigned managed identity to an existing Azure VM

To assign a user-assigned identity to a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) and [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) role assignments. No other Microsoft Entra directory role assignments are required.

1. Create a user-assigned managed identity using the [New-AzUserAssignedIdentity](/powershell/module/az.managedserviceidentity/new-azuserassignedidentity) cmdlet.  Note the `Id` in the output because you'll need this information in the next step.

   > [!IMPORTANT]
   > Creating user-assigned managed identities only supports alphanumeric, underscore and hyphen (0-9 or a-z or A-Z, \_ or -) characters. Additionally, name should be limited from 3 to 128 character length for the assignment to VM/VMSS to work properly. For more information, see [FAQs and known issues](known-issues.md)

   ```azurepowershell-interactive
   New-AzUserAssignedIdentity -ResourceGroupName <RESOURCEGROUP> -Name <USER ASSIGNED IDENTITY NAME>
   ```
1. Retrieve the VM properties using the `Get-AzVM` cmdlet. Then to assign a user-assigned managed identity to the Azure VM, use the `-IdentityType` and `-IdentityID` switch on the [Update-AzVM](/powershell/module/az.compute/update-azvm) cmdlet.  The value for the`-IdentityId` parameter is the `Id` you noted in the previous step.  Replace `<VM NAME>`, `<SUBSCRIPTION ID>`, `<RESROURCE GROUP>`, and `<USER ASSIGNED IDENTITY NAME>` with your own values.

   > [!WARNING]
   > To retain any previously user-assigned managed identities assigned to the VM, query the `Identity` property of the VM object (for example, `$vm.Identity`).  If any user assigned managed identities are returned, include them in the following command along with the new user assigned managed identity you would like to assign to the VM.

   ```azurepowershell-interactive
   $vm = Get-AzVM -ResourceGroupName <RESOURCE GROUP> -Name <VM NAME>
   Update-AzVM -ResourceGroupName <RESOURCE GROUP> -VM $vm -IdentityType UserAssigned -IdentityID "/subscriptions/<SUBSCRIPTION ID>/resourcegroups/<RESROURCE GROUP>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<USER ASSIGNED IDENTITY NAME>"
   ```

### Remove a user-assigned managed identity from an Azure VM

To remove a user-assigned identity to a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment.

If your VM has multiple user-assigned managed identities, you can remove all but the last one using the following commands. Be sure to replace the `<RESOURCE GROUP>` and `<VM NAME>` parameter values with your own values. The `<USER ASSIGNED IDENTITY NAME>` is the user-assigned managed identity's name property, which should remain on the VM. This information is discoverable using a query to search for the `Identity` property of the VM object.  For example, `$vm.Identity`:

```azurepowershell-interactive
$vm = Get-AzVm -ResourceGroupName myResourceGroup -Name myVm
Update-AzVm -ResourceGroupName myResourceGroup -VirtualMachine $vm -IdentityType UserAssigned -IdentityID <USER ASSIGNED IDENTITY NAME>
```
If your VM doesn't have a system-assigned managed identity and you want to remove all user-assigned managed identities from it, use the following command:

```azurepowershell-interactive
$vm = Get-AzVm -ResourceGroupName myResourceGroup -Name myVm
Update-AzVm -ResourceGroupName myResourceGroup -VM $vm -IdentityType None
```
If your VM has both system-assigned and user-assigned managed identities, you can remove all the user-assigned managed identities by switching to use only system-assigned managed identities.

```azurepowershell-interactive
$vm = Get-AzVm -ResourceGroupName myResourceGroup -Name myVm
Update-AzVm -ResourceGroupName myResourceGroup -VirtualMachine $vm -IdentityType "SystemAssigned"
```

## Next steps

- [Managed identities for Azure resources overview](overview.md)
- For the full Azure VM creation Quickstarts, see:

  - [Create a Windows virtual machine with PowerShell](/azure/virtual-machines/windows/quick-create-powershell)
  - [Create a Linux virtual machine with PowerShell](/azure/virtual-machines/linux/quick-create-powershell)
