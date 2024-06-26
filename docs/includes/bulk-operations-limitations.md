---
title: include file
description: include file
author: barclayn
manager: amycolannino
ms.service: entra-id
ms.topic: include
ms.date: 06/26/2024
ms.author: barclayn
ms.custom: include file
---

## Bulk operations limitations

Bulk operations in the Microsoft Entra admin portal could time out and fail on very large tenants. This limitation is a known issue due to scaling limitations. The Microsoft engineering team is working on a new service that will address this limitation in the future.

>[!NOTE]
> When performing bulk operations, such as import or create, you may encounter a problem if the bulk operation does not complete within the hour. To work around this issue, we recommend splitting the number of records processed per batch. For example, before starting an export you could limit the result set by filtering on a group type or user name to reduce the size of the results. By refining filters, essentially you are limiting the data returned by the bulk operation. 

Another workaround for this issue is to use PowerShell with direct Microsoft Graph API calls. For bulk download users and groups failure, we recommend using the PowerShell cmdlets `GET-MgGroup -All` and `GET-MgUser -All`.

The following PowerShell code examples are for bulk operations related to:
- [Users](#users)
- [Groups](#groups)
- [Devices](#devices)

### Users

```
Download a list of users in Azure portal
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
 

Bulk create users
Sample csv file:
 
# Import the Microsoft Graph module
Import-Module Microsoft.Graph

# Authenticate to Microsoft Graph (you may need to provide your credentials)
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Specify the path to the CSV file containing user data
$csvFilePath = "C:\\Path\\To\\Your\\Users.csv"

# Read the CSV file (adjust the column names as needed)
$usersData = Import-Csv -Path $csvFilePath

# Loop through each row in the CSV and create users
foreach ($userRow in $usersData) {
    $userParams = @{
        DisplayName = $userRow.'Name [displayName] Required'
        UserPrincipalName = $userRow.'User name [userPrincipalName] Required'
        PasswordProfile = @{
            Password = $userRow.'Initial password [passwordProfile] Required'
        }
        AccountEnabled = $true
        MailNickName = $userRow.mailNickName
    }

    try {
        New-MgUser @userParams
        Write-Host "User $($userRow.UserPrincipalName) created successfully."
    } catch {
        Write-Host "Error creating user $($userRow.UserPrincipalName): $($_.Exception.Message)"
    }
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph

Write-Host "Bulk user creation completed."

# Note: Make sure your CSV file contains the necessary columns (e.g., DisplayName, UserPrincipalName, etc.).
# Adjust the script to match the actual column names in your CSV file.

Bulk delete users
 
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
        Remove-MgUser -UserId $userRow.UserPrincipalName -Confirm:$false
        Write-Host "User $($userRow.UserPrincipalName) deleted successfully."
    } catch {
        Write-Host "Error deleting user $($userRow.UserPrincipalName): $($_.Exception.Message)"
    }
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph

Write-Host "Bulk user deletion completed."

# Note: Make sure your CSV file contains the necessary columns (e.g., UserPrincipalName).
# Adjust the script to match the actual column names in your CSV file.
```

### Groups

```
Bulk download members of a group in Microsoft Entra ID
Import-Module Microsoft.Graph.Groups

 # Authenticate to Microsoft Graph (you may need to provide your credentials)
 Connect-MgGraph -Scopes "Group.Read.All,GroupMember.Read.All"


 # Set the group ID of the group whose members you want to download
 $groupId = "your_group_id"

 # Get the group members
 $members = Get-MgGroupMember -GroupId $groupId -All | select * -ExpandProperty additionalProperties | Select-Object @(
                'id'    
                @{  Name       = 'userPrincipalName'
                    Expression = { $_.AdditionalProperties["userPrincipalName"] }
                }
                @{  Name = 'displayName'
                Expression = { $_.AdditionalProperties["displayName"] }
                }
            )

 # Specify the output CSV file path
 $outputCsvPath = "C:\\Users\\YourUserName\\Documents\\GroupMembers.csv"


 $members| Export-Csv -Path $outputCsvPath -NoTypeInformation

# Disconnect from Microsoft Graph
Disconnect-MgGraph


 Write-Host "Group members exported to $outputCsvPath" 
 
Add members in bulk
 
Import-Module Microsoft.Graph.Groups

 # Authenticate to Microsoft Graph (you may need to provide your credentials)
 Connect-MgGraph -Scopes "GroupMember.ReadWrite.All"

# Import the CSV file
$members = Import-Csv -Path "C:\path\to\your\file.csv"

# Define the Group ID
$groupId = "your-group-id"


# Iterate over each member and add them to the group
foreach ($member in $members) {
    try{
        New-MgGroupMember -GroupId $groupId -DirectoryObjectId $member.memberObjectId
  	 Write-Host "Added $($member.memberObjectId) to the group." 
    }
    Catch{
        Write-Host "Error adding member $($member.memberObjectId):$($_.Exception.Message)"
    }
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph

Remove members in bulk
 
Import-Module Microsoft.Graph.Groups

 # Authenticate to Microsoft Graph (you may need to provide your credentials)
 Connect-MgGraph -Scopes "GroupMember.ReadWrite.All"

# Import the CSV file
$members = Import-Csv -Path "C:\path\to\your\file.csv"

# Define the Group ID
$groupId = "your-group-id"

# Iterate over each member and add them to the group
foreach ($member in $members) {
    try{
        Remove-MgGroupMemberByRef -GroupId $groupId -DirectoryObjectId $member.memberObjectId
        Write-Host "Removed $($member.memberObjectId) from the group."
    }
    Catch{
        Write-Host "Error removing member $($member.memberObjectId):$($_.Exception.Message)"
    }
}
 
# Disconnect from Microsoft Graph
Disconnect-MgGraph
```

### Devices 

TBD




