---
title: Configure GitHub Enterprise Server for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to GitHub Enterprise Server.


author: jeevansd
manager: mwongerapk

ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to GitHub Enterprise Server so that I can streamline the user management process and ensure that users have the appropriate access to GitHub Enterprise Server.
---

# Configure GitHub Enterprise Server for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both GitHub Enterprise Server and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and/or groups to GitHub Enterprise Server using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in GitHub Enterprise Server
> * Remove users in GitHub Enterprise Server when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and GitHub Enterprise Server
> * Provision groups and group memberships in GitHub Enterprise Server
> * Single sign-on to [GitHub Enterprise Server](./github-enterprise-server-tutorial.md) (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* GitHub Enterprise Server, fully [initialized](https://docs.github.com/enterprise-server/admin/overview/about-github-enterprise-server) and configured for login with [SAML SSO](https://docs.github.com/enterprise-server/admin/managing-iam/using-saml-for-enterprise-iam/configuring-saml-single-sign-on-for-your-enterprise) through your Microsoft Entra tenant.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and GitHub Enterprise Server](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-github-server-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure GitHub Enterprise Server to support provisioning with Microsoft Entra ID

Learn how to enable provisioning for GitHub Enterprise Server [here](https://docs.github.com/enterprise-server/admin/managing-iam/provisioning-user-accounts-with-scim/configuring-scim-provisioning-for-users).

<a name='step-3-add-github-server-from-the-azure-ad-application-gallery'></a>

## Step 3: Add GitHub Enterprise Server from the Microsoft Entra application gallery

Add GitHub Enterprise Server from the Microsoft Entra application gallery to start managing provisioning to GitHub Enterprise Server. If you have previously setup GitHub Enterprise Server for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to GitHub Enterprise Server 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-github-server-in-azure-ad'></a>

### To configure automatic user provisioning for GitHub Enterprise Server in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

    ![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **GitHub Enterprise Server**.

    ![The GitHub Enterprise Server link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

    ![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

    ![Provisioning tab automatic](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your GitHub Enterprise Server **Tenant URL** and **Secret Token**. The value of the fields are in the following format:

    * **Tenant URL**: `https://<your-github-server-domain>/api/v3/scim`
    * **Secret Token**: [The Personal Access Token (PAT)](https://docs.github.com/enterprise-server/admin/managing-iam/provisioning-user-accounts-with-scim/configuring-scim-provisioning-for-users#2-create-a-personal-access-token) you created for [the provisioning account](https://docs.github.com/enterprise-server/admin/managing-iam/provisioning-user-accounts-with-scim/configuring-scim-provisioning-for-users#1-create-a-built-in-setup-user) in your GitHub Enterprise Server instance.

    Select **Test Connection** to ensure Microsoft Entra ID can connect to GitHub Enterprise Server. If the connection fails, ensure your GitHub Enterprise Server account has Admin permissions and try again.

    ![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

    ![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Provision Microsoft Entra ID Users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to GitHub Enterprise Server in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in GitHub Enterprise Server for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the GitHub Enterprise Server API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

    |Attribute|Type|
    |---|---|
    |`userName`|String|
    |`externalId`|String|
    |`emails[type eq "work"].value`|String|
    |`active`|Boolean|
    |`name.givenName`|String|
    |`name.familyName`|String|
    |n`ame.formatted`|String|
    |`displayName`|String|

1. Under the **Mappings** section, select **Provision Microsoft Entra ID Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to GitHub Enterprise Server in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in GitHub Enterprise Server for update operations. Select the **Save** button to commit any changes.

    |Attribute|Type|
    |---|---|
    |`displayName`|String|
    |`externalId`|String|
    |`members`|Reference|

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for GitHub Enterprise Server, change the **Provisioning Status** to **On** in the **Settings** section.

    ![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to GitHub Enterprise Server by choosing the desired values in **Scope** in the **Settings** section.

    ![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

    ![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and/or groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Change log

* 02/18/2021 - Added support for Groups provisioning.
* 08/19/2025 - Updated links and mentions of "GitHub AE" to "GitHub Enterprise Server" to reflect the current product name.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)