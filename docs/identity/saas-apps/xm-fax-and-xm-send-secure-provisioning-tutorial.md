---
title: 'Tutorial: Configure XM Fax and XM SendSecure for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to XM Fax and XM SendSecure.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to XM Fax and XM SendSecure so that I can streamline the user management process and ensure that users have the appropriate access to XM Fax and XM SendSecure.
---

# Tutorial: Configure XM Fax and XM SendSecure for automatic user provisioning

This tutorial describes the steps you need to perform in both XM Fax and XM SendSecure and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to [XM Fax and XM SendSecure](https://www.opentext.com/products/xm-fax) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).


## Supported capabilities
> [!div class="checklist"]
> * Create users in XM Fax and XM SendSecure.
> * Remove users in XM Fax and XM SendSecure when they do not require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and XM Fax and XM SendSecure.
> * [Single sign-on](xm-fax-and-xm-send-secure-tutorial.md) to XM Fax and XM SendSecure (recommended).

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in XM Fax and XM SendSecure with Admin permissions.

## Step 1: Plan your provisioning deployment
* Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
* Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
* Determine what data to [map between Microsoft Entra ID and XM Fax and XM SendSecure](~/identity/app-provisioning/customize-application-attributes.md).

## Step 2: Configure XM Fax and XM SendSecure to support provisioning with Microsoft Entra ID


### Create an access token
1. In your XM Cloud enterprise account, click **Enterprise name** > **Access tokens**.
1. Create a new access token with the permission **User provisioning (using SCIM)**.
1. Copy the access token. You will need it as the **Secret Token** in Microsoft Entra ID.

### Tenant URL

* To configure the Microsoft Entra provisioning service, you will need your tenant URL.

* The tenant URL depends on the region, the name of your enterprise account and has the following scheme:
`https://<domain>/api/scim/v2/enterprises/<enterprise_name>/`

Examples:

* `https://portal.xmedius.com/api/scim/v2/enterprises/acme/`
* `https://portal.xmedius.eu/api/scim/v2/enterprises/my_corporation/`
* `https://portal.xmedius.ca/api/scim/v2/enterprises/another_company/`


## Step 3: Add XM Fax and XM SendSecure from the Microsoft Entra application gallery

Add XM Fax and XM SendSecure from the Microsoft Entra application gallery to start managing provisioning to XM Fax and XM SendSecure. If you have previously setup XM Fax and XM SendSecure for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who will be in scope for provisioning

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users to the application. If you choose to scope who will be provisioned based solely on attributes of the user, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* Start small. Test with a small set of users before rolling out to everyone. When scope for provisioning is set to assigned users, you can control this by assigning one or two users to the app. When scope is set to all users, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need more roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.

## Step 5: Configure automatic user provisioning to XM Fax and XM SendSecure

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in TestApp based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-XM Fax and XM SendSecure-in-azure-ad'></a>

### To configure automatic user provisioning for XM Fax and XM SendSecure in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **XM Fax and XM SendSecure**.

	![Screenshot of the XM Fax and XM SendSecure link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your XM Fax and XM SendSecure Tenant URL and Secret Token from Step 2. Click **Test Connection** to ensure Microsoft Entra ID can connect to XM Fax and XM SendSecure. If the connection fails, check the URL and access token are correct.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to XM Fax and XM SendSecure**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to XM Fax and XM SendSecure in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in XM Fax and XM SendSecure for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the XM Fax and XM SendSecure API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by XM Fax and XM SendSecure|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |emails[type eq "work"].value|String||&check;
   |active|Boolean||
   |title|String||
   |name.givenName|String||
   |name.familyName|String||
   |addresses[type eq "work"].streetAddress|String||
   |addresses[type eq "work"].locality|String||
   |addresses[type eq "work"].region|String||
   |addresses[type eq "work"].postalCode|String||
   |addresses[type eq "work"].country|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |phoneNumbers[type eq "fax"].value|String||
   |externalId|String||&check;
   |roles[primary eq "True"].value|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for XM Fax and XM SendSecure, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to XM Fax and XM SendSecure by choosing the desired values in **Scope** in the **Settings** section.

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