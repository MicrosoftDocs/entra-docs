---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 01/16/2025
ms.topic: include
ms.custom: sfi-image-nochange
---

In this article, you learn how to enable and disable system and user-assigned managed identities for an Azure Virtual Machine (VM), using the Azure portal. 

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](~/identity/managed-identities-azure-resources/overview.md).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.

## System-assigned managed identity

In this section, you learn how to enable and disable the system-assigned managed identity for VM using the Azure portal.

### Enable system-assigned managed identity during creation of a VM

To enable system-assigned managed identity on a VM during its creation, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment.  No other Microsoft Entra directory role assignments are required.

When creating a [Windows virtual machine](/azure/virtual-machines/windows/quick-create-portal#create-virtual-machine) or [Linux virtual machine](/azure/virtual-machines/linux/quick-create-portal#create-virtual-machine), select the **Management** tab.

In the **Identity** section, select the **Enable system assigned managed identity** check-box.  

:::image type="content" source="../media/msi-qs-configure-portal-windows-vm/enable-system-assigned-identity-vm-creation.png" alt-text="Screenshot showing how to enable system-assigned identity during VM creation.":::


### Enable system-assigned managed identity on an existing VM


To enable system-assigned managed identity on a VM that was originally provisioned without it, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment.  No other Microsoft Entra directory role assignments are required.

1. Sign in to the [Azure portal](https://portal.azure.com) using an account associated with the Azure subscription that contains the VM.

2. Navigate to the desired Virtual Machine and in the **Security** section select **Identity**.

3. Under **System assigned**, **Status**, select **On** and then click **Save**:

   :::image type="content" source="../media/msi-qs-configure-portal-windows-vm/create-windows-vm-portal-configuration-blade.png" alt-text="Screenshot that shows the Identity page with the System assigned status set to On."::: 

### Remove system-assigned managed identity from a VM

To remove system-assigned managed identity from a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment.  No other Microsoft Entra directory role assignments are required.

If you have a Virtual Machine that no longer needs system-assigned managed identity:

1. Sign in to the [Azure portal](https://portal.azure.com) using an account associated with the Azure subscription that contains the VM. 

2. Navigate to the desired Virtual Machine and in the **Security** section select **Identity**.

3. Under **System assigned**, **Status**, select **Off** and then click **Save**:

   :::image type="content" source="../media/msi-qs-configure-portal-windows-vm/create-windows-vm-portal-configuration-blade-disable.png" alt-text="Screenshot of the configuration page.":::

## User-assigned managed identity

 In this section, you learn how to add and remove a user-assigned managed identity from a VM using the Azure portal.

### Assign a user-assigned identity during the creation of a VM

To assign a user-assigned identity to a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) and [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) role assignments. No other Microsoft Entra directory role assignments are required.

Currently, the Azure portal does not support assigning a user-assigned managed identity during the creation of a VM. First create a [Windows virtual machine](/azure/virtual-machines/windows/quick-create-portal#create-virtual-machine) or [Linux virtual machine](/azure/virtual-machines/linux/quick-create-portal#create-virtual-machine), then assign a user-assigned managed identity to the VM.

### Assign a user-assigned managed identity to an existing VM

To assign a user-assigned identity to a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) and [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) role assignments. No other Microsoft Entra directory role assignments are required.

1. Sign in to the [Azure portal](https://portal.azure.com) using an account associated with the Azure subscription that contains the VM.

2. Navigate to the desired VM and click **Security** > **Identity**, **User assigned** and then **\+Add**.  Click the user-assigned identity you want to add to the VM and then click **Add**.

3. Select the previously created [user assigned managed identity](../how-manage-user-assigned-managed-identities.md#create-a-user-assigned-managed-identity) from the list.

   :::image type="content" source="../media/msi-qs-configure-portal-windows-vm/add-user-assigned-identity-vm-screenshot1.png" alt-text="Screenshot that shows the Identity page with User assigned selected and the Add button highlighted.":::

### Remove a user-assigned managed identity from a VM

To remove a user-assigned identity from a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment. No other Microsoft Entra directory role assignments are required.

Sign in to the [Azure portal](https://portal.azure.com) using an account associated with the Azure subscription that contains the VM.

Navigate to the desired VM and select **Security** > **Identity**, **User assigned**, the name of the user-assigned managed identity you want to delete and then click **Remove** (click **Yes** in the confirmation pane).

:::image type="content" source="../media/msi-qs-configure-portal-windows-vm/remove-user-assigned-identity-vm-screenshot.png" alt-text="Screenshot showing how to remove user-assigned managed identity from a VM.":::

## Next steps

- Using the Azure portal, give an Azure VM's managed identity [access to another Azure resource](../how-to-assign-access-azure-resource.md?pivots=identity-mi-access-portal).
