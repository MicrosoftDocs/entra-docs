---
title: Connectors in the Microsoft Entra Connect Sync Service Manager UI'
description: Understand the Connectors tab in the Service Manager for Microsoft Entra Connect Sync.
author: omondiatieno
manager: mwongerapk
ms.assetid: 60f1d979-8e6d-4460-aaab-747fffedfc1e
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi
ms.custom: H1Hack27Feb2017, sfi-image-nochange
---
# Using connectors with the Microsoft Entra Connect Sync Service Manager

![Screenshot that shows the Microsoft Entra Connect Sync Service Manager.](./media/how-to-connect-sync-service-manager-ui-connectors/connectors.png)

The Connectors tab is used to manage all systems the sync engine is connected to.

## Connector actions
| Action | Comment |
| --- | --- |
| Create |Not supported. For connecting additional AD forests, use the configuration wizard. |
| Properties |Read-only. Connector properties for connectivity, domain and OU filtering and attribute selection and anchors. |
| Delete |Not supported. For removing AD forests, reinstall the Microsoft Entra Connect product.|
| [Configure Run Profiles](#configure-run-profiles) |Read-only. Connector run profiles.|
| Run |Starts a one-off connector run profile.|
| Stop |Stops a connector run profile.|
| Export Connector |Read-only. Exports the connector configuration.|
| Import Connector |Not supported. |
| Update Connector |Not supported. |
| Refresh Schema |Not supported. Use the "Refresh directory schema" task in the configuration wizard which also updates sync rules.|
| [Search Connector Space](#search-connector-space) |Finds objects and shows object data across the Metaverse and other connected sources.|



### Configure Run Profiles
This option allows you to see the run profiles configured for a Connector.

![Screenshot that shows the "Configure Run Profiles" window with "Delta Import" selected.](./media/how-to-connect-sync-service-manager-ui-connectors/configurerunprofiles.png)

### Search Connector Space
The search connector space action is useful to find objects and troubleshoot data issues.

![Screenshot that shows the "Search Connector Space" window.](./media/how-to-connect-sync-service-manager-ui-connectors/cssearch.png)

Start by selecting a **scope**. You can search based on data (RDN, DN, Anchor, Sub-Tree), or state of the object (all other options).  
![Screenshot that shows the "Scope" drop-down menu.](./media/how-to-connect-sync-service-manager-ui-connectors/cssearchscope.png)  
If you, for example, do a Sub-Tree search, you get all objects in one OU.  
![Screenshot that shows an example of a "Sub-Tree" search.](./media/how-to-connect-sync-service-manager-ui-connectors/cssearchsubtree.png)  
From this grid you can select an object, select **properties**, and [follow it](tshoot-connect-object-not-syncing.md) from the source connector space, through the metaverse, and to the target connector space.

### Changing the AD DS account password
If you change the account password, the Synchronization Service will no longer be able to import/export changes to on-premises AD.   You may see the following:

- The import/export step for the AD connector fails with "no-start-credentials" error.
- Under Windows Event Viewer, the application event log contains an error with Event ID 6000 and message “The management agent “contoso.com” failed to run because the credentials were invalid.”

To resolve the issue, update the AD DS user account using the following:


1. Start the Synchronization Service Manager (START → Synchronization Service).
</br>![Sync Service Manager](./media/how-to-connect-sync-service-manager-ui-connectors/startmenu.png)
2. Go to the **Connectors** tab.
3. Select the AD Connector which is configured to use the AD DS account.
4. Under Actions, select **Properties**.
5. In the pop-up dialog, select Connect to Active Directory Forest:
6. The Forest name indicates the corresponding on premises AD.
7. The User name indicates the AD DS account used for synchronization.
1. Enter the new password of the AD DS account in the Password textbox
![Microsoft Entra Connect Sync Encryption Key Utility](./media/how-to-connect-sync-service-manager-ui-connectors/key6.png)
9. Select OK to save the new password and restart the Synchronization Service to remove the old password from memory cache.



## Next steps
Learn more about the [Microsoft Entra Connect Sync](how-to-connect-sync-whatis.md) configuration.

Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).
