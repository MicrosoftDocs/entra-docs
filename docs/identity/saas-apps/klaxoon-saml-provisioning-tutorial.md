---
title: Configure Klaxoon SAML for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Klaxoon SAML.


author: adimitui
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Klaxoon SAML so that I can streamline the user management process and ensure that users have the appropriate access to Klaxoon SAML.
---

# Configure Klaxoon SAML for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Klaxoon SAML and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Klaxoon SAML](https://www.klaxoon.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Klaxoon.
> * Disable users in Klaxoon when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Klaxoon.
> * Provide licenses to users in Klaxoon based on Microsoft Entra groups.
> * [Single sign-on](klaxoon-saml-tutorial.md) to Klaxoon using SAML (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* An existing [Klaxoon contract](https://klaxoon.com/solutions-enterprise-excellence).

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Klaxoon SAML](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-klaxoon-saml-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Klaxoon SAML to support provisioning with Microsoft Entra ID

* Contact [Klaxoon](https://klaxoon.com/) to receive a unique **Tenant URL** and a **Secret Token**.

<a name='step-3-add-klaxoon-saml-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Klaxoon SAML from the Microsoft Entra application gallery

Add Klaxoon SAML from the Microsoft Entra application gallery to start managing provisioning to Klaxoon. If you have previously setup Klaxoon SAML for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Klaxoon 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Klaxoon SAML based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-klaxoon-saml-in-azure-ad'></a>

### To configure automatic user provisioning for Klaxoon SAML in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Klaxoon SAML**.

	![The Klaxoon SAML link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Klaxoon Tenant URL and Secret Token provided by Klaxoon. Select **Test Connection** to ensure Microsoft Entra ID can connect to Klaxoon. If the connection fails, please contact Klaxoon to check your account setup.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Klaxoon SAML**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Klaxoon in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Klaxoon for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Klaxoon API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Klaxoon|
   |---|---|---|---|
   |userName|String|&check;|&check;|
   |emails[type eq "work"].value|String|&check;|&check;|
   |externalId|String||&check;|
   |name.givenName|String||&check;|
   |name.familyName|String||&check;|
   |active|Boolean||&check;|

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Klaxoon SAML**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Klaxoon in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Klaxoon for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|Required by Klaxoon|
      |---|---|---|---|
      |displayName|String|&check;|&check;
      |externalId|String||&check;
      |members|Reference||
      |urn:ietf:params:scim:schemas:extension:klaxoon:2.0:Group:license|String||


1. Define **urn:ietf:params:scim:schemas:extension:klaxoon:2.0:Group:license** attribute to provide Klaxoon PRO licenses to users linked to a group.

      |Value|Group with Klaxoon PRO license|
      |---|---|
      |true|&check;|
      |false|No|
      |not specified (default value)|&check;|

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Klaxoon SAML, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Klaxoon SAML by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
