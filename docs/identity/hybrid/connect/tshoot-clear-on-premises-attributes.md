---
title: 'Microsoft Entra Connect: Clear on-premises attributes from migrated Microsoft Entra ID users'
description: Learn how to clean up on-premises attributes from migrated users in Microsoft Entra ID.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi
ms.custom: has-adal-ref, has-azure-ad-ps-ref
---





# Clear on-premises attributes from migrated Microsoft Entra ID users

After you've migrated your users and groups to Microsoft Entra ID, you may be ready to decommission your on-premises Active Directory and uninstall sync tools. After turning off directory synchronization, you can manage these objects directly in Microsoft Entra ID.

However, you may encounter issues in Windows, Intune, and Outlook due to legacy values remaining in the user attributes that were previously synchronized from on-premises. For example, hybrid device joining may fail because the system pulls the username and domain from these outdated attributes.

To prevent these issues, we recommend that customers clear the following on-premises attributes:

- onPremisesDistinguishedName 
- onPremisesDomainName 
- onPremisesImmutableId 
- onPremisesSamAccountName 
- onPremisesSecurityIdentifier 
- onPremisesUserPrincipalName 

 
## How to update these attributes
You can update these attributes via Microsoft Graph Beta with [Update User](/graph/api/user-update?view=graph-rest-beta&tabs=http) API call. These attributes can only be updated in Entra ID for native Cloud-Only users or for previously synced users that have been converted to Cloud-Only users after turning off synchronization in Entra ID. 


### Required roles
The Entra ID roles that can update on-premises attributes are: 

- [User Administrator](../../../identity/role-based-access-control/permissions-reference.md#user-administrator) 
- [Hybrid Identity Administrator](../../../identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator) 

 
### Required permissions
The required application permission is User.ReadWrite.All. 



## Using ADSyncTools PowerShell module 

You can also view and update these on-premises attributes with the PowerShell scripts provided. 

### Prerequisites for managing on-premises attributes with ADSyncTools PowerShell module:

- [Windows PowerShell 7](/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4) 
- [Microsoft Graph SDK PowerShell module](/powershell/microsoftgraph/installation?view=graph-powershell-1.0) 

In order to use [ADSyncTools](reference-connect-adsynctools.md) you need to install the module from PowerShell Gallery, as follows: 

 ``` powershell
 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
 Install-Module ADSyncTools # If ADSyncTools isn’t installed, or; 
 Update-Module ADSyncTools # If ADSyncTools is already installed 
 ``` 

>[!NOTE]
> The minimum required version to manage On-Premises attributes in Entra ID is v1.5.2. 
 
Use the following commands to get started with ADSyncTools.

 ``` powershell
 Import-Module ADSyncTools 
 ```

See the cmdlets available for managing OnPremises attributes: 

 ``` powershell
Get-Command *onpremises* -Module ADSyncTools 
 ```
Result: 

 ```
 CommandType   Name                      Version  Source 
-----------   ----                      -------  ------ 
Function    Clear-ADSyncToolsOnPremisesAttribute      1.5.2   ADSyncTools 
Function    Get-ADSyncToolsOnPremisesAttribute       1.5.2   ADSyncTools 
Function    Set-ADSyncToolsOnPremisesAttribute       1.5.2   ADSyncTools 

 ```

Get all the details of a cmdlet (i.e., Syntax, Examples, etc.) with Get-Help &lt;cmdlet&gt; -Full: 

 ```Get-Help Get-ADSyncToolsOnPremisesAttribute -Full ``` 

## Get-ADSyncToolsOnPremisesAttribute 

### Description

Gets a specific user or all users containing on-premises properties in Entra ID. It only returns the users that have on-premises attributes populated. By Default, it returns all cloud-only users, but you can specify `-IncludeSyncedUsers` to return all users, including users synced from on-premises AD. 

This operation requires Microsoft Graph PowerShell SDK, preauthenticated with `Connect-MgGraph -Scopes "User.Read.All`

### SYNTAX 

#### By Identity
 
 ``` powershell
  Get-ADSyncToolsOnPremisesAttribute [-Identity] <String> [[-Property] <String[]>] [<CommonParameters>] 
 ```
#### By IncludeSyncedUsers
 
 ``` powershell
 Get-ADSyncToolsOnPremisesAttribute [[-IncludeSyncedUsers]] [[-Property] <String[]>] [<CommonParameters>] 
 ```

### EXAMPLES 

#### Example 1

Get the on-premises attributes of all cloud-users that have on-premises attributes populated. 

  ``` powershell
  Get-ADSyncToolsOnPremisesAttribute 
  ```

### Clearing all on-premises attributes for all users 

To clear all on-premises attributes from all users in a bulk fashion, use the get function to retrieve a list of all cloud-only users containing on-premises attributes and then pipeline the results to the Clear cmdlet adding the parameter -All. 

This operation requires Microsoft Graph PowerShell SDK, preauthenticated with `Connect-MgGraph -Scopes "User.ReadWrite.All`

>[!IMPORTANT] 
> Before clearing on-premises attributes from Entra ID users in production, back up all the user's on-premises properties as a safety recommendation, in case you need to roll back the operation.

You can back up all the current values with the following command: 

 ``` powershell
Get-ADSyncToolsOnPremisesAttribute | Export-Csv backupOnpremisesAttributes.csv -Delimiter ';' 
 ```

To clear all on-premises attributes from all users, run: 

 ``` powershell
Get-ADSyncToolsOnPremisesAttribute | Select-Object id | Clear-ADSyncToolsOnPremisesAttribute -All -Verbose 
 ```
 

### Clearing all on-premises attributes for one user 

To clear all on-premises attributes for one particular user, specify the objectId or UserPrincipalName followed by the parameter -All.

This operation requires Microsoft Graph PowerShell SDK, preauthenticated with `Connect-MgGraph -Scopes "User.ReadWrite.All`

 ``` powershell
Clear-ADSyncToolsOnPremisesAttribute 'User1@Contoso.com' -All 
 ```

You can also use `Clear-ADSyncToolsOnPremisesAttribute ` to clear any of the following on-premises attributes individually: 

- onPremisesDistinguishedName 
- onPremisesDomainName 
- onPremisesImmutableId 
- onPremisesSamAccountName 
- onPremisesSecurityIdentifier 
- onPremisesUserPrincipalName 

## Clear-ADSyncToolsOnPremisesAttribute

### Description

Clears the on-premises properties of a specific Cloud-Only user or all CLoud-Only users in Entra ID.

### SYNTAX 

 ``` powershell
  Clear-ADSyncToolsOnPremisesAttribute [-Id] <String> [[-onPremisesDistinguishedName]] [[-onPremisesDomainName]] [[-onPremisesImmutableId]] [[-onPremisesSamAccountName]] [[-onPremisesSecurityIdentifier]] [[-onPremisesUserPrincipalName]] [<CommonParameters>] 
 ```
 
#### by BodyParameter

 ``` powershell
  Clear-ADSyncToolsOnPremisesAttribute [-Id] <String> [-BodyParameter] <String> [<CommonParameters>] 
 ```
 
#### by All

 ``` powershell
  Clear-ADSyncToolsOnPremisesAttribute [-Id] <String> [-All] [<CommonParameters>] 
 ```

#### Example 1

Clear only onPremisesImmutableId attribute 
 
 ``` powershell
  Clear-ADSyncToolsOnPremisesAttribute -Identity '12345678-90ab-cd12-3456-7890abcd1234' -onPremisesImmutableId
 ``` 

#### Example 2
Clear onpremises attributes based on a json parameter body (-BodyParameter) 

``` powershell
$jsonBody = @'
{ 
  "onPremisesDistinguishedName": null, 
  "onPremisesDomainName": null, 
  "onPremisesImmutableId": null, 
  "onPremisesSamAccountName": null, 
  "onPremisesSecurityIdentifier": null, 
  "onPremisesUserPrincipalName": null 
} 
'@ 

Clear-ADSyncToolsOnPremisesAttribute -Identity $userId -BodyParameter $jsonBody

```

## Set-ADSyncToolsOnPremisesAttribute 

Sets on-premises attributes for a Cloud-Only user in Entra ID.

This operation requires Microsoft Graph PowerShell SDK, preauthenticated with `Connect-MgGraph -Scopes "User.ReadWrite.All`

>[!IMPORTANT]
>Before updating on-premises attributes for Entra ID users in production, back up all the user's on-premises properties as a safety recommendation, in case you need to roll back the operation.

You can back up all the current values with the following command: 

``` powershell
Get-ADSyncToolsOnPremisesAttribute | Export-Csv backupOnpremisesAttributes.csv -Delimiter ';' 
```

This function can be used to set any of the on-premises attributes listed below: 

- onPremisesDistinguishedName 
- onPremisesDomainName 
- onPremisesImmutableId 
- sonPremisesSamAccountName 
- onPremisesSecurityIdentifier * 
- onPremisesUserPrincipalName 


* Must have the correct Security Identifier format, e.g.: "S-1-5-21-1234567890-0987654321-1234567890-1111"


### SYNTAX 

``` powershell
Set-ADSyncToolsOnPremisesAttribute [-Identity] <String> [[-onPremisesDistinguishedName] <String>] [[-onPremisesDomainName] <String>] [[-onPremisesImmutableId] <String>] [[-onPremisesSamAccountName] <String>] [[-onPremisesSecurityIdentifier] <String>] [[-onPremisesUserPrincipalName] <String>] [<CommonParameters>] 
```

#### by BodyParameter

``` powershell
Set-ADSyncToolsOnPremisesAttribute [-Identity] <String> [-BodyParameter] <String> [<CommonParameters>] 
```
 
### EXAMPLES 

#### Example 1

Set only onPremisesImmutableId (pipelining) 

``` powershell
'User1@Contoso.com' | Set-ADSyncToolsOnPremisesAttribute -onPremisesImmutableId 'nofCJe0gZk6D8J4gRgrt+A==' 
```

#### Example 2

Set onpremises attributes based on a json parameter body (-BodyParameter) 

``` powershell
$jsonBody = @' 
{ 
  "onPremisesDistinguishedName": "User1@Contoso.com", 
  "onPremisesDomainName": 'Contoso.com', 
  "onPremisesImmutableId": 'nofCJe0gZk6D8J4gRgrt+A==', 
  "onPremisesSamAccountName": 'User1', 
  "onPremisesSecurityIdentifier": "S-1-5-21-4097605469-3104078553-1111111111-1111", 
  "onPremisesUserPrincipalName": "User1@Contoso.com" 
}
'@
Set-ADSyncToolsOnPremisesAttribute -Identity '98765432-6f08-40b2-8b66-123456789012' -BodyParameter $jsonBody
```

>[!Note]
>You can use `-Verbose` with any command to show additional details as to what the function is doing.

