---
title: Configure Soloinsight-CloudGate SSO for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Soloinsight-CloudGate SSO.
author: jeevansd
ms.topic: how-to
ms.date: 03/24/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Soloinsight-CloudGate SSO so that I can streamline the user management process and ensure that users have the appropriate access to Soloinsight-CloudGate SSO.
---

# Configure Soloinsight-CloudGate SSO for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Soloinsight-CloudGate SSO and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Soloinsight-CloudGate SSO.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* [A Soloinsight-CloudGate SSO tenant](https://www.soloinsight.com/)
* A user account in Soloinsight-CloudGate SSO with Admin permissions.

## Step 1: Assigning users to Soloinsight-CloudGate SSO

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Soloinsight-CloudGate SSO. Once decided, you can assign these users and/or groups to Soloinsight-CloudGate SSO by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Step 2: Important tips for assigning users to Soloinsight-CloudGate SSO

* It's recommended that a single Microsoft Entra user is assigned to Soloinsight-CloudGate SSO to test the automatic user provisioning configuration. More users and/or groups may be assigned later.

* When assigning a user to Soloinsight-CloudGate SSO, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Step 3: Set up Soloinsight-CloudGate SSO for provisioning

1. Sign in to your [Soloinsight-CloudGate SSO Admin Console](https://soloinsight.sigateway.com/login). Navigate to **Administration > System Settings**.

	![Soloinsight-CloudGate SSO Admin Console](media/soloinsight-cloudgate-sso-provisioning-tutorial/admin.png)

1.	Navigate to **General**.

	![Soloinsight-CloudGate SSO Add SCIM](media/soloinsight-cloudgate-sso-provisioning-tutorial/config.png)

1.	Scroll down to the end of the page to get the **Tenant URL** and **Secret Token**. Copy the **Secret Token**. This value is entered in the Secret Token field in the Provisioning tab of your Soloinsight-CloudGate SSO application.

	![Soloinsight-CloudGate SSO Create Token](media/soloinsight-cloudgate-sso-provisioning-tutorial/token.png)

## Step 4: Add Soloinsight-CloudGate SSO from the gallery

Before configuring Soloinsight-CloudGate SSO for automatic user provisioning with Microsoft Entra ID, you need to add Soloinsight-CloudGate SSO from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Soloinsight-CloudGate SSO from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Soloinsight-CloudGate SSO**, select **Soloinsight-CloudGate SSO** in the search box.
1. Select **Soloinsight-CloudGate SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Soloinsight-CloudGate SSO in the results list](common/search-new-app.png)

## Step 5: Configuring automatic user provisioning to Soloinsight-CloudGate SSO 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Soloinsight-CloudGate SSO based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Soloinsight-CloudGate SSO, following the instructions provided in the [Soloinsight-CloudGate SSO Single sign-on  article](./soloinsight-cloudgate-sso-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other

<a name='to-configure-automatic-user-provisioning-for-soloinsight-cloudgate-sso-in-azure-ad'></a>

### To configure automatic user provisioning for Soloinsight-CloudGate SSO in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Soloinsight-CloudGate SSO**.

	![The Soloinsight-CloudGate SSO link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Soloinsight-CloudGate Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Soloinsight-CloudGate. If the connection fails, ensure your Soloinsight-CloudGate account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Soloinsight-CloudGate SSO in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Soloinsight-CloudGate SSO for update operations. Select the **Save** button to commit any changes.

	![Soloinsight-CloudGate SSO User Attributes](media/soloinsight-cloudgate-sso-provisioning-tutorial/userattributes.png)

1. Select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Soloinsight-CloudGate SSO in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Soloinsight-CloudGate SSO for update operations. Select the **Save** button to commit any changes.

	![Soloinsight-CloudGate SSO Group Attributes](media/soloinsight-cloudgate-sso-provisioning-tutorial/groupattributes.png)

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6:  Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
