---
title: Manage Group Source of Authority (SOA) in Microsoft Entra ID
description: Learn how to transition group management from Active Directory to Microsoft Entra ID using Source of Authority (SOA), including prerequisites, setup, validation, rollback, and integration with Group Provisioning to Active Directory (GPAD).
author: Justinha
manager: dougeby
ms.topic: concept-article
ms.date: 07/15/2025
ms.author: justinha
ms.reviewer: dhanyak
---

# Manage Group Source of Authority (SOA) 

Source of Authority (SOA) is a feature that enables IT administrators in hybrid environments to transition the management of specific objects from Active Directory (AD) to Microsoft Entra ID. 
When an administrator applies SOA to an object synced from AD to Microsoft Entra ID, they convert the object to a cloud-owned object that can only be edited and deleted in Microsoft Entra ID. 
Connect Sync and Cloud Sync honor the conversion, and no longer try to sync the object from AD. 

Helping administrators select which objects they want to be cloud-managed lets them phase the migration process. 
They don't need to switch the entire directory to the cloud and discontinue AD at once. 
SOA helps hybrid environments avoid substantial redesign and re-platforming of applications, so they can gradually reduce AD dependencies.
This phased approach ensures seamless operations, minimal impact on end users, and helps organizations secure their identities using capabilities in Microsoft Entra ID and
Microsoft Entra ID Governance. 

## When can you use SOA?

Source of Authority (SOA) allows you to convert an on-premises AD group into a cloud-owned group and manage it from the cloud.
If you no longer need the group on-premises, you can delete it from AD. 
If you still need the group, you can use **Group Provisioning to AD**. 
For more information, see [Tutorial - Provision groups to Active Directory using Microsoft Entra Cloud Sync](/entra/identity/hybrid/cloud-sync/tutorial-group-provisioning).

You can use SOA in any of these scenarios:

- You have begun your [Cloud-first](/entra/architecture/road-to-the-cloud-posture#state-3-cloud-first) journey by creating all new groups in the cloud, and now you want to migrate your existing on-premises AD groups to the cloud. This strategy enables you to use Microsoft Entra ID Governance to control access to applications through these groups. With **Group Provisioning to AD**, you can provision only the necessary groups back to AD, and govern their membership by using features like dynamic groups, entitlement management, and access reviews.

- You no longer have any on-premises Exchange dependencies, or require Distribution Lists (DLs), and Mail Enabled Security Groups (MESGs) to be present in AD. You also want to transition the management of these groups to Exchange Online (EXO).

- You modernized your apps and no longer need AD groups for access. For example, your apps now rely on group claims that use SAML or OpenID Connect from Microsoft Entra, rather than ADFS. Using Microsoft Entra ID Governance, you want to manage these apps with Microsoft Entra features. With SOA, instead of creating new cloud groups, you can migrate on-premises groups. After SOA conversion, app functionality remains because group properties stay the same, enabling you to manage app access using Microsoft Entra features that update group membership.

## When should you not use SOA?

If you are a customer who has any of the following scenarios, we
recommend that you review your group management strategy and determine
which groups can migrate to the cloud so you can reduce your AD
dependencies. For the ones that can’t, think about how you can remove or
modernize apps tied to these groups so you can remove them eventually.

| Customer scenario                                                                                          | What’s not supported                                                                                                                                                                                                                                                                                                                                                                                                             |
|------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| You are using group management tools, such as MIM, for approval and complex group management capabilities. | In this scenario, you may be using these tools to provide self-service group management capabilities, with multiple approval stages or other complex group management features such as dynamic groups populated based on attributes not in the Entra ID directory. Such capabilities are currently not supported through Microsoft Entra ID cloud-hosted services. These groups are not candidates yet to move to cloud managed. |
| You have on-prem groups tied to Exchange, such as Distribution Lists or Mail-Enabled security groups.      | You can apply SOA to these objects, but you must maintain membership through Exchange Online and not through Entra ID. As such, Entra ID Governance cannot be applied to them. They are also not able to be provisioned back to Active Directory. If you want to govern them from the cloud, we recommend you modernize the underlying apps and remove the groups from AD after you shift their SOA to the cloud.                |
| Support for managing and governing AD based apps tied to M365 groups (Universal groups).                   | Currently, there are no plans to enable selective provisioning of M365 groups to Active Directory. Our goal is to help customers clean up their groups in AD and remove any groups tied to apps that have exchange features rather than continue to keep these apps, thereby keeping these groups in AD.                                                                                                                         |

## Scenarios in scope for preview

This preview supports the ability to switch the SOA of any synced group in Active Directory to a cloud group. These scenarios are enabled by Group SOA preview:

- **Minimize on-premises groups in AD:** Migrate on-premises groups to the
cloud and manage them from the cloud without having to re-create these
groups in Entra ID. By leveraging Group SOA at object level feature, you
can switch the SOA of an on-premises AD group to be a cloud group. If
you have already modernized the underlying apps tied to this group, you
can just remove these groups in AD once you have shifted your SOA. If
you are using Entra Connect Sync, you can do this without having to make
any configuration changes to your sync.

- **Seamless switching of AD Security Group to the Cloud (via SOA) and enabling provisioning back to the same AD Security Group:** Currently,
Cloud Security Group Provisioning to AD creates a *new* on-prem AD
security group when provisioning from the cloud. Provisioning is supported by the *existing* AD security
group that SOA was applied for (retaining the SID so existing
applications tied to the security group continue to function).

## Supported features for Group SOA

- Microsoft Entra Connect Sync customers can apply SOA groups at the object
    level (sync client will understand the SOA switch and will stop
    syncing the object from AD to Entra ID).

- Transfer the source of authority of **any** group from AD to Microsoft Entra
    ID. This means, once the group is transferred, it becomes a cloud
    group and will be mapped to the corresponding group type in the
    cloud.

- Once the group is a cloud group, it will no longer be in scope for
    the AD to Microsoft Entra ID sync flow. This means, the group will not be
    synced from AD to Microsoft Entra ID using Connect Sync. We recommend you
    delete the group instead of removing it as out of scope in your
    scoping filters if you no longer need the group in AD.

- You can roll back the SOA switch at an object level the same way
    you set it up (by toggling the appropriate attribute value).
    However, rolling back the change is not instantaneous – the cloud
    object instantly becomes eligible again to be "taken over" by
    Connect Sync, but it only actually happens **when the next sync runs.** The Connect Sync client will again take over the cloud
    object, assuming the AD object remains in scope for sync.

- **Cloud sync** customers can use SOA switch for groups at object
    level (Cloud sync client will understand the SOA switch and will
    stop syncing the object from AD to Entra ID)

- If the cloud security group needs to be provisioned back to AD,
    Admins can add the group to the Group Provision to AD scoping
    configuration. They can use **Selected groups** or **All groups** with
    attribute value scoping. Dynamic groups can also be used.

- When provisioning security groups back to AD, Cloud Sync provisions
    to the same AD group that SOA had applied for (retaining the same
    SID) and will not create a new on-premises group.

## Limitations

- **No reconciliation support for local AD groups:** An AD admin (or
    other application with sufficient permissions) can directly modify
    an AD group. If SOA had been applied to the object and/or if cloud
    security group provisioning to AD is enabled, those local AD changes
    will not be reflected in Microsoft Entra ID. When a change to the cloud
    security group is made, any local AD changes will be overwritten if
    group provisioning to AD is enabled.

- **No dual write allowed:** Once you start managing a group’s
    memberships from Microsoft Entra ID for the transferred group (say cloud
    group A) and you provision this group to AD using Group Provision to
    AD as a nested group under another AD group (OnPremGroupB) in scope
    for AD to Entra ID sync, the membership reference of group A will
    not be synced when AD2EntraID sync happens for OnPremGroupB. This is
    because the sync client will not know the cloud group membership
    references. This is by design.

- **SOA transfer of nested groups:** If you have nested groups in AD
    and want to transfer the SOA of the parent or top group from AD to Microsoft Entra ID, only the parent group’s SOA will be switched. All the
    groups underneath the parent group will continue to be AD groups.
    You need to switch the SOA of these nested groups one by one. We
    recommend you start with the group in the lowest hierarchy and move
    up the tree.

- **Extension Attributes (1-15):** Extension attributes 1 – 15 aren't supported on cloud security groups and aren't supported after SOA is converted.

## Prerequisites

| Requirement | Description |
|-------------|-------------|
| **Roles** | - Groups Administrator role is allowed to call the OnPremisesSyncBehavior Graph API for Groups.<br>- Cloud Application Administrator role is allowed to consent to the required permissions for apps to call the OnPremisesSyncBehavior Graph API for Groups. |
| **Permissions** | For apps calling into the OnPremisesSyncBehavior Graph API, Group-OnPremisesSyncBehavior.ReadWrite.All permission scope needs to be granted. For more information see [how to grant this permission to Graph Explorer or an existing app in your tenant](#grant-permission-to-apps) later in this topic. |
| **License needed** | Microsoft Entra Free or Basic license. |
| **Connect Sync client** | Minimum version is 255.0.4.0 (see below on how to install the latest version of Connect Sync) |

## Setup

You need to set up Connect Sync client and the Cloud Sync client Provisioning agent, and make sure you have required administrator roles. 

### Connect Sync client

1. Download the latest version of the Connect Sync build.

1. Verify the Connect Sync build has been successfully installed. Go to “Add remove programs” in the control panel and check version of “Microsoft Entra Connect Sync,” minimum version is **255.0.4.0.**

> [!NOTE]
> There will be no upgrade path from this private build of the Connect Sync client to the ultimate public version. So, plan to uninstall this private build in the future before installing the eventual public build.

### Cloud Sync client

Download the Provisioning agent with build version [1.1.1373.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113730) or later.

1. [Instructions for download](/entra/identity/hybrid/cloud-sync/reference-version-history#download-link)

1. Learn how to [identify the agent's current version](/azure/active-directory/hybrid/cloud-sync/how-to-automatic-upgrade).



### Prerequisites to call Microsoft Graph API

- A Microsoft Entra ID tenant with on-premises sync enabled at the tenant level.

- A user account in the tenant with the following roles assigned:

   - [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator): To grant user consent to the required permissions to Microsoft Graph Explorer or the app used to call the Graph APIs.

   - [Groups Administrator](/entra/identity/role-based-access-control/permissions-reference#groups-administrator): To call the Microsoft Graph APIs to read and update SOA of groups.

## Grant permission to apps

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

1. In the **Enterprise Applications** blade in the Microsoft Entra portal, find the **Application Id** of the app that needs permission to be granted, such as Graph Explorer. For Graph Explorer, the **Application Id** is *de8bc8b5-d9f9-48b1-a8ad-b748da725064*.

1. In the same browser where you signed in, open the following URL to consent to the **Group-OnPremisesSyncBehavior.ReadWrite.All** permission. Replace the **Application Id** in URL below with the **Application Id** of the app that needs permission to be granted. For Graph Explorer, the URL is:

   ```https
   https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=de8bc8b5-d9f9-48b1-a8ad-b748da725064&response_type=code&scope=https://graph.microsoft.com/Group-OnPremisesSyncBehavior.ReadWrite.All
   ```

1. Click **Accept** to grant consent.

   > [!NOTE]
   > Consenting on behalf of the entire organization isn't required.

   :::image type="content" source="media/how-to-use-source-of-authority/consent.png" alt-text="Screenshot of the consent screen for granting permissions in Microsoft Entra admin center.":::

   > [!NOTE]
   > Ignore this error if you see it after you click **Accept**: `AADSTS9002325: Proof Key for Code Exchange is required for cross-origin authorization code redemption.`

1. To verify the permission is granted, open **Enterprise Applications** > **AppName** > **Security** > **Permissions** > **User consent in Microsoft Entra portal**. It may take a minute or two for the permission to appear.

   :::image type="content" source="media/how-to-use-source-of-authority/verify-consent.png" alt-text="Screenshot of the permissions page in Microsoft Entra portal showing granted permissions.":::

## Switch SOA of a test group

Follow these steps to switch the SOA for a test group:

1. Create a security group or a mail-enabled distribution group in AD for testing and add group members. Or you can use a group that's already synced to Microsoft Entra ID by using Connect Sync.
1. Run the folloing command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Verify that the group appears in the Microsoft Entra admin center as a synced group.
1. Use Microsoft Graph API to change the SOA of the group object (*isCloudManaged*=true). Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in with an appropriate user role, such as Groups admin.
1. Let's check the existing SOA status. Since we haven’t updated the SOA yet, the *isCloudManaged* attribute value should be false. Replace the *groupID* in the following examples with the object ID of your group.  

   ```https
   GET https://graph.microsoft.com/beta/groups/groupId/onPremisesSyncBehavior?\$select=isCloudManaged
   ```

   :::image type="content" source="media/how-to-use-source-of-authority/get-group.png" alt-text="Screenshot of how to use Microsoft Graph Explorer to get the SOA value of a group.":::

1. Check that the synced group is read-only. Because the group is managed on-premises, any write attempts to the group in the cloud fail. The error message differs for mail-enabled groups, but updates still aren't allowed.

   ```https
   PATCH https://graph.microsoft.com/v1.0/groups/groupId/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" source="media/how-to-use-source-of-authority/try-update.png" alt-text="Screenshot of an attempt to update a group to verify it's read-only.":::

   > [!NOTE]
   > If this API fails with 403, use the **Modify permissions** tab to grant consent to the required Group.ReadWrite.All permission.
 
1. Check Microsoft Entra portal for the group to verify that all group fields are greyed out, and that source is Windows Server AD:  

   :::image type="content" border="true" source="media/how-to-use-source-of-authority/basic.png" alt-text="Screenshot of basic group properties.":::

   :::image type="content" border="true" source="media/how-to-use-source-of-authority/properties.png" alt-text="Screenshot of advanced group properties.":::

1. Now you can update the SOA of group to be cloud-managed. Run the following operation in Microsoft Graph Explorer for the group object you want to switch to the cloud:


   ```https
   PATCH https://graph.microsoft.com/beta/groups/groupId/onPremisesSyncBehavior
      {
        "isCloudManaged": true
      }   
   ```

   :::image type="content" border="true" source="media/how-to-use-source-of-authority/switch.png" alt-text="Screenshot of PATCH operation to update group properties.":::


1. To validate the change, call GET to verify *isCloudManaged* is true.

   ```https
   GET https://graph.microsoft.com/beta/groups/groupId/onPremisesSyncBehavior?\$select=isCloudManaged
   ```

   :::image type="content" border="true" source="media/how-to-use-source-of-authority/cloud-managed.png" alt-text="Screenshot of GET call to verify group properties.":::


1. Confirm the change in the Audit Logs. To access Audit Logs in the Azure portal, open **Manage Microsoft Entra ID** > **Monitoring** > **Audit Logs**, or search for *audit logs*. Select **Change Source of Authority from AD to cloud** as the activity.

   :::image type="content" border="true" source="media/how-to-use-source-of-authority/audit.png" alt-text="Screenshot of change to group properties in Audit Logs.":::

1. Check that the group can be updated in the cloud.

   ```https
   PATCH https://graph.microsoft.com/v1.0/groups/groupId/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" border="true" source="media/how-to-use-source-of-authority/retry-update.png" alt-text="Screenshot of a retry to change group properties.":::

1. Open Microsoft Entra andmin center and confirm that the group **Source** property is **Cloud**.

   :::image type="content" border="true" source="media/how-to-use-source-of-authority/source-cloud.png" alt-text="Screenshot of how to confirm group source property.":::


## Connect Sync Client

1.  Run sync in connect sync by running “Start-ADSyncSyncCycle” in
    PowerShell window.

2.  To look at the group object you switched SOA of, in the
    “Synchronization Service Manager,” go to "Connectors":

<img src="media/how-to-group-source-of-authority-configure/connectors.png" style="width:6.5in;height:2.38542in"
alt="A screenshot of a computer Description automatically generated" />

3.  Right-click **Active Directory Domain Services Connector**:

Search the group by RDN setting CN=\<GroupName\>

> <img src="media/how-to-group-source-of-authority-configure/search.png" style="width:6.5in;height:4.72917in"
> alt="A screenshot of a computer Description automatically generated" />

4.  Double-click the searched entry and click **Lineage** > **Metaverse Object Properties**.

<img src="media/how-to-group-source-of-authority-configure/lineage.png" style="width:6.02083in;height:4.71825in"
alt="A screenshot of a computer Description automatically generated" />

5.  Click on “Connectors” and double click on the **Entra ID object**
    with “CN={\<Alpha Numeric Characters\>}”

6.  You will notice “blockOnPremisesSync” property is set to true on the
    Entra ID object, which means any changes made in the corresponding
    Active Directory object will not flow to the Entra ID object:

> <img src="media/how-to-group-source-of-authority-configure/block.png" style="width:6.5in;height:5.09375in"
> alt="A screenshot of a computer Description automatically generated" />

7.  Let’s update the on-premises group object, change the group name
    from SecGroup1 to SecGroup1.1:

> <img src="media/how-to-group-source-of-authority-configure/change-name.png" style="width:4.16667in;height:4.92708in"
> alt="A screenshot of a computer Description automatically generated" />

8.  Run sync in connect sync by running “Start-ADSyncSyncCycle” in
    PowerShell window.

9.  Open event viewer and filter the application event logs with event
    id “6956”, this event id is reserved to inform the customers that
    the object has not been synced to the cloud because the source of
    authority of object is in the cloud.

<img src="media/how-to-group-source-of-authority-configure/event-6956.png" style="width:6.47917in;height:1.70286in"
alt="A screenshot of a computer Description automatically generated" />

## Roll back SOA update

**PATCH**
*https://graph.microsoft.com/beta/groups/\<groupId\>/onPremisesSyncBehavior*

{

"isCloudManaged": false

}

<img src="media/how-to-group-source-of-authority-configure/rollback.png" style="width:6.5in;height:2.42708in" />

***Note:*** This change to “isCloudManaged: false” simply allows the
object to be taken over by Connect Sync the next time it runs (assuming
the AD object remains in scope). Until Connect Sync runs next, the
object remains cloud editable. So, the full “rollback of SOA” when the
object becomes synched from on-prem again only happens after *both* the
API call and the next run of Connect Sync (scheduled or forced).

### Check audit logs to validate the revert operation

Select activity as "**Undo changes to Source of Authority from AD to
cloud**"

<img src="media/how-to-group-source-of-authority-configure/audit-undo-changes.png" style="width:6.5in;height:1.0625in" />

## VALIDATE IN CONNECT SYNC CLIENT

1.  Run sync in connect sync by running “Start-ADSyncSyncCycle” in
    PowerShell window.

2.  Open the object in the “Synchronization Server Manager”, details are
    given in the [“Connect Sync Client”](#connect-sync-client)
    section, you can notice the state of the Microsoft Entra ID connector
    object as “Awaiting Export Confirmation” and blockOnPremisesSync =
    false, means the object is taken over by the on-premises again.

> <img src="media/how-to-group-source-of-authority-configure/await-export.png" style="width:6.5in;height:5.09375in" />

## Cloud sync - provisioning logs 

If you attempt to edit an attribute of a group in AD while **SOA is in
the cloud**, the **Cloud sync will skip this object**.

> **Example: SOAGroup3 Attribute Update**

Let's say we have a group **SOAGroup3**, and we update its group name to
**SOA Group3.1**.

> <img src="media/how-to-group-source-of-authority-configure/update-group-name.png" style="width:4.4375in;height:4.11458in"
> alt="Inserting image..." />

- In the **Provisioning Logs** of the **AD2AAD job**, you will see that
  **SOAGroup3 was skipped**.

> <img src="media/how-to-group-source-of-authority-configure/skipped.png" style="width:6.5in;height:1.10417in"
> alt="Inserting image..." />

- The details will confirm:

  - *"As the SOA of this group is in the cloud, this object will not
    sync."*

<img src="media/how-to-group-source-of-authority-configure/sync-blocked.png" style="width:6.03125in;height:4.26042in"
alt="Inserting image..." />

## Related content

- Group SOA overview
- Provision groups to Active Directory using Microsoft Entra Cloud Sync