---
title: PowerShell examples for group-based licensing
description: Learn how to manage group-based licensing in Microsoft Entra ID using Microsoft PowerShell. Includes examples for assigning licenses and troubleshooting errors.
#customer intent: As an IT admin, I want to access PowerShell examples for common group-based licensing tasks so that I can simplify license magement in my organization.
keywords: Entra ID licensing
author: barclayn
manager: femila
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 03/19/2025
ms.author: barclayn
---

# Group-based licensing PowerShell examples

Group-based licensing in Microsoft Entra ID, part of Microsoft Entra, is available through the [Azure portal](https://portal.azure.com). There are useful tasks that can be performed using [Microsoft Graph PowerShell Cmdlets](/powershell/microsoftgraph/get-started). 

In this article, we go over some examples using Microsoft Graph PowerShell.

> [!WARNING]
> These samples are provided for demonstration purposes only. We recommend testing them on a smaller scale or in a separate test environment before relying on them in your production environment. You can modify the samples to meet your specific environment's requirements.

Before you begin running cmdlets, make sure you connect to your organization first, by running the `Connect-MgGraph` cmdlet-.

## Assign licenses to a group

[Group based licensing](~/fundamentals/concept-group-based-licensing.md) provides a convenient way to manage license assignment. You can assign one or more product licenses to a group and those licenses are assigned to all members of the group.

```powershell
# Import the Microsoft.Graph.Groups module
Import-Module Microsoft.Graph.Groups
# Define the group ID - replace with your actual group ID
$groupId = "11111111-1111-1111-1111-111111111111"

# Create a hashtable to store the parameters for the Set-MgGroupLicense cmdlet
$params = @{
    AddLicenses = @(
        @{
            # Remove the DisabledPlans key as we don't need to disable any service plans
            # Specify the SkuId of the license you want to assign
                        SkuId = "11111111-1111-1111-1111-111111111111"       }
    )
    # Keep the RemoveLicenses key empty as we don't need to remove any licenses
    RemoveLicenses = @(
    )
}

# Call the Set-MgGroupLicense cmdlet to update the licenses for the specified group
# Replace $groupId with the actual group ID
Set-MgGroupLicense -GroupId $groupId -BodyParameter $params

```

## View product licenses assigned to a group


```powershell
The [Get-MgGroup](/powershell/module/microsoft.graph.groups/get-mggroup) cmdlet can be used to retrieve the group object and check the *AssignedLicenses* property: it lists all product licenses currently assigned to the group.

```powershell
# Define the group ID
$groupId = "99c4216a-56de-42c4-a4ac-e411cd8c7c41"

# Get the group with the specified ID and its assigned licenses
$group = Get-MgGroup -GroupId $groupId -Property "AssignedLicenses"

# Extract the assigned licenses
$assignedLicenses = $group | Select-Object -ExpandProperty AssignedLicenses

# Extract the SKU IDs from the assigned licenses
$skuIds = $assignedLicenses | Select-Object -ExpandProperty SkuId

# For each SKU ID, get the corresponding SKU part number
$skuPartNumbers = $skuIds | ForEach-Object {
    $skuId = $_
    $subscribedSku = Get-MgSubscribedSku | Where-Object { $_.SkuId -eq $skuId }
    $skuPartNumber = $subscribedSku | Select-Object -ExpandProperty SkuPartNumber
    $skuPartNumber
}

# Output the SKU part numbers
$skuPartNumbers
```

This output is what the results look like:

```output
SkuPartNumber
-------------
ENTERPRISEPREMIUM
EMSPREMIUM
```

## Get all groups with assigned licenses

You can find all groups with any license assigned by running the following command:

```powershell
Get-MgGroup -All -Property Id, MailNickname, DisplayName, GroupTypes, Description, AssignedLicenses | Where-Object {$_.AssignedLicenses -ne $null }
```

More details can be displayed about what products are assigned:

```powershell
# Get all groups with assigned licenses
$groups = Get-MgGroup -All -Property Id, MailNickname, DisplayName, GroupTypes, Description, AssignedLicenses | Where-Object {$_.AssignedLicenses -ne $null }

# Process each group
$groupInfo = foreach ($group in $groups) {
    # For each group, get the SKU part numbers of the assigned licenses
    $skuPartNumbers = foreach ($skuId in $group.AssignedLicenses.SkuId) {
        $subscribedSku = Get-MgSubscribedSku | Where-Object { $_.SkuId -eq $skuId }
        $subscribedSku.SkuPartNumber
    }

    # Create a custom object with the group's object ID, display name, and license SKU part numbers
    [PSCustomObject]@{
        ObjectId = $group.Id
        DisplayName = $group.DisplayName
        Licenses = $skuPartNumbers -join ', '
    }
}

$groupInfo
```

This output is what the results look like:

```output
Id                                   DisplayName              AssignedLicenses
--                                   -----------              ----------------
7023a314-6148-4d7b-b33f-6c775572879a EMS E5 – Licensed users  EMSPREMIUM
cf41f428-3b45-490b-b69f-a349c8a4c38e PowerBi - Licensed users POWER_BI_STANDARD
962f7189-59d9-4a29-983f-556ae56f19a5 O365 E3 - Licensed users ENTERPRISEPACK
c2652d63-9161-439b-b74e-fcd8228a7074 EMSandOffice             {ENTERPRISEPREMIUM,EMSPREMIUM}
```

## View all disabled service plan licenses assigned to groups

```powershell
$groups = Get-MgGroup -All
$groupsWithLicenses = @()

foreach ($group in $groups) {
$licenses = Get-MgGroup -GroupId $group.Id -Property "AssignedLicenses, Id, DisplayName" |
Select-Object AssignedLicenses, DisplayName, Id

if ($licenses.AssignedLicenses) {
    foreach ($license in $licenses.AssignedLicenses) {
        $skuId = $license.SkuId
        $disabledPlans = $license.DisabledPlans

        $skuDetails = Get-MgSubscribedSku | Where-Object { $_.SkuId -eq $skuId }
        $skuPartNumber = $skuDetails.SkuPartNumber

        $disabledPlanDetails = @()
        if ($disabledPlans.Count -gt 0) {
            foreach ($planId in $disabledPlans) {
                $planDetails = $skuDetails.ServicePlans | Where-Object { $_.ServicePlanId -eq $planId }
                
                if ($planDetails) {
                    $disabledPlanDetails += "$($planDetails.ServicePlanName) ($planId)"
                }
            }
        } else {
            $disabledPlanDetails = "None"
        }

        $groupsWithLicenses += [PSCustomObject]@{
            GroupObjectId  = $group.Id
            GroupName      = $group.DisplayName
            SkuId          = $skuId
            SkuPartNumber  = $skuPartNumber
            DisabledPlans  = ($disabledPlanDetails -join ", ")
        }
    }
}
}

Export to CSV
$csvPath = "$env:USERPROFILE\Documents\GroupLicenses.csv"
$groupsWithLicenses | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "Export completed: $csvPath"
```

## Get statistics for groups with licenses

```powershell
# Import User Graph Module
Import-Module Microsoft.Graph.Users
# Authenticate to MS Graph
Connect-MgGraph -Scopes "User.Read.All", "Directory.Read.All", "Group.ReadWrite.All"
#get all groups with licenses
$groups = Get-MgGroup -All -Property LicenseProcessingState, DisplayName, Id, AssignedLicenses | Select-Object  displayname, Id, LicenseProcessingState, AssignedLicenses | Select-Object DisplayName, Id, AssignedLicenses -ExpandProperty LicenseProcessingState | Select-Object DisplayName, State, Id, AssignedLicenses | Where-Object {$_.State -eq "ProcessingComplete"}
$groupInfoArray = @()
# Filter the groups to only include those that have licenses assigned
$groups = $groups | Where-Object {$_.AssignedLicenses -ne $null}
# For each group, get the group name, license types, total user count, licensed user count, and license error count
foreach ($group in $groups) {
    $groupInfo = New-Object PSObject
    $groupInfo | Add-Member -MemberType NoteProperty -Name "Group Name" -Value $group.DisplayName
    $groupInfo | Add-Member -MemberType NoteProperty -Name "Group ID" -Value $group.Id
    $groupInfo | Add-Member -MemberType NoteProperty -Name "License Types" -Value ($group.AssignedLicenses | Select-Object -ExpandProperty SkuId)
    $groupInfo | Add-Member -MemberType NoteProperty -Name "Total User Count" -Value (Get-MgGroupMember -GroupId $group.Id -All | Measure-Object).Count
    $groupInfo | Add-Member -MemberType NoteProperty -Name "Licensed User Count" -Value (Get-MgGroupMember -GroupId $group.Id -All | Where-Object {$_.      LicenseProcessingState -eq "ProcessingComplete"} | Measure-Object).Count
    $groupInfo | Add-Member -MemberType NoteProperty -Name "License Error Count" -Value (Get-MgGroupMember -GroupId $group.Id -All | Where-Object {$_.LicenseProcessingState -eq "ProcessingFailed"} | Measure-Object).Count
    $groupInfoArray += $groupInfo
}

# Format the output and print it to the console
$groupInfoArray | Format-Table -AutoSize

```


## Get all groups with license errors

```powershell
# Get all groups that have assigned licenses
$groups = Get-MgGroup -All -Property DisplayName, Id, AssignedLicenses | 
    Where-Object { $_.AssignedLicenses -ne $null } | 
    Select-Object DisplayName, Id, AssignedLicenses

# Initialize an array to store group information
$groupInfo = @()

# Iterate over each group
foreach ($group in $groups) {
    $groupId = $group.Id
    $groupName = $group.DisplayName

    # Initialize counters for total members and members with license errors
    $totalCount = 0
    $licenseErrorCount = 0

    # Get all members of the group that have license errors
    $members = Get-MgGroupMemberWithLicenseError -GroupId $groupId

    # Process each member
    foreach ($member in $members) {
        $totalCount++

        # If the member has a license error (indicated by a non-empty Id), increment the error count
        if (![string]::IsNullOrEmpty($member.Id)) {
            $licenseErrorCount++
        }
    }

    # Create a custom object with the group's information and counts
    $groupInfo += [PSCustomObject]@{
        GroupName         = $groupName
        GroupId           = $groupId
        TotalUserCount    = $totalCount
        LicenseErrorCount = $licenseErrorCount
    }
}

# Display the groups with licensing errors
$groupInfo | Where-Object { $_.LicenseErrorCount -gt 0 } | Format-Table -Property GroupName, GroupId, TotalUserCount, LicenseErrorCount
```

## Get all users with license errors in a group

Given a group that contains some license-related errors, you can now list all users affected by those errors. A user can have errors from other groups, too. However, in this example we limit results only to errors relevant to the group in question by checking the **ReferencedObjectId** property of each **IndirectLicenseError** entry on the user.

```powershell
# Import necessary modules
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

# Specify the group ID you want to check
$groupId = "ENTER-YOUR-GROUP-ID-HERE"

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes "Group.Read.All", "User.Read.All"

# Get the specified group
$group = Get-MgGroup -GroupId $groupId -Property DisplayName, Id, AssignedLicenses
Write-Host "Checking license errors for group: $($group.DisplayName)" -ForegroundColor Cyan

# Initialize output array
$groupInfoArray = @()

# Get all members from the group and check their license status
$groupMembers = Get-MgGroupMember -GroupId $group.Id -All
$errorCount = 0

# Process each member
foreach ($memberId in $groupMembers.Id) {
    # Get user details
    $user = Get-MgUser -UserId $memberId -Property DisplayName, Id, LicenseAssignmentStates
    
    # Check for license errors
    $licenseErrors = $user.LicenseAssignmentStates | Where-Object { 
        $_.AssignedByGroup -eq $groupId -and $_.Error -ne "None" 
    }
    
    if ($licenseErrors) {
        $errorCount++
        $userInfo = [PSCustomObject]@{
            GroupName = $group.DisplayName
            GroupId = $group.Id
            UserName = $user.DisplayName
            UserId = $user.Id
            Error = ($licenseErrors.Error -join ", ")
            ErrorSubcode = ($licenseErrors.ErrorSubcode -join ", ")
        }
        $groupInfoArray += $userInfo
    }
}

# Summary
Write-Host "Found $errorCount users with license errors in group $($group.DisplayName)" -ForegroundColor Yellow

# Format the output and print it to the console

if ($groupInfoArray.Length -gt 0) {
    $groupInfoArray | Format-Table -AutoSize
}
else {
    Write-Host "No License Errors"
}

```


## Get all users with license errors in the entire organization

The following script can be used to get all users who have license errors from one or more groups. The script prints one row per user, per license error, which allows you to clearly identify the source of each error.

```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All", "Directory.Read.All", "Organization.Read.All"

# Retrieve all SKUs in the tenant
$skus = Get-MgSubscribedSku -All | Select-Object SkuId, SkuPartNumber

# Retrieve all users in the tenant with required properties
$users = Get-MgUser -All -Property AssignedLicenses, LicenseAssignmentStates, DisplayName, Id, UserPrincipalName

# Initialize an empty array to store the user license information
$allUserLicenses = @()

foreach ($user in $users) {
    # Initialize a hash table to track all assignment methods for each license
    $licenseAssignments = @{}
    $licenseErrors = @()

    # Loop through license assignment states
    foreach ($assignment in $user.LicenseAssignmentStates) {
        $skuId = $assignment.SkuId
        $assignedByGroup = $assignment.AssignedByGroup
        $assignmentMethod = if ($assignedByGroup -ne $null) {
            # If the license was assigned by a group, get the group name
            $group = Get-MgGroup -GroupId $assignedByGroup
            if ($group) { $group.DisplayName } else { "Unknown Group" }
        } else {
            # If the license was assigned directly by the user
            "User"
        }

        # Check for errors in the assignment state and capture them
        if ($assignment.Error -ne $null -or $assignment.ErrorSubcode -ne $null) {
            $errorDetails = @{
                Error         = $assignment.Error
                ErrorSubcode  = $assignment.ErrorSubcode
                SkuId         = $skuId
                AssignedBy    = $assignmentMethod
            }
            $licenseErrors += $errorDetails
        }

        # Ensure all assignment methods are captured
        if (-not $licenseAssignments.ContainsKey($skuId)) {
            $licenseAssignments[$skuId] = @($assignmentMethod)
        } else {
            $licenseAssignments[$skuId] += $assignmentMethod
        }
    }

    # Process assigned licenses
    foreach ($skuId in $licenseAssignments.Keys) {
        # Get SKU details from the pre-fetched list
        $sku = $skus | Where-Object { $_.SkuId -eq $skuId } | Select-Object -First 1
        $skuPartNumber = if ($sku) { $sku.SkuPartNumber } else { "Unknown SKU" }

        # Sort and join the assignment methods
        $assignmentMethods = ($licenseAssignments[$skuId] | Sort-Object -Unique) -join ", "

        # Clean up license errors to make them more legible
        $errorDetails = if ($licenseErrors.Count -gt 0) {
            $errorMessages = $licenseErrors | Where-Object { $_.SkuId -eq $skuId } | ForEach-Object {
                # Check if error or subcode are empty, and filter them out
                if ($_Error -ne "None" -and $_.ErrorSubcode) {
                    "$($_.AssignedBy): Error: $($_.Error) Subcode: $($_.ErrorSubcode)"
                } elseif ($_Error -ne "None") {
                    "$($_.AssignedBy): Error: $($_.Error)"
                } elseif ($_.ErrorSubcode) {
                    "$($_.AssignedBy): Subcode: $($_.ErrorSubcode)"
                }
            }

            # Join filtered error messages into a clean output
            $errorMessages -join "; "
        } else {
            "No Errors"
        }

        # Construct a custom object to store the user's license information
        $userLicenseInfo = [PSCustomObject]@{
            UserId             = $user.Id
            UserDisplayName    = $user.DisplayName
            UserPrincipalName  = $user.UserPrincipalName
            SkuId              = $skuId
            SkuPartNumber      = $skuPartNumber
            AssignedBy         = $assignmentMethods
            LicenseErrors      = $errorDetails
        }

        # Add the user's license information to the array
        $allUserLicenses += $userLicenseInfo
    }
}

# Export the results to a CSV file
$path = Join-path $env:LOCALAPPDATA ("UserLicenseAssignments_" + [string](Get-Date -UFormat %Y%m%d) + ".csv")
$allUserLicenses | Export-Csv $path -Force -NoTypeInformation

# Display the location of the CSV file
Write-Host "CSV file generated at: $((Get-Item $path).FullName)"
```

>[!NOTE]
>This script retrieves a list of all licensed users in your environment, showing which licenses are assigned and the method of assignment. In the results, where "AssignedBy" shows "User", it indicates a direct license assignment. Where "SkuPartNumber" shows "Unknown SKU", it indicates the specific license SKU is disabled in your tenant. The script exports the complete results to a CSV file in your local AppData folder for further analysis.

## Check if user license is assigned directly or inherited from a group

```powershell
# Retrieve all SKUs in the tenant
$skus = Get-MgSubscribedSku -All | Select-Object SkuId, SkuPartNumber
 
# Retrieve all users in the tenant with required properties
$users = Get-MgUser -All -Property AssignedLicenses, LicenseAssignmentStates, DisplayName, Id, UserPrincipalName
 
# Initialize an empty array to store the user license information
$allUserLicenses = @()
 
foreach ($user in $users) {
    # Initialize a hash table to track all assignment methods for each license
    $licenseAssignments = @{}
 
    # Loop through license assignment states
    foreach ($assignment in $user.LicenseAssignmentStates) {
        $skuId = $assignment.SkuId
        $assignedByGroup = $assignment.AssignedByGroup
        $assignmentMethod = if ($assignedByGroup -ne $null) {
            # If the license was assigned by a group, get the group name
            $group = Get-MgGroup -GroupId $assignedByGroup
            if ($group) { $group.DisplayName } else { "Unknown Group" }
        } else {
            # If the license was assigned directly by the user
            "User"
        }
 
        # Ensure all assignment methods are captured
        if (-not $licenseAssignments.ContainsKey($skuId)) {
            $licenseAssignments[$skuId] = @($assignmentMethod)
        } else {
            $licenseAssignments[$skuId] += $assignmentMethod
        }
    }
 
    # Process assigned licenses
    foreach ($skuId in $licenseAssignments.Keys) {
        # Get SKU details from the pre-fetched list
        $sku = $skus | Where-Object { $_.SkuId -eq $skuId } | Select-Object -First 1
        $skuPartNumber = if ($sku) { $sku.SkuPartNumber } else { "Unknown SKU" }
 
        # Sort and join the assignment methods
        $assignmentMethods = ($licenseAssignments[$skuId] | Sort-Object -Unique) -join ", "
 
        # Construct a custom object to store the user's license information
        $userLicenseInfo = [PSCustomObject]@{
            UserId = $user.Id
            UserDisplayName = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
            SkuId = $skuId
            SkuPartNumber = $skuPartNumber
            AssignedBy = $assignmentMethods
        }
 
        # Add the user's license information to the array
        $allUserLicenses += $userLicenseInfo
    }
}
 
# Export the results to a CSV file
$path = Join-path $env:LOCALAPPDATA ("UserLicenseAssignments_" + [string](Get-Date -UFormat %Y%m%d) + ".csv")
$allUserLicenses | Export-Csv $path -Force -NoTypeInformation
 
# Display the location of the CSV file
Write-Host "CSV file generated at: $((Get-Item $path).FullName)"
```


## Remove direct licenses for users with group licenses

The purpose of this script is to remove unnecessary direct licenses from users who already inherit the same license from a group; for example, as part of a [transition to group-based licensing](licensing-groups-migrate-users.md).

> [!NOTE]
>To ensure that users don't lose access to services and data, it's important to confirm that directly assigned licenses don't provide more service functionality than the inherited licenses. It isn't currently possible to use PowerShell to determine which services are enabled through inherited licenses versus direct licenses. Therefore, the script uses a minimum level of services that are known to be inherited from groups to check and ensure that users don't experience unexpected service loss.

### Variables

- *$GroupLicenses:* Represents the licenses assigned to the group.
- *$GroupMembers:* Contains the members of the group.
- *$UserLicenses:* Holds the licenses directly assigned to a user.
- *$DirectLicensesToRemove:* Stores the licenses that need to be removed from the user.

```powershell
# Define the group ID containing the assigned license
$GroupId = "objectID of Group"

# Force all errors to be terminating errors
$ErrorActionPreference = "Stop"

# Get the group's assigned licenses
$Group = Get-MgGroup -GroupId $GroupId -Property AssignedLicenses
$GroupLicenses = $Group.AssignedLicenses.SkuId

if (-not $GroupLicenses) {
    Write-Host "No licenses assigned to the specified group. Exiting script."
    return
}

# Get all members of the group
$GroupMembers = Get-MgGroupMember -GroupId $GroupId -All

foreach ($User in $GroupMembers) {
    $UserId = $User.Id

    # Get user's assigned licenses
    $UserData = Get-MgUser -UserId $UserId -Property DisplayName,Mail,UserPrincipalName,AssignedLicenses
    $UserLicenses = $UserData.AssignedLicenses.SkuId

    # Identify direct licenses that match the group's assigned licenses
    $DirectLicensesToRemove = @()
    foreach ($License in $UserLicenses) {
        if ($GroupLicenses -contains $License) {
            $DirectLicensesToRemove += $License
        }
    }

    # Print user info before taking action
    Write-Host ("{0,-40} {1,-25} {2,-40} {3}" -f $UserData.Id, $UserData.DisplayName, $UserData.Mail, $UserData.UserPrincipalName)

    # Skip users who have no direct licenses matching the group
    if ($DirectLicensesToRemove.Count -eq 0) {
        Write-Host "No direct licenses to remove. (Only inherited licenses detected)"
        Write-Host "------------------------------------------------------"
        continue
    }

    # Attempt to remove direct licenses
    try {
        Write-Host "Removing direct license(s)..."
        Set-MgUserLicense -UserId $UserId -RemoveLicenses $DirectLicensesToRemove -AddLicenses @() -ErrorAction Stop
        Write-Host "✅ License(s) removed successfully."
    }
    catch {
        $ErrorMessage = $_.Exception.Message

        if ($ErrorMessage -match "User license is inherited from a group membership") {
            Write-Host "⚠️ Skipping removal - License is inherited from a group."
        } else {
            Write-Host "❌ Unexpected error: $ErrorMessage"
        }
    }
    Write-Host "------------------------------------------------------"
}

Write-Host "Script execution complete."

```

## Next steps

To learn more about the feature set for license management through groups, see the following articles:

* [What is group-based licensing in Microsoft Entra ID?](~/fundamentals/concept-group-based-licensing.md)
* [Assigning licenses to a group in Microsoft Entra ID](./licensing-groups-assign.md)
* [Identifying and resolving license problems for a group in Microsoft Entra ID](licensing-groups-resolve-problems.md)
