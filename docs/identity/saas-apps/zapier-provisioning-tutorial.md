---
title: Configure Zapier for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Zapier.
author: adimitui
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Zapier so that I can streamline the user management process and ensure that users have the appropriate access to Zapier.
---

# Configure Zapier for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Zapier and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Zapier](https://zapier.com/pricing) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Zapier
> * Remove users in Zapier when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Zapier
> * Provision groups and group memberships in Zapier
> * Single sign-on to Zapier (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (like [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications)). 
* A user account in Zapier with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Zapier](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-zapier-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Zapier to support provisioning with Microsoft Entra ID

1. Sign in to your [Zapier Admin Console](https://zapier.com/app/login/). Navigate to **Settings** under the tenant ID.

    ![Zapier Admin Console](media/zapier-provisioning-tutorial/admin.png)

2. Under **COMPANY SETTINGS**, Select **User provisioning**.

    ![Zapier Add SCIM](media/zapier-provisioning-tutorial/user.png)

3. Copy the **SCIM Base URL** and **SCIM Bearer Token**. These values are entered in the Tenant URL and Secret Token fields respectively in the Provisioning tab of your Zapier application.

    ![Zapier Create Token](media/zapier-provisioning-tutorial/token.png)

<a name='step-3-add-zapier-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Zapier from the Microsoft Entra application gallery

Add Zapier from the Microsoft Entra application gallery to start managing provisioning to Zapier. If you have previously setup Zapier for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Zapier 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-zapier-in-azure-ad'></a>

### To configure automatic user provisioning for Zapier in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

   ![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Zapier**.

   ![The Zapier link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Zapier **Tenant URL** and **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Zapier. If the connection fails, ensure your Zapier account has Admin permissions and try again.

   ![Screenshot shows the Admin Credentials dialog box, where you can enter your Tenant U R L and Secret Token.](./media/zapier-provisioning-tutorial/provisioning.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Zapier**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Zapier in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Zapier for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Zapier API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Variable|Type|
   |---|---|
   |userName|String|
   |active|Boolean|
   |externalId|String|
   |name.givenName|String|
   |name.familyName|String|
   |emails[type eq "work"].value|String|

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Zapier**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Zapier in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Zapier for update operations. Select the **Save** button to commit any changes.

    |Variable|Type|
    |---|---|
    |displayName|String|
    |members|Reference|

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Zapier, change the **Provisioning Status** to **On** in the **Settings** section.

    ![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Zapier by choosing the desired values in **Scope** in the **Settings** section.

    ![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

    ![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
