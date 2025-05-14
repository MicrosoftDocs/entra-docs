---
title: PowerShell sample - List extended info for Microsoft Entra application proxy apps
description: PowerShell example that lists all Microsoft Entra application proxy applications along with the application ID (AppId), name (DisplayName), external URL (ExternalUrl), internal URL (InternalUrl), and authentication type (ExternalAuthenticationType).
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

# Get all application proxy apps and list extended information

The PowerShell script example lists information about all Microsoft Entra application proxy applications, including the application ID (AppId), name (DisplayName), external URL (ExternalUrl), internal URL (InternalUrl), authentication type (ExternalAuthenticationType), single sign-on (SSO) mode and further settings.

Changing the value of the `$ssoMode` variable enables a filtered output by SSO mode. Further details are documented in the script.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script enumerates all Microsoft Entra application proxy applications with configuration details
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

$ssoMode = "All"

# Change $ssoMode to filter the output based on the configured SSO type
# All                           - all Microsoft Entra application proxy apps (no filter)
# none                          - Microsoft Entra application proxy apps configured with no SSO, SAML, Linked, Password
# OnPremisesKerberos            - Microsoft Entra application proxy apps configured with Windows Integrated SSO (Kerberos Constrained Delegation)
# aadHeaderBased                - Microsoft Entra Native Header-based authentication
# pingHeaderBased               - Microsoft Entra Ping Header-based authentication
# oAuthToken                    - Microsoft Entra OAuth-based SSO


Import-Module Microsoft.Graph.Beta.Applications

Connect-MgGraph -Scope Directory.Read.All -NoWelcome

Write-Host "Reading service principals. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green" 

$aadapServPrinc = Get-MgBetaServicePrincipal -Top 100000 | where-object {$_.Tags -Contains "WindowsAzureActiveDirectoryOnPremApp"}

Write-Host "Reading Microsoft Entra applications. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$allApps = Get-MgBetaApplication -Top 100000

Write-Host "Filtering Microsoft Entra application proxy applications. This operation might take longer..." -BackgroundColor "Black" -ForegroundColor "Green"

$aadapApp = $null

foreach ($item in $aadapServPrinc) {
   foreach ($item2 in $allApps) {
    
     if ($item.AppId -eq $item2.AppId) {[array]$aadapApp += $item2}

    }
}

$numberofAadapApps, $numberofFilteredAadapApps = 0, 0

Write-Host "Displaying all Microsoft Entra application proxy applications with configuration details..." -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host "SSO mode filter: " $ssoMode -BackgroundColor "Black" -ForegroundColor "Green"
Write-Host " "


foreach ($item in $aadapApp) {
 
 $aadapAppConf, $aadapAppConf1, $aadapAppConf2, $aadapAppConf3, $aadapAppConf4 = $null, $null, $null, $null, $null

 $aadapAppConf = Get-MgBetaApplication -ApplicationId $item.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing 
 $aadapAppConf1 = Get-MgBetaApplication -ApplicationId $item.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing `
  | select singleSignOnSettings -expand SingleSignOnSettings 
 $aadapAppConf2 = Get-MgBetaApplication -ApplicationId $item.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing `
  | select verifiedCustomDomainCertificatesMetadata -expand verifiedCustomDomainCertificatesMetadata 
 $aadapAppConf3 = Get-MgBetaApplication -ApplicationId $item.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing | select OnPremisesApplicationSegments -expand OnPremisesApplicationSegments
 $aadapAppConf4 = Get-MgBetaApplication -ApplicationId $item.Id -ErrorAction SilentlyContinue -select OnPremisesPublishing | select OnPremisesPublishing -expand OnPremisesPublishing `
  | select singleSignOnSettings -expand SingleSignOnSettings | select KerberosSignOnSettings -expand KerberosSignOnSettings 
 

    if ($aadapAppConf -ne $null) {
   
      if ($ssoMode -eq "All" -Or $aadapAppConf1.SingleSignOnSettings.SingleSignOnMode -eq $ssoMode) {
    
        Write-Host $Item.DisplayName " (AppId: " $item.AppId  " / ObjectId: " $item.Id ")" -BackgroundColor "Black" -ForegroundColor "White"    

        Write-Host " "

        Write-Host "External Url: " $aadapAppConf.ExternalUrl
        Write-Host "Internal Url: " $aadapAppConf.InternalUrl
        Write-Host "Pre authentication type: " $aadapAppConf.ExternalAuthenticationType
        Write-Host " "
        Write-Host "SSO mode: " $aadapAppConf1.SingleSignOnSettings.SingleSignOnMode

      If ($aadapAppConf1.SingleSignOnMode -eq "OnPremisesKerberos") {

        Write-Host "Service Principal Name (SPN): " $aadapAppConf4.KerberosServicePrincipalName
        Write-Host "Username Mapping Attribute: " $aadapAppConf4.KerberosSignOnMappingAttributeType
      
        }
      
        Write-Host " "
        Write-Host "Backend Application Timeout: " $aadapAppConf.ApplicationServerTimeout
        Write-Host "Translate URLs in Headers: " $aadapAppConf.IsTranslateHostHeaderEnabled
        Write-Host "Translate URLs in Application Body: " $aadapAppConf.IsTranslateLinksInBodyEnabled
        Write-Host "Use HTTP-Only Cookie: " $aadapAppConf.IsHttpOnlyCookieEnabled
        Write-Host "Use Secure Cookie: " $aadapAppConf.IsSecureCookieEnabled
        Write-Host "Use Persistent Cookie: " $aadapAppConf.IsPersistentCookieEnabled
        Write-Host "Backend Certification Validation: " $aadapAppConf.IsBackendCertificateValidationEnabled
 
 
      If ($aadapAppConf3.Count -gt 0) { Write-Host "Complex App."}
      
      If ($aadapAppConf2.VerifiedCustomDomainCertificatesMetadata.Thumbprint.Length -ne 0) {
       
        Write-Host " "
        Write-Host "SSL Certificate details:"
        Write-Host "Certificate SubjectName: " $aadapAppConf2.VerifiedCustomDomainCertificatesMetadata.SubjectName
        Write-Host "Certificate Issuer: " $aadapAppConf2.VerifiedCustomDomainCertificatesMetadata.Issuer
        Write-Host "Certificate Thumbprint: " $aadapAppConf2.VerifiedCustomDomainCertificatesMetadata.Thumbprint
        Write-Host "Valid from: " $aadapAppConf2.VerifiedCustomDomainCertificatesMetadata.IssueDate
        Write-Host "Valid to: " $aadapAppConf2.VerifiedCustomDomainCertificatesMetadata.ExpiryDate
       
       } 
     
      
      $numberofFilteredAadapApps = $numberofFilteredAadapApps + 1
      
        Write-Host
      }
     

      $numberofAadapApps = $numberofAadapApps + 1          

     }
}

Write-Host "Number of the Microsoft Entra application proxy Applications: " $numberofAadapApps
Write-Host "Number of the filtered Microsoft Entra application proxy Applications: " $numberofFilteredAadapApps
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
