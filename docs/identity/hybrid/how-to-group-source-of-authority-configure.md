---
title: Configure Group Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to transition group management from Active Directory to Microsoft Entra ID using Source of Authority (SOA), including prerequisites, setup, validation, rollback, and integration with Group Provisioning to Active Directory (GPAD).
author: Justinha
manager: dougeby
ms.topic: how-to
ms.date: 07/25/2025
ms.author: justinha
ms.reviewer: dhanyak
---

# Configure Group Source of Authority (SOA) (Preview)

This topic explains the prerequisites and steps to configure Group Source of Authority (SOA), how to revert changes, and limitations. For more information about Group SOA, see [Group SOA overview](concept-source-of-authority-overview.md). 

## Prerequisites

| Requirement | Description |
|-------------|-------------|
| **Roles** | - Groups Administrator role is allowed to call the OnPremisesSyncBehavior Microsoft Graph API for Groups.<br>- Cloud Application Administrator role is allowed to consent to the required permissions for apps to call the OnPremisesSyncBehavior Microsoft Graph API for Groups. |
| **Permissions** | For apps calling into the OnPremisesSyncBehavior Graph API, Group-OnPremisesSyncBehavior.ReadWrite.All permission scope needs to be granted. For more information, see [how to grant this permission to Graph Explorer or an existing app in your tenant](#grant-permission-to-apps) later in this topic. |
| **License needed** | Microsoft Entra Free or Basic license. |
| **Connect Sync client** | Minimum version is [2.5.76.0](./connect/reference-connect-version-history.md) |
| **Cloud Sync client** | Minimum version is [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700)|

## Setup

You need to set up Connect Sync client and the Cloud Sync client Provisioning agent, and make sure you have required administrator roles. 

### Connect Sync client

1. Download the latest version of the Connect Sync build.

1. Verify the Connect Sync build has been successfully installed. Go to **Programs** in Control Panel and confirm that the version of Microsoft Entra Connect Sync is [2.5.76.0](./connect/reference-connect-version-history.md) or later.

### Cloud Sync client

Download the Provisioning agent with build version [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700) or later.

1. Follow the [instructions to download the Cloud Sync client](/entra/identity/hybrid/cloud-sync/reference-version-history#download-link).

1. Learn how to [identify the agent's current version](/azure/active-directory/hybrid/cloud-sync/how-to-automatic-upgrade).

### Prerequisites to call Microsoft Graph API

- A Microsoft Entra ID tenant with on-premises sync enabled at the tenant level.

- A user account in the tenant with the following roles assigned:

   - [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator): To grant user consent to the required permissions to Microsoft Graph Explorer or the app used to call the Graph APIs.

   - [Hybrid Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-administrator): To call the Microsoft Graph APIs to read and update SOA of groups.

## Grant permission to apps

>[!Important] 
> A known issue might prevent you from viewing the new permission associated with Source of Authority conversion feature in the Microsoft Entra admin center. If you can't view the permissions in the Microsoft Entra ID center or in Graph Explorer, follow steps in the the [Workaround for granting permission to apps](#workaround-for-granting-permission-to-apps).

This highly privileged operation requires the Application Administrator or Cloud Application Administrator role. 

Follow these steps to grant `Group-OnPremisesSyncBehavior.ReadWrite. All` permission to the corresponding app. For more information about how to add new permissions to your app registration and grant consent, see [Update an app's requested permissions in Microsoft Entra ID](/entra/identity-platform/howto-update-permissions). 

1. Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in as an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).
1.	Click the profile icon, and select **Consent to permissions**.
1.	Search for Group-OnPremisesSyncBehavior, and click **Consent** for the permission.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/consent.png" alt-text="Screenshot of how to grant consent to Group-OnPremisesSyncBehavior.ReadWrite permission.":::

### Workaround for granting permission to apps
You can grant consent via PowerShell/MS Graph by referring to this article: [Grant consent on behalf of a single user](/entra/identity/enterprise-apps/grant-consent-single-user?pivots=ms-graph).
To validate permissions that the permissions have been granted, sign in to the Azure portal, navigate to **Enterprise Applications** > **App Name** and select **Security** > **Permissions**:

:::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/permission.png" alt-text="Screenshot of how to grant permission.":::

## Convert SOA for a test group

Follow these steps to convert the SOA for a test group:

1. Create a security group or a mail-enabled distribution group in AD for testing and add group members. You can also use a group that's already synced to Microsoft Entra ID by using Connect Sync.
1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Verify that the group appears in the Microsoft Entra admin center as a synced group.
1. Use Microsoft Graph API to convert the SOA of the group object (*isCloudManaged*=true). Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in with an appropriate user role, such as Groups admin.
1. Let's check the existing SOA status. Since we haven’t updated the SOA yet, the *isCloudManaged* attribute value should be false. Replace the *groupID* in the following examples with the object ID of your group.  

   ```https
   GET https://graph.microsoft.com/beta/groups/groupId/onPremisesSyncBehavior?\$select=isCloudManaged
   ```

   :::image type="content" source="media/how-to-group-source-of-authority-configure/get-group.png" alt-text="Screenshot of how to use Microsoft Graph Explorer to get the SOA value of a group.":::

1. Check that the synced group is read-only. Because the group is managed on-premises, any write attempts to the group in the cloud fail. The error message differs for mail-enabled groups, but updates still aren't allowed.

   ```https
   PATCH https://graph.microsoft.com/v1.0/groups/groupId/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" source="media/how-to-group-source-of-authority-configure/try-update.png" alt-text="Screenshot of an attempt to update a group to verify it's read-only.":::

   > [!NOTE]
   > If this API fails with 403, use the **Modify permissions** tab to grant consent to the required Group.ReadWrite.All permission.
 
1. Check Microsoft Entra portal for the group to verify that all group fields are greyed out, and that source is Windows Server AD:  

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/basic.png" alt-text="Screenshot of basic group properties.":::

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/properties.png" alt-text="Screenshot of advanced group properties.":::

1. Now you can update the SOA of group to be cloud-managed. Run the following operation in Microsoft Graph Explorer for the group object you want to convert to the cloud:

   ```https
   PATCH https://graph.microsoft.com/beta/groups/groupId/onPremisesSyncBehavior
      {
        "isCloudManaged": true
      }   
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/switch.png" alt-text="Screenshot of PATCH operation to update group properties.":::

1. To validate the change, call GET to verify *isCloudManaged* is true.

   ```https
   GET https://graph.microsoft.com/beta/groups/groupId/onPremisesSyncBehavior?\$select=isCloudManaged
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/cloud-managed.png" alt-text="Screenshot of GET call to verify group properties.":::

1. Confirm the change in the Audit Logs. To access Audit Logs in the Azure portal, open **Manage Microsoft Entra ID** > **Monitoring** > **Audit Logs**, or search for *audit logs*. Select **Change Source of Authority from AD to cloud** as the activity.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/audit.png" alt-text="Screenshot of change to group properties in Audit Logs.":::

1. Check that the group can be updated in the cloud.

   ```https
   PATCH https://graph.microsoft.com/v1.0/groups/groupId/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/retry-update.png" alt-text="Screenshot of a retry to change group properties.":::

1. Open Microsoft Entra andmin center and confirm that the group **Source** property is **Cloud**.

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

1. You can see that the **blockOnPremisesSync** property is set to true on the Entra ID object. This property value means that any changes made in the corresponding Active Directory object don't flow to the Entra ID object:

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/block.png" alt-text="Screenshot of how to block data flow.":::

1. Let’s update the on-premises group object. We'll change the group name from *SecGroup1* to *SecGroup1.1*:

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/change-name.png" alt-text="Screenshot of how to change the object name.":::

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Open Event viewer and filter the application event logs with event ID 6956. This event ID is reserved to inform the customers that the object isn't synced to the cloud because the SOA of the object is in the cloud.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/event-6956.png" alt-text="Screenshot of event ID 6956.":::

## Bulk updates for Group SOA

You can use the following PowerShell script to automate Group SOA updates for app-based authentication. 

```powershell

# Define your Microsoft Entra ID app details and tenant information
$clientId = ""
$tenantId = ""
$groupID = ""
$clientSecret = ""
 
 
# Get the access token
$body = @{
    grant_type    = "client_credentials"
    scope         = "https://graph.microsoft.com/.default"
    client_id     = $clientId
    client_secret = $clientSecret
}
 
$tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
$token = $tokenResponse.access_token

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Group.Read.All"

# Define the group name you want to query
$groupName = "HR London"


# Retrieve the group using group name
$group = Get-MgGroup -Filter "displayName eq '$groupName'"

# Ensure group is found
if ($group -ne $null)
{
    $groupObjectID = $($group.Id)
# Define the Microsoft Graph API endpoint for the user
$url = "https://graph.microsoft.com/beta/groups/$groupObjectID/onPremisesSyncBehavior"

# Define the JSON payload for the PATCH request
$jsonPayload = @{
    isCloudManaged = "true"
} | ConvertTo-Json
 
# Make the PATCH request to update the user's department
Invoke-RestMethod -Uri $url -Method Patch -Headers @{
    "Authorization" = "Bearer $token"
    "Content-Type"  = "application/json"
} -Body $jsonPayload
$result = Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/beta/groups/$groupObjectID/onPremisesSyncBehavior?$select=id,displayName,isCloudManaged" -Headers @{Authorization = "Bearer $token"}
 Write-Host "Group Name: $($group.DisplayName)"
 Write-Host "Group ID: $($result.id)"
 Write-Host "SOA Converted: $($result.isCloudManaged)"
}
Format-Table -AutoSize
 ```
### Status of attributes after you convert SOA

The following table explains the status for **isCloudManaged** and **dirSyncEnabled** attributes you convert the SOA of an object.

Admin step | isCloudManaged value | dirSyncEnabled value | Description  
-----|----------------------|----------------------|------------
Admin syncs an object from AD to Microsoft Entra ID | `false` | `true` | When an object is originally synchronized to Microsoft Entra ID, the **dirSyncEnabled** attribute is set to` true` and **isCloudManaged** is set to `false`.  
Admin converts the source of authority (SOA) of the object to the cloud | `true` | `null` | After an admin converts the SOA of an object to the cloud, the **isCloudManaged** attribute becomes set to `true` and the **dirSyncEnabled** attribute value is set to `null`. 
Admin rolls back the SOA operation | `false` | `null` | If an admin converts the SOA back to AD, the **isCloudManaged** is set to `false` and **dirSyncEnabled** is set to `null` until the sync client takes over the object.    


## Roll back SOA update

> [!IMPORTANT] 
> Make sure that the groups that you roll back have no cloud references. Remove cloud users from SOA converted groups, and remove these groups from access packages before you roll back the group to Active Directory. The sync client takes over the object in the next sync cycle.

You can run this opreration to roll back the SOA update and revert the SOA to on-premises. 

   ```https
   PATCH https://graph.microsoft.com/beta/groups/groupId/onPremisesSyncBehavior
      {
        "isCloudManaged": false
      }   
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/rollback.png" alt-text="Screenshot of API call to revert SOA.":::

> [!NOTE]
> This change to "isCloudManaged: false" allows an AD object that's in scope for sync to be taken over by Connect Sync the next time it runs. Until the next time Connect Sync runs, the object can be edited in the cloud. The rollback of SOA is complete only happens after *both* the API call and the next scheduled or forced run of Connect Sync.

### Check Audit Logs to validate the revert operation

Select activity as **Undo changes to Source of Authority from AD to cloud**:

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

The details state `As the SOA of this group is in the cloud, this object will not sync.

:::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/sync-blocked.png" alt-text="Screenshot of a blocked sync.":::


## Limitations

- **No reconciliation support for local AD groups:** An AD admin (or an application with sufficient permissions) can directly modify an AD group. If SOA is applied to the object or if cloud security group provisioning to AD is enabled, those local AD changes aren't reflected in Microsoft Entra ID. When a change to the cloud security group is made, any local AD changes are overwritten if group provisioning to AD is enabled.

- **No dual write allowed:** Once you start managing the memberships for the transferred group (say cloud group A) from Microsoft Entra ID, and you provision this group to AD using Group Provision to AD as a nested group under another AD group (OnPremGroupB) that's in scope for AD to Entra ID sync, the membership reference of group A won't be synced when AD2EntraID sync happens for OnPremGroupB. This is because the sync client doesn't know the cloud group membership references. This behavior is by design.

- **No SOA transfer of nested groups:** If you have nested groups in AD and want to transfer the SOA of the parent or top group from AD to Microsoft Entra ID, only the parent group’s SOA is converted. Nested groups in the parent group continue to be AD groups. You need to convert the SOA of any nested groups one-by-one. We recommend you start with the group that is lowest hierarchy, and move up the tree.

- **Extension Attributes (1-15):** Extension attributes 1 – 15 aren't supported on cloud security groups and aren't supported after SOA is converted.

## Related content

- [Group SOA overview](concept-source-of-authority-overview.md)
- [Provision groups to Active Directory using Microsoft Entra Cloud Sync](/entra/identity/hybrid/cloud-sync/tutorial-group-provisioning)