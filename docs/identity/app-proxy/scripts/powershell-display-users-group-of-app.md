---
title: PowerShell sample - List users & groups for a Microsoft Entra application proxy app
description: PowerShell example that lists all the users and groups assigned to a specific Microsoft Entra application proxy application.
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

# Display users and groups assigned to an Application Proxy application

This PowerShell script example lists the users and groups assigned to a specific Microsoft Entra application proxy application.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

[!INCLUDE [cloud-shell-try-it.md](~/../azure-docs-pr/includes/cloud-shell-try-it.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

[!code-azurepowershell[main](~/../powershell_scripts/application-proxy/display-users-group-of-an-app.ps1 "Display users and groups assigned to an Application Proxy application")]

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[Get-MgBetaServicePrincipalById](/powershell/module/microsoft.graph.beta.applications/get-mgbetaserviceprincipalbyid)| Gets a service principal by id|
|[Get-MgBetaUser](/powershell/module/microsoft.graph.beta.users/get-mgbetauser)| Gets a user|
|[Get-MgBetaGroup](/powershell/module/microsoft.graph.beta.groups/get-mgbetagroup)| Gets a group|
|[Get-MgBetaUserAppRoleAssignment](/powershell/module/microsoft.graph.beta.applications/get-mgbetaapproleassignment)| Gets the application role assignment|

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).
