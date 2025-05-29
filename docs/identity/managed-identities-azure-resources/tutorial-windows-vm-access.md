---
title: "Tutorial: Use a managed identity on a virtual machine (VM) to access Azure Resource Manager"
description: A tutorial that walks you through the process of using a system-assigned managed identity on a virtual machine (VM) to access Azure Resource Manager.
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: tutorial
ms.tgt_pltfrm: na
ms.date: 05/28/2024
ms.author: shermanouko
ms.custom: devx-track-arm-template, linux-related-content

appliesto:
zone_pivot_groups: identity-windows-vm-access
---

# Tutorial: Use a system-assigned managed identity on a VM to access Azure Resource Manager

This quickstart shows you how to use a system-assigned managed identity as a virtual machine (VM)'s identity to access the Azure Resource Manager API. Managed identities for Azure resources are automatically managed by Azure and enable you to authenticate to services that support Microsoft Entra authentication without needing to insert credentials into your code. 

You'll learn how to:

- Grant your virtual machine (VM) access to a resource group in Azure Resource Manager 
- Get an access token using a virtual machine (VM) identity and use it to call Azure Resource Manager

::: zone pivot="windows-vm-access-wvm" 
[!INCLUDE [windows-vm-access-arm](includes/tutorial-windows-vm-access-arm.md)]
::: zone-end

::: zone pivot="windows-vm-access-lvm" 
[!INCLUDE [windows-vm-ua-arm](includes/tutorial-linux-vm-access-arm.md)] 
::: zone-end

## Next steps

In this quickstart, you learned how to use a system-assigned managed identity on a VM to access the Azure Resource Manager API.  To learn more about Azure Resource Manager, see:

> [!div class="nextstepaction"]
> [Azure Resource Manager](/azure/azure-resource-manager/management/overview)
> [Create, list or delete a user-assigned managed identity using Azure PowerShell](./how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-powershell)
