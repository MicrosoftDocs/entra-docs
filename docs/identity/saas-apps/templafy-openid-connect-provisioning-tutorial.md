---
title: Configure Templafy OpenID Connect for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Templafy OpenID Connect.
author: jeevansd
ms.topic: how-to
ms.date: 04/06/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Templafy OpenID Connect so that I can streamline the user management process and ensure that users have the appropriate access to Templafy OpenID Connect.
---

# Configure Templafy OpenID Connect for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Templafy OpenID Connect and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Templafy OpenID Connect.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A Templafy tenant](https://www.templafy.com/pricing/).
* A user account in Templafy with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Templafy OpenID Connect](~/identity/app-provisioning/customize-application-attributes.md). 

## Step 1: Assign users to Templafy OpenID Connect

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Templafy OpenID Connect. Once decided, you can assign these users and/or groups to Templafy OpenID Connect by following the instructions [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).

### Important tips for assigning users to Templafy OpenID Connect

* It's recommended that a single Microsoft Entra user is assigned to Templafy OpenID Connect to test the automatic user provisioning configuration. More users and/or groups may be assigned later.

* When assigning a user to Templafy OpenID Connect, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

<a name='step-2-configure-templafy-openid-connect-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Templafy OpenID Connect to support provisioning with Microsoft Entra ID

Before configuring Templafy OpenID Connect for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on Templafy OpenID Connect.

1. Sign in to your Templafy Admin Console. Select **Administration**.

	![Screenshot of Templafy Admin Console.](media/templafy-openid-connect-provisioning-tutorial/templafy-admin.png)

1. Select **Authentication Method**.

	![Screenshot of the Templafy administration section with the Authentication method option called out.](media/templafy-openid-connect-provisioning-tutorial/templafy-auth.png)

1. Copy the **SCIM Api-key** value. This value is entered in the **Secret Token** field in the Provisioning tab of your Templafy OpenID Connect application.

	![A screenshot of the S C I M A P I key.](media/templafy-openid-connect-provisioning-tutorial/templafy-token.png)

## Step 3: Add Templafy OpenID Connect from the gallery

To configure Templafy OpenID Connect for automatic user provisioning with Microsoft Entra ID, you need to add Templafy OpenID Connect from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Templafy OpenID Connect from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Templafy OpenID Connect**, select **Templafy OpenID Connect** in the search box.
1. Select **Templafy OpenID Connect** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

	![Screenshot of Templafy OpenID Connect in the results list.](common/search-new-app.png)

## Step 4: Configure automatic user provisioning to Templafy OpenID Connect 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Templafy OpenID Connect based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable OpenID connect-based single sign-on for Templafy, following the instructions provided in the [Templafy Single sign-on  article](templafy-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-templafy-openid-connect-in-azure-ad'></a>

### Configure automatic user provisioning for Templafy OpenID Connect in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Templafy OpenID Connect**.

	![Screenshot of Templafy OpenID Connect link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of New configuration.](common/application-provisioning.png)

1. Under the **Admin Credentials** section, enter `https://scim.templafy.com/scim` in **Tenant URL**. Enter the **SCIM API-key** value retrieved earlier in **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Templafy. If the connection fails, ensure your Templafy account has Admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Templafy OpenID Connect in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Templafy OpenID Connect for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean|
   |displayName|String|
   |title|String|
   |preferredLanguage|String|
   |name.givenName|String|
   |name.familyName|String|
   |phoneNumbers[type eq "work"].value|String|
   |phoneNumbers[type eq "mobile"].value|String|
   |phoneNumbers[type eq "fax"].value|String|
   |externalId|String|
   |addresses[type eq "work"].locality|String|
   |addresses[type eq "work"].postalCode|String|
   |addresses[type eq "work"].region|String|
   |addresses[type eq "work"].streetAddress|String|
   |addresses[type eq "work"].country|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String|

      > [!NOTE]
      > Schema Discovery feature is enabled for this application.
      
1. Select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Templafy OpenID Connect in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Templafy OpenID Connect for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |members|Reference|
      |externalId|String|      

      > [!NOTE]
      > Schema Discovery feature is enabled for this application.

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Change log

* 05/04/2023 - Added support for **Schema Discovery**.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
