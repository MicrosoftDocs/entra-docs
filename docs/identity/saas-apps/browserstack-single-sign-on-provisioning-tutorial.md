---
title: Configure BrowserStack Single Sign-on for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to BrowserStack Single Sign-on.


author: thomasakelo
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to BrowserStack Single Sign-on so that I can streamline the user management process and ensure that users have the appropriate access to BrowserStack Single Sign-on.
---

# Configure BrowserStack Single Sign-on for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both BrowserStack Single Sign-on and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [BrowserStack Single Sign-on](https://www.browserstack.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in BrowserStack Single Sign-on
> * Remove users in BrowserStack Single Sign-on when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and BrowserStack Single Sign-on
> * [Single sign-on](./browserstack-single-sign-on-tutorial.md) to BrowserStack Single Sign-on (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A user account in BrowserStack with **Owner** permissions.
* An [Enterprise plan](https://www.browserstack.com/pricing) with BrowserStack. 
* [Single Sign-on](https://www.browserstack.com/docs/enterprise/single-sign-on/azure-ad) integration with BrowserStack (mandatory).

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and BrowserStack Single Sign-on](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-browserstack-single-sign-on-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure BrowserStack Single Sign-on to support provisioning with Microsoft Entra ID

1. Log in to [BrowserStack](https://www.browserstack.com/users/sign_in) as a user with **Owner** permissions.

2. Navigate to **Account** > **Settings & Permissions**. Select the **Security** tab.

3. Under **Auto User Provisioning**, select **Configure**.

    ![Settings](media/browserstack-single-sign-on-provisioning-tutorial/configure.png)

4. Select the user attributes that you want to control via Microsoft Entra ID and select **Confirm**.

    ![User](media/browserstack-single-sign-on-provisioning-tutorial/attributes.png)

5. Copy the **Tenant URL** and **Secret Token**. These values are entered in the Tenant URL and Secret Token fields in the Provisioning tab of your BrowserStack Single Sign-on application. Select **Done**.

    ![Authorization](media/browserstack-single-sign-on-provisioning-tutorial/credential.png)

6. Your provisioning configuration has been saved on BrowserStack. **Enable** user provisioning in BrowserStack once **the provisioning setup on Microsoft Entra ID** is completed, to prevent blocking of inviting new users from BrowserStack [Account](https://www.browserstack.com/accounts/manage-users). 

    ![Account](media/browserstack-single-sign-on-provisioning-tutorial/enable.png)
    
<a name='step-3-add-browserstack-single-sign-on-from-the-azure-ad-application-gallery'></a>

## Step 3: Add BrowserStack Single Sign-on from the Microsoft Entra application gallery

Add BrowserStack Single Sign-on from the Microsoft Entra application gallery to start managing provisioning to BrowserStack Single Sign-on. If you have previously setup BrowserStack Single Sign-on for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to BrowserStack Single Sign-on 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in app based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-browserstack-single-sign-on-in-azure-ad'></a>

### To configure automatic user provisioning for BrowserStack Single Sign-on in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **BrowserStack Single Sign-on**.

	![The BrowserStack Single Sign-on link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your BrowserStack Single Sign-on Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to BrowserStack Single Sign-on. If the connection fails, ensure your BrowserStack Single Sign-on account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to BrowserStack Single Sign-on**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to BrowserStack Single Sign-on in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in BrowserStack Single Sign-on for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the BrowserStack Single Sign-on API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for Filtering|
   |---|---|--|
   |userName|String|&check;|
   |name.givenName|String||
   |name.familyName|String||
   |urn:ietf:params:scim:schemas:extension:Bstack:2.0:User:bstack_role|String||
   |urn:ietf:params:scim:schemas:extension:Bstack:2.0:User:bstack_team|String||
   |urn:ietf:params:scim:schemas:extension:Bstack:2.0:User:bstack_product|String||


10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for BrowserStack Single Sign-on, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users that you would like to provision to BrowserStack Single Sign-on by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

13. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Connector limitations

* BrowserStack Single Sign-on doesn't support group provisioning.
* BrowserStack Single Sign-on requires **emails[type eq "work"].value** and **userName** to have the same source value.

## Troubleshooting tips

* Refer to troubleshooting tips [here](https://www.browserstack.com/docs/enterprise/auto-user-provisioning/azure-ad#troubleshooting).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Configuring attribute-mappings in BrowserStack Single Sign-on](https://www.browserstack.com/docs/enterprise/auto-user-provisioning/azure-ad)
* [Setup and enable auto user provisioning in BrowserStack](https://www.browserstack.com/docs/enterprise/auto-user-provisioning/azure-ad#setup-and-enable-auto-user-provisioning)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
