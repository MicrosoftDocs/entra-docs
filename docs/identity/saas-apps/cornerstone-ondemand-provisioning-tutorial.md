---
title: Configure Cornerstone OnDemand for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and deprovision user accounts to Cornerstone OnDemand.
author: zhchia
ms.topic: how-to
ms.date: 04/06/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Cornerstone OnDemand so that I can streamline the user management process and ensure that users have the appropriate access to Cornerstone OnDemand.
---

# Configure Cornerstone OnDemand for automatic user provisioning with Microsoft Entra ID

This article demonstrates the steps to perform in Cornerstone OnDemand and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and deprovision users or groups to Cornerstone OnDemand.

> [!WARNING]
> This provisioning integration is no longer supported. As a result of this, the provisioning functionality of the Cornerstone OnDemand application in the Microsoft Entra Enterprise App Gallery is removed soon. The application's SSO functionality will remain intact. Microsoft is working with Cornerstone to build a new modernized provisioning integration, but there are no timelines on when it's completed.


> [!NOTE]
> This article describes a connector that's built on top of the Microsoft Entra user provisioning service. For information on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to software-as-a-service (SaaS) applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Prerequisites

The scenario outlined in this article assumes that you have:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* A Cornerstone OnDemand tenant.
* A user account in Cornerstone OnDemand with admin permissions.

> [!NOTE]
> The Microsoft Entra provisioning integration relies on the [Cornerstone OnDemand web service](https://www.cornerstoneondemand.com/). This service is available to Cornerstone OnDemand teams.

## Add Cornerstone OnDemand from the Azure Marketplace

Before you configure Cornerstone OnDemand for automatic user provisioning with Microsoft Entra ID, add Cornerstone OnDemand from the Marketplace to your list of managed SaaS applications.

To add Cornerstone OnDemand from the Marketplace, follow these steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type ****Cornerstone OnDemand** and select **Cornerstone OnDemand** from the result panel. To add the application, select **Add**.

	![Cornerstone OnDemand in the results list](common/search-new-app.png)

## Assign users to Cornerstone OnDemand

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users or groups that were assigned to an application in Microsoft Entra ID are synchronized.

Before you configure and enable automatic user provisioning, decide which users or groups in Microsoft Entra ID need access to Cornerstone OnDemand. To assign these users or groups to Cornerstone OnDemand, follow the instructions in [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).

### Important tips for assigning users to Cornerstone OnDemand

* We recommend that you assign a single Microsoft Entra user to Cornerstone OnDemand to test the automatic user provisioning configuration. You can assign more users or groups later.

* When you assign a user to Cornerstone OnDemand, select any valid application-specific role, if available, in the assignment dialog box. Users with the **Default Access** role are excluded from provisioning.

## Configure automatic user provisioning to Cornerstone OnDemand

This section guides you through the steps to configure the Microsoft Entra provisioning service. Use it to create, update, and disable users or groups in Cornerstone OnDemand based on user or group assignments in Microsoft Entra ID.

To configure automatic user provisioning for Cornerstone OnDemand in Microsoft Entra ID, follow these steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cornerstone OnDemand**.

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Cornerstone OnDemand**.

	![The Cornerstone OnDemand link in the applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Cornerstone OnDemand Provisioning](./media/cornerstone-ondemand-provisioning-tutorial/ProvisioningTab.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. Under the **Admin Credentials** section, enter the admin username, admin password, and domain of your Cornerstone OnDemand's account:

	* In the **Admin Username** box, fill in the domain or username of the admin account on your Cornerstone OnDemand tenant. An example is contoso\admin.

	* In the **Admin Password** box, fill in the password that corresponds to the admin username.

	* In the **Domain** box, fill in the web service URL of the Cornerstone OnDemand tenant. For example, the service is located at `https://ws-[corpname].csod.com/feed30/clientdataservice.asmx`, and for Contoso the domain is `https://ws-contoso.csod.com/feed30/clientdataservice.asmx`.

1. In the **Tenant URL** field, enter your Cornerstone OnDemand Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Cornerstone OnDemand. If the connection fails, ensure your Cornerstone OnDemand account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Cornerstone OnDemand in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Cornerstone OnDemand for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Cornerstone OnDemand API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

	![Cornerstone OnDemand Attribute Mappings](./media/cornerstone-ondemand-provisioning-tutorial/UserMappingAttributes.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Connector limitations

The Cornerstone OnDemand **Position** attribute expects a value that corresponds to the roles on the Cornerstone OnDemand portal. To get a list of valid **Position** values, go to **Edit User Record > Organization Structure > Position** in the Cornerstone OnDemand portal.

![Cornerstone OnDemand Provisioning Edit User Record](./media/cornerstone-ondemand-provisioning-tutorial/UserEdit.png)

![Cornerstone OnDemand Provisioning Position](./media/cornerstone-ondemand-provisioning-tutorial/UserPosition.png)

![Cornerstone OnDemand Provisioning position list](./media/cornerstone-ondemand-provisioning-tutorial/PostionId.png)

## More resources

* [Manage user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

<!--Image references-->
[1]: ./media/cornerstone-ondemand-provisioning-tutorial/tutorial_general_01.png
[2]: ./media/cornerstone-ondemand-provisioning-tutorial/tutorial_general_02.png
[3]: ./media/cornerstone-ondemand-provisioning-tutorial/tutorial_general_03.png
