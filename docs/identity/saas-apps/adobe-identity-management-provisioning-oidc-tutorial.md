---
title: Configure Adobe Identity Management (OIDC) for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Adobe Identity Management (OIDC).

author: twimmers
manager: pmwongera
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: thwimmer

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Adobe Identity Management (OIDC) so that I can streamline the user management process and ensure that users have the appropriate access to Adobe Identity Management (OIDC).

---

# Configure Adobe Identity Management (OIDC) for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Adobe Identity Management (OIDC) and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to Adobe Identity Management (OIDC) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Adobe Identity Management (OIDC)
> * Disable users in Adobe Identity Management (OIDC) when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Adobe Identity Management (OIDC)
> * Provision groups and group memberships in Adobe Identity Management (OIDC)
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Adobe Identity Management (OIDC) (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A federated directory in the [Adobe Admin Console](https://adminconsole.adobe.com/) with verified domains.
* Review the [adobe documentation](https://helpx.adobe.com/enterprise/admin-guide.html/enterprise/using/add-azure-sync.ug.html) on user provisioning 

> [!NOTE]
> If your organization uses the User Sync Tool or a UMAPI integration, you must first pause the integration. Then, add Microsoft Entra automatic provisioning to automate user management. Once Microsoft Entra automatic provisioning is configured and running, you can completely remove the User Sync Tool or UMAPI integration.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Adobe Identity Management (OIDC)](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-adobe-identity-management-oidc-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Adobe Identity Management (OIDC) to support provisioning with Microsoft Entra ID

1. Log in to [Adobe Admin Console](https://adminconsole.adobe.com/). Navigate to **Settings > Directory Details > Sync**. 

1. Select **Add Sync**.

    ![Add](media/adobe-identity-management-provisioning-saml-tutorial/add-sync.png)

1. Select **Sync users from Microsoft Azure** and select **Next**.

    ![Screenshot that shows 'Sync users from Microsoft Entra ID' selected.](media/adobe-identity-management-provisioning-saml-tutorial/sync-users.png)

1. Copy and save the **Tenant URL** and the **Secret token**. These values are entered in the **Tenant URL** and **Secret Token** fields in the Provisioning tab of your Adobe Identity Management (OIDC) application.

    ![Sync](media/adobe-identity-management-provisioning-saml-tutorial/token.png)

<a name='step-3-add-adobe-identity-management-oidc-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Adobe Identity Management (OIDC) from the Microsoft Entra application gallery

Add Adobe Identity Management (OIDC) from the Microsoft Entra application gallery to start managing provisioning to Adobe Identity Management (OIDC). If you have previously setup Adobe Identity Management (OIDC) for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Adobe Identity Management (OIDC) 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-adobe-identity-management-oidc-in-azure-ad'></a>

### To configure automatic user provisioning for Adobe Identity Management (OIDC) in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

    ![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Adobe Identity Management (OIDC)**.

    ![The Adobe Identity Management (OIDC) link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

    ![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

    ![Provisioning tab automatic](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your Adobe Identity Management (OIDC) Tenant URL and Secret Token retrieved earlier from Step 2. Select **Test Connection** to ensure Microsoft Entra ID can connect to Adobe Identity Management (OIDC). If the connection fails, ensure your Adobe Identity Management (OIDC) account has Admin permissions and try again.

    ![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

    ![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Adobe Identity Management (OIDC)**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Adobe Identity Management (OIDC) in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Adobe Identity Management (OIDC) for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Adobe Identity Management (OIDC) API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Adobe Identity Management (OIDC)
   |---|---|---|---|
   |userName|String|&check;|&check;   
   |active|Boolean||
   |emails[type eq "work"].value|String||
   |addresses[type eq "work"].country|String||
   |name.givenName|String||
   |name.familyName|String||
   |urn:ietf:params:scim:schemas:extension:Adobe:2.0:User:emailAliases|String||
   |urn:ietf:params:scim:schemas:extension:Adobe:2.0:User:eduRole|String||

    > [!NOTE]
    > The **eduRole** field accepts values like `Teacher or Student`, anything else is ignored.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Adobe Identity Management (OIDC)**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Adobe Identity Management (OIDC) in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Adobe Identity Management (OIDC) for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|Required by Adobe Identity Management (OIDC)
      |---|---|---|---|
      |displayName|String|&check;|&check;
      |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Adobe Identity Management (OIDC), change the **Provisioning Status** to **On** in the **Settings** section.

    ![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Adobe Identity Management (OIDC) by choosing the desired values in **Scope** in the **Settings** section.

    ![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

    ![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Change log
08/15/2023 - Added support for Schema Discovery.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
