---
title: PowerShell sample - Resume noncritical groups and administrative units with dynamic membership in batches
description: PowerShell sample that resumes dynamic membership processing for noncritical groups and administrative units in your Microsoft Entra tenant, up to 100 of each per run.
ms.topic: sample
ms.date: 06/11/2026
ms.reviewer: mbhargava
ai-usage: ai-assisted
---

# Resume noncritical groups and administrative units with dynamic membership in batches

After your critical collections are back online, resume the remaining noncritical collections in controlled batches to avoid overwhelming dynamic membership processing.

## Overview

This PowerShell sample resumes dynamic membership rule processing for paused noncritical groups and administrative units, up to 100 of each per run. Run this sample after you've resumed your critical collections and waited at least 12 hours since pausing. Batching prevents the service from being overwhelmed when many collections resume processing simultaneously. The script runs in two phases: up to 100 groups first, then up to 100 administrative units.

## Important considerations

- Run the script from PowerShell 5.1 (x64) or later.
- Install the Microsoft Graph PowerShell module:

  ```powershell
  Install-Module Microsoft.Graph -Scope CurrentUser
  ```

- Sign in with an account that can manage the collections you target. The groups phase needs the [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator) Microsoft Entra role and requests the `Group.ReadWrite.All` Microsoft Graph scope. The administrative units phase needs the [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) Microsoft Entra role and requests the `AdministrativeUnit.ReadWrite.All` scope. The script requests only the scopes for the phases you run.
- The script runs in two phases: groups with dynamic membership first, then administrative units with dynamic membership. At the start of each phase, the script asks for confirmation. Enter `yes` to run that phase, or anything else to skip it. This lets you target only groups, only administrative units, or both in a single run.
- In large tenants, this script might trigger Microsoft Graph throttling. The script includes built-in retry handling, so expect a longer runtime rather than a failure. Don't cancel the script while it's running unless you see an explicit error.
- Resume critical collections first using the [resume-specific-critical sample](powershell-resume-specific-critical-dynamic-membership.md).
- The script processes up to 100 groups and up to 100 administrative units per run. Run it repeatedly until all noncritical collections are resumed.
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
# Usage: powershell.exe .\UnpauseNonCritical.ps1
# This script allows you to unpause non critical dynamic membership collections (groups and administrative units), 100 at a time per phase.
# It can be helpful when you need to mitigate ongoing issues with your collections that have dynamic membership rules.

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
        Write-Host "MAKE SURE THE BELOW ACCOUNT/CLIENT APPLICATION HAS THE RIGHT SET OF PERMISSIONS TO UNPAUSE DYNAMIC MEMBERSHIP COLLECTIONS (GROUPS AND ADMINISTRATIVE UNITS)" -ForegroundColor Yellow
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

# This function fetches a single page of items (groups or administrative units) from Microsoft Graph.
# It returns the items and the next page token if available.
function PageableFetchFromGraph {
    param (
        [string] $uri,
        [hashtable] $headers = @{},
        [string] $kindLabel = "item"
    )
    # Save the request args so we can retry the same call after throttling.
    $invokeArgs = @{
        Method = 'GET'
        Uri    = $uri
    }
    if ($headers.Count -gt 0) {
        $invokeArgs.Headers = $headers
    }
    try {
        # Make GET request to fetch items. AU queries require additional advanced query option headers.
        $response = Invoke-MgGraphRequest @invokeArgs
        $items = $response.value
        $nextPage = $response.'@odata.nextLink'
        Write-Host "Found $($items.count) $kindLabel(s) with dynamic membership." -ForegroundColor Green
        return $items, $nextPage
    } catch {
        # Handle any errors during fetch, including throttling
        $errorMessage = $_.Exception.Message
        $statusCode = $null
        try { $statusCode = [int]$_.Exception.Response.StatusCode } catch {}
        if ($statusCode -eq 429) {
            try {
                # Sleep then retry the same request once after throttling
                HandleThrottling -ErrorRecord $_
                $response = Invoke-MgGraphRequest @invokeArgs
                $items = $response.value
                $nextPage = $response.'@odata.nextLink'
                Write-Host "Throttling mitigated. Found $($items.count) $kindLabel(s) with dynamic membership." -ForegroundColor Green
                return $items, $nextPage
            } catch {
                $errorMessage = $_.Exception.Message
                Write-Host "Failed to fetch $kindLabel(s) with dynamic membership after throttling mitigation. URI: $uri" -ForegroundColor Red
                Write-Host "Error message: $($errorMessage)" -ForegroundColor Red
                return $null
            }
        }
        $responseBody = $null
        try {
            if ($_.ErrorDetails -and $_.ErrorDetails.Message) {
                $responseBody = $_.ErrorDetails.Message
            } elseif ($_.Exception.Response) {
                $stream = $_.Exception.Response.GetResponseStream()
                if ($stream) {
                    $reader = New-Object System.IO.StreamReader($stream)
                    $responseBody = $reader.ReadToEnd()
                }
            }
        } catch {}
        Write-Host "Failed to fetch $kindLabel(s) with dynamic membership. URI: $uri" -ForegroundColor Red
        Write-Host "Error message: $($errorMessage)" -ForegroundColor Red
        if ($responseBody) {
            Write-Host "Response body: $responseBody" -ForegroundColor Red
        }
        return $null
    }
}

# This function unpauses a specific group with dynamic membership.
# It handles any errors, including throttling, and retries if necessary.
function UnpauseGroup {
    param (
        [string] $uri, [string] $groupId
    )
    $invokeArgs = @{
        Uri     = "$uri/$groupId"
        Method  = 'PATCH'
        Headers = @{ ConsistencyLevel = 'eventual' }
        Body    = $unpauseDGjson
    }
    try {
        # Make PATCH request to unpause the group
        Invoke-MgGraphRequest @invokeArgs
        Write-Host "Successfully unpaused group with dynamic membership. Id: $groupId" -ForegroundColor Green
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
                Write-Host "Throttling mitigated. Successfully unpaused group with dynamic membership. Id: $groupId" -ForegroundColor Green
                return $true
            } catch {
                # Handle failure after throttling mitigation
                $errorMessage = $_.Exception.Message
                Write-Host "Failed to unpause group with dynamic membership. Id: $groupId. Error message: $errorMessage" -ForegroundColor Red
                return $false
            }
        } else {
            # Handle other errors
            Write-Host "Failed to unpause group with dynamic membership. Id: $groupId. Error message: $errorMessage" -ForegroundColor Red
            return $false
        }
    }
}

# This function unpauses a specific administrative unit with dynamic membership.
# It handles any errors, including throttling, and retries if necessary.
function UnpauseAdministrativeUnit {
    param (
        [string] $uri, [string] $auId
    )
    $invokeArgs = @{
        Uri     = "$uri/$auId"
        Method  = 'PATCH'
        Headers = @{ ConsistencyLevel = 'eventual' }
        Body    = $unpauseDGjson
    }
    try {
        # Make PATCH request to unpause the administrative unit
        Invoke-MgGraphRequest @invokeArgs
        Write-Host "Successfully unpaused administrative unit with dynamic membership. Id: $auId" -ForegroundColor Green
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
                Write-Host "Throttling mitigated. Successfully unpaused administrative unit with dynamic membership. Id: $auId" -ForegroundColor Green
                return $true
            } catch {
                # Handle failure after throttling mitigation
                $errorMessage = $_.Exception.Message
                Write-Host "Failed to unpause administrative unit with dynamic membership. Id: $auId. Error message: $errorMessage" -ForegroundColor Red
                return $false
            }
        } else {
            # Handle other errors
            Write-Host "Failed to unpause administrative unit with dynamic membership. Id: $auId. Error message: $errorMessage" -ForegroundColor Red
            return $false
        }
    }
}

# Unpauses up to 100 non-critical paused groups with dynamic membership in a single page.
# Returns a hashtable with Success and Failure counts, or $null if the fetch failed.
function UnpauseNonCriticalDynamicMembershipGroups {
    param (
        [string] $graphEndpoint
    )
    # Fetch up to 100 paused groups with dynamic membership (single page; cap at 100 by design).
    # The groupTypes/any(...) lambda filter requires advanced query options (ConsistencyLevel: eventual and $count=true).
    # The filter value must be pre-encoded because Invoke-MgGraphRequest double-encodes
    # URLs containing unescaped (, ), or : characters.
    $url = "$graphEndpoint/$graphApiVersion/groups"
    $filterValue = "groupTypes/any(c:c eq 'DynamicMembership') and membershipRuleProcessingState eq 'Paused'"
    $encodedFilter = [uri]::EscapeDataString($filterValue)
    $uri = "$url`?`$filter=$encodedFilter&`$count=true&`$top=100"
    $advancedHeaders = @{ ConsistencyLevel = 'eventual' }

    $successCount = 0
    $failureCount = 0

    $groupsData = PageableFetchFromGraph -uri $uri -headers $advancedHeaders -kindLabel "group"
    if ($groupsData -eq $null) {
        Write-Host "Phase 1 terminated due to fetch failure." -ForegroundColor Red
        return $null
    }
    $dynamicGroups = $groupsData[0]

    foreach ($group in $dynamicGroups) {
        if ($group.membershipRuleProcessingState -ceq "Paused") {
            $result = UnpauseGroup -uri $url -groupId $group.id
            if ($result) {
                $successCount++
            } else {
                $failureCount++
            }
        } else {
            # Skip groups that are not in "Paused" state
            Write-Host "Group skipped because it was found to be in $($group.membershipRuleProcessingState) state. Id: $($group.Id)" -ForegroundColor Yellow
        }
    }
    return @{ Success = $successCount; Failure = $failureCount }
}

# Unpauses up to 100 non-critical paused administrative units with dynamic membership in a single page.
# Returns a hashtable with Success and Failure counts, or $null if the fetch failed.
function UnpauseNonCriticalDynamicMembershipAdministrativeUnits {
    param (
        [string] $graphEndpoint
    )
    # Fetch up to 100 paused administrative units with dynamic membership (single page; cap at 100 by design).
    # AU dynamic membership queries require advanced query options ($count + ConsistencyLevel: eventual).
    $url = "$graphEndpoint/$graphApiVersion/directory/administrativeUnits"
    $filter = "?`$filter=membershipType eq 'Dynamic' and membershipRuleProcessingState eq 'Paused'"
    $countAndTop = "&`$count=true&`$top=100"
    $uri = "$url$filter$countAndTop"
    $headers = @{ ConsistencyLevel = 'eventual' }

    $successCount = 0
    $failureCount = 0

    $ausData = PageableFetchFromGraph -uri $uri -headers $headers -kindLabel "administrative unit"
    if ($ausData -eq $null) {
        Write-Host "Phase 2 terminated due to fetch failure." -ForegroundColor Red
        return $null
    }
    $dynamicAUs = $ausData[0]

    foreach ($au in $dynamicAUs) {
        if ($au.membershipRuleProcessingState -ceq "Paused") {
            $result = UnpauseAdministrativeUnit -uri $url -auId $au.id
            if ($result) {
                $successCount++
            } else {
                $failureCount++
            }
        } else {
            # Skip administrative units that are not in "Paused" state
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
#Prompt you to confirm if you want to run the unpause non-critical flow.
Write-Host "DO YOU WANT TO UNPAUSE NON-CRITICAL DYNAMIC MEMBERSHIP COLLECTIONS (GROUPS AND/OR ADMINISTRATIVE UNITS)?" -ForegroundColor Yellow
Write-Host "NOTE: If you are running this script as part of a mitigation exercise recommended by Microsoft, we strongly recommend performing this operation for BOTH groups and administrative units with dynamic membership (i.e. answer 'yes' to both phases below)." -ForegroundColor Cyan
Write-Host "NOTE THAT IF YOU UNPAUSE A HIGH NUMBER OF DYNAMIC MEMBERSHIP COLLECTIONS, YOU MIGHT SEE A MASSIVE BACKLOG OF PROCESSING." -ForegroundColor Yellow
Write-Host "IT IS HIGHLY RECOMMENDED THAT YOU MANUALLY UNPAUSE COLLECTIONS ON THE AZURE PORTAL BASED ON THEIR PRIORITY." -ForegroundColor Yellow
Write-Host "YOU CAN ONLY UNPAUSE UP TO 100 GROUPS AND 100 ADMINISTRATIVE UNITS PER RUN OF THIS SCRIPT." -ForegroundColor Yellow
Write-Host "PLEASE MAKE SURE YOU HAVE ALREADY UNPAUSED THE CRITICAL COLLECTIONS. THIS SCRIPT IS RECOMMENDED TO BE USED FOR NON-CRITICAL COLLECTIONS ONLY." -ForegroundColor Yellow
$input = Read-Host "Type 'yes' to confirm: "

#Global variable for JSON change.
$global:unpauseDGjson = '{"membershipRuleProcessingState":"On"}'

# Start the unpause non-critical flow if confirmed.
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
    Write-Host "Include the groups phase (unpause up to 100 non-critical paused groups with dynamic membership)?" -ForegroundColor Yellow
    Write-Host "(Type 'yes' to include, anything else to skip.)" -ForegroundColor Yellow
    $groupsPhaseInput = Read-Host "Type 'yes' to confirm: "
    $runGroupsPhase = $groupsPhaseInput.Trim().ToLower() -eq "yes"

    Write-Host "" -ForegroundColor Yellow
    Write-Host "Include the administrative units phase (unpause up to 100 non-critical paused administrative units with dynamic membership)?" -ForegroundColor Yellow
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
        # Status values: "Skipped" (user declined), "FetchFailed" (LIST call failed), "Completed".
        $groupResult = $null
        $auResult = $null
        $groupPhaseStatus = "Skipped"
        $auPhaseStatus = "Skipped"

        # Phase 1: groups with dynamic membership
        if ($runGroupsPhase) {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "PHASE 1 OF 2: GROUPS WITH DYNAMIC MEMBERSHIP" -ForegroundColor Yellow
            $groupResult = UnpauseNonCriticalDynamicMembershipGroups -graphEndpoint $graphEndpoint
            if ($null -eq $groupResult) { $groupPhaseStatus = "FetchFailed" } else { $groupPhaseStatus = "Completed" }
        } else {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "Phase 1 skipped. No groups with dynamic membership were unpaused." -ForegroundColor Yellow
        }

        # Phase 2: administrative units with dynamic membership
        if ($runAusPhase) {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "PHASE 2 OF 2: ADMINISTRATIVE UNITS WITH DYNAMIC MEMBERSHIP" -ForegroundColor Yellow
            $auResult = UnpauseNonCriticalDynamicMembershipAdministrativeUnits -graphEndpoint $graphEndpoint
            if ($null -eq $auResult) { $auPhaseStatus = "FetchFailed" } else { $auPhaseStatus = "Completed" }
        } else {
            Write-Host "" -ForegroundColor Yellow
            Write-Host "Phase 2 skipped. No administrative units with dynamic membership were unpaused." -ForegroundColor Yellow
        }

        # Combined summary
        Write-Host "" -ForegroundColor Yellow
        Write-Host "UnpauseNonCritical Operation Complete." -ForegroundColor Yellow
        if ($groupPhaseStatus -eq "Completed") {
            Write-Host "Groups with dynamic membership - Successfully Unpaused: $($groupResult.Success), Failed: $($groupResult.Failure)" -ForegroundColor Yellow
        } elseif ($groupPhaseStatus -eq "FetchFailed") {
            Write-Host "Groups with dynamic membership - Phase failed: could not list groups with dynamic membership. See error above." -ForegroundColor Red
        } else {
            Write-Host "Groups with dynamic membership - Phase skipped." -ForegroundColor Yellow
        }
        if ($auPhaseStatus -eq "Completed") {
            Write-Host "Administrative units with dynamic membership - Successfully Unpaused: $($auResult.Success), Failed: $($auResult.Failure)" -ForegroundColor Yellow
        } elseif ($auPhaseStatus -eq "FetchFailed") {
            Write-Host "Administrative units with dynamic membership - Phase failed: could not list administrative units with dynamic membership. See error above." -ForegroundColor Red
        } else {
            Write-Host "Administrative units with dynamic membership - Phase skipped." -ForegroundColor Yellow
        }
    } catch {
        # Handle any errors during the process
        $errorMessage = $_.Exception.Message
        Write-Host "UnpauseNonCritical operation failed. Error message: $($errorMessage)" -ForegroundColor Red
    }
# Inform you that the input was not accepted.
} else {
    Write-Host "UnpauseNonCritical script terminated. Please re-run the script and input 'yes' to run the UnpauseNonCritical script." -ForegroundColor Red
}
```

## Next steps

- [Understand and manage dynamic group processing in Microsoft Entra ID](../manage-dynamic-group.md)
- [Dynamic membership rules for groups](../groups-dynamic-membership.md)
- [Administrative units in Microsoft Entra ID](../../role-based-access-control/administrative-units.md)
- [Resume specific critical groups and administrative units with dynamic membership](powershell-resume-specific-critical-dynamic-membership.md)
- [Microsoft Graph PowerShell module installation](/powershell/microsoftgraph/installation)
