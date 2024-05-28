---
title: "Tutorial: Use a managed identity to access Azure Resource Manager"
description: A tutorial that walks you through the process of using a user-assigned managed identity to access Azure Resource Manager.
author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: tutorial
ms.tgt_pltfrm: na
ms.date: 05/28/2024
ms.author: barclayn
ms.custom: devx-track-azurepowershell, devx-track-arm-template
appliesto: 
zone_pivot_groups: identity-windows-vm-access
---

# Tutorial: Use a user-assigned managed identity on a Windows VM to access Azure Resource Manager

This tutorial explains how to create a user-assigned identity, assign it to a Windows virtual machine (VM), and then use that identity to access the Azure Resource Manager API. Managed service identities, automatically managed by Azure, enable authentication to services that support Microsoft Entra authentication without needing to embed credentials into your code.

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

::: zone pivot="windows-vm-access-wvm" [!INCLUDE tutorial-windows-vm-access-arm] ::: zone-end
::: zone pivot="windows-vm-access-lvm" [!INCLUDE tutorial-windows-vm-ua-arm] ::: zone-end

## Next steps

In this quickstart, you learned how to use a system-assigned managed identity to access the Azure Resource Manager API.  To learn more about Azure Resource Manager, see:

> [!div class="nextstepaction"]
>[Azure Resource Manager](/azure/azure-resource-manager/management/overview)
