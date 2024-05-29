---
title: Configure managed identities on Azure virtual machines (VMs)
description: Step-by-step instructions for configuring system and user-assigned managed identities on an Azure VMs.
author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: quickstart
ms.date: 05/29/2024
ms.author: barclayn

ms.custom: mode-api, devx-track-azurecli, devx-track-linux
ms.devlang: azurecli

appliesto:
zone_pivot_groups: identity-configure-mi-methods
---

# Configure managed identities on Azure virtual machines (VMs)

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

Managed identities for Azure resources provide Azure services with an automatically managed identity in Microsoft Entra ID. You can use this identity to authenticate to any service that supports Microsoft Entra authentication, without having credentials in your code. 

::: zone pivot="identity-mi-methods-azp"
[!INCLUDE [qs-configure-portal-windows-vm](includes/qs-configure-portal-windows-vm.md)]
::: zone-end

::: zone pivot="identity-mi-methods-azcli"
[!INCLUDE [qs-configure-cli-windows-vm](includes/qs-configure-cli-windows-vm.md)]
::: zone-end

::: zone pivot="identity-mi-methods-powershell"
[!INCLUDE [qs-configure-powershell-windows-vm](includes/qs-configure-powershell-windows-vm.md)]
::: zone-end

::: zone pivot="identity-mi-methods-arm"
[!INCLUDE [qs-configure-template-windows-vm](includes/qs-configure-template-windows-vm.md)]
::: zone-end

::: zone pivot="identity-mi-methods-rest"
[!INCLUDE [qs-configure-rest-vm](includes/qs-configure-rest-vm.md)]
::: zone-end

::: zone pivot="identity-mi-methods-sdk"
[!INCLUDE [qs-configure-sdk-windows-vm](includes/qs-configure-sdk-windows-vm.md)]
::: zone-end

