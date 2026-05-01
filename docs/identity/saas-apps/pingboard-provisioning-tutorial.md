---
title: Configure Pingboard for automatic user provisioning in Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Pingboard.

author: ArvindHarinder1
ms.topic: how-to
ms.date: 04/21/2026
ms.author: arvinh

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Pingboard so that I can streamline the user management process and ensure that users have the appropriate access to Pingboard.
---

# Configure Pingboard for automatic user provisioning in Microsoft Entra ID

The purpose of this article is to show you the steps you need to follow to enable automatic provisioning and de-provisioning of user accounts from Microsoft Entra ID to Pingboard.

## Prerequisites

The scenario outlined in this article assumes that you already have the following items:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Pingboard tenant [Pro account](https://pingboard.com/pricing)
* A user account in Pingboard with admin permissions

> [!NOTE]
> Microsoft Entra provisioning integration relies on the [Pingboard API](https://pingboard.docs.apiary.io/#), which is available to your account.

## Assign users to Pingboard

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected applications. In the context of automatic user account provisioning, only the users assigned to an application in Microsoft Entra ID are synchronized. 

Before you configure and enable the provisioning service, you must decide which users in Microsoft Entra ID need access to your Pingboard app. Then you can assign these users to your Pingboard app by following the instructions here:

[Assign a user to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Pingboard

We recommend that you assign a single Microsoft Entra user to Pingboard to test the provisioning configuration. Additional users can be assigned later.

## Configure user provisioning to Pingboard 

This section guides you through connecting your Microsoft Entra ID to the Pingboard user account provisioning API. You also configure the provisioning service to create, update, and disable assigned user accounts in Pingboard that are based on user assignments in Microsoft Entra ID.

> [!TIP]
> To enable SAML-based single sign-on for Pingboard, follow the instructions provided in the [Azure portal](https://portal.azure.com). Single sign-on can be configured independently of automatic provisioning, although these two features complement each other.

<a name='to-configure-automatic-user-account-provisioning-to-pingboard-in-azure-ad'></a>

### To configure automatic user account provisioning to Pingboard in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

1. If you already configured Pingboard for single sign-on, search for your instance of Pingboard by using the search field. Otherwise, select **Add** and search for **Pingboard** in the application gallery. Select **Pingboard** from the search results, and add it to your list of applications.

1. Select your instance of Pingboard, and then select the **Provisioning** tab.

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Pingboard Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Pingboard. If the connection fails, ensure your Pingboard account has the required admin permissions and try again.

    ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** in the **Overview** page.

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

    ![Screenshot of the Provisioning properties page showing notification and deletion settings.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. In the **Attribute Mappings** section, review the user attributes to be synchronized from Microsoft Entra ID to Pingboard. The attributes selected as **Matching** properties are used to match the user accounts in Pingboard for update operations. Select **Save** to commit any changes. For more information, see [Customize user provisioning attribute mappings](~/identity/app-provisioning/customize-application-attributes.md).

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

For more information on how to read the Microsoft Entra provisioning logs, see [Report on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Additional resources

* [Manage user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Configure single sign-on](pingboard-tutorial.md)
