---
title: PowerShell sample - List Microsoft Entra application proxy apps using wildcards
description: PowerShell example that lists all Microsoft Entra application proxy applications that are using wildcards.
author: kenwith
manager: dougeby 
ms.service: entra-id
ms.subservice: app-proxy
ms.custom: 
ms.topic: sample
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
---

# Get all application proxy apps using wildcard publishing

The PowerShell script example lists all Microsoft Entra application proxy applications using wildcard publishing.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script gets all Microsoft Entra application proxy application wildcard published apps.
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) and one of the following modules:
#
# Microsoft.Graph ver 2.10 or newer
#
# Before you begin:
#    
#    Required Microsoft Entra role at least Application Administrator or Application Developer 
#    or appropriate custom permissions as documented https://learn.microsoft.com/azure/active-directory/roles/custom-enterprise-app-permissions
#
# 

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.Read.All -NoWelcome

Write-Host "Reading service principals. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$allApps = Get-MgBetaServicePrincipal -Top 100000 | where-object {$_.Tags -Contains "WindowsAzureActiveDirectoryOnPremApp"}

$numberofAadapApps = 0

Write-Host "Displaying wildcard Microsoft Entra application proxy applications..." -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host " "

foreach ($item in $allApps) {

 $aadapApp = $null
 
 $aadapAppId =  Get-MgBetaApplication -Top 100000 | where-object {$_.AppId -eq $item.AppId}
 $aadapApp = Get-MgBetaApplication -ApplicationId $aadapAppId.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing 
 

  if (($aadapApp -ne $null) -and ($aadapApp.ExternalUrl -match "\*.")) {
   
  Write-Host $item.DisplayName"(AppId: " $item.AppId ", ObjId:" $item.Id")"
  Write-Host
  Write-Host "External Url: " $aadapApp.ExternalUrl
  Write-Host "Internal Url: " $aadapApp.InternalUrl
  Write-Host

  $numberofAadapApps = $numberofAadapApps + 1      

  }
}

Write-Host
Write-Host "Number of the Microsoft Entra application proxy applications: " $numberofAadapApps
Write-Host
Write-Host "Finished." -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet."
```

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[Get-MgBetaServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal)| Gets a service principal|
|[Get-MgBetaApplication](/powershell/module/microsoft.graph.beta.applications/get-mgbetaapplication)| Gets an Enterprise Application|

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
- [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md)
