---
title: Configure Talentech for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Talentech.
author: jeevansd
manager: pmwongera
ms.topic: how-to
ms.date: 04/14/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Talentech so that I can streamline the user management process and ensure that users have the appropriate access to Talentech.
---

# Configure Talentech for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Talentech and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Talentech](https://www.talentech.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 

## Capabilities supported
> [!div class="checklist"]
> * Create users in Talentech
> * Remove users in Talentech when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Talentech
> * Provision groups and group memberships in Talentech
> * Single sign-on to Talentech (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A user account in Talentech.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Talentech](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-talentech-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Talentech to support provisioning with Microsoft Entra ID

1. Log in [Talentech](https://www.talentech.com).

1. Navigate to **Integrations** in the left panel and select **Add new integration**.

	![Screenshot of the Talentech integrations settings page.](media/talentech-provisioning-tutorial/integrations.png)

1. Enter a **Name** for the integration and select **Add**.

1. Navigate to the integration you created and select **Create api-access token**.

	![Screenshot of the Talentech API access token page.](media/talentech-provisioning-tutorial/token.png)

1. An access token is generated. This value is entered in the **Secret Token** field in the Provisioning tab of your Talentech application.

	![Screenshot of the generated Talentech bearer token.](media/talentech-provisioning-tutorial/bearer.png)

1. Reach out to Talentech support to generate a Tenant URL. This value is entered in the **Tenant URL** field in the Provisioning tab of your Talentech application.

<a name='step-3-add-talentech-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Talentech from the Microsoft Entra application gallery

Add Talentech from the Microsoft Entra application gallery to start managing provisioning to Talentech. If you have previously setup Talentech for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Talentech 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in TestApp based on user and group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-talentech-in-azure-ad'></a>

### Configure automatic user provisioning for Talentech in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Talentech**.

	![Screenshot of Talentech link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of the New configuration option on the Provisioning page.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Talentech Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Talentech. If the connection fails, ensure your Talentech account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

    ![Screenshot of the Provisioning properties page.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Talentech in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Talentech for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Talentech API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |externalId|String|
   |active|Boolean|
   |name.givenName|String|
   |name.familyName|String|

1. Select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Talentech in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Talentech for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |externalId|String|
      |members|Reference|

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
