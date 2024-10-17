---
title: PowerShell sample - Assign group to a Microsoft Entra application proxy app
description: PowerShell example that assigns a group to a Microsoft Entra application proxy application.
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.custom:
ms.topic: sample
ms.date: 02/27/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Assign a group to a specific Microsoft Entra application proxy application

The PowerShell script example assigns a specific group to a Microsoft Entra application proxy application.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
#  This sample script assigns a group to a specific Microsoft Entra application proxy application.
#
#  Tip: You can identify the parameters by using the following PS commands:
#    ServicePrincipalObjectId - Get-MgBetaServicePrincipal -Filter "DisplayName eq '<displayname of the app>'" 
#    GroupObjectId - Get-MgBetaGroup -ConsistencyLevel eventual -Count userCount -Search '"DisplayName:<name of the group>"'"
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) or beyond and one of the following modules:
#
# Microsoft.Graph.Beta ver 2.10 or newer
#
# Before you begin:
#    
#    Required Microsoft Entra role at least Application Administrator
#    or appropriate custom permissions as documented https://learn.microsoft.com/azure/active-directory/roles/custom-enterprise-app-permissions
#
# 

param(
[parameter(Mandatory=$true)]
[string] $ServicePrincipalObjectId = "null",
[parameter(Mandatory=$true)]
[string] $GroupObjectId = "null"
)

$servicePrincipalObjectId = $ServicePrincipalObjectId
$groupObjectId = $GroupObjectId

If (($servicePrincipalObjectId -eq "null") -or ($groupObjectId -eq "null")) {

    Write-Host "Parameter is missing." -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host ".\assign-group-to-app.ps1 -ServicePrincipalObjectId <ObjectId of the Microsoft Entra application proxy application service principal> -UserObjectId <ObjectId of the User>" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host "Hints:" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host "You can easily identify the parameters by using the following PS commands:" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host "ServicePrincipalObjectId - Get-MgBetaServicePrincipal -Filter "DisplayName eq '<displayname of the app>'" " -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host "UserObjectId - Get-MgBetaGroup -ConsistencyLevel eventual -Count userCount -Search '"DisplayName:<name of the group>"'" -BackgroundColor "Black" -ForegroundColor "Green"

    Exit
}

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.ReadWrite.All -NoWelcome

New-MgBetaGroupAppRoleAssignment -GroupId $groupObjectId -PrincipalId $groupObjectId -ResourceId $servicePrincipalObjectId -AppRoleId "00000000-0000-0000-0000-000000000000"

Write-Host ("")
Write-Host ("Finished.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host ("")
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet." 
```

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[New-MgBetaGroupAppRoleAssignment](/powershell/module/microsoft.graph.beta.applications/new-mgbetagroupapproleassignment)| Assigns an app role to a group|


## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
- [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md)
