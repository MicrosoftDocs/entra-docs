---
title: Configure InviteDesk for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to InviteDesk.
author: jeevansd
manager: pmwongera
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to InviteDesk so that I can streamline the user management process and ensure that users have the appropriate access to InviteDesk.
---

# Configure InviteDesk for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both InviteDesk and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [InviteDesk](https://invitedesk.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in InviteDesk
> * Remove users in InviteDesk when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and InviteDesk
> * Provision groups and group memberships in InviteDesk.
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to InviteDesk (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A [InviteDesk](https://invitedesk.com/) tenant.
* A user account in InviteDesk with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and InviteDesk](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-invitedesk-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure InviteDesk to support provisioning with Microsoft Entra ID

1. Login to [InviteDesk admin console](https://app.invitedesk.com/). Navigate to **Settings > Active Directory**.


      ![InviteDesk settings](./media\invitedesk-provisioning-tutorial\invitedesk-settings.png)

1. Enter the **Azure Tenant-Id** and then select the toggle button to generate the corresponding **access code**.

      ![InviteDesk token page](./media\invitedesk-provisioning-tutorial\invitedesk-token-page.png)


1. On selecting the toggle button **access code** corresponding to the **Azure Tenant-Id** would be generated.This value is entered in the **Secret Token** * field in the Provisioning tab of your LucidChart application. 

      ![InviteDesk token generate](./media\invitedesk-provisioning-tutorial\invitedesk-token-generate.png)


<a name='step-3-add-invitedesk-from-the-azure-ad-application-gallery'></a>

## Step 3: Add InviteDesk from the Microsoft Entra application gallery

Add InviteDesk from the Microsoft Entra application gallery to start managing provisioning to InviteDesk. If you have previously setup InviteDesk for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to InviteDesk 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in InviteDesk based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-invitedesk-in-azure-ad'></a>

### To configure automatic user provisioning for InviteDesk in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **InviteDesk**.

	![The InviteDesk link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, input your InviteDesk **Tenant URL** and **Secret Token**. Select **Test Connection** to ensure Microsoft Entra ID can connect to InviteDesk. If the connection fails , ensure your InviteDesk account has Admin permissions and try again.

	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to InviteDesk**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to InviteDesk in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in InviteDesk for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the InviteDesk API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean||
   |emails[type eq "work"].value|String||
   |name.givenName|String||
   |name.familyName|String||
   |addresses[type eq "work"].streetAddress|String||
   |addresses[type eq "work"].locality|String||
   |addresses[type eq "work"].postalCode|String||
   |addresses[type eq "work"].country|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |externalId|String||
   |preferredLanguage|String||


1. In the **Mappings** section, select **Synchronize Microsoft Entra groups to InviteDesk**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to InviteDesk in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in InviteDesk for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |displayName|String|&check;|
   |externalId|String||
   |members|Reference||
   
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for InviteDesk, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to InviteDesk by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
