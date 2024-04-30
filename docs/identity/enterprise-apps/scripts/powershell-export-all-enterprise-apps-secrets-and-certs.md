---
title: PowerShell sample - Export secrets and certificates for enterprise apps in Microsoft Entra tenant.
description: PowerShell example that exports all secrets and certificates for the specified enterprise apps in your Microsoft Entra tenant.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.custom:
ms.topic: sample
ms.date: 01/15/2024
ms.author: jomondi
ms.reviewer: mifarca
---

# Export secrets and certificates for enterprise apps
This PowerShell script example exports all secrets, certificates and owners for the specified enterprise apps from your directory into a CSV file.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

This sample requires the [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) SDK module.

## Sample script

```powershell
<#################################################################################
DISCLAIMER:

This is not an official PowerShell Script. We designed it specifically for the situation you have
encountered right now.

Please do not modify or change any preset parameters.

Please note that we will not be able to support the script if it's changed or altered in any way
or used in a different situation for other means.

This code-sample is provided "AS IS" without warranty of any kind, either expressed or implied,
including but not limited to the implied warranties of merchantability and/or fitness for a
particular purpose.

This sample is not supported under any Microsoft standard support program or service.

Microsoft further disclaims all implied warranties including, without limitation, any implied
warranties of merchantability or of fitness for a particular purpose.

The entire risk arising out of the use or performance of the sample and documentation remains with
you.

In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or
delivery of the script be liable for any damages whatsoever (including, without limitation, damages
for loss of business profits, business interruption, loss of business information, or other
pecuniary loss) arising out of the use of or inability to use the sample or documentation, even if
Microsoft has been advised of the possibility of such damages.

#################################################################################>

Connect-MgGraph -Scopes 'Application.Read.All'

$Messages = @{
    DurationNotice = @{
        Info = @(
            'The operation is running and will take longer the more applications the tenant has...'
            'Please wait...'
        ) -join ' '
    }
    Export         = @{
        Info   = 'Where should the CSV file export to?'
        Prompt = 'Enter the full path in the format of <C:\Users\<USER>\Desktop\Users.csv>'
    }
}

Write-Host $Messages.DurationNotice.Info -ForegroundColor Yellow

$EnterpriseApps = Get-MgServicePrincipal -all

$Logs = @()

foreach ($EnterpriseApp in $EnterpriseApps) {
    $AppName = $EnterpriseApp.DisplayName
    $AppID   = $EnterpriseApp.Id
    $ApplID  = $EnterpriseApp.AppId

    $AppCreds = Get-MgServicePrincipal -ServicePrincipalId $AppID |
        Select-Object PasswordCredentials, KeyCredentials

    $Secrets = $AppCreds.PasswordCredentials
    $Certs   = $AppCreds.KeyCredentials

    ############################################
    $Logs += [PSCustomObject]@{
        'ApplicationName'        = $AppName
        'ApplicationID'          = $ApplID
        'Secret Name'            = $Null
        'Secret Start Date'      = $Null
        'Secret End Date'        = $Null
        'Certificate Name'       = $Null
        'Certificate Start Date' = $Null
        'Certificate End Date'   = $Null
        'Owner'                  = $Null
        'Owner_ObjectID'         = $Null
    }
    ############################################
    foreach ($Secret in $Secrets) {
        $StartDate = $Secret.StartDateTime
        $EndDate   = $Secret.EndDateTime

        $Owner    = Get-MgServicePrincipalOwner -ServicePrincipalId $EnterpriseApp.Id
        $Username = $Owner.AdditionalProperties.userPrincipalName -join ';'
        $OwnerID  = $Owner.Id -join ';'

        if ($null -eq $Owner.AdditionalProperties.userPrincipalName) {
            $Username = @(
                $Owner.AdditionalProperties.displayName
                '**<This is an Application>**'
            ) -join ' '
        }
        if ($null -eq $Owner.AdditionalProperties.displayName) {
            $Username = '<<No Owner>>'
        }

        $Logs += [PSCustomObject]@{
            'ApplicationName'        = $AppName
            'ApplicationID'          = $ApplID
            'Secret Name'            = $SecretName
            'Secret Start Date'      = $StartDate
            'Secret End Date'        = $EndDate
            'Certificate Name'       = $Null
            'Certificate Start Date' = $Null
            'Certificate End Date'   = $Null
            'Owner'                  = $Username
            'Owner_ObjectID'         = $OwnerID
        }
    }

    foreach ($Cert in $Certs) {
        $StartDate = $Cert.StartDateTime
        $EndDate   = $Cert.EndDateTime
        $CertName  = $Cert.DisplayName

        $Owner    = Get-MgServicePrincipalOwner -ServicePrincipalId $EnterpriseApp.Id
        $Username = $Owner.AdditionalProperties.userPrincipalName -join ';'
        $OwnerID  = $Owner.Id -join ';'

        if ($null -eq $Owner.AdditionalProperties.userPrincipalName) {
            $Username = @(
                $Owner.AdditionalProperties.displayName
                '**<This is an Application>**'
            ) -join ' '
        }
        if ($null -eq $Owner.AdditionalProperties.displayName) {
            $Username = '<<No Owner>>'
        }

        $Logs += [PSCustomObject]@{
            'ApplicationName'        = $AppName
            'ApplicationID'          = $ApplID
            'Secret Name'            = $Null
            'Certificate Name'       = $CertName
            'Certificate Start Date' = $StartDate
            'Certificate End Date'   = $EndDate
            'Owner'                  = $Username
            'Owner_ObjectID'         = $OwnerID
        }
    }
}

Write-Host $Messages.Export.Info -ForegroundColor Green
$Path = Read-Host -Prompt $Messages.Export.Prompt
$Logs | Export-Csv $Path -NoTypeInformation -Encoding UTF8
```

## Script explanation

The script can be used directly without any modifications. The admin will be asked about the expiration date and whether they would like to see already expired secrets or certificates or not.

The "Add-Member" command is responsible for creating the columns in the CSV file.
You can modify the "$Path" variable directly in PowerShell, with a CSV file path, in case you'd prefer the export to be non-interactive.

| Command | Notes |
|---|---|
| [Get-MgServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal?view=graph-powershell-1.0&preserve-view=true) | Retrieves an enterprise application from your directory. |
| [Get-MgServicePrincipalOwner](/powershell/module/microsoft.graph.applications/get-mgserviceprincipalowner?view=graph-powershell-1.0&preserve-view=true) | Retrieves the owners of an enterprise application from your directory. |

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell module overview](/powershell/microsoftgraph/installation).

For other PowerShell examples for Application Management, see [Azure Microsoft Graph PowerShell examples for Application Management](../app-management-powershell-samples.md).
