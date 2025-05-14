---
title: PowerShell sample - List all Microsoft Entra application proxy apps with a policy
description: PowerShell example that lists all Microsoft Entra application proxy applications in your directory that have a lifetime token policy.
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

# Get all application proxy apps with a token lifetime policy

The PowerShell script example lists all the Microsoft Entra application proxy applications in your directory that have a token lifetime policy and lists details about the policy.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script gets all Microsoft Entra proxy applications that have assigned an Azure AD policy (token lifetime) with policy details.
# Reference:
# Configurable token lifetimes in Azure Active Directory (Preview)
# https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-configurable-token-lifetimes
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

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.Read.All -NoWelcome

Write-Host "Reading service principals. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green" 

$aadapServPrinc = Get-MgBetaServicePrincipal -Top 100000 | where-object {$_.Tags -Contains "WindowsAzureActiveDirectoryOnPremApp"}

Write-Host "Reading Microsoft Entra applications. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$allApps = Get-MgBetaApplication -Top 100000

Write-Host "Reading application. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$aadapApp = $null

foreach ($item in $aadapServPrinc) {
   foreach ($item2 in $allApps) {
    
     if ($item.AppId -eq $item2.AppId) {[array]$aadapApp += $item2}

    }
}

foreach ($item in $aadapApp)
 {
  
  $Policies = $Null
  $Policies = Get-MgBetaApplicationTokenLifetimePolicy -ApplicationId $item.Id 
  
  if ($Policies -ne $Null) {

  Write-Host ("")        
 
  Write-Host $item.DisplayName + " (AppId: " + $item.AppId + ")"  -BackgroundColor "Black" -ForegroundColor "White" 
 
  Write-Host ("") 
  Write-Host ("Assigned policy:") 
  Write-Host ("") 

  Write-Host ("Policy Id:    " + $Policies.Id)
  Write-Host ("DisplayName:  " + $Policies.DisplayName)
  Write-Host ("Definition:   " + $Policies.Definition)
  Write-Host ("Org. default: " + $Policies.IsOrganizationDefault)
  Write-Host ("") 

  }
          
 }   

Write-Host ("")
Write-Host ("Finished.") -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host "To disconnect from Microsoft Graph, please use the Disconnect-MgGraph cmdlet."
```

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[Get-MgBetaServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal)| Gets a service principal|
|[Get-MgBetaApplication](/powershell/module/microsoft.graph.beta.applications/get-mgbetaapplication)| Gets an Enterprise Application|
|[Get-MgBetaApplicationTokenLifetimePolicy](/powershell/module/microsoft.graph.beta.applications/get-mgbetaapplicationtokenlifetimepolicy)| Lists policies assigned to application or service principal|

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
- [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md)
