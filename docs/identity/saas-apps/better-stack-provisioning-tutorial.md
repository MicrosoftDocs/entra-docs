---
title: Configure Better Stack for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Better Stack.

author: jeevansd
manager: beatrizd
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Better Stack so that I can streamline the user management process and ensure that users have the appropriate access to Better Stack.
---

# Configure Better Stack for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Better Stack and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Better Stack](https://betterstack.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Better Stack.
> * Remove users in Better Stack when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Better Stack.
> * Provision groups and group memberships in Better Stack.
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Better Stack (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Better Stack with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Better Stack](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-better-stack-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Better Stack to support provisioning with Microsoft Entra ID
You can configure the Microsoft Entra provisioning in the Single Sign-on settings inside the Better Stack dashboard. Once enabled, you see the **Tenant ID** and the **Secret token** you can use in the Provisioning settings below. If you need any help, feel free to contact [Better Stack Support](mailto:hello@betterstack.com).

<a name='step-3-add-better-stack-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Better Stack from the Microsoft Entra application gallery

Add Better Stack from the Microsoft Entra application gallery to start managing provisioning to Better Stack. If you have previously setup Better Stack for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Better Stack 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-better-stack-in-azure-ad'></a>

### To configure automatic user provisioning for Better Stack in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Better Stack**.

	![Screenshot of the Better Stack link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Better Stack Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Better Stack. If the connection fails, ensure your Better Stack account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Better Stack**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Better Stack in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Better Stack for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Better Stack API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Better Stack|
   |---|---|---|---|
   |userName|String|&check;|&check;|
   |active|Boolean|||
   |emails[type eq "work"].value|String|||
   |name.givenName|String|||
   |name.familyName|String|||
   |phoneNumbers[type eq "work"].value|String|||
   |phoneNumbers[type eq "mobile"].value|String|||
   |externalId|String|||
   |timezone|String|||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Better Stack**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Better Stack in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Better Stack for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Better Stack|
   |---|---|---|---|
   |displayName|String|&check;|&check;|
   |externalId|String|||
   |members|Reference|||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Better Stack, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Better Stack by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
