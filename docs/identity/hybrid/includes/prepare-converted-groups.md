---
title: Prepare SOA converted groups for provisioning to their original organizational unit (OU) path
description: Steps to prepare SOA converted groups for provisioning to their original organizational unit (OU) path
author: omondiatieno
ms.service: entra-id
ms.topic: Include
ms.date: 10/10/2025
ms.author: jomondi
ms.custom: Include file
---
## Prepare SOA converted groups for provisioning to their original organizational unit (OU) path

Complete these steps to prepare groups that you plan to convert to be cloud-managed for provisioning from Microsoft Entra ID back to their original OU path in Active Directory Domain Services (AD DS) on-premises:

1. Change the AD DS group scope to Universal. 
1. Create a special application.
1. Create the directory extension property for groups.

### Change the group scope for the AD DS groups to Universal

1. Open Active Directory Administrative Center.
1. Right-click a group, click **Properties**.
1. In the **Group** section, select **Universal** as the group scope.
1. Click **Save**.

### Create the extension 

Cloud Sync only supports extensions created on a special application called *CloudSyncCustomExtensionsApp*. If the app doesn't exist in your tenant, you must create it. This step is performed once per tenant. 

For more information about how to create the extension, see [Cloud sync directory extensions and custom attribute mapping](/entra/identity/hybrid/cloud-sync/custom-attribute-mapping).
 
#### [**Graph PowerShell**](#tab/ps)

1. Open an elevated PowerShell window and run the following commands to install modules and connect: 

   ```powershell
   Install-Module Microsoft.Graph -Scope CurrentUser -Force 
   Connect-MgGraph -Scopes "Application.ReadWrite.All","Directory.ReadWrite.All","Directory.AccessAsUser.All" 
   ```

1. Check if the application exists. If it doesn't, create it. Also ensure a service principal is present. 

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

1. Now add a directory extension property named *GroupDN*. This will be a string attribute available on group objects. 

   ```powershell
   New-MgApplicationExtensionProperty ` 
     -ApplicationId $app.Id ` 
     -Name "GroupDN" ` 
     -DataType "String" ` 
     -TargetObjects Group 
   ```
   
For more information about how to create the directory extension property for groups, see [Cloud sync directory extensions and custom attribute mapping](/entra/identity/hybrid/cloud-sync/custom-attribute-mapping).

#### [**Graph Explorer**](#tab/ge)
 
1. Check if application with the identifier URI `API://<tenantId>/CloudSyncCustomExtensionsApp` exists.

   ```https
   GET /applications?$filter=identifierUris/any(uri:uri eq 'api://<tenantId>/CloudSyncCustomExtensionsApp')
   ```

   For more information, see [Get application](/graph/api/application-get?view=graph-rest-1.0&tabs=http&preserve-view=true)
     
1. If the application doesn't exist, create the application with identifier URI `API://<tenantId>/CloudSyncCustomExtensionsApp`:

   ```https
   POST https://graph.microsoft.com/v1.0/applications
   Content-type: application/json

   {
   "displayName": "CloudSyncCustomExtensionsApp",
   "identifierUris": ["api://<tenant id>/CloudSyncCustomExtensionsApp"]
   }
   ```
   
   For more information, see [create application](/graph/api/application-post-applications?view=graph-rest-1.0&tabs=http&preserve-view=true).

1. Create a directory extension in Microsoft Entra ID. For example, a new extension called 'GroupDN', of string type, for Group objects:

   ```https
   POST https://graph.microsoft.com/v1.0/applications/<ApplicationId>/extensionProperties
   Content-type: application/json
     
   {
     "name": "GroupDN",
     "dataType": "String",
     "isMultiValued": false,
     "targetObjects": [
         "Group"
     ]
   }    
   ```

### Configure Cloud Sync attribute mapping

Next, tell Cloud Sync to populate this extension property with the group’s Distinguished Name (DN) from Active Directory. This step ensures the original OU and CN information are preserved in Microsoft Entra ID.

1. Open Microsoft Entra admin center > **Entra ID** > **Entra Connect** > **Cloud Sync**.
2. Select your AD-to-Microsoft Entra ID configuration.
3. Go to **Attribute mappings**.
4. At the top, switch **Object type** to **Group**.
5. Add a new attribute mapping.
   - Mapping type: Direct
   - Source attribute: distinguishedName (the on-premises group’s DN)
   - Target attribute: `extension_<appIdWithoutHyphens>_GroupDN`
6. Save the schema to trigger a sync.

By mapping distinguishedName directly, you capture the group’s full DN (CN + OU path) in the extension property, making it easier to later reconstruct both CN and OU when provisioning back to AD.

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

Once you have validated the DN is stored in the extension, you can convert the group’s Source of Authority to Microsoft Entra ID. This change makes the group cloud-managed while preserving its original DN in the extension for later use in group provisioning to AD DS.
