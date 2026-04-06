---
title: Configure Workgrid for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Workgrid.
author: jeevansd
ms.topic: how-to
ms.date: 04/02/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Workgrid so that I can streamline the user management process and ensure that users have the appropriate access to Workgrid.
---

# Configure Workgrid for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Workgrid  and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Workgrid.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A Workgrid tenant](https://www.workgrid.com/)
* A user account in Workgrid  with Admin permissions.

## Step 1: Assign users to Workgrid 

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Workgrid. Once decided, you can assign these users and/or groups to Workgrid  by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Workgrid 

* It's recommended that a single Microsoft Entra user is assigned to Workgrid  to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Workgrid, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Step 2: Set up Workgrid for provisioning

Before configuring Workgrid  for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on Workgrid.

1. Log in into Workgrid. Navigate to **Users > User Provisioning**.

	![Screenshot of the Workgrid U I with the Users and User Provisioning options called out.](media/Workgrid-provisioning-tutorial/user.png)

2. Under **Account Management API**, select **Create Credentials**.

	![Screenshot of the Account Management A P I section with the Create Credentials option called out.](media/Workgrid-provisioning-tutorial/scim.png)

3. Copy the **SCIM Endpoint** and **Access Token** values. These is entered in the **Tenant URL** and **Secret Token** field in the Provisioning tab of your Workgrid application.

	![Screenshot of the Account Management A P I section with S C I M Endpoint and Access Token called out.](media/Workgrid-provisioning-tutorial/token.png)


## Step 3: Add Workgrid  from the gallery

To configure Workgrid  for automatic user provisioning with Microsoft Entra ID, you need to add Workgrid  from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Workgrid  from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Workgrid**, select **Workgrid** in the search box.
1. Select **Workgrid** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Workgrid  in the results list](common/search-new-app.png)

## Step 4: Configure automatic user provisioning to Workgrid  

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Workgrid  based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Workgrid , following the instructions provided in the [Workgrid  Single sign-on  article](Workgrid-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other

<a name='to-configure-automatic-user-provisioning-for-workgrid--in-azure-ad'></a>

### To configure automatic user provisioning for Workgrid  in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Workgrid**.

	![The Workgrid  link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Workgrid Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Workgrid. If the connection fails, ensure your Workgrid account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Workgrid  in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Workgrid  for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Workgrid|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||
   |displayName|String||
   |title|String||
   |emails[type eq "work"].value|String||
   |preferredLanguage|String||
   |name.givenName|String||
   |name.familyName|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |phoneNumbers[type eq "fax"].value|String||
   |externalId|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|String||
   |addresses[type eq "work"].locality|String||
   |addresses[type eq "work"].postalCode|String||
   |addresses[type eq "work"].formatted|String||
   |addresses[type eq "work"].region|String||
   |addresses[type eq "work"].streetAddress|String||

1. Select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Workgrid  in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Workgrid  for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Workgrid
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |externalId|String||&check;
   |members|Reference||

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
