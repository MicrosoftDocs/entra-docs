---
title: Configure Cerby for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Cerby.

author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Cerby so that I can streamline the user management process and ensure that users have the appropriate access to Cerby.
---

# Configure Cerby for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to do in both Cerby and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Cerby](https://app.cerby.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Cerby
> * Remove users in Cerby when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Cerby
> * Provision groups and group memberships in Cerby.
> * [Single sign-on](cerby-tutorial.md) to Cerby (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Cerby with the Workspace Owner role.
* The Cerby SAML2-based integration must be set up. Follow the instructions in the [How to Configure the Cerby App Gallery SAML App with Your Microsoft Entra tenant](https://help.cerby.com/en/articles/5457563-how-to-configure-the-cerby-app-gallery-saml-app-with-your-azure-ad-tenant) article to set up the integration.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Cerby](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-cerby-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Cerby to support provisioning with Microsoft Entra ID
Cerby has enabled by default the provisioning support for Microsoft Entra ID. You must only retrieve the SCIM API authentication token by completing the following steps:

1. Log in to your corresponding [Cerby workspace](https://app.cerby.com/).
1. Select the **Hi there < user >!** button located at the bottom of the left side navigation menu. A drop-down menu is displayed.
1. Select the **Workspace Configuration** option related to your account from the drop-down menu. The **Workspace Configuration** page is displayed.
1. Activate the **IDP Settings** tab.
1. Select the **View Token** button located in the **Directory Sync** section of the **IDP Settings** tab. A pop-up window is displayed waiting to confirm your identity, and a push notification is sent to your Cerby mobile application.
**IMPORTANT:** To confirm your identity, you must have installed and logged in to the Cerby mobile application to receive push notifications.
1. Select the **It's me!** button in the **Confirmation Request** screen of your Cerby mobile application to confirm your identity. The pop-up window in your Cerby workspace is closed, and the **Show Token** pop-up window is displayed.
1. Select the **Copy** button to copy the SCIM token to the clipboard.

	>[!TIP]
	>Keep the **Show Token** pop-up window open to copy the token at any time. You need the token to configure provisioning with Microsoft Entra ID.

<a name='step-3-add-cerby-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Cerby from the Microsoft Entra application gallery

Add Cerby from the Microsoft Entra application gallery to start managing provisioning to Cerby. If you have previously setup Cerby for SSO, you can use the same application. However it's recommended you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Cerby 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in Cerby based on user and group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-cerby-in-azure-ad'></a>

### To configure automatic user provisioning for Cerby in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Cerby**.

	![The Cerby link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, input `https://api.cerby.com/v1/scim/v2` as your Cerby Tenant URL and the SCIM API authentication token that you have previously retrieved. 

1. Select **Test Connection** to ensure Microsoft Entra ID can connect to Cerby. If the connection fails, ensure your Cerby account has Admin permissions and try again.

	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to Cerby**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Cerby in the **Attribute Mappings** section. The attributes selected as **Matching** properties are used to match the user accounts in Cerby for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Cerby API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Cerby|
   |---|---|---|---|
   |userName|String|&check;|&check;|
   |emails[type eq "work"].value|String|&check;|&check;|
   |active|Boolean||&check;|
   |name.givenName|String||&check;|
   |name.familyName|String||&check;|
   |externalId|String|||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Cerby**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Cerby in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Cerby for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Cerby|
   |---|---|---|---|
   |displayName|String|&check;|&check;|
   |externalId|String|||
   |members|Reference|||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Cerby, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and groups that you would like to provision to Cerby by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to complete than next cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Troubleshooting Tips
If you need to regenerate the SCIM API authentication token, complete the following steps:

1. Send an email with your request to [Cerby Support Team](mailto:support@cerby.com). The Cerby team regenerates the SCIM API authentication token.
1. Receive the response email from Cerby to confirm that the token was successfully regenerated.
1. Complete the instructions from the [How to Retrieve the SCIM API Authentication Token from Cerby](https://help.cerby.com/en/articles/5638472-how-to-configure-automatic-user-provisioning-for-azure-ad) article to retrieve the new token.

	>[!NOTE]
	>The Cerby team is currently developing a self-service solution for regenerating the SCIM API authentication token. To regenerate the token, the Cerby team members must validate their identity.

## Change log

* 01/02/2024 - Added support for **Group Provisioning**.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)