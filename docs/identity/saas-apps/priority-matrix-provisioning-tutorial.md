---
title: Configure Priority Matrix for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Priority Matrix.
author: adimitui
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Priority Matrix so that I can streamline the user management process and ensure that users have the appropriate access to Priority Matrix.
---

# Configure Priority Matrix for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Priority Matrix and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Priority Matrix.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Priority Matrix tenant](https://appfluence.com/pricing/)
* A user account on a Priority Matrix with Admin permissions.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Assign users to Priority Matrix

Microsoft Entra ID uses a concept called assignments to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Priority Matrix. Once decided, you can assign these users and/or groups to Priority Matrix by following the instructions here:

* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Priority Matrix

* It's recommended that a single Microsoft Entra user is assigned to Priority Matrix to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Priority Matrix, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up Priority Matrix for provisioning

Before configuring Priority Matrix for automatic user provisioning with Microsoft Entra ID, you need to retrieve some provisioning information from Priority Matrix.

1. Sign in to your [Priority Matrix Admin Console](https://sync.appfluence.com/accounts/login/?next=/accounts/provisioning).

3. Select **Oauth login token** for Priority Matrix

	![Priority Matrix Add SCIM](media/priority-matrix-provisioning-tutorial/oauthlogin.png)

4. Select the **GET NEW TOKEN** button. Copy the **Token String**. This value is entered in the **Secret Token** field in the Provisioning tab of your Priority Matrix application.

## Add Priority Matrix from the gallery

To configure Priority Matrix for automatic user provisioning with Microsoft Entra ID, you need to add Priority Matrix from the Microsoft Entra application gallery to your list of managed SaaS applications.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Priority Matrix**, select **Priority Matrix** in the results panel. 

	![Priority Matrix in the results list](common/search-new-app.png)

5. Select the **Sign-up for Priority Matrix** button which will redirect you to Priority Matrix's login page. 

	![Priority Matrix OIDC Add](media/priority-matrix-provisioning-tutorial/signup.png)

6. As Priority Matrix is an OpenIDConnect app, choose to log in to Priority Matrix using your Microsoft work account.

	![Priority Matrix OIDC login](media/priority-matrix-provisioning-tutorial/msftsignin.png)

7. After a successful authentication, accept the consent prompt for the consent page. The application will then be automatically added to your tenant and you be redirected to your Priority Matrix account.


## Configure automatic user provisioning to Priority Matrix 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Priority Matrix based on user and/or group assignments in Microsoft Entra ID.

> [!NOTE]
> To learn more about Priority Matrix's SCIM endpoint, refer to [User provisioning and Priority Matrix](https://appfluence.com/help/article/user-provisioning/).

<a name='to-configure-automatic-user-provisioning-for-priority-matrix-in-azure-ad'></a>

### To configure automatic user provisioning for Priority Matrix in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Priority Matrix**.

	![The Priority Matrix link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input `https://sync.appfluence.com/scim/v2/` in **Tenant URL**. Input the value that you retrieved and saved earlier from Priority Matrix in **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Priority Matrix. If the connection fails, ensure your Priority Matrix account has Admin permissions and try again.

	![Tenant URL + Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Priority Matrix**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Priority Matrix in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Priority Matrix for update operations. Select the **Save** button to commit any changes.

	![Priority Matrix User Attributes](media/priority-matrix-provisioning-tutorial/userattributes.png)

10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for Priority Matrix, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users and/or groups that you would like to provision to Priority Matrix by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

13. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization of all users and/or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than subsequent syncs, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. You can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on Priority Matrix.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
