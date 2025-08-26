---
title: Configure Tic-Tac Mobile for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Tic-Tac Mobile.

author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Tic-Tac Mobile so that I can streamline the user management process and ensure that users have the appropriate access to Tic-Tac Mobile.
---

# Configure Tic-Tac Mobile for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Tic-Tac Mobile and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to [Tic-Tac Mobile](https://www.tictacmobile.com/) by using the Microsoft Entra provisioning service. For information on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to software as a service (SaaS) applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).


## Capabilities supported

> [!div class="checklist"]
> * Create users in Tic-Tac Mobile.
> * Remove users in Tic-Tac Mobile when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Tic-Tac Mobile.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A [Tic-Tac Mobile](https://www.tictacmobile.com/) account with a super admin role.


## Step 1: Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Tic-Tac Mobile](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-tic-tac-mobile-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Tic-Tac Mobile to support provisioning with Microsoft Entra ID

Contact support@tictacmobile.com to get your **Tenant URL** and **Secret Token**. You must have a super admin role in Tic-Tac Mobile to receive a token. The token is entered in the **Secret Token** box on the **Provisioning** tab of your Tic-Tac Mobile application.

<a name='step-3-add-tic-tac-mobile-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Tic-Tac Mobile from the Microsoft Entra application gallery

Add Tic-Tac Mobile from the Microsoft Entra application gallery to start managing provisioning to Tic-Tac Mobile. If you've previously set up Tic-Tac Mobile for single sign-on, you can use the same application. When you test out the integration initially, create a separate app. To learn more about how to add an application from the gallery, see [Attribute-based application provisioning with scoping filters](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who is in scope for provisioning

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Tic-Tac Mobile

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users or groups in TestApp based on user or group assignments in Microsoft Entra ID.

<a name='configure-automatic-user-provisioning-for-tic-tac-mobile-in-azure-ad'></a>

### Configure automatic user provisioning for Tic-Tac Mobile in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

	![Screenshot that shows the Enterprise applications pane.](common/enterprise-applications.png)

1. In the applications list, select **Tic-Tac Mobile**.

	![Screenshot that shows the Tic-Tac Mobile link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot that shows the Provisioning tab.](common/provisioning.png)

1. Set **Provisioning Mode** to **Automatic**.

	![Screenshot that shows the Provisioning tab Automatic option.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Tic-Tac Mobile **Tenant URL** and **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Tic-Tac Mobile. If the connection fails, ensure your Tic-Tac Mobile account has admin permissions and try again.

 	![Screenshot that shows the Secret Token box.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** box, enter the email address of a person or group who should receive the provisioning error notifications. Select the **Send an email notification when a failure occurs** check box.

	![Screenshot that shows the Notification Email box.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Tic-Tac Mobile**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Tic-Tac Mobile in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Tic-Tac Mobile for update operations. If you change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you must ensure that the Tic-Tac Mobile API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |name.givenName|String|
   |name.familyName|String|
   |externalId|String|
   |title|String|
   |emails[type eq "work"].value|String|
   |preferredLanguage|String|
   |externalId|String|
   |userType|String|
   |locale|String|
   |timezone|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:costCenter|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|

1. To configure scoping filters, see the instructions in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Tic-Tac Mobile, change **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot that shows the Provisioning Status toggled On.](common/provisioning-toggle-on.png)

1. Define the users or groups that you want to provision to Tic-Tac Mobile by selecting the desired values in **Scope** in the **Settings** section.

	![Screenshot that shows the provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot that shows saving the provisioning configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
