---
title: Configure Cleanmail Swiss for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Cleanmail Swiss.

author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Cleanmail Swiss so that I can streamline the user management process and ensure that users have the appropriate access to Cleanmail Swiss.
---

# Configure Cleanmail Swiss for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to do in both Cleanmail Swiss and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to [Cleanmail](https://www.alinto.com/fr) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Cleanmail
> * Remove users in Cleanmail Swiss when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Cleanmail
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Cleanmail Swiss (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Cleanmail Swiss with Admin permission

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Cleanmail](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-cleanmail-swiss-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Cleanmail Swiss to support provisioning with Microsoft Entra ID

Contact [Cleanmail Swiss Support](https://www.alinto.com/contact-email-provider/) to configure Cleanmail Swiss to support provisioning with Microsoft Entra ID.

<a name='step-3-add-cleanmail-swiss-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Cleanmail Swiss from the Microsoft Entra application gallery

Add Cleanmail Swiss from the Microsoft Entra application gallery to start managing provisioning to Cleanmail. If you have previously setup Cleanmail Swiss for SSO, you can use the same application. However it's recommended you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Cleanmail Swiss 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in Cleanmail Swiss based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-cleanmail-swiss-in-azure-ad'></a>

### To configure automatic user provisioning for Cleanmail Swiss in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Cleanmail**.

	![Screenshot of the Cleanmail Swiss link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, input your Cleanmail Swiss Tenant URL as `https://cloud.cleanmail.ch/api/v3/scim2` and corresponding Secret Token obtained from Step 2. Select **Test Connection** to ensure Microsoft Entra ID can connect to Cleanmail. If the connection fails, ensure your Cleanmail Swiss account has Admin permissions and try again.

	![Screenshot of the token.](common/provisioning-testconnection-tenanturltoken.png)
	
1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of notification email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to Cleanmail**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Cleanmail Swiss in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Cleanmail Swiss for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Cleanmail Swiss API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Cleanmail|
   |---|---|---|---|
   |userName|String|&check;|&check;|
   |active|Boolean||&check;|
   |name.givenName|String|||
   |name.familyName|String|||
   |externalId|String|||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Cleanmail, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of provisioning status toggled on.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to Cleanmail Swiss by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of provisioning scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of saving provisioning configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to complete than next cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
