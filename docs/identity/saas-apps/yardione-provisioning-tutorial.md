---
title: Configure YardiOne for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to YardiOne.
author: jeevansd
manager: pmwongera
ms.topic: how-to
ms.date: 04/05/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to YardiOne so that I can streamline the user management process and ensure that users have the appropriate access to YardiOne.
---

# Configure YardiOne for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both YardiOne and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to [YardiOne](https://www.yardi.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in YardiOne.
> * Remove users in YardiOne when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and YardiOne.
> * [Single sign-on](yardione-tutorial.md) to YardiOne (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in YardiOne with Admin permissions.

## Step 1: Plan your provisioning deployment

* Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
* Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
* Determine what data to [map between Microsoft Entra ID and YardiOne](~/identity/app-provisioning/customize-application-attributes.md).

## Step 2: Configure YardiOne to support provisioning with Microsoft Entra ID

Contact YardiOne support to configure YardiOne to support provisioning with Microsoft Entra ID.

## Step 3: Add YardiOne from the Microsoft Entra application gallery

Add YardiOne from the Microsoft Entra application gallery to start managing provisioning to YardiOne. If you have previously setup YardiOne for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to YardiOne 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in YardiOne based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-YardiOne-in-azure-ad'></a>

### Configure automatic user provisioning for YardiOne in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **YardiOne**.

	![Screenshot of the YardiOne link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your YardiOne Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to YardiOne. If the connection fails, ensure your YardiOne account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to YardiOne in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in YardiOne for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the YardiOne API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by YardiOne|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||
   |name.givenName|String||
   |name.familyName|String||

1. Select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to YardiOne in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in YardiOne for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by YardiOne|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |members|Reference||

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)