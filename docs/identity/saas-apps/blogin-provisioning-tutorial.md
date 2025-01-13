---
title: 'Tutorial: Configure BlogIn for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to BlogIn.


author: thomasakelo
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to BlogIn so that I can streamline the user management process and ensure that users have the appropriate access to BlogIn.
---

# Tutorial: Configure BlogIn for automatic user provisioning

This tutorial describes the steps you need to perform in both BlogIn and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to [BlogIn](https://blogin.co/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in BlogIn
> * Remove users in BlogIn when they do not require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and BlogIn
> * Provision groups and group memberships in BlogIn
> * [Single sign-on](./blogin-tutorial.md) to BlogIn (recommended)

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A user account in BlogIn with Administrator role.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and BlogIn](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-blogin-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure BlogIn to support provisioning with Microsoft Entra ID

To configure user provisioning on **BlogIn**, login to your BlogIn account and follow these steps:

1. Navigate to **Settings** > **User Authentication** > **Configure SSO & User provisioning**.
2. Switch to the **User provisioning** tab and change User provisioning status to **On**.
3. Click the **Save changes** button. Upon first save, the **Secret (Bearer) token** will be generated.
4. Copy **Base (Tenant) URL** and **Secret (Bearer) token** values. These values will be entered in the Tenant URL and Secret Token fields in the Provisioning tab of your BlogIn application.

For a more detailed explanation of setting up user provisioning on BlogIn, see [Set up User Provisioning via SCIM](https://blogin.co/blog/set-up-user-provisioning-via-scim-254/). Please reach out to the [BlogIn support team](mailto:support@blogin.co) if you have any questions or need help.

<a name='step-3-add-blogin-from-the-azure-ad-application-gallery'></a>

## Step 3: Add BlogIn from the Microsoft Entra application gallery

Add BlogIn from the Microsoft Entra application gallery to start managing provisioning to BlogIn. If you have previously setup BlogIn for SSO, you can use the same application. However it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who will be in scope for provisioning 

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user / group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need additional roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to BlogIn 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-blogin-in-azure-ad'></a>

### To configure automatic user provisioning for BlogIn in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

    ![Screenshot shows the Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **BlogIn**.

    ![Screenshot shows the BlogIn link in the Applications list.](common/all-applications.png)

3. Select the **Provisioning** tab.

    ![Screenshot shows the Provisioning tab.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

    ![Screenshot shows the Provisioning tab automatic.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your BlogIn Tenant URL and Secret Token. Click **Test Connection** to ensure Microsoft Entra ID can connect to BlogIn. If the connection fails, ensure your BlogIn account has Admin permissions and try again.

    ![Screenshot shows the Token.](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

    ![Screenshot shows the Notification Email.](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to BlogIn**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to BlogIn in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in BlogIn for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you will need to ensure that the BlogIn API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |active|Boolean|
   |title|String|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|
   |name.formatted|String|
   |phoneNumbers[type eq "work"].value|String|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to BlogIn**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to BlogIn in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in BlogIn for update operations. Select the **Save** button to commit any changes.

    |Attribute|Type|
    |---|---|
    |displayName|String|
    |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for BlogIn, change the **Provisioning Status** to **On** in the **Settings** section.

    ![Screenshot shows the Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to BlogIn by choosing the desired values in **Scope** in the **Settings** section.

    ![Screenshot shows the Provisioning Scope.](common/provisioning-scope.png)

15. When you are ready to provision, click **Save**.

    ![Screenshot shows the Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

Once you've configured provisioning, use the following resources to monitor your deployment:

1. Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
2. Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion
3. If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)