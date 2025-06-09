---
title: Configure Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service.

author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service so that I can streamline the user management process and ensure that users have the appropriate access to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service.
---

# Configure Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service](https://www.paloaltonetworks.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service.
> * Remove users in Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service.
> * Provision groups and group memberships in Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service.
> * [Single sign-on](palo-alto-networks-cloud-identity-engine---cloud-authentication-service-tutorial.md) to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A user account in Palo Alto Networks with Admin rights.


## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-palo-alto-networks-cloud-identity-engine---cloud-authentication-service-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service to support provisioning with Microsoft Entra ID

Contact [Palo Alto Networks Customer Support](https://support.paloaltonetworks.com/support) to obtain the **SCIM Url** and corresponding **Token**.

<a name='step-3-add-palo-alto-networks-cloud-identity-engine---cloud-authentication-service-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service from the Microsoft Entra application gallery

Add Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service from the Microsoft Entra application gallery to start managing provisioning to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service. If you have previously setup Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-palo-alto-networks-cloud-identity-engine---cloud-authentication-service-in-azure-ad'></a>

### To configure automatic user provisioning for Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service**.

	![Screenshot of the Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service. If the connection fails, ensure your Palo Alto Networks account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

    |Attribute|Type|Supported for filtering|Required by Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service|
    |---|---|---|---|
    |userName|String|&check;|&check;
    |active|Boolean||&check; 
    |displayName|String||&check;
    |title|String|| 
    |emails[type eq "work"].value|String||
    |emails[type eq "other"].value|String||
    |preferredLanguage|String||    
    |name.givenName|String||&check;
    |name.familyName|String||&check;
    |name.formatted|String||&check;
    |name.honorificSuffix|String||
    |name.honorificPrefix|String||
    |addresses[type eq "work"].formatted|String||
    |addresses[type eq "work"].streetAddress|String||
    |addresses[type eq "work"].locality|String||
    |addresses[type eq "work"].region|String||
    |addresses[type eq "work"].postalCode|String||
    |addresses[type eq "work"].country|String||
    |addresses[type eq "other"].formatted|String||
    |addresses[type eq "other"].streetAddress|String||
    |addresses[type eq "other"].locality|String||
    |addresses[type eq "other"].region|String||
    |addresses[type eq "other"].postalCode|String||
    |addresses[type eq "other"].country|String||
    |phoneNumbers[type eq "work"].value|String||
    |phoneNumbers[type eq "mobile"].value|String||
    |phoneNumbers[type eq "fax"].value|String||
    |externalId|String||
    |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String||
    |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
    |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|String||

    > [!NOTE]
    > **Schema Discovery** is enabled on this app. Hence you might see more attributes in the application than mentioned in the table above.
          
1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service for update operations. Select the **Save** button to commit any changes.

    |Attribute|Type|Supported for filtering|Required by Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service|
    |---|---|---|---|
    |displayName|String|&check;|&check;
    |members|Reference||    

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Palo Alto Networks Cloud Identity Engine - Cloud Authentication Service by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
