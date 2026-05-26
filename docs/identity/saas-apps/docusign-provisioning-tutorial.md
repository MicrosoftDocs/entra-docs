---
title: Configure DocuSign for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and DocuSign.

ms.topic: how-to
ms.date: 04/06/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to DocuSign so that I can streamline the user management process and ensure that users have the appropriate access to DocuSign.
---
# Configure DocuSign for automatic user provisioning with Microsoft Entra ID

The objective of this article is to show you the steps you need to perform in DocuSign and Microsoft Entra ID to automatically provision and de-provision user accounts from Microsoft Entra ID to DocuSign.

## Prerequisites

The scenario outlined in this article assumes that you already have the following items:

*   A Microsoft Entra tenant.
*   A DocuSign single sign-on enabled subscription.
*   A user account in DocuSign with Team Admin permissions.

## Assigning users to DocuSign

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected apps. In the context of automatic user account provisioning, only the users and groups that have been "assigned" to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling the provisioning service, you need to decide what users and/or groups in Microsoft Entra ID represent the users who need access to your DocuSign app. Once decided, you can assign these users to your DocuSign app by following the instructions here:

[Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to DocuSign

*   It's recommended that a single Microsoft Entra user is assigned to DocuSign to test the provisioning configuration. Additional users may be assigned later.

*   When assigning a user to DocuSign, you must select a valid user role. The "Default Access" role doesn't work for provisioning.

> [!NOTE]
> Microsoft Entra ID doesn't support group provisioning with the Docusign application, only users can be provisioned.

## Enable User Provisioning

This section guides you through connecting your Microsoft Entra ID to DocuSign's user account provisioning API, and configuring the provisioning service to create, update, and disable assigned user accounts in DocuSign based on user and group assignment in Microsoft Entra ID.

> [!Tip]
> You may also choose to enabled SAML-based Single Sign-On for DocuSign, following the instructions provided in the [Azure portal](https://portal.azure.com). Single sign-on can be configured independently of automatic provisioning, though these two features complement each other.

### To configure user account provisioning:

The objective of this section is to outline how to enable user provisioning of Active Directory user accounts to DocuSign.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

1. If you have already configured DocuSign for single sign-on, search for your instance of DocuSign using the search field. Otherwise, select **Add** and search for **DocuSign** in the application gallery. Select DocuSign from the search results, and add it to your list of applications.

1. Select your instance of DocuSign, then select the **Provisioning** tab.

1. Select **+ New configuration**.

    ![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. In the **Tenant URL** field, input your DocuSign Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to DocuSign. If the connection fails, ensure your DocuSign account has the required admin permissions and try again.

1. Select **Properties** on the **Overview** page.


1. Select **Create** to create your configuration.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. In the **Attribute Mappings** section, review the user attributes that are synchronized from Microsoft Entra ID to DocuSign. The attributes selected as **Matching** properties are used to match the user accounts in DocuSign for update operations. Select the Save button to commit any changes.

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Troubleshooting Tips
* Provisioning a role or permission profile for a user in Docusign can be accomplished by using an expression in your attribute mappings using the [switch](~/identity/app-provisioning/functions-for-customizing-application-data.md#switch) and [singleAppRoleAssignment](~/identity/app-provisioning/functions-for-customizing-application-data.md#singleapproleassignment) functions. For example, the expression below will provision the ID "8032066" when a user has the "DS Admin" role assigned in Microsoft Entra ID. It doesn't provision any permission profile if the user isn't assigned a role on the Microsoft Entra ID side. The ID can be retrieved from the DocuSign [portal](https://support.docusign.com/).

Switch(SingleAppRoleAssignment([appRoleAssignments])," ", "DS Admin", "8032066")


## Additional resources

* [Managing user account provisioning for Enterprise Apps](tutorial-list.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Configure Single Sign-on](docusign-tutorial.md)
