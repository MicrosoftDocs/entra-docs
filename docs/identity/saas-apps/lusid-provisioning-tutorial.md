---
title: Configure LUSID for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to LUSID.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to LUSID so that I can streamline the user management process and ensure that users have the appropriate access to LUSID.
---

# Configure LUSID for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both LUSID and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [LUSID](https://www.finbourne.com/lusid) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in LUSID.
> * Remove users in LUSID when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and LUSID.
> * Provision groups and group memberships in LUSID.
> * [Single sign-on](lusid-tutorial.md) to LUSID (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A LUSID license for SCIM (contact LUSID support).
* A user account in your LUSID domain with the **lusid-administrator** role

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and LUSID](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-lusid-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure LUSID to support provisioning with Microsoft Entra ID
After generating [an access token](https://support.lusid.com/knowledgebase/article/KA-01654/), make a request to LUSID's [AddScim](https://www.lusid.com/identity/swagger/index.html) endpoint:

```
curl --request PUT 'https://<your-lusid-domain>.lusid.com/identity/api/identityprovider/scim' \
--header 'Authorization: Bearer <your-API-access-token>'
```

The response will include the `baseUrl` (**Tenant URL** in Microsoft Entra ID) and `apiToken` (**Secret Token** in Microsoft Entra ID) to be entered into the LUSID Microsoft Entra app later.

<a name='step-3-add-lusid-from-the-azure-ad-application-gallery'></a>

## Step 3: Add LUSID from the Microsoft Entra application gallery

Add LUSID from the Microsoft Entra application gallery to start managing provisioning to LUSID. If you have previously setup LUSID for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to LUSID 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-lusid-in-azure-ad'></a>

### To configure automatic user provisioning for LUSID in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **LUSID**.

	![Screenshot of the LUSID link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your LUSID Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to LUSID.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to LUSID**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to LUSID in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in LUSID for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the LUSID API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by LUSID|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||&check;
   |emails[type eq "work"].value|String||&check;
   |name.givenName|String||&check;
   |name.familyName|String||&check;
   |externalId|String||&check;

1. If you'd like to synchronize Microsoft Entra groups to LUSID then under the **Mappings** section, select **Synchronize Microsoft Entra groups to LUSID**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to LUSID in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in LUSID for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by LUSID|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |externalId|String||
   |members|Reference||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for LUSID, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to LUSID by choosing the desired values in **Scope** in the **Settings** section.

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
