---
title: 'PowerShell sample: Export apps with secrets and certificates expiring beyond the required date'
description: PowerShell example that exports all apps with secrets and certificates expiring beyond the required date for the specified apps in your Microsoft Entra tenant.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.custom: no-azure-ad-ps-ref
ms.topic: sample
ms.date: 01/23/2025
ms.author: jomondi
ms.reviewer: mifarca
---

# PowerShell sample: Export apps with secrets and certificates expiring beyond the required date

This PowerShell script example exports all app registrations' secrets and certificates expiring beyond a required period. It performs this task for the specified apps from your directory. The script runs non-interactively. The output is saved in a CSV file.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

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

$loginURL = 'https://login.microsoftonline.com'
$resource = 'https://graph.microsoft.com'

#PARAMETERS TO CHANGE
$ClientID     = 'App ID'
$ClientSecret = 'APP Secret'
$TenantName   = 'TENANT.onmicrosoft.com'

$Months = 'Number of months'
$Path   = 'add a path here\File.csv'
###################################################################
#Repeating Function to get an Access Token based on the parameters:
function Get-RefreshedToken($LoginURL, $ClientID, $ClientSecret, $TenantName) {
    $RequestParameters = @{
        Method = 'POST'
        Uri    = "$LoginURL/$TenantName/oauth2/v2.0/token"
        Body   = @{
            grant_type    = 'client_credentials'
            client_id     = $ClientID
            client_secret = $ClientSecret
            scope         = 'https://graph.microsoft.com/.default'
        }
    }

    Invoke-RestMethod @RequestParameters
}

#BUILD THE ACCESS TOKEN
$RefreshParameters = @{
    LoginURL     = $loginURL
    ClientID     = $ClientID
    ClientSecret = $ClientSecret
    TenantName   = $TenantName
}
$OAuth    = Get-RefreshedToken @RefreshParameters
$Identity = $OAuth.access_token

##############################################

$HeaderParams = @{
    'Authorization' = "$($OAuth.token_type) $($Identity)"
}
$AppsSecrets = 'https://graph.microsoft.com/v1.0/applications'

$ApplicationsList = Invoke-WebRequest -Headers $HeaderParams -Uri $AppsSecrets -Method GET

$Logs        = @()
$NextCounter = 0

do {
    $ApplicationEvents = $ApplicationsList.Content |
        ConvertFrom-Json |
        Select-Object -ExpandProperty value

    foreach ($ApplicationEvent in $ApplicationEvents) {
        $IDs     = $ApplicationEvent.id
        $AppName = $ApplicationEvent.displayName
        $AppID   = $ApplicationEvent.appId
        $Secrets = $ApplicationEvent.passwordCredentials

        $NextCounter++

        foreach ($Secret in $Secrets) {
            $StartDate       = $Secret.startDateTime
            $EndDate         = $Secret.endDateTime
            $pos             = $StartDate.IndexOf('T')
            $LeftPart        = $StartDate.Substring(0, $pos)
            $Position        = $EndDate.IndexOf('T')
            $LeftPartEnd     = $EndDate.Substring(0, $pos)
            $DateStringStart = [Datetime]::ParseExact($LeftPart, 'yyyy-MM-dd', $null)
            $DateStringEnd   = [Datetime]::ParseExact($LeftPartEnd, 'yyyy-MM-dd', $null)
            $OptimalDate     = $DateStringStart.AddMonths($Months)

            if ($OptimalDate -lt $DateStringEnd) {
                $Log = [PSCustomObject]@{
                    'Application'       = $AppName
                    'AppID'             = $AppID
                    'Secret Start Date' = $DateStringStart
                    'Secret End Date'   = $DateStringEnd
                }

                $OwnerRequestParams = @{
                    Headers = $HeaderParams
                    Uri     = "https://graph.microsoft.com/v1.0/applications/$IDs/owners"
                    Method  = 'GET'
                }
                $ApplicationsOwners = Invoke-WebRequest @OwnerRequestParams

                $Users = $ApplicationsOwners.Content |
                    ConvertFrom-Json |
                    Select-Object -ExpandProperty value

                foreach ($User in $Users) {
                    $Owner = $User.displayname
                    $Log | Add-Member -MemberType NoteProperty -Name  'AppOwner' -Value $Owner
                }

                $Logs += $Log
            }
        }

        If ($NextCounter -eq 100) {
            $OData = $ApplicationsList.Content | ConvertFrom-Json
            $AppsSecrets = $OData.'@odata.nextLink'
            try {
                $ListRequestParams = @{
                    UseBasicParsing = $true
                    Headers         = $HeaderParams
                    Uri             = $AppsSecrets
                    Method          = 'GET'
                    ContentType     = 'application/Json'
                }
                $ApplicationsList = Invoke-WebRequest @ListRequestParams
            } catch {
                $_
            }

            $NextCounter = 0

            Start-Sleep -Seconds 1
        }
    }

} while ($AppsSecrets -ne $null)

$Logs | Export-Csv $Path -NoTypeInformation -Encoding UTF8
```

## Script explanation

This script is working non-interactively. The admin using it needs to change the values in the "#PARAMETERS TO CHANGE" section. They need to enter their own App ID, Application Secret, and Tenant Name. They also need to specify the period for the apps' credentials expiration. Finally, they need to set the path where the CSV is exported.

This script uses the [Client_Credential Oauth Flow](~/identity-platform/v2-oauth2-client-creds-grant-flow.md) The function "RefreshToken" builds the access token based on the values of the parameters modified by the admin.

The "Add-Member" command is responsible for creating the columns in the CSV file.

| Command | Notes |
|---|---|
| [Invoke-WebRequest](/powershell/module/microsoft.powershell.utility/invoke-webrequest) | Sends HTTP and HTTPS requests to a web page or web service. It parses the response and returns collections of links, images, and other significant HTML elements. |

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Management, see [Microsoft Graph PowerShell examples for Application Management](../app-management-powershell-samples.md).
