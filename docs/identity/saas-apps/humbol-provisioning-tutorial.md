---
title: Configure Humbol for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Humbol.

author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Humbol so that I can streamline the user management process and ensure that users have the appropriate access to Humbol.
---

# Configure Humbol for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Humbol and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [Humbol](https://www.humbol.app/en/product/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Humbol.
> * Remove users in Humbol when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Humbol.
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Humbol (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* Active contract with Humbol including SCIM API usage with Humbol Inc.
* A user account in Humbol with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Humbol](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-humbol-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Humbol to support provisioning with Microsoft Entra ID
Contact Humbol support to configure Humbol to support provisioning with Microsoft Entra ID.

1. As Humbol Admin login to your [Humbol](https://my.humbol.app/login) organization.
1. Go to organization's API [settings page](https://my.humbol.app/settings#apis).
   1. On this page you can find the organization SCIM API url. Copy it.
   1. Create SCIM API token and copy the value. 
   > [!NOTE]
   > The token value isn't saved anywhere on the Humbol service, so if you lose it, you should create a new one and remove old one.

<a name='step-3-add-humbol-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Humbol from the Microsoft Entra application gallery

Add Humbol from the Microsoft Entra application gallery to start managing provisioning to Humbol. If you have previously setup Humbol for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Humbol 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in TestApp based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-humbol-in-azure-ad'></a>

### To configure automatic user provisioning for Humbol in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Humbol**.

	![Screenshot of the Humbol link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Humbol Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Humbol. If the connection fails, ensure your Humbol account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Humbol**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Humbol in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Humbol for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Humbol API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Humbol|
   |---|---|---|---|
   |userName|String|&check;|&check;|
   |active|Boolean||&check;|
   |title|String|||
   |emails[type eq "work"].value|String||&check;|
   |preferredLanguage|String|||
   |name.givenName|String||&check;|
   |name.familyName|String||&check;|
   |addresses[type eq "work"].locality|String|||
   |addresses[type eq "work"].region|String|||
   |addresses[type eq "work"].country|String|||
   |roles[primary eq "True"].value|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|String|||

   > [!NOTE]
   > * If you include `roles[primary eq "True"].value` every user must have precisely one role. 
   > * Another option is to remove the role attribute mapping and manage Humbol user roles inside the Humbol application.
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Humbol, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to Humbol by choosing the desired values in **Scope** in the **Settings** section.

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
