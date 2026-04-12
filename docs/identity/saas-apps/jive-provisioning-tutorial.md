---
title: Configure Jive for automatic user provisioning with Microsoft Entra ID
description: Learn the steps you need to perform in Jive and Microsoft Entra ID to automatically provision and de-provision user accounts from Microsoft Entra ID to Jive.
ms.topic: how-to
ms.date: 04/10/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Jive so that I can streamline the user management process and ensure that users have the appropriate access to Jive.
---
# Configure Jive for automatic user provisioning with Microsoft Entra ID

The objective of this article is to show you the steps you need to perform in Jive and Microsoft Entra ID to automatically provision and de-provision user accounts from Microsoft Entra ID to Jive.

## Prerequisites

The scenario outlined in this article assumes that you already have the following items:

*   A Microsoft Entra tenant.
*   A Jive single-sign on enabled subscription.
*   A user account in Jive with Team Admin permissions.

## Assigning users to Jive

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected apps. In the context of automatic user account provisioning, only the users and groups that have been "assigned" to an application in Microsoft Entra ID is synchronized.

Before configuring and enabling the provisioning service, you need to decide what users and/or groups in Microsoft Entra ID represent the users who need access to your Jive app. Once decided, you can assign these users to your Jive app by following the instructions here:

[Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Jive

*   It's recommended that a single Microsoft Entra user be assigned to Jive to test the provisioning configuration. Additional users and/or groups may be assigned later.

*   When assigning a user to Jive, you must select a valid user role. The "Default Access" role doesn't work for provisioning.

## Enable User Provisioning

This section guides you through connecting your Microsoft Entra ID to Jive's user account provisioning API, and configuring the provisioning service to create, update, and disable assigned user accounts in Jive based on user and group assignment in Microsoft Entra ID.

> [!TIP]
> You may also choose to enabled SAML-based Single Sign-On for Jive, following the instructions provided in the [Azure portal](https://portal.azure.com). Single sign-on can be configured independently of automatic provisioning, though these two features complement each other.

### To configure user account provisioning:

The objective of this section is to outline how to enable user provisioning of Active Directory user accounts to Jive.
As part of this procedure, you're required to provide a user security token you need to request from Jive.com.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

1. If you have already configured Jive for single sign-on, search for your instance of Jive using the search field. Otherwise, select **Add** and search for **Jive** in the application gallery. Select Jive from the search results, and add it to your list of applications.

1. Select your instance of Jive, then select the **Provisioning** tab.

1. Select **+ New configuration**.

  ![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. In the **Tenant URL** field, enter your Jive Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Jive. If the connection fails, ensure your Jive account has the required admin permissions and try again.

  ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. In the **Attribute Mappings** section, review the user attributes that are synchronized from Microsoft Entra ID to Jive. The attributes selected as **Matching** properties are used to match the user accounts in Jive for update operations. Select the Save button to commit any changes.

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](tutorial-list.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Configure Single Sign-on](jive-tutorial.md)
