---
title: Configure Wrike for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and deprovision user accounts to Wrike.
author: jeevansd
ms.topic: how-to
ms.date: 04/05/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Wrike so that I can streamline the user management process and ensure that users have the appropriate access to Wrike.
---

# Configure Wrike for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps you perform in Wrike and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and deprovision users or groups to Wrike.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to software-as-a-service (SaaS) applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Wrike tenant](https://www.wrike.com/price/)
* A user account in Wrike with admin permissions

## Step 1:  Assign users to Wrike
Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users or groups that were assigned to an application in Microsoft Entra ID are synchronized.

Before you configure and enable automatic user provisioning, decide which users or groups in Microsoft Entra ID need access to Wrike. Then assign these users or groups to Wrike by following the instructions here: [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Wrike

* We recommend that you assign a single Microsoft Entra user to Wrike to test the automatic user provisioning configuration. More users or groups can be assigned later.

* When you assign a user to Wrike, you must select any valid application-specific role (if available) in the assignment dialog box. Users with the Default Access role are excluded from provisioning.

## Step 2: Set up Wrike for provisioning

Before you configure Wrike for automatic user provisioning with Microsoft Entra ID, you need to enable System for Cross-domain Identity Management (SCIM) provisioning on Wrike.

1. Sign in to your [Wrike admin console](https://www.Wrike.com/login/). Go to your Tenant ID. Select **Apps & Integrations**.

	![Screenshot of Apps & Integrations.](media/Wrike-provisioning-tutorial/admin.png)

1.  Go to **Microsoft Entra ID** and select it.

1.  Select SCIM. Copy the **Base URL**.

	![Screenshot of Base URL.](media/Wrike-provisioning-tutorial/Wrike-tenanturl.png)

1. Select **API** > **Azure SCIM**.

	![Screenshot of Azure SCIM.](media/Wrike-provisioning-tutorial/Wrike-add-scim.png)

1.  A pop-up opens. Enter the same password that you created earlier to create an account.

	![Screenshot of Wrike Create token.](media/Wrike-provisioning-tutorial/password.png)

1. 	Copy the **Secret Token**, and paste it in Microsoft Entra ID. Select **Save** to finish the provisioning setup on Wrike.

	![Screenshot of Permanent access token.](media/Wrike-provisioning-tutorial/Wrike-create-token.png)


## Step 3: Add Wrike from the gallery

Before you configure Wrike for automatic user provisioning with Microsoft Entra ID, add Wrike from the Microsoft Entra application gallery to your list of managed SaaS applications.

To add Wrike from the Microsoft Entra application gallery, follow these steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Entra ID** > **Enterprise apps** > **New application**.Wrike**, select **Wrike** in the results panel, and then select **Add** to add the application.

	![Screenshot of Wrike in the results list.](common/search-new-app.png)

## Step 4: Configure automatic user provisioning to Wrike 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users or groups in Wrike based on user or group assignments in Microsoft Entra ID.

> [!TIP]
> To enable SAML-based single sign-on for Wrike, follow the instructions in the [Wrike single sign-on  article](wrike-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, although these two features complement each other.

<a name='configure-automatic-user-provisioning-for-wrike-in-azure-ad'></a>

### Configure automatic user provisioning for Wrike in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Entra ID** > **Enterprise apps** > **Wrike**.

	![Screenshot of the Wrike link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. Under the Admin Credentials section, input the **Base URL** and **Permanent access token** values retrieved earlier in **Tenant URL** and **Secret Token**, respectively. Select **Test Connection** to ensure that Microsoft Entra ID can connect to Wrike. If the connection fails, make sure that your Wrike account has admin permissions and try again.

	![Screenshot of Tenant URL + token.](common/provisioning-testconnection-tenanturltoken.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Wrike in the **Attribute Mappings** section. The attributes selected as **Matching** properties are used to match the user accounts in Wrike for update operations. Select **Save** to commit any changes.

	![Screenshot of Wrike user attributes.](media/Wrike-provisioning-tutorial/Wrike-user-attributes.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Manage user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
