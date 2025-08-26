---
title: Configure Acunetix 360 for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Acunetix 360.
author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Acunetix 360 so that I can streamline the user management process and ensure that users have the appropriate access to Acunetix 360.

---

# Configure Acunetix 360 for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Acunetix 360 and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Acunetix 360](https://www.acunetix.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Acunetix 360.
> * Remove users in Acunetix 360 when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Acunetix 360.
> * Provision groups and group memberships in Acunetix 360
> * [Single sign-on](acunetix-360-tutorial.md) to Acunetix 360 (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* An administrator account with Acunetix 360. 

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Acunetix 360](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-acunetix-360-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Acunetix 360 to support provisioning with Microsoft Entra ID

1. Log in to [Acunetix 360 admin console](https://online.acunetix360.com/). 
1. Select profile logo and navigate to **API Settings**.
1. Enter your **Current Password** and then select **Submit**.
1. Copy and save the **Token**.This value is entered in the **Secret Token** field in the Provisioning tab of your Acunetix 360 application. 
   >[!NOTE]
   >Select **Reset API Token** in order to reset the Token.
1. And `https://online.acunetix360.com/scim/v2` is entered in the **Tenant Url** field in the Provisioning tab of your Acunetix 360 application.



<a name='step-3-add-acunetix-360-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Acunetix 360 from the Microsoft Entra application gallery

Add Acunetix 360 from the Microsoft Entra application gallery to start managing provisioning to Acunetix 360. If you have previously setup Acunetix 360 for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Acunetix 360 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-acunetix-360-in-azure-ad'></a>

### To configure automatic user provisioning for Acunetix 360 in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Acunetix 360**.

	![Screenshot of the Acunetix 360 link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Acunetix 360 Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Acunetix 360. If the connection fails, ensure your Acunetix 360 account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Acunetix 360**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Acunetix 360 in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Acunetix 360 for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Acunetix 360 API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Acunetix 360|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||&check;
   |emails[type eq "work"].value|String||&check;
   |name.givenName|String||&check;
   |name.familyName|String||&check;
   |phoneNumbers[type eq "mobile"].value|String||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Acunetix 360**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Acunetix 360 in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Acunetix 360 for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Acunetix 360|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |members|Reference||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Acunetix 360, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Acunetix 360 by choosing the desired values in **Scope** in the **Settings** section.

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
