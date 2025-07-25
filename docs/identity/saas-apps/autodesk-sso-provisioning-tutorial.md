---
title: Configure Autodesk SSO for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Autodesk SSO.

author: adimitui
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Autodesk SSO so that I can streamline the user management process and ensure that users have the appropriate access to Autodesk SSO.
---

# Configure Autodesk SSO for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to do in both Autodesk SSO and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Autodesk SSO](https://autodesk.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Autodesk SSO.
> * Remove users in Autodesk SSO when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Autodesk SSO.
> * Provision groups and group memberships in Autodesk SSO.
> * [Single sign-on](autodesk-sso-tutorial.md) to Autodesk SSO (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A user account with either Primary admin or SSO admin role to access [Autodesk management portal](https://manage.autodesk.com/).

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Autodesk SSO](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-autodesk-sso-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Autodesk SSO to support provisioning with Microsoft Entra ID
1. Login to [Autodesk management portal](https://manage.autodesk.com/).
1. From the left navigation menu, navigate to **User Management > By Group**. Select the required team from the drop-down list and select the team settings gear icon.

	[![Navigation](media/autodesk-sso-provisioning-tutorial/step2-1-navigation.png)](media/autodesk-sso-provisioning-tutorial/step2-1-navigation.png#lightbox)
	
2.  Select the Set up directory sync button and select Microsoft Entra SCIM as the directory environment. Select Next to access the Azure admin credentials. If you set up Directory Sync before, select the Access Credential instead.

	![Set Up Directory Sync](media/autodesk-sso-provisioning-tutorial/step2-2-set-up-directory-sync.png)

3. Copy and save the Base URL and API token. These values are entered in the Tenant URL * field and Secret Token * field respectively in the Provisioning tab of your Autodesk application.

	![Get Credentials](media/autodesk-sso-provisioning-tutorial/step2-3-get-credentials.png)

<a name='step-3-add-autodesk-sso-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Autodesk SSO from the Microsoft Entra application gallery

Add Autodesk SSO from the Microsoft Entra application gallery to start managing provisioning to Autodesk SSO. If you have previously setup Autodesk SSO for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Autodesk SSO 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in Autodesk SSO based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-autodesk-sso-in-azure-ad'></a>

### To configure automatic user provisioning for Autodesk SSO in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Autodesk SSO**.

	![The Autodesk SSO link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Autodesk SSO Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Autodesk SSO. If the connection fails, ensure your Autodesk SSO account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to Autodesk SSO**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Autodesk SSO in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Autodesk SSO for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Autodesk SSO API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Autodesk SSO|
   |---|---|---|---|
   |userName|String|&check;|&check;|   
   |active|Boolean||&check;|
   |name.givenName|String||&check;|
   |name.familyName|String||&check;|
   |urn:ietf:params:scim:schemas:extension:AdskUserExt:2.0:User:objectGUID|String||&check;|


1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Autodesk SSO**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Autodesk SSO in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Autodesk SSO for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|Required by Autodesk SSO|
      |---|---|---|---|
      |displayName|String|&check;|&check;|
      |members|Reference|||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Autodesk SSO, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and groups that you would like to provision to Autodesk SSO by choosing the appropriate values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to execute than next cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
