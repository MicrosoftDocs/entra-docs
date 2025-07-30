---
title: Configure Talentech for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Talentech.
author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Talentech so that I can streamline the user management process and ensure that users have the appropriate access to Talentech.
---

# Configure Talentech for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Talentech and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Talentech](https://www.talentech.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Talentech
> * Remove users in Talentech when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Talentech
> * Provision groups and group memberships in Talentech
> * Single sign-on to Talentech (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A user account in Talentech.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Talentech](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-talentech-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Talentech to support provisioning with Microsoft Entra ID

1. Log in [Talentech](https://www.talentech.com).

2. Navigate to **Integrations** in the left panel and select **Add new integration**.

	![Navigate](media/talentech-provisioning-tutorial/integrations.png)

3. Enter a **Name** for the integration and select **Add**.

4. Navigate to the integration you created and select **Create api-access token**.

	![api](media/talentech-provisioning-tutorial/token.png)

5. An access token is generated. This value is entered in the **Secret Token** field in the Provisioning tab of your Talentech application.

	![permanent](media/talentech-provisioning-tutorial/bearer.png)

6. Reach out to Talentech support to generate a Tenant URL. This value is entered in the **Tenant URL** field in the Provisioning tab of your Talentech application.

<a name='step-3-add-talentech-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Talentech from the Microsoft Entra application gallery

Add Talentech from the Microsoft Entra application gallery to start managing provisioning to Talentech. If you have previously setup Talentech for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Talentech 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in TestApp based on user and group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-talentech-in-azure-ad'></a>

### To configure automatic user provisioning for Talentech in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Talentech**.

	![The Talentech link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Talentech Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Talentech. If the connection fails, ensure your Talentech account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Talentech**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Talentech in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Talentech for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Talentech API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |externalId|String|
   |active|Boolean|
   |name.givenName|String|
   |name.familyName|String|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Talentech**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Talentech in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Talentech for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |externalId|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Talentech, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and groups that you would like to provision to Talentech by choosing the desired values in **Scope** in the **Settings** section.

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
