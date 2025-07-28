---
title: Configure Jellyfish for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Jellyfish.

author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 04/15/2024
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Jellyfish so that I can streamline the user management process and ensure that users have the appropriate access to Jellyfish.
---

# Configure Jellyfish for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Jellyfish and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users to [Jellyfish](https://cogitogroup.net/jellyfish/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Jellyfish.
> * Remove users in Jellyfish when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Jellyfish.
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Jellyfish (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in Jellyfish with Admin permissions.

## Step 1: Plan your provisioning deployment
* Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
* Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
* Determine what data to [map between Microsoft Entra ID and Jellyfish](~/identity/app-provisioning/customize-application-attributes.md).

## Step 2: Generate Credential for provisioning

1. Login to the **Jellyfish** portal and navigate to **Key Management > API Keys**.
2. Select **Generate New**

   ![Screenshot of API Key management page.](./media/jellyfish-provisioning-tutorial/api-key-page.png)

3. Search for the admin account created as part of the prerequisites and select **Create**. (Optionally) set an expiry, noting that the credential *must* be updated once expired.

   ![Screenshot of Creating New API Key.](./media/jellyfish-provisioning-tutorial/create-new-api-key.png)

4. The API key is downloaded, ensure that this key is kept safe as this will grant access to the user account it was generated for. It's recommended to delete the downloaded API key once user provisioning is configured.

## Step 3: Add Jellyfish from the Microsoft Entra application gallery

Add Jellyfish from the Microsoft Entra application gallery to start managing provisioning to Jellyfish. If you have previously setup Jellyfish for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Jellyfish 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in Jellyfish based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-Jellyfish-in-azure-ad'></a>

### To configure automatic user provisioning for Jellyfish in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Jellyfish**.

	![Screenshot of the Jellyfish link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, enter the **Tenant Url** which is in the form of **https://\<organisation\>.securesme.com**. This is the same address used to log in to the Jellyfish portal. For the *Secret Token* input the API key generated earlier in step 2. Then select Authorize, make sure that you enter your Jellyfish account's Admin credentials. Select **Test Connection** to ensure Microsoft Entra ID can connect to Jellyfish. If the connection fails, ensure your Jellyfish account has Admin permissions and try again.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Jellyfish**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Jellyfish in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Jellyfish for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Jellyfish API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|Required by Jellyfish|
      |---|---|---|---|
      |userName|String|&check;|&check;|
      |active|Boolean||&check;|
      |title|String|||
      |emails[type eq "work"].value|String|||
      |name.givenName|String|||
      |name.familyName|String|||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Jellyfish, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to Jellyfish by choosing the desired values in **Scope** in the **Settings** section.

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