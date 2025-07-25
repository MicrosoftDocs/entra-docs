---
title: Configure ContractS CLM for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to ContractS CLM.

author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to ContractS CLM so that I can streamline the user management process and ensure that users have the appropriate access to ContractS CLM.
---

# Configure ContractS CLM for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both ContractS CLM and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to [ContractS CLM](https://www.holmescloud.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in ContractS CLM.
> * Remove users in ContractS CLM when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and ContractS CLM.
> * Provision groups and group memberships in ContractS CLM.
> * [Single sign-on](holmes-tutorial.md) to ContractS CLM (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A [ContractS CLM](https://www.holmescloud.com/) tenant.
* A user account in ContractS CLM with Admin permissions.
* A ContractS CLM subscription where single sign-on and user provisioning services are enabled.


## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and ContractS CLM](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-holmes-cloud-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure ContractS CLM to support provisioning with Microsoft Entra ID

> [!NOTE]
> * You receive your ContractS CLM tenant URL from **ContractS CLM Support** <cs@holmescloud.com> team after purchasing the subscription.
> * You can find the required information(endpoint URL, token, and so on) to set up the provisioning service in the **Company Settings** page as long as you subscribe single sign-on and user provisioning service.
 
1. Log in to ContractS CLM account with your ContractS CLM credentials.
1. Select "会社設定 (Company Settings)" menu and then select the hat shaped icon.
1. See the information including API token on the card menu titled "アカウントプロビジョニング (Account Provisioning)".
1. For token regeneration, select the link "APIキーを発行する (Issue API key)".


<a name='step-3-add-holmes-cloud-from-the-azure-ad-application-gallery'></a>

## Step 3: Add ContractS CLM from the Microsoft Entra application gallery

Add ContractS CLM from the Microsoft Entra application gallery to start managing provisioning to ContractS CLM. If you have previously setup ContractS CLM for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to ContractS CLM 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in ContractS CLM based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-holmes-cloud-in-azure-ad'></a>

### To configure automatic user provisioning for ContractS CLM in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **ContractS CLM**.

	![The ContractS CLM link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot shows the Provisioning tab automatic.](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, input your ContractS CLM **Tenant URL** and **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to ContractS CLM. If the connection fails, ensure your ContractS CLM account has Admin permissions and try again.

	![Screenshot shows the Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot shows the Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to ContractS CLM**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to ContractS CLM in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in ContractS CLM for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the ContractS CLM API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean||
   |displayName|String||
   |externalId|String||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to ContractS CLM**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to ContractS CLM in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in ContractS CLM for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |members|Reference||
      |externalId|String||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for ContractS CLM, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot shows the Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to ContractS CLM by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot shows the Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot shows saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
