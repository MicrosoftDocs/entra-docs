---
title: Configure directprint.io for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to directprint.io.


author: thomasakelo
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to directprint.io so that I can streamline the user management process and ensure that users have the appropriate access to directprint.io.
---

# Configure directprint.io for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both directprint.io and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [directprint.io](https://directprint.io) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in directprint.io.
> * Remove users in directprint.io when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and directprint.io.
> * Provision groups and group memberships in directprint.io.
> * [Single sign-on](directprint-io-cloud-print-administration-tutorial.md) to directprint.io (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* Single sign-on with Microsoft Entra ID is completed.
* A licensed or 30 days free trial account with directprint.io.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and directprint.io](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-directprintio-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure directprint.io to support provisioning with Microsoft Entra ID

1. log into your [directprint.io account](https://directprint.io/login/).
1. Navigate to the Microsoft Entra SSO and Provisioning screen.
1. Save the Tenant URL and secret toke for future reference. You need it in **Step 5**.

## Step 3: Add directprint.io from the Microsoft Entra application gallery

Add directprint.io from the Microsoft Entra application gallery to start managing provisioning to directprint.io. If you have previously setup directprint.io for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to directprint.io 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in directprint.io based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-directprintio-in-azure-ad'></a>

### To configure automatic user provisioning for directprint.io in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **directprint.io**.

	![The directprint.io link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your directprint.io Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to directprint.io. If the connection fails, ensure your directprint.io account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to directprint.io**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to directprint.io in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in directprint.io for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the directprint.io API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |externalId|String||
   |active|Boolean||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to directprint.io**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to directprint.io in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in directprint.io for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |externalId|String||
      |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for directprint.io, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to directprint.io by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
