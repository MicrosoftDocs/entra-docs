---
title: Configure Proxyclick for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Proxyclick.
author: jeevansd
ms.topic: how-to
ms.date: 03/20/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Proxyclick so that I can streamline the user management process and ensure that users have the appropriate access to Proxyclick.
---

# Configure Proxyclick for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Proxyclick and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Proxyclick.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Proxyclick tenant](https://www.proxyclick.com/pricing)
* A user account in Proxyclick with Admin permissions.

## Add Proxyclick from the gallery

Before configuring Proxyclick for automatic user provisioning with Microsoft Entra ID, you need to add Proxyclick from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Proxyclick from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Proxyclick**, select **Proxyclick** in the search box.
1. Select **Proxyclick** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

	![Diagram that shows Proxyclick in the results list.](common/search-new-app.png)

## Assigning users to Proxyclick

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Proxyclick. Once decided, you can assign these users and/or groups to Proxyclick by following the instructions here:

* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Proxyclick

* It's recommended that a single Microsoft Entra user is assigned to Proxyclick to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Proxyclick, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Configure automatic user provisioning to Proxyclick 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Proxyclick based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Proxyclick, following the instructions provided in the [Proxyclick single sign-on  article](proxyclick-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-proxyclick-in-azure-ad'></a>

### To configure automatic user provisioning for Proxyclick in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Diagram that shows Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Proxyclick**.

	![Diagram that shows the Proxyclick link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. To retrieve the **Tenant URL** and **Secret Token** of your Proxyclick account, follow the steps mentioned later in the document.

1. Sign in to your [Proxyclick Admin Console](https://app.proxyclick.com/login//?destination=%2Fdefault). Navigate to **Settings** > **Integrations** > **Browse Marketplace**.

	![Diagram that shows Proxyclick Settings.](media/proxyclick-provisioning-tutorial/proxyclick09.png)

	![Diagram that shows Proxyclick Integrations.](media/proxyclick-provisioning-tutorial/proxyclick01.png)

	![Diagram that shows Proxyclick Marketplace.](media/proxyclick-provisioning-tutorial/proxyclick02.png)

	Select **Microsoft Entra ID**. Select **Install now**.

	![Diagram that shows Proxyclick Microsoft Entra ID.](media/proxyclick-provisioning-tutorial/proxyclick03.png)

	![Diagram that shows Proxyclick Install.](media/proxyclick-provisioning-tutorial/proxyclick04.png)

	Select **User Provisioning** and select **Start integration**. 

	![Diagram that shows Proxyclick User Provisioning.](media/proxyclick-provisioning-tutorial/proxyclick05.png)

	The appropriate settings configuration UI should now show up under **Settings** > **Integrations**. Select **Settings** under **Microsoft Entra ID (User Provisioning)**.

	![Diagram that shows Proxyclick Create.](media/proxyclick-provisioning-tutorial/proxyclick06.png)

	You can find the **Tenant URL** and **Secret Token** here.

	![Diagram that shows Proxyclick Create Token.](media/proxyclick-provisioning-tutorial/proxyclick07.png)

1. Upon populating the fields shown in Step 5, select **Test Connection** to ensure Microsoft Entra ID can connect to Proxyclick. If the connection fails, ensure your Proxyclick account has Admin permissions and try again.

	![Diagram that shows Token.](common/provisioning-testconnection-tenanturltoken.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Proxyclick in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Proxyclick for update operations. Select the **Save** button to commit any changes.

    ![Diagram that shows Proxyclick User Attributes.](media/proxyclick-provisioning-tutorial/proxyclick-user-attribute.png)

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Connector limitations

* Proxyclick requires **emails** and **userName** to have the same source value. Any updates to either attributes will modify the other value.
* Proxyclick doesn't support provisioning for groups.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
