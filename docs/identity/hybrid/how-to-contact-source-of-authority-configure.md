---
title: Configure Contact Source of Authority (SOA) in Microsoft Entra ID
description: Learn how to transfer contact management from Active Directory Domain Services (AD DS) to Microsoft Entra ID by using contact Source of Authority (SOA).
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 08/07/2025
ms.reviewer: dhanyak

#CustomerIntent: As an administrator, I want to change the source of authority for a synced hybrid contact so that their attributes can be fully managed in the cloud.
---

# Configure Contact Source of Authority (SOA)

This article explains the prerequisites, and steps, to configure contact Source of Authority (SOA). This article also explains how to revert changes, and current feature limitations. For a full overview for SOA, see [Embrace cloud-first posture: Transfer User Source of Authority to the cloud](user-source-of-authority-overview.md).

## Prerequisites

| Requirement | Description |
|-------------|-------------|
| **Roles** | [Hybrid Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-administrator) is required to call the Microsoft Graph APIs to read and update SOA of contacts.<br>[Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) is required to grant user consent to the required permissions to Microsoft Graph Explorer or the app used to call the Microsoft Graph APIs. |
| **Permissions** | For apps calling into the `onPremisesSyncBehavior` Microsoft Graph API, the `Contacts-OnPremisesSyncBehavior.ReadWrite.All` permission scope needs to be granted. For more information, see [how to consent to this permission](how-to-user-source-of-authority-configure.md#consent-permission-to-apps) using the Microsoft Entra Admin Center. |
| **License needed** | Microsoft Entra Free license. |
| **Connect Sync client** | Minimum version is [2.5.79.0](../../identity/hybrid/connect/reference-connect-version-history.md#25790).  |
| **Cloud Sync client** | Minimum version is [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700)|



## Setup

You need to set up Connect Sync client and the Microsoft Entra Provisioning agent.

### Connect sync client

1. Download the latest version of the Connect Sync build.

1. Verify the Connect Sync build is successfully installed. Go to **Programs** in Control Panel and confirm that the version of Microsoft Entra Connect Sync is [2.5.76.0](/entra/identity/hybrid/connect/reference-connect-version-history#25760).

### Cloud sync client

Download the Microsoft Entra Provisioning agent with build version [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700) or later.

1. Follow the [instructions to download the Cloud Sync client](/entra/identity/hybrid/cloud-sync/reference-version-history#download-link).

1. Learn how to [identify the agent's current version](/azure/active-directory/hybrid/cloud-sync/how-to-automatic-upgrade).

1. Follow the [instructions to configure provisioning from AD DS to Microsoft Entra ID](/entra/identity/hybrid/cloud-sync/how-to-configure).

## Consent permission to apps

You can consent permission in the Microsoft Entra admin center. This highly privileged operation requires the Application Administrator or Cloud Application Administrator role. You can also grant consent by using PowerShell. For more information, see [Grant consent on behalf of a single user](/entra/identity/enterprise-apps/grant-consent-single-user?pivots=ms-graph).

### Custom apps

Follow these steps to grant `Contacts-OnPremisesSyncBehavior.ReadWrite.All` permission to the corresponding app. For more information about how to add new permissions to your app registration and grant consent, see [Update an app's requested permissions in Microsoft Entra ID](/entra/identity-platform/howto-update-permissions). 

### Use Microsoft Entra admin center to consent permission to apps 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) or a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Enterprise Apps** > ***App name***.

1. Select **Permissions** > **Grant admin consent for *tenant name***.

1. Sign in again as an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) or a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 

1. Review the list of permissions that require your consent, and select **Accept**.

1. You can see the list of permissions that you granted:

:::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/permission.png" alt-text="Screenshot of how to validate a permission is granted.":::

### Grant permission to Graph Explorer

1. Open [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in as an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

1.	Select the profile icon, and select **Consent to permissions**.

1.	Search for Contacts-OnPremisesSyncBehavior, and select **Consent** for the permission.
:::image type="content" source="media/how-to-contacts-source-of-authority-configure/contact-graph-permission.png" alt-text="screenshot of granting permission for contacts within graph explorer.":::


## Transfer SOA for a test contact

> [!NOTE]
> You're also able to transfer contact SOA using the `https://graph.microsoft.com/v1.0/contacts` API endpoint.

Follow these steps to transfer the SOA for a test contact:

1. Create a contact within AD. You can also use an existing contact that is synced to Microsoft Entra ID by using Connect Sync.
1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Verify that the user appears in the Microsoft Entra admin center as a synced user.
1. Use Microsoft Graph API to transfer the SOA of the user object (*isCloudManaged*=true). Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in with an appropriate user role, such as user admin.
1. Let's check the existing SOA status. We didn’t update the SOA yet, so the *isCloudManaged* attribute value should be false. Replace the *{ID}* in the following examples with the object ID of your user. For more information about this API, see [Get onPremisesSyncBehavior](/graph/api/onpremisessyncbehavior-get).
/graph/api/onpremisessyncbehavior-update

   ```https
   GET https://graph.microsoft.com/v1.0/contacts/{ID}/onPremisesSyncBehavior?$select=isCloudManaged
   ```

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/cloud-managed.png" alt-text="Screenshot of GET call to verify user properties.":::

1. Confirm that the synced contact is read-only. Because the contact is managed on-premises, any write attempts to the user in the cloud fail. The error message differs for mail-enabled contacts, but updates still aren't allowed.

   > [!NOTE]
   > If this API fails with 403, use the **Modify permissions** tab to grant consent to the required User.ReadWrite.All permission.

   ```https
   PATCH https://graph.microsoft.com/v1.0/contacts/{ID}/
      {
        "DisplayName": "Contact Name Updated"
      }   
   ```

   :::image type="content" source="media/how-to-user-source-of-authority-configure/try-update.png" alt-text="Screenshot of an attempt to update a user to verify it's read-only.":::
 
1. Search the Microsoft Entra admin center for the user. Verify that all user fields are greyed out, and that source is Windows Server AD DS.

1. Now you can update the SOA of the user to be cloud-managed. Run the following operation in Microsoft Graph Explorer for the user object you want to transfer to the cloud. For more information about this API, see [Update onPremisesSyncBehavior](/graph/api/onpremisessyncbehavior-update).

   ```https
   PATCH https://graph.microsoft.com/v1.0/contacts/{ID}/onPremisesSyncBehavior
      {
        "isCloudManaged": true
      }   
   ```

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/switch.png" alt-text="Screenshot of PATCH operation to update user properties.":::

1. To validate the change, call GET to verify *isCloudManaged* is true.

   ```https
   GET https://graph.microsoft.com/v1.0/contacts/{ID}/onPremisesSyncBehavior?$select=isCloudManaged
   ```

   :::image type="content" source="media/how-to-user-source-of-authority-configure/get-user.png" alt-text="Screenshot of how to use Microsoft Graph Explorer to get the SOA value of a user.":::

1. Confirm the change in the Audit Logs. To access Audit Logs in the Azure portal, open **Manage Microsoft Entra ID** > **Monitoring** > **Audit Logs**, or search for *audit logs*. Select **Change Source of Authority from AD to cloud** as the activity.

1. Check that the user can be updated in the cloud.

   ```https
   PATCH https://graph.microsoft.com/v1.0/contacts/{ID}/
      {
        "DisplayName": "Update User Name"
      }   
   ```

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/retry-update.png" alt-text="Screenshot of a retry to change user properties.":::

1. Open Microsoft Entra admin center and confirm that the user **On-premises sync enabled** property is **Yes**.


## Connect Sync client

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. To look at the user object with transferred SOA, in the **Synchronization Service Manager**, go to **Connectors**:

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/connectors.png" alt-text="Screenshot of Connectors.":::

1. Right-click **Active Directory Domain Services Connector**. Search for the user by the relative domain name (RDN) setting "CN=\<UserName\>":

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/search.png" alt-text="Screenshot of how to search for RDN.":::

1. Double-click the searched entry, and select **Lineage** > **Metaverse Object Properties**.

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/lineage.png" alt-text="Screenshot of how to view lineage.":::

1. Select **Connectors** and double-click the **Microsoft Entra ID object** with "CN={\<Alphanumeric Characters\>}".

1. You can see that the **blockOnPremisesSync** property is set to true on the Microsoft Entra ID object. This property value means that any changes made in the corresponding AD DS object don't flow to the Microsoft Entra ID object:

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/block.png" alt-text="Screenshot of how to block data flow.":::

1. Let’s update the on-premises user object. We change the user name from *TestUserF1* to *TestUserF1.1*:

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/change-name.png" alt-text="Screenshot of how to change the object name.":::

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Open Event viewer and filter the Application log for event ID 6956. This event ID is reserved to inform the customers that the object isn't synced to the cloud because the SOA of the object is in the cloud.

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/event-6956.png" alt-text="Screenshot of event ID 6956.":::


### Status of attributes after you transfer SOA

The following table explains the status for *isCloudManaged* and *onPremisesSyncEnabled* attributes after you transfer the SOA of an object.

Admin step | isCloudManaged value | onPremisesSyncEnabled value | Description  
-----|----------------------|----------------------|------------
Admin syncs an object from AD DS to Microsoft Entra ID | `false` | `true` | When an object is originally synchronized to Microsoft Entra ID, the *onPremisesSyncEnabled* attribute is set to `true` and *isCloudManaged* is set to `false`.  
Admin transfers the source of authority (SOA) of the object to the cloud | `true` | `null` | After an admin transfers the SOA of an object to the cloud, the *isCloudManaged* attribute becomes set to `true` and the *onPremisesSyncEnabled* attribute value is set to `null`. 
Admin rolls back the SOA operation | `false` | `null` | If an admin transfers the SOA back to AD, the *isCloudManaged* is set to `false` and *onPremisesSyncEnabled* is set to `null` until the sync client takes over the object.    
Admin creates a cloud native object in Microsoft Entra ID | `false` | `null` | If an admin creates a new cloud-native object in Microsoft Entra ID, *isCloudManaged* is set to `false` and *onPremisesSyncEnabled* is set to `null`.
Admin creates a cloud native object in Microsoft Entra ID | `false` | `null` | If an admin creates a new cloud-native object in Microsoft Entra ID, *isCloudManaged* is set to `false` and *onPremisesSyncEnabled* is set to `null`.


## Roll back SOA update

> [!IMPORTANT] 
> Make sure that the contacts that you roll back have no cloud references. Remove cloud contacts from SOA transferred groups, and remove these groups from access packages before you roll back the uscontactscontactsers to AD DS. The sync client takes over the object in the next sync cycle.

You can run this operation to roll back the SOA update and revert the SOA to on-premises. 

   ```https
   PATCH https://graph.microsoft.com/v1.0/contacts/{ID}/onPremisesSyncBehavior
      {
        "isCloudManaged": false
      }   
   ```

  :::image type="content" source="media/how-to-contacts-source-of-authority-configure/rollback.png" alt-text="Screenshot of contacts source of authority rollback api call.":::

> [!NOTE]
> The change of *isCloudManaged* to `false` allows an AD DS object that's in scope for sync to be taken over by Connect Sync the next time it runs. Until the next time Connect Sync runs, the object can be edited in the cloud. The rollback of SOA is finished only after *both* the API call and the next scheduled or forced run of Connect Sync are complete.

### Validate the change in the audit logs

Select activity as **Undo changes to Source of Authority from AD DS to cloud**:

:::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/audit-undo-changes.png" alt-text="Screenshot of Undo Changes in Audit Logs.":::

## Validate in Connect Sync client

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Open the object in the **Synchronization Server Manager** (details are in the [Connect Sync Client](#connect-sync-client) section). You can see the state of the Microsoft Entra ID connector object is **Awaiting Export Confirmation** and *blockOnPremisesSync* = false, which means the object SOA is taken over by the on-premises again.

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/await-export.png" alt-text="Screenshot of an object awaiting export.":::

## Clear on-premises attributes for SOA transferred contacts

The following are the list of on-premises [properties](/graph/api/resources/user#properties) present on the cloud contact object that are used for accessing on-premises resources:

- onPremisesDistinguishedName
- onPremisesDomainName
- onPremisesSamAccountName
- onPremisesSecurityIdentifier
- onPremisesUserPrincipalName


If Admins want to access on-premises resources after transfer of SOA, you must [manually maintain these attributes using Microsoft Graph](/graph/api/resources/user), and not delete, these attributes.

## Scope a contact for SOA operations within an Administrative Unit

To scope a contact for Source of Authority operations within an Administrative Unit, do the following steps:

1. Create a unit to use as the scope for the contact. For steps on creating a unit, see: [Create an administrative unit](../../identity/role-based-access-control/admin-units-manage.md#create-an-administrative-unit).

1. Add the contact as a Hybrid Identity Administrator within the scope.
    :::image type="content" source="media/how-to-user-source-of-authority-configure/assign-scope-role.png" alt-text="Screenshot of assigning a hybrid admin role to an Administrative unit scope." lightbox="media/how-to-user-source-of-authority-configure/assign-scope-role.png":::
1. Add contacts to the unit. For information on this, see: [Add users, groups, or devices to an administrative unit](../../identity/role-based-access-control/admin-units-members-add.md).

1. Transfer the SOA of contacts within the scope of the unit. For a guide on transferring the SOA of contacts, see: [Transfer SOA for a test contact](how-to-contact-source-of-authority-configure.md#transfer-soa-for-a-test-contact).


## Related content

- [Configure User Source of Authority (SOA)](how-to-user-source-of-authority-configure.md)
- [Configure Group Source of Authority (SOA)](how-to-group-source-of-authority-configure.md)


