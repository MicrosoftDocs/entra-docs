---
title: PowerShell sample - Microsoft Entra application proxy apps with no certificate
description: PowerShell example that lists all Microsoft Entra application proxy applications that are using custom domains but don't have a valid TLS/SSL certificate uploaded.
services: active-directory
author: kenwith
manager: amycolannino
ms.service: active-directory
ms.subservice: app-proxy
ms.custom: has-azure-ad-ps-ref
ms.topic: sample
ms.date: 01/04/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Get all Application Proxy apps published with no certificate uploaded

This PowerShell script example lists all Microsoft Entra application proxy apps that are using custom domains but don't have a valid TLS/SSL certificate uploaded.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script gets all Microsoft Entra application proxy applications using custom domain with no uploaded certificate.
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) and one of the following modules:
#
# Microsoft.Graph ver 2.10 or newer
#
# Before you begin:
#    
#    Required Microsoft Entra role: Global Administrator or Application Administrator or Application Developer 
#    or appropriate custom permissions as documented https://learn.microsoft.com/en-us/azure/active-directory/roles/custom-enterprise-app-permissions
#
# 

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.Read.All -NoWelcome

Write-Host "Reading service principals. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$allApps = Get-MgBetaServicePrincipal -Top 100000 | where-object {$_.Tags -Contains "WindowsAzureActiveDirectoryOnPremApp"}

$numberofAadapApps = 0

Write-Host " "
Write-Host "Displaying custom domain Microsoft Entra application proxy applications with no uploaded certificates..." -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host " "

foreach ($item in $allApps) {

 $aadapApp, $aadapAppConf, $aadapAppConf1 = $null, $null, $null
 
 $aadapAppId =  Get-MgBetaApplication | where-object {$_.AppId -eq $item.AppId}
 $aadapAppConf = Get-MgBetaApplication -ApplicationId $aadapAppId.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing 
 $aadapAppConf1 = Get-MgBetaApplication -ApplicationId $aadapAppId.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing `
  | select verifiedCustomDomainCertificatesMetadata -expand verifiedCustomDomainCertificatesMetadata 

  if (($aadapAppConf -ne $null) -and ($aadapAppConf.ExternalUrl -notmatch ".msappproxy.net")) {
   
   if ($aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Thumbprint.Length -eq 0) {
  
     Write-Host $item.DisplayName"(AppId: " $item.AppId ", ObjId:" $item.Id")" -BackgroundColor "Black" -ForegroundColor "White"
     Write-Host
     Write-Host "External Url: " $aadapAppConf.ExternalUrl
     Write-Host "Internal Url: " $aadapAppConf.InternalUrl
     Write-Host "Pre-authentication: " $aadapAppConf.ExternalAuthenticationType
     Write-Host
  
     $numberofAadapApps = $numberofAadapApps + 1              
    }
  
   }
  
}


Write-Host
Write-Host "Number of the custom domain Microsoft Entra application proxy applications with no uploaded certificate: " $numberofAadapApps -BackgroundColor "Black" -ForegroundColor "White"
Write-Host ("")

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

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).
