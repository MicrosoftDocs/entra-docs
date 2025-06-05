---
title: PowerShell sample - Replace certificate in Microsoft Entra application proxy apps
description: PowerShell example that bulk replaces a certificate across Microsoft Entra application proxy applications.
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

# Get all Microsoft Entra application proxy applications published with the identical certificate and replace it

The PowerShell script example replaces the certificates in bulk for all Microsoft Entra application proxy applications published with identical certificate.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script gets all Microsoft Entra application proxy applications published with the identical certificate.
#
# .\replace_with_the_script_name.ps1 -CurrentThumbprint <thumbprint of the current certificate> -PFXFilePath <full path with PFX filename>
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

param(
[parameter(Mandatory=$true)]
[string] $CurrentThumbprint = "null",
[parameter(Mandatory=$true)]
[string] $PFXFilePath = "null"
)

$certThumbprint = $CurrentThumbprint
$certPfxFilePath = $PFXFilePath

If (($certThumbprint -eq "null") -or ($certPfxFilePath -eq "null")) {

    Write-Host "Parameter is missing." -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "
    Write-Host ".\get-custom-domain-replace-cert.ps1 -CurrentThumbprint <thumbprint of the current certificate> -PFXFilePath <full path with PFX filename>" -BackgroundColor "Black" -ForegroundColor "Green"
    Write-Host " "

    Exit
}

If ((Test-Path -Path $certPfxFilePath) -eq $False) {

    Write-Host "The pfx file does not exist." -BackgroundColor "Black" -ForegroundColor "Red"
    Write-Host " "

    Exit
}

$securePassword = Read-Host -AsSecureString // please provide the password of the pfx file

Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.ReadWrite.All -NoWelcome

Write-Host "Reading service principals. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$allApps = Get-MgBetaServicePrincipal -Top 100000 | where-object {$_.Tags -Contains "WindowsAzureActiveDirectoryOnPremApp"}

$numberofAadapApps = 0

Write-Host ("")
Write-Host ("SSL certificate change for the Microsoft Entra application proxy apps below:")
Write-Host ("")

foreach ($item in $allApps) {

  $aadapApp, $aadapAppConf, $aadapAppConf1 = $null, $null, $null


  $aadapAppId =  Get-MgBetaApplication -Filter "AppId eq '$($item.AppID)'"

  $aadapAppConf = Get-MgBetaApplication -ApplicationId $aadapAppId.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing 
  $aadapAppConf1 = Get-MgBetaApplication -ApplicationId $aadapAppId.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing `
    | select verifiedCustomDomainCertificatesMetadata -expand verifiedCustomDomainCertificatesMetadata 

  if ($aadapAppConf -ne $null) {

    if ($aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Thumbprint -match $certThumbprint) {

      Write-Host $item.DisplayName"(AppId: " $item.AppId ", ObjId:" $item.Id")" -BackgroundColor "Black" -ForegroundColor "White"
      Write-Host
      Write-Host "External Url: " $aadapAppConf.ExternalUrl
      Write-Host "Internal Url: " $aadapAppConf.InternalUrl
      Write-Host "Pre-authentication: " $aadapAppConf.ExternalAuthenticationType
      Write-Host

      $params = @{
         onPremisesPublishing = @{
            verifiedCustomDomainKeyCredential = @{
                type="X509CertAndPassword";
                value = [convert]::ToBase64String((Get-Content $certPfxFilePath -Encoding byte));
            };
            verifiedCustomDomainPasswordCredential = @{
                value = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)) };
         }
      }

      Update-MgBetaApplication -ApplicationId $aadapAppId.Id -BodyParameter $params
  
      $numberofAadapApps = $numberofAadapApps + 1
    }
  }
}

Write-Host
Write-Host "Number of the updated Microsoft Entra application proxy applications: " $numberofAadapApps -BackgroundColor "Black" -ForegroundColor "White"
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
|[Update-MgBetaApplication](/powershell/module/microsoft.graph.beta.applications/update-mgbetaapplication)| updates an application|

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
- [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md)
