---
title: Assign a managed identity access to an Azure resource or another resource
description: Step-by-step instructions for assigning a managed identity access to an Azure resource or another resource.

author: barclayn
manager: amycolannino

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.tgt_pltfrm: na
ms.date: 06/03/2024
ms.author: barclayn

ms.custom: devx-track-azurepowershell

appliesto: 
zone_pivot_groups: identity-mi-azure-resource
---

# Assign a managed identity access to an Azure resource or another resource

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

Once you've configured an Azure resource with a managed identity, you can give the managed identity access to another resource, just like any security principal. This example shows you how to give an Azure virtual machine's managed identity access to an Azure storage account.

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, see [What are managed identities for Azure resources?](~/identity/managed-identities-azure-resources/overview.md). 
- Be sure to review the [difference between a system-assigned and user-assigned managed identity](~/identity/managed-identities-azure-resources/overview.md#managed-identity-types).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

::: zone pivot="identity-mi-access-portal"
[!INCLUDE [howto-assign-access-portal](includes/howto-assign-access-portal.md)]
::: zone-end

::: zone pivot="identity-mi-access-cli"
[!INCLUDE [howto-assign-access-cli](includes/howto-assign-access-cli.md)]
::: zone-end

::: zone pivot="identity-mi-access-powershell"
[!INCLUDE [howto-assign-access-powershell](includes/howto-assign-access-powershell.md)]
::: zone-end

## Next steps

- [Managed identities for Azure resources overview](overview.md)
- To enable managed identities on an Azure virtual machine, see [Configure managed identities for Azure resources](how-to-configure-managed-identities.md).
- To enable managed identities on an Azure virtual machine scale set, see [Configure managed identities for Azure resources on a virtual machine scale set](how-to-configure-managed-identities-scale-sets.md).
