---
title: View the service principal of a managed identity using PowerShell
description: Step-by-step instructions for viewing the service principal of a managed identity using PowerShell.

author: barclayn
manager: amycolannino

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.tgt_pltfrm: na
ms.date: 02/15/2022
ms.author: barclayn

ms.custom: devx-track-azurepowershell
---

# View the service principal of a managed identity using PowerShell

Managed identities for Azure resources provides Azure services with an automatically managed identity in Microsoft Entra ID. You can use this identity to authenticate to any service that supports Microsoft Entra authentication, without having credentials in your code. 

In this article, you learn how to view the service principal of a managed identity using PowerShell.

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](overview.md).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/).
- Enable [system assigned identity on a virtual machine](./qs-configure-portal-windows-vm.md#system-assigned-managed-identity) or [application](/azure/app-service/overview-managed-identity#add-a-system-assigned-identity).
- To run the example scripts, you have two options:
    - Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top right corner of code blocks.
    - Run scripts locally by installing the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell), then sign in to Azure using `Connect-AzAccount`.

## View the service principal

This following command demonstrates how to view the service principal of a VM or application with system assigned identity enabled. Replace `<Azure resource name>` with your own values.

```powershell
Get-AzADServicePrincipal -DisplayName <Azure resource name>
```

## Next steps

For more information on viewing Microsoft Entra service principals using PowerShell, see [Get-AzADServicePrincipal](/powershell/module/az.resources/get-azadserviceprincipal).
