---
title: Configure Smallstep SSH for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Smallstep SSH.

author: jeevansd
manager: pmwongera
ms.topic: how-to
ms.date: 04/16/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Smallstep SSH so that I can streamline the user management process and ensure that users have the appropriate access to Smallstep SSH.
---

# Configure Smallstep SSH for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Smallstep SSH and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Smallstep SSH](https://smallstep.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Smallstep SSH
> * Remove users in Smallstep SSH when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Smallstep SSH
> * Provision groups and group memberships in Smallstep SSH
> * Single sign-on to Smallstep SSH (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A [Smallstep SSH](https://smallstep.com/sso-ssh/) account.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Smallstep SSH](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-smallstep-ssh-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Smallstep SSH to support provisioning with Microsoft Entra ID

1. Log in to your [Smallstep SSH](https://smallstep.com/sso-ssh/) account.

1. Navigate to the **Users** tab and select **Microsoft Entra ID** as your Identity Provider.

1. On the next page, provide your **Microsoft Entra tenant ID** and allow list to configure OIDC.

1. Under SCIM Details, copy and save your SCIM **Tenant URL** and **Secret Token**. These values are entered in the **Tenant URL** and **Secret Token** field in the Provisioning tab of your Smallstep SSH application.

>Note! 
>You would need to grant access to your Smallstep managed hosts via Active Directory Groups. For example, you might have a group for your ssh users and one for your sudo users. Learn more about access control in [Microsoft Entra Quickstart](https://smallstep.com/docs/ssh/azure-ad) and [Host Quickstart Guide](https://smallstep.com/docs/ssh/hosts).

<a name='step-3-add-smallstep-ssh-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Smallstep SSH from the Microsoft Entra application gallery

Add Smallstep SSH from the Microsoft Entra application gallery to start managing provisioning to Smallstep SSH. If you have previously setup Smallstep SSH for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Smallstep SSH 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Smallstep SSH based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-smallstep-ssh-in-azure-ad'></a>

### To configure automatic user provisioning for Smallstep SSH in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Smallstep SSH**.

	![The Smallstep SSH link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your Smallstep SSH Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Smallstep SSH. If the connection fails, ensure your Smallstep SSH account has the required admin permissions and try again.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Smallstep SSH in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Smallstep SSH for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Smallstep SSH API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported For Filtering|
   |---|---|--|
   |userName|String|&check;|
   |active|Boolean|
   |displayName|String|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|

1. Review the group attributes that are synchronized from Microsoft Entra ID to Smallstep SSH in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Smallstep SSH for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported For Filtering|
      |---|---|---|
      |displayName|String|&check;|
      |members|Reference|

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
