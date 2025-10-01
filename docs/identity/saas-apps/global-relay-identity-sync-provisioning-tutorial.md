---
title: Configure Global Relay Identity Sync for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Global Relay Identity Sync.


author: jeevansd
manager: pmwongera

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Global Relay Identity Sync so that I can streamline the user management process and ensure that users have the appropriate access to Global Relay Identity Sync.
---

# Configure Global Relay Identity Sync for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Global Relay Identity Sync and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to Global Relay Identity Sync using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Global Relay Identity Sync
> * Remove users in Global Relay Identity Sync when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Global Relay Identity Sync
> * Provision groups and group memberships in Global Relay Identity Sync


> [!NOTE]
> Global Relay Identity Sync provisioning connector utilizes a SCIM authorization method that's no longer supported due to security concerns. Efforts are underway with Global Relay to switch to a more secure authorization method.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Global Relay Identity Sync](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-global-relay-identity-sync-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Global Relay Identity Sync to support provisioning with Microsoft Entra ID

Contact your Global Relay Identity Sync representative to receive the Tenant URL. This value is entered in the **Tenant URL** field in the Provisioning tab of your Global Relay Identity Sync application.

<a name='step-3-add-global-relay-identity-sync-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Global Relay Identity Sync from the Microsoft Entra application gallery

Add Global Relay Identity Sync from the Microsoft Entra application gallery to start managing provisioning to Global Relay Identity Sync. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Global Relay Identity Sync 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Global Relay Identity Sync app based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-global-relay-identity-sync-in-azure-ad'></a>

### To configure automatic user provisioning for Global Relay Identity Sync in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Global Relay Identity Sync**.

	![The Global Relay Identity Sync link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Global Relay Identity Sync **Tenant url**. Select **Test Connection** to ensure Microsoft Entra ID can connect to Global Relay Identity Sync. If the connection fails, ensure your Global Relay Identity Sync account has Admin permissions and contact your Global Relay representative to resolve the issue.

	![Authorization button](media/global-relay-identity-sync-provisioning-tutorial/authorization.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Global Relay Identity Sync**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Global Relay Identity Sync in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Global Relay Identity Sync for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Global Relay Identity Sync API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |active|Boolean|
   |displayName|String|
   |title|String|
   |preferredLanguage|String|
   |name.givenName|String|
   |name.familyName|String|
   |name.formatted|String|
   |addresses[type eq "work"].formatted|String|
   |addresses[type eq "work"].streetAddress|String|
   |emails[type eq "work"].value|String|
   |addresses[type eq "work"].locality|String|
   |addresses[type eq "work"].region|String|
   |addresses[type eq "work"].postalCode|String|
   |addresses[type eq "work"].country|String|
   |addresses[type eq "other"].formatted|String|
   |phoneNumbers[type eq "work"].value|String|
   |phoneNumbers[type eq "mobile"].value|String|
   |phoneNumbers[type eq "fax"].value|String|
   |externalId|String|
   |name.honorificPrefix|String|
   |name.honorificSuffix|String|
   |nickName|String|
   |userType|String|
   |locale|String|
   |timezone|String|
   |emails[type eq "home"].value|String|
   |emails[type eq "other"].value|String|
   |phoneNumbers[type eq "home"].value|String|
   |phoneNumbers[type eq "other"].value|String|
   |phoneNumbers[type eq "pager"].value|String|
   |addresses[type eq "home"].streetAddress|String|
   |addresses[type eq "home"].locality|String|
   |addresses[type eq "home"].region|String|
   |addresses[type eq "home"].postalCode|String|
   |addresses[type eq "home"].country|String|
   |addresses[type eq "home"].formatted|String|
   |addresses[type eq "other"].streetAddress|String|
   |addresses[type eq "other"].locality|String|
   |addresses[type eq "other"].region|String|
   |addresses[type eq "other"].postalCode|String|
   |addresses[type eq "other"].country|String|
   |roles[primary eq "True"].display|String|
   |roles[primary eq "True"].type|String|
   |roles[primary eq "True"].value|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:costCenter|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:proxyAddresses|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute1|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute2|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute3|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute4|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute5|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute6|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute7|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute8|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute9|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute10|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute11|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute12|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute13|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute14|String|
   |urn:ietf:params:scim:schemas:extension:GlobalRelay:2.0:User:extensionAttribute15|String|



10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Global Relay Identity Sync**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Global Relay Identity Sync in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Global Relay Identity Sync for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|
      |---|---|
      |displayName|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Global Relay Identity Sync, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Global Relay Identity Sync by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
