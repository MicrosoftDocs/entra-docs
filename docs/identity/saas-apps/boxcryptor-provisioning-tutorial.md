---
title: Configure Boxcryptor for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Boxcryptor.


author: jeevansd
manager: pmwongera

ms.topic: how-to
ms.date: 03/02/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Boxcryptor so that I can streamline the user management process and ensure that users have the appropriate access to Boxcryptor.
---

# Configure Boxcryptor for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Boxcryptor and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Boxcryptor](https://www.boxcryptor.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Boxcryptor
> * Remove users in Boxcryptor when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Boxcryptor
> * Provision groups and group memberships in Boxcryptor
> * [Single sign-on](./boxcryptor-tutorial.md) to Boxcryptor (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Boxcryptor Single sign-on enabled [subscription](https://www.boxcryptor.com).

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Boxcryptor](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-boxcryptor-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Boxcryptor to support provisioning with Microsoft Entra ID
To configure provisioning on Boxcryptor, reach out to your Boxcryptor account manager or the [Boxcryptor support team](mailto:support@boxcryptor.com) who enables provisioning on Boxcryptor and reach out to you with your Boxcryptor Tenant URL and Secret Token. These values are entered in the **Tenant URL** and **Secret Token** field in the Provisioning tab of your Boxcryptor application.

<a name='step-3-add-boxcryptor-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Boxcryptor from the Microsoft Entra application gallery

Add Boxcryptor from the Microsoft Entra application gallery to start managing provisioning to Boxcryptor. If you have previously setup Boxcryptor for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Boxcryptor 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-boxcryptor-in-azure-ad'></a>

### To configure automatic user provisioning for Boxcryptor in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Boxcryptor**.

	![The Boxcryptor link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Boxcryptor Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Boxcryptor. If the connection fails, ensure your Boxcryptor account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.	

1. Select **Properties** in the **Overview** page. 

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select users.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Boxcryptor in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Boxcryptor for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Boxcryptor API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for Filtering|
   |---|---|---|
   |userName|String|&check;|
   |preferredLanguage|String||
   |name.givenName|String||
   |name.familyName|String||
   |externalId|String||
   |addresses[type eq "work"].country|String||

10. Select **Groups**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Boxcryptor in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Boxcryptor for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for Filtering|
      |---|---|---|
      |displayName|String|&check;|
      |externalId|String||
      |members|Reference||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md) article.

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.


## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
