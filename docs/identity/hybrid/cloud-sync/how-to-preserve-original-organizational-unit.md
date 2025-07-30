---
title: How to preserve and use the original organizational unit (OU) for group provisioning in Microsoft Entra ID
description: Learn how to preserve and use the original organizational unit (OU) for group provisioning in Microsoft Entra ID.
author: Justinha
manager: dougeby
ms.topic: concept-article
ms.date: 07/30/2025
ms.author: justinha
ms.reviewer: dhanyak
---


# Preserve and use the original OU for group provisioning 

This topic covers how to preserve and use the original organizational unit (OU) of an on-premises group during group provisioning to Microsoft Entra ID. 

## Step 1: Populate extensionAttribute13 in on-premises Active Directory Domain Services (AD DS) 

Use PowerShell to extract the OU from each group's distinguished name (DN) and store it in the extensionAttribute13 attribute. You can run the following cmdlet to store the original OU path of each group in a writable attribute before you convert Group Source of Authority (SOA). 


```powershell
Get-ADGroup -Filter * -SearchBase "DC=contoso,DC=com" | ForEach-Object { 
    $ou = ($_.DistinguishedName -split ",", 2)[1]  # Extract OU path 
    Set-ADGroup -Identity $_.DistinguishedName -Replace @{extensionAttribute13 = $ou} 
} 
```


You can also store the OU information in some other attribute also like *info* or any other custom attribute. For more information about how to sync custom attributes, see [Custom attribute mapping](/entra/identity/hybrid/cloud-sync/custom-attribute-mapping). 

## Step 2: Enable sync for extensionAttribute13 in Microsoft Entra Cloud Sync or Connect Sync 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
1. Browse to **Identity** > **Provisioning** > **Cloud Sync**. 
2. Select your Cloud Sync configuration. 
3. Under **Attribute Mapping**, for Group objects: 
   - Click **Edit Mapping** 
   - Add a new mapping: 

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

 - [Group SOA overview](../concept-source-of-authority-overview.md)
 - [How to configure Group SOA](../how-to-group-source-of-authority-configure.md)