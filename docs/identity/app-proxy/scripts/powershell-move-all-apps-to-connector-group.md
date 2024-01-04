---
title: PowerShell sample - Move Microsoft Entra application proxy apps to another group
description: Microsoft Entra application proxy PowerShell example used to move all applications currently assigned to a connector group to a different connector group.
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

# Move all Microsoft Entra application proxy apps assigned to a connector group to another connector group

This PowerShell script example moves all Microsoft Entra application proxy applications currently assigned to a connector group to a different connector group.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

[!INCLUDE [cloud-shell-try-it.md](~/../azure-docs-pr/includes/cloud-shell-try-it.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script moves all Microsoft Entra application proxy applications assigned to a specific connector group to another connector group.
#
# .\move-all-apps-to-a-connector-group.ps1 -CurrentConnectorGroupId <ObjectId of the current connector group> -NewConnectorGroupId <ObjectId of the new connector group>
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
[string] $CurrentConnectorGroupId = "null", 
[parameter(Mandatory=$true)]
[string] $NewConnectorGroupId = "null"
)

$currentGroupId = $CurrentConnectorGroupId
$newGroupId = $NewConnectorGroupId
$connectorAssignedApp = $null

If (($currentGroupId -eq "null") -or ($newGroupId -eq "null")) {

    Write-Host "Parameter is missing." -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host ".\move-all-apps-to-a-connector-group.ps1 -CurrentConnectorGroupId <ObjectId of the current connector group> -NewConnectorGroupId <ObjectId of the new connector group>" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "

    Exit
}

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.ReadWrite.All -NoWelcome

Try {
$temp = Get-MgBetaOnPremisePublishingProfileConnectorGroup -OnPremisesPublishingProfileId "applicationProxy" -ConnectorGroupId $currentGroupId
$temp = Get-MgBetaOnPremisePublishingProfileConnectorGroup -OnPremisesPublishingProfileId "applicationProxy" -ConnectorGroupId $newGroupId
}

Catch {
    Write-Host "Possibly, one of the parameters is incorrect." -BackgroundColor "Black" -ForegroundColor "Red"
    Write-Host " "

    Exit
}

Write-Host "Reading service principals. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green" 

$aadapServPrinc = Get-MgBetaServicePrincipal -Top 100000 | where-object {$_.Tags -Contains "WindowsAzureActiveDirectoryOnPremApp"}

Write-Host "Displaying Microsoft Entra application proxy applications moved from the connector Id :",$currentGroupId," to: ",$newGroupId -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host " "

$connectorAssignedApp = Get-MgBetaOnPremisePublishingProfileConnectorGroupApplication -OnPremisesPublishingProfileId "applicationProxy" -ConnectorGroupId $CurrentConnectorGroupId;
$movedApps, $notmovedApps = 0, 0

 foreach ($item in $connectorAssignedApp) {

    if ($item.AppId -in ($aadapServPrinc.AppId)) {
               
     $item.DisplayName + " (AppId: " + $item.AppId + ")"
     
     $params = @{
      "@odata.id" = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups/$NewConnectorGroupId"
       }
      
        Set-MgBetaApplicationConnectorGroupByRef -ApplicationId $item.Id -BodyParameter $params 

        $movedApps = $movedApps + 1
     }
     else
     {
      $notmovedApps = $notmovedApps + 1
     }      
} 

Write-Host ("")
Write-Host ("$movedApps apps has been moved to the new connector.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host ("$notmovedApps apps could not be moved to the new connector. Finished.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host ("")
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet."
Write-Host ("")
```

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[Get-MgBetaServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal)| Gets a service principal|
|[Get-MgBetaOnPremisePublishingProfileConnectorGroup](/powershell/module/microsoft.graph.beta.applications/get-mgbetaapplication)| Gets an Enterprise Application|
|[Get-MgBetaOnPremisePublishingProfileConnectorGroupApplication](/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisepublishingprofileconnectorgroupapplication)| Lists applications assigned to a connector group |
|[Set-MgBetaApplicationConnectorGroupByRef](/powershell/module/microsoft.graph.beta.applications/set-mgbetaapplicationconnectorgroupbyref)| Assigns an application to the connector group|

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).
