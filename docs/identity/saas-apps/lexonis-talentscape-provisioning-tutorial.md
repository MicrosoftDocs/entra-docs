---
title: Configure Lexonis TalentScape for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Lexonis TalentScape.
author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/09/2024
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Lexonis TalentScape so that I can streamline the user management process and ensure that users have the appropriate access to Lexonis TalentScape.
---

# Configure Lexonis TalentScape for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Lexonis TalentScape and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to [Lexonis TalentScape](https://www.lexonis.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Lexonis TalentScape.
> * Remove users in Lexonis TalentScape when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Lexonis TalentScape.
> * [Single sign-on](lexonis-talentscape-tutorial.md) to Lexonis TalentScape (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Lexonis TalentScape with Admin permissions.

## Step 1: Plan your provisioning deployment

* Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
* Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
* Determine what data to [map between Microsoft Entra ID and Lexonis TalentScape](~/identity/app-provisioning/customize-application-attributes.md).

## Step 2: Configure Lexonis TalentScape to support provisioning with Microsoft Entra ID

Contact Lexonis TalentScape support to configure Lexonis TalentScape to support provisioning with Microsoft Entra ID.

## Step 3: Add Lexonis TalentScape from the Microsoft Entra application gallery

Add Lexonis TalentScape from the Microsoft Entra application gallery to start managing provisioning to Lexonis TalentScape. If you have previously setup Lexonis TalentScape for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Lexonis TalentScape 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in Lexonis TalentScape based on user assignments in Microsoft Entra ID.

### To configure automatic user provisioning for Lexonis TalentScape in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Lexonis TalentScape**.

	![Screenshot of the Lexonis TalentScape link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Lexonis TalentScape Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Lexonis TalentScape. If the connection fails, ensure your Lexonis TalentScape account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Lexonis TalentScape**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Lexonis TalentScape in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Lexonis TalentScape for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Lexonis TalentScape API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Lexonis TalentScape|
   |---------|----|-----------------------|----------------|
   |userName|String|&check;|&check;
   |active|Boolean||
   |displayName|String||
   |title|String||
   |emails[type eq "work"].value|String||
   |preferredLanguage|String||
   |name.givenName|String||
   |name.familyName|String||
   |addresses[type eq "work"].formatted|String||
   |addresses[type eq "work"].streetAddress|String||
   |addresses[type eq "work"].locality|String||
   |addresses[type eq "work"].region|String||
   |addresses[type eq "work"].postalCode|String||
   |addresses[type eq "work"].country|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |phoneNumbers[type eq "fax"].value|String||
   |externalId|String||&check; 
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|String||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Lexonis TalentScape**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Lexonis TalentScape in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Lexonis TalentScape for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Lexonis TalentScape|
   |---------|----|-----------------------|----------------|
   |displayName|String|&check;|&check;
   |externalId|String||
   |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Lexonis TalentScape, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to Lexonis TalentScape by choosing the desired values in **Scope** in the **Settings** section.

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