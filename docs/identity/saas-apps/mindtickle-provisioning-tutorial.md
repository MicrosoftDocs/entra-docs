---
title: Configure MindTickle for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to MindTickle.
author: jeevansd
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Mindtickle so that I can streamline the user management process and ensure that users have the appropriate access to Mindtickle.
---

# Configure MindTickle for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in MindTickle and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to MindTickle.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A MindTickle tenant](https://www.mindtickle.com/)
* A user account in MindTickle with Admin permissions.

## Assigning users to MindTickle

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to MindTickle. Once decided, you can assign these users and/or groups to MindTickle by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to MindTickle

* It's recommended that a single Microsoft Entra user is assigned to MindTickle to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to MindTickle, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Setup MindTickle for provisioning

Before configuring MindTickle for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on MindTickle.


1.	Reach out to the  [MindTickle's support team](mailto:help@mindtickle.com) to obtain the JWT token needed to configure SCIM provisioning.


## Add MindTickle from the gallery

To configure MindTickle for automatic user provisioning with Microsoft Entra ID, you need to add MindTickle from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add MindTickle from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **MindTickle**, select **MindTickle** in the search box.
1. Select **MindTickle** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![MindTickle in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to MindTickle 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in MindTickle based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for MindTickle, following the instructions provided in the [MindTickle Single sign-on  article](mindtickle-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other

<a name='to-configure-automatic-user-provisioning-for-mindtickle-in-azure-ad'></a>

### To configure automatic user provisioning for MindTickle in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **MindTickle**.

	![The MindTickle link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input `https://admin.mindtickle.com/scim` in **Tenant URL**. Input the **JWT token** value retrieved earlier In Secret Token textbox, enter the **JWT token** value which was given by MindTickle support team. Select **Test Connection** to ensure Microsoft Entra ID can connect to myPolicies. If the connection fails, ensure your MindTickle account has Admin permissions and try again.

	![Tenant URL + Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to MindTickle**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to MindTickle in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in MindTickle for update operations. Select the **Save** button to commit any changes.

	:::image type="content" source="media/mindtickle-provisioning-tutorial/userattribute.png" alt-text="Screenshot of the Attribute Mappings page. A table lists Microsoft Entra ID and MindTickle attributes and the matching precedence." border="false":::

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for MindTickle, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to MindTickle by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization of all users and/or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than subsequent syncs. For more information on how long it will take for users and/or groups to provision, see [How long will it take to provision users](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md#how-long-will-it-take-to-provision-users). 

You can use the **Current Status** section to monitor progress and follow links to your provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on MindTickle. For more information, see [Check the status of user provisioning](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md). To read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
