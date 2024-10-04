---
title: View service principal for a managed identity
description: Step-by-step instructions for viewing the service principal of a managed identity.

author: rwike77
manager: CelesteDG

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.tgt_pltfrm: na
ms.date: 06/04/2024
ms.author: ryanwi
ms.custom: devx-track-azurecli, devx-track-azurepowershell

appliesto:
zone_pivot_groups: identity-mi-service-principals
---

# View the service principal of a managed identity

Managed identities for Azure resources provide Azure services with an automatically managed identity in Microsoft Entra ID. You can use this identity to authenticate to any service that supports Microsoft Entra authentication without having credentials in your code. 

In this article, you'll learn how to view the service principal of a managed identity.

> [!NOTE] 
> Service principals are enterprise applications. 

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, see [What are managed identities for Azure resources?](~/identity/managed-identities-azure-resources/overview.md).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.
- Enable [system assigned identity on a virtual machine](~/identity/managed-identities-azure-resources/qs-configure-portal-windows-vm.md#system-assigned-managed-identity) or [application](/azure/app-service/overview-managed-identity#add-a-system-assigned-identity).

::: zone pivot="identity-mi-service-principal-portal"
[!INCLUDE [how-to-view-managed-identity-service-principal-portal](includes/how-to-view-managed-identity-service-principal-portal.md)]
::: zone-end

::: zone pivot="identity-mi-service-principal-cli"
[!INCLUDE [how-to-view-managed-identity-service-principal-cli](includes/how-to-view-managed-identity-service-principal-cli.md)]
::: zone-end

::: zone pivot="identity-mi-service-principal-powershell"
[!INCLUDE [how-to-view-managed-identity-service-principal-powershell](includes/how-to-view-managed-identity-service-principal-powershell.md)]
::: zone-end
 
