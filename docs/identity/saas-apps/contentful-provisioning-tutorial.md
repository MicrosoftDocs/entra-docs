---
title: Configure Contentful for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Contentful.


author: jeevansd
manager: pmwongera

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Contentful so that I can streamline the user management process and ensure that users have the appropriate access to Contentful.
---

# Configure Contentful for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to complete in Contentful and in Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to [Contentful](https://www.contentful.com/) by using the Microsoft Entra provisioning service. For important details about what this service does and how it works, and for frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 

## Capabilities supported

> [!div class="checklist"]
> * Create users in Contentful
> * Remove users in Contentful when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Contentful
> * Provision groups and group memberships in Contentful
> * [Single sign-on](contentful-tutorial.md) to Contentful (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Contentful organization account that has a subscription that supports System for Cross-domain Identity Management (SCIM) provisioning. If you have questions about your organization's subscription, contact [Contentful Support](mailto:support@contentful.com).
 
## Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Contentful](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='configure-contentful-to-support-provisioning-with-azure-ad'></a>

## Configure Contentful to support provisioning with Microsoft Entra ID

1. In Contentful, create a **Service User** account. All provisioning permissions for Azure are provided through this account. We recommend that you choose **Owner** as the organization role for this account.

2. Sign in to Contentful as the **Service User**.

3. In the left menu, select **Organization settings** > **Access Tools** > **User provisioning**.

   ![Screenshot of the Organization settings menu in Contentful, with User provisioning highlighted under Access Tools.](media/contentful-provisioning-tutorial/access.png)

4. Copy and save the **SCIM URL**. You'll enter this value in the Azure portal, on the **Provisioning** tab of your Contentful application.

5. Select **Generate personal access token**.

    ![Screenshot showing the SCIM URL to generate a personal access token.](media/contentful-provisioning-tutorial/generate.png)

6. In the modal window, enter a name for your personal access token, and then select **Generate**.

7. The SCIM URL and the secret token are generated. Copy and save these values. You'll enter these values on the **Provisioning** tab of your Contentful application.

    ![Screenshot of the Personal access token pane, with C F P A T and the token placeholder name highlighted.](media/contentful-provisioning-tutorial/token.png)


If you have questions while you configure provisioning in the Contentful admin console, contact [Contentful Support](mailto:support@contentful.com).

<a name='add-contentful-from-the-azure-ad-application-gallery'></a>

## Add Contentful from the Microsoft Entra application gallery

To manage provisioning to Contentful, add Contentful from the Microsoft Entra application gallery. If you have previously set up Contentful for single sign-on, you can use the same application. However, we recommend that you create a separate app to initially test the integration. Learn how to [add an application in the gallery](~/identity/enterprise-apps/add-application-portal.md). 

## Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Configure automatic user provisioning to Contentful 

This section guides you through the steps to set up the Microsoft Entra provisioning service to create, update, and disable users and groups in a test app based on user or group assignments in Microsoft Entra ID.

<a name='configure-automatic-user-provisioning-for-contentful-in-azure-ad'></a>

### Configure automatic user provisioning for Contentful in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

   ![Screenshot that shows the Enterprise applications menu in the Azure portal, with All applications highlighted.](common/enterprise-applications.png)

1. In the applications list, select **Contentful**.

   ![Screenshot that shows the first 20 results returned in the Applications list.](common/all-applications.png)

3. Select the **Provisioning** tab.

   ![Screenshot of the Provisioning tab highlighted in the Manage section of the left menu.](common/provisioning.png)

4. Set **Provisioning Mode** to **Automatic**.

   ![Screenshot that shows the Provisioning Mode options, with Automatic highlighted.](common/provisioning-automatic.png)

5. In the **Admin Credentials** section, enter your Contentful tenant URL and secret token. To ensure that Microsoft Entra ID can connect to Contentful, select **Test Connection**. If the connection fails, be sure that your Contentful account has Admin permissions, and then try again.

   ![Screenshot that shows the Tenant U R L and Secret Token text boxes, with the Test Connection button highlighted.](common/provisioning-testconnection-tenanturltoken.png)

6. In **Notification Email**, enter the email address of a person or group who should receive the provisioning error notifications, and then select the **Send an email notification when a failure occurs** check box.

   ![Screenshot that shows the Notification Email text box.](common/provisioning-notification-email.png)

7. Select **Save**.

8. In the **Mappings** section, select **Synchronize Microsoft Entra users to Contentful**.

9. In the **Attribute-Mapping** section, review the user attributes that are synced from Microsoft Entra ID to Contentful. The attributes selected as **Matching** properties are used to match the user accounts in Contentful for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you must ensure that the Contentful API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |name.givenName|String||
   |name.familyName|String||

10. In the **Mappings** section, select **Synchronize Microsoft Entra groups to Contentful**.

11. In the **Attribute-Mapping** section, review the group attributes that are synced from Microsoft Entra ID to Contentful. The attributes selected as **Matching** properties are used to match the groups in Contentful for update operations. Select the **Save** button to commit any changes.

    |Attribute|Type|Supported for filtering|
    |---|---|---|
    |displayName|String|&check;|
    |members|Reference||

12. To set up scoping filters, complete the steps that are described in the [scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Contentful, in the **Settings** section, for **Provisioning Status**, select **On**.

    ![Screenshot that shows Provisioning Status On and Off toggle.](common/provisioning-toggle-on.png)

14. To define the users or groups that you want to provision to Contentful, in the **Settings** section, for **Scope**, select the relevant option.

    ![Screenshot that shows options you can select in the Scope pane.](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

    ![Screenshot that shows the Save button and the Cancel button.](common/provisioning-configuration-save.png)

This operation starts the initial sync cycle of all users and groups defined in **Scope** under **Settings**. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
* [Manage user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
