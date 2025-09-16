---
title: Configure uniFLOW Online for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to uniFLOW Online.
author: jeevansd
manager: beatrizd
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to uniFLOW Online so that I can streamline the user management process and ensure that users have the appropriate access to uniFLOW Online.
---

# Configure uniFLOW Online for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both uniFLOW Online and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [uniFLOW Online](https://www.uniflowonline.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in uniFLOW Online.
> * Disable users in uniFLOW Online.
> * Remove users in uniFLOW Online when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and uniFLOW Online.
> * [Single sign-on](uniflow-online-tutorial.md) to uniFLOW Online (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* An administrator account with uniFLOW Online.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and uniFLOW Online](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-uniflow-online-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure uniFLOW Online to support provisioning with Microsoft Entra ID
* In a different web browser window, sign in to uniFLOW Online website as an administrator.
* Select **Extensions** tab **> Identity Providers > Configure identity providers**.
* Select **Add identity provider**. On the **ADD IDENTITY PROVIDER** section, perform the following steps:
   * Enter the **Display name** .
   * For **Provider type**, select **WS-Federation** option from the dropdown.
   * For **WS-Federation type**, select **Microsoft Entra ID** option from the dropdown.
   * Select **Save**.
* Enable the Advanced Administrative View within your user Profile settings by navigating to **Profile settings > Administrator view** and setting it to **Advanced**.
* The provisioning tab will now be available within the Identity Provider configuration.
* Select **Enable Provisioning** when you're ready to set up user provisioning in your company's Microsoft Entra ID.
   * **Provisioning tenant URL** (only displayed once after **Provisioning** is enabled): You need this URL when setting up provisioning in your Microsoft Entra application.
   * **Provisioning secret token** (only displayed once after **Provisioning** is enabled): You need this token when setting up provisioning in your Microsoft Entra application.

<a name='step-3-add-uniflow-online-from-the-azure-ad-application-gallery'></a>

## Step 3: Add uniFLOW Online from the Microsoft Entra application gallery

Add uniFLOW Online from the Microsoft Entra application gallery to start managing provisioning to uniFLOW Online. If you have previously setup uniFLOW Online for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to uniFLOW Online 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-uniflow-online-in-azure-ad'></a>

### To configure automatic user provisioning for uniFLOW Online in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **uniFLOW Online**.

	![Screenshot of the uniFlow Online link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your uniFLOW Online Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to uniFLOW Online. If the connection fails, ensure your uniFLOW Online account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to uniFLOW Online**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to uniFLOW Online in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in uniFLOW Online for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the uniFLOW Online API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by uniFLOW Online|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |externalId|String|&check;|&check;
   |emails[type eq "work"].value|String|&check;|
   |active|Boolean||&check;
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
   |displayName|String||
   |title|String||
   |addresses[type eq "work"].streetAddress|String||
   |title|String||
   |phoneNumbers[type eq "work"].value|String||
   |urn:ietf:params:scim:schemas:extension:uniFLOWOnline:2.0:User:cardNumber|String||
   |urn:ietf:params:scim:schemas:extension:uniFLOWOnline:2.0:User:cardRegistrationCode|String||
   |urn:ietf:params:scim:schemas:extension:uniFLOWOnline:2.0:User:localUsername|String||
   |urn:ietf:params:scim:schemas:extension:uniFLOWOnline:2.0:User:pin|String||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for uniFLOW Online, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to uniFLOW Online by choosing the desired values in **Scope** in the **Settings** section.

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
