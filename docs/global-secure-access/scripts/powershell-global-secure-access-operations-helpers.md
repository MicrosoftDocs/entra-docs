---
title: PowerShell sample - Shared helper functions for Microsoft Entra Global Secure Access operations
description: "Use shared helper functions for authentication and alert email in Global Secure Access operations automation scripts."
ms.topic: sample
ms.date: 06/17/2026
ms.reviewer: tdetzner
ai-usage: ai-assisted
---

# Shared helper functions for Microsoft Entra Global Secure Access operations

This helper file provides shared authentication and alert email functions used by the Global Secure Access operations automation scripts. Download or copy this helper into the same folder as the scripts that dot-source `_GsaOpsHelpers.ps1`.

The helper supports Azure authentication, Microsoft Graph authentication, Log Analytics token checks, and alert email delivery through Microsoft Graph.

## Prerequisites

- PowerShell 7.0 or later.
- Install the modules listed in the script's `.NOTES` block.
- Use only permissions and roles that your organization has approved for the task.

## Script

```powershell
<#
.SYNOPSIS
    Shared helpers for GSA operations automation scripts.
.DESCRIPTION
    Dot-source this file from any script in scripts/automation/ that needs to
    authenticate to Azure and/or Microsoft Graph, or send an HTML alert email
    via Microsoft Graph.

    Exposed functions:
        Connect-GsaRuntime  - Ensure Az and/or Microsoft Graph contexts exist.
                              Tries managed identity first; if unavailable,
                              falls back to interactive browser login, then
                              device-code. Accepts -TenantId and -SubscriptionId.
                              Reuses existing contexts when tenant/subscription
                              match. Throws on failure.
        Confirm-GsaLogAnalyticsAccess
                            - Ensures the Az session holds a Log Analytics
                              token. Tenants with CA policies may issue
                              ARM-only tokens; this helper detects and fixes
                              that. Call before Invoke-AzOperationalInsightsQuery.
        Send-GsaAlertEmail  - Send an HTML alert email through Microsoft Graph
                              using Send-MgUserMail. Throws on failure.

    Both helpers throw terminating errors so the calling script can surface
    auth and delivery failures via standard try/catch, rather than masking
    them with Write-Warning and continuing.

    Example:
        . "$PSScriptRoot\_GsaOpsHelpers.ps1"
        Connect-GsaRuntime -Service Both
        Send-GsaAlertEmail -SenderId 'gsa-automation@contoso.com' `
                           -Recipient 'gsa-ops@contoso.com' `
                           -Subject  'GSA alert'                `
                           -HtmlBody '<p>Body</p>'
.NOTES
    Minimum module versions:
        Az.Accounts 2.x
        Microsoft.Graph.Authentication 2.x
        Microsoft.Graph.Users.Actions 2.x
    PowerShell 5.1+. Callers that use `ConvertFrom-Json -AsHashtable` require
    PowerShell 7.0 or later.
    Author: GSA Operations
#>

function Connect-GsaRuntime {
    <#
    .SYNOPSIS
        Ensures an Az and/or Microsoft Graph context is available.
    .DESCRIPTION
        If no context is already established for the requested service, attempts
        to authenticate in this order:
          1. Reuse an existing context (no-op if tenant and subscription match).
          2. Managed identity (Azure Automation, App Service, etc.).
          3. Interactive browser login (local development / test).
          4. Device-code fallback (headless terminals).
        Throws on failure. Safe to call multiple times.
    .PARAMETER Service
        Which service contexts to ensure. One of: Az, Graph, Both. Default: Both.
    .PARAMETER TenantId
        Microsoft Entra tenant ID to target. When supplied and a context for a
        different tenant is active, the existing context is replaced.
    .PARAMETER SubscriptionId
        Optional Azure subscription ID to set as the active context.
    #>
    [CmdletBinding()]
    param(
        [ValidateSet('Az', 'Graph', 'Both')]
        [string]$Service = 'Both',

        [string]$TenantId,

        [string]$SubscriptionId
    )

    if ($Service -in 'Az', 'Both') {
        $azContext = Get-AzContext -ErrorAction SilentlyContinue
        if ($azContext) {
            $tenantOk = (-not $TenantId) -or ($azContext.Tenant.Id -eq $TenantId)
            $subOk    = (-not $SubscriptionId) -or ($azContext.Subscription.Id -eq $SubscriptionId)
            if ($tenantOk -and $subOk) {
                Write-Verbose ("Reusing existing Az context (tenant {0}, subscription {1})." -f $azContext.Tenant.Id, $azContext.Subscription.Id)
            } elseif ($tenantOk -and $SubscriptionId) {
                Set-AzContext -SubscriptionId $SubscriptionId -ErrorAction Stop | Out-Null
                Write-Verbose ("Switched subscription to {0}." -f $SubscriptionId)
            } else {
                # Tenant mismatch — disconnect and re-authenticate below
                Disconnect-AzAccount -ErrorAction SilentlyContinue | Out-Null
                $azContext = $null
            }
        }

        if (-not $azContext) {
            $connectParams = @{ ErrorAction = 'Stop' }
            if ($TenantId)       { $connectParams['TenantId']     = $TenantId }
            if ($SubscriptionId) { $connectParams['Subscription'] = $SubscriptionId }

            # 1. Managed identity
            try {
                Connect-AzAccount -Identity @connectParams | Out-Null
                Write-Verbose "Connected to Azure via managed identity."
            } catch {
                Write-Verbose "Managed identity unavailable for Azure — falling back to interactive login."
                # 2. Interactive browser
                try {
                    Connect-AzAccount @connectParams | Out-Null
                    Write-Verbose "Connected to Azure via interactive login."
                } catch {
                    Write-Verbose ("Interactive browser failed: {0}. Trying device-code." -f $_.Exception.Message)
                    # 3. Device-code fallback
                    try {
                        Connect-AzAccount -UseDeviceAuthentication @connectParams | Out-Null
                        Write-Verbose "Connected to Azure via device-code."
                    } catch {
                        throw "Failed to obtain an Azure context via managed identity, browser, or device-code. Error: $_"
                    }
                }
            }
            if (-not (Get-AzContext -ErrorAction SilentlyContinue)) {
                throw "Connect-AzAccount returned without an error but no Az context is available."
            }
        }
    }

    if ($Service -in 'Graph', 'Both') {
        $mgContext = Get-MgContext -ErrorAction SilentlyContinue
        if ($mgContext) {
            $tenantOk = (-not $TenantId) -or ($mgContext.TenantId -eq $TenantId)
            if ($tenantOk) {
                Write-Verbose ("Reusing existing Graph context (tenant {0})." -f $mgContext.TenantId)
            } else {
                Disconnect-MgGraph -ErrorAction SilentlyContinue | Out-Null
                $mgContext = $null
            }
        }

        if (-not $mgContext) {
            $mgParams = @{ NoWelcome = $true; ErrorAction = 'Stop' }
            if ($TenantId) { $mgParams['TenantId'] = $TenantId }

            # 1. Managed identity
            try {
                Connect-MgGraph -Identity @mgParams | Out-Null
                Write-Verbose "Connected to Microsoft Graph via managed identity."
            } catch {
                Write-Verbose "Managed identity unavailable for Graph — falling back to interactive login."
                # 2. Interactive browser
                try {
                    Connect-MgGraph @mgParams | Out-Null
                    Write-Verbose "Connected to Microsoft Graph via interactive login."
                } catch {
                    throw "Failed to obtain a Microsoft Graph context via managed identity or interactive login. Error: $_"
                }
            }
            if (-not (Get-MgContext -ErrorAction SilentlyContinue)) {
                throw "Connect-MgGraph returned without an error but no Graph context is available."
            }
        }
    }
}

function Confirm-GsaLogAnalyticsAccess {
    <#
    .SYNOPSIS
        Ensures the current Az context holds a Log Analytics token.
    .DESCRIPTION
        Tenants with conditional access policies (e.g. MFA) may issue an
        ARM-only token on initial Connect-AzAccount. Calls to
        Invoke-AzOperationalInsightsQuery then fail with:

            "Authentication failed against resource
             OperationalInsightsEndpointResourceId."

        This function detects that condition by attempting to acquire a token
        for the Log Analytics resource (https://api.loganalytics.io). If the
        token request fails, it re-authenticates with the
        OperationalInsightsEndpointResourceId scope.

        Call this after Connect-GsaRuntime and before any
        Invoke-AzOperationalInsightsQuery call.
    #>
    [CmdletBinding()]
    param()

    $context = Get-AzContext -ErrorAction SilentlyContinue
    if (-not $context) {
        throw 'No Az context available. Call Connect-GsaRuntime first.'
    }

    try {
        $null = Get-AzAccessToken -ResourceUrl 'https://api.loganalytics.io' -ErrorAction Stop
        Write-Verbose 'Log Analytics token is available.'
        return
    } catch {
        Write-Verbose ("Log Analytics token not available: {0}" -f $_.Exception.Message)
    }

    Write-Verbose 'Acquiring Log Analytics token (conditional access may prompt for MFA)...'
    $connectParams = @{
        AuthScope   = 'OperationalInsightsEndpointResourceId'
        TenantId    = $context.Tenant.Id
        ErrorAction = 'Stop'
    }

    try {
        Connect-AzAccount @connectParams | Out-Null
        Write-Verbose 'Re-authenticated with browser for Log Analytics scope.'
    } catch {
        Write-Verbose ("Browser re-auth failed: {0}. Trying device-code." -f $_.Exception.Message)
        try {
            Connect-AzAccount -UseDeviceAuthentication @connectParams | Out-Null
            Write-Verbose 'Re-authenticated with device-code for Log Analytics scope.'
        } catch {
            throw "Failed to acquire a Log Analytics token. Error: $_"
        }
    }
}

function Send-GsaAlertEmail {
    <#
    .SYNOPSIS
        Sends an HTML alert email via Microsoft Graph.
    .DESCRIPTION
        Wraps Send-MgUserMail with a consistent HTML message envelope. The
        sender mailbox must exist in the tenant and the calling identity must
        hold Mail.Send for that mailbox. Throws on failure so the caller can
        decide whether to log, retry, or rethrow.
    .PARAMETER SenderId
        UserId or UPN of the sending mailbox.
    .PARAMETER Recipient
        Email address of the recipient.
    .PARAMETER Subject
        Subject line of the alert.
    .PARAMETER HtmlBody
        HTML body of the alert. Caller is responsible for HTML-escaping any
        dynamic content that could otherwise break the message.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$SenderId,

        [Parameter(Mandatory)]
        [string]$Recipient,

        [Parameter(Mandatory)]
        [string]$Subject,

        [Parameter(Mandatory)]
        [string]$HtmlBody
    )

    $message = @{
        Message = @{
            Subject      = $Subject
            Body         = @{
                ContentType = 'HTML'
                Content     = $HtmlBody
            }
            ToRecipients = @(@{ EmailAddress = @{ Address = $Recipient } })
        }
        SaveToSentItems = $false
    }

    try {
        Send-MgUserMail -UserId $SenderId -BodyParameter $message -ErrorAction Stop
        Write-Verbose "Alert email sent from '$SenderId' to '$Recipient'."
    } catch {
        throw "Failed to send alert email via Microsoft Graph (Sender='$SenderId', Recipient='$Recipient'). Verify the Mail.Send permission and that the sending mailbox exists. Error: $_"
    }
}
```

## Related content

- [Global Secure Access PowerShell samples](../powershell-samples.md)
- [Microsoft Entra Global Secure Access operations guide](../overview-operations.md)
