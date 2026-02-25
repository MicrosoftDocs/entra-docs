---
title: Configure Ardoq for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Ardoq.

author: jeevansd
manager: pmwongera
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 02/20/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Ardoq so that I can streamline the user management process and ensure that users have the appropriate access to Ardoq.
---

# Configure Ardoq for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Ardoq and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [Ardoq](https://www.ardoq.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Supported capabilities
> [!div class="checklist"]
> * Create users in Ardoq.
> * Remove users in Ardoq when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Ardoq.
> * [Single sign-on](ardoq-tutorial.md) to Ardoq (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* An administrator account with Ardoq.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Ardoq](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-ardoq-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Ardoq to support provisioning with Microsoft Entra ID
* Provisioning is gated by a feature toggle in Ardoq.  If you intend to configure SSO or have already done so, Ardoq automatically recognizes that Microsoft Entra ID is in use, and the provisioning feature is automatically enabled.

* If you don't intend to use the provisioning features of Microsoft Entra ID along with SSO, please reach out to Ardoq customer support and they'll manually enable support for provisioning.

Before we proceed we need to obtain a *Tenant Url* and a *Secret Token*, to configure secure communication between Microsoft Entra ID and Ardoq.




1. Log in to Ardoq admin console. 
1. In the left menu, select profile logo and, navigate to **Organization Settings->Manage Organization->Manage SCIM Token**.
1. Select **Generate new**.
1. Copy and save the **Token**.This value is entered in the **Secret Token** field in the Provisioning tab of your Ardoq application. 
1. To create your *tenant URL*, use this template: `https://<YOUR-SUBDOMAIN>.ardoq.com/api/scim/v2` by replacing the placeholder text `<YOUR-SUBDOMAIN>`.This value is entered in the **Tenant Url** field in the Provisioning tab of your Ardoq application.

	>[!NOTE]
	>`<YOUR-SUBDOMAIN>` is the subdomain your organization has chosen to access Ardoq. This is the same URL segment you use when you access the Ardoq app. For example, if your organization accesses Ardoq at `https://acme.ardoq.com` you'd fill in `acme`.  If you're in the US and access Ardoq at `https://piedpiper.us.ardoq.com`  then you'd fill in `piedpiper.us`.

<a name='step-3-add-ardoq-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Ardoq from the Microsoft Entra application gallery

Add Ardoq from the Microsoft Entra application gallery to start managing provisioning to Ardoq. If you have previously setup Ardoq for SSO you can use the same application. However it's recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Ardoq 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-ardoq-in-azure-ad'></a>

### To configure automatic user provisioning for Ardoq in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Ardoq**.

	![Screenshot of the Ardoq link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Ardoq Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Ardoq. If the connection fails, ensure your Ardoq account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.	

1. Select **Properties** in the **Overview** page. 

1. Select the pencil to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select users.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Ardoq in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Ardoq for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Ardoq API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Ardoq|
   |---|---|---|---|
   |userName|String|&check;|&check;|
   |active|Boolean||&check;|
   |displayName|String||&check;|
   |roles[primary eq "True"].value|String||&check;|
   
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
