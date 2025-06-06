---
title: Configure QA for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to QA.


author: thomasakelo
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to QA so that I can streamline the user management process and ensure that users have the appropriate access to QA.
---

# Configure QA for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both QA and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [QA](https://www.qa.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in QA
> * Remove users in QA when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and QA
> * [Single sign-on](./cloud-academy-sso-tutorial.md) to QA (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A user account in QA with an Administrator role in your company to activate the AD Integration and generate the API Key.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and QA](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-cloud-academy---sso-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure QA to support provisioning with Microsoft Entra ID

1. Login to [QA](https://www.qa.com) admin portal.

2. Select **Dashboard** on the home page next to the profile icon.

	![Home](media/cloud-academy-sso-provisioning-tutorial/dashboard.png)

3. Navigate to **your profile** > **Settings & Integrations**.

	![Integrations](media/cloud-academy-sso-provisioning-tutorial/settings.png)

4. Select **Integrations** tab and select **View Integration** in Microsoft Entra ID.

	![Directory](media/cloud-academy-sso-provisioning-tutorial/active.png)

5. Select **Generate a new API Key**.

	![Generate](media/cloud-academy-sso-provisioning-tutorial/key.png)

6. Copy the full API Key. This value is entered in the **Secret Token** field in the Provisioning tab of your QA application.

   >[!Note]
   >You can generate a new API Key as required. The old API Key is marked as expired in the next **8 hours** to allow the time needed to update the configuration in the AD Portal.

7. The Tenant URL is `https://app.qa.com/webhooks/ad/v1/scim`. This value is entered in the **Tenant URL** field in the Provisioning tab of your QA application.

<a name='step-3-add-cloud-academy---sso-from-the-azure-ad-application-gallery'></a>

## Step 3: Add QA from the Microsoft Entra application gallery

Add QA from the Microsoft Entra application gallery to start managing provisioning to QA. If you have previously setup QA for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to QA 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-cloud-academy---sso-in-azure-ad'></a>

### To configure automatic user provisioning for QA in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **QA**.

	![The QA link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your QA Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to QA. If the connection fails, ensure your QA account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to QA**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to QA in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in QA for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the QA API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported For Filtering|
   |---|---|---|
   |userName|String|&check;|
   |externalId|String||
   |active|Boolean||
   |name.givenName|String||
   |name.familyName|String||

10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for QA, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users and/or groups that you would like to provision to QA by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

13. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
