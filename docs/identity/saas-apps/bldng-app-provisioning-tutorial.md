---
title: Configure BLDNG APP for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to BLDNG APP.

author: jeevansd
manager: pmwongera

ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to BLDNG APP so that I can streamline the user management process and ensure that users have the appropriate access to BLDNG APP.
---

# Configure BLDNG APP for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both BLDNG APP and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [BLDNG APP](https://dashboard.bldng.ai/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in BLDNG.AI 
> * Remove users in BLDNG.AI  when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and BLDNG.AI
> * Provision groups and group memberships in BLDNG.AI
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to BLDNG.AI (recommended).


## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A [BLDNG.AI](https://dashboard.bldng.ai/) agreement.
* An invitation from BLDNG.AI to enable user provisioning and use BLDNG APP

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and BLDNG APP](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-bldng-app-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure BLDNG APP to support provisioning with Microsoft Entra ID

* To configure provisioning of users, user groups and group memberships from Azure you need a BLDNG.AI agreement and tenant.
* To attain an agreement, please contact [sales](mailto:salg@bldng.ai) to get in contact with a sales representative. You aren't able to proceed nor use BLDNG APP if an agreement doesn't exist.
* If you already have an active agreement but need to enable user provisioning only, contact [support](mailto:support@bldng.ai) directly.

When an agreement has been established, you receive an email with detailed instructions on how to set up user provisioning. The email will also include details regarding admin consent (on behalf of your organization) for using BLDNG APP if needed. 

The email will also include Tenant URL and Secret Token for use when configuring automatic user provisioning. 

<a name='step-3-add-bldng-app-from-the-azure-ad-application-gallery'></a>

## Step 3: Add BLDNG APP from the Microsoft Entra application gallery

Add BLDNG APP from the Microsoft Entra application gallery to start managing provisioning to BLDNG APP. If you have previously setup BLDNG APP for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to BLDNG APP 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in BLDNG APP based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-bldng-app-in-azure-ad'></a>

### To configure automatic user provisioning for BLDNG APP in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **BLDNG APP**.

	![The BLDNG APP link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, input your BLDNG APP **Tenant URL** and **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to BLDNG APP. If the connection fails , ensure your BLDNG APP account has Admin permissions and try again.

	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to BLDNG APP**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to BLDNG APP in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in BLDNG APP for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the BLDNG APP API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

> [!NOTE]
> It's important to note that if you change the mapping of **externalId**, the users in your tenant isn't able to log in using BLDNG APP.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean||
   |displayName|String||
   |emails[type eq "work"].value|String||
   |name.givenName|String||
   |name.familyName|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |externalId|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
   

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to BLDNG APP**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to BLDNG APP in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in BLDNG APP for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |members|Reference||
      |externalId|String||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for BLDNG APP, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to BLDNG APP by choosing the desired values in **Scope** in the **Settings** section.

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
