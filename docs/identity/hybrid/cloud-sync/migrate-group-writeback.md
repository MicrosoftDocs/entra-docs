---
title: 'Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync'
description: This article describes how to migrate groups that were initially set up of group writeback using Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 04/26/2024
ms.subservice: hybrid-cloud-sync
ms.author: billmath

---

# Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync

[!INCLUDE [deprecation](~/includes/gwb-v2-deprecation.md)]

The following document describes how to migrate group writeback using Microsoft Entra Connect Sync (formerly Azure AD Connect) to Microsoft Entra Cloud Sync. This scenario is **only** for customers who are currently using Microsoft Entra Connect group writeback v2. The process outlined in this document pertains only to cloud-created security groups that are written back with a universal scope.

> [!IMPORTANT]
> This scenario is **only** for customers who are currently using Microsoft Entra Connect group writeback v2
> 
> Also, this scenario is only supported for:
> - cloud created [Security groups](../../../fundamentals/concept-learn-about-groups.md#group-types)
> - groups written back to AD with scope of [universal](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).
>
> Mail-enabled groups and DLs written back to AD continue to work with Microsoft Entra Connect group writeback but will revert to the behavior of group writeback V1, so in this scenario, after disabling group writeback V2 all M365 groups will be written back to AD independently of the Writeback Enabled setting in Entra admin center. For more information, see the [Provisioning to Active Directory with Microsoft Entra Cloud Sync FAQ](reference-provision-to-active-directory-faq.yml).

## Prerequisites

The following prerequisites are required to implement this scenario.

 - Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
 - An on-premises AD account with at least domain administrator permissions - required to access the adminDescription attribute and copy it to the msDS-ExternalDirectoryObjectId attribute
 - On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later. 
     - Required for AD Schema attribute  - msDS-ExternalDirectoryObjectId 
 - Provisioning agent with build version [1.1.1367.0](reference-version-history.md#) or later.
 - The provisioning agent must be able to communicate with the domain controller(s) on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
     - Required for global catalog lookup to filter out invalid membership references


## Naming convention for groups written back
By default, Microsoft Entra Connect Sync uses the following format when naming groups that are written back.

- Default format: CN=Group_&lt;guid&gt;,OU=&lt;container&gt;,DC=&lt;domain component&gt;,DC=\<domain component>

 - Example: CN=Group_3a5c3221-c465-48c0-95b8-e9305786a271,OU=WritebackContainer,DC=contoso,DC=com 

To make it easier to find groups being written back from Microsoft Entra ID to Active Directory, Microsoft Entra Connect Sync added an option to write back the group name by using the cloud display name. This is done by selecting the **Writeback Group Distinguished Name with cloud Display Name** during initial setup of group writeback v2. If this feature is enabled, Microsoft Entra Connect uses the following new format, instead of the default format:

- New format: CN=&lt;display name&gt;_&lt;last 12 digits of object ID&gt;,OU=&lt;container&gt;,DC=&lt;domain component&gt;,DC=\<domain component>

 - Example: CN=Sales_e9305786a271,OU=WritebackContainer,DC=contoso,DC=com 

> [!IMPORTANT]
> By default, Microsoft Entra cloud sync uses the new format, even if **Writeback Group Distinguished Name with cloud Display Name** feature is not enabled in Microsoft Entra Connect Sync. If you are using the default Microsoft Entra Connect Sync naming and then migrate the group so that it is managed by Microsoft Entra cloud sync, the group is renamed to the new format. Use the following section to allow Microsoft Entra cloud sync to use the default format from Microsoft Entra Connect.

### Using the default format
If you want cloud sync to use the same default format as Microsoft Entra Connect Sync, you need to modify the attribute flow expression for the CN attribute. The two possible mappings are:

|Expression|Syntax|Description|
|-----|-----|-----|
|Cloud sync default expression using DisplayName|Append(Append(Left(Trim([displayName]), 51), "_"), Mid([objectId], 25, 12))|The default expression used by Microsoft Entra cloud sync (that is, the new format)|
|Cloud sync new expression without using DisplayName|Append("Group_", [objectId])|The new expression to use the default format from Microsoft Entra Connect Sync.|

For more information, see [Add an attribute mapping - Microsoft Entra ID to Active Directory](how-to-attribute-mapping.md#add-an-attribute-mapping---microsoft-entra-id-to-active-directory)

## Step 1 - Copy adminDescription to msDS-ExternalDirectoryObjectID

To validate group membership references, Microsoft Entra Cloud Sync must query the Active Directory Global Catalog for msDS-ExternalDirectoryObjectID attribute. This is an indexed attribute which replicates across all Global Catalogs within the Active Directory Forest.

1. In your on-premises environment, open ADSI Edit.

2. Copy the value that it in the group's adminDescription attribute

   :::image type="content" source="media/migrate-group-writeback/migrate-1.png" alt-text="Screenshot of the adminDescription attribute." lightbox="media/migrate-group-writeback/migrate-1.png":::

3. Paste in to the msDS-ExternalDirectoryObjectID attribute

   :::image type="content" source="media/migrate-group-writeback/migrate-2.png" alt-text="Screenshot of the msDS-ExternalDirectoryObjectID attribute." lightbox="media/migrate-group-writeback/migrate-2.png":::

The following PowerShell script can be used to help automate this step. This script takes all of the groups in the **OU=Groups,DC=Contoso,DC=com** container and copy the adminDescription attribute value to the msDS-ExternalDirectoryObjectID attribute value. Before using this script, update the variable `$gwbOU` with the DistinguishedName of your group writeback's target organizational unit (OU).

```powershell

# Provide the DistinguishedName of your Group Writeback target OU
$gwbOU = 'OU=Groups,DC=Contoso,DC=com'

# Get all groups written back to Active Directory
Import-module ActiveDirectory
$properties = @('Samaccountname', 'adminDescription', 'msDS-ExternalDirectoryObjectID')
$groups = Get-ADGroup -Filter * -SearchBase $gwbOU -Properties $properties | 
    Where-Object {$_.adminDescription -ne $null} |
        Select-Object $properties

# Set msDS-ExternalDirectoryObjectID for all groups written back to Active Directory 
foreach ($group in $groups) {
    Set-ADGroup -Identity $group.Samaccountname -Add @{('msDS-ExternalDirectoryObjectID') = $group.adminDescription}
} 

```

## Step 2 - Place the Microsoft Entra Connect Sync server in staging mode and disable the sync scheduler

1. Start the Microsoft Entra Connect Sync wizard 
2. Click **Configure**
3. Select **Configure staging mode** and click **Next**
4. Enter Microsoft Entra credentials
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

In the Microsoft Entra Connect Synchronization Rules editor, you need to create an inbound sync rule that filters out groups that have NULL for the mail attribute. The inbound sync rule is a join rule with a target attribute of cloudNoFlow. This rule tells Microsoft Entra Connect not to synchronize attributes for these groups. 

 1. Launch the **Synchronization Rules Editor** from the start menu.
 2. Select **Inbound** from the drop-down list for Direction and select **Add new rule**.
 3. On the **Description** page, enter the following and select **Next**:

    - **Name:** Give the rule a meaningful name
    - **Description:** Add a meaningful description
    - **Connected System:** Choose the Microsoft Entra connector that you're writing the custom sync rule for
    - **Connected System Object Type:** Group
    - **Metaverse Object Type:** Group
    - **Link Type:** Join
    - **Precedence:** Provide a value that is unique in the system. Lower than 100 is recommended, so that it takes precedence over the default rules.
    - **Tag:** Leave empty

      :::image type="content" source="media/migrate-group-writeback/migrate-5.png" alt-text="Screenshot of inbound sync rule." lightbox="media/migrate-group-writeback/migrate-5.png":::

4. On the **Scoping filter** page, **Add** the following and then select **Next**.

   |Attribute|Operator|Value|
   |-----|----|----|
   |cloudMastered|EQUAL|true|
   |mail|ISNULL||
   

     :::image type="content" source="media/migrate-group-writeback/migrate-6.png" alt-text="Screenshot of scoping filter." lightbox="media/migrate-group-writeback/migrate-6.png":::

5. On the **Join** rules page, select **Next**.
6. On the **Transformations** page, add a Constant transformation: flow True to cloudNoFlow attribute. Select **Add**.

     :::image type="content" source="media/migrate-group-writeback/migrate-7.png" alt-text="Screenshot of transformation." lightbox="media/migrate-group-writeback/migrate-7.png":::


## Step 4 - Create a custom group outbound rule

You also need an outbound sync rule with a link type of JoinNoFlow and the scoping filter that has the cloudNoFlow attribute set to True. This rule tells Microsoft Entra Connect not to synchronize attributes for these groups. 

 1. Select **Outbound** from the drop-down list for Direction and select **Add rule**.
 2. On the **Description** page, enter the following and select **Next**:



    - **Name:** Give the rule a meaningful name
    - **Description:** Add a meaningful description
    - **Connected System:** Choose the AD connector that you're writing the custom sync rule for
    - **Connected System Object Type:** Group
    - **Metaverse Object Type:** Group
    - **Link Type:** JoinNoFlow
    - **Precedence:** Provide a value that is unique in the system. Lower than 100 is recommended, so that it takes precedence over the default rules.
    - **Tag:** Leave empty


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

1. Disable the group writeback feature for the tenant: 

   > [!WARNING]
   > This operation is irreversible. After disabling group writeback V2, all Microsoft 365 groups will be written back to AD, independently of the Writeback Enabled setting in Entra admin center.
   ``` PowerShell 
   Set-ADSyncAADCompanyFeature -GroupWritebackV2 $false 
   ```
   
5. Run a full sync cycle (yes again):

   ``` PowerShell 
   Start-ADSyncSyncCycle -PolicyType Initial
   ``` 

6. Re-enable the sync scheduler:

   ``` PowerShell 
   Set-ADSyncScheduler -SyncCycleEnabled $true  
   ``` 

     :::image type="content" source="media/migrate-group-writeback/migrate-11.png" alt-text="Screenshot of PowerShell execution." lightbox="media/migrate-group-writeback/migrate-11.png":::

## Step 6 - Remove the Microsoft Entra Connect Sync server from staging mode

1. Start the Microsoft Entra Connect Sync wizard
2. Click **Configure**
3. Select **Configure staging mode** and click **Next**
4. Enter Microsoft Entra credentials
5. Remove the check from the **Enable staging mode** box and click **Next**
6. Click **Configure**
7. Click **Exit**

## Step 7 - Configure Microsoft Entra Cloud Sync

Now that the groups are removed from the synchronization scope of Microsoft Entra Connect Sync, you can set up and configure Microsoft Entra Cloud Sync to take over synchronization of the security groups. See [Provision groups to Active Directory using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md).

## Next Steps

- [Provision groups to Active Directory using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Provisioning to Active Directory with Microsoft Entra Cloud Sync FAQ](reference-provision-to-active-directory-faq.yml)

