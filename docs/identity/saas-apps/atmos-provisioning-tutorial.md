---
title: Configure Atmos for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Atmos.

author: jeevansd
manager: pmwongera

ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 02/26/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Atmos so that I can streamline the user management process and ensure that users have the appropriate access to Atmos.
---

# Configure Atmos for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to do in both Atmos and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Atmos](https://www.axissecurity.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Atmos.
> * Remove users in Atmos when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Atmos.
> * Provision groups and group memberships in Atmos.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A user account in [Axis Security](https://www.axissecurity.com) with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Atmos](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-atmos-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Atmos to support provisioning with Microsoft Entra ID

1. Log in to the Axis Management Console.
1. Navigate to **Settings**-> **Identity Providers** screen.
1. Hover over the **Azure Identity Provider** and select **edit**.
1. Navigate to **Advanced Settings**.
1. Navigate to **User Auto-Provisioning (SCIM)**. 
1. Select **Generate new token**.
1. Copy the **SCIM Service Provider Endpoint** and **SCIM Provisioning Token** and paste them into a text editor. You need them for Step 5.

<a name='step-3-add-atmos-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Atmos from the Microsoft Entra application gallery

Add Atmos from the Microsoft Entra application gallery to start managing provisioning to Atmos. If you have previously setup Atmos for SSO, you can use the same application. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Atmos 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Atmos based on user and/or group assignments in Microsoft Entra ID. 

<a name='to-configure-automatic-user-provisioning-for-atmos-in-azure-ad'></a>

### To configure automatic user provisioning for Atmos in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an app owner or [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Atmos**.

	![Screenshot of the Atmos link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Atmos Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Atmos. If the connection fails, ensure your Atmos account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.	

1. Select **Properties** in the **Overview** page. 

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Atmos in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Atmos for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Atmos API supports filtering users based on that attribute. Select the **Save** button to commit any changes.



   |Attribute|Type|Supported for filtering|Required by Atmos|
   |---|---|---|---|
   |userName|String|&check;|&check;|   
   |active|Boolean|||
   |displayName|String||&check;|
   |emails[type eq "work"].value|String||| 
   |name.givenName|String|||
   |name.familyName|String|||
   |externalId|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String|||


1. Select **groups**. 

1. Review the group attributes that are synchronized from Microsoft Entra ID to Atmos in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Atmos for update operations. Select the **Save** button to commit any changes.



      |Attribute|Type|Supported for filtering|Required by Atmos|
      |---|---|---|---|
      |displayName|String|&check;|&check;|
      |members|Reference|||
      |externalId|String||&check;|


1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.
## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
