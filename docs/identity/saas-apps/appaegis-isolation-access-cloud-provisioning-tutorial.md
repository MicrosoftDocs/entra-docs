---
title: Configure Appaegis Isolation Access Cloud for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Appaegis Isolation Access Cloud.

author: jeevansd
manager: pmwongera
ms.topic: how-to
ms.date: 02/20/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Appaegis Isolation Access Cloud so that I can streamline the user management process and ensure that users have the appropriate access to Appaegis Isolation Access Cloud.
---

# Configure Appaegis Isolation Access Cloud for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to do in both Appaegis Isolation Access Cloud and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to Appaegis Isolation Access Cloud using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Appaegis Isolation Access Cloud
> * Remove users in Appaegis Isolation Access Cloud when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Appaegis Isolation Access Cloud
> * [Single sign-on](appaegis-isolation-access-cloud-tutorial.md) to Appaegis Isolation Access Cloud (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* An Appaegis Cloud account with Professional level of subscription. 
* An Appaegis Cloud user account with administrator permissions.


## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Appaegis Isolation Access Cloud](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-appaegis-isolation-access-cloud-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Appaegis Isolation Access Cloud to support provisioning with Microsoft Entra ID

1. Enabled [SSO](appaegis-isolation-access-cloud-tutorial.md) with Appaegis Cloud.
2. When at the **Identity Provider Details** page (the page lists ACS URL and Entity ID), you find the SCIM URL and SCIM Token.

<a name='step-3-add-appaegis-isolation-access-cloud-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Appaegis Isolation Access Cloud from the Microsoft Entra application gallery

Add Appaegis Isolation Access Cloud from the Microsoft Entra application gallery to start managing provisioning to Appaegis Isolation Access Cloud. If you have previously setup Appaegis Isolation Access Cloud for SSO, you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Appaegis Isolation Access Cloud 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-appaegis-isolation-access-cloud-in-azure-ad'></a>

### To configure automatic user provisioning for Appaegis Isolation Access Cloud in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Appaegis Isolation Access Cloud**.

	![The Appaegis Isolation Access Cloud link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provision tab](common/provisioning.png)

1. Set **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Appaegis Isolation Access Cloud Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Appaegis Isolation Access Cloud. If the connection fails, ensure your Appaegis Isolation Access Cloud account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.	

1. Select **Properties** in the **Overview** page. 

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select users.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Appaegis Isolation Access Cloud in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Appaegis Isolation Access Cloud for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Appaegis Isolation Access Cloud API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

    |Attribute|Type|Supported for filtering|
    |---|---|---|
    |userName|String|&check;|
    |active|Boolean||
    |displayName|String||
    |name.givenName|String||
    |name.familyName|String||

10. Select **Groups**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Contoso in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Contoso for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md) article.

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
