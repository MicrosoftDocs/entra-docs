---
title: Configure managed identities for Azure resources on virtual machine scale set
description: Step-by-step instructions for configuring managed identities for Azure resources on a virtual machine scale set using the Azure portal.
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: quickstart
ms.date: 01/16/2025
ms.author: shermanouko
ms.custom: mode-api, devx-track-azurecli, devx-track-linux, devx-track-arm-template, devx-track-azurepowershell
ms.devlang: azurecli

appliesto:
zone_pivot_groups: identity-mi-scaled-sets
---

# Configure managed identities for Azure resources on a virtual machine scale set 

Managed identities for Azure resources provide Azure services with an automatically managed identity in Microsoft Entra ID. You can use this identity to authenticate to any service that supports Microsoft Entra authentication, without having credentials in your code. 

For information about Azure Policy definition and details, see [Use Azure Policy to assign managed identities (preview)](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F516187d4-ef64-4a1b-ad6b-a7348502976c).

::: zone pivot="identity-mi-methods-azp"
[!INCLUDE [qs-configure-portal-windows-vmss](includes/qs-configure-portal-windows-vmss.md)]
::: zone-end

::: zone pivot="identity-mi-methods-azcli"
[!INCLUDE [qs-configure-cli-windows-vmss](includes/qs-configure-cli-windows-vmss.md)]
::: zone-end

::: zone pivot="identity-mi-methods-powershell"
[!INCLUDE [qs-configure-powershell-windows-vmss](includes/qs-configure-powershell-windows-vmss.md)]
::: zone-end

::: zone pivot="identity-mi-methods-arm"
[!INCLUDE [qs-configure-template-windows-vmss](includes/qs-configure-template-windows-vmss.md)]
::: zone-end

::: zone pivot="identity-mi-methods-rest"
[!INCLUDE [qs-configure-rest-vmss](includes/qs-configure-rest-vmss.md)]
::: zone-end
