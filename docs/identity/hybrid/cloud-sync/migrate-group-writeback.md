---
title: 'Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync'
description: This article describes how to migrate groups that were initially set up of group writeback using Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync
services: active-directory
author: billmath
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.topic: how-to
ms.date: 10/24/2023
ms.subservice: hybrid
ms.author: billmath
ms.collection: M365-identity-device-management
---

# Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync
The following document describes how to migrate group writeback using Microsoft Entra Connect Sync (formerly Azure AD Connect) to Microsoft Entra Cloud Sync.  This scenario is **only** for customers who are currently using Microsoft Entra Connect group writeback v2.  The process outlined in this document pertains only to cloud-created security groups that are written back with a universal scope.  Mail-enabled groups and DLs written back using Microsoft Entra Connect group writeback V1 or V2 are not supported.

>[!IMPORTANT]
>This scenario is **only** for customers who are currently using Microsoft Entra Connect group writeback v2
>
>Also, this scenario is only supported for:
>   - cloud created [Security groups](../../../fundamentals/concept-learn-about-groups.md#group-types)
>   - these groups are written back with the AD groups scope of [universal](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).
>
>Mail-enabled groups and DLs written back using Microsoft Entra Connect group writeback V1 or V2 are not supported.

## Prerequisites
The following prerequisites are required to implement this scenario.

 - Azure AD account with at least a [Hybrid Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
 - An on-premises AD account with at least domain administrator permissions - required to access the adminDescription attribute and copy it to the msDS-ExternalDirectoryObjectId attribute
 - On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later. 
     - Required for AD Schema attribute  - msDS-ExternalDirectoryObjectId 
 - Provisioning agent with build version [1.1.1367.0](reference-version-history.md#) or later.
 - The provisioning agent must be able to communicate with the domain controller(s) on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
     - Required for global catalog lookup to filter out invalid membership references



## Step 1 - Copy adminDescription to msDS-ExternalDirectoryObjectID
 1. In your on-premises environment, open ADSI Edit.
 2. Copy the value that it in the group's adminDescription attribute

:::image type="content" source="media/migrate-group-writeback/migrate-1.png" alt-text="Screenshot of the adminDescription attribute." lightbox="media/migrate-group-writeback/migrate-1.png":::
 3. Paste this in to the msDS-ExternalDirectoryObjectID attribute
 :::image type="content" source="media/migrate-group-writeback/migrate-2.png" alt-text="Screenshot of the msDS-ExternalDirectoryObjectID attribute." lightbox="media/migrate-group-writeback/migrate-2.png":::

## Step 2 - Place the Microsoft Entra Connect Sync server in staging mode and disable the sync scheduler
 1. Start the Microsoft Entra Connect Sync(Azure AD Connect) wizard 
 2. Click **Configure**
 3. Select **Configure staging mode** and click **Next**
 4. Enter Entra ID credentials
 5. Place a check in the **Enable staging mode** box and click **Next**
  
  :::image type="content" source="media/migrate-group-writeback/migrate-3.png" alt-text="Screenshot of enabling staging mode." lightbox="media/migrate-group-writeback/migrate-3.png":::
 
 6. Click **Configure**
 7. Click **Exit**

   :::image type="content" source="media/migrate-group-writeback/migrate-4.png" alt-text="Screenshot of staging mode success." lightbox="media/migrate-group-writeback/migrate-4.png":::
 
 8. On your Microsoft Entra Connect server, open a PowerShell prompt as an administrator. 
 9. Disable the sync scheduler: 

   ``` PowerShell 
   Set-ADSyncScheduler -SyncCycleEnabled $false  
   ``` 


## Step 3 - Create a custom group inbound rule
In the Microsoft Entra Connect Synchronization Rules editor, you need to create an inbound sync rule that filters out groups that have NULL for the mail attribute.  The inbound sync rule is a join rule with a target attribute of cloudNoFlow.  This rule tells Microsoft Entra Connect not to synchronize attributes for these groups.  

 1. Launch the synchronization editor from the application menu in desktop as shown below:
 2. Select **Inbound** from the drop-down list for Direction and select **Add new rule**.
 3. On the **Description** page, enter the following and select **Next**:

    - **Name:** Give the rule a meaningful name
    - **Description:** Add a meaningful description
    - **Connected System:** Choose the AD connector that you're writing the custom sync rule for
    - **Connected System Object Type:** Group
    - **Metaverse Object Type:** Group
    - **Link Type:** Join
    - **Precedence:** Provide a value that is unique in the system
    - **Tag:** Leave this empty

    :::image type="content" source="media/migrate-group-writeback/migrate-5.png" alt-text="Screenshot of inbound sync rule." lightbox="media/migrate-group-writeback/migrate-5.png":::

 4. On the **Scoping filter** page, **Add** the following and then select **Next**.

    |Attribute|Operator|Value|
    |-----|----|----|
    |cloudMastered|EQUAL|true.|
    |mail|ISNULL||

    :::image type="content" source="media/migrate-group-writeback/migrate-6.png" alt-text="Screenshot of scoping filter." lightbox="media/migrate-group-writeback/migrate-6.png":::

 5. On the **Join** rules page, select **Next**.
 6. On the **Transformations** page, add a Constant transformation: flow True to cloudNoFlow attribute. Select **Add**.

    :::image type="content" source="media/migrate-group-writeback/migrate-7.png" alt-text="Screenshot of transformation." lightbox="media/migrate-group-writeback/migrate-7.png":::


## Step 4 - Create a custom group outbound rule
You'll also need an outbound sync rule with a link type of JoinNoFlow and the scoping filter that has the cloudNoFlow attribute set to True.  This rule tells Microsoft Entra Connect not to synchronize attributes for these groups. 

 1. Select **Outbound** from the drop-down list for Direction and select **Add rule**.
 2. On the **Description** page, enter the following and select **Next**:

    - **Name:** Give the rule a meaningful name
    - **Description:** Add a meaningful description
    - **Connected System:** Choose the Microsoft Entra connector that you're writing the custom sync rule for
    - **Connected System Object Type:** Group
    - **Metaverse Object Type:** Group
    - **Link Type:** JoinNoFlow
    - **Precedence:** Provide a value that is unique in the system<br>
    - **Tag:** Leave this empty

    :::image type="content" source="media/migrate-group-writeback/migrate-8.png" alt-text="Screenshot of outbound sync rule." lightbox="media/migrate-group-writeback/migrate-8.png":::

 3. On the **Scoping filter** page, choose **cloudNoFlow** equal **True**. Then select **Next**.
    
    :::image type="content" source="media/migrate-group-writeback/migrate-9.png" alt-text="Screenshot of outbound scoping filter." lightbox="media/migrate-group-writeback/migrate-9.png":::
 
 4. On the **Join** rules page, select **Next**.
 5. On the **Transformations** page, select **Add**.


## Step 5 - Use PowerShell to finish configuration
1. On your Microsoft Entra Connect server, open a PowerShell prompt as an administrator. 
2. Import the ADSync module:

   ``` PowerShell 
   Import-Module  'C:\Program Files\Microsoft Azure Active Directory Connect\Tools\ADSyncTools.psm1' 
   ``` 
3. Run a full sync cycle:
   ``` PowerShell 
   Start-ADSyncSyncCycle -PolicyType Initial
   ``` 
4. Disable the group writeback feature for the tenant: 

   ``` PowerShell 
   Set-ADSyncAADCompanyFeature -GroupWritebackV2 $false 

5. Run a full sync cycle (yes again):
   ``` PowerShell 
   Start-ADSyncSyncCycle -PolicyType Initial
   ``` 
   ``` 
6. Re-enable the sync scheduler:

   ``` PowerShell 
   Set-ADSyncScheduler -SyncCycleEnabled $true  
   ``` 
    :::image type="content" source="media/migrate-group-writeback/migrate-11.png" alt-text="Screenshot of PowerShell execution." lightbox="media/migrate-group-writeback/migrate-11.png":::

## Step 6 - Remove the Microsoft Entra Connect Sync server from staging mode
1.  Start the Entra Connect Sync wizard (Azure AD Connect)
2.  Click **Configure**
3.  Select **Configure staging mode** and click **Next**
4.  Enter Entra ID credentials
5.  Remove the check from the **Enable staging mode** box and click **Next**
6.  Click **Configure**
7.  Click **Exit**

## Step 7 - Configure Microsoft Entra Cloud Sync
Now that you have successfully removed the groups from the scope of Microsoft Entra Connect Sync, you can seupt and configure Microsoft Entra Cloud Sync to take over synchronization.  To do this, see [Provision groups to Active Directory using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md)

## Next Steps
- [Provision groups to Active Directory using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)