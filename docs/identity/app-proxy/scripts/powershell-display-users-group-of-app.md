---
title: PowerShell sample - List users & groups for a Microsoft Entra application proxy app
description: PowerShell example that lists all the users and groups assigned to a specific Microsoft Entra application proxy application.
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

# Display users and groups assigned to an application proxy application

The PowerShell script example lists the users and groups assigned to a specific Microsoft Entra application proxy application.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script displays users and groups assigned to the specified Microsoft Entra application proxy application.
#
# .\display-users-group-of-an-app.ps1 -ObjectId <ObjectId of the service principal> (Enterprise App)
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
[string] $ObjectId = "null"
)

$aadapServPrincObjId=$ObjectId

If ($aadapServPrincObjId -eq "null") {

    Write-Host "Parameter is missing." -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host ".\display-users-group-of-an-app.ps1 -ObjectId <ObjectId of the service principal (Enterprise App)>" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "

    Exit
}

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.Read.All -NoWelcome

Write-Host "Reading users. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$users= Get-MgBetaUser -Top 1000000

Write-Host "Reading groups. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$groups = Get-MgBetaGroup -Top 1000000 

try {$app = Get-MgBetaServicePrincipalById -Id $aadapServPrincObjId}

catch {

    Write-Host "Possibly the ObjetId is incorrect." -BackgroundColor "Black" -ForegroundColor "Red"
    Write-Host " "

    Exit
}

Write-Host ("Application: " + $app.DisplayName + "(ServicePrinc. ObjID:" + $aadapServPrincObjId + ")")
Write-Host ("")
Write-Host ("Assigned (directly and through group membership) users:")
Write-Host ("")

$number=0

foreach ($item in $users) {

   $listOfAssignments = Get-MgBetaUserAppRoleAssignment -UserId $item.Id

   $assigned = $false

   foreach ($item2 in $listOfAssignments) { if ($item2.ResourceId -eq $aadapServPrincObjId) { $assigned = $true } }

     If ($assigned -eq $true) {
        Write-Host ("DisplayName: " + $item.DisplayName + " UPN: " + $item.UserPrincipalName + " ObjectID: " + $item.Id)
        $number = $number + 1
     }
}

Write-Host ("")
Write-Host ("Number of (directly and through group membership) users: " + $number)
Write-Host ("")
Write-Host ("")
Write-Host ("Assigned groups:")
Write-Host ("")

$number=0

foreach ($item in $groups) {

   $listOfAssignments = Get-MgBetaGroupAppRoleAssignment -GroupId $item.Id

   $assigned = $false

   foreach ($item2 in $listOfAssignments) { If ($item2.ResourceID -eq $aadapServPrincObjId) { $assigned = $true } }

   If ($assigned -eq $true) {
        Write-Host ("DisplayName: " + $item.DisplayName + " ObjectID: " + $item.Id)
        $number=$number+1
   }
}

  
Write-Host ("")
Write-Host ("Number of assigned groups: " + $number)
Write-Host ("")

Write-Host ("")
Write-Host ("Finished.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host ("") 
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet."
```

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[Get-MgBetaServicePrincipalById](/powershell/module/microsoft.graph.beta.applications/get-mgbetaserviceprincipalbyid)| Gets a service principal by ID|
|[Get-MgBetaUser](/powershell/module/microsoft.graph.beta.users/get-mgbetauser)| Gets a user|
|[Get-MgBetaGroup](/powershell/module/microsoft.graph.beta.groups/get-mgbetagroup)| Gets a group|
|[Get-MgBetaUserAppRoleAssignment](/powershell/module/microsoft.graph.beta.applications/get-mgbetagroupapproleassignment)| Gets the application role assignment|

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
- [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md)
