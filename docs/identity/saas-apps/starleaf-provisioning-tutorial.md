---
title: Configure StarLeaf for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to StarLeaf.
author: jeevansd
ms.topic: how-to
ms.date: 04/13/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to StarLeaf so that I can streamline the user management process and ensure that users have the appropriate access to StarLeaf.
---

# Configure StarLeaf for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in StarLeaf and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to StarLeaf.

> [!NOTE]
>  This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>
> This connector is currently in Preview. For more information about previews, see [Universal License Terms For Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A StarLeaf tenant](https://starleaf.com/).
* A user account in StarLeaf with Admin permissions.

## Step 1: Assign users to StarLeaf
Microsoft Entra ID uses a concept called assignments to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before you configure and enable automatic user provisioning, you should decide which users and groups in Microsoft Entra ID need access to StarLeaf. Then you can assign the users and groups to StarLeaf by following [these instructions](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).

### Important tips for assigning users to StarLeaf

* It's recommended that a single Microsoft Entra user is assigned to StarLeaf to test the automatic user provisioning configuration. More users and groups can be assigned later.

* When you assign a user to StarLeaf, you must select any valid application-specific role (if available) in the assignment dialog. Users with the Default Access role are excluded from provisioning.

## Step 2: Set up StarLeaf for provisioning

Before you configure StarLeaf for automatic user provisioning with Microsoft Entra ID, you need to configure SCIM provisioning in StarLeaf:

1. Sign in to your StarLeaf Admin Console. Navigate to **Integrations** > **Add integration**.

	![Screenshot of the StarLeaf Admin Console with the Integrations and Add integration options called out.](media/starleaf-provisioning-tutorial/image00.png)

1. Select the **Type** to be Microsoft Entra ID. Enter a suitable name in **Name**. Select **Apply**.

	![Screenshot of the Add integration dialog box with the Type and Name text boxes called out.](media/starleaf-provisioning-tutorial/image01.png)

1.  The **SCIM base URL** and **Access token** values are then displayed. These values are entered in the **Tenant URL** and **Secret Token** fields in the Provisioning tab of your StarLeaf application. 

	![Screenshot of the Edit integration dialog box with the Type, Name, and SCIM base URL text boxes called out.](media/starleaf-provisioning-tutorial/image02.png)

## Step 3: Add StarLeaf from the gallery

To configure StarLeaf for automatic user provisioning with Microsoft Entra ID, you need to add StarLeaf from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add StarLeaf from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **StarLeaf**, select **StarLeaf** in the results panel.

	![Screenshot of the StarLeaf in the results list.](common/search-new-app.png)

## Step 4: Configure automatic user provisioning to StarLeaf

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in StarLeaf based on user and/or group assignments in Microsoft Entra ID.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of the Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **StarLeaf**.

	![Screenshot of the StarLeaf link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of the New configuration option on the Provisioning page.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your StarLeaf Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to StarLeaf. If the connection fails, ensure your StarLeaf account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

   ![Screenshot of the Provisioning properties page.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to StarLeaf in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in StarLeaf for update operations. Select the **Save** button to commit any changes.

	![Screenshot of the Attribute Mappings section showing nine mappings displayed.](media/starleaf-provisioning-tutorial/userattribute.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Connector limitations

* StarLeaf doesn't currently support group provisioning. 
* StarLeaf requires **email** and **userName** values to have the same source value.

## More resources

* [Manage user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* Learn how to [review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md).
