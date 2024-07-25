---
title: 'Tutorial: Configure Gtmhub for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Gtmhub.


author: thomasakelo
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Gtmhub so that I can streamline the user management process and ensure that users have the appropriate access to Gtmhub.
---

# Tutorial: Configure Gtmhub for automatic user provisioning

This tutorial describes the steps you need to perform in both Gtmhub and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Gtmhub](https://www.gtmhub.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 

>[!NOTE]
>Currently, when automatic user provisioning is configured, Microsoft Entra-only automatically de-provisions users and groups to Gtmhub as well as map users to their respective teams using the Microsoft Entra provisioning service.But in 2021 once SSO is enabled with Gtmhub,users will be automatically provisioned when they log in through SSO and will be assigned to their respective team.


## Capabilities Supported
> [!div class="checklist"]
> * Remove users in Gtmhub when they do not require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Gtmhub.
> * Map users into their teams automatically and align them.

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* An Enterprise Gtmhub account.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Gtmhub](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-gtmhub-to-support-team-mapping-and-user-de-provisioning-with-azure-ad'></a>

## Step 2: Configure Gtmhub to support team mapping and user de-provisioning with Microsoft Entra ID

In order to connect your provisioning application to your Gtmhub account you will need to issue a SCIM token and compile the tenant URL.

### To issue a new SCIM token:

1. Sign in to your **Gtmhub account**. Navigate to **Settings > Configuration > API Tokens**.

    ![API Tokens tab](media/gtmhub-provisioning-tutorial/api-tokens.png)
2. Click on **Issue Token** and select **SCIM**. Enter a name for the token and click the **Generate API Token** button.

    ![Generate Tokens tab](media/gtmhub-provisioning-tutorial/generate-token.png)
3. Once the token is generated you can copy and use it in your Microsoft Entra provisioning application.

    ![Copy Token](media/gtmhub-provisioning-tutorial/token.png)

### To compile the tenant URL:

1. Your tenant URL has to be in the following format:

    `https://app.gtmhub.com/api/v1/scim/azure/{account_id}`

2. If your Gtmhub account is located in the US data center you will also have to add the data center to the URL:
    
     `https://app.us.gtmhub.com/api/v1/scim/azure/{account_id}`

3. To get the account ID go to **Settings** then select the **API Tokens** tab and copy the account ID:
    ![Account ID](media/gtmhub-provisioning-tutorial/account-id.png)

<a name='step-3-add-gtmhub-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Gtmhub from the Microsoft Entra application gallery

Add Gtmhub from the Microsoft Entra application gallery to start managing provisioning to Gtmhub. If you have previously setup Gtmhub for SSO you can use the same application. However it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who will be in scope for provisioning 

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user / group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need additional roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to Gtmhub 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-gtmhub-in-azure-ad'></a>

### To configure automatic user provisioning for Gtmhub in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Gtmhub**.

	![The Gtmhub link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Gtmhub Tenant URL and Secret Token. Click **Test Connection** to ensure Microsoft Entra ID can connect to Gtmhub. If the connection fails, ensure your Gtmhub account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Gtmhub**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Gtmhub in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Gtmhub for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you will need to ensure that the Gtmhub API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |externalId|String|&check;|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference|

10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Gtmhub, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Gtmhub by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you are ready to provision, click **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion
* If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).  

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
