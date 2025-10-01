---
title: Configure Notion for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Notion.
author: jeevansd
manager: pmwongera
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Notion so that I can streamline the user management process and ensure that users have the appropriate access to Notion.
---

# Configure Notion for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Notion and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Notion](https://notion.so) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Notion.
> * Remove users in Notion when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Notion.
> * Provision groups and group memberships in Notion.
> * [Single sign-on](notion-tutorial.md) to Notion (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Notion with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Notion](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-notion-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Notion to support provisioning with Microsoft Entra ID
1. Log in to your Notion Workspace, open the **Settings and Members → Identity & Provisioning** tab and scroll down to the **SCIM provisioning** section.
1. If a token hasn’t already been generated, select **+ Add token** and copy the token. You’ll enter this token as your Secret Token in step 5.5.
1. Notion’s SCIM tenant URL is `https://www.notion.so/scim/v2`, which you’ll use in step 5.5.


<a name='step-3-add-notion-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Notion from the Microsoft Entra application gallery

Add Notion from the Microsoft Entra application gallery to start managing provisioning to Notion. If you have previously setup Notion for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Notion 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-notion-in-azure-ad'></a>

### To configure automatic user provisioning for Notion in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Notion**.

	![Screenshot of the Notion link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Notion Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Notion. If the connection fails, ensure your Notion account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Notion**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Notion in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Notion for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Notion API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Notion|
   |---|---|---|---|
   |userName|String|&check;|&check;   
   |name.formatted|String||&check;  
   |active|Boolean||&check;  

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Notion**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Notion in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Notion for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Notion|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |members|Reference||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Notion, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Notion by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
