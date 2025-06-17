---
title: Configure Meta Work Accounts for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Meta Work Accounts.

author: nguhiu
manager: mwongerapk
ms.author: thomasakelo
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Facebook Work Accounts so that I can streamline the user management process and ensure that users have the appropriate access to Facebook Work Accounts.
---

# Configure Meta Work Accounts for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Meta Work Accounts and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Meta Work Accounts](https://work.meta.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Capabilities supported

> [!div class="checklist"]
> * Create users in Meta Work Accounts
> * Remove users in Meta Work Accounts when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Meta Work Accounts
> * Single sign-on to Meta Work Accounts (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md)
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* An admin account in Work Accounts with the permission to change company settings and configure integrations.

## Step 1: Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Meta Work Accounts](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-add-meta-work-accounts-from-the-azure-ad-application-gallery'></a>

## Step 2: Add Meta Work Accounts from the Microsoft Entra application gallery

Add Meta Work Accounts from the Microsoft Entra application gallery to start managing provisioning to Meta Work Accounts. If you have previously setup Meta Work Accounts for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 3: Define who is in scope for provisioning

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 4: Configure automatic user provisioning to Meta Work Accounts

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-meta-work-accounts-in-azure-ad'></a>

### To configure automatic user provisioning for Meta Work Accounts in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

1. In the applications list, select **Meta Work Accounts**.

1. Select the **Provisioning** tab.

1. Set the **Provisioning Mode** to **Automatic**.

1. Under the **Admin Credentials** section, select **Authorize**. You be redirected to **Meta Work Accounts**'s authorization page. Input your Meta Work Accounts username and select the **Continue** button. Select **Test Connection** to ensure Microsoft Entra ID can connect to Meta Work Accounts. If the connection fails, ensure your Meta Work Accounts account has Admin permissions and try again.

    :::image type="content" source="media/facebook-work-accounts-provisioning-tutorial/azure-connect.png" alt-text="Screenshot shows the Meta Work Accounts authorization page.":::

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Meta Work Accounts**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Meta Work Accounts in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Meta Work Accounts for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Meta Work Accounts API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

    |Attribute|Type|Supported for filtering|
    |---|---|---|
    |userName|String|&check;|
    |externalId|String||
    |active|Boolean||
    |title|String||
    |emails[type eq "work"].value|String||
    |preferredLanguage|String||
    |name.givenName|String||
    |name.familyName|String||
    |name.formatted|String||
    |addresses[type eq "work"].formatted|String||
    |addresses[type eq "work"].streetAddress|String||
    |addresses[type eq "work"].locality|String||
    |addresses[type eq "work"].region|String||
    |addresses[type eq "work"].postalCode|String||
    |addresses[type eq "work"].country|String||
    |phoneNumbers[type eq "work"].value|String||
    |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String||
    |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Meta Work Accounts, change the **Provisioning Status** to **On** in the **Settings** section.

1. Define the users and/or groups that you would like to provision to Meta Work Accounts by choosing the desired values in **Scope** in the **Settings** section.

   ![Screenshot shows the Scope dropdown in the Settings section.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
