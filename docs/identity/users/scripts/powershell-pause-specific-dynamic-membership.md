---
title: PowerShell sample - Pause specific groups and administrative units with dynamic membership
description: PowerShell sample that pauses specific groups and administrative units with dynamic membership in your Microsoft Entra tenant by accepting a list of IDs.
ms.topic: sample
ms.date: 06/11/2026
ms.reviewer: mbhargava
ai-usage: ai-assisted
---

# Pause specific groups and administrative units with dynamic membership

When you've isolated a dynamic membership problem to a known set of collections, you can pause just those collections instead of the entire tenant.

## Overview

This PowerShell sample pauses one or more groups and administrative units with dynamic membership rules that you specify by ID. Use this sample when you only need to pause processing for a known subset of dynamic membership collections. The script runs in two phases: you supply group IDs first, then administrative unit IDs, and you can run either phase or both.

## Important considerations

- Run the script from PowerShell 5.1 (x64) or later.
- Install the Microsoft Graph PowerShell module:

  ```powershell
  Install-Module Microsoft.Graph -Scope CurrentUser
  ```

- Sign in with an account that can manage the collections you target. The groups phase needs the [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator) Microsoft Entra role and requests the `Group.ReadWrite.All` Microsoft Graph scope. The administrative units phase needs the [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) Microsoft Entra role and requests the `AdministrativeUnit.ReadWrite.All` scope. The script requests only the scopes for the phases you run.
- The script runs in two phases: groups with dynamic membership first, then administrative units with dynamic membership. At the start of each phase, the script asks for confirmation. Enter `yes` to run that phase, or anything else to skip it. This lets you target only groups, only administrative units, or both in a single run.
- In large tenants, this script might trigger Microsoft Graph throttling. The script includes built-in retry handling, so expect a longer runtime rather than a failure. Don't cancel the script while it's running unless you see an explicit error.
- The script validates that each ID is a valid GUID and skips collections that aren't dynamic or that are already paused.
- Verify all steps in a test environment before you run the script in production.

## Sample script

```powershell
# DISCLAIMER:
# Copyright (c) Microsoft Corporation. All rights reserved. This
# script is made available to you without any express, implied or
# statutory warranty, not even the implied warranty of
# merchantability or fitness for a particular purpose, or the
# warranty of title or non-infringement. The entire risk of the
# use or the results from the use of this script remains with you.
#
# Usage: powershell.exe .\PauseSpecific.ps1
# This script allows you to pause specific dynamic membership collections (groups and administrative units).
# It can be helpful when you need to mitigate ongoing issues with your dynamic membership collections.

# This function checks if you are already connected to Microsoft Graph.
#     If yes,
#         It disconnects to fetch your current information. Then, it prompts you to confirm the your current information.
#             If you confirm, it reconnects to Microsoft Graph with Group.ReadWrite.All and AdministrativeUnit.ReadWrite.All permissions.
#             If you don't confirm, it will not reconnect and will prompt you to connect manually using Connect-MgGraph.
#     If not,
#         It attempts to connect to Microsoft Graph with Group.ReadWrite.All and AdministrativeUnit.ReadWrite.All permissions.
#         If it fails to connect, it informs you that the Microsoft.Graph module might not be installed and provides the command to install it.
# Microsoft Graph API version used for all requests in this script.
# Change to "beta" if you need to call beta endpoints. Default: "v1.0".
$graphApiVersion = "v1.0"

function ConnectToGraph {
    param (
        [string]$environment,
        [string[]]$scopes
    )
    # Check if already connected to Microsoft Graph
    if (Get-MgContext) {
        # Disconnect to fetch your current information
        $accountInfo = Disconnect-MgGraph
        Write-Host "MAKE SURE THE BELOW ACCOUNT/CLIENT APPLICATION HAS THE RIGHT SET OF PERMISSIONS TO PAUSE DYNAMIC MEMBERSHIP COLLECTIONS (GROUPS AND ADMINISTRATIVE UNITS)" -ForegroundColor Yellow
        Write-Host "Confirm the account: $($accountInfo.Account), TenantId: $($accountInfo.TenantId), and ClientId: $($accountInfo.ClientId)" -ForegroundColor Yellow
        $input = Read-Host "Type 'yes' to confirm: "
        if ($input.Trim().ToLower() -eq "yes") {
            # Reconnect with the scopes required by the phases the operator selected.
            Connect-MgGraph -Environment $environment -Scopes $scopes
        } else {
            # Inform you to reconnect manually
            Write-Host "Information not confirmed. Either re-run the script to confirm again or call <Connect-MgGraph> to log in using a different account." -ForegroundColor Yellow
            exit 1
        }
    } else {
        # Attempt to connect with the scopes required by the phases the operator selected.
        Connect-MgGraph -Environment $environment -Scopes $scopes
        if (Get-MgContext) {
            # Recursive call to confirm your information
            ConnectToGraph -environment $environment -scopes $scopes
        } else {
            # Inform you to install Microsoft.Graph module if not connected
            Write-Host "If the Microsoft.Graph module is not installed, you need to install it to run this script." -ForegroundColor Yellow
            Write-Host "Run <Install-Module Microsoft.Graph -Scope CurrentUser> as an administrator." -ForegroundColor Yellow
            exit 1
        }
    }
}

# This function pauses a specific group with dynamic membership.
# It handles any errors, including throttling, and retries if necessary.
function PauseGroup {
    param (
        [string] $uri, [string] $groupId
    )
    $invokeArgs = @{
        Uri     = $uri
        Method  = 'PATCH'
        Headers = @{ ConsistencyLevel = 'eventual' }
        Body    = $pauseDGjson
    }
    try {
        # Make PATCH request to pause the group
        Invoke-MgGraphRequest @invokeArgs
        Write-Host "Successfully paused group with dynamic membership. Id: $groupId" -ForegroundColor Green
        return $true
    } catch {
        # Handle errors and throttling
        $errorMessage = $_.Exception.Message
        $statusCode = $_.Exception.Response.StatusCode
        if ($statusCode -eq 429) {
            try {
                # Handle throttling if status code is 429 by sleeping then retrying once
                HandleThrottling -ErrorRecord $_
                Invoke-MgGraphRequest @invokeArgs
                Write-Host "Throttling mitigated. Successfully paused group with dynamic membership. Id: $groupId" -ForegroundColor Green
                return $true
            } catch {
                # Handle failure after throttling mitigation
                $errorMessage = $_.Exception.Message
                Write-Host "Failed to pause group with dynamic membership. Id: $groupId. Error message: $errorMessage" -ForegroundColor Red
                return $false
            }
        } else {
            # Handle other errors
            Write-Host "Failed to pause group with dynamic membership. Id: $groupId. Error message: $errorMessage" -ForegroundColor Red
            return $false
        }
    }
}

# This function pauses a specific administrative unit with dynamic membership.
# It handles any errors, including throttling, and retries if necessary.
function PauseAdministrativeUnit {
    param (
        [string] $uri, [string] $auId
    )
    $invokeArgs = @{
        Uri     = $uri
        Method  = 'PATCH'
        Headers = @{ ConsistencyLevel = 'eventual' }
        Body    = $pauseDGjson
    }
    try {
        # Make PATCH request to pause the administrative unit
        Invoke-MgGraphRequest @invokeArgs
        Write-Host "Successfully paused administrative unit with dynamic membership. Id: $auId" -ForegroundColor Green
        return $true
    } catch {
        # Handle errors and throttling
        $errorMessage = $_.Exception.Message
        $statusCode = $_.Exception.Response.StatusCode
        if ($statusCode -eq 429) {
            try {
                # Handle throttling if status code is 429 by sleeping then retrying once
                HandleThrottling -ErrorRecord $_
                Invoke-MgGraphRequest @invokeArgs
                Write-Host "Throttling mitigated. Successfully paused administrative unit with dynamic membership. Id: $auId" -ForegroundColor Green
                return $true
            } catch {
                # Handle failure after throttling mitigation
                $errorMessage = $_.Exception.Message
                Write-Host "Failed to pause administrative unit with dynamic membership. Id: $auId. Error message: $errorMessage" -ForegroundColor Red
                return $false
            }
        } else {
            # Handle other errors
            Write-Host "Failed to pause administrative unit with dynamic membership. Id: $auId. Error message: $errorMessage" -ForegroundColor Red
            return $false
        }
    }
}

# Function to validate GUID
function Is-Guid {
    param (
        [string]$Guid
    )
    return [guid]::TryParse($Guid, [ref]([guid]::Empty))
}

# Helper that prompts you for a comma-separated list of IDs of a given kind, validates them as GUIDs,
# echoes them back for confirmation, and returns the validated list.
# Returns $null if the user enters no valid IDs or declines to confirm.
function PromptForIdList {
    param (
        [string] $kindLabel
    )
    Write-Host "Enter the $kindLabel IDs (separated by comma if multiple):" -ForegroundColor Yellow
    $inputIds = Read-Host

    if ([string]::IsNullOrWhiteSpace($inputIds)) {
        Write-Host "No IDs entered." -ForegroundColor Red
        return $null
    }

    # Extracting individual IDs
    $idList = $inputIds -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }

    # Validate each ID and remove invalid ones
    $validIdList = @()
    $invalidIds = @()
    foreach ($id in $idList) {
        if (Is-Guid $id) {
            $validIdList += $id
        } else {
            $invalidIds += $id
        }
    }

    if ($invalidIds.Count -gt 0) {
        Write-Host "The following IDs are not valid GUIDs and will be removed:" -ForegroundColor Red
        foreach ($invalidId in $invalidIds) {
            Write-Host $invalidId
        }
    }

    if ($validIdList.Count -eq 0) {
        Write-Host "No valid IDs entered. Please re-run the script and provide IDs in GUID format." -ForegroundColor Red
        return $null
    }

    Write-Host "Confirm that you entered $($validIdList.count) valid $kindLabel ID(s), as displayed here:" -ForegroundColor Yellow
    foreach ($id in $validIdList) {
        Write-Host $id
    }

    $confirm = Read-Host "Type 'yes' to confirm: "
    if ($confirm.Trim().ToLower() -ne "yes") {
        return $null
    }

    Write-Host "You have confirmed the entry of valid $kindLabel IDs." -ForegroundColor Green
    return $validIdList
}

# Pauses each of the supplied groups (by ID) if it is a dynamic membership group currently in "On" state.
# Returns a hashtable with Success and Failure counts.
function PauseSpecificDynamicMembershipGroups {
    param (
        [string] $graphEndpoint,
        [string[]] $groupIdList
    )
    $successCount = 0
    $failureCount = 0

    foreach ($groupId in $groupIdList) {
        # Fetch the group with the id given by you.
        $uri = "$graphEndpoint/$graphApiVersion/groups/$groupId"
        try {
            $group = Invoke-MgGraphRequest -Method GET -Uri $uri
        } catch {
            # Branch on status so 429 retries, 404 reports as not-found, and other
            # errors are not silently mislabelled as "Could not find".
            $errorMessage = $_.Exception.Message
            $statusCode = $null
            try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
            if ($statusCode -eq 429) {
                try {
                    HandleThrottling -ErrorRecord $_
                    $group = Invoke-MgGraphRequest -Method GET -Uri $uri
                } catch {
                    $errorMessage = $_.Exception.Message
                    Write-Host "Failed to fetch the group with Id: $($groupId) after throttling mitigation. Error message: $($errorMessage)" -ForegroundColor Red
                    $failureCount++
                    continue
                }
            } elseif ($statusCode -eq 404) {
                Write-Host "Could not find the group with Id: $($groupId). Error message: $($errorMessage)" -ForegroundColor Red
                $failureCount++
                continue
            } else {
                $statusText = if ($statusCode) { "$statusCode" } else { "Unknown" }
                Write-Host "Failed to fetch the group with Id: $($groupId). Status: $statusText. Error message: $($errorMessage)" -ForegroundColor Red
                $failureCount++
                continue
            }
        }
        $isDynamic = $group.groupTypes -contains "DynamicMembership"
        $isUnpaused = $group.membershipRuleProcessingState -ceq "On"

        # Pause this group if it has a dynamic membership rule and is currently unpaused.
        if ($isDynamic -and $isUnpaused) {
            $result = PauseGroup -uri $uri -groupId $groupId
            if ($result) {
                $successCount++
            } else {
                $failureCount++
            }
        } else {
            if (-not $isDynamic) {
                Write-Host "Group skipped because it was found to be not a group with dynamic membership. Id: $($group.Id)" -ForegroundColor Yellow
                continue
            }
            Write-Host "Group skipped because it was found to be in $($group.membershipRuleProcessingState) state. Id: $($group.Id)" -ForegroundColor Yellow
        }
    }
    return @{ Success = $successCount; Failure = $failureCount }
}

# Pauses each of the supplied administrative units (by ID) if it is a dynamic membership AU currently in "On" state.
# Returns a hashtable with Success and Failure counts.
function PauseSpecificDynamicMembershipAdministrativeUnits {
    param (
        [string] $graphEndpoint,
        [string[]] $auIdList
    )
    $successCount = 0
    $failureCount = 0

    foreach ($auId in $auIdList) {
        # Fetch the administrative unit with the id given by you.
        $uri = "$graphEndpoint/$graphApiVersion/directory/administrativeUnits/$auId"
        try {
            $au = Invoke-MgGraphRequest -Method GET -Uri $uri
        } catch {
            $errorMessage = $_.Exception.Message
            $statusCode = $null
            try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
            if ($statusCode -eq 429) {
                try {
                    HandleThrottling -ErrorRecord $_
                    $au = Invoke-MgGraphRequest -Method GET -Uri $uri
                } catch {
                    $errorMessage = $_.Exception.Message
                    Write-Host "Failed to fetch the administrative unit with Id: $($auId) after throttling mitigation. Error message: $($errorMessage)" -ForegroundColor Red
                    $failureCount++
                    continue
                }
            } elseif ($statusCode -eq 404) {
                Write-Host "Could not find the administrative unit with Id: $($auId). Error message: $($errorMessage)" -ForegroundColor Red
                $failureCount++
                continue
            } else {
                $statusText = if ($statusCode) { "$statusCode" } else { "Unknown" }
                Write-Host "Failed to fetch the administrative unit with Id: $($auId). Status: $statusText. Error message: $($errorMessage)" -ForegroundColor Red
                $failureCount++
                continue
            }
        }
        $isDynamic = $au.membershipType -ceq "Dynamic"
        $isUnpaused = $au.membershipRuleProcessingState -ceq "On"

        # Pause this administrative unit if it has a dynamic membership rule and is currently unpaused.
        if ($isDynamic -and $isUnpaused) {
            $result = PauseAdministrativeUnit -uri $uri -auId $auId
            if ($result) {
                $successCount++
            } else {
                $failureCount++
            }
        } else {
            if (-not $isDynamic) {
                Write-Host "Administrative unit skipped because it was found to be not an administrative unit with dynamic membership. Id: $($au.Id)" -ForegroundColor Yellow
                continue
            }
            Write-Host "Administrative unit skipped because it was found to be in $($au.membershipRuleProcessingState) state. Id: $($au.Id)" -ForegroundColor Yellow
        }
    }
    return @{ Success = $successCount; Failure = $failureCount }
}

# Internal function to handle throttling and retry requests
# This function handles throttling by sleeping for the duration indicated by the Retry-After
# header (or a default of 60 seconds). The caller is responsible for retrying the request.
function HandleThrottling {
    param (
        [System.Management.Automation.ErrorRecord]$ErrorRecord
    )
    # Throttling occurred, extract Retry-After header if available
    $retryAfter = $ErrorRecord.Exception.Response.Headers.'Retry-After'
    if ($retryAfter) {
        Write-Host "Throttling detected. Waiting for $retryAfter seconds before retrying..."
        Start-Sleep -Seconds $retryAfter
    } else {
        # If Retry-After header is not available, wait for a default time
        Write-Host "Throttling detected. Waiting for default time i.e. 60 seconds before retrying..."
        Start-Sleep -Seconds 60  # Wait for 60 seconds by default
    }
}

# Function to prompt you to select the environment for determining the Microsoft Graph endpoint.
# This function helps you choose the correct environment and returns the corresponding endpoint.
function GetEnvironmentAndEndpoint {
    # Prompt you to select the environment
    try {
        $environmentChoice = Read-Host "Please select the environment (default is 'Global'): `nOptions: Global, USGov, USGovDoD, China"
    } catch {
        $environmentChoice = 'Global'
    }

    # Normalize the input to lower case
    $environmentChoice = $environmentChoice.Trim().ToLower()

    # Set the default environment to global
    $selectedEnvironment = "Global"

    # Map your choice to the corresponding environment
    switch ($environmentChoice) {
        "usgov" { $selectedEnvironment = "USGov" }
        "usgovdod" { $selectedEnvironment = "USGovDoD" }
        "china" { $selectedEnvironment = "China" }
        default { $selectedEnvironment = "Global" }
    }

    # Dictionary to map environment names to their endpoints
    $endpoints = @{
        "Global"   = "https://graph.microsoft.com"
        "USGov"    = "https://graph.microsoft.us"
        "USGovDoD" = "https://dod-graph.microsoft.us"
        "China"    = "https://microsoftgraph.chinacloudapi.cn"
    }

    $graphEndpoint = $endpoints[$selectedEnvironment]

    Write-Host "Environment Selected: $($selectedEnvironment). It maps to the graph endpoint: $($graphEndpoint)" -ForegroundColor Green

    # Return the selected environment and graph endpoint
    return @{ "SelectedEnvironment" = $selectedEnvironment; "GraphEndpoint" = $graphEndpoint }
}

#Running the script:
#Prompt you to confirm if you want to run the pause specific flow.
Write-Host "DO YOU WANT TO PAUSE SPECIFIC DYNAMIC MEMBERSHIP COLLECTIONS (GROUPS AND/OR ADMINISTRATIVE UNITS)?" -ForegroundColor Yellow
Write-Host "NOTE: If you are running this script as part of a mitigation exercise recommended by Microsoft, we strongly recommend performing this operation for BOTH groups and administrative units with dynamic membership (i.e. answer 'yes' to both phases below)." -ForegroundColor Cyan
$input = Read-Host "Type 'yes' to confirm: "

#Global variable for JSON change.
$global:pauseDGjson = '{"membershipRuleProcessingState":"Paused"}'

# Start the pause specific flow if confirmed.
if (($input.Trim().ToLower() -eq "yes")) {
    $result = GetEnvironmentAndEndpoint
    $selectedEnvironment = $result.SelectedEnvironment
    $graphEndpoint = $result.GraphEndpoint
    # Determine which phases the operator wants to run BEFORE connecting to Microsoft Graph,
    # so we only request the scopes needed for the selected phases. This avoids requiring
    # AdministrativeUnit.ReadWrite.All consent when the operator only wants to run the groups phase.
    Write-Host "" -ForegroundColor Yellow
    Write-Host "Before connecting to Microsoft Graph, please choose which phases to include in this run." -ForegroundColor Yellow
    Write-Host "Only the scopes required by the selected phases will be requested." -ForegroundColor Yellow

    Write-Host "" -ForegroundColor Yellow
    Write-Host "Include the groups phase (pause specific groups with dynamic membership by ID)?" -ForegroundColor Yellow
    Write-Host "(Type 'yes' to include, anything else to skip.)" -ForegroundColor Yellow
    $groupsPhaseInput = Read-Host "Type 'yes' to confirm: "
    $runGroupsPhase = $groupsPhaseInput.Trim().ToLower() -eq "yes"

    Write-Host "" -ForegroundColor Yellow
    Write-Host "Include the administrative units phase (pause specific administrative units with dynamic membership by ID)?" -ForegroundColor Yellow
    Write-Host "(Type 'yes' to include, anything else to skip.)" -ForegroundColor Yellow
    $ausPhaseInput = Read-Host "Type 'yes' to confirm: "
    $runAusPhase = $ausPhaseInput.Trim().ToLower() -eq "yes"

    # Build the scopes list based on the selected phases.
    $selectedScopes = @()
    if ($runGroupsPhase) { $selectedScopes += "Group.ReadWrite.All" }
    if ($runAusPhase) { $selectedScopes += "AdministrativeUnit.ReadWrite.All" }

    if ($selectedScopes.Count -eq 0) {
        Write-Host "" -ForegroundColor Yellow
        Write-Host "No phases selected. Exiting without connecting to Microsoft Graph." -ForegroundColor Yellow
        exit 0
    }

    try {
        # Show the operator which scopes will be requested so they know what consent to expect.
        Write-Host "" -ForegroundColor Yellow
        Write-Host "Requesting the following Microsoft Graph scope(s) for this run: $($selectedScopes -join ', ')" -ForegroundColor Yellow

        # Connect to Microsoft Graph requesting only the scopes needed for the selected phases.
        ConnectToGraph -environment $selectedEnvironment -scopes $selectedScopes

        # Track per-phase results so a combined summary can be printed at the end.
        $groupResult = $null
        $auResult = $null

        # Phase 1: groups with dynamic membership
        if ($runGroupsPhase) {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "PHASE 1 OF 2: GROUPS WITH DYNAMIC MEMBERSHIP" -ForegroundColor Yellow
            $groupIds = PromptForIdList -kindLabel "group"
            if ($groupIds -eq $null) {
                Write-Host "Phase 1 cancelled by user. No groups with dynamic membership were paused." -ForegroundColor Yellow
            } else {
                $groupResult = PauseSpecificDynamicMembershipGroups -graphEndpoint $graphEndpoint -groupIdList $groupIds
            }
        } else {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "Phase 1 skipped. No groups with dynamic membership were paused." -ForegroundColor Yellow
        }

        # Phase 2: administrative units with dynamic membership
        if ($runAusPhase) {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "PHASE 2 OF 2: ADMINISTRATIVE UNITS WITH DYNAMIC MEMBERSHIP" -ForegroundColor Yellow
            $auIds = PromptForIdList -kindLabel "administrative unit"
            if ($auIds -eq $null) {
                Write-Host "Phase 2 cancelled by user. No administrative units with dynamic membership were paused." -ForegroundColor Yellow
            } else {
                $auResult = PauseSpecificDynamicMembershipAdministrativeUnits -graphEndpoint $graphEndpoint -auIdList $auIds
            }
        } else {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "Phase 2 skipped. No administrative units with dynamic membership were paused." -ForegroundColor Yellow
        }

        # Combined summary
        Write-Host "" -ForegroundColor Yellow
        Write-Host "PauseSpecific Operation Complete." -ForegroundColor Yellow
        if ($groupResult) {
            Write-Host "Groups with dynamic membership - Successfully Paused: $($groupResult.Success), Failed: $($groupResult.Failure)" -ForegroundColor Yellow
        } else {
            Write-Host "Groups with dynamic membership - Phase skipped or cancelled." -ForegroundColor Yellow
        }
        if ($auResult) {
            Write-Host "Administrative units with dynamic membership - Successfully Paused: $($auResult.Success), Failed: $($auResult.Failure)" -ForegroundColor Yellow
        } else {
            Write-Host "Administrative units with dynamic membership - Phase skipped or cancelled." -ForegroundColor Yellow
        }
    } catch {
        # Handle any errors during the process
        $errorMessage = $_.Exception.Message
        Write-Host "PauseSpecific operation failed. Error message: $($errorMessage)" -ForegroundColor Red
    }
# Inform you that the input was not accepted.
} else {
    Write-Host "PauseSpecific script terminated. Please re-run the script and input 'yes' to run the PauseSpecific script." -ForegroundColor Red
}
```

## Next steps

- [Understand and manage dynamic group processing in Microsoft Entra ID](../manage-dynamic-group.md)
- [Dynamic membership rules for groups](../groups-dynamic-membership.md)
- [Administrative units in Microsoft Entra ID](../../role-based-access-control/administrative-units.md)
- [Microsoft Graph PowerShell module installation](/powershell/microsoftgraph/installation)
