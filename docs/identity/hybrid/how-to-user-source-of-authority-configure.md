---
title: Configure Group Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to convert user management from Active Directory Domain Services (AD DS) to Microsoft Entra ID by using user Source of Authority (SOA).
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 08/07/2025
ms.reviewer: dhanyak

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
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

## Prerequisites

| Requirement | Description |
|-------------|-------------|
| **Roles** | [Hybrid Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-administrator) is required to call the Microsoft Graph APIs to read and update SOA of groups.<br>[Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) is required to grant user consent to the required permissions to Microsoft Graph Explorer or the app used to call the Microsoft Graph APIs. |
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

>[!Important] 
> A known issue might prevent you from viewing the new permission associated with Source of Authority conversion feature in the Microsoft Entra admin center. If you can't view the permissions in the Microsoft Entra ID center or in Graph Explorer, follow the steps in the [Workaround for granting permission to apps](#workaround-for-granting-permission-to-apps).

This highly privileged operation requires the Application Administrator or Cloud Application Administrator role. 

### Custom apps

Follow these steps to grant `User-OnPremisesSyncBehavior.ReadWrite.All` permission to the corresponding app. For more information about how to add new permissions to your app registration and grant consent, see [Update an app's requested permissions in Microsoft Entra ID](/entra/identity-platform/howto-update-permissions). 

### Microsoft Graph Explorer

1. Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and sign in as an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

1.	Select the profile icon, and select **Consent to permissions**. 

1. Search for User-OnPremisesSyncBehavior, and select **Consent** for the permission.
    :::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/consent.png" alt-text="Screenshot of how to grant consent to user-OnPremisesSyncBehavior.ReadWrite permission." lightbox="media/how-to-user-source-of-authority-configure/consent.png":::

### Workaround for granting permission to apps

You can grant consent by using PowerShell or Microsoft Graph. For more information, see [Grant consent on behalf of a single user](/entra/identity/enterprise-apps/grant-consent-single-user?pivots=ms-graph).

## Validate that the permissions are granted 

Sign in to the Azure portal, go to **Enterprise Applications** > **App Name**, and select **Security** > **Permissions**:

:::image type="content" border="true" source="media/how-to-user-source-of-authority-configure/permission.png" alt-text="Screenshot of how to validate a permission is granted.":::

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

1. Check that the synced user is read-only. Because the user is managed on-premises, any write attempts to the user in the cloud fail. The error message differs for mail-enabled users, but updates still aren't allowed.

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

1. Check that the group can be updated in the cloud.

   ```https
   PATCH https://graph.microsoft.com/v1.0/users/{ID}/
      {
        "DisplayName": "Group1 Name Updated"
      }   
   ```

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/retry-update.png" alt-text="Screenshot of a retry to change group properties.":::

1. Open Microsoft Entra admin center and confirm that the group **Source** property is **Cloud**.

   :::image type="content" border="true" source="media/how-to-group-source-of-authority-configure/source-cloud.png" alt-text="Screenshot of how to confirm group source property.":::


## "\<verb\> * \<noun\>"
TODO: Add introduction sentence(s)
[Include a sentence or two to explain only what is needed to complete the procedure.]
TODO: Add ordered list of procedure steps
1. Step 1
1. Step 2
1. Step 3

<!-- 5. Next step/Related content------------------------------------------------------------------------

Optional: You have two options for manually curated links in this pattern: Next step and Related content. You don't have to use either, but don't use both.
  - For Next step, provide one link to the next step in a sequence. Use the blue box format
  - For Related content provide 1-3 links. Include some context so the customer can determine why they would click the link. Add a context sentence for the following links.

-->

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)

<!-- OR -->

## Related content

TODO: Add your next step link(s)

- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->

