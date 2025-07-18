---
title: Configure LinkedIn Elevate for automatic user provisioning in Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to LinkedIn Elevate.

author: ArvindHarinder1
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: arvinh

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to LinkedIn Elevate so that I can streamline the user management process and ensure that users have the appropriate access to LinkedIn Elevate.
---

# Configure LinkedIn Elevate for automatic user provisioning in Microsoft Entra ID

The objective of this article is to show you the steps you need to perform in LinkedIn Elevate and Microsoft Entra ID to automatically provision and de-provision user accounts from Microsoft Entra ID to LinkedIn Elevate.

## Prerequisites

The scenario outlined in this article assumes that you already have the following items:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A LinkedIn Elevate tenant
* An administrator account in LinkedIn Elevates with access to the LinkedIn Account Center

> [!NOTE]
> Microsoft Entra ID integrates with LinkedIn Elevate using the SCIM protocol.

## Assigning users to LinkedIn Elevate

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected apps. In the context of automatic user account provisioning, only the users and groups that have been "assigned" to an application in Microsoft Entra ID is synchronized.

Before configuring and enabling the provisioning service, you need to decide what users and/or groups in Microsoft Entra ID represent the users who need access to LinkedIn Elevate. Once decided, you can assign these users to LinkedIn Elevate by following the instructions here:

[Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to LinkedIn Elevate

* It's recommended that a single Microsoft Entra user be assigned to LinkedIn Elevate to test the provisioning configuration. More users and/or groups may be assigned later.

* When assigning a user to LinkedIn Elevate, you must select the **User** role in the assignment dialog. The "Default Access" role doesn't work for provisioning.

## Configuring user provisioning to LinkedIn Elevate

This section guides you through connecting your Microsoft Entra ID to LinkedIn Elevate's SCIM user account provisioning API, and configuring the provisioning service to create, update disable assigned user accounts in LinkedIn Elevate based on user and group assignment in Microsoft Entra ID.

**Tip:** You may also choose to enable SAML-based single sign-on for LinkedIn Elevate, following the instructions provided in the [Azure portal](https://portal.azure.com). single sign-on can be configured independently of automatic provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-account-provisioning-to-linkedin-elevate-in-azure-ad'></a>

### To configure automatic user account provisioning to LinkedIn Elevate in Microsoft Entra ID:

The first step is to retrieve your LinkedIn access token. If you're an Enterprise administrator, you can self-provision an access token. In your account center, go to **Settings &gt; Global Settings** and open the **SCIM Setup** panel.

> [!NOTE]
> If you're accessing the account center directly rather than through a link, you can reach it using the following steps.

1. Sign in to Account Center.

1. Select **Admin &gt; Admin Settings** .

1. Select **Advanced Integrations** on the left sidebar. You're directed to the account center.

1. Select **+ Add new SCIM configuration** and follow the procedure by filling in each field.

    > [!NOTE]
    > When auto-assign licenses isn't enabled, it means that only user data is synced.

    ![Screenshot shows the LinkedIn Account Center Global Settings.](./media/linkedinelevate-provisioning-tutorial/linkedin_elevate1.PNG)

    > [!NOTE]
    > When auto-license assignment is enabled, you need to note the application instance and license type. Licenses are assigned on a first come, first serve basis until all the licenses are taken.

    ![Screenshot shows the S C I M Setup page.](./media/linkedinelevate-provisioning-tutorial/linkedin_elevate2.PNG)

1. Select **Generate token**. You should see your access token display under the **Access token** field.

1. Save your access token to your clipboard or computer before leaving the page.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

1. If you have already configured LinkedIn Elevate for single sign-on, search for your instance of LinkedIn Elevate using the search field. Otherwise, select **Add** and search for **LinkedIn Elevate** in the application gallery. Select LinkedIn Elevate from the search results, and add it to your list of applications.

1. Select your instance of LinkedIn Elevate, then select the **Provisioning** tab.

1. Set the **Provisioning Mode** to **Automatic**.

1. Fill in the following fields under **Admin Credentials** :

    * In the **Tenant URL** field, enter `https://api.linkedin.com`.

    * In the **Secret Token** field, enter the access token you generated in step 1 and select **Test Connection** .

    * You should see a success notification on the upper-right side of your portal.

1. Enter the email address of a person or group who should receive provisioning error notifications in the **Notification Email** field, and check the checkbox below.

1. Select **Save**.

1. In the **Attribute Mappings** section, review the user and group attributes that are synchronized from Microsoft Entra ID to LinkedIn Elevate. The attributes selected as **Matching** properties are used to match the user accounts and groups in LinkedIn Elevate for update operations. Select the Save button to commit any changes.

    ![Screenshot shows Mappings, including Attribute Mappings.](./media/linkedinelevate-provisioning-tutorial/linkedin_elevate4.PNG)

1. To enable the Microsoft Entra provisioning service for LinkedIn Elevate, change the **Provisioning Status** to **On** in the **Settings** section

1. Select **Save**.

This starts the initial synchronization of any users and/or groups assigned to LinkedIn Elevate in the Users and Groups section. The initial sync takes longer to perform than subsequent syncs, which occur approximately every 40 minutes as long as the service is running. You can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity logs, which describe all actions performed by the provisioning service on your LinkedIn Elevate app.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## More Resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
