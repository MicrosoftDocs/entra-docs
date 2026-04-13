---
title: Configure N-able User Provisioning for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to N-able User Provisioning.
author: jeevansd
manager: pmwongera
ms.topic: how-to
ms.date: 04/13/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to N-able User Provisioning so that I can streamline the user management process and ensure that users have the appropriate access to N-able User Provisioning.
---

# Configure N-able User Provisioning for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both N-able User Provisioning and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to [N-able User Provisioning](https://www.n-able.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in N-able User Provisioning.
> * Remove users in N-able User Provisioning when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and N-able User Provisioning.

> [!NOTE]
> To use the OAuth2 flow, users should use the https://portal.azure.com/?feature.userProvisioningV2Authentication=true url to access the Azure portal.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in N-able User Provisioning with Admin permissions.

## Step 1: Plan your provisioning deployment
* Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
* Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
* Determine what data to [map between Microsoft Entra ID and N-able User Provisioning](~/identity/app-provisioning/customize-application-attributes.md).

## Step 2: Add N-able User Provisioning from the Microsoft Entra application gallery

Add N-able User Provisioning from the Microsoft Entra application gallery to start managing provisioning to N-able User Provisioning. If you have previously setup N-able User Provisioning for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 3: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 4: Configure automatic user provisioning to N-able User Provisioning 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in N-able User Provisioning based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-N-able User Provisioning-in-azure-ad'></a>

### To configure automatic user provisioning for N-able User Provisioning in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **N-able User Provisioning**.

	![Screenshot of the N-able User Provisioning link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your N-able User Provisioning Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to N-able User Provisioning. If the connection fails, ensure your N-able User Provisioning account has the required admin permissions and try again.
	> [!NOTE]
	> To use the OAuth2 flow, users should use the https://portal.azure.com/?feature.userProvisioningV2Authentication=true url to access the Azure portal.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to N-able User Provisioning in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in N-able User Provisioning for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the N-able User Provisioning API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|Required by N-able User Provisioning|
      |---|---|---|---|
      |userName|String|&check;|&check;
      |active|Boolean||&check;
      |name.givenName|String||&check;
      |name.familyName|String||&check;

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
