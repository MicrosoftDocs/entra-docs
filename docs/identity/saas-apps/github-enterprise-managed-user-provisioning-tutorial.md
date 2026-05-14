---
title: Configure GitHub Enterprise Managed User for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to GitHub Enterprise Managed User.

author: jeevansd
manager: pmwongera

ms.topic: how-to
ms.date: 03/09/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to GitHub Enterprise Managed User so that I can streamline the user management process and ensure that users have the appropriate access to GitHub Enterprise Managed User.
---

# Configure GitHub Enterprise Managed User for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both GitHub Enterprise Managed User and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to GitHub Enterprise Managed User using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

> [!NOTE]
> [GitHub Enterprise Managed User (EMU)](https://docs.github.com/enterprise-cloud@latest/admin/authentication/managing-your-enterprise-users-with-your-identity-provider/about-enterprise-managed-users) is a different type of [GitHub Enterprise Account](https://docs.github.com/enterprise-cloud@latest/admin/overview/about-enterprise-accounts). If you haven't specifically requested EMU instance, you have a standard GitHub Enterprise Account. In that case, please refer to [the documentation](./github-provisioning-tutorial.md) to configure user provisioning in your non-EMU organisation. User provisioning isn't supported for [standard GitHub Enterprise Accounts](https://docs.github.com/enterprise-cloud@latest/admin/overview/about-enterprise-accounts), but is supported for organisations under GitHub Enterprise Managed User (EMU).

## Capabilities Supported
> [!div class="checklist"]
> * Create users in GitHub Enterprise Managed User
> * Remove users in GitHub Enterprise Managed User when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and GitHub Enterprise Managed User
> * Provision groups and group memberships in GitHub Enterprise Managed User
> * Single sign-on to GitHub Enterprise Managed User (recommended)


## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md)
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* Enterprise Managed Users enabled GitHub Enterprise and configured to log in with SAML SSO through your Microsoft Entra tenant.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and GitHub Enterprise Managed User](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-github-enterprise-managed-user-to-support-provisioning-with-azure-ad'></a>

## Step 2: Prepare to configure provisioning with Microsoft Entra ID

1. Identify your Tenant URL. This is the value that you enter in the Tenant URL field in the Provisioning tab of your GitHub Enterprise Managed User application.

   * For an enterprise on GitHub.com, the Tenant URL is `https://api.github.com/scim/v2/enterprises/{enterprise}`.
   * For an enterprise on GHE.com, the Tenant URL is `https://api.{subdomain}.ghe.com/scim/v2/enterprises/{subdomain}`

2. Ensure you have created a token with the **scim:enterprise** scope for your enterprise's setup user. This value is entered in the Secret Token field in the Provisioning tab of your GitHub Enterprise Managed User application. See [Getting started with Enterprise Managed Users](https://docs.github.com/en/enterprise-cloud@latest/admin/managing-iam/understanding-iam-for-enterprises/getting-started-with-enterprise-managed-users#create-a-personal-access-token) on GitHub Docs.

<a name='step-3-add-github-enterprise-managed-user-from-the-azure-ad-application-gallery'></a>

## Step 3: Add GitHub Enterprise Managed User from the Microsoft Entra application gallery

Add GitHub Enterprise Managed User from the Microsoft Entra application gallery to start managing provisioning to GitHub Enterprise Managed User. If you have previously setup GitHub Enterprise Managed User for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who is in scope for provisioning

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to GitHub Enterprise Managed User

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-github-enterprise-managed-user-in-azure-ad'></a>

### To configure automatic user provisioning for GitHub Enterprise Managed User in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

    ![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **GitHub Enterprise Managed User**.

    ![The GitHub Enterprise Managed User link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

    ![Provisioning tab](common/provisioning.png)

1. Set **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your GitHub Enterprise Managed User Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to GitHub Enterprise Managed User. If the connection fails, ensure your GitHub Enterprise Managed User account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.	

1. Select **Properties** in the **Overview** page. 

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to GitHub Enterprise Managed User in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in GitHub Enterprise Managed User for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the GitHub Enterprise Managed User API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported For Filtering|
   |---|---|---|
   |externalId|String|&check;|
   |userName|String||
   |active|Boolean||
   |roles|String||
   |displayName|String||
   |name.givenName|String||
   |name.familyName|String||
   |name.formatted|String||
   |emails[type eq "work"].value|String||
   |emails[type eq "home"].value|String||
   |emails[type eq "other"].value|String||

10. Select **Groups**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to GitHub Enterprise Managed User in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in GitHub Enterprise Managed User for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported For Filtering|
      |---|---|---|
      |externalId|String|&check;|
      |displayName|String||
      |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
