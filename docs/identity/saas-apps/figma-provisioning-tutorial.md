---
title: Configure Configure Figma for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Figma.
author: jeevansd
ms.topic: how-to
ms.date: 04/07/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Figma so that I can streamline the user management process and ensure that users have the appropriate access to Figma.
---

# Configure Configure Figma for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Figma  and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Figma.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A Figma tenant](https://www.figma.com/pricing/).
* A user account in Figma  with Admin permissions.

## Assign users to Figma.
Microsoft Entra ID uses a concept called assignments to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Figma. Once decided, you can assign these users and/or groups to Figma by following the instructions here:
 
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)
## Important tips for assigning users to Figma

 * It's recommended that a single Microsoft Entra user is assigned to Figma to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Figma, you must select any valid application-specific role (if available) in the assignment dialog. Users with the Default Access role are excluded from provisioning.

## Set up Figma for provisioning

Before configuring Figma for automatic user provisioning with Microsoft Entra ID, you need to retrieve some provisioning information from Figma.

1. Sign in to your [Figma Admin Console](https://www.Figma.com/). Select the gear icon next to your tenant.

	:::image type="content" source="media/Figma-provisioning-tutorial/image0.png" alt-text="Screenshot of the Figma admin console. A tenant named A A D Scim Test is visible. Next to the tenant, a gear icon is highlighted." border="false":::

1. Navigate to **General > Update Log in Settings**.

	:::image type="content" source="media/Figma-provisioning-tutorial/figma03.png" alt-text="Screenshot of the General tab of the Figma admin console. Under Log in and provisioning, Update log in settings is highlighted." border="false":::

1. Copy the **Tenant ID**. This value is used to construct the SCIM endpoint URL to be entered into the **Tenant URL** field in the Provisioning tab of your Figma application.

	:::image type="content" source="media/Figma-provisioning-tutorial/figma-tenantid.png" alt-text="Screenshot of the S A M L S S O section in the Figma admin console. A Tenant ID label and an adjacent link that says Copy are highlighted." border="false":::

1. Scroll down and select **Generate API Token**.

	:::image type="content" source="media/Figma-provisioning-tutorial/token.png" alt-text="Screenshot of the S C I M provisioning section in the Figma admin console. A link labeled Generate A P I token is highlighted." border="false":::

1. Copy the  **API Token** value. This value is entered in the **Secret Token** field in the Provisioning tab of your Figma application. 

	:::image type="content" source="media/Figma-provisioning-tutorial/figma04.png" alt-text="Screenshot of a page in the Figma admin console. Under Your provisioning A P I token, a placeholder for the token is highlighted." border="false":::

## Add Figma from the gallery

To configure Figma for automatic user provisioning with Microsoft Entra ID, you need to add Figma from the Microsoft Entra application gallery to your list of managed SaaS applications.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Figma**, select **Figma** in the search box.
1. Select **Figma** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Screenshot of Figma  in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to Figma 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Figma  based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Figma, following the instructions provided in the [Figma Single sign-on  article](figma-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-figma--in-azure-ad'></a>

### To configure automatic user provisioning for Figma  in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Figma**.

	![Screenshot of The Figma  link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Figma Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Figma. If the connection fails, ensure your Figma account has the required admin permissions and try again.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Figma  in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Figma  for update operations. Select the **Save** button to commit any changes.

	![Screenshot of Figma User Attributes](media/Figma-provisioning-tutorial/figma06.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization. 

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
