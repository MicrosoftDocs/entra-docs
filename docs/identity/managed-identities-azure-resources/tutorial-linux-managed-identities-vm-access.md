---
title: Tutorial - Use a Linux VM/VMSS to access Azure resources
description: A tutorial that shows you how to use a Linux VM/VMSS to access Azure resources.
author: rwike77
manager: CelesteDG

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: tutorial
ms.tgt_pltfrm: na
ms.date: 06/10/2024
ms.author: ryanwi
ms.custom: devx-track-arm-template, devx-track-azurecli, linux-related-content

appliesto:
zone_pivot_groups: identity-linux-vm-access
---

# Tutorial: Use a Linux VM/VMSS to access Azure resources

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

## Prerequisites

- An understanding of managed identities. If you're not familiar with the managed identities for Azure resources feature, see this [overview](~/identity/managed-identities-azure-resources/overview.md).
- An Azure account, [sign up for a free account](https://azure.microsoft.com/free/).
- *Owner* permissions at the appropriate scope (your subscription or resource group) to perform required resource creation and role management steps. If you need assistance with role assignment, see [Assign Azure roles to manage access to your Azure subscription resources](/azure/role-based-access-control/role-assignments-portal).
- A Linux virtual machine (VM) that has system assigned managed identities enabled.
  - If you need to create a VM for this tutorial, see [Create a virtual machine with system-assigned identity enabled](~/identity/managed-identities-azure-resources/how-to-configure-managed-identities.md).

::: zone pivot="identity-linux-mi-vm-access-data-lake"
[!INCLUDE [tutorial-linux-vm-access-datalake](includes/tutorial-linux-vm-access-datalake.md)]
::: zone-end

::: zone pivot="identity-linux-mi-vm-access-storage"
[!INCLUDE [tutorial-linux-vm-access-storage](includes/tutorial-linux-vm-access-storage.md)]
::: zone-end

::: zone pivot="identity-linux-mi-vm-access-sas-key"
[!INCLUDE [tutorial-linux-vm-access-storage-sas](includes/tutorial-linux-vm-access-storage-sas.md)]
::: zone-end


::: zone pivot="identity-linux-mi-vm-access-key"
[!INCLUDE [tutorial-linux-vm-access-storage-access-key](includes/tutorial-linux-vm-access-storage-access-key.md)]
::: zone-end

::: zone pivot="identity-linux-mi-vm-access-key-vault"
[!INCLUDE [tutorial-linux-vm-access-nonaad](includes/tutorial-linux-vm-access-nonaad.md)]
::: zone-end

::: zone pivot="identity-linux-mi-vm-access-arm"
[!INCLUDE [tutorial-linux-vm-access-arm](includes/tutorial-linux-vm-access-arm.md)]
::: zone-end

::: zone pivot="identity-linux-mi-vm-user-arm"
[!INCLUDE [msi-tutorial-linux-vm-access-arm](includes/msi-tutorial-linux-vm-access-arm.md)]
::: zone-end

## Learn more

- [What are managed identities for Azure resources?](~/identity/managed-identities-azure-resources/overview.md)
- [Quickstart: Use a user-assigned managed identity on a VM to access Azure Resource Manager](~/identity/managed-identities-azure-resources/tutorial-linux-managed-identities-vm-access.md)
- [Create, list, or delete a user-assigned managed identity using Azure PowerShell](./how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-powershell)
