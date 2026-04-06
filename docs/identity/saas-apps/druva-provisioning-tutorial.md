---
title: Configure Druva for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Druva.
author: jeevansd
ms.topic: how-to
ms.date: 04/06/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Druva so that I can streamline the user management process and ensure that users have the appropriate access to Druva.
---

# Configure Druva for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Druva and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Druva.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A Druva tenant](https://www.druva.com/products/pricing-plans/).
* A user account in Druva with Admin permissions.

## Assigning users to Druva

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Druva. Once decided, you can assign these users and/or groups to Druva by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to Druva

* It's recommended that a single Microsoft Entra user is assigned to Druva to test the automatic user provisioning configuration. More users and/or groups may be assigned later.

* When assigning a user to Druva, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up Druva for provisioning

Before configuring Druva for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on Druva.

1. Sign in to your [Druva Admin Console](https://console.druva.com). Navigate to **Druva** > **inSync**.

    ![Druva Admin Console](media/druva-provisioning-tutorial/menubar.png)

1. Navigate to **Manage** > **Deployments** > **Users**.

    :::image type="content" source="media/druva-provisioning-tutorial/manage.png" alt-text="Screenshot of the Druva admin console. Manage is highlighted, and the Manage menu is visible. In that menu, under Deployments, Users are highlighted." border="false":::

1. Navigate to **Settings**. Select **Generate Token**.

    :::image type="content" source="media/druva-provisioning-tutorial/settings.png" alt-text="Screenshot of a page in the Druva admin console. Settings are highlighted, and the Settings tab is open. The Generate token button is highlighted." border="false":::

1. Copy the **Auth token** value. This value is entered in the **Secret Token** field in the Provisioning tab of your Druva application.

    :::image type="content" source="media/druva-provisioning-tutorial/auth.png" alt-text="Screenshot of the Create token page in the Druva admin console. A link labeled Copy Token is available for copying the Auth token value." border="false":::

## Add Druva from the gallery

To configure Druva for automatic user provisioning with Microsoft Entra ID, you need to add Druva from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Druva from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Druva**, select **Druva** in the search box.
1. Select **Druva** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
    ![Druva in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to Druva 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Druva based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Druva, following the instructions provided in the [Druva Single sign-on  article](druva-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-druva-in-azure-ad'></a>

### To configure automatic user provisioning for Druva in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

    ![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Druva**.

    ![The Druva link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

    ![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Druva Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Druva. If the connection fails, ensure your Druva account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Druva in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Druva for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Druva API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

    ![Druva User Attributes](media/druva-provisioning-tutorial/userattribute.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Connector limitations

* Druva requires **email** as a mandatory attribute. 

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md).
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md).
