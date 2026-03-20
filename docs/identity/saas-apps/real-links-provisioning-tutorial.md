---
title: Configure Real Links for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Real Links.
author: jeevansd
manager: pmwongera
ms.topic: how-to
ms.date: 03/20/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Real Links so that I can streamline the user management process and ensure that users have the appropriate access to Real Links.
---

# Configure Real Links for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Real Links and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Real Links](https://www.reallinks.io) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Real Links
> * Remove users in Real Links when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Real Links
> * [Single sign-on](real-links-tutorial.md) to Real Links (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A [Real Links](https://www.reallinks.io/) subscription - all tiers include automatic user provisioning.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Real Links](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-real-links-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Real Links to support provisioning with Microsoft Entra ID

To configure provisioning in your Real Links platform, you need to contact the [Real Links support team](mailto:support@reallinks.io) and request your SCIM-v2 provisioning details. This will include:

* Your platform's tenant URL
* Your unique secret token

<a name='step-3-add-real-links-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Real Links from the Microsoft Entra application gallery

Add Real Links from the Microsoft Entra application gallery to start managing provisioning to Real Links. If you have previously setup Real Links for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Real Links 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Real Links based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-real-links-in-azure-ad'></a>

### To configure automatic user provisioning for Real Links in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Real Links**.

	![The Real Links link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your Real Links Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Real Links. If the connection fails, ensure your Real Links account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Real Links in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Real Links for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Real Links API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Real Links|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |active|Boolean||&check;
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:firstName|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:lastName|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:emailAddress|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:phoneNumber|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:title|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:preferredLanguage|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:organization|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:department|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:division|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:location|String|
   |urn:ietf:params:scim:schemas:extension:real-links:2.0:User:countryCode|String|

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
