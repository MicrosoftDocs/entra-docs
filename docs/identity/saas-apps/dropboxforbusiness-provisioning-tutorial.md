---
title: Configure Dropbox for Business for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Dropbox for Business.
author: jeevansd
ms.topic: how-to
ms.date: 04/06/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Dropbox Business so that I can streamline the user management process and ensure that users have the appropriate access to Dropbox Business.
---

# Configure Dropbox for Business for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Dropbox for Business and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Dropbox for Business.

> [!IMPORTANT]
> In the future, Microsoft and Dropbox are deprecating the old Dropbox integration. This was originally planned for 4/1/2021, but has been postponed indefinitely. However, to avoid disruption of service, we recommend migrating to the new SCIM 2.0 Dropbox integration which supports Groups. To migrate to the new Dropbox integration, add and configure a new instance of Dropbox for Provisioning in your Microsoft Entra tenant using the steps below. Once you have configured the new Dropbox integration, disable Provisioning on the old Dropbox integration to avoid Provisioning conflicts. For more detailed steps on migrating to the new Dropbox integration, see [Update to the newest Dropbox for Business application using Microsoft Entra ID](https://help.dropbox.com/installs-integrations/third-party/update-dropbox-azure-ad-connector) and [Connect Dropbox with Microsoft Entra ID](https://help.dropbox.com/integrations/microsoft-entra-id).

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Dropbox for Business tenant](https://www.dropbox.com/business/pricing)
* A user account in Dropbox for Business with Admin permissions.

## Add Dropbox for Business from the gallery

Before configuring Dropbox for Business for automatic user provisioning with Microsoft Entra ID, you need to add Dropbox for Business from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Dropbox for Business from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Dropbox for Business**, select **Dropbox for Business** in the search box.
1. Select **Dropbox for Business** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Screenshot of Dropbox for Business in the results list.](common/search-new-app.png)

## Assigning users to Dropbox for Business

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Dropbox for Business. Once decided, you can assign these users and/or groups to Dropbox for Business by following the instructions here:

* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Dropbox for Business

* It's recommended that a single Microsoft Entra user is assigned to Dropbox for Business to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Dropbox for Business, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Configuring automatic user provisioning to Dropbox for Business 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Dropbox for Business based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Dropbox for Business, following the instructions provided in the [Dropbox for Business single sign-on  article](dropboxforbusiness-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-dropbox-for-business-in-azure-ad'></a>

### To configure automatic user provisioning for Dropbox for Business in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Dropbox for Business**.

	![Screenshot of The Dropbox for Business link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Dropbox Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Dropbox. If the connection fails, ensure your Dropbox account has the required admin permissions and try again.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. On the **Sign-in to Dropbox for Business to link with Microsoft Entra ID** dialog, sign in to your Dropbox for Business tenant and verify your identity.

	![Screenshot of Dropbox for Business sign-in.](media/dropboxforbusiness-provisioning-tutorial/dropbox01.png)

1. Select **Test Connection** to ensure Microsoft Entra ID can connect to Dropbox for Business. If the connection fails, ensure your Dropbox for Business account has Admin permissions and try again.

	![Screenshot of Token.](common/provisioning-testconnection-oauth.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Dropbox in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Dropbox for update operations. Select the **Save** button to commit any changes.

	![Screenshot of Dropbox User Attributes.](media/dropboxforbusiness-provisioning-tutorial/dropbox-user-attributes.png)

1. Select **Attribute Mapping** in the left panel and select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Dropbox in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Dropbox for update operations. Select the **Save** button to commit any changes.

	![Screenshot of Dropbox Group Attributes.](media/dropboxforbusiness-provisioning-tutorial/dropbox-group-attributes.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization. 

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Connector Limitations
 
* Dropbox doesn't support suspending invited users. If an invited user is  suspended, that user is deleted.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
