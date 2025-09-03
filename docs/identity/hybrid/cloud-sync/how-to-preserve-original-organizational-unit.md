---
title: How to preserve and use the original organizational unit (OU) for group provisioning in Microsoft Entra ID
description: Learn how to preserve and use the original organizational unit (OU) for group provisioning in Microsoft Entra ID.
author: Justinha
manager: dougeby
ms.topic: concept-article
ms.date: 08/01/2025
ms.author: justinha
ms.reviewer: dhanyak
---


# Preserve and use the original OU for group provisioning 

This topic covers how to preserve and use the original organizational unit (OU) of an on-premises group during group provisioning to Microsoft Entra ID. 

## Prerequisite
 
Use [Connect Sync](/entra/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions) or [Cloud Sync](/entra/identity/hybrid/cloud-sync/custom-attribute-mapping) to sync a custom extension attribute, or use an existing attribute from the default schema that you aren't using today, and set the OU path for the groups that you want to convert Source of Authority (SOA) to the cloud. The attribute helps you provision the group to the same OU when you update these groups from the cloud.

## Step 1: Populate extensionAttribute13 in on-premises Active Directory Domain Services (AD DS) 

Use PowerShell to extract the OU from each group's distinguished name (DN) and store it in the extensionAttribute13 attribute. You can run the following cmdlet to store the original OU path of each group in a writable attribute before you convert Group Source of Authority (SOA). 


```powershell
Get-ADGroup -Filter * -SearchBase "DC=contoso,DC=com" | ForEach-Object { 
    $ou = ($_.DistinguishedName -split ",", 2)[1]  # Extract OU path 
    Set-ADGroup -Identity $_.DistinguishedName -Replace @{extensionAttribute13 = $ou} 
} 
```


You can also store the OU information in some other attribute like *info* or any other custom attribute. For more information about how to sync custom attributes, see [Custom attribute mapping](/entra/identity/hybrid/cloud-sync/tutorial-directory-extension-group-provisioning). 

## Step 2: Enable sync for extensionAttribute13 in Microsoft Entra Cloud Sync or Connect Sync 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
1. Browse to **Identity** > **Provisioning** > **Cloud Sync**. 
1. Select your Cloud Sync configuration. 
1. Under **Attribute Mapping**, for Group objects: 
   1. Click **Edit Mapping** 
   1. Add a new mapping: 

     | Setting | Value |
     |---------|-------|
     | Source attribute | extensionAttribute13 |
     | Target attribute | onPremisesExtensionAttributes.extensionAttribute13|
     | Match objects | Leave unchecked |
     | Apply this mapping | Always |

## Step 3: Confirm attribute sync in Microsoft Entra ID 

Use PowerShell or Microsoft Graph Explorer to verify the attribute sync.
 

- **PowerShell (Microsoft Graph SDK)**

  ```powershell
  Get-MgGroup -GroupId <groupId> | Select -ExpandProperty OnPremisesExtensionAttributes 
  ```

- **Microsoft Graph Explorer**

  ```https
  GET https://graph.microsoft.com/v1.0/groups/{group-id}?$select=onPremisesExtensionAttributes 
  ```

  You should see: 

  ```
  { 
    "onPremisesExtensionAttributes": { 
      "extensionAttribute13": "OU=Finance,DC=contoso,DC=com" 
    } 
  } 
  ```

## Step 4: Use extensionAttribute13 during provisioning 

When you configure **Provisioning**, use the synced attribute to control the target OU. 
 
1. In your **Provisioning** configuration, map onPremisesExtensionAttributes.extensionAttribute13 to a custom variable such as *preferredOU*. 
2. Use an expression like this example to handle fallback. This expression uses the original OU if it's available, or falls back to a default OU that you specify. You can change extensionAttribute13 later to override the value. 

   ```
   IIF(IsNullOrEmpty([extensionAttribute13]), "OU=<Enter your default OU name>,DC=contoso,DC=com", [extensionAttribute13]) 
   ```

## Related content

- [Provision groups to Active Directory Domain Services by using Microsoft Entra Cloud Sync](tutorial-group-provisioning.md)
- [Govern on-premises Active Directory Domain Services based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)

