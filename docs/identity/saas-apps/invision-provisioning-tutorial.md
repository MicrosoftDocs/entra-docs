---
title: Configure InVision for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to InVision.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Invision so that I can streamline the user management process and ensure that users have the appropriate access to Invision.
---

# Configure InVision for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both InVision and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [InVision](https://www.invisionapp.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in InVision
> * Remove users in InVision when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and InVision
> * [Single sign-on](./invision-tutorial.md) to InVision (required)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (like [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications)). 
* An [InVision Enterprise account](https://www.invisionapp.com/) with SSO enabled.
* A user account in InVision with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and InVision](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-invision-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure InVision to support provisioning with Microsoft Entra ID

1. Sign in to your [InVision Enterprise account](https://www.invisionapp.com/) as an Admin or Owner. Open the **Team Settings** drawer on the bottom left and select **Settings**.

   ![SCIM setup configuration](./media/invision-provisioning-tutorial/invision-scim-settings.png)

2. Select **Change** on the **User Provisioning with SCIM** setting.

   ![SCIM provisioning settings](./media/invision-provisioning-tutorial/invision-provisioning-settings.png)

3. Select the toggle to enable SCIM provisioning. Note that you must have SSO configured first to be able to enable SCIM:

   ![SCIM enable provisioning](./media/invision-provisioning-tutorial/enable-scim-provisioning.png)

4. Copy the **SCIM API URL** and append `/scim/v2` to the URL. Copy the **Authentication token**. Save these values for later to use in the **Tenant URL** and **Secret Token** fields in the Provisioning tab of your InVision application.

   ![SCIM access token](./media/invision-provisioning-tutorial/invision-access-token.png)


<a name='step-3-add-invision-from-the-azure-ad-application-gallery'></a>

## Step 3: Add InVision from the Microsoft Entra application gallery

Add InVision from the Microsoft Entra application gallery to start managing provisioning to InVision. If you have previously setup InVision for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to InVision 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-invision-in-azure-ad'></a>

### To configure automatic user provisioning for InVision in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **InVision**.

	![The InVision link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning mode](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input the SCIM API URL value retrieved earlier in **Tenant URL**. Input the Authentication token value retrieved earlier in **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to InVision. If the connection fails, ensure your InVision account has Admin permissions and try again.

	![Admin Credentials](./media/inVision-provisioning-tutorial/provisioning.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Provision Microsoft Entra users**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to InVision in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in InVision for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the InVision API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean||
   |emails[type eq "work"].value|String||
   |name.givenName|String||
   |name.familyName|String||

10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for InVision, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users and/or groups that you would like to provision to InVision by choosing the desired values in **Scope** in the **Settings** section.

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
