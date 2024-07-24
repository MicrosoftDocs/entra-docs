---
title: PowerShell sample - List and Disable Conditional Access policies using the Compliant Network condition in a break glass scenario.
description: PowerShell examples for use in a Microsoft Entra Internet Access break glass scenario. 
author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.topic: sample
ms.date: 06/27/2024
ms.author: kenwith
ms.reviewer: frankgomulka
---

# What is a Break Glass scenario?

In the event of an outage or connectivity failure to Microsoft Entra Internet Access, your users remain protected. However, you may want to perform a "break glass" operation: Temporarily disabling the Compliant Network condition policies can help your users regain access to their Microsoft apps in favor of productivity.

Below you can view sample scripts that can help you quickly switch your Conditional Access policies using the [Compliant Network](../how-to-compliant-network.md) condition into Report-Only mode.

## Step 1: List the Compliant Network Conditional Access policies

The PowerShell script is the prerequisite for running the break glass script in the event of an outage. It lists Conditional Access policies using the Compliant Network condition and stores the list on the local device.

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

```powershell
# listscript.ps1 lists the Compliant Network Conditional Access Policies for a tenant using Microsoft Entra Internet Access.
# It is a prerequisite for running .\breakglass.ps1 to disable Compliant Network policies in a breakglass scenario.
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
Connect-MgGraph -Scopes "Policy.Read.All"

$result = @()
$timeRun = Get-Date
$result += "Script was run at $($timeRun)"
$count = 0

# Search for any Conditional Access policies leveraging the Compliant Network condition.
$allCAPolicies = Get-MgBetaIdentityConditionalAccessPolicy
$allCompliantNetworkCAPolicies = @()
foreach ($policy in $allCAPolicies) 
{
    if ($policy.conditions.locations.excludeLocations -Contains "3d46dbda-8382-466a-856d-eb00cbc6b910" -or $policy.conditions.locations.includeLocations -Contains "3d46dbda-8382-466a-856d-eb00cbc6b910") 
    {
        $allCompliantNetworkCAPolicies += $policy
    }
}
$compliantNetworkCount = $allCompliantNetworkCAPolicies.Count
$result += "Total count of Compliant Network CA policies: $($compliantNetworkCount)"

# Save the list of Compliant Network CA policies to the C:\BreakGlass folder for use in .\breakglass.ps1
foreach ($policy in $allCompliantNetworkCAPolicies)
{
    $current = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policy.id
    $currentState = $current.state
    $currentTime = Get-Date
    $policyContent = "{0},{1},{2},{3},{4}" -f $policy.displayName, $policy.id, "Current State: $($currentState) at $($currentTime)", $policy.CreatedDateTime, $policy.ModifiedDateTime
    $result += $policyContent
}
$result += " "
$path = "C:\BreakGlass\ListCompliantNetworkCAPolicies.txt"
if (Test-Path $path)
{
    $result | Out-File -FilePath $path
} else {
    New-Item -Force -Path $path -Value $result -Type File
}
Write-Host "Results have been exported to C:\BreakGlass\ListCompliantNetworkCAPolicies.txt"
```

## Step 2: Switch listed policies into Report-Only mode

The PowerShell script effectively disables any Conditional Access policies that use the Compliant Network condition. In an emergency situation, this script can be used to temporarily regain access for your users.

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

```powershell
# breakglass.ps1 places the Compliant Network Conditional Access Policies for a given tenant using Microsoft Entra Internet Access into Report-Only mode.
# The prerequisite for running this script is running .\listscript.ps1.
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

$allCAPolicies = Get-MgBetaIdentityConditionalAccessPolicy
$allCompliantNetworkCAPolicies = @()

# Sort out only CA policies affected by Compliant Network
foreach ($policy in $allCAPolicies) 
{
    if ($policy.conditions.locations.excludeLocations -Contains "3d46dbda-8382-466a-856d-eb00cbc6b910" -or $policy.conditions.locations.includeLocations -Contains "3d46dbda-8382-466a-856d-eb00cbc6b910") 
    {
        $allCompliantNetworkCAPolicies += $policy
    }
}
$compliantNetworkCount = $allCompliantNetworkCAPolicies.Count
$result += "Total count of Compliant Network CA policies: $($compliantNetworkCount)"

# Based on admin input, disable either all or some Conditional Access policies leveraging the Compliant Network Condition.
$action = Read-Host "Do you want to put all enabled compliant network CA policies in Report-Only mode (type 'all') or just specific policy IDs (type 'ids')?"
if ($action -eq "all") 
{
    foreach ($policy in $allCompliantNetworkCAPolicies) 
    {
        if ($policy) 
        {
            #only BreakGlass if policy is already enabled
            if ($policy.state -eq "enabled")
            {
                $params = @{
                    state = "enabledForReportingButNotEnforced"
                }

                $current = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policy.id
                $currentState = $current.state
                $currentTime = Get-Date

                Update-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policy.id -BodyParameter $params
                
                $updatedTime = Get-Date
                $check = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policy.id
                $updatedState = $check.state
                
                if ($updatedState -eq "enabledForReportingButNotEnforced") 
                {
                    $policyContent = "{0},{1},{2},{3},{4},{5}" -f $policy.displayName, $policy.id, $policy.CreatedDateTime, $policy.ModifiedDateTime, "Before BreakGlass: $($currentState) at $($currentTime)", "After BreakGlass: $($updatedState) at $($updatedTime)"
                    $result += $policyContent
                    $count++
					Write-Host "Policy with ID $($policy.id) is now in Report-Only mode"
                } else {
                    Write-Host "Policy with ID $($policy.id) could not be put in Report-Only mode"
                }
            } else {
                Write-Host "Policy with ID $($policy.id) is already Disabled or Report-Only."
            }
        } else {
            Write-Host "Policy with ID $($policy.id) was not found."
        }
    }

} elseif ($action -eq "ids") {
    $policyIds = Read-Host "Enter the IDs of the policies you want to put in Report-Only mode (separated by commas):"
    $policyIds = $policyIds -split ","
   
    foreach ($id in $policyIds) 
    {
        $policy = $allCompliantNetworkPolicies | Where-Object { $_.id -eq $policy.id }
        if ($policy) 
        {
            if ($policy.state -eq "enabled")
            {
                $params = @{
                state = "enabledForReportingButNotEnforced"
                }

                $current = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policy.id
                $currentState = $current.state
                $currentTime = Get-Date

                Update-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policy.id -BodyParameter $params
                
                $updatedTime = Get-Date
                $check = Get-MgBetaIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $policy.id
                $updatedState = $check.state
                
                if ($updatedState -eq "enabledForReportingButNotEnforced") 
                {
                    $policyContent = "{0},{1},{2},{3},{4},{5}" -f $policy.displayName, $policy.id, $policy.CreatedDateTime, $policy.ModifiedDateTime, "Before BreakGlass: $($currentState) at $($currentTime)", "After BreakGlass: $($updatedState) at $($updatedTime)"
                    $result += $policyContent
                    $count++
                } else {
                    Write-Host "Policy with ID $($policy.id) could not be put in Report-Only mode"
                }
            } else {
                Write-Host "Policy with ID $($policy.id) is not already enabled."
            }
        } else {
            Write-Host "Policy with ID $id not found."
        }
    }
} else {
    Write-Host "Invalid action. Please type 'all' or 'ids'."
}

# Save the list of Compliant Network CA policies that were moved to Report-Only mode to the C:\BreakGlass folder for use in .\breakglass.ps1
$result += "Number of policies placed in Report-Only mode: $($count)"
$path = "C:\BreakGlass\ReportOnlyCompliantNetworkCAPolicies.txt"
if (Test-Path $path)
{
    $result | Out-File -FilePath $path
} else {
    New-Item -Force -Path $path -Value $result -Type File
}

Write-Host "Results have been exported to C:\BreakGlass\ReportOnlyCompliantNetworkCAPolicies.txt"
```

## Next steps

- [Recover from Break glass scenario](./powershell-compliant-network-breakglass-recovery.md)
- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
