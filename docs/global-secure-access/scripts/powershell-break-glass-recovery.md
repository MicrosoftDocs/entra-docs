---
title: PowerShell sample - Recover from Global Secure Access break glass scenario
description: PowerShell examples that re-enable any Conditional Access policies that were disabled in a break glass scenario. 
author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.topic: sample
ms.date: 06/27/2024
ms.author: kenwith
ms.reviewer: frankgomulka
---

# Restore compliant network requirement after a break glass operation

After an outage is resolved, you need to make a fast and accurate recovery from a [break glass](./powershell-break-glass.md) operation.

Below you can view a script that can help you quickly regain the security value of [Global Secure Access](../overview-what-is-global-secure-access.md) and [Compliant Network](../how-to-compliant-network.md) for your users.

## Implement break glass recovery

The PowerShell script enables any forwarding profiles and any Conditional Access policies using the compliant network condition that were disabled in the [break glass](./powershell-break-glass.md) script. 

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

```powershell
# recoveryscript.ps1 enables any Conditional Access policies using the Compliant Network condition that were disabled in a breakglass scenario. 
# This script is the recovery method once the GSA service is back up after running .\gsabreakglass.ps1
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
# - Make sure your Administrator persona is an leveraging an Entra ID emergency access admin account, not subject to Microsoft Entra Internet Access Compliant Network policy, as described in https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access.
# - Make sure you run: Install-Module Microsoft.Graph.Beta -AllowClobber -Force
Import-Module Microsoft.Graph.Beta.Identity.SignIns
Connect-MgGraph -Scopes "Policy.Read.All,Policy.ReadWrite.ConditionalAccess"

$result = @()
$timeRun = Get-Date
$result += "Script was run at $($timeRun)`n"
# Enable Traffic Profiles
$disabledForwardingProfiles = Get-Content -Path "C:\BreakGlass\DisabledForwardingProfiles.txt"
if ($disabledForwardingProfiles.Count -gt 2) {
	$disabledForwardingProfiles = $disabledForwardingProfiles[1..($disabledForwardingProfiles.Count - 2)]
	foreach ($profile in $disabledForwardingProfiles)
	{
		$profile = $profile -split ','
		$body = @{ state = "enabled" } | ConvertTo-Json
		$check = Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/beta/networkaccess/forwardingprofiles/$($profile[1])" -Body $body -ContentType "application/json"
		if ($check.state -eq "enabled") {
			$profileContent = "{0},{1},{2}`n" -f $profile.name, $profile.id, $profile.lastModifiedDateTime
			$result += $profileContent
			Write-Host "$($profile[0]) is now enabled."
		} else {
			Write-Host "$($profile[0]) can't be enabled."
		}
	}

	$path = "C:\BreakGlass\RecoveredForwardingProfiles.txt"
	if (Test-Path $path)
	{
		$result | Out-File -FilePath $path
	} else {
		New-Item -Force -Path $path -Type File
		$result | Out-File -FilePath $path
	}
	Write-Host "`nResults have been exported to C:\BreakGlass\RecoveredForwardingProfiles.txt`n"
} else {
	Write-Host "There are no Forwarding Profiles to recover."
}

# Enable Compliant Network Conditional Access policies
$result = @()
$result += "Script was run at $($timeRun)"
$count = 0
$reportOnlyOutput = Get-Content -Path "C:\BreakGlass\ReportOnlyCompliantNetworkCAPolicies.txt"
if ($reportOnlyOutput.Count -le 3){
	Write-Host "There are no Conditional Access policies to recover. Exiting script."
	exit
}
$policiesToRecover = $reportOnlyOutput[2..($reportOnlyOutput.Count - 2)]
$result += "Total count of Compliant Network Conditional Access policies to recover: $($policiesToRecover.Count)"

# Based on admin input, either view or recover the list of policies disabled in the breakglass scenario.
$action = Read-Host "`nDo you want to recover all affected CA policies (type 'recover') or just view them (type 'view')?"
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
        New-Item -Force -Path $path -Type File
		$result | Out-File -FilePath $path
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
        $preRecoveryState = $preRecovery.state
        $preRecoveryTime = Get-Date
        Update-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policyId -BodyParameter $params
        
        $postRecoveryTime = Get-Date
        $postRecovery = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policyId
        $postRecoveryState = $postRecovery.state
        
        if ($postRecoveryState -eq "enabled") 
        {
            $policyContent = "{0},{1},{2},{3},{4},{5},{6}" -f $policyFields[0], $policyId, $policyFields[2], $policyFields[3], "State $($policyFields[4])", "State During Breakglass: $($preRecoveryState) at $($preRecoveryTime)", "State After Recovery: $($postRecoveryState) at $($postRecoveryTime)"
            $result += $policyContent
            $count++
			Write-Host "Policy with ID $($policyId) is now Enabled"
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
        New-Item -Force -Path $path -Type File
		$result | Out-File -FilePath $path
    }
    Write-Host "`nResults have been exported to C:\BreakGlass\RecoveredCompliantNetworkCAPolicies.txt`n"
}
```

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
