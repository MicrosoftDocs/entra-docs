---
title: Configure TheOrgWiki for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to TheOrgWiki.
author: jeevansd
ms.topic: how-to
ms.date: 04/06/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to TheOrgWiki so that I can streamline the user management process and ensure that users have the appropriate access to TheOrgWiki.
---

# Configure TheOrgWiki for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in TheOrgWiki and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to TheOrgWiki.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [An OrgWiki tenant](https://www.theorgwiki.com/welcome/).
* A user account in TheOrgWiki with Admin permissions.

## Step 1: Assign users to TheOrgWiki

Microsoft Entra ID uses a concept called assignments to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to TheOrgWiki. Once decided, you can assign these users and/or groups to TheOrgWiki by following the instructions [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).

### Important tips for assigning users to TheOrgWiki

* It's recommended that a single Microsoft Entra user is assigned to TheOrgWiki to test the automatic user provisioning configuration. More users and/or groups may be assigned later.

* When assigning a user to TheOrgWiki, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Step 2: Set up TheOrgWiki for provisioning

Before configuring TheOrgWiki for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on TheOrgWiki.

1. Sign in to your [TheOrgWiki Admin Console](https://www.theorgwiki.com/login/). Select **Admin Console**.

	![Screenshot of Org Wiki with the user avatar and the Admin Console called out.](media/theorgwiki-provisioning-tutorial/login.png)

2. In Admin Console, Select **Settings tab**. 

	![Screenshot of the The Org Wiki Admin Console with the Settings tab called out.](media/theorgwiki-provisioning-tutorial/settings.png)
	
3. Navigate to **Service Accounts**.

	![Screenshot of the Service Accounts page in the Org Wiki Admin Console.](media/theorgwiki-provisioning-tutorial/serviceaccount.png)

4. Select **+Service Account**. Under **Service Account Type**, select **Token Based**. Select **Save**.

	![Screenshot of the New Service Account dialog box with the Service Account Type, Token Based, and Save options called out.](media/theorgwiki-provisioning-tutorial/auth.png)

5. 	Copy the **Active Tokens**. This value is entered in the Secret Token field in the Provisioning tab of your TheOrgWiki application.
	 
	![Screenshot of the Manage Tokens for S C I M provisioning dialog box.](media/theorgwiki-provisioning-tutorial/token.png)

## Step 3: Add TheOrgWiki from the gallery

To configure TheOrgWiki for automatic user provisioning with Microsoft Entra ID, you need to add TheOrgWiki from the Microsoft Entra application gallery to your list of managed SaaS applications.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **TheOrgWiki**, select **TheOrgWiki** in the results panel. 

	![Screenshot of TheOrgWiki in the results list.](common/search-new-app.png)

5. Select the **Sign-up for TheOrgWiki** button which will redirect you to TheOrgWiki's login page. 

	![Screenshot of The Org Wiki login page with the URL called out.](media/theorgwiki-provisioning-tutorial/image00.png)

6.  In the top right-hand corner, select **Login**.

	![Screenshot of the upper-right corner of the login page with the Log In option called out.](media/theorgwiki-provisioning-tutorial/image02.png)

7. As TheOrgWiki is an OpenIDConnect app, choose to log in to OrgWiki using your Microsoft work account.

	![Screenshot of the The Org Wiki sign in page with the Sign in with Microsoft option called out.](media/theorgwiki-provisioning-tutorial/image03.png)
	
8. After a successful authentication, the application is automatically added to your tenant and you be redirected to your TheOrgWiki account.

	![Screenshot of OrgWiki Add SCIM.](media/theorgwiki-provisioning-tutorial/image04.png)

## Step 4: Configure automatic user provisioning to TheOrgWiki 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TheOrgWiki based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-theorgwiki-in-azure-ad'></a>

### Configure automatic user provisioning for TheOrgWiki in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **TheOrgWiki**.

	![Screenshot of OrgWiki link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of New configuration.](common/application-provisioning.png)

1. Under the **Admin Credentials** section, input `https://<TheOrgWiki Subdomain 		value>.theorgwiki.com/api/v2/scim/v2/` in **Tenant URL**. 

	Example: `https://test1.theorgwiki.com/api/v2/scim/v2/`

	> [!NOTE]
	> The **Subdomain Value** can only be set during the initial sign-up process for TheOrgWiki.
 
1. Input the token value in **Secret Token** field, that you retrieved earlier from TheOrgWiki. Select **Test Connection** to ensure Microsoft Entra ID can connect to TheOrgWiki. If the connection fails, ensure your TheOrgWiki account has Admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to TheOrgWiki in the **Attribute- Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in TheOrgWiki for update operations. Select the **Save** button to commit any changes.

	![Screenshot of TheOrgWiki User Attributes.](media/theorgwiki-provisioning-tutorial/userattribute.png).

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md).
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

[Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md).
