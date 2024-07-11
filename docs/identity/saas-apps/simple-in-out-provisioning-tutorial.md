---
title: 'Tutorial: Configure Simple In/Out for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Simple In/Out.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Simple In/Out so that I can streamline the user management process and ensure that users have the appropriate access to Simple In/Out.
---

# Tutorial: Configure Simple In/Out for automatic user provisioning

This tutorial describes the steps you need to perform in both Simple In/Out and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to [Simple In/Out](https://www.simpleinout.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).


## Supported capabilities
> [!div class="checklist"]
> * Create users in Simple In/Out.
> * Remove users in Simple In/Out when they do not require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Simple In/Out.
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Simple In/Out (recommended).

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md)
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Simple In/Out with Admin permissions.

## Step 1: Plan your provisioning deployment

* Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
* Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
* Determine what data to [map between Microsoft Entra ID and Simple In/Out](~/identity/app-provisioning/customize-application-attributes.md).

## Step 2: Configure Simple In/Out to support provisioning with Microsoft Entra ID

Any one of your Simple In/Out administrator-level users can configure Single Sign On.

1. In a web browser, head to [simpleinout.com](https://www.simpleinout.com) and sign in with a Simple In/Out administrator's credentials.
1. Click **Settings** in the upper-right.
1. Click **Single Sign On** under the **ENTERPRISE** menu on the left.
1. If you are not yet on an Enterprise level plan, this settings page will alert you that you need to upgrade your plan in order to use Single Sign On. Follow the link to upgrade your plan if necessary and return to this page.
1. Be sure your provider is set to **Microsoft** and click the **Connect Single Sign On** button.
1. You will be asked to confirm that you wish to enable Single Sign On. Click **OK** to confirm.
1. Click **Reveal** on your Recovery Key and store this entire key in a safe place. **IMPORTANT!** If you are ever locked out of your Microsoft accounts and need to disconnect SSO without access, you'll be required to relay the Recovery Key to Simple In/Out technical support.
1. Click **Reveal** on your Bearer Token and make note of it. You'll need this for Step 5.6.

* When a new user is provisioned from Microsoft Entra ID to Simple In/Out, Simple In/Out will set that user's role to the default role for your organization. This role will govern the user's permissions inside Simple In/Out. For existing users that may be converted to SSO, Simple In/Out will maintain their existing role.

* After users are provisioned to Simple In/Out, any administrator-level user can edit a user's role. This is done by clicking on a user on the Simple In/Out board, then clicking the **Edit User** button that appears in the user's profile dialog.

* You can change the default role in Simple In/Out as well as customize the permissions in the role on Simple In/Out's website.

1. Within Simple In/Out's website, click **Settings** in the upper-right
1. Click **Roles** under the **USERS** menu on the left.
1. Click the **Edit** button associated with your default role as designated by the green checkmark.
1. Any settings can be changed from here and will immediately take effect.

## Step 3: Add Simple In/Out from the Microsoft Entra application gallery

Add Simple In/Out from the Microsoft Entra application gallery to start managing provisioning to Simple In/Out. If you have previously setup Simple In/Out for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who will be in scope for provisioning

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users to the application. If you choose to scope who will be provisioned based solely on attributes of the user, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* Start small. Test with a small set of users before rolling out to everyone. When scope for provisioning is set to assigned users, you can control this by assigning one or two users to the app. When scope is set to all users, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need more roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.

## Step 5: Configure automatic user provisioning to Simple In/Out

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in Simple In/Out based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-Simple In/Out-in-azure-ad'></a>

### To configure automatic user provisioning for Simple In/Out in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Simple In/Out**.

	![Screenshot of the Simple In/Out link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Simple In/Out Tenant URL and Secret Token. Click **Test Connection** to ensure Microsoft Entra ID can connect to Simple In/Out. If the connection fails, ensure your Simple In/Out account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Simple In/Out**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Simple In/Out in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Simple In/Out for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Simple In/Out API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Simple In/Out|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||
   |displayName|String|&check;|&check;
   |title|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |phoneNumbers[type eq "fax"].value|String||
   |externalId|String||&check;

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Simple In/Out**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Simple In/Out in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Simple In/Out for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Simple In/Out|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Simple In/Out, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to Simple In/Out by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, click **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running.

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it's to completion
* If the provisioning configuration seems to be in an unhealthy state, the application goes into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
