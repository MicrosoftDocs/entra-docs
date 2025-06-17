---
title: Configure Tribeloo for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Tribeloo.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Tribeloo so that I can streamline the user management process and ensure that users have the appropriate access to Tribeloo.
---

# Configure Tribeloo for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Tribeloo and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Tribeloo](https://www.tribeloo.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Tribeloo.
> * Remove users in Tribeloo when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Tribeloo.
> * [Single sign-on](tribeloo-tutorial.md) to Tribeloo (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A [Tribeloo](https://www.tribeloo.com/) tenant.
* A user account in Tribeloo with Admin permissions.


## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Tribeloo](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-tribeloo-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Tribeloo to support provisioning with Microsoft Entra ID

Navigate to the [Tribeloo app](https://app.tribeloo.com/) and log as a user with Admin permissions.
1. Using the side menu(1), navigate to **Admin**(2), select **User management**(3)

	![Access User Management](media/tribeloo-provisioning-tutorial/tribeloo-user-management.png)

1. Select the **User provisioning**(1) tab. On this tab, you have access to Tribeloo information that you have to use to configure the Microsoft Entra integration.
   1. **SCIM base URL** (2)
   1. **SCIM Bearer token** (3)
1. Copy these values to the clipboard and paste them in the corresponding Microsoft Entra ID fields (see Step 5). The AD fields are named **Tenant URL** and **Secret Token** respectively.

	![Tribeloo Provisioning Parameters](media/tribeloo-provisioning-tutorial/tribeloo-provisioning-parameters.png)

1. On the **User Provisioning** tab you can now select the **Enable User provisioning**(1) button to enable user provisioning in Tribeloo.

	![Tribeloo Enable Provisioning](media/tribeloo-provisioning-tutorial/tribeloo-enable-provisioning.png)

<a name='step-3-add-tribeloo-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Tribeloo from the Microsoft Entra application gallery

Add Tribeloo from the Microsoft Entra application gallery to start managing provisioning to Tribeloo. If you have previously setup Tribeloo for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Tribeloo 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Tribeloo based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-tribeloo-in-azure-ad'></a>

### To configure automatic user provisioning for Tribeloo in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Tribeloo**.

	![The Tribeloo link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, input your Tribeloo **Tenant URL** and **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Tribeloo. If the connection fails , ensure your Tribeloo account has Admin permissions and try again.

	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to Tribeloo**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Tribeloo in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Tribeloo for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Tribeloo API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;
   |emails[type eq "work"].value|String|
   |active|Boolean|   
   |displayName|String|
   |name.givenName|String|
   |name.familyName|String|
   |addresses[type eq "work"].formatted|String|

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Tribeloo, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Tribeloo by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Change Log
* 08/12/2021 - Added support for core user attributes **emails[type eq "work"].value** and **addresses[type eq "work"].formatted**.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
