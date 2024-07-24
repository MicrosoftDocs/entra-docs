---
title: PowerShell sample - Recover from Global Secure Access Break glass scenario
description: PowerShell examples that re-enableany Conditional Access policies that were disabled in a break glass scenario. 
author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.topic: sample
ms.date: 06/27/2024
ms.author: kenwith
ms.reviewer: frankgomulka
---

# Swift Recovery is Critical

After an outage is resolved, you need to recover from a [Break Glass](./powershell-compliant-network-breakglass.md#step-2-switch-listed-policies-into-report-only-mode) operation fast and with accuracy.

Below you can view a script that can help you quickly regain the security value of [Compliant Network](../how-to-compliant-network.md) for your users.

## Recover from Break Glass

The PowerShell script enables any Conditional Access policies using the Compliant Network condition that were disabled in the [Break Glass](./powershell-compliant-network-breakglass.md#step-2-switch-listed-policies-into-report-only-mode) script. 

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

```powershell
# recoveryscript.ps1 enables any Conditional Access policies using the Compliant Network condition that were disabled in a breakglass scenario. 
# This script is the recovery method once the GSA service is back up after running .\breakglass.ps1
#
# Version 1.0
#
# This script requires following 
#    - PowerShell 5.1 (x64) or beyond
#    - Module: Microsoft.Graph.Beta
#
#
# Before you begin:
#    
# - Make sure you are running PowerShell as an Administrator
# - Make sure your Administrator persona is an leveraging an Entra ID emergency access admin account, not subject to Microsoft Entra Internet Access Compliant Network policy, as described in https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access.
# - Make sure you run: Install-Module Microsoft.Graph.Beta -AllowClobber -Force
# - Make sure there is no other C:\BreakGlass folder on your machine. If you have some files stored, please move those before running the script 
Import-Module Microsoft.Graph.Beta.Identity.SignIns
Connect-MgGraph -Scopes "Policy.Read.All,Policy.ReadWrite.ConditionalAccess"

$result = @()
$timeRun = Get-Date
$result += "Script was run at $($timeRun)"
$count = 0

$reportOnlyOutput = Get-Content -Path "C:\BreakGlass\ReportOnlyCompliantNetworkCAPolicies.txt"
$policiesToRecover = $reportOnlyOutput[2..($reportOnlyOutput.Count - 2)]
$result += "Total count of Compliant Network Conditional Access policies to recover: $($policiesToRecover.Count)"

# Based on admin input, either view or recover the list of policies disabled in the breakglass scenario.
$action = Read-Host "Do you want to recover all affected policies (type 'recover') or just view them (type 'view')?"
if ($action -eq "view") {
    $result += "Total count of policies to revert: $($policiesToRecover.Count)"
    foreach ($policy in $policiesToRecover) 
    {
        $policyFields = $policiesToRecover -split ','
        $policyId = $policyFields[1]
        $current = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policyId
        $currentState = $current.state
        $currentTime = Get-Date
        $policyContent = "{0},{1},{2},{3},{4},{5},{6}" -f $policyFields[0], $policyId, $policyFields[2], $policyFields[3], "State Before Recovery: $($policyFields[4])", "State During Recovery: $($currentState) at $($currentTime)", "State After Recovery: enabled)"
        $result += $policyContent
    }
    $path = "C:\BreakGlass\ViewCompliantNetworkCAPoliciesToRecover.txt"
    if (Test-Path $path)
    {
        $result | Out-File -FilePath $path
    } else {
        New-Item -Force -Path $path -Value $result -Type File
    }

    Write-Host "Results have been exported to C:\BreakGlass\ViewCompliantNetworkCAPoliciesToRecover.txt"
} elseif ($action -eq "recover") {
    foreach ($policy in $policiesToRecover) 
    {
        $policyFields = $policiesToRecover -split ','
        $policyId = $policyFields[1]

        $params = @{
            state = "enabled"
        }

        $preRecovery = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policyId
        $preRecoveryState = $current.state
        $preRecoveryTime = Get-Date

        Update-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policyId -BodyParameter $params
        
        $postRecoveryTime = Get-Date
        $postRecovery = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policyId
        $postRecoveryState = $postRecovery.state
        
        if ($postRecoveryState -eq "enabled") 
        {
            $policyContent = "{0},{1},{2},{3},{4},{5},{6}" -f $policyFields[0], $policyId, $policyFields[2], $policyFields[3], "State Before BreakGlass: $($policyFields[4])", "State During Breakglass: $($preRecoveryState) at $($preRecoveryTime)", "State After Recovery: $($postRecoveryState) at $($postRecoveryTime)"
            $result += $policyContent
            $count++
        } else {
            Write-Host "Policy with ID $($policy.id) could not be enabled"
        }
    }

    $result += "Number of policies recovered: $($count)"

    $path = "C:\BreakGlass\RecoveredCompliantNetworkCAPolicies.txt"
    if (Test-Path $path)
    {
        $result | Out-File -FilePath $path
    } else {
        New-Item -Force -Path $path -Value $result -Type File
    }

    Write-Host "Results have been exported to C:\BreakGlass\RecoveredCompliantNetworkCAPolicies.txt"
}
```

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
