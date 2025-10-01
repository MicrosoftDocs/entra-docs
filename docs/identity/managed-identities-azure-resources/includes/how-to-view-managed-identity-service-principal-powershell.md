---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 03/14/2025
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - devx-track-azurepowershell
---

## View the service principal for a managed identity using PowerShell

To run the scripts for this example, you have two options:
- Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top right corner of code blocks.
- Run scripts locally by installing the latest version of [Azure PowerShell](/powershell/azure/install-azure-powershell), then sign in to Azure using `Connect-AzAccount`.
 
The following command demonstrates how to view the service principal of a virtual machine (VM) or application with *system assigned identity* enabled. Replace `<Azure resource name>` with your own values.

```powershell
Get-AzADServicePrincipal -DisplayName <Azure resource name>
```

## Next steps

For more information on viewing Microsoft Entra service principals using PowerShell, see [Get-AzADServicePrincipal](/powershell/module/az.resources/get-azadserviceprincipal).
