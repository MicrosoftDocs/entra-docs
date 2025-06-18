---
title: How to preserve and use the original organizational unit (OU) for group provisioning in Microsoft Entra ID
description: Learn how to preserve and use the original organizational unit (OU) for group provisioning in Microsoft Entra ID.
author: Justinha
manager: dougeby
ms.topic: concept-article
ms.date: 06/18/2025
ms.author: justinha
ms.reviewer: dhanyak
---


# Preserve and use the original OU for group provisioning 

This topic covers how to preserve and use the original organizational unit (OU) during group provisioning. 

## Step 1: Populate extensionAttribute13 in on-premises AD 

Use PowerShell to extract the OU from each group's Distinguished Name (DN) and store it in the extensionAttribute13 attribute. 

Get-ADGroup -Filter * -SearchBase "DC=contoso,DC=com" | ForEach-Object { 
    $ou = ($_.DistinguishedName -split ",", 2)[1]  # Extract OU path 
    Set-ADGroup -Identity $_.DistinguishedName -Replace @{extensionAttribute13 = $ou} 
} 

This stores each group’s original OU path in a writable attribute before SOA (Source of Authority) switch. 

## Step 2: Enable Sync for extensionAttribute13 in Azure AD Cloud Sync or Connect Sync 

1. Go to Microsoft Entra Admin Center → Identity → Provisioning → Cloud Sync. 
2. Select your Cloud Sync configuration. 
3. Under 'Attribute Mapping' for Group objects: 
   - Click Edit Mapping 
   - Add a new mapping: 

Setting 

Value 

Source attribute 

extensionAttribute13 

Target attribute 

onPremisesExtensionAttributes.extensionAttribute13 

Match objects 

Leave unchecked 

Apply this mapping 

Always 

## Step 3: Confirm Attribute Sync in Entra ID (Skip this step if the extension attribute is not exposed through graph) 

Use PowerShell or Microsoft Graph to verify the attribute sync: 
 

Option A – PowerShell (Microsoft Graph SDK): 

Get-MgGroup -GroupId <groupId> | Select -ExpandProperty OnPremisesExtensionAttributes 

Option B – Microsoft Graph Explorer: 

GET https://graph.microsoft.com/v1.0/groups/{group-id}?$select=onPremisesExtensionAttributes 

You should see: 

{ 
  "onPremisesExtensionAttributes": { 
    "extensionAttribute13": "OU=Finance,DC=contoso,DC=com" 
  } 
} 

🔹 Step 4: Use extensionAttribute13 in Group Provisioning to AD (GPAD) 

When configuring Group Provisioning to AD, use the synced attribute to control the target OU. 
 

1. In your GPAD configuration, map onPremisesExtensionAttributes.extensionAttribute13 to a custom variable, e.g., preferredOU. 
2. Use an expression like this to handle fallback: 

IIF(IsNullOrEmpty([preferredOU]), "OU=Default,DC=contoso,DC=com", [preferredOU]) 

This: 
- Uses the original OU if available 
- Falls back to a default OU if not set 
- Supports override by changing extensionAttribute13 later 

 ## Related content