---
title: Configure SecureLogin for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to SecureLogin.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: thomasakelo
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to SecureLogin so that I can streamline the user management process and ensure that users have the appropriate access to SecureLogin.
---

# Configure SecureLogin for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both SecureLogin and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [SecureLogin](https://securelogin.nu) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in SecureLogin
> * Remove users in SecureLogin when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and SecureLogin
> * Provision groups and group memberships in SecureLogin
> * Single sign-on to SecureLogin (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A [SecureLogin](https://securelogin.nu) Account.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and SecureLogin](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-securelogin-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure SecureLogin to support provisioning with Microsoft Entra ID

A [SecureLogin](https://securelogin.nu) account as a manager is required to **Authorize** in the **Admin Credentials** section in Step 5. 

<a name='step-3-add-securelogin-from-the-azure-ad-application-gallery'></a>

## Step 3: Add SecureLogin from the Microsoft Entra application gallery

Add SecureLogin from the Microsoft Entra application gallery to start managing provisioning to SecureLogin. If you have previously setup SecureLogin for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to SecureLogin 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-securelogin-in-azure-ad'></a>

### To configure automatic user provisioning for SecureLogin in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **SecureLogin**.

	![The SecureLogin link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, select **Authorize**. You be redirected to **SecureLogin**'s Go to domain page. Input your SecureLogin domain and select the **Go** button. You be redirected to **SecureLogin**'s Authorization page. Input your **Username** and **Password** and select the **Login** button. Select **Test Connection** to ensure Microsoft Entra ID can connect to SecureLogin. If the connection fails, ensure your SecureLogin account has Admin permissions and try again.

 	![Admin Credentials](./media/secure-login-provisioning-tutorial/authorize.png)

 	![Welcome](./media/secure-login-provisioning-tutorial/login.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to SecureLogin**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to SecureLogin in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in SecureLogin for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the SecureLogin API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for Filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|
   |phoneNumbers[type eq "mobile"].value|String|
   |externalId|String|
   |preferredLanguage|String|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to SecureLogin**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to SecureLogin in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in SecureLogin for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for Filtering|
      |---|---|---|
      |displayName|String|&check;|
      |externalId|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for SecureLogin, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to SecureLogin by choosing the desired values in **Scope** in the **Settings** section.

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
