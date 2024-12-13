---
title: Configure managed identities on Azure virtual machines (VMs)
description: Step-by-step instructions for configuring system and user-assigned managed identities on an Azure VMs.
author: rwike77
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: quickstart
ms.date: 05/29/2024
ms.author: ryanwi
ms.custom: mode-api, devx-track-azurecli, devx-track-linux, devx-track-arm-template, devx-track-azurepowershell
ms.devlang: azurecli

appliesto:
zone_pivot_groups: identity-configure-mi-methods
---

# Configure managed identities on Azure virtual machines (VMs)

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

Managed identities for Azure resources provide Azure services with an automatically managed identity in Microsoft Entra ID. You can use this identity to authenticate to any service that supports Microsoft Entra authentication, without having credentials in your code. 

For information about Azure Policy definition and details, see [Use Azure Policy to assign managed identities (preview)](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fd367bd60-64ca-4364-98ea-276775bddd94).


::: zone pivot="qs-configure-portal-windows-vm"
[!INCLUDE [qs-configure-portal-windows-vm](includes/qs-configure-portal-windows-vm.md)]
::: zone-end

::: zone pivot="qs-configure-cli-windows-vm"
[!INCLUDE [qs-configure-cli-windows-vm](includes/qs-configure-cli-windows-vm.md)]
::: zone-end

::: zone pivot="qs-configure-powershell-windows-vm"
[!INCLUDE [qs-configure-powershell-windows-vm](includes/qs-configure-powershell-windows-vm.md)]
::: zone-end

::: zone pivot="qs-configure-template-windows-vm"
[!INCLUDE [qs-configure-template-windows-vm](includes/qs-configure-template-windows-vm.md)]
::: zone-end

::: zone pivot="qs-configure-rest-vm"
[!INCLUDE [qs-configure-rest-vm](includes/qs-configure-rest-vm.md)]
::: zone-end

::: zone pivot="qs-configure-sdk-windows-vm"
[!INCLUDE [qs-configure-sdk-windows-vm](includes/qs-configure-sdk-windows-vm.md)]
::: zone-end
