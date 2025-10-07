---
title: Preserve the organizational unit (OU) path for synced groups
description: Steps to preserve the organizational unit (OU) path for synced groups
author: omondiatieno
ms.service: entra-id
ms.topic: Include
ms.date: 10/07/2025
ms.author: jomondi
ms.custom: Include file
---
## Preserve the organizational unit (OU) path for synced groups

Complete these end-to-end steps to preserve the original organizational unit (OU) for Active Directory Domain Services (AD DS) groups when use the Microsoft Entra Provisioning Agent in Microsoft Entra Cloud Sync to provision SOA converted groups from Microsoft Entra ID back to AD DS: 

1. Create a tenant-scoped directory extension property for groups. 
1. Map an on-premises value, such as the distinguished name (DN), directly into the extension property. 
1. Verify the property value using Microsoft Graph. 
1. Convert the Source of Authority (SOA) when ready. 
1. Use custom expressions to ensure Cloud Sync provisions groups back to AD DS with the same CN and OU values. 
 
### Create the extension 

Cloud Sync only supports extensions created on a special application called *CloudSyncCustomExtensionsApp*. If the app doesn't exist in your tenant, you must create it. This step is performed once per tenant. 
 
#### Connect to Microsoft Graph PowerShell

Open an elevated PowerShell window and run the following commands to install modules and connect: 

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser -Force 
Connect-MgGraph -Scopes "Application.ReadWrite.All","Directory.ReadWrite.All","Directory.AccessAsUser.All" 
```

#### Ensure the special application exists 

Check if the application exists. If it doesn't, create it. Also ensure a service principal is present. 

```powershell
$tenantId = (Get-MgOrganization).Id 
$app = Get-MgApplication -Filter "identifierUris/any(uri:uri eq 'API://$tenantId/CloudSyncCustomExtensionsApp')" 
if (-not $app) { 
  $app = New-MgApplication -DisplayName "CloudSyncCustomExtensionsApp" -IdentifierUris "API://$tenantId/CloudSyncCustomExtensionsApp" 
} 
 
$sp = Get-MgServicePrincipal -Filter "AppId eq '$($app.AppId)'" 
if (-not $sp) { 
  $sp = New-MgServicePrincipal -AppId $app.AppId 
} 
```

#### Create the directory extension property for groups 

Now add a directory extension property named *GroupDN*. This will be a string attribute available on group objects. 

```powershell
New-MgApplicationExtensionProperty ` 
  -ApplicationId $app.Id ` 
  -Name "GroupDN" ` 
  -DataType "String" ` 
  -TargetObjects Group 
```

### Configure Cloud Sync attribute mapping 

Next, tell Cloud Sync to populate this extension property with the group’s distinguished name (DN) from AD DS. This DN ensures the original OU and CN information are preserved in Entra. 

1. Sign in to the Microsot Entra admin center as at least a Hybrid Administrator.
1. Select **Entra ID** > **Entra Connect** > **Cloud Sync**. 
1. Select your **AAD to Entra** provisioning configuration. 
1. Go to **Attribute mappings**. 
1. At the top, switch **Object type** to **Group**. 
1. Add a new attribute mapping. 
   - Mapping type: Direct 
   - Source attribute: distinguishedName (the on-prem group’s DN) 
   - Target attribute: extension_<appIdWithoutHyphens>_GroupDN 
1. Save the schema to trigger a sync. 

By mapping distinguishedName directly, you capture the group’s full DN (CN + OU path) in the extension property, which makes it easier to later reconstruct both CN and OU when provisioning back to AD DS. 

### Verify that the mapping worked 

Once sync runs, you should verify that the extension property is populated with the DN. Use Microsoft Graph PowerShell: 

```powershell
$clientId = $app.AppId 
$propName = "extension_{0}_GroupDN" -f ($clientId -replace "-","") 
$grp = Get-MgGroup -Filter "displayName eq 'My Security Group'" -ConsistencyLevel eventual 
Get-MgGroup -GroupId $grp.Id -Property "id,displayName,$propName" | 
  Select-Object id, displayName, @{n=$propName; e={$_."$propName"}} 
```

This command returns the group with its DN stored in the extension property. You can also test using Graph Explorer by querying: 
 
```https
GET /v1.0/groups/{id}?$select=displayName,extension_<appIdNoHyphens>_GroupDN 
```

### Convert Source of Authority (SOA) 

After you validate the DN is stored in the extension, you can convert the group’s Source of Authority to Microsoft Entra ID. The group is then cloud-managed while the original DN is preserved in the extension for later use in **Group Provisioning to Active Directory**. 

### Use group provisioning expressions to preserve CN and OU 

When you provision groups back to AD DS using **Group Provisioning to Active Directory**, custom expressions ensure the group is created with the same CN and OU. 

Expression for CN value: 

IIF(IsNullOrEmpty([extension_..._GroupDN]), Append(Append(Left(Trim([DisplayName]), 51), "_"), Mid([ObjectId], 25, 12)), Replace(Replace(Replace(Word(Replace([extension_..._GroupDN], "\\,", , , "\\2C", , ), 1, ","), "CN=", , , "", , ), "cn=", , , "", , ), "\\2C", , , ",", , )) 


This expression: 
- If the extension is empty, generates a fallback CN from DisplayName + ObjectId. 
- Otherwise extracts the CN, handling escaped commas by temporarily replacing them with hex values. 

Expression for ParentDistinguishedName value:

IIF(IsNullOrEmpty([extension_..._GroupDN]), "OU=test1,DC=utkarshVm,DC=nttest,DC=microsoft,DC=com", Replace(Mid(Mid(Replace([extension_..._GroupDN], "\\,", , , "\\2C", , ), Instr(Replace([extension_..._GroupDN], "\\,", , , "\\2C", , ), ",", , ), 9999), 2, 9999), "\\2C", , , ",", , )) 

This expression: 
- Uses a default OU if the extension is empty. 
- Otherwise strips the CN portion and preserves the parentDN path, again handling escaped commas. 

This change causes a full sync and doesn't affect existing groups. Test by setting the GroupDN attribute for an existing group using Microsoft Graph and ensure that it moves back to original OU. 

### Troubleshooting and tips 

- If the extension doesn't appear in mappings, confirm it was created under CloudSyncCustomExtensionsApp. 
- If new on-premises attributes don't appear, restart the provisioning agent service. 
- Escaped commas in CN values (\\,) are handled by substitution with \\2C. 
- Always configure safe fallbacks to avoid provisioning errors. 

### Conclusion 

By completing this setup, you ensure: 
- Groups preserve their original OU placement even after you convert their SOA. 
- Group CN values are consistent, even with special characters. 
- Your Cloud Sync and **Group Provisioning to Active Directory** deployment remains stable, predictable, and fully reversible. 