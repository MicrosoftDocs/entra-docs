---
title: Configure Rollbar for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Rollbar.

author: jeevansd
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Rollbar so that I can streamline the user management process and ensure that users have the appropriate access to Rollbar.
---

# Configure Rollbar for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Rollbar and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Rollbar](https://rollbar.com/pricing/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Rollbar
> * Remove users in Rollbar when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Rollbar
> * Provision groups and group memberships in Rollbar
> * [Single sign-on](./rollbar-tutorial.md) to Rollbar (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (like [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications)). 
* [A Rollbar tenant](https://rollbar.com/pricing/) that has an Enterprise Plan.
* A user account in Rollbar with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Rollbar](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-rollbar-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Rollbar to support provisioning with Microsoft Entra ID

Before configuring Rollbar for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on Rollbar.

1. Sign in to your [Rollbar Admin Console](https://rollbar.com/login/). Select **Account Settings**.

	![Rollbar Admin Console](media/rollbar-provisioning-tutorial/image00.png)

2. Navigate to your **Rollbar Tenant Name > Identity Provider**.

	![Rollbar Identity Provider](media/rollbar-provisioning-tutorial/idp.png)

3. Scroll down to **Provisioning Options**. Copy the access token. This value is entered in the **Secret Token** field in the provisioning tab of your Rollbar application. Select the **Enable user and team provisioning** checkbox and select **Save**.

	![Rollbar Access Token](media/rollbar-provisioning-tutorial/token.png)


<a name='step-3-add-rollbar-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Rollbar from the Microsoft Entra application gallery

Add Rollbar from the Microsoft Entra application gallery to start managing provisioning to Rollbar. If you have previously setup Rollbar for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Rollbar 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-rollbar-in-azure-ad'></a>

### To configure automatic user provisioning for Rollbar in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Rollbar**.

	![The Rollbar link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input the access token value retrieved earlier in **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Rollbar. If the connection fails, ensure your Rollbar account has admin permissions and try again.

 	![Provisioning](./media/rollbar-provisioning-tutorial/admin.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Rollbar**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Rollbar in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Rollbar for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Rollbar API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |externalId|String|
   |active|Boolean|
   |name.familyName|String|
   |name.givenName|String|
   |emails[type eq "work"]|String|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Rollbar**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Rollbar in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Rollbar for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|
      |---|---|
      |displayName|String|
      |externalId|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Rollbar, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Rollbar by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
