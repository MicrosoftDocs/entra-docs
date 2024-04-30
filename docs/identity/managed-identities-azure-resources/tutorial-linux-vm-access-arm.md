---
title: "Quickstart`:` Use a managed identity to access Azure Resource Manager"
description: A quickstart that walks you through the process of using a Linux VM system-assigned managed identity to access Azure Resource Manager.

author: barclayn
manager: amycolannino
editor: bryanla
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: quickstart
ms.tgt_pltfrm: na
ms.date: 01/11/2022
ms.author: barclayn

ms.custom: mode-other, devx-track-arm-template
---

# Use a Linux VM system-assigned managed identity to access Azure Resource Manager

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

This quickstart shows you how to use a system-assigned managed identity as a Linux virtual machine (VM)'s identity to access the Azure Resource Manager API. Managed identities for Azure resources are automatically managed by Azure and enable you to authenticate to services that support Microsoft Entra authentication without needing to insert credentials into your code. 
You learn how to:

> [!div class="checklist"]
> * Grant your VM access to a Resource Group in Azure Resource Manager 
> * Get an access token using the VM identity and use it to call Azure Resource Manager 

## Prerequisites

- An understanding of Managed identities. If you're not familiar with managed identities, see this [overview](overview.md). 
- An Azure account, [sign up for a free account](https://azure.microsoft.com/free/).
- You also need a Linux Virtual machine that has system assigned managed identities enabled. If you have a VM but need to enable [system assigned managed identities](qs-configure-portal-windows-vm.md) you can do it in the identity section of the virtual machine's properties. 
  - If you need to create  a virtual machine for this tutorial, you can follow the article titled [Create a Linux virtual machine with the Azure portal](/azure/virtual-machines/linux/quick-create-portal#create-virtual-machine)

## Grant access

[!INCLUDE [portal updates](~/includes/portal-update.md)]

When you use managed identities for Azure resources, your code can get access tokens to authenticate to resources that support Microsoft Entra authentication. The Azure Resource Manager API supports Microsoft Entra authentication. First, we need to grant this VM's identity access to a resource in Azure Resource Manager, in this case, the Resource Group in which the VM is contained.  

1. Sign in to the [Azure portal](https://portal.azure.com) with your administrator account.
1. Navigate to the tab for **Resource Groups**.
1. Select the **Resource Group** you want to grant the VM's managed identity access.
1. In the left panel, select **Access control (IAM)**.
1. Select **Add**, and then select **Add role assignment**.
1. In the **Role** tab, select **Reader**. This role allows view all resources, but doesn't allow you to make any changes.
1. In the **Members** tab, for the **Assign access to**, select **Managed identity**. Then, select **+ Select members**.
1. Ensure the proper subscription is listed in the **Subscription** dropdown. And for **Resource Group**, select **All resource groups**.
1. For the **Manage identity** dropdown, select **Virtual Machine**.
1. Finally, in **Select** choose your Windows Virtual Machine in the dropdown and select **Save**.

    :::image type="content" source="media/msi-tutorial-linux-vm-access-arm/msi-permission-linux.png" alt-text="Screenshot showing adding the reader role to the managed identity.":::

## Get an access token using the VM's system-assigned managed identity and use it to call Resource Manager

To complete these steps, you need an SSH client. If you're using Windows, you can use the SSH client in the [Windows Subsystem for Linux](/windows/wsl/about). If you need assistance configuring your SSH client's keys, see [How to Use SSH keys with Windows on Azure](/azure/virtual-machines/linux/ssh-from-windows), or [How to create and use an SSH public and private key pair for Linux VMs in Azure](/azure/virtual-machines/linux/mac-create-ssh-keys).

1. In the portal, navigate to your Linux VM and in the **Overview**, select **Connect**.

2. **Connect** to the VM with the SSH client of your choice.

3. In the terminal window, using `curl`, make a request to the local managed identities for Azure resources endpoint to get an access token for Azure Resource Manager.
 
The `curl` request for the access token is below.

```bash
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/' -H Metadata:true
```

> [!NOTE]
> The value of the `resource` parameter must be an exact match for what is expected by Microsoft Entra ID. In the case of the Resource Manager resource ID, you must include the trailing slash on the URI.

The response includes the access token you need to access Azure Resource Manager.

Response:

```json
{
  "access_token":"eyJ0eXAiOi...",
  "refresh_token":"",
  "expires_in":"3599",
  "expires_on":"1504130527",
  "not_before":"1504126627",
  "resource":"https://management.azure.com",
  "token_type":"Bearer"
}
```

You can use this access token to access Azure Resource Manager, for example to read the details of the Resource Group to which you previously granted this VM access. Replace the values of `<SUBSCRIPTION-ID>`, `<RESOURCE-GROUP>`, and `<ACCESS-TOKEN>` with the ones you created earlier.

> [!NOTE]
> The URL is case-sensitive, so ensure if you are using the exact same case as you used earlier when you named the Resource Group, and the uppercase “G” in “resourceGroup”.  

```bash
curl https://management.azure.com/subscriptions/<SUBSCRIPTION-ID>/resourceGroups/<RESOURCE-GROUP>?api-version=2016-09-01 -H "Authorization: Bearer <ACCESS-TOKEN>" 
```

The response back with the specific Resource Group information:
 
```json
{
"id":"/subscriptions/98f51385-2edc-4b79-bed9-7718de4cb861/resourceGroups/DevTest",
"name":"DevTest",
"location":"westus",
"properties":
{
  "provisioningState":"Succeeded"
  }
} 
```

## Next steps

In this quickstart, you learned how to use a system-assigned managed identity to access the Azure Resource Manager API. For more information about Azure Resource Manager, see:

> [!div class="nextstepaction"]
>[Azure Resource Manager](/azure/azure-resource-manager/management/overview)
>[Create, list or delete a user-assigned managed identity using Azure PowerShell](./how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-powershell)
