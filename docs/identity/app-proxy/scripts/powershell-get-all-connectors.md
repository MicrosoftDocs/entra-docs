---
title: PowerShell sample - List all Microsoft Entra private network connector groups
description: PowerShell example that lists all Microsoft Entra private network connector groups and connectors in your directory.
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: app-proxy
ms.custom: 
ms.topic: sample
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
---

# Get all private network connector groups and connectors in the directory

The PowerShell script example lists all Microsoft Entra private network connector groups and connectors in your directory.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script gets all Microsoft Entra private network connector groups with the included connectors.
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) or beyond and one of the following modules:
#
# Microsoft.Graph.Beta ver 2.10 or newer
#
# Before you begin:
#    
#    Required Microsoft Entra role at least Application Administrator or Application Developer 
#    or appropriate custom permissions as documented https://learn.microsoft.com/azure/active-directory/roles/custom-enterprise-app-permissions
#
# 

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.Read.All -NoWelcome

Write-Host "Reading Microsoft Entra private network connector groups. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$aadapConnectorGroups= Get-MgBetaOnPremisePublishingProfileConnectorGroup -OnPremisesPublishingProfileId "applicationProxy" -Top 100000 

$countAssignedApps, $CountOfConnectorGroups = 0

foreach ($item in $aadapConnectorGroups) {
   
     If ($item.ConnectorGroupType -eq "applicationProxy") {

     Write-Host "Connector group: " $item.Name, "(Id:" $item.Id ")" -BackgroundColor "Black" -ForegroundColor "White" 
     Write-Host "Region: " $item.Region
     
     Write-Host " "

     $connectors = Get-MgBetaOnPremisePublishingProfileConnectorGroupMember -ConnectorGroupId $item.Id -OnPremisesPublishingProfileId "applicationProxy" 

     $connectors | ft

     " ";

     $CountOfConnectorGroups = $CountOfConnectorGroups + 1

     }
}  

Write-Host ("")
Write-Host ("Number of Microsoft Entra private network connector Groups: $CountOfConnectorGroups")
Write-Host ("")
Write-Host ("Finished.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet."
```

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph |
|[Get-MgBetaOnPremisePublishingProfileConnectorGroup](/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisepublishingprofileconnectorgroup)| Gets a connector group |
|[Get-MgBetaOnPremisePublishingProfileConnectorGroupMember](/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisepublishingprofileconnectorgroupmember)|Gets the members of a connector group |

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
- [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md)
