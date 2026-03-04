---
title: Configure GoToMeeting for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and GoToMeeting.

ms.topic: how-to
ms.date: 03/04/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to GoToMeeting so that I can streamline the user management process and ensure that users have the appropriate access to GoToMeeting.
---
# Configure GoToMeeting for automatic user provisioning with Microsoft Entra ID

The objective of this article is to show you the steps you need to perform in GoToMeeting and Microsoft Entra ID to automatically provision and de-provision user accounts from Microsoft Entra ID to GoToMeeting.

> [!WARNING]
> This provisioning integration is no longer supported. As a result of this, the provisioning functionality of the GoToMeeting application in the Microsoft Entra Enterprise App Gallery is removed soon. The application's SSO functionality will remain intact. Microsoft is working with GoToMeeting to build a new modernized provisioning integration, but there are no timelines on when it's completed. 

## Prerequisites

The scenario outlined in this article assumes that you already have the following items:

*   A Microsoft Entra tenant.
*   A GoToMeeting single  sign-on enabled subscription.
*   A user account in GoToMeeting with Team Admin permissions.

## Assigning users to GoToMeeting

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected apps. In the context of automatic user account provisioning, only the users and groups that have been "assigned" to an application in Microsoft Entra ID is synchronized.

Before configuring and enabling the provisioning service, you need to decide what users and/or groups in Microsoft Entra ID represent the users who need access to your GoToMeeting app. Once decided, you can assign these users to your GoToMeeting app by following the instructions here:

[Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to GoToMeeting

*   It's recommended that a single Microsoft Entra user is assigned to GoToMeeting to test the provisioning configuration. Additional users and/or groups may be assigned later.

*   When assigning a user to GoToMeeting, you must select a valid user role. The "Default Access" role doesn't work for provisioning.

## Enable Automated User Provisioning

This section guides you through connecting your Microsoft Entra ID to GoToMeeting's user account provisioning API, and configuring the provisioning service to create, update, and disable assigned user accounts in GoToMeeting based on user and group assignment in Microsoft Entra ID.

> [!TIP]
> You may also choose to enabled SAML-based Single Sign-On for GoToMeeting, following the instructions provided in the [Azure portal](https://portal.azure.com). Single sign-on can be configured independently of automatic provisioning, though these two features complement each other.

### To configure automatic user account provisioning:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

1. If you have already configured GoToMeeting for single sign-on, search for your instance of GoToMeeting using the search field. Otherwise, select **Add** and search for **GoToMeeting** in the application gallery. Select GoToMeeting from the search results, and add it to your list of applications.

1. Select your instance of GoToMeeting, then select the **Provisioning** tab.

1. Set **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your GoToMeeting Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to GoToMeeting. If the connection fails, ensure your GoToMeeting account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.	

1. Select **Properties** in the **Overview** page. 

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to GoToMeeting. The attributes selected as **Matching** properties are used to match the user accounts in GoToMeeting for update operations. Select the Save button to commit any changes.

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](tutorial-list.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Configure Single Sign-on](./citrix-gotomeeting-tutorial.md)
