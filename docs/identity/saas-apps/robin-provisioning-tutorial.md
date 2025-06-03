---
title: Configure Robin for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Robin Powered.
author: thomasakelo
manager: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: thomasakelo
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Robin so that I can streamline the user management process and ensure that users have the appropriate access to Robin.
---

# Configure Robin for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Robin and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Robin.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Robin tenant](https://robinpowered.com/pricing/)
* A user account in Robin with Admin permissions.

## Assigning users to Robin

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Robin. Once decided, you can assign these users and/or groups to Robin by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to Robin

* It's recommended that a single Microsoft Entra user is assigned to Robin to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Robin, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up Robin for provisioning

1. Sign in to your [Robin Admin Console](https://dashboard.robinpowered.com/login). Navigate to **Manage > Integrations > SCIM > Manage**.

	![robin powered Admin Console](media/robin-provisioning-tutorial/robin-admin.png)

2.	Generate a new organization token. If you lose this token, you can always make a new one without affecting existing users.

	![robin powered Add SCIM](media/robin-provisioning-tutorial/robin-token.png)

3.	Copy the **SCIM Authentication Token**. This value is entered in the Secret Token field in the Provisioning tab of your Robin application.



## Add Robin from the gallery

Before configuring Robin for automatic user provisioning with Microsoft Entra ID, you need to add Robin from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Robin from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Robin**, select **Robin** in the search box.
1. Select **Robin** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Robin in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to Robin 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Robin based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Robin, following the instructions provided in the [Robin Single sign-on  article](./robin-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other

<a name='to-configure-automatic-user-provisioning-for-robin-in-azure-ad'></a>

### To configure automatic user provisioning for Robin in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Robin**.

	![The robin powered link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input `https://api.robinpowered.com/v1.0/scim-2` in **Tenant URL**. Input the **SCIM Authentication Token** value retrieved earlier in **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Robin. If the connection fails, ensure your Robin account has Admin permissions and try again.

	![Tenant URL + Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Robin**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Robin in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Robin for update operations. Select the **Save** button to commit any changes.

	![robin powered User Attributes](media/robin-provisioning-tutorial/robin-user-attribute-mapping.png)

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Robin**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Robin in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Robin for update operations. Select the **Save** button to commit any changes.

	![robin powered Group Attributes](media/robin-provisioning-tutorial/robin-group-attribute-mapping.png)

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Robin, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Robin by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization of all users and/or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than subsequent syncs, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. You can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on Robin.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).



## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
