---
title: 'Tutorial: Configure Sigma Computing for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Sigma Computing.

author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Sigma Computing so that I can streamline the user management process and ensure that users have the appropriate access to Sigma Computing.
---

# Tutorial: Configure Sigma Computing for automatic user provisioning

This tutorial describes the steps you need to perform in both Sigma Computing and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Sigma Computing](https://www.sigmacomputing.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Sigma Computing
> * Remove users in Sigma Computing when they do not require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Sigma Computing
> * Provision groups and group memberships in Sigma Computing
> * [Single sign-on](./sigma-computing-tutorial.md) to Sigma Computing (recommended)

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* An admin account in your Sigma organization.
* An existing [SSO](./sigma-computing-tutorial.md) integration with Sigma Computing.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Sigma Computing](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-sigma-computing-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Sigma Computing to support provisioning with Microsoft Entra ID

1. Log in to your Sigma account.

2. Navigate to the **Admin Portal** by selecting **Administration** from the user menu.

3. In the left panel, click **Authentication** to open your organization’s Authentication page.

4. Ensure the **Authentication Method** is **SAML** only.

5. Click the **Setup** button under **Account Type and Team Provisioning** to open the Provisioning modal.

   ![Role](media/sigma-computing-provisioning-tutorial/sigma-role-and-team-provisioning.png)

6. Read through the notes provided on the getting started section of the Provisioning modal. Check the confirmation box, and click **Next** to continue.

7. Enter a Token name and click **Next**.

   ![Next](media/sigma-computing-provisioning-tutorial/sigma-create-token.png)

8. Sigma will provide you with a **Bearer Token** and **Directory Base URL**. Copy and save these values in a secure location. These values will be entered in the **Tenant URL** and **Secret Token** field in the Provisioning tab of your Sigma Computing application. Click **Done**.

   ![Sigma](media/sigma-computing-provisioning-tutorial/sigma-copy-keys.png)
   
<a name='step-3-add-sigma-computing-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Sigma Computing from the Microsoft Entra application gallery

Add Sigma Computing from the Microsoft Entra application gallery to start managing provisioning to Sigma Computing. If you have previously setup Sigma Computing for SSO, you can use the same application. However it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who will be in scope for provisioning 

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user / group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need additional roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to Sigma Computing 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-sigma-computing-in-azure-ad'></a>

### To configure automatic user provisioning for Sigma Computing in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

   ![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Sigma Computing**.

   ![The Sigma Computing link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

   ![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

   ![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Sigma Computing Tenant URL and Secret Token. Click **Test Connection** to ensure Microsoft Entra ID can connect to Sigma Computing. If the connection fails, ensure your Sigma Computing account has Admin permissions and try again.

   ![Auth](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Sigma Computing**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Sigma Computing in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Sigma Computing for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you will need to ensure that the Sigma Computing API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported For Filtering|
   |---|---|---|
   |userName|String|&check;|
   |userType|String|
   |active|Boolean|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|


10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Sigma Computing**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Sigma Computing in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Sigma Computing for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported For Filtering|
      |---|---|---|
      |displayName|String|&check;|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Sigma Computing, change the **Provisioning Status** to **On** in the **Settings** section.

   ![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Sigma Computing by choosing the desired values in **Scope** in the **Settings** section.

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

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
