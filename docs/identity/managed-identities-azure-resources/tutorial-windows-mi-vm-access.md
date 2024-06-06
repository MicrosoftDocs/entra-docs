---
title: Tutorial - Use a Windows VM/VMSS to access Azure services 
description: A tutorial that shows you how to use a Windows VM/VMSS to access Azure services.
author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: tutorial
ms.date: 06/06/2024
ms.author: barclayn

ms.custom: mode-api, devx-track-azurecli, devx-track-linux
ms.devlang: azurecli

appliesto:
zone_pivot_groups: identity-windows-mi-vm-access
---

# Tutorial: Use a Windows VM/VMSS to access Azure services

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

::: zone pivot="identity-windows--mi-vm-access-data-lake"
[!INCLUDE [tutorial-windows-vm-access-datalake](includes/tutorial-windows-vm-access-datalake.md)]
::: zone-end

::: zone pivot="identity-windows--mi-vm-access-storage"
[!INCLUDE [tutorial-windows-vm-access-storage-sas](includes/tutorial-windows-vm-access-storage-sas.md)]
::: zone-end

::: zone pivot="identity-windows--mi-vm-access-sql-db"
[!INCLUDE [tutorial-windows-vm-access-sql](includes/tutorial-windows-vm-access-sql.md)]
::: zone-end

::: zone pivot="identity-windows--mi-vm-access-key-vault"
[!INCLUDE [tutorial-windows-vm-access-nonaad](includes/tutorial-windows-vm-access-nonaad.md)]
::: zone-end

::: zone pivot="identity-windows--mi-vm-access-resource-manager"
[!INCLUDE [tutorial-windows-vm-access-arm](includes/tutorial-windows-vm-access-arm.md)]
::: zone-end

## Learn more

- [What are managed identities for Azure resources?](~/identity/managed-identities-azure-resources/overview.md)
- [Quickstart: Use a user-assigned managed identity on a VM to access Azure Resource Manager](~/identity/managed-identities-azure-resources/tutorial-windows-vm-access.md)
- [Create, list, or delete a user-assigned managed identity using Azure PowerShell](./how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-powershell)
