---
title: 'Tutorial: Configure Code42 for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Code42.

documentationcenter: ''
author: twimmers
writer: twimmers
manager: jeedes

ms.assetid: ddcb950b-3f9a-4ebb-bf78-4ec42d16d52d
ms.service: entra-id
ms.subservice: saas-apps

ms.tgt_pltfrm: na
ms.topic: tutorial
ms.date: 11/21/2022
ms.author: thwimmer

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Code42 so that I can streamline the user management process and ensure that users have the appropriate access to Code42.
---

# Tutorial: Configure Code42 for automatic user provisioning

This tutorial describes the steps you need to perform in both Code42 and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Code42](https://www.code42.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Code42
> * Remove users in Code42 when they do not require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Code42
> * Provision groups and group memberships in Code42
> * [Single sign-on](./code42-tutorial.md) to Code42 (recommended)

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md)
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (for example, Application Administrator, Cloud Application administrator, Application Owner, or Global Administrator).
* A Code42 tenant with Identity Management enabled.
* A Code42 user account with [Customer Cloud Admin](https://support.code42.com/hc/en-us/articles/14827655905943-Roles-reference#Customer_Cloud_Admin) permission.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Code42](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-code42-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Code42 to support provisioning with Microsoft Entra ID

This section guides you through the steps to configure Microsoft Entra ID as a provisioning provider in the Identity Management section of Code42's console. Doing so will enable Code42 to securely receive provisioning requests from Microsoft Entra ID. It is recommended to review [Code42's support documentation](https://support.code42.com/hc/en-us/articles/14827670461207-How-to-provision-users-to-Code42-from-Azure-AD) before provisioning with Microsoft Entra ID.

### To create a provisioning provider in Code42's console:

1. Sign in to your Code42 console. Select **Administration** to expand the navigation menu. Select **Settings** then **Identity Management**.
2. Select the **Provisioning** tab. Then expand the **Add provisioning provider** menu and select **Add SCIM provider**.
3. In the **Display name** field, enter a unique name for the provisioning provider. Set the **Authentication credential type** to **OAuth token**. Select **Next** to generate credentials.

> [!NOTE]
>* Keep this window open until prompted for the **Base URL** and **Token** required in the next steps.
>* Alternatively, copy this information to a temporary location for future reference.

<a name='step-3-add-code42-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Code42 from the Microsoft Entra application gallery

Add Code42 from the Microsoft Entra application gallery to start managing provisioning to Code42. If you have previously setup Code42 for SSO, you can use the same application. However it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who will be in scope for provisioning

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user / group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need additional roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to Code42

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-code42-in-azure-ad'></a>

### To configure automatic user provisioning for Code42 in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Code42**.

	![The Code42 link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input the **SCIM 2.0 base URL and Access Token** values retrieved earlier from Code42 in **Tenant URL** and **Secret Token** respectively. Click **Test Connection** to ensure Microsoft Entra ID can connect to Code42. If the connection fails, ensure your Code42 account has Admin permissions and try again.

	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Code42**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Code42 in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Code42 for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you will need to ensure that the Code42 API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |active|Boolean|
   |title|String|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|
   |addresses[type eq "work"].locality|String|
   |addresses[type eq "work"].region|String|
   |addresses[type eq "work"].country|String|
   |externalId|String|
   |userType|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Code42**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Code42 in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Code42 for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|
      |---|---|
      |displayName|String|
      |externalId|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Code42, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Code42 by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you are ready to provision, click **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running.

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

1. Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
2. Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion
3. If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Configure organization assignments based on SCIM groups in Code42](https://support.code42.com/hc/en-us/articles/14827670461207-How-to-provision-users-to-Code42-from-Azure-AD#step-6-map-users-to-organizations-and-roles-using-scim-groups-0-18)
* [Configure role assignments based on SCIM groups in Code42](https://support.code42.com/hc/en-us/articles/14827670461207-How-to-provision-users-to-Code42-from-Azure-AD#apply-organization-and-role-mappings-0-21)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
