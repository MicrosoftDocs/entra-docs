---
title: PowerShell sample - Assign user to a Microsoft Entra application proxy app
description: PowerShell example that assigns a user to a Microsoft Entra application proxy application.
services: active-directory
author: kenwith
manager: amycolannino
ms.service: active-directory
ms.subservice: app-proxy
ms.workload: identity
ms.custom: has-azure-ad-ps-ref
ms.topic: sample
ms.date: 08/29/2022
ms.author: kenwith
ms.reviewer: ashishj
---

# Assign a user to a specific Microsoft Entra application proxy application

This PowerShell script example allows you to assign a user to a specific Microsoft Entra application proxy application.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

[!INCLUDE [cloud-shell-try-it.md](~/../azure-docs-pr/includes/cloud-shell-try-it.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

[!code-azurepowershell[main](~/../powershell_scripts/application-proxy/assign-user-to-app.ps1 "Assign a user to an application")]

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[New-MgBetaUserAppRoleAssignment](/powershell/module/microsoft.graph.beta.applications/new-mgbetauserapproleassignment)| Assigns an app role to the user|


## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).
