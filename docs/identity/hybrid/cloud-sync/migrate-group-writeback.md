---
title: 'Migrate Microsoft Entra Connect Sync Group Writeback v2 to Microsoft Entra Cloud Sync'
description: This article describes how to migrate groups that were initially set up for Group Writeback by using Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: jomondi

---

# Migrate Microsoft Entra Connect Sync Group Writeback v2 to Microsoft Entra Cloud Sync

[!INCLUDE [deprecation](~/includes/gwb-v2-deprecation.md)]

This article describes how to migrate Group Writeback by using Microsoft Entra Connect Sync (formerly Azure Active Directory Connect) to Microsoft Entra Cloud Sync. This scenario is *only* for customers who are currently using Microsoft Entra Connect Group Writeback v2. The process outlined in this article pertains only to cloud-created security groups that are written back with a universal scope.

This scenario is only supported for:

- Cloud-created [security groups](../../../fundamentals/concept-learn-about-groups.md#group-types).
- Groups written back to Active Directory with the scope of [universal](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).

Mail-enabled groups and distribution lists written back to Active Directory continue to work with Microsoft Entra Connect Group Writeback but revert to the behavior of Group Writeback v1. In this scenario, after you disable Group Writeback v2, all Microsoft 365 groups are written back to Active Directory independently of the **Writeback Enabled** setting in the Microsoft Entra admin center. For more information, see [Provision to Active Directory with Microsoft Entra Cloud Sync FAQ](reference-provision-to-active-directory-faq.yml).

## Prerequisites

 - A Microsoft Entra account with at least a [Hybrid Identity administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
 - An on-premises Active Directory account with at least domain administrator permissions.
     
   Required to access the `adminDescription` attribute and copy it to the `msDS-ExternalDirectoryObjectId` attribute.
 - On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later.
     
   Required for the Active Directory Schema attribute `msDS-ExternalDirectoryObjectId`.
 - Provisioning agent with build version [1.1.1367.0](reference-version-history.md#) or later.
 - The provisioning agent must be able to communicate with the domain controllers on ports TCP/389 (LDAP) and TCP/3268 (global catalog).
     
   Required for global catalog lookup to filter out invalid membership references.

## Naming convention for groups written back

By default, Microsoft Entra Connect Sync uses the following format when naming groups are written back:

- **Default format:** `CN=Group_&lt;guid&gt;,OU=&lt;container&gt;,DC=&lt;domain component&gt;,DC=\<domain component>`
- **Example:** `CN=Group_3a5c3221-c465-48c0-95b8-e9305786a271,OU=WritebackContainer,DC=contoso,DC=com`

To make it easier to find groups being written back from Microsoft Entra ID to Active Directory, Microsoft Entra Connect Sync added an option to write back the group name by using the cloud display name. To use this option, select **Writeback Group Distinguished Name with Cloud Display Name** during initial setup of Group Writeback v2. If this feature is enabled, Microsoft Entra Connect uses the following new format instead of the default format:

- **New format:** `CN=&lt;display name&gt;_&lt;last 12 digits of object ID&gt;,OU=&lt;container&gt;,DC=&lt;domain component&gt;,DC=\<domain component>`
- **Example:** `CN=Sales_e9305786a271,OU=WritebackContainer,DC=contoso,DC=com`

By default, Microsoft Entra Cloud Sync uses the new format, even if the Writeback Group Distinguished Name with Cloud Display Name feature isn't enabled in Microsoft Entra Connect Sync. If you use the default Microsoft Entra Connect Sync naming and then migrate the group so that it's managed by Microsoft Entra Cloud Sync, the group is renamed to the new format. Use the following section to allow Microsoft Entra Cloud Sync to use the default format from Microsoft Entra Connect.

### Use the default format

If you want Microsoft Entra Cloud Sync to use the same default format as Microsoft Entra Connect Sync, you need to modify the attribute flow expression for the `CN` attribute. The two possible mappings are:

|Expression|Syntax|Description|
|-----|-----|-----|
|Cloud sync default expression by using `DisplayName`|`Append(Append(Left(Trim([displayName]), 51), "_"), Mid([objectId], 25, 12))`|The default expression used by Microsoft Entra Cloud Sync (that is, the new format).|
|Cloud sync new expression without using `DisplayName`|`Append("Group_", [objectId])`|The new expression to use the default format from Microsoft Entra Connect Sync.|

For more information, see [Add an attribute mapping - Microsoft Entra ID to Active Directory](how-to-attribute-mapping.md#add-an-attribute-mapping---microsoft-entra-id-to-active-directory).

## Step 1: Copy adminDescription to msDS-ExternalDirectoryObjectID

To validate group membership references, Microsoft Entra Cloud Sync must query the Active Directory global catalog for the `msDS-ExternalDirectoryObjectID` attribute. This indexed attribute replicates across all global catalogs within the Active Directory forest.

1. In your on-premises environment, open **ADSI Edit**.

1. Copy the value that's in the group's `adminDescription` attribute.

   :::image type="content" source="media/migrate-group-writeback/migrate-1.png" alt-text="Screenshot that shows the adminDescription attribute." lightbox="media/migrate-group-writeback/migrate-1.png":::

1. Paste the value in the `msDS-ExternalDirectoryObjectID` attribute.

   :::image type="content" source="media/migrate-group-writeback/migrate-2.png" alt-text="Screenshot that shows the msDS-ExternalDirectoryObjectID attribute." lightbox="media/migrate-group-writeback/migrate-2.png":::

You can use the following PowerShell script to help automate this step. This script takes all of the groups in the `OU=Groups,DC=Contoso,DC=com` container and copies the `adminDescription` attribute value to the `msDS-ExternalDirectoryObjectID` attribute value. Before you use this script, update the variable `$gwbOU` with the `DistinguishedName` value of your group writeback's target organizational unit (OU).

```powershell

# Provide the DistinguishedName of your Group Writeback target OU
$gwbOU = 'OU=Groups,DC=Contoso,DC=com'

# Get all groups written back to Active Directory
$properties = @('displayName', 'Samaccountname', 'adminDescription', 'msDS-ExternalDirectoryObjectID')
$groups = Get-ADGroup -Filter * -SearchBase $gwbOU -Properties $properties | 
    Where-Object {$_.adminDescription -ne $null} |
        Select-Object $properties

# Set msDS-ExternalDirectoryObjectID for all groups written back to Active Directory 
foreach ($group in $groups) {
    Set-ADGroup -Identity $group.Samaccountname -Add @{('msDS-ExternalDirectoryObjectID') = $group.adminDescription}
} 

```

You can use the following PowerShell script to check the results of the preceding script. You can also confirm that all groups have the `adminDescription` value equal to the `msDS-ExternalDirectoryObjectID` value.

```powershell

# Provide the DistinguishedName of your Group Writeback target OU
$gwbOU = 'OU=Groups,DC=Contoso,DC=com'


# Get all groups written back to Active Directory
$properties = @('displayName', 'Samaccountname', 'adminDescription', 'msDS-ExternalDirectoryObjectID')
$groups = Get-ADGroup -Filter * -SearchBase $gwbOU -Properties $properties | 
    Where-Object {$_.adminDescription -ne $null} |
        Select-Object $properties

$groups | select displayName, adminDescription, 'msDS-ExternalDirectoryObjectID', @{Name='Equal';Expression={$_.adminDescription -eq $_.'msDS-ExternalDirectoryObjectID'}}

```

## Step 2: Place the Microsoft Entra Connect Sync server in staging mode and disable the sync scheduler

1. Start the Microsoft Entra Connect Sync wizard.
1. Select **Configure**.
1. Select **Configure staging mode** and select **Next**.
1. Enter Microsoft Entra credentials.
1. Select the **Enable staging mode** checkbox and select **Next**.
  
   :::image type="content" source="media/migrate-group-writeback/migrate-3.png" alt-text="Screenshot that shows enabling staging mode." lightbox="media/migrate-group-writeback/migrate-3.png":::
 
1. Select **Configure**.
1. Select **Exit**.

   :::image type="content" source="media/migrate-group-writeback/migrate-4.png" alt-text="Screenshot that shows staging mode success." lightbox="media/migrate-group-writeback/migrate-4.png":::

1. On your Microsoft Entra Connect server, open a PowerShell prompt as an administrator.
1. Disable the sync scheduler:

   ``` PowerShell 
   Set-ADSyncScheduler -SyncCycleEnabled $false  
   ``` 

## Step 3: Create a custom group inbound rule

In the Microsoft Entra Connect Synchronization Rules Editor, you create an inbound sync rule that filters out groups that have `NULL` for the mail attribute. The inbound sync rule is a join rule with a target attribute of `cloudNoFlow`. This rule tells Microsoft Entra Connect not to synchronize attributes for these groups. To create this sync rule, you can opt to use the user interface or create it via PowerShell with the provided script.

### Create a custom group inbound rule in the user interface

 1. On the **Start** menu, start the Synchronization Rules Editor.
 1. Under **Direction**, select **Inbound** from the dropdown list, and select **Add new rule**.
 1. On the **Description** page, enter the following values and select **Next**:

    - **Name**: Give the rule a meaningful name.
    - **Description**: Add a meaningful description.
    - **Connected System**: Choose the Microsoft Entra connector for which you're writing the custom sync rule.
    - **Connected System Object Type**: Select **group**.
    - **Metaverse Object Type**: Select **group**.
    - **Link Type**: Select **Join**.
    - **Precedence**: Provide a value that's unique in the system. We recommend that you use a value lower than 100 so that it takes precedence over the default rules.
    - **Tag:** Leave the field empty.

     :::image type="content" source="media/migrate-group-writeback/migrate-5.png" alt-text="Screenshot that shows the inbound sync rule." lightbox="media/migrate-group-writeback/migrate-5.png":::

1. On the **Scoping filter** page, add the following values and select **Next**:

   |Attribute|Operator|Value|
   |-----|----|----|
   |`cloudMastered`|`EQUAL`|`true`|
   |`mail`|`ISNULL`||
   

     :::image type="content" source="media/migrate-group-writeback/migrate-6.png" alt-text="Screenshot that shows the scoping filter." lightbox="media/migrate-group-writeback/migrate-6.png":::

1. On the **Join rules** page, select **Next**.
1. On the **Add transformations** page, for **FlowType**, select **Constant**. For **Target Attribute**, select **cloudNoFlow**. For **Source**, select **True**.

     :::image type="content" source="media/migrate-group-writeback/migrate-7.png" alt-text="Screenshot that shows adding transformations." lightbox="media/migrate-group-writeback/migrate-7.png":::

1. Select **Add**.

### Create a custom group inbound rule in PowerShell

1. On your Microsoft Entra Connect server, open a PowerShell prompt as an administrator.
1. Import the module.

   ``` PowerShell 
   Import-Module ADSync
   ```
1. Provide a unique value for the sync rule precedence (0-99).

   ``` PowerShell 
   [int] $inboundSyncRulePrecedence = 88
   ```
1. Run the following script:

   ``` PowerShell 
    New-ADSyncRule  `
    -Name 'In from AAD - Group SOAinAAD coexistence with Cloud Sync' `
    -Identifier 'e4eae1c9-b9bc-4328-ade9-df871cdd3027' `
    -Description 'https://learn.microsoft.com/entra/identity/hybrid/cloud-sync/migrate-group-writeback' `
    -Direction 'Inbound' `
    -Precedence $inboundSyncRulePrecedence `
    -PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
    -PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
    -SourceObjectType 'group' `
    -TargetObjectType 'group' `
    -Connector 'b891884f-051e-4a83-95af-2544101c9083' `
    -LinkType 'Join' `
    -SoftDeleteExpiryInterval 0 `
    -ImmutableTag '' `
    -OutVariable syncRule

    Add-ADSyncAttributeFlowMapping  `
    -SynchronizationRule $syncRule[0] `
    -Source @('true') `
    -Destination 'cloudNoFlow' `
    -FlowType 'Constant' `
    -ValueMergeType 'Update' `
    -OutVariable syncRule

    New-Object  `
    -TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
    -ArgumentList 'cloudMastered','true','EQUAL' `
    -OutVariable condition0

    New-Object  `
    -TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
    -ArgumentList 'mail','','ISNULL' `
    -OutVariable condition1

    Add-ADSyncScopeConditionGroup  `
    -SynchronizationRule $syncRule[0] `
    -ScopeConditions @($condition0[0],$condition1[0]) `
    -OutVariable syncRule

    Add-ADSyncRule  `
    -SynchronizationRule $syncRule[0]

    Get-ADSyncRule  `
    -Identifier 'e4eae1c9-b9bc-4328-ade9-df871cdd3027'
   ``` 

## Step 4: Create a custom group outbound rule

You also need an outbound sync rule with a link type of `JoinNoFlow` and the scoping filter that has the `cloudNoFlow` attribute set to `True`. This rule tells Microsoft Entra Connect not to synchronize attributes for these groups. To create this sync rule, you can opt to use the user interface or create it via PowerShell with the provided script.

### Create a custom group outbound rule in the user interface

 1. Under **Direction**, select **Outbound** from the dropdown list, and then select **Add rule**.
 1. On the **Description** page, enter the following values and select **Next**:

    - **Name**: Give the rule a meaningful name.
    - **Description**: Add a meaningful description.
    - **Connected System**: Choose the Active Directory connector for which you're writing the custom sync rule.
    - **Connected System Object Type**: Select **group**.
    - **Metaverse Object Type**: Select **group**.
    - **Link Type**: Select **JoinNoFlow**.
    - **Precedence**: Provide a value that's unique in the system. We recommend that you use a value lower than 100 so that it takes precedence over the default rules.
    - **Tag**: Leave the field empty.

    :::image type="content" source="media/migrate-group-writeback/migrate-8.png" alt-text="Screenshot that shows the outbound sync rule." lightbox="media/migrate-group-writeback/migrate-8.png":::

1. On the **Scoping filter** page, for **Attribute**, select **cloudNoFlow**. For **Operator** select **EQUAL**. For **Value**, select **True**. Then select **Next**.

     :::image type="content" source="media/migrate-group-writeback/migrate-9.png" alt-text="Screenshot that shows the outbound scoping filter." lightbox="media/migrate-group-writeback/migrate-9.png":::

1. On the **Join rules** page, select **Next**.
1. On the **Transformations** page, select **Add**.

### Create a custom group inbound rule in PowerShell

1. On your Microsoft Entra Connect server, open a PowerShell prompt as an administrator.
1. Import the module.

   ``` PowerShell 
   Import-Module ADSync
   ```
1. Provide a unique value for the sync rule precedence (0-99).

   ``` PowerShell 
   [int] $outboundSyncRulePrecedence = 89
   ```

1. Get the Active Directory connector for Group Writeback.

   ``` PowerShell 
   $connectorAD = Get-ADSyncConnector -Name "Contoso.com"
   ``` 

1. Run the following script:

   ``` PowerShell 
    New-ADSyncRule  `
    -Name 'Out to AD - Group SOAinAAD coexistence with Cloud Sync' `
    -Identifier '419fda18-75bb-4e23-b947-8b06e7246551' `
    -Description 'https://learn.microsoft.com/entra/identity/hybrid/cloud-sync/migrate-group-writeback' `
    -Direction 'Outbound' `
    -Precedence $outboundSyncRulePrecedence `
    -PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
    -PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
    -SourceObjectType 'group' `
    -TargetObjectType 'group' `
    -Connector $connectorAD.Identifier `
    -LinkType 'JoinNoFlow' `
    -SoftDeleteExpiryInterval 0 `
    -ImmutableTag '' `
    -OutVariable syncRule

    New-Object  `
    -TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
    -ArgumentList 'cloudNoFlow','true','EQUAL' `
    -OutVariable condition0

    Add-ADSyncScopeConditionGroup  `
    -SynchronizationRule $syncRule[0] `
    -ScopeConditions @($condition0[0]) `
    -OutVariable syncRule

    Add-ADSyncRule  `
    -SynchronizationRule $syncRule[0]

    Get-ADSyncRule  `
    -Identifier '419fda18-75bb-4e23-b947-8b06e7246551'
   ``` 

## Step 5: Use PowerShell to finish configuration

1. On your Microsoft Entra Connect server, open a PowerShell prompt as an administrator.
1. Import the `ADSync` module:

   ``` PowerShell 
   Import-Module ADSync
   ``` 

1. Run a full sync cycle:

   ``` PowerShell 
   Start-ADSyncSyncCycle -PolicyType Initial
   ``` 

1. Disable the Group Writeback feature for the tenant.

   > [!WARNING]
   > This operation is irreversible. After you disable Group Writeback v2, all Microsoft 365 groups are written back to Active Directory, independently of the **Writeback Enabled** setting in the Microsoft Entra admin center.
   ``` PowerShell 
   Set-ADSyncAADCompanyFeature -GroupWritebackV2 $false 
   ```
   
1. Run a full sync cycle again:

   ``` PowerShell 
   Start-ADSyncSyncCycle -PolicyType Initial
   ``` 

1. Reenable the sync scheduler:

   ``` PowerShell 
   Set-ADSyncScheduler -SyncCycleEnabled $true  
   ``` 

     :::image type="content" source="media/migrate-group-writeback/migrate-11.png" alt-text="Screenshot that shows PowerShell execution." lightbox="media/migrate-group-writeback/migrate-11.png":::

## Step 6: Remove the Microsoft Entra Connect Sync server from staging mode

1. Start the Microsoft Entra Connect Sync wizard.
1. Select **Configure**.
1. Select **Configure staging mode** and select **Next**.
1. Enter Microsoft Entra credentials.
1. Clear the **Enable staging mode** checkbox and select **Next**.
1. Select **Configure**.
1. Select **Exit**.

## Step 7: Configure Microsoft Entra Cloud Sync

Now that the groups are removed from the synchronization scope of Microsoft Entra Connect Sync, you can set up and configure Microsoft Entra Cloud Sync to take over synchronization of the security groups. For more information, see [Provision groups to Active Directory by using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md).

## Related content

- [Provision groups to Active Directory by using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md)
- [Govern on-premises Active Directory-based apps (Kerberos) by using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Provisioning to Active Directory with Microsoft Entra Cloud Sync FAQ](reference-provision-to-active-directory-faq.yml)
