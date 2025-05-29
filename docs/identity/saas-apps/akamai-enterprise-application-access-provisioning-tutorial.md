---
title: Configure Akamai Enterprise Application Access for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Akamai Enterprise Application Access.

author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Akamai Enterprise Application Access so that I can streamline the user management process and ensure that users have the appropriate access to Akamai Enterprise Application Access.

---

# Configure Akamai Enterprise Application Access for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Akamai Enterprise Application Access and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Akamai Enterprise Application Access](https://www.akamai.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Akamai Enterprise Application Access.
> * Remove users in Akamai Enterprise Application Access when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Akamai Enterprise Application Access.
> * Provision groups and group memberships in Akamai Enterprise Application Access
> * [Single sign-on](akamai-tutorial.md) to Akamai Enterprise Application Access (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (like [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications)).
* An administrator account with Akamai [Enterprise Application Access](https://www.akamai.com/products/enterprise-application-access). 


## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Akamai Enterprise Application Access](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-akamai-enterprise-application-access-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Akamai Enterprise Application Access to support provisioning with Microsoft Entra ID

Configure a SCIM directory of type Azure in Akamai Enterprise Center and save the SCIM base URL and the Provisioning key.

1. Sign in to [Akamai Enterprise Center](https://control.akamai.com/apps/zt-ui/#/identity/directories).   

1. In menu, navigate to **Application Access > Identity & Users > Directories**.
1. Select **Add New Directory** (+).
1. Enter a name and description for directory.
1. In **Directory Type** select **SCIM**, and in **SCIM Schema** select **Azure**.
1. Select **Add New Directory**.
1. Open your new directory **Settings** > **General** and copy **SCIM base URL**. Save it for Azure SCIM provisioning in STEP 4.
1. In **Settings** > **General** select **Create Provisioning Key**.
1. Enter a name and description for the key.
1. Copy **Provisioning key** by selecting the copy to clipboard icon. Save it for Azure SCIM provisioning in STEP 5.
1. In **Login preference Attributes** select either **User principal name** (default) or **Email** to choose for a user a way to log in.
1. Select **Save**.  
     The new SCIM directory appears in the directories list in **Identity & Users** > **Directories**.


<a name='step-3-add-akamai-enterprise-application-access-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Akamai Enterprise Application Access from the Microsoft Entra application gallery

Add Akamai Enterprise Application Access from the Microsoft Entra application gallery to start managing provisioning to Akamai Enterprise Application Access. If you have previously setup Akamai Enterprise Application Access for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Akamai Enterprise Application Access 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-akamai-enterprise-application-access-in-azure-ad'></a>

### To configure automatic user provisioning for Akamai Enterprise Application Access in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Akamai Enterprise Application Access**.

	![Screenshot of the Akamai Enterprise Application Access link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Akamai Enterprise Application Access Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Akamai Enterprise Application Access. If the connection fails, ensure your Akamai Enterprise Application Access account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Akamai Enterprise Application Access**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Akamai Enterprise Application Access in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Akamai Enterprise Application Access for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Akamai Enterprise Application Access API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute| Type  |Supported for filtering|Required by Akamai Enterprise Application Access|
   |---|---|---|---|
   |userName| String |&check;|&check;
   |active| Boolean |||
   |displayName| String |||
   |emails[type eq "work"].value| String ||&check;
   |name.givenName| String |||
   |name.familyName| String |||
   |phoneNumbers[type eq "mobile"].value| String|||
   |externalId| String |||


1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Akamai Enterprise Application Access**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Akamai Enterprise Application Access in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Akamai Enterprise Application Access for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Akamai Enterprise Application Access|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |externalId|String|||
   |members|Reference|||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Akamai Enterprise Application Access, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Akamai Enterprise Application Access by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Akamai Enterprise Application Access - Getting Started](https://techdocs.akamai.com/eaa/docs/welcome-guide)
* [Configuring Custom Attributes in EAA](https://techdocs.akamai.com/eaa/docs/scim-provisioning-with-azure#step-7-optional-add-a-custom-attribute-in--and-map-it-to-the-scim-attribute-in-your--scim-directory)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
