Issues and proposed solutions  

When customers are ready to move decommission their on-premises Active Directory and uninstall sync tools, their users and groups will be migrated to Entra ID and customers will manage the objects in Entra ID. Users may encounter issues in Windows, Intune and Outlook, as user on-premises attributes still have the legacy values. E.g. joining hybrid devices may not work, as it takes username and domain from user on-premises attributes. We recommend customers clear these on-premises attributes to resolve issues. 

These on-premises attributes include  

onPremisesDistinguishedName 

onPremisesDomainName 

onPremisesImmutableId 

onPremisesSamAccountName 

onPremisesSecurityIdentifier 

onPremisesUserPrincipalName 

 

Customers can update these attributes on Microsoft Graph Beta with Update User API (https://learn.microsoft.com/en-us/graph/api/user-update?view=graph-rest-beta&tabs=http). These attributes can only be updated in Entra ID for Cloud-Only users and for converted users after customers have disabled decommissioned their sync tools. 

The Entra ID roles that can update on-premises attributes are: 

Global Admin 

User Admin 

Hybrid Identity Admin 

 

The required application permission is User.ReadWrite.All. 

You can also view, update these on-premises attributes with the PowerShell scripts below.  

Using ADSyncTools PowerShell module 

Prerequisites for managing on-premises attributes with ADSyncTools PowerShell module: 

PowerShell 7  

Microsoft Graph SDK PowerShell module 

 

In order to use ADSyncTools you need to install the module from PowerShell Gallery , as follows: 

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
 

Install-Module ADSyncTools # If ADSyncTools isn’t installed, or; 

 

Update-Module ADSyncTools # If ADSyncTools is already installed 
 

Note: The minimum required version to manage On-Premises attributes in Entra ID is v1.5.1. 

 

Use the following commands to get started with ADSyncTools. 

Import ADSyncTools module 

Import-Module ADSyncTools 

See the cmdlets available for managing OnPremises attributes: 

Get-Command *onpremises* -Module ADSyncTools 

Result: 

CommandType     Name                                           Version    Source 
	-----------     ----                                           -------    ------ 
	Function        Clear-ADSyncToolsOnPremisesAttribute           1.5.0      ADSyncTools 
	Function        Get-ADSyncToolsOnPremisesAttribute             1.5.0      ADSyncTools 
	Function        Set-ADSyncToolsOnPremisesAttribute             1.5.0      ADSyncTools 
 

Get all the details of a cmdlet (i.e., Syntax, Examples, etc) with Get-Help <cmdlet> -Full: 

Get-Help Get-ADSyncToolsOnPremisesAttribute -Full 

 

Clear on-premises attributes 

Clearing all on-premises attributes for all users 

To clear all on-premises attributes from all users in a bulk fashion, use the get function to retrieve a list of all cloud-only users containing on-premises attributes and then pipeline the results to the Clear cmdlet adding the parameter -All. 

IMPORTANT  

Before clearing on-premises attributes from Entra ID users in production, back up all the user's on-premises properties as a safety recommendation, in case you need to roll back the operation. You can back up all the current values with the following command: 

Get-ADSyncToolsOnPremisesAttribute |  

Export-Csv backupOnpremisesAttributes.csv -Delimiter ';' 

To clear all on-premises attributes from all users, run: 

Get-ADSyncToolsOnPremisesAttribute | Select-Object id |  

Clear-ADSyncToolsOnPremisesAttribute -All -Verbose 

 

Clearing all on-premises attributes for one user 

To clear all on-premises attributes for one particular user, specify the objectId or UserPrincipalName followed by the parameter -All. 

Clear-ADSyncToolsOnPremisesAttribute 'User1@Contoso.com' -All 

Clear-ADSyncToolsOnPremisesAttribute 

This function can be used to clear any of the following on-premises attributes individually: 

onPremisesDistinguishedName 

onPremisesDomainName 

onPremisesImmutableId 

onPremisesSamAccountName 

onPremisesSecurityIdentifier 

onPremisesUserPrincipalName 

 

Requires Microsoft Graph PowerShell SDK, authenticated with: Connect-MgGraph -Scopes "User.ReadWrite.All" 

 

SYNTAX 

    Clear-ADSyncToolsOnPremisesAttribute [-Id] <String> [[-onPremisesDistinguishedName]] [[-onPremisesDomainName]] [[-onPremisesImmutableId]] [[-onPremisesSamAccountName]] [[-onPremisesSecurityIdentifier]] [[-onPremisesUserPrincipalName]] [<CommonParameters>] 

 

    Clear-ADSyncToolsOnPremisesAttribute [-Id] <String> [-BodyParameter] <String> [<CommonParameters>] 

 

    Clear-ADSyncToolsOnPremisesAttribute [-Id] <String> [-All] [<CommonParameters>] 

 

     

    -------------------------- EXAMPLE 1 -------------------------- 

 

    PS > Clear only onPremisesDistinguishedName attribute 

    Clear-ADSyncToolsOnPremisesAttribute -Identity '98765432-6f08-40b2-8b66-123456789012'  ` 

-onPremisesDistinguishedName 

 

 

    -------------------------- EXAMPLE 2 -------------------------- 

 

    PS > Clear some onpremises attributes explicitly 

    Clear-ADSyncToolsOnPremisesAttribute 'User1@Contoso.com'   ` 

-onPremisesImmutableId ` 

-onPremisesSecurityIdentifier ` 

-onPremisesUserPrincipalName 

 

    -------------------------- EXAMPLE 3 -------------------------- 

 

    PS > Clear onpremises attributes based on a json parameter body (-BodyParameter) 

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

 

Get users with on-premises attributes 

Get a specific user or all users containing on-premises properties in Entra ID 

Get-ADSyncToolsOnPremisesAttribute 

Notes: 

It only returns the users that have on-premises attributes populated. 

By Default, it returns all cloud-only users, but you can specify -IncludeSyncedUsers to return all users, including users synced from on-premises AD. 

Requires Microsoft Graph PowerShell SDK, authenticated with: Connect-MgGraph -Scopes "User.Read.All" 

 

SYNTAX 
    Get-ADSyncToolsOnPremisesAttribute [-Identity] <String> [[-Property] <String[]>] [<CommonParameters>] 
 
    Get-ADSyncToolsOnPremisesAttribute [[-IncludeSyncedUsers]] [[-Property] <String[]>] [<CommonParameters>] 
 
EXAMPLES 
    -------------------------- EXAMPLE 1 -------------------------- 
 
    # Get the on-premises attributes of all cloud-users that have on-premises attributes populated. 
    Get-ADSyncToolsOnPremisesAttribute 
 
    -------------------------- EXAMPLE 2 -------------------------- 
 
    # Get the on-premises attributes of all users that have on-premises attributes populated. 
    Get-ADSyncToolsOnPremisesAttribute -IncludeSyncedUsers 
 

Set on-premises attributes 

Set on-premises attributes for a cloud user in Entra ID 

IMPORTANT  

Before updating on-premises attributes for Entra ID users in production, back up all the user's on-premises properties as a safety recommendation, in case you need to roll back the operation. You can back up all the current values with the following command: 

Get-ADSyncToolsOnPremisesAttribute | Export-Csv backupOnpremisesAttributes.csv -Delimiter ';' 

Set-ADSyncToolsOnPremisesAttribute 

This function can be used to set any of the on-premises attributes listed below: 

onPremisesDistinguishedName 

onPremisesDomainName 

onPremisesImmutableId 

onPremisesSamAccountName 

onPremisesSecurityIdentifier * 

onPremisesUserPrincipalName 

 

* Must have the correct Security Identifier format, e.g.: "S-1-5-21-4097605469-3104078553-1111111111-1111" 

 

SYNTAX 
    Set-ADSyncToolsOnPremisesAttribute [-Identity] <String> [[-onPremisesDistinguishedName] <String>] [[-onPremisesDomainName] <String>] [[-onPremisesImmutableId] <String>] [[-onPremisesSamAccountName] 
    <String>] [[-onPremisesSecurityIdentifier] <String>] [[-onPremisesUserPrincipalName] <String>] [<CommonParameters>] 
 
    Set-ADSyncToolsOnPremisesAttribute [-Identity] <String> [-BodyParameter] <String> [<CommonParameters>] 
 
 
EXAMPLES 
    -------------------------- EXAMPLE 1 -------------------------- 
 
    PS > Set only onPremisesImmutableId (pipelining) 
    'User1@Contoso.com' | Set-ADSyncToolsOnPremisesAttribute -onPremisesImmutableId 'nofCJe0gZk6D8J4gRgrt+A==' 
 
    -------------------------- EXAMPLE 2 -------------------------- 
 
    PS > Set onpremises attributes based on a json parameter body (-BodyParameter) 
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
