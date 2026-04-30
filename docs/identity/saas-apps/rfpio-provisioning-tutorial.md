---
title: Configure RFPIO for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to RFPIO.
author: jeevansd
ms.topic: how-to
ms.date: 04/20/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to RFPIO so that I can streamline the user management process and ensure that users have the appropriate access to RFPIO.
---

# Configure RFPIO for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in RFPIO and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to RFPIO.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A RFPIO tenant](https://www.rfpio.com/product/).
* A user account in RFPIO with Admin permissions.

## Assigning users to RFPIO

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to RFPIO. Once decided, you can assign these users and/or groups to RFPIO by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to RFPIO

* It's recommended that a single Microsoft Entra user is assigned to RFPIO to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to RFPIO, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up RFPIO for provisioning

Before configuring RFPIO for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on RFPIO.

1. 	Sign in to your RFPIO Admin Console. On the bottom left of the admin console, select **Tenant**.

	![Screenshot of RFPIO Admin Console](media/rfpio-provisioning-tutorial/aadtest0.png)

2.	Select **Organization Settings**.
	
	![Screenshot of RFPIO Admin](media/rfpio-provisioning-tutorial/aadtest.png)

3.	Navigate to **USER MANAGEMENT** > **SECURITY** > **SCIM**.

	![Screenshot of RFPIO Add SCIM](media/rfpio-provisioning-tutorial/scim.png)

4.	Ensure that **Auto User Provisioning** is enabled. Select **GENERATE SCIM API TOKEN**.

	![Screenshot of the S C I M section with the GENERATE S C I M A P I TOKEN option called out.](media/rfpio-provisioning-tutorial/generate.png)

5.	Save the **SCIM API Token** as this token isn't displayed again for security purpose. This value is entered in the **Secret Token** field in the Provisioning tab of your RFPIO application.

	![Screenshot of the S C I M section with the Warning dialog box that appears after you select SUBMIT.](media/rfpio-provisioning-tutorial/auth.png)

## Add RFPIO from the gallery

To configure RFPIO for automatic user provisioning with Microsoft Entra ID, you need to add RFPIO from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add RFPIO from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **RFPIO**, select **RFPIO** in the results panel, and then select the 	**Add** button to add the application.

	![Screenshot of RFPIO in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to RFPIO 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in RFPIO based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for RFPIO, following the instructions provided in the [RFPIO Single sign-on  article](rfpio-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-rfpio-in-azure-ad'></a>

### To configure automatic user provisioning for RFPIO in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **RFPIO**.

	![Screenshot of the RFPIO link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. Set **+ New configuration**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

1. In the **Tenant URL** field, input your RFPIO Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to RFPIO. If the connection fails, ensure your RFPIO account has the required admin permissions and try again.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** in the **Overview** page.

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

	![Screenshot of the Provisioning properties page showing notification and deletion settings.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select users.

1. Review the user attributes that are synchronized from Microsoft Entra ID to RFPIO in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in RFPIO for update operations. Select the **Save** button to commit any changes.

	![Screenshot of RFPIO User Attributes](media/rfpio-provisioning-tutorial/userattributes.png)

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md) article.

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Connector Limitations

* RFPIO doesn't support groups provisioning currently.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
