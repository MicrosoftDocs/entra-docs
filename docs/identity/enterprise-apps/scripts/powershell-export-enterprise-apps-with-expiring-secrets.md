---
title: 'PowerShell sample: Export enterprise apps with expiring secrets and certificates'
description: PowerShell example that exports all enterprise apps with expiring secrets and certificates for the specified enterprise apps in your Microsoft Entra tenant.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: sample
ms.date: 01/23/2025
ms.author: jomondi
ms.reviewer: mifarca
---

# PowerShell sample: Export enterprise apps with expiring secrets and certificates

This PowerShell script example exports all enterprise applications with secrets and certificates expiring in the next X days. It also includes the ones that are expired, if you choose so. The script exports the enterprise applications along with their owners. It performs this action for the specified enterprise apps from your directory. The output is saved in a CSV file.

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

$Applications = Get-MgServicePrincipal -all
$Logs = @()

$Messages = @{
    ExpirationDays = @{
        Info   = 'Filter the applications to log by the number of days until their secrets expire.'
        Prompt = 'Enter the number of days until the secrets expire as an integer.'
    }
    AlreadyExpired = @{
        Info   = 'Would you like to see Applications with already expired secrets as well?'
        Prompt = 'Enter Yes or No'
    }
    DurationNotice = @{
        Info = @(
            'The operation is running and will take longer the more applications the tenant has...'
            'Please wait...'
        ) -join ' '
    }
    Export = @{
        Info = 'Where should the CSV file export to?'
        Prompt = 'Enter the full path in the format of <C:\Users\<USER>\Desktop\Users.csv>'
    }
}

Write-Host $Messages.ExpirationDays.Info -ForegroundColor Green
$DaysUntilExpiration = Read-Host -Prompt $Messages.ExpirationDays.Prompt

Write-Host $Messages.AlreadyExpired.Info -ForegroundColor Green
$IncludeAlreadyExpired = Read-Host -Prompt $Messages.AlreadyExpired.Prompt

$Now = Get-Date

Write-Host $Messages.DurationNotice.Info -ForegroundColor yellow

foreach ($App in $Applications) {
    $AppName = $App.DisplayName
    $AppID   = $App.Id
    $ApplID  = $App.AppId

    $AppCreds = Get-MgServicePrincipal -ServicePrincipalId $AppID |
        Select-Object PasswordCredentials, KeyCredentials

    $Secrets = $AppCreds.PasswordCredentials
    $Certs   = $AppCreds.KeyCredentials

    foreach ($Secret in $Secrets) {
        $StartDate  = $Secret.StartDateTime
        $EndDate    = $Secret.EndDateTime
        $SecretName = $Secret.DisplayName

        $Owner    = Get-MgServicePrincipalOwner -ServicePrincipalId $App.Id
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

        $RemainingDaysCount = $EndDate - $Now |
            Select-Object -ExpandProperty Days

        if ($IncludeAlreadyExpired -eq 'No') {
            if ($RemainingDaysCount -le $DaysUntilExpiration -and $RemainingDaysCount -ge 0) {
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
        } elseif ($IncludeAlreadyExpired -eq 'Yes') {
            if ($RemainingDaysCount -le $DaysUntilExpiration) {
                $Logs += [pscustomobject]@{
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
        }
    }


    foreach ($Cert in $Certs) {
        $StartDate = $Cert.StartDateTime
        $EndDate   = $Cert.EndDateTime
        $CertName  = $Cert.DisplayName

        $RemainingDaysCount = $EndDate - $Now |
            Select-Object -ExpandProperty Days

        $Owner    = Get-MgServicePrincipalOwner -ServicePrincipalId $App.Id
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

        if ($IncludeAlreadyExpired -eq 'No') {
            if ($RemainingDaysCount -le $DaysUntilExpiration -and $RemainingDaysCount -ge 0) {
                $Logs += [pscustomobject]@{
                    'ApplicationName'        = $AppName
                    'ApplicationID'          = $ApplID
                    'Secret Name'            = $Null
                    'Certificate Name'       = $CertName
                    'Certificate Start Date' = $StartDate
                    'Certificate End Date'   = $EndDate
                    'Owner'                  = $Username
                    'Owner_ObjectID'         = $OwnerID
                    'Secret Start Date'      = $Null
                    'Secret End Date'        = $Null
                }
            }
        } elseif ($IncludeAlreadyExpired -eq 'Yes') {
            if ($RemainingDaysCount -le $DaysUntilExpiration) {
                $Logs += [pscustomobject]@{
                    'ApplicationName'        = $AppName
                    'ApplicationID'          = $ApplID
                    'Certificate Name'       = $CertName
                    'Certificate Start Date' = $StartDate
                    'Certificate End Date'   = $EndDate
                    'Owner'                  = $Username
                    'Owner_ObjectID'         = $OwnerID
                    'Secret Start Date'      = $Null
                    'Secret End Date'        = $Null
                }
            }
        }
    }
}

Write-Host $Messages.Export.Info -ForegroundColor Green
$Path = Read-Host -Prompt $Messages.Export.Prompt
$Logs | Export-Csv $Path -NoTypeInformation -Encoding UTF8
```

## Script explanation

The script can be used directly without any modifications. The admin is asked about the expiration date and whether they would like to see already expired secrets or certificates or not.

The "Add-Member" command is responsible for creating the columns in the CSV file.
The "New-Object" command creates an object to be used for the columns in the CSV file export.
You can modify the "$Path" variable directly in PowerShell, with a CSV file path, in case you'd prefer the export to be non-interactive.

| Command | Notes |
|---|---|
| [Get-MgServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal?view=graph-powershell-1.0&preserve-view=true) | Retrieves an enterprise application from your directory. |
| [Get-MgServicePrincipalOwner](/powershell/module/microsoft.graph.applications/get-mgserviceprincipalowner?view=graph-powershell-1.0&preserve-view=true) | Retrieves the owners of an enterprise application from your directory. |

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell module overview](/powershell/microsoftgraph/installation).

For other PowerShell examples for Application Management, see [Azure Microsoft Graph PowerShell examples for Application Management](../app-management-powershell-samples.md).
