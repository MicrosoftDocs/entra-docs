---
title: Configure O'Reilly learning platform for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to O'Reilly learning platform.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to O'Reilly learning platform so that I can streamline the user management process and ensure that users have the appropriate access to O'Reilly learning platform.
---

# Configure O'Reilly learning platform for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both O'Reilly learning platform and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [O'Reilly learning platform](https://www.oreilly.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 

## Supported capabilities

> [!div class="checklist"]
> * Create users in O'Reilly learning platform.
> * Remove users in O'Reilly learning platform when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and O'Reilly learning platform.
> * [Single sign-on](oreilly-learning-platform-tutorial.md) to O'Reilly learning platform (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in O'Reilly learning platform with Admin permissions.
* An O'Reilly learning platform single sign-on (SSO) enabled subscription.

## Step 1: Plan your provisioning deployment
* Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
* Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
* Determine what data to [map between Microsoft Entra ID and O'Reilly learning platform](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-oreilly-learning-platform-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure O'Reilly learning platform to support provisioning with Microsoft Entra ID

Before you begin to configure the O'Reilly learning platform to support provisioning with Microsoft Entra ID, you’ll need to generate a SCIM API token within the O’Reilly Admin Console.

1. Navigate to [O’Reilly Admin Console](https://learning.oreilly.com/) by logging in to your O’Reilly account. 
1. Once you’ve logged in, select **Admin** in the top navigation and select **Integrations**.
1. Scroll down to the **API tokens** section. Under API tokens, select **Create token** and select the **SCIM API**. Then give your token a name and expiration date, and select Continue. You’ll receive your API key in a pop-up message prompting you to store a copy of it in a secure place. Once you’ve saved a copy of your key, select the checkbox and Continue.
1. You use the O’Reilly SCIM API token in Step 5.

<a name='step-3-add-oreilly-learning-platform-from-the-azure-ad-application-gallery'></a>

## Step 3: Add O'Reilly learning platform from the Microsoft Entra application gallery

Add O'Reilly learning platform from the Microsoft Entra application gallery to start managing provisioning to O'Reilly learning platform. If you have previously [set up O'Reilly learning platform for SSO](oreilly-learning-platform-tutorial.md), you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who is in scope for provisioning

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to O'Reilly learning platform

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in O’Reilly learning platform based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-oreilly-learning-platform-in-azure-ad'></a>

### To configure automatic user provisioning for O'Reilly learning platform in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **O'Reilly learning platform**.

	![Screenshot of the O'Reilly learning platform link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your O'Reilly learning platform Tenant URL, which is `https://api.oreilly.com/api/scim/v2`, and Secret Token, which you generated in Step 2. Select **Test Connection** to ensure Microsoft Entra ID can connect to O'Reilly learning platform. If the connection fails, double-check that your token is correct or [contact the O’Reilly platform integration team](mailto:platform-integration@oreilly.com) for help.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to O'Reilly learning platform**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to O'Reilly learning platform in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in O'Reilly learning platform for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the O'Reilly learning platform API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by O'Reilly learning platform|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||
   |emails[type eq "work"].value|String||&check;
   |name.givenName|String||&check;
   |name.familyName|String||&check;
   |externalId|String||&check;

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for O'Reilly learning platform, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to O'Reilly learning platform by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
