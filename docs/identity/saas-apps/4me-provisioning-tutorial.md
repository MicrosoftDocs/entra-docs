---
title: Configure 4me for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to 4me.
author: adimitui
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to 4me so that I can streamline the user management process and ensure that users have the appropriate access to 4me.
---

# Configure 4me for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in 4me and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to 4me.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user Provisioning Service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A 4me tenant](https://www.4me.com/)
* A user account in 4me with Admin permissions.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Add 4me from the gallery

Before configuring 4me for automatic user provisioning with Microsoft Entra ID, you need to add 4me from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add 4me from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **4me**, select **4me** in the search box.
1. Select **4me** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Screenshot of 4me in the results list.](common/search-new-app.png)

## Assigning users to 4me

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to 4me. Once decided, you can assign these users and/or groups to 4me by following the instructions here:

* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to 4me

* It's recommended that a single Microsoft Entra user is assigned to 4me to test the automatic user provisioning configuration. Additional users and/or groups can be assigned later.

* When assigning a user to 4me, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Configuring automatic user provisioning to 4me 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in 4me based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You can also choose to enable SAML-based single sign-on for 4me, following the instructions provided in the [4me single sign-on  article.(4me-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-4me-in-azure-ad'></a>

### To configure automatic user provisioning for 4me in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **4me**.

	![Screenshot of The 4me link in the Applications list.](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. To retrieve the **Tenant URL** and **Secret Token** of your 4me account, follow the walkthrough as described in Step 6.

6. Sign in to your 4me Admin Console. Navigate to **Settings**.

	![Screenshot of 4me Settings.](media/4me-provisioning-tutorial/4me01.png)

	Type in **apps** in the search bar.

	![Screenshot of 4me apps.](media/4me-provisioning-tutorial/4me02.png)

	Open the **SCIM** dropdown to retrieve the Secret Token and the SCIM endpoint.

	![Screenshot of 4me SCIM.](media/4me-provisioning-tutorial/4me03.png)

7. Upon populating the fields shown in Step 5, select **Test Connection** to ensure Microsoft Entra ID can connect to 4me. If the connection fails, ensure your 4me account has Admin permissions and try again.

	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

8. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

9. Select **Save**.

10. Under the **Mappings** section, select **Synchronize Microsoft Entra users to 4me**.
	
11. Review the user attributes that are synchronized from Microsoft Entra ID to 4me in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in 4me for update operations. Please ensure that [4me supports filtering](https://developer.4me.com/v1/scim/users/) on the matching attribute you have chosen. Select the **Save** button to commit any changes.

	![Screenshot of 4me User attributes list.](media/4me-provisioning-tutorial/4me-user-attributes-first-part.png)
	![Screenshot of 4me User attributes list-2.](media/4me-provisioning-tutorial/4me-user-attributes-second-part.png)
	
12. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to 4me**.
	
13. Review the group attributes that are synchronized from Microsoft Entra ID to 4me in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in 4me for update operations. Select the **Save** button to commit any changes.

	![Screenshot of 4me Group attributes list.](media/4me-provisioning-tutorial/4me-group-attribute.png)

14. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

15. To enable the Microsoft Entra provisioning service for 4me, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

16. Define the users and/or groups that you would like to provision to 4me by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

17. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization of all users and/or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than subsequent syncs, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. You can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on 4me.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Connector Limitations

* 4me has different SCIM endpoint URLs for test and production environments. The former ends with **.qa** while the latter ends with **.com**
* 4me generated Secret Tokens have an expiration date of a month from generation.
* 4me doesn’t support **HARD DELETE** of Users. SCIM users are never really deleted in 4me, instead the **active** attribute of the SCIM user is set to **false** and the related 4me person record is disabled.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
