---
title: Configure Atea for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Atea.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Atea so that I can streamline the user management process and ensure that users have the appropriate access to Atea.
---

# Configure Atea for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to do in both Atea and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Atea](https://www.atea.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works and frequently asked questions refer [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Atea
> * Remove users in Atea when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Atea

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A user account in Atea with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Atea](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-atea-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Atea to support provisioning with Microsoft Entra ID

Contact [Atea support](mailto:sso.support@atea.com) to configure Atea to support provisioning with Microsoft Entra ID.

<a name='step-3-add-atea-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Atea from the Microsoft Entra application gallery

Add Atea from the Microsoft Entra application gallery to start managing provisioning to Atea. If you have previously setup Atea for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Atea 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in Atea, based on user and group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-atea-in-azure-ad'></a>

### To configure automatic user provisioning for Atea in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Atea**.

	![The Atea link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. In the **Admin Credentials** section, select **Authorize**. It opens an Atea login dialog box in a new browser window.

 	 ![Atea authorize](media/atea-provisioning-tutorial/provisioning-authorize.png)

6. On the Atea's log in dialog, sign in to your Atea's tenant and verify your identity.
       
      ![Atea login dialog](media/atea-provisioning-tutorial/atea-login.png)

7. Upon completing steps 5 and 6, select **Test Connection** to ensure Microsoft Entra ID can connect to Atea. If the connection fails, ensure your Atea has Admin permissions and try again.
        
      ![Atea test connection](media/atea-provisioning-tutorial/test-connection.png)

8. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications. And then select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

9. Select **Save**.

10. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Atea**.

11. Review the user attributes that are synchronized from Microsoft Entra ID to Atea in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Atea for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Atea API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|Required by LawVu|
      |---|---|---|---|
      |userName|String|&check;|&check;|
      |active|Boolean||&check;|
      |emails[type eq "work"].value|String||&check;|
      |name.givenName|String|||
      |name.familyName|String|||
      |name.formatted|String||&check;|
      |phoneNumbers[type eq "mobile"].value|String|||
      |locale|String|||

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Atea, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and groups that you would like to provision to Atea by choosing the relevant value in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to complete than next cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Change Log
* 10/25/2022 - Drop core user attribute **nickName**. 
* 10/25/2022 - Changed the mapping of core user attribute **name.formatted** to **Join(" ", [givenName], [surname]) -> name.formatted**.
* 10/25/2022 - Domain name of all OAuth config urls of Atea app changed to Atea owned domain.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
