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
ms.date: 01/04/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Assign a user to a specific Microsoft Entra application proxy application

This PowerShell script example allows you to assign a user to a specific Microsoft Entra application proxy application.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
#  This sample script assigns a user to a specific Microsoft Entra application proxy application.
#
#  Tip: You can identify the parameters by using the following PS commands:
#    ServicePrincipalObjectId - Get-MgBetaServicePrincipal -Filter "DisplayName eq '<displayname of the app>'" 
#    UserObjectId - Get-MgBetaUser -ConsistencyLevel eventual -Count userCount -Search '"DisplayName:<name of the user>"'"
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) or beyond and one of the following modules:
#
# Microsoft.Graph.Beta ver 2.10 or newer
#
# Before you begin:
#    
#    Required Microsoft Entra role: Global Administrator or Application Administrator
#    or appropriate custom permissions as documented https://learn.microsoft.com/en-us/azure/active-directory/roles/custom-enterprise-app-permissions
#
# 

param(
[parameter(Mandatory=$true)]
[string] $ServicePrincipalObjectId = "null",
[parameter(Mandatory=$true)]
[string] $UserObjectId = "null"
)

$servicePrincipalObjectId = $ServicePrincipalObjectId
$userObjectId = $UserObjectId

If (($servicePrincipalObjectId -eq "null") -or ($userObjectId -eq "null")) {

    Write-Host "Parameter is missing." -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host ".\assign-user-to-app.ps1 -ServicePrincipalObjectId <ObjectId of the Microsoft Entra Application Proxy application service principal> -UserObjectId <ObjectId of the User>" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host "Hints:" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host "You can easily identify the parameters by using the following PS commands:" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host "ServicePrincipalObjectId - Get-MgBetaServicePrincipal -Filter "DisplayName eq '<displayname of the app>'" " -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host "UserObjectId - Get-MgBetaUser -ConsistencyLevel eventual -Count userCount -Search '"DisplayName:<name of the user>"'" -BackgroundColor "Black" -ForegroundColor "Green"

    Exit
}

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.ReadWrite.All -NoWelcome

New-MgBetaUserAppRoleAssignment -UserId $userObjectId -PrincipalId $userObjectId -ResourceId $servicePrincipalObjectId -AppRoleId "18d14569-c3bd-439b-9a66-3a2aee01d14f"

Write-Host ("")
Write-Host ("Finished.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host ("")
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet."

```

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[New-MgBetaUserAppRoleAssignment](/powershell/module/microsoft.graph.beta.applications/new-mgbetauserapproleassignment)| Assigns an app role to the user|


## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).
