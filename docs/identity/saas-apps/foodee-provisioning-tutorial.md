---
title: Configure Foodee for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and deprovision user accounts to Foodee.
author: jeevansd
ms.topic: how-to
ms.date: 04/07/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Foodee so that I can streamline the user management process and ensure that users have the appropriate access to Foodee.
---

# Configure Foodee for automatic user provisioning with Microsoft Entra ID

This article shows you how to configure Microsoft Entra ID in Foodee and Microsoft Entra ID to automatically provision or deprovision users or groups to Foodee.

> [!NOTE]
> The article describes a connector that's built on top of the Microsoft Entra user provisioning service. To learn what this service does and how it works, and to get answers to frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>
> This connector is currently in preview. For more information about previews, see [Universal License Terms For Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Prerequisites

This article assumes that you've met the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Foodee tenant](https://www.food.ee/about-us/)
* A user account in Foodee with Admin permissions

## Assign users to Foodee 

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before you configure and enable automatic user provisioning, you should decide which users or groups in Microsoft Entra ID need access to Foodee. After you've made this determination, you can assign these users or groups to Foodee by following the instructions in [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).

## Important tips for assigning users to Foodee 

When you're assigning users, keep the following tips in mind:

* We recommend that you assign only a single Microsoft Entra user to Foodee to test the configuration of automatic user provisioning. You can assign additional users or groups later.

* When you're assigning a user to Foodee, select any valid application-specific role, if it's available, in the **Assignment** pane. Users who have the *Default Access* role are excluded from provisioning.

## Set up Foodee for provisioning

Before you configure Foodee for automatic user provisioning by using Microsoft Entra ID, you need to enable System for Cross-domain Identity Management (SCIM) provisioning in Foodee.

1. Sign in to [Foodee](https://www.food.ee/login/), and then select your tenant ID.

	:::image type="content" source="media/Foodee-provisioning-tutorial/tenant.png" alt-text="Screenshot of the main menu of the Foodee enterprise portal. A Tenant ID placeholder is visible in the menu." border="false":::

1. Under **Enterprise portal**, select **Single Sign On**.

	![Screenshot of the Foodee Enterprise Portal left-pane menu.](media/Foodee-provisioning-tutorial/scim.png)

1. Copy the value in the **API Token** box for later use. You'll enter it in the **Secret Token** box in the **Provisioning** tab of your Foodee application.

	:::image type="content" source="media/Foodee-provisioning-tutorial/token.png" alt-text="Screenshot of a page in the Foodee enterprise portal. An A P I token value is highlighted." border="false":::

## Add Foodee from the gallery

To configure Foodee for automatic user provisioning by using Microsoft Entra ID, you need to add Foodee from the Microsoft Entra application gallery to your list of managed SaaS applications.

To add Foodee from the Microsoft Entra application gallery, do the following:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

	![Screenshot of The Enterprise applications pane.](common/enterprise-applications.png)

1. To add a new application, select **New application** at the top of the pane.

	![Screenshot of the New application button.](common/add-new-app.png)

1. In the search box, enter **Foodee**, select **Foodee** in the results pane, and then select **Add** to add the application.

	![Screenshot of Foodee in the results list.](common/search-new-app.png)

## Configure automatic user provisioning to Foodee 

In this section, you configure the Microsoft Entra provisioning service to create, update, and disable users or groups in Foodee based on user or group assignments in Microsoft Entra ID.

> [!TIP]
> You can also enable SAML-based single sign-on for Foodee by following the instructions in the [Foodee single sign-on  article](Foodee-tutorial.md). You can configure single sign-on independent of automatic user provisioning, though these two features complement each other.

Configure automatic user provisioning for Foodee in Microsoft Entra ID by doing the following:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

	![Screenshot of Enterprise applications pane.](common/enterprise-applications.png)

1. In the **Applications** list, select **Foodee**.

	![Screenshot of the Foodee link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Foodee Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Foodee. If the connection fails, ensure your Foodee account has the required admin permissions and try again.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Under **Attribute Mappings**, review the user attributes that are synchronized from Microsoft Entra ID to Foodee. The attributes that are selected as **Matching** properties are used to match the *user accounts* in Foodee for update operations. 

	:::image type="content" source="media/Foodee-provisioning-tutorial/userattribute.png" alt-text="Screenshot of the Attribute Mappings page. A table lists Microsoft Entra ID and Foodee attributes and the matching precedence." border="false":::

1. To commit your changes, select **Save**.
1. Under **Mappings**, select **Synchronize Microsoft Entra groups to Foodee**.

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization. 

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

You can use the **Current Status** section to monitor progress and follow links to your provisioning activity report. The report describes all actions that are performed by the Microsoft Entra provisioning service on Foodee. For more information, see [Check the status of user provisioning](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md). To read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Additional resources

* [Manage user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
