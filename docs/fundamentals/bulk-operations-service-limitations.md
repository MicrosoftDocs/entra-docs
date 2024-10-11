---
title: Bulk operations
description: Learn about Microsoft Entra bulk operations related to users, groups, and devices in the Microsoft Entra admin portal could time out and fail on very large tenants.
keywords: Azure AD licensing
author: barclayn
manager: amycolannino

ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 07/15/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro

# Customer intent: As an IT admin, I want to understand bulk operations, so that I can effectively understand what some of the service limitations are and apply a workaround if possible.
---

# Bulk operations

Bulk operations in Microsoft Entra ID enable you to perform actions on multiple entities, such as users, groups, and devices, at once. This can include creating, deleting, or updating multiple records in a single operation, which can greatly streamline administrative tasks and improve efficiency.

Bulk operations in the Microsoft Entra admin portal could time out and fail on very large tenants. This limitation is a known issue due to scaling limitations. The Microsoft engineering team is working on a new service that will eventually address this limitation.

> [!NOTE]
> When performing bulk operations, such as import or create, you may encounter a problem if the bulk operation does not complete within the hour. To work around this issue, we recommend splitting the number of records processed per batch. For example, before starting an export you could limit the result set by filtering on a group type or user name to reduce the size of the results. By refining your filters, essentially you are limiting the data returned by the bulk operation. 

## Bulk operations workaround

A workaround for this issue is to use PowerShell to make direct Microsoft Graph API calls. For bulk download users and groups failure, we recommend using the PowerShell cmdlets `GET-MgGroup -All` and `GET-MgUser -All`.

The following PowerShell code examples are for bulk operations related to:
- [Users](#users)
- [Groups](#groups)
- [Devices](#devices)

## Users

### Bulk download all users 

```azurepowershell
# Import the Microsoft Graph module 
Import-Module Microsoft.Graph 

# Authenticate to Microsoft Graph (you may need to provide your credentials) 
Connect-MgGraph -Scopes "User.Read.All" 

# Get all users using Get-MgUser 
$users = Get-MgUser -All -ConsistencyLevel eventual -Property Id, DisplayName, UserPrincipalName,UserType,OnPremisesSyncEnabled,CompanyName,CreationType 

# Specify the output CSV file path 
$outputCsvPath = "C:\\Users\\YourUsername\\Documents\\Users.csv"  

# Create a custom object to store user data 
$userData = @() 

# Loop through each user and collect relevant data 
foreach ($user in $users) { 
    $userObject = [PSCustomObject]@{ 
        Id = $user.Id 
        DisplayName = $user.DisplayName 
        UserPrincipalName = $user.UserPrincipalName 
        UserType = $user.UserType 
        OnPremisesSyncEnabled = $user.OnPremisesSyncEnabled 
        CompanyName = $user.CompanyName 
        CreationType = $user.CreationType 
    } 
    $userData += $userObject 
} 

# Export user data to a CSV file 
$userData | Export-Csv -Path $outputCsvPath -NoTypeInformation 

# Disconnect from Microsoft Graph 
Disconnect-MgGraph 

Write-Host "User data exported to $outputCsvPath" 
```

### Bulk create users 

```azurepowershell 
# Import the Microsoft Graph module 
Import-Module Microsoft.Graph 

# Authenticate to Microsoft Graph (you may need to provide your credentials) 
Connect-MgGraph -Scopes "User.ReadWrite.All" 

# Specify the path to the CSV file containing user data 
$csvFilePath = "C:\\Path\\To\\Your\\Users.csv" 

# Read the CSV file (adjust the column names as needed) 
$usersData = Import-Csv -Path $csvFilePath 

# Loop through each row in the CSV and create users \
foreach ($userRow in $usersData) { 
    $userParams = @{ 
        DisplayName = $userRow.'Name [displayName] Required' 
        UserPrincipalName = $userRow.'User name [userPrincipalName] Required' 
        PasswordProfile = @{ 
            Password = $userRow.'Initial password [passwordProfile] Required'
            ForceChangePasswordNextSignIn = $true # You can set this to $false if you don't want the user to change the password at the next sign-in
        } 
        AccountEnabled = $true 
        MailNickName = $userRow.mailNickName
        UsageLocation = $userRow.usageLocation # Required the ISO Country Code. For example: US for United States
    } 
    try { 
        New-MgUser @userParams -ErrorAction SilentlyContinue
        Write-Host "User $($userRow.UserPrincipalName) created successfully." -ForegroundColor Green
    } catch{ 
        Write-Host "Error creating user $($userRow.UserPrincipalName): $($_.ErrorDetails.Message)" -ForegroundColor Red
    } 
} 

# Disconnect from Microsoft Graph 
Disconnect-MgGraph

Write-Host "Bulk user creation completed." 
```

> [!NOTE] 
> Make sure your CSV file contains the necessary columns (for example; `DisplayName`, `UserPrincipalName`, and so on). Also, adjust the script to match the actual column names in your CSV file. 


### Bulk delete users 

```azurepowershell
# Import the Microsoft Graph module 
Import-Module Microsoft.Graph 

# Authenticate to Microsoft Graph (you may need to provide your credentials) 
Connect-MgGraph -Scopes "User.ReadWrite.All" 

# Specify the path to the CSV file containing user data 
$csvFilePath = "C:\\Path\\To\\Your\\Users.csv" 

# Read the CSV file (adjust the column names as needed) 
$usersData = Import-Csv -Path $csvFilePath 

# Loop through each row in the CSV and delete users 
foreach ($userRow in $usersData) { 
    try { 
        Remove-MgUser -UserId $userRow.UserPrincipalName -Confirm:$false -ErrorAction SilentlyContinue
        Write-Host "User $($userRow.UserPrincipalName) deleted successfully." -ForegroundColor Yellow
    } catch { 
        Write-Host "Error deleting user $($userRow.UserPrincipalName): $($_.ErrorDetails.Message)" -ForegroundColor Red
    } 
} 

# Disconnect from Microsoft Graph 
Disconnect-MgGraph 

Write-Host "Bulk user deletion completed." 
```

> [!NOTE]
> Make sure your CSV file contains the necessary columns (for example, `UserPrincipalName`). Also, adjust the script to match the actual column names in your CSV file. 

## Groups

### Bulk download all groups 

```azurepowershell
Import-Module Microsoft.Graph.Groups 

 # Authenticate to Microsoft Graph (you may need to provide your credentials) 
 Connect-MgGraph -Scopes "Group.Read.All" 

 # Get the group members 
 $groups = Get-MgGroup -All | Select displayName, Id, groupTypes,mail 

 # Create a custom object to store group data 
$groupData = @() 

# Loop through each group and collect relevant data 
foreach ($group in $groups) { 
    if ($group.groupTypes -contains "Unified"){$groupType = "Microsoft 365"} 
    else {$groupType = "Security"} 
    if ($group.groupTypes -contains "DynamicMembership"){$membershipType = "Dynamic"} 
    else {$membershipType = "Assigned"} 
    $groupObject = [PSCustomObject]@{ 
        Id = $group.Id 
        DisplayName = $group.displayName 
        Mail = $group.mail 
        GroupType = $groupType 
        MemebershipType = $membershipType 
    }   
    $groupData += $groupObject 
} 

 # Specify the output CSV file path 
 $outputCsvPath = "C:\\Users\\<YourUsername>\\Documents\\Groups.csv" 

 $groupData| Export-Csv -Path $outputCsvPath -NoTypeInformation 
 
 Write-Host "Group members exported to $outputCsvPath" 
```

### Bulk download members of a group

```azurepowershell
Import-Module Microsoft.Graph.Groups 

 # Authenticate to Microsoft Graph (you may need to provide your credentials) 
 Connect-MgGraph -Scopes "Group.Read.All,GroupMember.Read.All" 

 # Set the group ID of the group whose members you want to download 
 $groupId = "your_group_id" 

 # Get the group members 
 $members = Get-MgGroupMemberAsUser -GroupId $groupId -All | Select-Object @(
    @{  Name        =   "UserId";
        Expression  =   {$_.Id}
    },
    @{  Name        =   "UserPrincipalName";
        Expression  =   {$_.UserPrincipalName}
    },
    @{  Name        =   "DisplayName";
        Expression  =   {$_.DisplayName}
    }
 )

 # Specify the output CSV file path 
 $outputCsvPath = "C:\\Users\\YourUserName\\Documents\\GroupMembers.csv" 

 $members| Export-Csv -Path $outputCsvPath -NoTypeInformation 

# Disconnect from Microsoft Graph 
Disconnect-MgGraph 

 Write-Host "Group members exported to $outputCsvPath"  
```

### Add members in bulk 

```azurepowershell
Import-Module Microsoft.Graph.Groups 

 # Authenticate to Microsoft Graph (you may need to provide your credentials) 
 Connect-MgGraph -Scopes "GroupMember.ReadWrite.All" 

# Import the CSV file 
$members = Import-Csv -Path "C:\path\to\your\file.csv" 

# Define the Group ID 
$groupId = "your-group-id" 

# Iterate over each member and add them to the group 
foreach ($member in $members) { 
    $user = Get-MgUser -UserId $members.UserPrincipalName
    if($user){
        try{
            New-MgGroupMember -GroupId $groupId -DirectoryObjectId $user.Id -ErrorAction SilentlyContinue
            Write-Host "Added $($user.UserPrincipalName) to the group." -ForegroundColor Green
        } 
        Catch{ 
            Write-Host "Error adding member $($user.UserPrincipalName): $($_.ErrorDetails.Message)" -ForegroundColor Red 
        } 
    }
    else{
        Write-Host "User $($members.UserPrincipalName) not found." -ForegroundColor Red
    }
} 

# Disconnect from Microsoft Graph 
Disconnect-MgGraph 
```
> [!NOTE]
> Make sure your CSV file contains the column `UserPrincipalName` with all users you want to add in the group 
 
### Remove members in bulk 

```azurepowershell 
Import-Module Microsoft.Graph.Groups 

 # Authenticate to Microsoft Graph (you may need to provide your credentials) 
 Connect-MgGraph -Scopes "GroupMember.ReadWrite.All" 

# Import the CSV file 
$members = Import-Csv -Path "C:\path\to\your\file.csv" 

# Define the Group ID 
$groupId = "your-group-id" 

# Iterate over each member and remove them from the group 
foreach ($member in $members) { 
    $user = Get-MgUser -UserId $members.UserPrincipalName
    if($user){
        try{
            New-MgGroupMember -GroupId $groupId -DirectoryObjectId $user.Id -ErrorAction SilentlyContinue
            Write-Host "Removed $($user.UserPrincipalName) from the group." -ForegroundColor Green
        } 
        Catch{ 
            Write-Host "Error removing member $($user.UserPrincipalName): $($_.ErrorDetails.Message)" -ForegroundColor Red 
        } 
    }
    else{
        Write-Host "User $($members.UserPrincipalName) not found." -ForegroundColor Red
    }
}

# Disconnect from Microsoft Graph 
Disconnect-MgGraph 
```
> [!NOTE]
> Make sure your CSV file contains the column `UserPrincipalName` with all users you want to remove from the group 

## Devices 

### Bulk download all devices 

```azurepowershell
Import-Module Microsoft.Graph 

 # Authenticate to Microsoft Graph (you may need to provide your credentials) 
 Connect-MgGraph -Scopes "Device.Read.All" 

 # Get all devices  
 $devices = Get-MgDevice -All |select displayName,deviceId,operatingSystem,operatingSystemVersion,isManaged,isCompliant,mdmAppId,registeredOwners,TrustType 

 # Specify the output CSV file path 
 $outputCsvPath = "C:\\Users\\YourUserName\\Documents\\Devices.csv" 

 $devices| Export-Csv -Path $outputCsvPath -NoTypeInformation 

 Write-Host "Devices exported to $outputCsvPath"  
```
