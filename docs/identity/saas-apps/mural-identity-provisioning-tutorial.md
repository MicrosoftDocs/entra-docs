---
title: Configure MURAL Identity for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to MURAL Identity.
author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to MURAL Identity so that I can streamline the user management process and ensure that users have the appropriate access to MURAL Identity.
---

# Configure MURAL Identity for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both MURAL Identity and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [MURAL Identity](https://www.mural.co/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in MURAL Identity
> * Remove users in MURAL Identity when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and MURAL Identity
> * Provision groups and group memberships in MURAL Identity.
> * [Single sign-on](mural-identity-tutorial.md) to MURAL Identity (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* SCIM provisioning is only available for MURAL’s Enterprise plan. Before you configure SCIM provisioning, please reach out to a member of the MURAL Customer Success Team to enable the feature.
* SAML based SSO must be properly set up before configuring automated provisioning. The instructions on how to set up SSO through Microsoft Entra ID for MURAL can be found [here](mural-identity-tutorial.md).

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1.  Determine what data to [map between Microsoft Entra ID and MURAL Identity](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-mural-identity-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure MURAL Identity to support provisioning with Microsoft Entra ID

Follow the [steps](https://developers.mural.co/enterprise/docs/set-up-the-scim-api) to get your SCIM URL and unique API Token from the API keys page in your MURAL Company dashboard. Use this key in the Secret Token field in **Step 5**.

<a name='step-3-add-mural-identity-from-the-azure-ad-application-gallery'></a>

## Step 3: Add MURAL Identity from the Microsoft Entra application gallery

Add MURAL Identity from the Microsoft Entra application gallery to start managing provisioning to MURAL Identity. If you have previously setup MURAL Identity for SSO you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to MURAL Identity 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in MURAL Identity based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-mural-identity-in-azure-ad'></a>

### To configure automatic user provisioning for MURAL Identity in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **MURAL Identity**.

	![The MURAL Identity link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your MURAL Identity Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to MURAL Identity. If the connection fails, ensure your MURAL Identity account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to MURAL Identity**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to MURAL Identity in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in MURAL Identity for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the MURAL Identity API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by MURAL Identity
   |---|---|---|---
   |userName|String|&check;|&check;
   |emails[type eq "work"].value|String||&check;
   |active|Boolean||
   |name.givenName|String||
   |name.familyName|String||
   |externalId|String||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to MURAL Identity**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to MURAL Identity in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in MURAL Identity for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by MURAL Identity|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |members|Reference||
   |externalId|String||
10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for MURAL Identity, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users and/or groups that you would like to provision to MURAL Identity by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

13. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Troubleshooting Tips
* When provisioning a user keep in mind that at MURAL we don't support numbers in the name fields (that is, givenName or familyName).
* When filtering on **userName** in the GET endpoint make sure that the email address is all lowercase otherwise you get an empty result. This is because we convert email addresses to lowercase while provisioning accounts.
* When de-provisioning an end-user (setting the active attribute to false), user is soft-deleted and lose access to all their workspaces. When that same de-provisioned end-user is later activated again (setting the active attribute to true), user doesn't have access to the workspaces user previously belonged to. The end-user will see an error message "You’ve been deactivated from this workspace",  with an option to request reactivation which the workspace admin must approve.
* If you have any other issues, please reach out to [MURAL Identity support team](mailto:support@mural.co).

## Change log
06/22/2023 - Added support for **Group Provisioning**.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
