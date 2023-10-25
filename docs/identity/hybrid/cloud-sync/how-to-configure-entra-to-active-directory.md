---
title: 'Provision groups to Active Directory using Microsoft Entra Cloud Sync'
description: This article describes how to configure Microsoft Entra Cloud Sync's Group Provision to AD with cloud sync.
services: active-directory
author: billmath
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.topic: how-to
ms.date: 10/12/2023
ms.subservice: hybrid
ms.author: billmath
ms.collection: M365-identity-device-management
---

# Provision groups to Active Directory using Microsoft Entra Cloud Sync

The following document will guide you through configuring cloud sync to synchronize groups to on-premises Active Directory.  This configuration document is specific to on-premises Microsoft Entra Cloud Sync's Group Provision to AD.  For information on a traditional on-premises to cloud configuration see [Configure and new installation - AD to Microsoft Entra ID](how-to-configure.md).

 :::image type="content" source="media/how-to-configure/new-ux-configure-19.png" alt-text="Screenshot of enable preview features." lightbox="media/how-to-configure/new-ux-configure-19.png":::

For additional information on this scenario, see [Govern on-premises application access with groups from the cloud]
(govern-on-premises-groups.md)

## Prerequisites
The following prerequisites are required to implement this scenario.

 - Azure AD account with at least a [Hybrid Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
 - On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later. 
     - Required for AD Schema attribute  - msDS-ExternalDirectoryObjectId 
 - Provisioning agent with build version [1.1.1367.0](reference-version-history.md#) or later.

 > [!NOTE]
 > The permissions to the service account are assigned during clean install only. In case you're upgrading from the previous version then permissions need to be assigned manually using PowerShell cmdlet: 
 > 
 > ```
 > $credential = Get-Credential  
 >
 >   Set-AADCloudSyncPermissions -PermissionType UserGroupCreateDelete -TargetDomain "FQDN of domain" -EACredential $credential
 >```
 >If the permissions are set manually, you need to ensure that Read, Write, Create, and Delete all properties for all descendent Groups and User objects. 
 >
 >These permissions are not applied to AdminSDHolder objects by default

 [Microsoft Entra Provisioning Agent gMSA PowerShell cmdlets](how-to-gmsa-cmdlets.md#grant-permissions-to-a-specific-domain) 

 - The provisioning agent must be able to communicate with the domain controller(s) on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
     - Required for global catalog lookup to filter out invalid membership references
 - Mircorosft Entra Connect with build version [2.2.8.0](../connect/reference-connect-version-history.md#2280) or later
     - Required to support on-premises user membership synchronized using Microsoft Entra Connect 
     - Required to synchronize AD:user:objectGUID to AAD:user:onPremisesObjectIdentifier

## Supported groups
For this scenario, only the following is supported:
  - only cloud created [Security groups](../../../fundamentals/concept-learn-about-groups.md#group-types) are supported
  - these groups can have assigned or dynamic membership.
  - these groups can only contain on-premises synchronized users and / or additional cloud created security groups.
  - the on-premises user accounts that are synchronized and are members of this cloud created security group, can be from the same domain or cross-domain, but they all must be from the same forest.
  - these groups are written back with the AD groups scope of [universal](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).  Your on-premises environment must support the universal group scope.
  - groups that are larger than 50,000 members are not supported.
  - each direct child nested group counts as one member in the referencing group

## License requirements
[!INCLUDE [entra-p1-license.md](~/includes/entra-p1-license.md)]



## Configure provisioning
To configure provisioning, follow these steps.

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]
 
 3. Select **New configuration**.
 4. Select **Microsoft Entra ID to AD sync**.

  :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png" alt-text="Screenshot of configuration selection." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png":::

 5. On the configuration screen, select your domain and whether to enable password hash sync.  Click **Create**.  
 
 :::image type="content" source="media/how-to-configure/new-ux-configure-2.png" alt-text="Screenshot of a new configuration." lightbox="media/how-to-configure/new-ux-configure-2.png":::

 6.  The **Get started** screen will open.  From here, you can continue configuring cloud sync.

  :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-2.png" alt-text="Screenshot of the configuration sections." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-2.png":::

 7. The configuration is split in to the following 3 sections.

   |Section|Description|
   |-----|-----|
   |1. Add [scoping filters](#scope-provisioning-to-specific-groups)|Use this section to define what objects appear in Microsoft Entra ID|
   |2. View [default properties](#accidental-deletions-and-email-notifications)|View the default setting prior to enabling them and make changes where appropriate|
   |3. Enable [your configuration](#enable-your-configuration)|Once ready, enable the configuration and users/groups will begin synchronizing|

## Scope provisioning to specific groups
You can scope the agent to synchronize all or specific security groups. You can configure groups and organizational units within a configuration. 
 
 1.  On the **Getting started** configuration screen.  Click either **Add scoping filters** next to the **Add scoping filters** icon or on the click **Scoping filters** on the left under **Manage**.

  :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png" alt-text="Screenshot of the scoping filters sections." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png":::
 
 2. Select the scoping filter. The filter can be one of the following:
     - **All security groups**: Scopes the configuration to apply to all cloud security groups.
     - **Selected security groups**: Scopes the configuration to apply to specific security groups.

 3. For specific security groups select **Edit groups** and pick your desired groups from the list.

 >[!NOTE]
 >If you select a security group that has a nested security group as its member, then only the nested group will be written back and not it's members.  For example, if a Sales security group is a member of the Marketing security group, only the Sales group itself will be written back and not the members of the Sales group.
 >
 >If you want to nest groups and provision them AD, then you will need to add all of the member groups to the scope also.

 4.  You can use the **Target Container** box to scope groups that use a specific container.  This is done by using the parentDistinguishedName attribute. This is done by using either a constant, direct, or expression mapping.
 
  Multiple target containers can be configured using an attribute mapping expression with the Switch() function.  With this expression, if the displayName value is Marketing or Sales, the group is created in the corresponding OU. If there's no match, then the group is created in the default OU.

  ```Switch([displayName],"OU=Default,OU=container,DC=contoso,DC=com","Marketing","OU=Marketing,OU=container,DC=contoso,DC=com","Sales","OU=Sales,OU=container,DC=contoso,DC=com")  ```

  :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-4.png" alt-text="Screenshot of the scoping filters expression." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-4.png":::

 5. Attribute based scope filtering is supported.  For more information see [Attribute based scope filtering](#attribute-scope-filtering)
 4. Once your scoping filters are configured, click **Save**.
 5. After saving, you should see a message telling you what you still need to do to configure cloud sync.  You can click the link to continue.
 :::image type="content" source="media/how-to-configure/new-ux-configure-16.png" alt-text="Screenshot of the nudge for scoping filters." lightbox="media/how-to-configure/new-ux-configure-16.png":::


## Attributes and attribute based scope filtering
You can customize the default attribute-mappings according to your business needs. So, you can change or delete existing attribute-mappings, or create new attribute-mappings.  

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png" alt-text="Screenshot of the attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png":::

### Schema for Entra ID to AD configurations
Currently, the AD Schema is not discoverable and there is fixed set of mappings.  The following table provides the default mappings and schema for the Entra ID to AD configurations.

|Target attribute|Source attribute|Mapping type|Notes|
|-----|-----|-----|-----|
|adminDescription|Append("Group_",[objectId])|Expression|CANNOT UPDATE IN UI - SHOULD NOT UPDATE</br></br>Used for filtering out AD to cloud sync</br></br>Not visible in UI|
|cn|Append(Append(Left(Trim([displayName]),51),"_"),Mid([objectId],25,12))|Expression||
|description|Left(Trim([description]),448)|Expression||
|dispalyName|displayName|Direct||
|isSecurityGroup|True|Constant|CANNOT UPDATE IN UI - SHOULD NOT UPDATE</br></br>Not visible in UI|
|member|members|Direct|CANNOT UPDATE IN UI - SHOULD NOT UPDATE|
|msDS-ExternalDirectoryObjectId|Append("Group_",[objectId])|Expression|CANNOT UPDATE IN UI - SHOULD NOT UPDATE</br></br>Used for joining - matching in AD</br></br>Not visible in UI|
|ObjectGUID|||CANNOT UPDATE IN UI - SHOULD NOT UPDATE</br></br>Read only - anchor in AD</br></br>Not visible in UI|
|parentDistinguishedName|OU=Users,DC=&lt;domain selected at configuration start&gt;,DC=com|Constant|Default in the UI</br></br>Not visible in UI|
|UniversalScope|True|Constant|CANNOT UPDATE IN UI - SHOULD NOT UPDATE</br></br>Not visible in UI|

Be aware that not all of the above mappings are visible in the portal.  For more information on how to add an attribute mapping see, see [attribute mapping](how-to-attribute-mapping.md#add-an-attribute-mapping---microsoft-entra-id-to-ad).


### Attribute scope filtering
Attribute based scope filtering is supported.  This allows you to scope groups based on certain attributes.  However, be aware that the attribute mapping section for a Microsoft Entra ID to AD configuration is slightly different than the traditional attribute mapping section.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png" alt-text="Screenshot of the attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-6.png":::

#### Supported clauses

A scoping filter consists of one or more clauses. Clauses determine which groups are allowed to pass through the scoping filter by evaluating each group's attributes. For example, you might have one clause that requires that a groups  "displayName" attribute equals "Marketing", so only Marketing groups are provisioned.

#### The default security grouping
The default security grouping is applied on top of every clause created and uses the "AND" logic. It contains the following conditions:
  - securityEnabled IS True AND 
  - dirSyncEnabled IS FALSE AND 
  - mailEnabled IS FALSE
  
The default security grouping is ALWAYS applied first and uses the AND logic when working with a single clause.   Clause will then follow the logic outlined below.

A single clause defines a single condition for a single attribute value. If multiple clauses are created in a single scoping filter, they're evaluated together using "AND" logic. The "AND" logic means all clauses must evaluate to "true" in order for a user to be provisioned.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-8.png" alt-text="Screenshot of AND clause attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-8.png":::

Finally, multiple scoping filters can be created for a group. If multiple scoping filters are present, they're evaluated together by using "OR" logic. The "OR" logic means that if either of the clauses in any of the configured scoping filters evaluate to "true", the group is provisioned.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-9.png" alt-text="Screenshot of OR clause attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-9.png":::


#### Supported operators
The following operators are supported:

|Operator|Description|
|-----|-----|
|&||
|ENDS_WITH||
|EQUALS|Clause returns "true" if the evaluated attribute matches the input string value exactly (case sensitive).|
|GREATER_THAN|Clause returns "true" if the evaluated attribute is greater than the value. The value specified on the scoping filter must be an integer and the attribute on the user must be an integer [0,1,2,...].|
|GREATER_THAN_OR_EQUALS| Clause returns "true" if the evaluated attribute is greater than or equal to the value. The value specified on the scoping filter must be an integer and the attribute on the user must be an integer [0,1,2,...].|
|INCLUDES||
|IS FALSE| Clause returns "true" if the evaluated attribute contains a Boolean value of false.|
|IS_MEMBER_OF||
|IS NOT NULL|Clause returns "true" if the evaluated attribute is not empty.|
|IS NULL|Clause returns "true" if the evaluated attribute is empty.|
|IS TRUE|Clause returns "true" if the evaluated attribute contains a Boolean value of true.|
|!&L||
|NOT EQUALS|Clause returns "true" if the evaluated attribute doesn't match the input string value (case sensitive).|
|NOT REGEX MATCH|Clause returns "true" if the evaluated attribute doesn't match a regular expression pattern. It returns "false" if the attribute is null / empty.|
|PRESENT||
|REGEX MATCH|Clause returns "true" if the evaluated attribute matches a regular expression pattern. For example: ([1-9][0-9]) matches any number between 10 and 99 (case sensitive).|
|VALID CERT MATCH||

#### Create an attribute based filter
To create an attribute based filter use the following steps:

1.  Click **Add attribute filter**
2.  In the **Name** box, provide a name for your filter
3.  From the drop-down, under **Target attribute** select the target attribute
4.  Under **Operator**, select an operator.
5.  Under **Value**, specify a value.
6.  Click **Save**.

:::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-7.png" alt-text="Screenshot of the setting up attribute based scoping." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-7.png":::

For more information, see [attribute mapping](how-to-attribute-mapping.md#add-an-attribute-mapping---microsoft-entra-id-to-ad).


## On-demand provisioning
Microsoft Entra Connect cloud sync allows you to test configuration changes, by applying these changes to a group.  

You can use this to validate and verify that the changes made to the configuration were applied properly and are being correctly synchronized to Microsoft Entra ID.  

The following is true with regrad to on-demand provisioning of groups:
- On-demand provisioning of groups supports updating up to five members at a time.
- On-demand provisioning doesn't support deleting groups that have been deleted from Microsoft Entra ID. Those groups don't appear when you search for a group.
- On-demand provisioning doesn't support nested groups that aren't directly assigned to the application.
- The on-demand provisioning request API can only accept a single group with up to 5 members at a time.


### Verify a group
To use on-demand provisioning, follow these steps:

>[!NOTE]
>When using on-demand provisioning, members are not automatically provsisioned.  You need to select which members you wish to test on and there is a 5 member limit.

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]

 3. Under **Configuration**, select your configuration.
 4. On the left, select **Provision on demand**.
 5. Enter the name of the group in the **Selected group** box
 6. From the **Selected users** section, select some users to test.
 
   :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-10.png" alt-text="Screenshot of adding members." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-10.png":::

 7. Click **Provision**.
 8. You should see the group provisioned.
 
   :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-11.png" alt-text="Screenshot of successful provisioning on demand." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-11.png":::


For more information, see [on-demand provisioning](how-to-on-demand-provision.md).

## Accidental deletions and email notifications
The accidental delete feature is designed to protect you from accidental configuration changes and changes to your on-premises directory that would affect many users and groups.  

This feature allows you to:

- configure the ability to prevent accidental deletes automatically. 
- Set the # of objects (threshold) beyond which the configuration will take effect 
- set up a notification email address so they can get an email notification once the sync job in question is put in quarantine for this scenario 

For more information, see [Accidental deletes](how-to-accidental-deletes.md)

## Enable your configuration
Once you've finalized and tested your configuration, you can enable it.  Click **Enable configuration** to enable it.


## Provisioning logs and quarantines
Cloud sync monitors the health of your configuration and places unhealthy objects in a quarantine state. If most or all of the calls made against the target system consistently fail because of an error, for example, invalid admin credentials, the sync job is marked as in quarantine.  For more information, see the troubleshooting section on [quarantines](how-to-troubleshoot.md#provisioning-quarantined-problems).

Provisioning logs are available and can be used to provide information and assist in troubleshooting.

   :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-11.png" alt-text="Screenshot of successful provisioning on demand." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-11.png":::

For more information on provisioning logs, see [Enabling provisioning logs](how-to-cloud-sync-workbook.md#enabling-provisioning-logs)



## Next steps 

- [What is provisioning?](../what-is-provisioning.md)
- [What is Microsoft Entra Connect cloud sync?](what-is-cloud-sync.md)
