---
title: Configure IDEO for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to IDEO.

author: jeevansd
ms.topic: how-to
ms.date: 04/07/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Ideo so that I can streamline the user management process and ensure that users have the appropriate access to Ideo.
---

# Configure IDEO for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in IDEO and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to IDEO. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Capabilities supported
> [!div class="checklist"]
> * Create users in IDEO
> * Remove users in IDEO when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and IDEO
> * Provision groups and group memberships in IDEO
> * Single sign-on to IDEO (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md).
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (like [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications)).
* [A IDEO tenant](https://www.saasworthy.com/product/shape-space/pricing)
* A user account on IDEO | Shape with Admin permissions.


## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and IDEO](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-ideo-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure IDEO to support provisioning with Microsoft Entra ID

Before configuring IDEO for automatic user provisioning with Microsoft Entra ID, you need to retrieve some provisioning information from IDEO.

* For **Secret Token** contact IDEO support team at productsupport@ideo.com. This value is entered in the **Secret Token** field in the Provisioning tab of your IDEO application. 

<a name='step-3-add-ideo-from-the-azure-ad-application-gallery'></a>

## Step 3: Add IDEO from the Microsoft Entra application gallery

Add IDEO from the Microsoft Entra application gallery to start managing provisioning to IDEO. If you have previously setup IDEO for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to IDEO 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in IDEO based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-ideo-in-azure-ad'></a>

### To configure automatic user provisioning for IDEO in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **IDEO**.

	![The IDEO link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your IDEO Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to IDEO. If the connection fails, ensure your IDEO account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to IDEO in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in IDEO for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the IDEO API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |emails[type eq "work"].value|String|
   |active|Boolean|
   |name.givenName|String|
   |name.familyName|String|
   
1. Review the group attributes that are synchronized from Microsoft Entra ID to ideo in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in IDEO for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|
      |---|---|
      |displayName|String|
      |members|Reference|

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Change log

* 06/15/2020 - Added support to use PATCH operations for Groups instead of PUT.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
