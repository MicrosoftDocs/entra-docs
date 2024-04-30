---
title: 'Tutorial: Configure ProdPad for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to ProdPad.

documentationcenter: ''
author: twimmers
writer: Thwimmer
manager: jeedes

ms.assetid: 57511d3c-905a-4de5-9cc9-1a08bd7b8457
ms.service: entra-id
ms.subservice: saas-apps


ms.topic: tutorial
ms.date: 11/21/2022
ms.author: Thwimmer

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to ProdPad so that I can streamline the user management process and ensure that users have the appropriate access to ProdPad.
---

# Tutorial: Configure ProdPad for automatic user provisioning

This tutorial describes the steps you need to perform in both ProdPad and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [ProdPad](https://www.prodpad.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in ProdPad.
> * Remove users in ProdPad when they do not require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and ProdPad.
> * [Single sign-on](prodpad-tutorial.md) to ProdPad.

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (for example, Application Administrator, Cloud Application administrator, Application Owner, or Global Administrator). 
* A user account in ProdPad with Admin permissions.


## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and ProdPad](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-prodpad-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure ProdPad to support provisioning with Microsoft Entra ID

1. Login to [ProdPad admin console](https://app.prodpad.com/).
1. Navigate to **Profile Settings**.

	![Profile](media/prodpad-provisioning-tutorial/profile-settings.png)

1. Navigate to **API key** to get your API key. If you need to regenerate your API key, click the regenerate key. Please note this will also make the previous API key as invalid.

	![API Key](media/prodpad-provisioning-tutorial/api-key.png)

1. Copy and save the **API key**. This value will be entered in the **Secret Token** field in the Provisioning tab of your ProdPad application.

<a name='step-3-add-prodpad-from-the-azure-ad-application-gallery'></a>

## Step 3: Add ProdPad from the Microsoft Entra application gallery

Add ProdPad from the Microsoft Entra application gallery to start managing provisioning to ProdPad. If you have previously setup [ProdPad for SSO](prodpad-tutorial.md), you can use the same application. However it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who will be in scope for provisioning 

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user / group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need additional roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to ProdPad 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in ProdPad based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-prodpad-in-azure-ad'></a>

### To configure automatic user provisioning for ProdPad in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **ProdPad**.

	![The ProdPad link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your ProdPad Tenant URL and Secret Token. Click **Test Connection** to ensure Microsoft Entra ID can connect to ProdPad. If the connection fails, ensure your ProdPad account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to ProdPad**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to ProdPad in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in ProdPad for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you will need to ensure that the ProdPad API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by ProdPad|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |emails[type eq "work"].value|String||&check; 
   |active|Boolean||; 
   |name.givenName|String||; 
   |name.familyName|String||; 

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for ProdPad, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to ProdPad by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you are ready to provision, click **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion
* If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## Troubleshooting Tips
Reach out to [ProdPad support team](mailto:help@prodpad.com) in case of any issues.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
