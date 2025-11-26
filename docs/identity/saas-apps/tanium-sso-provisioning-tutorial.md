---
title: Configure Tanium SSO for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Tanium SSO.
author: jeevansd
manager: pmwongera
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Tanium SSO so that I can streamline the user management process and ensure that users have the appropriate access to Tanium SSO.
---

# Configure Tanium SSO for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Tanium SSO and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Tanium SSO](https://www.tanium.com/) using the Microsoft Entra provisioning service. These capabilities are supported only for Tanium Cloud customers. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Tanium SSO.
> * Remove users in Tanium SSO when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Tanium SSO.
> * Provision groups and group memberships in Tanium SSO.
> * [Single sign-on](~/identity/saas-apps/tanium-sso-tutorial.md) to Tanium SSO (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Tanium SSO with Admin permissions.

## Step 1: Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Tanium SSO](~/identity/app-provisioning/customize-application-attributes.md).

## Step 2: Enable SCIM Provisioning in the Tanium Cloud Management Portal (CMP)

* Follow the steps in the [Tanium Cloud Deployment Guide: Configure SCIM Provisioning](https://docs.tanium.com/cloud/cloud/configuring_identity_providers.html#configure_scim) to enable automatic user provisioning in Tanium Cloud.
* Retain the **Token** and **SCIM API URL** values for later use in configuring Tanium SSO. Copy the entire token string, formatted like `token-\<58 alphanumeric characters\>`.

<a name='step-3-add-tanium-sso-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Tanium SSO from the Microsoft Entra application gallery

Add Tanium SSO from the Microsoft Entra application gallery to start managing provisioning to Tanium SSO. If you have previously setup Tanium SSO for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Tanium SSO 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Tanium based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-tanium-sso-in-azure-ad'></a>

### To configure automatic user provisioning for Tanium SSO in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Tanium SSO**.

	![Screenshot of the Tanium SSO link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Tanium SSO **Tenant URL** and **Secret Token** that you previously retrieved from the Tanium CMP. Select **Test Connection** to ensure Microsoft Entra ID can connect to Tanium SSO. If the connection fails, ensure that you entered the complete token value, including the `token-` prefix.

	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Tanium SSO**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Tanium SSO in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Tanium SSO for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Tanium SSO API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Tanium SSO|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||&check;
   |displayName|String||&check;
   |externalId|String||&check;


1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Tanium SSO**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Tanium SSO in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Tanium SSO for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Tanium SSO|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |externalId|String||&check;
   |members|Reference||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Tanium SSO, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Tanium SSO by choosing the desired values in **Scope** in the **Settings** section.

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
