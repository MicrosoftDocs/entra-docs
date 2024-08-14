---
title: PowerShell sample - Microsoft Entra application proxy apps using custom domains
description: PowerShell example that lists all Microsoft Entra application proxy applications that are using custom domains and certificate information.
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

# Get all application proxy apps using custom domains and certificate information

The PowerShell script example lists all Microsoft Entra application proxy applications that are using custom domains and lists the certificate information associated with the custom domains.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script gets all Microsoft Entra application proxy application custom domain applications & uploaded certificates.
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) and one of the following modules:
#
# Microsoft.Graph ver 2.10
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

$numberofAadapApps, $certsNumber = 0, 0

[string[]]$certs = $null

Write-Host "Displaying all custom domain Microsoft Entra application proxy applications and the uploaded certificates..." -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host " "

foreach ($item in $allApps) {

 $aadapApp, $aadapAppConf, $aadapAppConf1 = $null, $null, $null
 
 $aadapAppId =  Get-MgBetaApplication | where-object {$_.AppId -eq $item.AppId}
 $aadapAppConf = Get-MgBetaApplication -ApplicationId $aadapAppId.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing 
 $aadapAppConf1 = Get-MgBetaApplication -ApplicationId $aadapAppId.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing `
  | select verifiedCustomDomainCertificatesMetadata -expand verifiedCustomDomainCertificatesMetadata 

  if (($aadapAppConf -ne $null) -and ($aadapAppConf.ExternalUrl -notmatch ".msappproxy.net")) {
   
  Write-Host $item.DisplayName"(AppId: " $item.AppId ", ObjId:" $item.Id")" -BackgroundColor "Black" -ForegroundColor "White"
  Write-Host
  Write-Host "External Url: " $aadapAppConf.ExternalUrl
  Write-Host "Internal Url: " $aadapAppConf.InternalUrl
  Write-Host "Pre-authentication: " $aadapAppConf.ExternalAuthenticationType
  Write-Host

  If ($aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Thumbprint.Length -ne 0) {
       
        Write-Host " "
        Write-Host "SSL Certificate details:"
        Write-Host "Certificate SubjectName: " $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.SubjectName
        Write-Host "Certificate Issuer: " $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Issuer
        Write-Host "Certificate Thumbprint: " $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Thumbprint
        Write-Host "Valid from: " $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.IssueDate
        Write-Host "Valid to: " $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.ExpiryDate
        Write-Host " "

        if ($null -eq ($aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Thumbprint | ? { $certs -match $_ })) {
        
        
          $certs += " `r`nSSL Certificate details:`r`nCertificate SubjectName: " + $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.SubjectName
          $certs += "Certificate Issuer: " + $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Issuer
          $certs += "Certificate Thumbprint: " + $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.Thumbprint
          $certs += "Valid from: " + $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.IssueDate
          $certs += "Valid to: " + $aadapAppConf1.VerifiedCustomDomainCertificatesMetadata.ExpiryDate + "`r`n"

          $certsNumber = $certsNumber + 1
          
        }

  $numberofAadapApps = $numberofAadapApps + 1      
     }
  }
}


Write-Host
Write-Host "Number of the Microsoft Entra application proxy applications with custom domain: " $numberofAadapApps -BackgroundColor "Black" -ForegroundColor "White"
Write-Host ("")
Write-Host ("Number of uploaded certificates: " + $certsNumber) -BackgroundColor "Black" -ForegroundColor "White"
Write-Host ("")
Write-Host ("Used certificates:") -BackgroundColor "Black" -ForegroundColor "White"
Write-Host ("")

$certs 

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
