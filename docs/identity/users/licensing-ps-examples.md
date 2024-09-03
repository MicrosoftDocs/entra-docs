---

title: PowerShell and Microsoft Graph examples for group licensing
description: PowerShell + Graph examples and scenarios for Microsoft Entra group-based licensing

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.date: 12/02/2020
ms.author: barclayn
ms.reviewer: sumitp
---

# PowerShell and Microsoft Graph examples for group-based licensing in Microsoft Entra ID

Full functionality for group-based licensing in Microsoft Entra ID, part of Microsoft Entra, is available through the [Azure portal](https://portal.azure.com), and currently there are some useful tasks that can be performed using the existing Microsoft Graph and [Microsoft Graph PowerShell](/powershell/microsoftgraph/). This document provides examples of what is possible.

> [!NOTE]
> Before you begin running cmdlets, make sure you connect to your organization first, by running the [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) cmdlet.

> [!WARNING]
> This code is provided as an example for demonstration purposes. If you intend to use it in your environment, consider testing it first on a small scale, or in a separate test organization. You may have to adjust the code to meet the specific needs of your environment.

## Assign licenses to a group

Use the following sample to assign licenses to a group by using Microsoft Graph:

```
POST https://graph.microsoft.com/v1.0/groups/1ad75eeb-7e5a-4367-a493-9214d90d54d0/assignLicense
Content-type: application/json
{
  "addLicenses": [
    {
      "disabledPlans": [ "11b0131d-43c8-4bbb-b2c8-e80f9a50834a" ],
      "skuId": "c7df2760-2c81-4ef7-b578-5b5392b571df"
    },
    {
      "disabledPlans": [ "a571ebcc-fqe0-4ca2-8c8c-7a284fd6c235" ],
      "skuId": "sb05e124f-c7cc-45a0-a6aa-8cf78c946968"
    }
  ],
  "removeLicenses": []
}

```
Output:
```
HTTP/1.1 202 Accepted
Content-type: application/json
location: https://graph.microsoft.com/v2/d056d009-17b3-4106-8173-cd3978ada898/directoryObjects/1ad75eeb-7e5a-4367-a493-9214d90d54d0/Microsoft.DirectoryServices.Group

{
  "id": "1ad75eeb-7e5a-4367-a493-9214d90d54d0",
  "deletedDateTime": null,
  "classification": null,
  "createdDateTime": "2018-04-18T22:05:03Z",
  "securityEnabled": true,

}
```

## View product licenses assigned to a group

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

This is the result:

```output
SkuPartNumber
-------------
ENTERPRISEPREMIUM
EMSPREMIUM
```

> [!NOTE]
> The data retuned here is limited to product (SKU) information. To generate a list of disabled service plans in the license, see [Microsoft Graph PowerShell examples for group licensing](licensing-powershell-graph-examples.md#view-all-disabled-service-plan-licenses-assigned-to-a-group).


Use the following sample to get the same data from Microsoft Graph.

```
GET https://graph.microsoft.com/v1.0/groups/99c4216a-56de-42c4-a4ac-e411cd8c7c41?$select=assignedLicenses
```
Output:
```
HTTP/1.1 200 OK
{
  "value": [
{
  "assignedLicenses": [
     {
          "accountId":"aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
          "skuId":"c7df2760-2c81-4ef7-b578-5b5392b571df",
      "disabledPlans":[]
     },
     {
          "accountId":"aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
          "skuId":" b05e124f-c7cc-45a0-a6aa-8cf78c946968",
      "disabledPlans":[]
     },
  ],
}
  ]
}
```

## Get all groups with licenses

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

This is the result:

```output
Id                                   DisplayName              AssignedLicenses
--                                   -----------              ----------------
7023a314-6148-4d7b-b33f-6c775572879a EMS E5 – Licensed users  EMSPREMIUM
cf41f428-3b45-490b-b69f-a349c8a4c38e PowerBi - Licensed users POWER_BI_STANDARD
962f7189-59d9-4a29-983f-556ae56f19a5 O365 E3 - Licensed users ENTERPRISEPACK
c2652d63-9161-439b-b74e-fcd8228a7074 EMSandOffice             {ENTERPRISEPREMIUM,EMSPREMIUM}
```

## Get statistics for groups with licenses
You can report basic statistics for groups with licenses. In the example below, the script lists the total user count, the count of users with licenses already assigned by the group, and the count of users for whom licenses could not be assigned by the group.

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

The result is the following table:

```output
GroupName         GroupId                              GroupLicenses       TotalUserCount LicensedUserCount LicenseErrorCount
---------         -------                              -------------       -------------- ----------------- -----------------
Dynamics Licen... 9160c903-9f91-4597-8f79-22b6c47eafbf AAD_PREMIUM_P2                   0                 0                 0
O365 E5 - base... 055dcca3-fb75-4398-a1b8-f8c6f4c24e65 ENTERPRISEPREMIUM                2                 2                 0
O365 E5 - extr... 6b14a1fe-c3a9-4786-9ee4-3a2bb54dcb8e ENTERPRISEPREMIUM                3                 3                 0
EMS E5 - all s... 7023a314-6148-4d7b-b33f-6c775572879a EMSPREMIUM                       2                 2                 0
PowerBi - Lice... cf41f428-3b45-490b-b69f-a349c8a4c38e POWER_BI_STANDARD                2                 2                 0
O365 E3 - all ... 962f7189-59d9-4a29-983f-556ae56f19a5 ENTERPRISEPACK                   2                 2                 0
O365 E5 - EXO     102fb8f4-bbe7-462b-83ff-2145e7cdd6ed ENTERPRISEPREMIUM                1                 1                 0
Access to Offi... 11151866-5419-4d93-9141-0603bbf78b42 STANDARDPACK                     4                 3                 1
```

## Get all groups with license errors
To find groups that contain some users for whom licenses could not be assigned:

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

The result looks like the following example:

```output
GroupId                                   GroupName             TotalUserCount LicenseErrorCount
--                                   -----------             --------- -----------
11151866-5419-4d93-9141-0603bbf78b42 Access to Office 365 2  2
```

Use following to get the same data from Microsoft Graph

```
GET https://graph.microsoft.com/v1.0/groups?$filter=hasMembersWithLicenseErrors+eq+true
```
Output:
```
HTTP/1.1 200 OK
{
  "value":[
    {
      "odata.type": "Microsoft.DirectoryServices.Group",
      "objectType": "Group",
      "id": "11151866-5419-4d93-9141-0603bbf78b42",
      ... # other group properties.
    },
    {
      "odata.type": "Microsoft.DirectoryServices.Group",
      "objectType": "Group",
      "id": "c57cdc98-0dcd-4f90-a82f-c911b288bab9",
      ...
    },
    ... # other groups with license errors.
  ]
"odata.nextLink":"https://graph.microsoft.com/v1.0/ groups?$filter=hasMembersWithLicenseErrors+eq+true&$skipToken=<encodedPageToken>"
}
```


## Get all users with license errors in a group

Given a group that contains some license-related errors, you can now list all users affected by those errors. A user can have errors from other groups, too. However, in this example we limit results only to errors relevant to the group in question by checking the **ReferencedObjectId** property of each **IndirectLicenseError** entry on the user.

```powershell
#a sample group with errors
$groupId = '11151866-5419-4d93-9141-0603bbf78b42'

#get all user members of the group
$Members = Get-MgGroupMember -All -GroupId $groupId 
#get full information about user objects
Foreach ($Member in $Members) {
    Get-MgUser -UserId $Member.Id |
        #filter out users without license errors and users with license errors from other groups
        Where {$Member.AdditionalProperties.IndirectLicenseErrors -and $Member.AdditionalProperties.IndirectLicenseErrors.ReferencedObjectId -eq $groupId} |
        #display id, name and error detail. Note: we are filtering out license errors from other groups
        Select Id, `
            DisplayName, `
            @{Name="LicenseError";Expression={$Member.AdditionalProperties.IndirectLicenseErrors | 
            Where {$Member.AdditionalProperties.IndirectLicenseErrors.ReferencedObjectId -eq $groupId} | 
            Select -ExpandProperty Error}}
    }
```

The result looks like the following example:

```output
Id                                   DisplayName      License Error
--                                   -----------      ------------
11bb11bb-cc22-dd33-ee44-55ff55ff55ff Catherine Gibson MutuallyExclusiveViolation
```

Use following to get the same data from Microsoft Graph:

```powershell
GET https://graph.microsoft.com/v1.0/groups/11151866-5419-4d93-9141-0603bbf78b42/membersWithLicenseErrors
```

Output:
```powershell
HTTP/1.1 200 OK
{
  "value":[
    {
      "odata.type": "Microsoft.DirectoryServices.User",
      "objectType": "User",
      "id": "11bb11bb-cc22-dd33-ee44-55ff55ff55ff",
      ... # other user properties.
    },
    ... # other users.
  ],
  "odata.nextLink":"https://graph.microsoft.com/v1.0/groups/11151866-5419-4d93-9141-0603bbf78b42/membersWithLicenseErrors?$skipToken=<encodedPageToken>"
}

```

## Get all users with license errors in the entire organization

The following script can be used to get all users who have license errors from one or more groups. The script prints one row per user, per license error, which allows you to clearly identify the source of each error.

> [!NOTE]
> This script enumerates all users in the organization, which might not be optimal for large organizations.

```powershell
Get-MgUser -All | Where {$_.AdditionalProperties.IndirectLicenseErrors } | % {   
    $user = $_;
    $user.AdditionalProperties.IndirectLicenseErrors | % {
        New-Object Object |
        Add-Member -NotePropertyName UserName -NotePropertyValue $user.DisplayName -PassThru |
        Add-Member -NotePropertyName UserId -NotePropertyValue $user.Id -PassThru |
        Add-Member -NotePropertyName GroupId -NotePropertyValue $_.AdditionalProperties.IndirectLicenseErrors.ReferencedObjectId -PassThru |
        Add-Member -NotePropertyName LicenseError -NotePropertyValue $_.AdditionalProperties.IndirectLicenseErrors -PassThru
        }
    }  
```

The result looks like the following example:

```output
UserName         UserId                               GroupId                              LicenseError
--------         ------                               -------                              ------------
Anna Bergman     00aa00aa-bb11-cc22-dd33-44ee44ee44ee 7946137d-b00d-4336-975e-b1b81b0666d0 MutuallyExclusiveViolation
Catherine Gibson 11bb11bb-cc22-dd33-ee44-55ff55ff55ff f2503e79-0edc-4253-8bed-3e158366466b CountViolation
Catherine Gibson 22cc22cc-dd33-ee44-ff55-66aa66aa66aa 11151866-5419-4d93-9141-0603bbf78b42 MutuallyExclusiveViolation
Drew Fogarty     33dd33dd-ee44-ff55-aa66-77bb77bb77bb 1ebd5028-6092-41d0-9668-129a3c471332 MutuallyExclusiveViolation
```

Here is another version of the script that searches only through groups that contain license errors. It may be more optimized for scenarios where you expect to have few groups with problems.

```powershell
$groupIds = Get-MgGroup -All -Filter "HasMembersWithLicenseErrors eq true"
    foreach ($groupId in $groupIds) {
        $Members = Get-MgGroupMember -All -GroupId $groupId 
        foreach ($Member in $Members) { Get-Get-MgUser -UserId $Member.Id |
            Where {$Member.AdditionalProperties.IndirectLicenseErrors -and $Member.AdditionalProperties.IndirectLicenseErrors.ReferencedObjectId -eq $groupId.ObjectID} |
            Select DisplayName, `
                   ObjectId, `
                   @{Name="LicenseError";Expression={$Member.AdditionalProperties.IndirectLicenseErrors | Where {$Member.AdditionalProperties.IndirectLicenseErrors.ReferencedObjectId -eq $groupId.Id} | Select -ExpandProperty Error}}
        }
    }
```

## Check if user license is assigned directly or inherited from a group

For a user object, it is possible to check if a particular product license is assigned from a group or if it is assigned directly.

The two sample functions below can be used to analyze the type of assignment on an individual user:

```powershell
#Returns TRUE if the user has the license assigned directly
function UserHasLicenseAssignedDirectly
{
    Param([Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser]$user, [string]$skuId)

    foreach($license in $user.Licenses)
    {
        #we look for the specific license SKU in all licenses assigned to the user
        if ($license.AccountSkuId -ieq $skuId)
        {
            #GroupsAssigningLicense contains a collection of IDs of objects assigning the license
            #This could be a group object or a user object (contrary to what the name suggests)
            #If the collection is empty, this means the license is assigned directly - this is the case for users who have never been licensed via groups in the past
            if ($license.GroupsAssigningLicense.Count -eq 0)
            {
                return $true
            }

            #If the collection contains the ID of the user object, this means the license is assigned directly
            #Note: the license may also be assigned through one or more groups in addition to being assigned directly
            foreach ($assignmentSource in $license.GroupsAssigningLicense)
            {
                if ($assignmentSource -ieq $user.ObjectId)
                {
                    return $true
                }
            }
            return $false
        }
    }
    return $false
}
#Returns TRUE if the user is inheriting the license from a group
function UserHasLicenseAssignedFromGroup
{
    Param([Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser]$user, [string]$skuId)

    foreach($license in $user.Licenses)
    {
        #we look for the specific license SKU in all licenses assigned to the user
        if ($license.AccountSkuId -ieq $skuId)
        {
            #GroupsAssigningLicense contains a collection of IDs of objects assigning the license
            #This could be a group object or a user object (contrary to what the name suggests)
            foreach ($assignmentSource in $license.GroupsAssigningLicense)
            {
                #If the collection contains at least one ID not matching the user ID this means that the license is inherited from a group.
                #Note: the license may also be assigned directly in addition to being inherited
                if ($assignmentSource -ine $user.ObjectId)
                {
                    return $true
                }
            }
            return $false
        }
    }
    return $false
}
```

This script executes those functions on each user in the organization, using the SKU ID as input - in this example we are interested in the license for *Enterprise Mobility + Security*, which in our organization is represented with ID *contoso:EMS*:

```powershell
#the license SKU we are interested in. use Get-MgSubscribedSku to see a list of all identifiers in your organization
$skuId = "contoso:EMS"

#find all users that have the SKU license assigned
Get-MgUser -All | where {$_.isLicensed -eq $true -and $_.Licenses.AccountSKUID -eq $skuId} | select `
    Id, `
    @{Name="SkuId";Expression={$skuId}}, `
    @{Name="AssignedDirectly";Expression={(UserHasLicenseAssignedDirectly $_ $skuId)}}, `
    @{Name="AssignedFromGroup";Expression={(UserHasLicenseAssignedFromGroup $_ $skuId)}}
```

The result looks like this example:

```output
Id                                   SkuId       AssignedDirectly AssignedFromGroup
--                                   -----       ---------------- -----------------
157870f6-e050-4b3c-ad5e-0f0a377c8f4d contoso:EMS             True             False
1f3174e2-ee9d-49e9-b917-e8d84650f895 contoso:EMS            False              True
240622ac-b9b8-4d50-94e2-dad19a3bf4b5 contoso:EMS             True              True
```

Graph doesn’t have a straightforward way to show the result, but it can be seen from this API:

```powershell
GET https://graph.microsoft.com/v1.0/users/e61ff361-5baf-41f0-b2fd-380a6a5e406a?$select=licenseAssignmentStates
```

Output:

```powershell
HTTP/1.1 200 OK
{
  "value":[
    {
      "odata.type": "Microsoft.DirectoryServices.User",
      "objectType": "User",
      "id": "e61ff361-5baf-41f0-b2fd-380a6a5e406a",
      "licenseAssignmentState":[
        {
          "skuId": "157870f6-e050-4b3c-ad5e-0f0a377c8f4d",
          "disabledPlans":[],
          "assignedByGroup": null, # assigned directly.
          "state": "Active",
          "error": "None"
        },
        {
          "skuId": "1f3174e2-ee9d-49e9-b917-e8d84650f895",
          "disabledPlans":[],
          "assignedByGroup": "e61ff361-5baf-41f0-b2fd-380a6a5e406a", # assigned by this group.
          "state": "Active",
          "error": "None"
        },
        {
          "skuId": "240622ac-b9b8-4d50-94e2-dad19a3bf4b5", 
          "disabledPlans":[
            "e61ff361-5baf-41f0-b2fd-380a6a5e406a"
          ],
          "assignedByGroup": "e61ff361-5baf-41f0-b2fd-380a6a5e406a",
          "state": "Active",
          "error": "None"
        },
        {
          "skuId": "240622ac-b9b8-4d50-94e2-dad19a3bf4b5",
          "disabledPlans":[],
          "assignedByGroup": null, # It is the same license as the previous one. It means the license is assigned directly once and inherited from group as well.
          "state": " Active ",
          "error": " None"
        }
      ],
      ...
    }
  ],
}

```

## Remove direct licenses for users with group licenses

The purpose of this script is to remove unnecessary direct licenses from users who already inherit the same license from a group; for example, as part of a [transition to group-based licensing](licensing-groups-migrate-users.md).
> [!NOTE]
> It is important to first validate that the direct licenses to be removed do not enable more service functionality than the inherited licenses. Otherwise, removing the direct license may disable access to services and data for users. Currently it is not possible to check via PowerShell which services are enabled via inherited licenses vs direct. In the script, we specify the minimum level of services we know are being inherited from groups and check against that to make sure users do not unexpectedly lose access to services.

```powershell
#BEGIN: Helper functions used by the script

#Returns TRUE if the user has the license assigned directly
function UserHasLicenseAssignedDirectly
{
    Param([Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser]$user, [string]$skuId)

    $license = GetUserLicense $user $skuId

    if ($license -ne $null)
    {
        #GroupsAssigningLicense contains a collection of IDs of objects assigning the license
        #This could be a group object or a user object (contrary to what the name suggests)
        #If the collection is empty, this means the license is assigned directly - this is the case for users who have never been licensed via groups in the past
        if ($license.GroupsAssigningLicense.Count -eq 0)
        {
            return $true
        }

        #If the collection contains the ID of the user object, this means the license is assigned directly
        #Note: the license may also be assigned through one or more groups in addition to being assigned directly
        foreach ($assignmentSource in $license.GroupsAssigningLicense)
        {
            if ($assignmentSource -ieq $user.ObjectId)
            {
                return $true
            }
        }
        return $false
    }
    return $false
}
#Returns TRUE if the user is inheriting the license from a specific group
function UserHasLicenseAssignedFromThisGroup
{
    Param([Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser]$user, [string]$skuId, [Guid]$groupId)

    $license = GetUserLicense $user $skuId

    if ($license -ne $null)
    {
        #GroupsAssigningLicense contains a collection of IDs of objects assigning the license
        #This could be a group object or a user object (contrary to what the name suggests)
        foreach ($assignmentSource in $license.GroupsAssigningLicense)
        {
            #If the collection contains at least one ID not matching the user ID this means that the license is inherited from a group.
            #Note: the license may also be assigned directly in addition to being inherited
            if ($assignmentSource -ieq $groupId)
            {
                return $true
            }
        }
        return $false
    }
    return $false
}

#Returns the license object corresponding to the skuId. Returns NULL if not found
function GetUserLicense
{
    Param([Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser]$user, [string]$skuId, [Guid]$groupId)
    #we look for the specific license SKU in all licenses assigned to the user
    foreach($license in $user.Licenses)
    {
        if ($license.AccountSkuId -ieq $skuId)
        {
            return $license
        }
    }
    return $null
}

#produces a list of disabled service plan names for a set of plans we want to leave enabled
function GetDisabledPlansForSKU
{
    Param([string]$skuId, [string[]]$enabledPlans)

    $allPlans = Get-MgSubscribedSku | where {$_.SkuId -ieq $skuId} | Select -ExpandProperty ServiceStatus | Where {$_.ProvisioningStatus -ine "PendingActivation" -and $_.ServicePlan.TargetClass -ieq "User"} | Select -ExpandProperty ServicePlans | Select -ExpandProperty ServiceName
    $disabledPlans = $allPlans | Where {$enabledPlans -inotcontains $_}

    return $disabledPlans
}

function GetUnexpectedEnabledPlansForUser
{
    Param([Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser]$user, [string]$skuId, [string[]]$expectedDisabledPlans)

    $license = GetUserLicense $user $skuId

    $extraPlans = @();

    if($license -ne $null)
    {
        $userDisabledPlans = $license.ServiceStatus | where {$_.ProvisioningStatus -ieq "Disabled"} | Select -ExpandProperty ServicePlan | Select -ExpandProperty ServiceName

        $extraPlans = $expectedDisabledPlans | where {$userDisabledPlans -notcontains $_}
    }
    return $extraPlans
}
#END: helper functions

#BEGIN: executing the script
#the group to be processed
$groupId = "48ca647b-7e4d-41e5-aa66-40cab1e19101"

#license to be removed - Office 365 E3
$skuId = "contoso:ENTERPRISEPACK"

#minimum set of service plans we know are inherited from groups - we want to make sure that there aren't any users who have more services enabled
#which could mean that they may lose access after we remove direct licenses
$servicePlansFromGroups = ("EXCHANGE_S_ENTERPRISE", "SHAREPOINTENTERPRISE", "OFFICESUBSCRIPTION")

$expectedDisabledPlans = GetDisabledPlansForSKU $skuId $servicePlansFromGroups

#process all members in the group and get full info about each user in the group looping through group members. 
$Members = Get-MgGroupMember -All -GroupId $groupId 
Foreach ($member in $Members) {

    Get-MgUser -UserId $Member.Id | Foreach {
        $user = $_;
        $operationResult = "";

        #check if Direct license exists on the user
        if (UserHasLicenseAssignedDirectly $user $skuId)
        {
            #check if the license is assigned from this group, as expected
            if (UserHasLicenseAssignedFromThisGroup $user $skuId $groupId)
            {
                #check if there are any extra plans we didn't expect - we are being extra careful not to remove unexpected services
                $extraPlans = GetUnexpectedEnabledPlansForUser $user $skuId $expectedDisabledPlans
                if ($extraPlans.Count -gt 0)
                {
                    $operationResult = "User has extra plans that may be lost - license removal was skipped. Extra plans: $extraPlans"
                }
                else
                {
                    #remove the direct license from user
                    Set-MgUserLicense -UserId $user.Id -RemoveLicenses $skuId
                    $operationResult = "Removed direct license from user."   
                }

            }
            else
            {
                $operationResult = "User does not inherit this license from this group. License removal was skipped."
            }
        }
        else
        {
            $operationResult = "User has no direct license to remove. Skipping."
        }

        #format output
        New-Object Object |
                    Add-Member -NotePropertyName UserId -NotePropertyValue $user.Id -PassThru |
                    Add-Member -NotePropertyName OperationResult -NotePropertyValue $operationResult -PassThru
    } | Format-Table

}
#END: executing the script
```

The result looks like this example:

```output
UserId                               OperationResult
------                               ---------------
7c7f860f-700a-462a-826c-f50633931362 Removed direct license from user.
0ddacdd5-0364-477d-9e4b-07eb6cdbc8ea User has extra plans that may be lost - license removal was skipped. Extra plans: SHAREPOINTWAC
aadbe4da-c4b5-4d84-800a-9400f31d7371 User has no direct license to remove. Skipping.
```

> [!NOTE]
> Please update the values for the variables `$skuId` and `$groupId` which is being targeted for removal of Direct Licenses as per your test environment before running the above script.

## Next steps

To learn more about the feature set for license management through groups, see the following articles:

* [What is group-based licensing in Microsoft Entra ID?](~/fundamentals/concept-group-based-licensing.md)
* [Assigning licenses to a group in Microsoft Entra ID](./licensing-groups-assign.md)
* [Identifying and resolving license problems for a group in Microsoft Entra ID](licensing-groups-resolve-problems.md)
* [How to migrate individual licensed users to group-based licensing in Microsoft Entra ID](licensing-groups-migrate-users.md)
* [How to migrate users between product licenses using group-based licensing in Microsoft Entra ID](licensing-groups-change-licenses.md)
* [Microsoft Entra group-based licensing additional scenarios](./licensing-group-advanced.md)
* [PowerShell examples for group-based licensing in Microsoft Entra ID](licensing-ps-examples.md)
