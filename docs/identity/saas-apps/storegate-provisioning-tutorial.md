---
title: Configure Storegate for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Storegate.
author: jeevansd
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Storegate so that I can streamline the user management process and ensure that users have the appropriate access to Storegate.
---

# Configure Storegate for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Storegate and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Storegate.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Storegate tenant](https://www.storegate.com)
* A user account on a Storegate with Administrator permissions.

## Assign users to Storegate

Microsoft Entra ID uses a concept called assignments to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Storegate. Once decided, you can assign these users and/or groups to Storegate by following the instructions here:

* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Storegate

* It's recommended that a single Microsoft Entra user is assigned to Storegate to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Storegate, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up Storegate for provisioning

Before configuring Storegate for automatic user provisioning with Microsoft Entra ID, you need to retrieve some provisioning information from Storegate.

1. Sign in to your [Storegate Admin Console](https://ws1.storegate.com/identity/core/login?signin=c71fb8fe18243c571da5b333d5437367) and navigate to the settings by selecting the user icon in the upper right corner and select **Account Settings**.

	![Storegate Add SCIM](media/storegate-provisioning-tutorial/admin.png)

2. Within settings navigate to **Team > Settings** and verify that the toggle switch is switched on in the **Single sign-on** section.

	![Storegate settings](media/storegate-provisioning-tutorial/team.png)

	![Storegate toggle button](media/storegate-provisioning-tutorial/sso.png)

3. Copy the **Tenant URL** and **Token**. These values are entered in the **Tenant URL** and **Secret Token** fields respectively in the Provisioning tab of your Storegate application. 

## Add Storegate from the gallery

To configure Storegate for automatic user provisioning with Microsoft Entra ID, you need to add Storegate from the Microsoft Entra application gallery to your list of managed SaaS applications.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Storegate**, select **Storegate** in the results panel. 

	![Storegate in the results list](common/search-new-app.png)

1. Select the **Sign-up for Storegate** button which will redirect you to Storegate's login page. 

	![Storegate OIDC Add](media/storegate-provisioning-tutorial/signup.png)

1. Sign in to your [Storegate Admin Console](https://ws1.storegate.com/identity/core/login?signin=c71fb8fe18243c571da5b333d5437367) and navigate to the settings by selecting the user icon in the upper right corner and select **Account Settings**.

	![Storegate login](media/storegate-provisioning-tutorial/admin.png)

1. Within settings navigate to **Team > Settings** and select toggle switch in the Single sign-on section, this will start the consent-flow. Select **Activate**.

	![Storegate team](media/storegate-provisioning-tutorial/team.png)

	![Storegate sso](media/storegate-provisioning-tutorial/sso.png)


1. As Storegate is an OpenIDConnect app, choose to log in to Storegate using your Microsoft work account.

	![Storegate OIDC login](media/storegate-provisioning-tutorial/login.png)

1. After a successful authentication, accept the consent prompt for the consent page. The application will then be automatically added to your tenant and you be redirected to your Storegate account.


## Configure automatic user provisioning to Storegate 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Storegate based on user and/or group assignments in Microsoft Entra ID.

> [!NOTE]
> To learn more about Storegate's SCIM endpoint, refer [this](https://en-support.storegate.com/article/step-by-step-instruction-how-to-enable-azure-provisioning-to-your-storegate-team-account/).

<a name='to-configure-automatic-user-provisioning-for-storegate-in-azure-ad'></a>

### To configure automatic user provisioning for Storegate in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Storegate**.

	![The Storegate link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

1.  Under the **Admin Credentials** section, input `https://dialpad.com/scim` in **Tenant URL**. Input the value that you retrieved and saved earlier from Storegate in **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Storegate. If the connection fails, ensure your Storegate account has Admin permissions and try again.

	![Tenant URL + Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Storegate**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Storegate in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Storegate for update operations. Select the **Save** button to commit any changes.


   |Attribute|Type|Supported for filtering|Required by Storegate|
   |---|---|---|---|
   |userName|String|&check;|&check; 
   |active|Boolean||
   |preferredLanguage|String||
   |name.givenName|String||
   |name.familyName|String||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Storegate, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Storegate by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization of all users and/or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than subsequent syncs, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. You can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on Storegate.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
