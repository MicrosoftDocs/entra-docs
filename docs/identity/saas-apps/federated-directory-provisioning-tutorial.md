---
title: Configure Federated Directory for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Federated Directory.
author: jeevansd
ms.topic: how-to
ms.date: 04/07/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Federated Directory so that I can streamline the user management process and ensure that users have the appropriate access to Federated Directory.
---

# Configure Federated Directory for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Federated Directory and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Federated Directory.

> [!NOTE]
>  This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A Federated Directory](https://www.federated.directory/pricing).
* A user account in Federated Directory with Admin permissions.

## Assign Users to Federated Directory
Microsoft Entra ID uses a concept called assignments to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Federated Directory. Once decided, you can assign these users and/or groups to Federated Directory by following the instructions here:

 * [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) 
 
 ## Important tips for assigning users to Federated Directory
 * It's recommended that a single Microsoft Entra user is assigned to Federated Directory to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Federated Directory, you must select any valid application-specific role (if available) in the assignment dialog. Users with the Default Access role are excluded from provisioning.
	
 ## Set up Federated Directory for provisioning

Before configuring Federated Directory for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on Federated Directory.

1. Sign in to your [Federated Directory Admin Console](https://federated.directory/of)

	:::image type="content" source="media/federated-directory-provisioning-tutorial/companyname.png" alt-text="Screenshot of the Federated Directory admin console showing a field for entering a company name. Sign-in buttons are also visible." border="false":::

1. Navigate to **Directories > User directories** and select your tenant. 

	:::image type="content" source="media/federated-directory-provisioning-tutorial/ad-user-directories.png" alt-text="Screenshot of the Federated Directory admin console, with Directories and Federated Directory Microsoft Entra ID Test highlighted." border="false":::

1. 	To generate a permanent bearer token, navigate to **Directory Keys > Create New Key.** 

	:::image type="content" source="media/federated-directory-provisioning-tutorial/federated01.png" alt-text="Screenshot of the Directory keys page of the Federated Directory admin console. The Create new key button is highlighted." border="false":::

1. Create a directory key. 

	:::image type="content" source="media/federated-directory-provisioning-tutorial/federated02.png" alt-text="Screenshot of the Create directory key page of the Federated Directory admin console, with Name and Description fields and a Create key button." border="false":::
	

1. Copy the **Access Token** value. This value is entered in the **Secret Token** field in the Provisioning tab of your Federated Directory application. 

	:::image type="content" source="media/federated-directory-provisioning-tutorial/federated03.png" alt-text="Screenshot of a page in the Federated Directory admin console. An access token placeholder and a key name, description, and issuer are visible." border="false":::
	
## Add Federated Directory from the gallery

To configure Federated Directory for automatic user provisioning with Microsoft Entra ID, you need to add Federated Directory from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Federated Directory from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Federated Directory**, select **Federated Directory** in the results panel.

	![Screenshot of Federated Directory in the results list](common/search-new-app.png)

1. Navigate to the **URL** highlighted below in a separate browser. 

	:::image type="content" source="media/federated-directory-provisioning-tutorial/loginpage1.png" alt-text="Screenshot of a page in the Azure portal that displays information on Federated Directory. The U R L value is highlighted." border="false":::

1. Select **LOG IN**.

	:::image type="content" source="media/federated-directory-provisioning-tutorial/federated04.png" alt-text="Screenshot of the main menu on the Federated Directory site. The Login button is highlighted." border="false":::

1.  As Federated Directory is an OpenIDConnect app, choose to log in to Federated Directory using your Microsoft work account.
	
	:::image type="content" source="media/federated-directory-provisioning-tutorial/loginpage3.png" alt-text="Screenshot of the S C I M A D test page on the Federated Directory site. Log in with your Microsoft account is highlighted." border="false":::
 
1. After a successful authentication, accept the consent prompt for the consent page. The application will then be automatically added to your tenant and you be redirected to your Federated Directory account.

## Configuring automatic user provisioning to Federated Directory 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Federated Directory based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-federated-directory-in-azure-ad'></a>

### To configure automatic user provisioning for Federated Directory in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Federated Directory**.

	![Screenshot of the Federated Directory link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Federated Directory Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Federated Directory. If the connection fails, ensure your Federated Directory account has the required admin permissions and try again.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.
	
1. Review the user attributes that are synchronized from Microsoft Entra ID to Federated Directory in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Federated Directory for update operations. Select the **Save** button to commit any changes.

	:::image type="content" source="media/federated-directory-provisioning-tutorial/user-attributes.png" alt-text="Screenshot of the Attribute Mappings page. A table lists Microsoft Entra ID and Federated Directory attributes and the matching status." border="false":::
	

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization. 

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md)
## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
