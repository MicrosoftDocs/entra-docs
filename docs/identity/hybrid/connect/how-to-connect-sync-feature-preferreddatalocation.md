---
title: 'Microsoft Entra Connect: Configure preferred data location for Microsoft 365 resources'
description: Describes how to put your Microsoft 365 user resources close to the user with Microsoft Entra Connect Sync.
author: billmath
ms.service: entra-id
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
manager: amycolannino
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath

---
# Microsoft Entra Connect Sync: Configure preferred data location for Microsoft 365 resources
The purpose of this topic is to walk you through how to configure the attribute for preferred data location in Microsoft Entra Connect Sync. When someone uses Multi-Geo capabilities in Microsoft 365, you use this attribute to designate the geo-location of the user’s Microsoft 365 data. (The terms *region* and *geo* are used interchangeably.)

## Supported Multi-Geo locations
For a list of all geos supported by Microsoft Entra Connect see [Microsoft 365 Multi-Geo availability](/microsoft-365/enterprise/microsoft-365-multi-geo#microsoft-365-multi-geo-availability)

## Enable synchronization of preferred data location
By default, Microsoft 365 resources for your users are located in the same geo as your Microsoft Entra tenant. For example, if the *Tenant* is located in North America, then the users' Exchange mailboxes are also located in North America. For a multinational organization, this might not be optimal.

By setting the attribute **preferredDataLocation**, you can define a user's geo. You can have the user's Microsoft 365 resources, such as the mailbox and OneDrive, in the same geo as the user, and still have one tenant for your entire organization.

> [!IMPORTANT]
> As of June 1, 2023, Multi-Geo is available for CSP partners to purchase, at a minimum of 5% of their customer’s total Microsoft 365 subscription seats. 
> 
> Multi-Geo is also available to customers with an active Enterprise Agreement. Please talk to your Microsoft representative for details.
>
> For a list of all geos supported by Microsoft Entra Connect see [Microsoft 365 Multi-Geo availability](/microsoft-365/enterprise/microsoft-365-multi-geo#microsoft-365-multi-geo-availability).




<a name='azure-ad-connect-support-for-synchronization'></a>

### Microsoft Entra Connect support for synchronization

Microsoft Entra Connect supports synchronization of the **preferredDataLocation** attribute for **User** objects in version 1.1.524.0 and later. Specifically:

* The schema of the object type **User** in the Microsoft Entra Connector is extended to include the **preferredDataLocation** attribute. The attribute is of the type, single-valued string.
* The schema of the object type **Person** in the metaverse is extended to include the **preferredDataLocation** attribute. The attribute is of the type, single-valued string.

By default, **preferredDataLocation** is not enabled for synchronization. This feature is intended for larger organizations. The Active Directory schema in Windows Server 2019 has an attribute **msDS-preferredDataLocation** you should use for this purpose. If you have not updated the Active Directory schema and cannot do so, then you must identify an attribute to hold the Microsoft 365 geo for your users. This is going to be different for each organization.

> [!IMPORTANT]
> Microsoft Entra ID allows the **preferredDataLocation** attribute on **cloud User objects** to be directly configured by using [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview). To configure this attribute on **synchronized User objects**, you must use Microsoft Entra Connect.

Before enabling synchronization:

* If you have not upgraded the Active Directory schema to 2019, then decide which on-premises Active Directory attribute to be used as the source attribute. It should be of the type, **single-valued string**.
* If you have previously configured the **preferredDataLocation** attribute on existing **synchronized User objects** in Microsoft Entra ID by using Microsoft Graph PowerShell, you must backport the attribute values to the corresponding **User** objects in on-premises Active Directory.

    > [!IMPORTANT]
    > If you do not backport these values, Microsoft Entra Connect removes the existing attribute values in Microsoft Entra ID when synchronization for the **preferredDataLocation** attribute is enabled.

* Configure the source attribute on at least a couple of on-premises Active Directory User objects now. You can use this for verification later.

The following sections provide the steps to enable synchronization of the **preferredDataLocation** attribute.

> [!NOTE]
> The steps are described in the context of a Microsoft Entra deployment with single-forest topology, and without custom synchronization rules. If you have a multi-forest topology, custom synchronization rules configured, or have a staging server, you should adjust the steps accordingly.

## Step 1: Disable sync scheduler and verify there is no synchronization in progress
To avoid unintended changes being exported to Microsoft Entra ID, ensure that no synchronization takes place while you are in the middle of updating synchronization rules. To disable the built-in sync scheduler:

1. Start a PowerShell session on the Microsoft Entra Connect server.
2. Disable scheduled synchronization by running this cmdlet: `Set-ADSyncScheduler -SyncCycleEnabled $false`.
3. Start the **Synchronization Service Manager** by going to **START** > **Synchronization Service**.
4. Select the **Operations** tab, and confirm there is no operation with the status *in progress*.

![Screenshot of Synchronization Service Manager](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-step1.png)

## Step 2: Refresh the schema for Active Directory
If you have updated the Active Directory schema to 2019 and Connect was installed before the schema extension, then the Connect schema cache does not have the updated schema. You must then refresh the schema from the wizard for it to appear in the UI.

1. Start the Microsoft Entra Connect wizard from the desktop.
2. Select the option **Refresh directory schema** and click **Next**.
3. Enter your Microsoft Entra credentials and click **Next**.
4. On the **Refresh Directory Schema** page, make sure all forests are selected and click **Next**.
5. When completed, close the wizard.

![Screenshot of Refresh Directory Schema in the Connect wizard](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-refreshschema.png)

## Step 3: Add the source attribute to the on-premises Active Directory Connector schema
**This step is only needed if you run Connect version 1.3.21 or older. If you are on 1.4.18 or newer, then skip to step 5.**  
Not all Microsoft Entra attributes are imported into the on-premises Active Directory connector space. If you have selected to use an attribute that is not synchronized by default, then you need to import it. To add the source attribute to the list of the imported attributes:

1. Select the **Connectors** tab in the Synchronization Service Manager.
2. Right-click the on-premises Active Directory Connector, and select **Properties**.
3. In the pop-up dialog box, go to the **Select Attributes** tab.
4. Make sure the source attribute you selected to use is checked in the attribute list. If you do not see your attribute, select the **Show All** check box.
5. To save, select **OK**.

![Screenshot that shows the Synchronization Service Manager and Properties dialog box with the "Attributes" list highlighted.](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-step2.png)

<a name='step-4-add-preferreddatalocation-to-the-azure-ad-connector-schema'></a>

## Step 4: Add **preferredDataLocation** to the Microsoft Entra Connector schema
**This step is only needed if you run Connect version 1.3.21 or older. If you are on 1.4.18 or newer, then skip to step 5.**  
By default, the **preferredDataLocation** attribute is not imported into the Microsoft Entra Connector space. To add it to the list of imported attributes:

1. Select the **Connectors** tab in the Synchronization Service Manager.
2. Right-click the Microsoft Entra connector, and select **Properties**.
3. In the pop-up dialog box, go to the **Select Attributes** tab.
4. Select the **preferredDataLocation** attribute in the list.
5. To save, select **OK**.

![Screenshot of Synchronization Service Manager and Properties dialog box](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-step3.png)

## Step 5: Create an inbound synchronization rule
The inbound synchronization rule permits the attribute value to flow from the source attribute in on-premises Active Directory to the metaverse.

1. Start the **Synchronization Rules Editor** by going to **START** > **Synchronization Rules Editor**.
2. Set the search filter **Direction** to be **Inbound**.
3. To create a new inbound rule, select **Add new rule**.
4. Under the **Description** tab, provide the following configuration:

    | Attribute | Value | Details |
    | --- | --- | --- |
    | Name | *Provide a name* | For example, “In from AD – User preferredDataLocation” |
    | Description | *Provide a custom description* |  |
    | Connected System | *Pick the on-premises Active Directory Connector* |  |
    | Connected System Object Type | **User** |  |
    | Metaverse Object Type | **Person** |  |
    | Link Type | **Join** |  |
    | Precedence | *Choose a number between 1–99* | 1–99 is reserved for custom sync rules. Do not pick a value that is used by another synchronization rule. |

5. Keep the **Scoping filter** empty, to include all objects. You might need to tweak the scoping filter according to your Microsoft Entra Connect deployment.
6. Go to the **Transformation tab**, and implement the following transformation rule:

    | Flow type | Target attribute | Source | Apply once | Merge type |
    | --- | --- | --- | --- | --- |
    |Direct | preferredDataLocation | Pick the source attribute | Unchecked | Update |

7. To create the inbound rule, select **Add**.

![Screenshot of Create inbound synchronization rule](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-step4.png)

## Step 6: Create an outbound synchronization rule
The outbound synchronization rule permits the attribute value to flow from the metaverse to the **preferredDataLocation** attribute in Microsoft Entra ID:

1. Go to the **Synchronization Rules Editor**.
2. Set the search filter **Direction** to be **Outbound**.
3. Select **Add new rule**.
4. Under the **Description** tab, provide the following configuration:

    | Attribute | Value | Details |
    | ----- | ------ | --- |
    | Name | *Provide a name* | For example, “Out to Microsoft Entra ID – User preferredDataLocation” |
    | Description | *Provide a description* ||
    | Connected System | *Select the Microsoft Entra Connector* ||
    | Connected System Object Type | **User** ||
    | Metaverse Object Type | **Person** ||
    | Link Type | **Join** ||
    | Precedence | *Choose a number between 1–99* | 1–99 is reserved for custom sync rules. Do not pick a value that is used by another synchronization rule. |

5. Go to the **Scoping filter** tab, and add a single scoping filter group with two clauses:

    | Attribute | Operator | Value |
    | --- | --- | --- |
    | sourceObjectType | EQUAL | User |
    | cloudMastered | NOTEQUAL | True |

    Scoping filter determines which Microsoft Entra objects this outbound synchronization rule is applied to. In this example, we use the same scoping filter from “Out to Microsoft Entra ID – User Identity” OOB (out-of-box) synchronization rule. It prevents the synchronization rule from being applied to **User** objects that are not synchronized from an on-premises Active Directory. You might need to tweak the scoping filter according to your Microsoft Entra Connect deployment.

6. Go to the **Transformation** tab, and implement the following transformation rule:

    | Flow type | Target attribute | Source | Apply once | Merge type |
    | --- | --- | --- | --- | --- |
    | Direct | preferredDataLocation | preferredDataLocation | Unchecked | Update |

7. Close **Add** to create the outbound rule.

![Screenshot of Create outbound synchronization rule](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-step5.png)

## Step 7: Run full synchronization cycle
In general, full synchronization cycle is required. This is because you have added new attributes to both the Active Directory and Microsoft Entra Connector schema, and introduced custom synchronization rules. Verify the changes before exporting them to Microsoft Entra ID. You can use the following steps to verify the changes, while manually running the steps that make up a full synchronization cycle.

1. Run **Full import** on the on-premises Active Directory Connector:

   1. Go to the **Connectors** tab in the Synchronization Service Manager.
   2. Right-click the **on-premises Active Directory Connector**, and select **Run**.
   3. In the dialog box, select **Full Import**, and select **OK**.
   4. Wait for the operation to complete.

      > [!NOTE]
      > You can skip full import on the on-premises Active Directory Connector if the source attribute is already included in the list of imported attributes. In other words, you did not have to make any change during step 2 earlier in this article.

2. Run **Full import** on the Microsoft Entra Connector:

   1. Right-click the **Microsoft Entra Connector**, and select **Run**.
   2. In the dialog box, select **Full Import**, and select **OK**.
   3. Wait for the operation to complete.

3. Verify the synchronization rule changes on an existing **User** object.

   The source attribute from on-premises Active Directory, and **preferredDataLocation** from Microsoft Entra ID, have been imported into each respective connector space. Before proceeding with the full synchronization step, do a preview on an existing **User** object in the on-premises Active Directory Connector space. The object you picked should have the source attribute populated. A successful preview with **preferredDataLocation** populated in the metaverse is a good indicator that you have configured the synchronization rules correctly. For information about how to do a preview, see [Verify the change](how-to-connect-sync-change-the-configuration.md#verify-the-change).

4. Run **Full Synchronization** on the on-premises Active Directory Connector:

   1. Right-click the **on-premises Active Directory Connector**, and select **Run**.
   2. In the dialog box, select **Full Synchronization**, and select **OK**.
   3. Wait for the operation to complete.

5. Verify **Pending Exports** to Microsoft Entra ID:

   1. Right-click the **Microsoft Entra Connector**, and select **Search Connector Space**.
   2. In the **Search Connector Space** dialog box:

        a. Set **Scope** to **Pending Export**.<br>
        b. Select all three check boxes, including **Add, Modify, and Delete**.<br>
        c. To view the list of objects with changes to be exported, select **Search**. To        examine the changes for a given object, double-click the object.<br>
        d. Verify that the changes are expected.

6. Run **Export** on the **Microsoft Entra Connector**

   1. Right-click the **Microsoft Entra Connector**, and select **Run**.
   2. In the **Run Connector** dialog box, select **Export**, and select **OK**.
   3. Wait for the operation to complete.

> [!NOTE]
> You might notice that the steps do not include the full synchronization step on the Microsoft Entra Connector, or the export step on the Active Directory Connector. The steps are not required, because the attribute values are flowing from on-premises Active Directory to Microsoft Entra-only.

## Step 8: Re-enable sync scheduler
Re-enable the built-in sync scheduler:

1. Start a PowerShell session.
2. Re-enable scheduled synchronization by running this cmdlet: `Set-ADSyncScheduler -SyncCycleEnabled $true`

## Step 9: Verify the result
It is now time to verify the configuration and enable it for your users.

1. Add the geo to the selected attribute on a user. The list of available geos can be [found in this table](/microsoft-365/enterprise/microsoft-365-multi-geo).  
![Screenshot of AD attribute added to a user](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-adattribute.png)
2. Wait for the attribute to be synchronized to Microsoft Entra ID.
3. Using Exchange Online PowerShell, verify that the mailbox region has been set correctly.  
![Screenshot of Exchange Online PowerShell](./media/how-to-connect-sync-feature-preferreddatalocation/preferreddatalocation-mailboxregion.png)  
Assuming your tenant has been marked to be able to use this feature, the mailbox is moved to the correct geo. This can be verified by looking at the server name where the mailbox is located.

## Next steps

Learn more about Multi-Geo in Microsoft 365:

* [Multi-Geo sessions at Ignite](https://aka.ms/MultiGeoIgnite)
* [Multi-Geo in OneDrive](/microsoft-365/enterprise/multi-geo-capabilities-in-onedrive-and-sharepoint-online-in-microsoft-365)
* [Multi-Geo in SharePoint Online](/microsoft-365/enterprise/multi-geo-capabilities-in-onedrive-and-sharepoint-online-in-microsoft-365)

Learn more about the configuration model in the sync engine:

* Read more about the configuration model in [Understanding Declarative Provisioning](concept-azure-ad-connect-sync-declarative-provisioning.md).
* Read more about the expression language in [Understanding Declarative Provisioning Expressions](concept-azure-ad-connect-sync-declarative-provisioning-expressions.md).

Overview topics:

* [Microsoft Entra Connect Sync: Understand and customize synchronization](how-to-connect-sync-whatis.md)
* [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md)
