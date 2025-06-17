---
title: Configure kpifire for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to kpifire.

author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to kpifire so that I can streamline the user management process and ensure that users have the appropriate access to kpifire.
---

# Configure kpifire for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both kpifire and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [kpifire](https://www.kpifire.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in kpifire
> * Remove users in kpifire when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and kpifire
> * Provision groups and group memberships in kpifire
> * [Single sign-on](kpifire-tutorial.md) to kpifire (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A [kpifire tenant](https://www.kpifire.com/).
* A user account in kpifire with Admin permissions.

## Step 1: Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and kpifire](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-kpifire-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure kpifire to support provisioning with Microsoft Entra ID
1. Sign in to https://app.kpifire.com with admin rights
1. Navigate to **Settings->API Settings->Add New Token** to generate the SCIM token.

	[ ![kpifire token generation](media/kpifire-provisioning-tutorial/kpifire-token-generation.png) ](media/kpifire-provisioning-tutorial/kpifire-token-generation.png#lightbox)

1. Copy and save the SCIM token. This value is entered in the **Secret Token** field in the Provisioning tab of your kpifire application. 


<a name='step-3-add-kpifire-from-the-azure-ad-application-gallery'></a>

## Step 3: Add kpifire from the Microsoft Entra application gallery

Add kpifire from the Microsoft Entra application gallery to start managing provisioning to kpifire. If you have previously setup kpifire for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to kpifire 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in kpifire app based on user and group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-kpifire-in-azure-ad'></a>

### To configure automatic user provisioning for kpifire in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **kpifire**.

	![The kpifire link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1.  Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, enter your kpifire **Tenant URL** and **Secret token** information. Select **Test Connection** to ensure that Microsoft Entra ID can connect to kpifire. If the connection fails, ensure that your kpifire account has admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications. Select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to kpifire**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to kpifire in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in kpifire for update operations. If you change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the kpifire API supports filtering users based on that attribute. Select **Save** to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean|
   |name.givenName|String|
   |name.familyName|String|
   |phoneNumbers[type eq "work"].value|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|


1. In the **Mappings** section, select **Synchronize Microsoft Entra groups to kpifire**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to kpifire in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in kpifire for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;
      |members|Reference|     

1. To configure scoping filters, see the instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for kpifire, change **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users or groups that you want to provision to kpifire by selecting the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to do than next cycles, which occur about every 40 minutes as long as the Microsoft Entra provisioning service is running.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
