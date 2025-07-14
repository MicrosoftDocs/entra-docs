---
title: Configure Moqups for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Moqups.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Moqups so that I can streamline the user management process and ensure that users have the appropriate access to Moqups.
---

# Configure Moqups for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Moqups and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [Moqups](https://www.moqups.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Moqups.
> * Remove users in Moqups when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Moqups.
> * [Single sign-on](moqups-tutorial.md) to Moqups (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* An administrator account with Moqups.
* SCIM-based user provisioning is available to Moqups customers on our [Unlimited Plan](https://moqups.com/pricing).

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Moqups](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-moqups-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Moqups to support provisioning with Microsoft Entra ID
To set up **SCIM** for **Azure**, you first need to generate an **API Token** in Moqups, and then configure **Automatic Provisioning** in Azure itself.

Generate an API Token:

1. Go to the **Integrations** tab on your Moqups **Dashboard's Account** page.
1. In the **SCIM Provisioning** section of your **Integration tab**, select the **Generate token** button.

	![Screenshot of generate token.](media/moqups-provisioning-tutorial/generate-token.png)

1. Copy the **API Token** to your clipboard. You'll need this to complete the process in **Azure**.

	![Screenshot of api token.](media/moqups-provisioning-tutorial/api-token.png)

<a name='step-3-add-moqups-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Moqups from the Microsoft Entra application gallery

Add Moqups from the Microsoft Entra application gallery to start managing provisioning to Moqups. If you have previously setup Moqups for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Moqups 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-moqups-in-azure-ad'></a>

### To configure automatic user provisioning for Moqups in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Moqups**.

	![Screenshot of the Moqups link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, input your Moqups Tenant URL and Secret Token.
	1. Use `https://api.moqups.com/scim/v2` as the **Tenant URL**. 
	1. Use the **API Token** generated in Step 2.1 as the **Secret Token**.
	1. Select **Test Connection** so that Microsoft Entra ID can confirm that the supplied credentials can be used for provisioning. If the connection fails, double-check the **Tenant URL**,  as well make sure the **API Token** is correct. 

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Moqups**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Moqups in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Moqups for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Moqups API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Moqups|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||
   |displayName|String||
   |emails[type eq "work"].value|String||
   |name.formatted|String||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Moqups, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to Moqups by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
