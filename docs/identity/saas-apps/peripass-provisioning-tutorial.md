---
title: Configure Peripass for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Peripass.
author: jeevansd
manager: pmwongera
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Peripass so that I can streamline the user management process and ensure that users have the appropriate access to Peripass.
---

# Configure Peripass for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Peripass and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Peripass](https://www.peripass.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Peripass
> * Remove users in Peripass when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Peripass
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to Peripass (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Peripass tenant - contact [Peripass](https://www.peripass.com/) to set up your tenant.
* A Peripass user with permissions to the tenant's configuration.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Peripass](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-peripass-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Peripass to support provisioning with Microsoft Entra ID

1. Sign in to Peripass using your tenant's sign-in URL.

2. Go to your tenant's **Configuration**.

   ![Screenshot of Peripass main menu](media/peripass-provisioning-tutorial/peripass-main-menu.png)

3. Open the **Identity providers & provisioning** settings.

   ![Screenshot of Peripass tenant configuration](media/peripass-provisioning-tutorial/peripass-configuration.png)

4. Give a **Provider name** to the identity provider you're configuring.

5.   Pick the **User role** that should be assigned to the provisioned users.

6. Note down your tenant's **SCIM Endpoint** and **SCIM Token** (you will need it later on when configuring the user provisioning in the Microsoft Entra Enterprise Applications and use it as **Peripass Tenant URL** and **Secret Token**).

   ![Screenshot of Peripass id provider settings](media/peripass-provisioning-tutorial/peripass-id-provider-settings.png)

7. **Save your changes** in the configuration.

   ![Screenshot of saving the provider](media/peripass-provisioning-tutorial/peripass-save-changes.png)

<a name='step-3-add-peripass-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Peripass from the Microsoft Entra application gallery

Add Peripass from the Microsoft Entra application gallery to start managing provisioning to Peripass. If you have previously setup Peripass for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who is in scope for provisioning

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Peripass

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-peripass-in-azure-ad'></a>

### To configure automatic user provisioning for Peripass in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

   ![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Peripass**.

   ![The Peripass link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

   ![Provision tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

   ![Provisioning tab](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Peripass Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Peripass. If the connection fails, ensure your Peripass account has Admin permissions and try again.

   ![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Peripass**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Peripass in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Peripass for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Peripass API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;
   |active|Boolean|
   |displayName|String|
   |externalId|String|
   |preferredLanguage|String|
   |name.givenName|String|
   |name.familyName|String|
   |name.formatted|String|
   |phoneNumbers[type eq "mobile"].value|String|
   |emails[type eq "work"].value|String|
   
10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for Peripass, change the **Provisioning Status** to **On** in the **Settings** section.

    ![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users and/or groups that you would like to provision to Peripass by choosing the desired values in **Scope** in the **Settings** section.

    ![Provisioning Scope](common/provisioning-scope.png)

13. When you're ready to provision, select **Save**.

    ![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
