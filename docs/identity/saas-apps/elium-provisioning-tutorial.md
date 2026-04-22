---
title: Configure Elium for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Elium.
author: jeevansd
ms.topic: how-to
ms.date: 04/06/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Elium so that I can streamline the user management process and ensure that users have the appropriate access to Elium.
---

# Configure Elium for automatic user provisioning with Microsoft Entra ID

This article shows how to configure Elium and Microsoft Entra ID to automatically provision and de-provision users or groups to Elium.

> [!NOTE]
> This article describes a connector that's built on top of the Microsoft Entra user provisioning service. For important details about what this service does and how it works, and for frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>
> This connector is currently in preview. For more information about previews, see [Universal License Terms For Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Prerequisites

This article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [An Elium tenant](https://www.elium.com/pricing/)
* A user account in Elium, with admin permissions

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Assigning users to Elium

Microsoft Entra ID uses a concept called *assignments* to determine which users receive access to selected apps. In the context of automatic user provisioning, only the users and groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before you configure and enable automatic user provisioning, decide which users and groups in Microsoft Entra ID need access to Elium. Then, assign those users and groups to Elium by following the steps in [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).

## Important tips for assigning users to Elium 

We recommend that you assign a single Microsoft Entra user to Elium to test the automatic user-provisioning configuration. More users and groups can be assigned later.

When assigning a user to Elium, you must select a valid, application-specific role (if any are available) in the assignment dialog box. Users who have the **Default Access** role are excluded from provisioning.

## Set up Elium for provisioning

Before configuring Elium for automatic user provisioning with Microsoft Entra ID, you must enable System for Cross-domain Identity Management (SCIM) provisioning on Elium. Follow these steps:

1. Sign in to Elium and go to **My Profile** > **Settings**.

    ![Settings menu item in Elium](media/Elium-provisioning-tutorial/setting.png)

1. In the lower-left corner, under **ADVANCED**, select **Security**.

    ![Security link in Elium](media/Elium-provisioning-tutorial/security.png)

1. Copy the **Tenant URL** and **Secret token** values. You'll use these values later, in corresponding fields in the **Provisioning** tab of your Elium application.

    ![Tenant URL and Secret token fields in Elium](media/Elium-provisioning-tutorial/token.png)

## Add Elium from the gallery

To configure Elium for automatic user provisioning with Microsoft Entra ID, you must also add Elium from the Microsoft Entra application gallery to your list of managed software-as-a-service (SaaS) applications. Follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

     ![Microsoft Entra Enterprise applications blade](common/enterprise-applications.png)

1. To add a new application, select **New application** at the top of the pane.

    ![New application link](common/add-new-app.png)

1. In the search box, type **Elium**, select **Elium** in the results list, and then select **Add** to add the application.

    ![Gallery search box](common/search-new-app.png)

## Configure automatic user provisioning to Elium

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in Elium, based on user and group assignments in Microsoft Entra ID.

> [!TIP]
> You might also choose to enable single sign-on for Elium based on Security Assertion Markup Language (SAML) by following the instructions in the [Elium single sign-on  article](Elium-tutorial.md). You can configure single sign-on independently of automatic user provisioning, although the two features complement each other.

To configure automatic user provisioning for Elium in Microsoft Entra ID, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

    ![Microsoft Entra Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Elium**.

    ![Applications list in the Enterprise applications blade](common/all-applications.png)

1. Select the **Provisioning** tab.

    ![Provisioning tab in the Enterprise applications blade](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Elium Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Elium. If the connection fails, ensure your Elium account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Elium in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Elium for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Elium API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

    ![Attribute mappings between Microsoft Entra ID and Elium](media/Elium-provisioning-tutorial/userattribute.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md).
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
