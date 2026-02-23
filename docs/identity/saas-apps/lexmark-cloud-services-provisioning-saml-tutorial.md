---
title: Configure Lexmark Cloud Services (SAML) for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Lexmark Cloud Services (SAML).

author: nguhiu
manager: pmwongera
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Lexmark Cloud Services (SAML) so that I can streamline the user management process and ensure that users have the appropriate access to Lexmark Cloud Services (SAML).

---

# Configure Lexmark Cloud Services (SAML) for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Lexmark Cloud Services (SAML) and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to Lexmark Cloud Services (SAML) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Capabilities supported
> [!div class="checklist"]
> * Create users in Lexmark Cloud Services (SAML)
> * Disable users in Lexmark Cloud Services (SAML) when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Lexmark Cloud Services (SAML) [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Lexmark Cloud Services (SAML) (recommended).

> [!NOTE]
> Lexmark Cloud Services (SAML) application currently only supports user provisioning. Group provisioning isn't supported and is planned for a future release.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A SAML federated organization in Lexmark Cloud Services with Organization Administrator role.
* Review the [lexmark documentation](https://support.lexmark.com/en_us/manuals-guides/online/Lexmark-Cloud-Platform/overview-v54808648.html?toc=2.5.0) on user provisioning.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Adobe Identity Management (SAML)](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-lexmark-cloud-services-saml-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Lexmark Cloud Services (SAML) to support provisioning with Microsoft Entra ID

1. Log in to Lexmark Cloud Services.

2. From the Dashboard card or the navigation waffle menu, select **Account Management**.

    ![Screenshot shows Account Management.](media/lexmark-cloud-services-provisioning-saml-tutorial/account-management.png "Account Management")

3. If necessary, select your organization, and then select **Next**.

    ![Screenshot shows Organization Menu.](media/lexmark-cloud-services-provisioning-saml-tutorial/organization.png "Organization")

4. Ensure your organization is configured for SSO with [Lexmark Cloud Services (SAML) application](~/identity/saas-apps/lexmark-cloud-services-tutorial.md).

5. In the **Select Organization** pane, select **User provisioning**.

    ![Screenshot shows User Provisioning Menu.](media/lexmark-cloud-services-provisioning-saml-tutorial/user-provisioning.png "User Provisioning")

6. Select  **Enable User Provisioning**.

    ![Screenshot shows Enable User Provisioning.](media/lexmark-cloud-services-provisioning-saml-tutorial/enable-user-provisioning-saml.png "Enable User Provisioning")

7. Provisioning details will be automatically populated when enabled.

    ![Screenshot shows User Provisioning Details.](media/lexmark-cloud-services-provisioning-saml-tutorial/provisioning-details.png "User Provisioning Details")

## Step 3: Add Lexmark Cloud Services (SAML) from the Microsoft Entra application gallery

Add Lexmark Cloud Services (SAML) from the Microsoft Entra application gallery to start managing provisioning to Lexmark Cloud Services (SAML). If you have previously setup Lexmark Cloud Services (SAML) for SSO, you can use the same application. However, it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Configure automatic user provisioning to Lexmark Cloud Services (SAML) 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Lexmark Cloud Services (SAML) based on user and/or group assignments in Microsoft Entra ID

<a name='to-configure-automatic-user-provisioning-for-lexmark-cloud-services-saml-in-azure-ad'></a>

### To configure automatic user provisioning for Lexmark Cloud Services (SAML) in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an app owner or a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

    ![Screenshot shows the enterprise applications blade.](common/enterprise-applications.png "Enterprise application")

1. In the applications list, select **Lexmark Cloud Services (SAML)**.

    ![Screenshot shows the Lexmark Cloud Services (SAML) link in the Applications list.](common/all-applications.png "Application List")

1. Select the **Provisioning** tab.

    ![Screenshot shows the provisioning tab.](common/provisioning.png "Tab")

1. Set **+ New configuration**.

    ![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the Tenant URL field, input your Lexmark Cloud Services (SAML) Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Lexmark Cloud Services (SAML). If the connection fails, ensure your Lexmark Cloud Services (SAML) account has Admin permissions and try again.
    
    ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.  

1. Select **Properties** in the **Overview** page.  

1. Select the pencil to edit the properties: 
    1. Enable notification emails and provide an email to receive quarantine emails. 
    1. Enable accidental deletions prevention.
    1. Select  **Apply**  to save the changes. 
    
   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select users.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Lexmark Cloud Services (SAML) in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Lexmark Cloud Services (SAML) for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Lexmark Cloud Services (SAML) API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

    |Attribute|Type|Supported for filtering|Required by Lexmark Cloud Services (SAML)|
    |---|---|---|---|
    |userName|String|&check;|&check;|
    |active|Boolean|||
    |name.givenName|String||
    |name.familyName|String||
    |displayName|String||
    |preferredLanguage|String||
    |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:costCenter|String|| 
    |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|| 

1. Select **groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Lexmark Cloud Services (SAML) in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Lexmark Cloud Services (SAML) for update operations. Select the **Save** button to commit any changes.

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md) article.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 5: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]
