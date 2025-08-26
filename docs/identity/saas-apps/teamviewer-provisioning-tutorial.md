---
title: Configure TeamViewer for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to TeamViewer.

author: adimitui
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 04/30/2024
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to TeamViewer so that I can streamline the user management process and ensure that users have the appropriate access to TeamViewer.
---

# Configure TeamViewer for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both TeamViewer and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [TeamViewer](https://www.teamviewer.com/buy-now/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in TeamViewer
> * Remove users in TeamViewer when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and TeamViewer
> * [Single sign-on](./teamviewer-tutorial.md) to TeamViewer (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (like [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications)). 
* A valid [Tensor license](https://www.teamviewer.com/de/teamviewer-tensor/) for TeamViewer.
* A valid custom identifier from the [Single Sign-On](https://community.teamviewer.com/English/kb/articles/110134-single-sign-on-for-microsoft-entra-id) configuration available.

> [!NOTE]
> This requires a Microsoft Entra Premium license subscription.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and TeamViewer](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-teamviewer-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure TeamViewer to support provisioning with Microsoft Entra ID

1. Log in to [TeamViewer Management Console](https://login.teamviewer.com). Navigate to **Admin settings**.
1. In the Authentication section, select **Apps and token**.
1. Select Profile **settings**.
1. Select **Add app or token**.
1. Select **Create script token**.
1. Enter a name for your API token and select the following options for the token.

	### Account management

	* View online state.
	* View account data.
	* View email address.
	* View license.

	### User management

	* Create users.
	* Edit users.
	* View users.

	### User groups

	* Create user groups.
	* Delete user groups.
	* Edit user groups.
	* Read user groups.

1. Select Save, to create your script token.

## Step 3: Add TeamViewer from the Microsoft Entra application gallery

Add TeamViewer from the Microsoft Entra application gallery to start managing provisioning to TeamViewer. If you have previously setup TeamViewer for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to TeamViewer 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in TestApp based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-teamviewer-in-azure-ad'></a>

### To configure automatic user provisioning for TeamViewer in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **TeamViewer**.

	![The TeamViewer link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, enter `https://webapi.teamviewer.com/scim/v2`  in the **Tenant URL** field and enter the script token created earlier in the **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to TeamViewer. If the connection fails, ensure your TeamViewer account has Admin permissions and try again.

 	![Screenshot shows the Admin Credentials dialog box, where you can enter your Tenant U R L and Secret Token.](./media/teamViewer-provisioning-tutorial/provisioning.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to TeamViewer**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to TeamViewer in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in TeamViewer for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the TeamViewer API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |displayName|String|
   |active|Boolean|

10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for TeamViewer, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users that you would like to provision to TeamViewer by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

13. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)