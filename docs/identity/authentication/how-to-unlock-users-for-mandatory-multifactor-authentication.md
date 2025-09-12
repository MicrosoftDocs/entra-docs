---
title: How to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory multifactor authentication (MFA) requirement for the Azure portal, Microsoft Entra admin center, or Microsoft Intune admin center
description: A script to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory MFA requirement for the Azure portal, Microsoft Entra admin center, or Microsoft Intune admin center
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 04/19/2025
ms.author: justinha
author: najshahid
manager: dougeby
ms.reviewer: nashahid

# Customer intent: As an identity administrator, I want to unlock users who are locked out by mandatory MFA.
---
# How to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory MFA requirement

Users might not be able to sign into the Azure portal, Microsoft Entra admin center, or Microsoft Intune admin center if they have trouble using their MFA method after the mandatory requirement to use MFA is rolled out to their tenant. 
 
If users are unable to sign in, you can run the following script as a Global Administrator to temporarily postpone the MFA enforcement for your tenant. 

For more information about Azure's mandatory MFA requirements, see [Planning for mandatory multifactor authentication for Azure and other admin portals](concept-mandatory-multifactor-authentication.md). The following script applies only to applications in Phase 1. 

## Script actions

The script takes the following actions:

- Picks the user's tenant if they have one, or presents a list of tenants for them to choose from. Optionally, the script asks for the date of enforcement. The default date is September 30, 2025.
- Logs the user into that tenant.
- Gets the relevant authentication tokens.
- Checks if user has elevated access. If not, the script does the elevation.
- Checks if the appropriate role is assigned for the user on the settings resource provider (RP). If not, the script assigns the appropriate role.
- Updates the enforcement date in Entra ID.
- Tries to remove elevated access if the script added it.

## Prerequisites

- [Az PowerShell module](/powershell/azure/what-is-azure-powershell)
- [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator)

## Script

```powershell
param (
    [Parameter(Mandatory=$false)]
    [string]$TenantId,

    [Parameter(Mandatory=$false)]
    [string]$PostponementDateInUTC
)

# Make sure the Az.Accounts module is imported
Import-Module Az.Accounts

function Set-TenantSettingsMFAPostponement {

    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

    $cutoffDate = [datetime]::Parse("2025-10-01T00:00:00Z")
    $isDefaultDate = $false
    if ($PostponementDateInUTC) {
        # ISO 8601 check (basic): YYYY-MM-DDTHH:mm:ssZ
        if ($PostponementDateInUTC -notmatch '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$') {
            Write-Host "Invalid PostponementDateInUTC format. Must be in ISO 8601 format like '2025-09-30T23:59:59Z'." -ForegroundColor Red
            return
        }
        $valid = $false
        $today = [DateTime]::UtcNow.Date
        $minDate = $today.AddDays(1)
        $maxDate = [DateTime]::ParseExact("2025-09-30T23:59:59Z", "yyyy-MM-ddTHH:mm:ssZ", $null).ToUniversalTime()
        $valid = Check-Date-Is-Valid -maxDate $maxDate -minDate $minDate -dateToCheck $PostponementDateInUTC
        if (-not $valid) {
            return
        }
    } else {
        $PostponementDateInUTC = "2025-09-30T23:59:59Z"
        $isDefaultDate = $true
    }

    # If user didn't specify a tenant in params, let them select.
    if (-not $TenantId) {
        try {
            # Have user log into relevant account
            $connected = Connect-AzAccount -ErrorAction Stop
            # Get all tenants the user has access to
            $tenants = Get-AzTenant -ErrorAction Stop
        } catch {
            Write-Host "Failed to connect and/or fetch list of user's tenants. Error: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host
            return
        }

        if (-not $tenants) {
            Write-Host "No tenants found for this user." -ForegroundColor Red
            return
        }

        # Display them as a numbered list
        Write-Host "Please select a tenant from the list below"
        Write-Host " "
        for ($i = 0; $i -lt $tenants.Count; $i++) {
            Write-Host "$($i + 1)) $($tenants[$i].TenantId) - $($tenants[$i].Name) ($($tenants[$i].DefaultDomain))"
        }
        Write-Host

        # Ask user to select one
        $selection = Read-Host "Enter the number for the tenant you want to use"

        # Validate and extract selected tenant
        if ($selection -match '^\d+$') {
            $selection = [int]$selection
            if ($selection -ge 1 -and $selection -le $tenants.Count) {
                $chosenTenant = $tenants[$selection - 1]
                Write-Host "You selected tenant: $($chosenTenant.TenantId) - $($chosenTenant.Name) ($($chosenTenant.DefaultDomain))" -ForegroundColor Green
                Write-Host
                # Use $chosenTenant.TenantId later in the script
                $TenantId = $chosenTenant.TenantId
            } else {
                Write-Host "Number is out of range. Exiting..." -ForegroundColor Red
                return
            }
        } else {
            Write-Host "Invalid selection. Exiting..." -ForegroundColor Red
            return
        }
    }

    if ($isDefaultDate) {
        $newDate = Select-Postponement-Date
        if (-not $newDate) {
            return
        } else {
            $PostponementDateInUTC = $newDate.ToString("yyyy-MM-ddTHH:mm:ssZ")
            $isDefaultDate = $false
        }
    }

    if ($isDefaultDate) {
        Write-Host "This will update the MFA enforcement date for TenantId: '$($TenantId)' to the DEFAULT date of '$($PostponementDateInUTC)'"
    } else {
        Write-Host "This will update the MFA enforcement date for TenantId: '$($TenantId)' to the date of '$($PostponementDateInUTC)'"
    }
    
    Write-Host
    $confirmation = Read-Host "Do you want to continue (Y/N)?"
    if ($confirmation -match '^[Yy]$') {
        Write-Host "Proceeding..." -ForegroundColor Green
        Write-Host
    } else {
        Write-Host "Operation canceled by user." -ForegroundColor Red
        return
    }

    try {
        $connected = Connect-AzAccount -TenantId $TenantId
    } catch {
        Write-Host "Failed to log the user in to specified tenant. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
        return
    }
    Start-Sleep -Seconds 3

    # Constants
    $ELEVATED_TENANT_ADMIN_ROLE_ID = "/providers/Microsoft.Authorization/roleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9"
    $OWNER_ROLE_ID = "/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635"

    # Get tokens
    Write-Host "Fetching necessary authorization tokens..."
    try {
        $armToken = (Get-AzAccessToken -ResourceUrl "https://management.azure.com/").Token
        if ($null -eq $armToken) {
            Write-Host "Failed to fetch an authorization token for Azure Resource Manager. Make sure you run: Connect-AzAccount -TenantId '<your tenant id>'" -ForegroundColor Red
            return
        }
            
        Start-Sleep -Seconds 3
    } catch {
        Write-Host "Failed to fetch Azure Resource Manager token. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
        return
    }

    try {
        $coreToken = (Get-AzAccessToken -ResourceUrl "https://management.core.windows.net/").Token
        if ($null -eq $coreToken) {
            Write-Host "Failed to fetch an authorization token for Azure Resource Manager core. Make sure you run: Connect-AzAccount -TenantId '<your tenant id>'" -ForegroundColor Red
            return
        }
            
        Start-Sleep -Seconds 3
    } catch {
        Write-Host "Failed to fetch Azure Resource Manager token. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
        return
    }
    
    $armClaims = Decode-JwtPayload -Jwt $armToken
    $objectId = $armClaims.oid
    if ($null -eq $objectId) {
        Write-Host "Failed to parse objectId from oid claim in Azure Resource Manager token. Make sure you are an admin of this tenant." -ForegroundColor Red
        return
    }
    
    Write-Host "Successfully fetched authorization tokens." -ForegroundColor Green
    Write-Host

    # Check elevated access
    try {
        $roleCheckUri = "https://management.azure.com/providers/Microsoft.PortalServices/providers/Microsoft.Authorization/roleAssignments?api-version=2022-04-01&`$filter=principalId eq '$($objectId)'"
        $roleAssignments = Invoke-RestMethod -Headers @{Authorization = "Bearer $armToken"} -Uri $roleCheckUri -Method GET
            
        Start-Sleep -Seconds 3
    } catch {
        Write-Host "Failed to check user's elevated access. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
        return
    }

    Write-Host "Checking for elevated access..."
    $hasElevatedAccess = $false
    foreach ($item in $roleAssignments.value) {
        if ($item.properties.roleDefinitionId -eq $ELEVATED_TENANT_ADMIN_ROLE_ID) {
            $hasElevatedAccess = $true
        }
    }

    # Used to determine whether or not to delete elevated access at end
    $alreadyHadElevatedStatus = $hasElevatedAccess
    
    if (-not $hasElevatedAccess) {
        Write-Host "User does NOT have elevated access. Elevating access..."
        $elevateUri = "https://management.azure.com/providers/Microsoft.Authorization/elevateAccess?api-version=2017-05-01"

        try {
            # Attempt the API call and capture the response
            $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $coreToken"} -Uri $elevateUri -Method POST -ErrorAction Stop

            # Even if there's no content in the response, the request could still have succeeded
            Write-Host "Successfully elevated access." -ForegroundColor Green
            Write-Host
            
            Start-Sleep -Seconds 3
        } catch {
            Write-Host "Failed to elevate access. Error: $($_.Exception.Message)"
            Write-Host "Make sure you are already a tenant admin"
            return
        }
    } else {
        Write-Host "User already has elevated access." -ForegroundColor Green
        Write-Host
    }

    try {
        # Re-check role assignments after possible elevation
        $roleAssignments = Invoke-RestMethod -Headers @{Authorization = "Bearer $armToken"} -Uri $roleCheckUri -Method GET
            
        Start-Sleep -Seconds 3
    } catch {
        Write-Host "Failed to re-check user's elevated access. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host

        # Clean up elevated access if we added it
        if (-not $alreadyHadElevatedStatus) {
            Remove-ElevatedAccess -objectId $objectId -TenantId $TenantId
        }
        return
    }

    Write-Host "Checking if owner role exists..."
    $hasOwnerRole = $false
    foreach ($item in $roleAssignments.value) {
        if ($item.properties.roleDefinitionId -eq $OWNER_ROLE_ID) {
            $hasOwnerRole = $true
        }
    }

    try {
        if (-not $hasOwnerRole) {
            Write-Host "Owner role does NOT exist. Assigning Owner Role..."
            
            # register provider
            $regProviderUri = "https://management.azure.com/providers/Microsoft.PortalServices/register?api-version=2024-03-01"
            try { 
                $providerRegistered = Invoke-RestMethod -Headers @{Authorization = "Bearer $armToken"} -Uri $regProviderUri -Method POST
                
                Start-Sleep -Seconds 3
            } catch {
                Write-Host "Failed to register PortalServices provider. Error: $($_.Exception.Message)" -ForegroundColor Red
                Write-Host
                throw "Provider registration failed"
            }

            # assign owner role
            $assignmentId = [guid]::NewGuid()
            $assignUri = "https://management.azure.com/providers/Microsoft.PortalServices/providers/Microsoft.Authorization/roleAssignments/$($assignmentId)?api-version=2020-04-01-preview"
            $assignBody = @{
                properties = @{
                    roleDefinitionId = $OWNER_ROLE_ID
                    principalId = $objectId
                    principalType = "User"
                    scope = "/providers/Microsoft.PortalServices"
                }
            } | ConvertTo-Json -Depth 5
            try {
                Invoke-RestMethod -Headers @{Authorization = "Bearer $armToken"; "Content-Type" = "application/json"} `
                    -Uri $assignUri -Method PUT -Body $assignBody
                Start-Sleep -Seconds 3
                Write-Host "Successfully assigned owner role." -ForegroundColor Green
            } catch {
                Write-Host "Failed to assign owner role. Error: $($_.Exception.Message)" -ForegroundColor Red
                Write-Host
                throw "Owner role assignment failed"
            }
        } else {
            Write-Host "Owner role already exists."
            Write-Host
        }

        # Update Tenant Settings
        Write-Host "Trying to postpone MFA enforcement..."
        $settingsUri = "https://management.azure.com/providers/Microsoft.PortalServices/settings/default?api-version=2024-09-01-preview"
        $settingsBody = @{
            properties = @{
                multiFactorAuthentication = @{
                    portalEnforcement = "OptOut"
                    portalJustification = "Postponed MFA by user with Powershell script"
                    portalEnforcementDate = $PostponementDateInUTC
                }
            }
        } | ConvertTo-Json -Depth 5

        $successfulUpdate = $false
        try {
            $updateResults = Invoke-WebRequest -Headers @{Authorization = "Bearer $armToken"; "Content-Type" = "application/json"} `
                -Uri $settingsUri -Method PUT -Body $settingsBody
                
            Start-Sleep -Seconds 3
        } catch {
            Write-Host "Failed to postpone MFA. Error: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host
            throw "MFA postponement failed"
        }
        
        if ($updateResults.StatusCode -ge 200 -and $updateResults.StatusCode -lt 300) {
            # Convert content to JSON
            $jsonResponse = $updateResults.Content | ConvertFrom-Json

            # Check if provisioningState is 'Succeeded'
            if ($jsonResponse.properties.provisioningState -eq "Succeeded") {
                Write-Host "Successfully postponed MFA to $($PostponementDateInUTC)." -ForegroundColor Green
                Write-Host
                $successfulUpdate = $true
            } else {
                Write-Host "Provisioning state is not Succeeded. It is $($jsonResponse.properties.provisioningState)." -ForegroundColor Red
                Write-Host
                throw "MFA postponement failed - incorrect provisioning state"
            }
        } else {
            Write-Host "Request failed with status: $($updateResults.StatusCode)" -ForegroundColor Red
            Write-Host
            throw "MFA postponement failed - incorrect status code"
        }

        # Optional verification
        if ($successfulUpdate) {
            Write-Host "Verifying that postponement date was properly stored..."
            try {
                $verify = Invoke-RestMethod -Headers @{Authorization = "Bearer $armToken"} `
                    -Uri $settingsUri -Method GET
                
                Start-Sleep -Seconds 3

                Write-Host "The postponement date of '$($verify.properties.multiFactorAuthentication.portalEnforcementDate)' is set for tenant '$($TenantId)'" -ForegroundColor Green
                Write-Host
            } catch {
                Write-Host "Failed to fetch the stored postponement date. Error: $($_.Exception.Message)" -ForegroundColor Red
                Write-Host
                # Continue despite verification failure as update was successful
            }
        }
    }
    catch {
        Write-Host "An error occurred during the operation: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
    }
    finally {
        # Remove elevated access only if we were the ones that added it in the script.
        if (-not $alreadyHadElevatedStatus) {
            Remove-ElevatedAccess -objectId $objectId -TenantId $TenantId
        }
    }
}

function Remove-ElevatedAccess {
    param (
        [string]$objectId,
        [string]$TenantId
    )

    Write-Host "Removing temporary elevated access..."
    $roleCheckUri = "https://management.azure.com/providers/Microsoft.Authorization/roleAssignments?api-version=2022-04-01&`$filter=principalId+eq+'$($objectId)'"
    try {
        $roleAssignments = Invoke-RestMethod -Headers @{Authorization = "Bearer $armToken"} -Uri $roleCheckUri -Method GET
    } catch {
        Write-Host "Failed to fetch elevated access status. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
        return
    }

    $newAssignmentId = $false
    foreach ($item in $roleAssignments.value) {
        if ($item.properties.roleDefinitionId -eq $ELEVATED_TENANT_ADMIN_ROLE_ID) {
            $newAssignmentId = $($item.name)
        }
    }

    if ($newAssignmentId -eq $false) {
        Write-Host "Could not find the elevated role assignment id. You will need to manually delete your elevated status.2" -ForegroundColor Red
        return
    }

    try {
        $connected = Connect-AzAccount -TenantId $TenantId
    } catch {
        Write-Host "Failed re-connect user. You will need to manually delete your elevated status. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
        return
    }

    Write-Host "Refreshing authorization tokens..."
    Start-Sleep -Seconds 3
    try {
        $coreToken = (Get-AzAccessToken -ResourceUrl "https://management.core.windows.net/").Token
        if ($null -eq $coreToken) {
            Write-Host "Failed to fetch an authorization token for Azure Resource Manager core. You will need to manually delete your elevated status." -ForegroundColor Red
            return
        }
    } catch {
        Write-Host "Failed to refresh authorization tokens. You will need to manually delete your elevated status. Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host
        return
    }

    $retryCount = 0
    $maxRetries = 3

    do {
        $result = Delete-Elevated-Access -roleAssignmentId $newAssignmentId -coreToken $coreToken -retryCount $retryCount
        if ($result -eq $false) {
            $retryCount = $retryCount + 1
        } else {
            return
        }
    } while ($retryCount -lt $maxRetries)

    if ($retryCount -ge $maxRetries) {
        Write-Host "Failed to remove elevated access. You will need to manually delete your elevated status. " -ForegroundColor Red
        Write-Host
        return
    }
}

function Delete-Elevated-Access {
    param (
        [string]$roleAssignmentId,
        [string]$coreToken,
        [int]$retryCount
    )

    try {
        $deleteUri = "https://management.azure.com/providers/Microsoft.Authorization/roleAssignments/" + $roleAssignmentId + "?api-version=2018-07-01"
        # Attempt the API call and capture the response
        $response = Invoke-RestMethod -Headers @{Authorization = "Bearer $coreToken"} -Uri $deleteUri -Method DELETE -ErrorAction Stop

        # Even if there's no content in the response, the request could still have succeeded
        Write-Host "Successfully removed elevated access." -ForegroundColor Green
        Write-Host
        
        Start-Sleep -Seconds 3
        return $true
    } catch {
        Write-Host "(Attempt #$($retryCount)): Failed to remove elevated access. Error: $($_.Exception.Message)" -ForegroundColor Yellow
        Start-Sleep -Seconds 3
        return $false
    }
}

function Decode-JwtPayload {
    param (
        [string]$Jwt
    )

    $parts = $Jwt -split '\.'
    if ($parts.Count -lt 2) {
        throw "Invalid JWT format"
    }

    $payload = $parts[1]

    # Replace URL-safe base64 chars
    $payload = $payload.Replace('-', '+').Replace('_', '/')

    # Add padding if needed
    switch ($payload.Length % 4) {
        2 { $payload += '==' }
        3 { $payload += '=' }
        1 { throw "Invalid base64url string" }
    }

    $json = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($payload))
    return $json | ConvertFrom-Json
}

function Check-Date-Is-Valid {
    param (
        [DateTime]$maxDate,
        [DateTime]$minDate,
        [string]$dateToCheck
    )

    $inputDate = $maxDate
    if ([string]::IsNullOrWhiteSpace($dateToCheck)) {
        Write-Host "No input provided. Please enter a date in the required format.`n" -ForegroundColor Red
        return $valid
    }

    $parsed = [DateTime]::TryParse($dateToCheck, [ref]$inputDate)
    if (-not $parsed) {
        Write-Host "Invalid date format. Please try again using format like 2025-09-15T00:00:00Z.`n" -ForegroundColor Red
        return $valid
    }

    $inputDate = $inputDate.ToUniversalTime()
    if ($inputDate -ge $minDate -and $inputDate -le $maxDate) {
        return $inputDate
    } else {
        Write-Host "Date must be between $($minDate.ToString("u")) and $($maxDate.ToString("u")) (UTC). Try again.`n" -ForegroundColor Red
    }

    return $valid
}

function Select-Postponement-Date {
    $valid = $false
    $today = [DateTime]::UtcNow.Date
    $minDate = $today.AddDays(1)
    $maxDate = [DateTime]::ParseExact("2025-09-30T23:59:59Z", "yyyy-MM-ddTHH:mm:ssZ", $null).ToUniversalTime()

    $inputDate = $maxDate
    while (-not $valid) {
        $inputDateStr = Read-Host "Enter a UTC date up to 2025-09-30T23:59:59Z (e.g., 2025-09-15T00:00:00Z) or Enter to use the default" 
        $defaultChosen = $false
        if([string]::IsNullOrWhiteSpace($inputDateStr)) {
            $inputDateStr = "2025-09-30T23:59:59Z"
            $defaultChosen = $true
        }
        
        $inputDate = Check-Date-Is-Valid -maxDate $maxDate -minDate $minDate -dateToCheck $inputDateStr

        if (-not $inputDate) {
            $valid = $false
        } else {
            $valid = $true
            if ($defaultChosen) {
                Write-Host "You chose the enforcement date: $($inputDateStr)" -ForegroundColor Green
            } else {
                Write-Host "You entered the enforcement date: $($inputDateStr)" -ForegroundColor Green
            }
            Write-Host
        }
    }

    return $inputDate
}

# Call the function
Set-TenantSettingsMFAPostponement -TenantId $TenantId -PostponementDateInUTC $PostponementDateInUTC
```

## Related content

- [Planning for mandatory MFA for Azure and other admin portals](concept-mandatory-multifactor-authentication.md)
- [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md)
