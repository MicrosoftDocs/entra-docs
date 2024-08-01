---
title: 'Tutorial: Configure Tailscale for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Tailscale.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Tailscale so that I can streamline the user management process and ensure that users have the appropriate access to Tailscale.
---

# Tutorial: Configure Tailscale for automatic user provisioning

This tutorial describes the steps you need to perform in both Tailscale and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to [Tailscale](https://tailscale.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Tailscale.
> * Remove users in Tailscale when they do not require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Tailscale.
> * Provision groups and group memberships in Tailscale.
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Tailscale (recommended).

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Tailscale with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine  who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Tailscale](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-tailscale-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Tailscale to support provisioning with Microsoft Entra ID

You need to be an [Owner, Admin, or IT admin](https://tailscale.com/kb/1138/user-roles/) in Tailscale to complete these steps. See [Tailscale plans](https://tailscale.com/pricing/) to find out which plans make user & group provisioning for Microsoft Entra available.

### Generate a SCIM API key in Tailscale.

In the **[User management](https://login.tailscale.com/admin/settings/user-management/)** page of the admin console,

1. Click **Enable Provisioning**.
1. Copy the generated key to the clipboard.

Save the key information in a secure spot. This is the Secret Token you will need to use it when you configure provisioning in Microsoft Entra ID.

<a name='step-3-add-tailscale-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Tailscale from the Microsoft Entra application gallery

Add Tailscale from the Microsoft Entra application gallery to start managing provisioning to Tailscale. If you have previously setup Tailscale for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

The Microsoft Entra provisioning service allows you to scope who is provisioned based on assignment to the application and/or based on attributes of the user / group. If you choose to scope who is provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users to the application. If you choose to scope who is provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need more roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to Tailscale 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Tailscale based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-tailscale-in-azure-ad'></a>

### To configure automatic user provisioning for Tailscale in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Tailscale**.

	![Screenshot of the Tailscale link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Tailscale Tenant URL and Secret Token. Click **Test Connection** to ensure Microsoft Entra ID can connect to Tailscale. If the connection fails, ensure your Tailscale account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Tailscale**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Tailscale in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Tailscale for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Tailscale API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Tailscale|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean|&check;|
   |displayName|String|&check;|
   |preferredLanguage|String|&check;|
   |name.givenName|String|&check;|
   |name.familyName|String|&check;|
   |name.formatted|String|&check;|
   |emails[type eq "work"].value|String|&check;|
   |externalId|String|&check;|&check;

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Tailscale**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Tailscale in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Tailscale for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Tailscale|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |externalId|String||&check;
   |members|Reference||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Tailscale, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Tailscale by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, click **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it's to completion
* If the provisioning configuration seems to be in an unhealthy state, the application goes into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## Change log

* 11/21/2023 - Added support for **Group Provisioning**.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
