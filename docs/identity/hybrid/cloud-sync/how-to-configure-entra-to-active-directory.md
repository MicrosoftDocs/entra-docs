---
title: 'Configure - Provisioning Microsoft Entra ID to Active Directory using Microsoft Entra Cloud Sync'
description: This article describes how to configure Microsoft Entra Cloud Sync's Group Provision to AD with cloud sync.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: jomondi
ms.custom: sfi-image-nochange
---

# Provision Microsoft Entra ID to Active Directory - Configuration
The following document will guide you through configuring Microsoft Entra Cloud Sync for provisioning from Microsoft Entra ID to Active Directory. If you are looking for information on provisioning from AD to Microsoft Entra ID, see [ Configure - Provisioning Active Directory to Microsoft Entra ID using Microsoft Entra Cloud Sync](how-to-configure.md)

[!INCLUDE [deprecation](~/includes/gwb-v2-deprecation.md)]


## Configure provisioning
To configure provisioning, follow these steps.

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]
 
 3. Select **New configuration**.
 4. Select **Microsoft Entra ID to AD sync**.

 :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png" alt-text="Screenshot of configuration selection." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png":::

 5. On the configuration screen, select your domain and whether to enable password hash sync. Click **Create**. 
 
 :::image type="content" source="media/how-to-configure/new-ux-configure-2.png" alt-text="Screenshot of a new configuration." lightbox="media/how-to-configure/new-ux-configure-2.png":::

 6. The **Get started** screen will open. From here, you can continue configuring cloud sync.

 :::image type="content" source="media/how-to-configure-entra-to-active-directory/config-1.png" alt-text="Screenshot of the configuration sections." lightbox="media/how-to-configure-entra-to-active-directory/config-1.png":::

 7. The configuration is split in to the following 5 sections.

  |Section|Description|
  |-----|-----|
  |1. Add [scoping filters](#scope-provisioning-to-specific-groups)|Use this section to define what objects appear in Microsoft Entra ID|
  |2. Map [attributes](#attribute-mapping)|Use this section to map attributes between your on-premises users/groups with Microsoft Entra objects|
  |3. [Test](#on-demand-provisioning)|Test your configuration before deploying it|
  |4. View [default properties](#accidental-deletions-and-email-notifications)|View the default setting prior to enabling them and make changes where appropriate|
  |5. Enable [your configuration](#enable-your-configuration)|Once ready, enable the configuration and users/groups will begin synchronizing|

## Scope provisioning to specific groups
You can scope the agent to synchronize all or specific security groups. 

For more information see [Attribute based scope filtering](how-to-attribute-mapping-entra-to-active-directory.md#attribute-scope-filtering) and [Reference for writing expressions for attribute mappings in Microsoft Entra ID](../../app-provisioning/functions-for-customizing-application-data.md) and [Scenario - Using directory extensions with group provisioning to Active Directory](tutorial-directory-extension-group-provisioning.md).


You can configure groups and organizational units within a configuration. 

 1. On the **Getting started** configuration screen. Click either **Add scoping filters** next to the **Add scoping filters** icon or on the click **Scoping filters** on the left under **Manage**.

 :::image type="content" source="media/how-to-configure-entra-to-active-directory/config-2.png" alt-text="Screenshot of the scoping filters sections." lightbox="media/how-to-configure-entra-to-active-directory/config-2.png":::
 
 2. Select the scoping filter. The filter can be one of the following:
   - **All security groups**: Scopes the configuration to apply to all cloud security groups.
   - **Selected security groups**: Scopes the configuration to apply to specific security groups.

 3. For specific security groups select **Edit groups** and pick your desired groups from the list.

 >[!NOTE]
 >If you select a security group that has a nested security group as its member, then only the nested group will be written back and not it's members. For example, if a Sales security group is a member of the Marketing security group, only the Sales group itself will be written back and not the members of the Sales group.
 >
 >If you want to nest groups and provision them AD, then you will need to add all of the member groups to the scope also.

 4. You can use the **Target Container** box to scope groups that use a specific container. Accomplish this task by using the parentDistinguishedName attribute. Use either a constant, direct, or expression mapping.
 
 Multiple target containers can be configured using an attribute mapping expression with the Switch() function. With this expression, if the displayName value is Marketing or Sales, the group is created in the corresponding OU. If there's no match, then the group is created in the default OU.

 ```Switch([displayName],"OU=Default,OU=container,DC=contoso,DC=com","Marketing","OU=Marketing,OU=container,DC=contoso,DC=com","Sales","OU=Sales,OU=container,DC=contoso,DC=com") ```

 :::image type="content" source="media/how-to-configure-entra-to-active-directory/config-6.png" alt-text="Screenshot of the scoping filters expression." lightbox="media/how-to-configure-entra-to-active-directory/config-6.png":::

 5. Attribute based scope filtering is supported. For more information see [Attribute based scope filtering](how-to-attribute-mapping-entra-to-active-directory.md#attribute-scope-filtering) and [Reference for writing expressions for attribute mappings in Microsoft Entra ID](../../app-provisioning/functions-for-customizing-application-data.md) and [Scenario - Using directory extensions with group provisioning to Active Directory](tutorial-directory-extension-group-provisioning.md).
 4. Once your scoping filters are configured, click **Save**.
 5. After saving, you should see a message telling you what you still need to do to configure cloud sync. You can click the link to continue.
 :::image type="content" source="media/how-to-configure/new-ux-configure-16.png" alt-text="Screenshot of the nudge for scoping filters." lightbox="media/how-to-configure/new-ux-configure-16.png":::

 ### Scope provisioning to specific groups using directory extensions
 For more advanced scoping and filtering, you can configure the use of directory extensions.  For an overview of directory extensions see [Directory extensions for provisioning Microsoft Entra ID to Active Directory](custom-attribute-mapping-entra-to-active-directory.md)

For a step-by-step tutorial on how to extend the schema and then use the directory extension attribute with cloud sync provisioning to AD, see [Scenario - Using directory extensions with group provisioning to Active Directory](tutorial-directory-extension-group-provisioning.md).

## Attribute mapping
Microsoft Entra Cloud Sync allows you to easily map attributes between your on-premises user/group objects and the objects in Microsoft Entra ID. 

 :::image type="content" source="media/how-to-configure-entra-to-active-directory/config-3.png" alt-text="Screenshot of the default attribute mappings." lightbox="media/how-to-configure-entra-to-active-directory/config-3.png":::


You can customize the default attribute-mappings according to your business needs. So, you can change or delete existing attribute-mappings, or create new attribute-mappings. 

After saving, you should see a message telling you what you still need to do to configure cloud sync. You can click the link to continue.

For more information, see [attribute mapping](how-to-attribute-mapping-entra-to-active-directory.md) and [Reference for writing expressions for attribute mappings in Microsoft Entra ID](../../app-provisioning/functions-for-customizing-application-data.md).

## Directory extensions and custom attribute mapping.
Microsoft Entra Cloud Sync allows you to extend the directory with extensions and provides for custom attribute mapping. For more information see [Directory extensions and custom attribute mapping](custom-attribute-mapping.md).

## On-demand provisioning
Microsoft Entra Cloud Sync allows you to test configuration changes, by applying these changes to a single user or group. 

 :::image type="content" source="media/how-to-configure-entra-to-active-directory/config-5.png" alt-text="Screenshot of the provisioning on-demand." lightbox="media/how-to-configure-entra-to-active-directory/config-5.png":::

You can use this to validate and verify that the changes made to the configuration were applied properly and are being correctly synchronized to Microsoft Entra ID. 

After testing, you should see a message telling you what you still need to do to configure cloud sync. You can click the link to continue.

For more information, see [on-demand provisioning](how-to-on-demand-provision-entra-to-active-directory.md).

## Accidental deletions and email notifications
The default properties section provides information on accidental deletions and email notifications.



The accidental delete feature is designed to protect you from accidental configuration changes and changes to your on-premises directory that would affect many users and groups. 

This feature allows you to:

- Configure the ability to prevent accidental deletes automatically. 
- Set the # of objects (threshold) beyond which the configuration will take effect 
- Set up a notification email address so they can get an email notification once the sync job in question is put in quarantine for this scenario 

For more information, see [Accidental deletes](how-to-accidental-deletes.md)

Click the **pencil** next to **Basics** to change the defaults in a configuration.


## Enable your configuration
Once you've finalized and tested your configuration, you can enable it.


Click **Enable configuration** to enable it.



## Quarantines
Cloud sync monitors the health of your configuration and places unhealthy objects in a quarantine state. If most or all of the calls made against the target system consistently fail because of an error, for example, invalid admin credentials, the sync job is marked as in quarantine. For more information, see the troubleshooting section on [quarantines](how-to-troubleshoot.md#provisioning-quarantined-problems).

## Restart provisioning 
If you don't want to wait for the next scheduled run, trigger the provisioning run by using the **Restart sync** button. 
 [!INCLUDE [sign in](~/includes/cloud-sync-sign-in.md)]
 4. Under **Configuration**, select your configuration.



 5. At the top, select **Restart sync**.

## Remove a configuration
To delete a configuration, follow these steps.

 [!INCLUDE [sign in](~/includes/cloud-sync-sign-in.md)]
 3. Under **Configuration**, select your configuration.



 4. At the top of the configuration screen, select **Delete configuration**.

>[!IMPORTANT]
>There's no confirmation prior to deleting a configuration. Make sure this is the action you want to take before you select **Delete**.















## Next steps 
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)
- [Scoping filter and attribute mapping - Microsoft Entra ID to Active Directory](how-to-attribute-mapping-entra-to-active-directory.md)