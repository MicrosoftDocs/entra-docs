---
title: Configure Gtmhub for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Gtmhub.
author: jeevansd
manager: pmwongera
ms.topic: how-to
ms.date: 04/07/2026
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Gtmhub so that I can streamline the user management process and ensure that users have the appropriate access to Gtmhub.
---

# Configure Gtmhub for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Gtmhub and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Gtmhub](https://www.gtmhub.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 

>[!NOTE]
>Currently, when automatic user provisioning is configured, Microsoft Entra-only automatically de-provisions users and groups to Gtmhub and map users to their respective teams using the Microsoft Entra provisioning service.But in 2021 once SSO is enabled with Gtmhub,users are automatically provisioned when they log in through SSO and is assigned to their respective team.


## Capabilities Supported
> [!div class="checklist"]
> * Remove users in Gtmhub when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Gtmhub.
> * Map users into their teams automatically and align them.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* An Enterprise Gtmhub account.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Gtmhub](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-gtmhub-to-support-team-mapping-and-user-de-provisioning-with-azure-ad'></a>

## Step 2: Configure Gtmhub to support team mapping and user de-provisioning with Microsoft Entra ID

In order to connect your provisioning application to your Gtmhub account you need to issue a SCIM token and compile the tenant URL.

### To issue a new SCIM token:

1. Sign in to your **Gtmhub account**. Navigate to **Settings > Configuration > API Tokens**.

    ![API Tokens tab](media/gtmhub-provisioning-tutorial/api-tokens.png)
1. Select **Issue Token** and select **SCIM**. Enter a name for the token and select the **Generate API Token** button.

    ![Generate Tokens tab](media/gtmhub-provisioning-tutorial/generate-token.png)
1. Once the token is generated you can copy and use it in your Microsoft Entra provisioning application.

    ![Copy Token](media/gtmhub-provisioning-tutorial/token.png)

### To compile the tenant URL:

1. Your tenant URL has to be in the following format:

    `https://app.gtmhub.com/api/v1/scim/azure/{account_id}`

1. If your Gtmhub account is located in the US data center you also have to add the data center to the URL:
    
     `https://app.us.gtmhub.com/api/v1/scim/azure/{account_id}`

1. To get the account ID go to **Settings** then select the **API Tokens** tab and copy the account ID:
    ![Account ID](media/gtmhub-provisioning-tutorial/account-id.png)

<a name='step-3-add-gtmhub-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Gtmhub from the Microsoft Entra application gallery

Add Gtmhub from the Microsoft Entra application gallery to start managing provisioning to Gtmhub. If you have previously setup Gtmhub for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Gtmhub 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-gtmhub-in-azure-ad'></a>

### To configure automatic user provisioning for Gtmhub in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Gtmhub**.

	![The Gtmhub link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Gtmhub Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Gtmhub. If the connection fails, ensure your Gtmhub account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Gtmhub in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Gtmhub for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Gtmhub API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |externalId|String|&check;|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference||

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
