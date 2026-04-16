---
title: Configure Promapp for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Promapp.
author: jeevansd
ms.topic: how-to
ms.date: 04/16/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Promapp so that I can streamline the user management process and ensure that users have the appropriate access to Promapp.
---

# Configure Promapp for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Promapp and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Promapp.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Promapp tenant](https://www.promapp.com/licensing/)
* A user account in Promapp with Admin permissions.

## Assigning users to Promapp

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Promapp. Once decided, you can assign these users and/or groups to Promapp by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to Promapp

* It's recommended that a single Microsoft Entra user is assigned to Promapp to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Promapp, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up Promapp for provisioning

1. Sign in to your [Promapp Admin Console](https://freetrial.promapp.com/axelerate/Login.aspx). Under the user name navigate to **My Profile**.

	![Promapp Admin Console](media/promapp-provisioning-tutorial/admin.png)

1.	Under **Access Tokens** select the **Create Token** button.

	![Promapp Add SCIM](media/promapp-provisioning-tutorial/addtoken.png)

1.	Provide any name in the **Description** field and select **SCIM** from the **Scope** dropdown menu. Select the save icon.

	![Promapp Add Name](media/promapp-provisioning-tutorial/addname.png)

1.	Copy the access token and save it as it's the only time you can view it. This value is entered in the Secret Token field in the Provisioning tab of your Promapp application.

	![Promapp Create Token](media/promapp-provisioning-tutorial/token.png)

## Add Promapp from the gallery

Before configuring Promapp for automatic user provisioning with Microsoft Entra ID, you need to add Promapp from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Promapp from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Promapp**, select **Promapp** in the search box.
1. Select **Promapp** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Promapp in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to Promapp 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Promapp based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Promapp by following the instructions provided in the [Promapp Single sign-on  article](./promapp-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, although these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-promapp-in-azure-ad'></a>

### To configure automatic user provisioning for Promapp in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Promapp**.

	![The Promapp link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Promapp Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Promapp. If the connection fails, ensure your Promapp account has the required admin permissions and try again.
	
	> [!NOTE]
	> Enter `https://api.promapp.com/api/scim` in the **Tenant URL**

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Promapp in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Promapp for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Promapp API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

	![Promapp User Attributes](media/promapp-provisioning-tutorial/userattributes.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
