---
title: Configure Group Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to convert group management from Active Directory Domain Services (AD DS) to Microsoft Entra ID by using Group Source of Authority (SOA), including prerequisites, setup, validation, and how to roll back.
author: Justinha
manager: dougeby
ms.topic: how-to
ms.date: 08/01/2025
ms.author: justinha
ms.reviewer: dhanyak
---

# Configure Group Source of Authority (SOA) (Preview)

This topic explains the prerequisites and steps to configure Group Source of Authority (SOA), how to revert changes, and limitations. For more information about Group SOA, see [Embrace cloud-first posture: Convert Group Source of Authority to the cloud (Preview)](concept-source-of-authority-overview.md). 

## Prerequisites

| Requirement | Description |
|-------------|-------------|
| **Roles** | [Hybrid Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-administrator) is required to call the Microsoft Graph APIs to read and update SOA of groups.<br>[Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) is required to grant user consent to the required permissions to Microsoft Graph Explorer or the app used to call the Microsoft Graph APIs. |
| **Permissions** | For apps calling into the onPremisesSyncBehavior Microsoft Graph API, the Group-OnPremisesSyncBehavior.ReadWrite.All permission scope needs to be granted. For more information, see [how to grant this permission](#grant-permission-to-apps) to Graph Explorer or an existing app in your tenant. |
| **License needed** | Microsoft Entra Free or Basic license. |
| **Connect Sync client** | Minimum version is [2.5.76.0](./connect/reference-connect-version-history.md) |
| **Cloud Sync client** | Minimum version is [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700)|

## Setup

You need to set up Connect Sync client and the Microsoft Entra Provisioning agent. 

### Connect Sync client

1. Download the latest version of the Connect Sync build.

1. Verify the Connect Sync build is successfully installed. Go to **Programs** in Control Panel and confirm that the version of Microsoft Entra Connect Sync is [2.5.76.0](./connect/reference-connect-version-history.md) or later.

### Cloud Sync client

Download the Microsoft Entra Provisioning agent with build version [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700) or later.

1. Follow the [instructions to download the Cloud Sync client](/entra/identity/hybrid/cloud-sync/reference-version-history#download-link).

1. Learn how to [identify the agent's current version](/azure/active-directory/hybrid/cloud-sync/how-to-automatic-upgrade).


## Grant permission to apps

>[!Important] 
> A known issue might prevent you from viewing the new permission associated with Source of Authority conversion feature in the Microsoft Entra admin center. If you can't view the permissions in the Microsoft Entra ID center or in Graph Explorer, follow the steps in the [Workaround for granting permission to apps](#workaround-for-granting-permission-to-apps).

This highly privileged operation requires the Application Administrator or Cloud Application Administrator role. 

### Custom apps

Follow these steps to grant `Group-OnPremisesSyncBehavior.ReadWrite.All` permission to the corresponding app. For more information about how to add new permissions to your app registration and grant consent, see [Update an app's requested permissions in Microsoft Entra ID](/entra/identity-platform/howto-update-permissions). 

### Microsoft Graph Explorer

1. Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in as an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).
1.	Click the profile icon, and select **Consent to permissions**.
1.	Search for Group-OnPremisesSyncBehavior, and click **Consent** for the permission.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/consent.png" alt-text="Screenshot of how to grant consent to Group-OnPremisesSyncBehavior.ReadWrite permission." lightbox="media/how-to-group-source-of-authority-configure/consent.png":::

### Workaround for granting permission to apps

You can grant consent by using PowerShell or Microsoft Graph. For more information, see [Grant consent on behalf of a single user](/entra/identity/enterprise-apps/grant-consent-single-user?pivots=ms-graph).

## Validate that the permissions are granted 

Sign in to the Azure portal, go to **Enterprise Applications** > **App Name**, and select **Security** > **Permissions**:

:::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/permission.png" alt-text="Screenshot of how to grant permission.":::

## Convert SOA for a test group

Follow these steps to convert the SOA for a test group:

1. Create a security group or a mail-enabled distribution group in AD for testing and add group members. You can also use a group that is synced to Microsoft Entra ID by using Connect Sync.
1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Verify that the group appears in the Microsoft Entra admin center as a synced group.
1. Use Microsoft Graph API to convert the SOA of the group object (*isCloudManaged*=true). Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in with an appropriate user role, such as Groups admin.
1. Let's check the existing SOA status. We didn’t update the SOA yet, so the *isCloudManaged* attribute value should be false. Replace the *{ID}* in the following examples with the object ID of your group. For more information about this API, see [Get onPremisesSyncBehavior](/graph/api/onpremisessyncbehavior-get).
/graph/api/onpremisessyncbehavior-update

   ```https
   GET https://graph.microsoft.com/beta/groups/{ID}/onPremisesSyncBehavior?$select=isCloudManaged
   ```

   :::image type="content" source="media/how-to-group-source-of-authority-configure/get-group.png" alt-text="Screenshot of how to use Microsoft Graph Explorer to get the SOA value of a group.":::

1. Check that the synced group is read-only. Because the group is managed on-premises, any write attempts to the group in the cloud fail. The error message differs for mail-enabled groups, but updates still aren't allowed.

   ```https
   PATCH https://graph.microsoft.com/v1.0/groups/{ID}/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" source="media/how-to-group-source-of-authority-configure/try-update.png" alt-text="Screenshot of an attempt to update a group to verify it's read-only.":::

   > [!NOTE]
   > If this API fails with 403, use the **Modify permissions** tab to grant consent to the required Group.ReadWrite.All permission.
 
1. Search the Microsoft Entra admin center for the group. Verify that all group fields are greyed out, and that source is Windows Server AD:  

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/basic.png" alt-text="Screenshot of basic group properties.":::

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/properties.png" alt-text="Screenshot of advanced group properties.":::

1. Now you can update the SOA of group to be cloud-managed. Run the following operation in Microsoft Graph Explorer for the group object you want to convert to the cloud. For more information about this API, see [Update onPremisesSyncBehavior](/graph/api/onpremisessyncbehavior-update).

   ```https
   PATCH https://graph.microsoft.com/beta/groups/{ID}/onPremisesSyncBehavior
      {
        "isCloudManaged": true
      }   
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/switch.png" alt-text="Screenshot of PATCH operation to update group properties.":::

1. To validate the change, call GET to verify *isCloudManaged* is true.

   ```https
   GET https://graph.microsoft.com/beta/groups/{ID}/onPremisesSyncBehavior?$select=isCloudManaged
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/cloud-managed.png" alt-text="Screenshot of GET call to verify group properties.":::

1. Confirm the change in the Audit Logs. To access Audit Logs in the Azure portal, open **Manage Microsoft Entra ID** > **Monitoring** > **Audit Logs**, or search for *audit logs*. Select **Change Source of Authority from AD to cloud** as the activity.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/audit.png" alt-text="Screenshot of change to group properties in Audit Logs.":::

1. Check that the group can be updated in the cloud.

   ```https
   PATCH https://graph.microsoft.com/v1.0/groups/{ID}/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/retry-update.png" alt-text="Screenshot of a retry to change group properties.":::

1. Open Microsoft Entra admin center and confirm that the group **Source** property is **Cloud**.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/source-cloud.png" alt-text="Screenshot of how to confirm group source property.":::


## Connect Sync client

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. To look at the group object with converted SOA, in the **Synchronization Service Manager**, go to **Connectors**:

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/connectors.png" alt-text="Screenshot of Connectors.":::

1. Right-click **Active Directory Domain Services Connector**. Search for the group by the relative domain name (RDN) setting "CN=\<GroupName\>":

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/search.png" alt-text="Screenshot of how to search for RDN.":::

1. Double-click the searched entry, and click **Lineage** > **Metaverse Object Properties**.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/lineage.png" alt-text="Screenshot of how to view lineage.":::

1. Click **Connectors** and double-click the **Entra ID object** with "CN={\<Alphanumeric Characters\>}".

1. You can see that the **blockOnPremisesSync** property is set to true on the Entra ID object. This property value means that any changes made in the corresponding AD DS object don't flow to the Entra ID object:

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/block.png" alt-text="Screenshot of how to block data flow.":::

1. Let’s update the on-premises group object. We'll change the group name from *SecGroup1* to *SecGroup1.1*:

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/change-name.png" alt-text="Screenshot of how to change the object name.":::

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Open Event viewer and filter the Application log for event ID 6956. This event ID is reserved to inform the customers that the object isn't synced to the cloud because the SOA of the object is in the cloud.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/event-6956.png" alt-text="Screenshot of event ID 6956.":::

## Bulk updates for Group SOA

You can use the following PowerShell script to automate Group SOA updates by using app-based authentication.

```powershell
# Define your Microsoft Entra ID app details and tenant information
$tenantId = ""
$clientId = ""
$certThumbprint = ""

# Connect to Microsoft Graph as App-Only using a certificate. The app registration must have the Group.Read.All Group-OnPremisesSyncBehavior.ReadWrite.All permissions granted.
Connect-MgGraph -ClientId $clientId -TenantId $tenantId -CertificateThumbprint $certThumbprint

#Connect to Microsoft Graph using delegated permissions
#Connect-MgGraph -Scopes "Group.Read.All Group-OnPremisesSyncBehavior.ReadWrite.All" -TenantId $tenantId

# Define the group name you want to query
$groupName = "HR India"

# Retrieve the group using group name
$group = Get-MgBetaGroup -Filter "displayName eq '$groupName'"

# Ensure group is found
if ($null -ne $group)
{
    $groupObjectID = $($group.Id)
    # Define the Microsoft Graph API endpoint for the group
    $url = "https://graph.microsoft.com/beta/groups/$groupObjectID/onPremisesSyncBehavior"

    # Define the JSON payload for the PATCH request
    $jsonPayload = @{
        isCloudManaged = "true"
    } | ConvertTo-Json

    # Make the PATCH request to update the JSON payload
    Invoke-MgGraphRequest -Uri $url -Method Patch -ContentType "application/json" -Body $jsonPayload

    $result = Invoke-MgGraphRequest -Method Get -Uri "https://graph.microsoft.com/beta/groups/$groupObjectID/onPremisesSyncBehavior?`$select=id,isCloudManaged"

    Write-Host "Group Name: $($group.DisplayName)"
    Write-Host "Group ID: $($result.id)"
    Write-Host "SOA Converted: $($result.isCloudManaged)"
}
else 
{
    Write-Warning "Group '$groupName' not found."
}
```

### Status of attributes after you convert SOA

The following table explains the status for **isCloudManaged** and **onPremisesSyncEnabled** attributes you convert the SOA of an object.

Admin step | isCloudManaged value | onPremisesSyncEnabled value | Description  
-----|----------------------|----------------------|------------
Admin syncs an object from AD DS to Microsoft Entra ID | `false` | `true` | When an object is originally synchronized to Microsoft Entra ID, the **OnPremisesSyncEnabled** attribute is set to` true` and **isCloudManaged** is set to `false`.  
Admin converts the source of authority (SOA) of the object to the cloud | `true` | `null` | After an admin converts the SOA of an object to the cloud, the **isCloudManaged** attribute becomes set to `true` and the **OnPremisesSyncEnabled** attribute value is set to `null`. 
Admin rolls back the SOA operation | `false` | `null` | If an admin converts the SOA back to AD, the **isCloudManaged** is set to `false` and **OnPremisesSyncEnabled** is set to `null` until the sync client takes over the object.    
Admin creates a cloud native object in Microsoft Entra ID | `false` | `null` | If an admin creates a new cloud-native object in Microsoft Entra ID, **isCloudManaged** is set to `false` and **onPremisesSyncEnabled** is set to `null`.

## Roll back SOA update

> [!IMPORTANT] 
> Make sure that the groups that you roll back have no cloud references. Remove cloud users from SOA converted groups, and remove these groups from access packages before you roll back the group to AD DS. The sync client takes over the object in the next sync cycle.

You can run this operation to roll back the SOA update and revert the SOA to on-premises. 

   ```https
   PATCH https://graph.microsoft.com/beta/groups/{ID}/onPremisesSyncBehavior
      {
        "isCloudManaged": false
      }   
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/rollback.png" alt-text="Screenshot of API call to revert SOA.":::

> [!NOTE]
> This change to "isCloudManaged: false" allows an AD DS object that's in scope for sync to be taken over by Connect Sync the next time it runs. Until the next time Connect Sync runs, the object can be edited in the cloud. The rollback of SOA is finished only after *both* the API call and the next scheduled or forced run of Connect Sync are complete.

### Validate the change in the Audit Logs

Select activity as **Undo changes to Source of Authority from AD DS to cloud**:

:::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/audit-undo-changes.png" alt-text="Screenshot of Undo Changes in Audit Logs.":::

## Validate in Connect Sync client

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Open the object in the **Synchronization Server Manager** (details are in the [Connect Sync Client](#connect-sync-client) section). You can see the state of the Microsoft Entra ID connector object is **Awaiting Export Confirmation** and blockOnPremisesSync = false, which means the object SOA is taken over by the on-premises again.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/await-export.png" alt-text="Screenshot of an object awaiting export.":::

## Check Cloud sync Provisioning Logs 

If you try to edit an attribute of a group in AD while **SOA is in the cloud**, the Cloud Sync skips the object.

Let's say we have a group *SOAGroup3*, and we update its group name to *SOA Group3.1*.

:::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/update-group-name.png" alt-text="Screenshot of an object name update.":::

In the **Provisioning Logs** of the **AD2AAD job**, you can see that **SOAGroup3 was skipped**.

:::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/skipped.png" alt-text="Screenshot of a skipped object.":::

The details explain that the object isn't synced because its SOA is converted to the cloud.

:::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/sync-blocked.png" alt-text="Screenshot of a blocked sync.":::

## Limitations

- **No reconciliation support for local AD groups**: An AD DS admin (or an application with sufficient permissions) can directly modify an AD DS group. If Group SOA is converted for the group, or if cloud security group provisioning to AD DS is enabled, those local AD changes aren't reflected in Microsoft Entra ID. When a change to the cloud security group is made, any local AD DS changes are overwritten when group provisioning to AD DS runs.

- **No dual write allowed**: After you start to manage the memberships for the converted group (say cloud group A) from Microsoft Entra ID, and you provision this group to AD as a nested group under another AD DS group (OnPremGroupB) that's in scope for sync to Microsoft Entra ID, the membership references of group A aren't synced when sync happens for OnPremGroupB. The membership references aren't synced because the sync client doesn't know the cloud group membership references. This behavior is by design.

- **No SOA conversion of nested groups**: If there are nested groups in AD DS, and you want to convert the SOA of the parent group or top group to Microsoft Entra ID, only the parent group SOA is converted. Nested groups in the parent group continue to be AD DS groups. You need to convert the SOA of any nested groups one-by-one. We recommend you start with the group that is lowest in the hierarchy, and move up the tree.

- **No support for extension attributes (1-15)**: Extension attributes 1–15 aren't supported on cloud security groups and aren't supported after SOA is converted.

## Related content

- [Group SOA overview](concept-source-of-authority-overview.md)
- [Provision groups to Active Directory Domain Services by using Microsoft Entra Cloud Sync](/entra/identity/hybrid/cloud-sync/tutorial-group-provisioning)
- [onPremisesSyncBehavior Microsoft Graph API](/graph/api/resources/onpremisessyncbehavior)