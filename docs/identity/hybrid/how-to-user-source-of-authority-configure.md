---
title: Configure User Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to convert user management from Active Directory Domain Services (AD DS) to Microsoft Entra ID by using user Source of Authority (SOA).
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 08/07/2025
ms.reviewer: dhanyak

#CustomerIntent: As a user administrator, I want to change the source of authority for a synced hybrid user so that their attributes can be fully managed in the cloud.
---

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.

This template provides the basic structure of a How-to article pattern. See the
[instructions - How-to](../level4/article-how-to-guide.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

How-to is a procedure-based article pattern that show the user how to complete a task in their own environment. A task is a work activity that has a definite beginning and ending, is observable, consist of two or more definite steps, and leads to a product, service, or decision.

-->

<!-- 1. H1 -----------------------------------------------------------------------------

Required: Use a "<verb> * <noun>" format for your H1. Pick an H1 that clearly conveys the task the user will complete.

For example: "Migrate data from regular tables to ledger tables" or "Create a new Azure SQL Database".

* Include only a single H1 in the article.
* Don't start with a gerund.
* Don't include "Tutorial" in the H1.

-->

# Configure User Source of Authority (SOA) (Preview)

<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the customer will do. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don't use a bulleted list of article H2 sections.

Example: In this article, you will migrate your user databases from IBM Db2 to SQL Server by using SQL Server Migration Assistant (SSMA) for Db2.

-->

This article explains the prerequisites, and steps, to configure User Source of Authority (SOA). This article also explains how to revert changes, and current feature limitations. For a full overview for User SOA, see [Embrace cloud-first posture: Convert User Source of Authority to the cloud (Preview)](test.md).

<!---Avoid notes, tips, and important boxes. Readers tend to skip over them. Better to put that info directly into the article text.

-->

<!-- 3. Prerequisites --------------------------------------------------------------------

Required: Make Prerequisites the first H2 after the H1. 

* Provide a bulleted list of items that the user needs.
* Omit any preliminary text to the list.
* If there aren't any prerequisites, list "None" in plain text, not as a bulleted item.

-->

## Prerequisites

| Requirement | Description |
|-------------|-------------|
| **Roles** | [Hybrid Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-administrator) is required to call the Microsoft Graph APIs to read and update SOA of users.<br>[Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) is required to grant user consent to the required permissions to Microsoft Graph Explorer or the app used to call the Microsoft Graph APIs. |
| **Permissions** | For apps calling into the `onPremisesSyncBehavior` Microsoft Graph API, the `Group-OnPremisesSyncBehavior.ReadWrite.All` permission scope needs to be granted. For more information, see [how to grant this permission](#grant-permission-to-apps) to Graph Explorer or an existing app in your tenant. |
| **License needed** | Microsoft Entra Free or Basic license. |
| **Connect Sync client** | Minimum version is [2.5.76.0](/entra/identity/hybrid/connect/reference-connect-version-history#25760) |
| **Cloud Sync client** | Minimum version is [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700)|

<!-- 4. Task H2s ------------------------------------------------------------------------------

Required: Multiple procedures should be organized in H2 level sections. A section contains a major grouping of steps that help users complete a task. Each section is represented as an H2 in the article.

For portal-based procedures, minimize bullets and numbering.

* Each H2 should be a major step in the task.
* Phrase each H2 title as "<verb> * <noun>" to describe what they'll do in the step.
* Don't start with a gerund.
* Don't number the H2s.
* Begin each H2 with a brief explanation for context.
* Provide a ordered list of procedural steps.
* Provide a code block, diagram, or screenshot if appropriate
* An image, code block, or other graphical element comes after numbered step it illustrates.
* If necessary, optional groups of steps can be added into a section.
* If necessary, alternative groups of steps can be added into a section.

-->

## Setup

You need to set up Connect Sync client and the Microsoft Entra Provisioning agent.

### Connect Sync client

1. Download the latest version of the Connect Sync build.

1. Verify the Connect Sync build is successfully installed. Go to **Programs** in Control Panel and confirm that the version of Microsoft Entra Connect Sync is [2.5.76.0](/entra/identity/hybrid/connect/reference-connect-version-history#25760).

### Cloud Sync client

Download the Microsoft Entra Provisioning agent with build version [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700) or later.

1. Follow the [instructions to download the Cloud Sync client](/entra/identity/hybrid/cloud-sync/reference-version-history#download-link).

1. Learn how to [identify the agent's current version](/azure/active-directory/hybrid/cloud-sync/how-to-automatic-upgrade).

1. Follow the [instructions to configure provisioning from AD DS to Microsoft Entra ID](/entra/identity/hybrid/cloud-sync/how-to-configure).

## Grant permission to apps

You can grant permission in the Microsoft Entra admin center or in Graph Explorer. This highly privileged operation requires the Application Administrator or Cloud Application Administrator role. You can also grant consent by using PowerShell. For more information, see [Grant consent on behalf of a single user](/entra/identity/enterprise-apps/grant-consent-single-user?pivots=ms-graph).

### Custom apps

Follow these steps to grant `User-OnPremisesSyncBehavior.ReadWrite.All` permission to the corresponding app. For more information about how to add new permissions to your app registration and grant consent, see [Update an app's requested permissions in Microsoft Entra ID](/entra/identity-platform/howto-update-permissions). 

### Use Microsoft Entra admin center to grant permission to apps 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) or a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Enterprise Applications** > ***App name***.

1. Select **Permissions** > **Grant admin consent for *tenant name***.

1. Sign in again as an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) or a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 

1. Review the list of permissions that require your consent, and select **Accept**.

1. You can see the list of permissions that you granted:

:::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/permission.png" alt-text="Screenshot of how to validate a permission is granted.":::

### Use Microsoft Graph Explorer to grant permission to apps 

1. Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in as an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

1.	Select the profile icon, and select **Consent to permissions**. 

1. Search for User-OnPremisesSyncBehavior, and select **Consent** for the permission.
    :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/consent.png" alt-text="Screenshot of how to grant consent to user-OnPremisesSyncBehavior.ReadWrite permission." lightbox="media/how-to-user-source-of-authority-configure/consent.png":::

## Convert SOA for a test user

Follow these steps to convert the SOA for a test user:

1. Create a user within AD. You can also use an existing user that is synced to Microsoft Entra ID by using Connect Sync.
1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Verify that the user appears in the Microsoft Entra admin center as a synced user.
1. Use Microsoft Graph API to convert the SOA of the user object (*isCloudManaged*=true). Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in with an appropriate user role, such as user admin.
1. Let's check the existing SOA status. We didn’t update the SOA yet, so the *isCloudManaged* attribute value should be false. Replace the *{ID}* in the following examples with the object ID of your group. For more information about this API, see [Get onPremisesSyncBehavior](/graph/api/onpremisessyncbehavior-get).
/graph/api/onpremisessyncbehavior-update

   ```https
   GET https://graph.microsoft.com/beta/users/{ID}/onPremisesSyncBehavior?$select=isCloudManaged
   ```

   :::image type="content" source="media/how-to-user-source-of-authority-configure/get-user.png" alt-text="Screenshot of how to use Microsoft Graph Explorer to get the SOA value of an user.":::

1. Confirm that the synced user is read-only. Because the user is managed on-premises, any write attempts to the user in the cloud fail. The error message differs for mail-enabled users, but updates still aren't allowed.

   > [!NOTE]
   > If this API fails with 403, use the **Modify permissions** tab to grant consent to the required User.ReadWrite.All permission.

   ```https
   PATCH https://graph.microsoft.com/v1.0/users/{ID}/
      {
        "DisplayName": "User Name Updated"
      }   
   ```

   :::image type="content" source="media/how-to-user-source-of-authority-configure/try-update.png" alt-text="Screenshot of an attempt to update a user to verify it's read-only.":::
 
1. Search the Microsoft Entra admin center for the user. Verify that all user fields are greyed out, and that source is Windows Server AD DS:  

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/basic.png" alt-text="Screenshot of basic group properties.":::

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/properties.png" alt-text="Screenshot of advanced group properties.":::

1. Now you can update the SOA of the user to be cloud-managed. Run the following operation in Microsoft Graph Explorer for the group object you want to convert to the cloud. For more information about this API, see [Update onPremisesSyncBehavior](/graph/api/onpremisessyncbehavior-update).

   ```https
   PATCH https://graph.microsoft.com/beta/users/{ID}/onPremisesSyncBehavior
      {
        "isCloudManaged": true
      }   
   ```

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/switch.png" alt-text="Screenshot of PATCH operation to update user properties.":::

1. To validate the change, call GET to verify *isCloudManaged* is true.

   ```https
   GET https://graph.microsoft.com/beta/users/{ID}/onPremisesSyncBehavior?$select=isCloudManaged
   ```

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/cloud-managed.png" alt-text="Screenshot of GET call to verify user properties.":::

1. Confirm the change in the Audit Logs. To access Audit Logs in the Azure portal, open **Manage Microsoft Entra ID** > **Monitoring** > **Audit Logs**, or search for *audit logs*. Select **Change Source of Authority from AD to cloud** as the activity.

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/audit.png" alt-text="Screenshot of change to user properties in Audit Logs.":::

1. Check that the user can be updated in the cloud.

   ```https
   PATCH https://graph.microsoft.com/v1.0/users/{ID}/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/retry-update.png" alt-text="Screenshot of a retry to change user properties.":::

1. Open Microsoft Entra admin center and confirm that the group **Source** property is **Cloud**.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/source-cloud.png" alt-text="Screenshot of how to confirm user source property.":::


## Connect Sync client

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. To look at the user object with converted SOA, in the **Synchronization Service Manager**, go to **Connectors**:

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/connectors.png" alt-text="Screenshot of Connectors.":::

1. Right-click **Active Directory Domain Services Connector**. Search for the user by the relative domain name (RDN) setting "CN=\<UserName\>":

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/search.png" alt-text="Screenshot of how to search for RDN.":::

1. Double-click the searched entry, and select **Lineage** > **Metaverse Object Properties**.

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/lineage.png" alt-text="Screenshot of how to view lineage.":::

1. Select **Connectors** and double-click the **Entra ID object** with "CN={\<Alphanumeric Characters\>}".

1. You can see that the **blockOnPremisesSync** property is set to true on the Entra ID object. This property value means that any changes made in the corresponding AD DS object don't flow to the Entra ID object:

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/block.png" alt-text="Screenshot of how to block data flow.":::

1. Let’s update the on-premises user object. We'll change the user name from *TestUserF1* to *TestUserF1.1*:

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/change-name.png" alt-text="Screenshot of how to change the object name.":::

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Open Event viewer and filter the Application log for event ID 6956. This event ID is reserved to inform the customers that the object isn't synced to the cloud because the SOA of the object is in the cloud.

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/event-6956.png" alt-text="Screenshot of event ID 6956.":::


## Bulk updates for Group SOA

You can use the following PowerShell script to automate User SOA updates by using app-based authentication.

```powershell
# Define your Microsoft Entra ID app details and tenant information
$tenantId = ""
$clientId = ""
$certThumbprint = ""

# Connect to Microsoft Graph as App-Only using a certificate. The app registration must have the User.Read.All User-OnPremisesSyncBehavior.ReadWrite.All permissions granted.
Connect-MgGraph -ClientId $clientId -TenantId $tenantId -CertificateThumbprint $certThumbprint

#Connect to Microsoft Graph using delegated permissions
#Connect-MgGraph -Scopes "User.Read.All User-OnPremisesSyncBehavior.ReadWrite.All" -TenantId $tenantId

# Define the user name you want to query
$userName = "Ken Roy"

# Retrieve the group using group name
$user = Get-MgBetaUser -Filter "displayName eq '$userName'"

# Ensure user is found
if ($null -ne $user)
{
    $userObjectID = $($user.Id)
    # Define the Microsoft Graph API endpoint for the user
    $url = "https://graph.microsoft.com/beta/users/$userObjectID/onPremisesSyncBehavior"

    # Define the JSON payload for the PATCH request
    $jsonPayload = @{
        isCloudManaged = "true"
    } | ConvertTo-Json

    # Make the PATCH request to update the JSON payload
    Invoke-MgGraphRequest -Uri $url -Method Patch -ContentType "application/json" -Body $jsonPayload

    $result = Invoke-MgGraphRequest -Method Get -Uri "https://graph.microsoft.com/beta/users/$userObjectID/onPremisesSyncBehavior?`$select=id,isCloudManaged"

    Write-Host "User Name: $($user.DisplayName)"
    Write-Host "User ID: $($result.id)"
    Write-Host "SOA Converted: $($result.isCloudManaged)"
}
else 
{
    Write-Warning "User '$userName' not found."
}
```


### Status of attributes after you convert SOA

The following table explains the status for *isCloudManaged* and *onPremisesSyncEnabled* attributes after you convert the SOA of an object.

Admin step | isCloudManaged value | onPremisesSyncEnabled value | Description  
-----|----------------------|----------------------|------------
Admin syncs an object from AD DS to Microsoft Entra ID | `false` | `true` | When an object is originally synchronized to Microsoft Entra ID, the *onPremisesSyncEnabled* attribute is set to `true` and *isCloudManaged* is set to `false`.  
Admin converts the source of authority (SOA) of the object to the cloud | `true` | `null` | After an admin converts the SOA of an object to the cloud, the *isCloudManaged* attribute becomes set to `true` and the *onPremisesSyncEnabled* attribute value is set to `null`. 
Admin rolls back the SOA operation | `false` | `null` | If an admin converts the SOA back to AD, the *isCloudManaged* is set to `false` and *onPremisesSyncEnabled* is set to `null` until the sync client takes over the object.    
Admin creates a cloud native object in Microsoft Entra ID | `false` | `null` | If an admin creates a new cloud-native object in Microsoft Entra ID, *isCloudManaged* is set to `false` and *onPremisesSyncEnabled* is set to `null`.


## Roll back SOA update

> [!IMPORTANT] 
> Make sure that the users that you roll back have no cloud references. Remove cloud users from SOA converted groups, and remove these groups from access packages before you roll back the users to AD DS. The sync client takes over the object in the next sync cycle.

You can run this operation to roll back the SOA update and revert the SOA to on-premises. 

   ```https
   PATCH https://graph.microsoft.com/beta/users/{ID}/onPremisesSyncBehavior
      {
        "isCloudManaged": false
      }   
   ```

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/rollback.png" alt-text="Screenshot of API call to revert SOA.":::

> [!NOTE]
> The change of *isCloudManaged* to `false` allows an AD DS object that's in scope for sync to be taken over by Connect Sync the next time it runs. Until the next time Connect Sync runs, the object can be edited in the cloud. The rollback of SOA is finished only after *both* the API call and the next scheduled or forced run of Connect Sync are complete.

### Validate the change in the Audit Logs

Select activity as **Undo changes to Source of Authority from AD DS to cloud**:

:::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/audit-undo-changes.png" alt-text="Screenshot of Undo Changes in Audit Logs.":::

## Validate in Connect Sync client

1. Run the following command to start Connect Sync: 

   ```powershell
   Start-ADSyncSyncCycle
   ```

1. Open the object in the **Synchronization Server Manager** (details are in the [Connect Sync Client](#connect-sync-client) section). You can see the state of the Microsoft Entra ID connector object is **Awaiting Export Confirmation** and *blockOnPremisesSync* = false, which means the object SOA is taken over by the on-premises again.

   :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/await-export.png" alt-text="Screenshot of an object awaiting export.":::

## Limitations

- **No reconciliation support for local AD groups**: An AD DS admin (or an application with sufficient permissions) can directly modify an AD DS group. If Group SOA is converted for the group, or if cloud security group provisioning to AD DS is enabled, those local AD changes aren't reflected in Microsoft Entra ID. When a change to the cloud security group is made, any local AD DS changes are overwritten when group provisioning to AD DS runs.

<!-- 5. Next step/Related content------------------------------------------------------------------------

Optional: You have two options for manually curated links in this pattern: Next step and Related content. You don't have to use either, but don't use both.
  - For Next step, provide one link to the next step in a sequence. Use the blue box format
  - For Related content provide 1-3 links. Include some context so the customer can determine why they would click the link. Add a context sentence for the following links.

-->


## Related content

TODO: Add your next step link(s)

- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->

