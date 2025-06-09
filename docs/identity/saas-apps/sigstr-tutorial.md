---
title: Configure Sigstr for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Sigstr.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Sigstr so that I can control who has access to Sigstr, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Sigstr for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Sigstr with Microsoft Entra ID. When you integrate Sigstr with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Sigstr.
* Enable your users to be automatically signed-in to Sigstr with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Sigstr single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Sigstr supports **IDP** initiated SSO
* Sigstr supports **Just In Time** user provisioning

## Adding Sigstr from the gallery

To configure the integration of Sigstr into Microsoft Entra ID, you need to add Sigstr from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Sigstr** in the search box.
1. Select **Sigstr** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-single-sign-on-for-sigstr'></a>

## Configure and test Microsoft Entra single sign-on for Sigstr

Configure and test Microsoft Entra SSO with Sigstr using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Sigstr.

To configure and test Microsoft Entra SSO with Sigstr, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Sigstr SSO](#configure-sigstr-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Sigstr test user](#create-sigstr-test-user)** - to have a counterpart of B.Simon in Sigstr that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Sigstr** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. Sigstr application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Select **Edit** icon to open User Attributes dialog.

	![image](common/edit-attribute.png)

1. In addition to above, Sigstr application expects few more attributes to be passed back in SAML response. In the User Claims section on the User Attributes dialog, perform the following steps to add SAML token attribute as shown in the below table:

	| Name |  Source Attribute|
	| -------|----------- |
	| email | user.mail |

	1. Select **Add new claim** to open the **Manage user claims** dialog.

	1. In the **Name** textbox, type the attribute name shown for that row.

	1. Leave the **Namespace** blank.

	1. Select Source as **Attribute**.

	1. From the **Source attribute** list, type the attribute value shown for that row.

	1. Select **Ok**

	1. Select **Save**.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificateraw.png)

1. On the **Set up Sigstr** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

## Configure Sigstr SSO

To configure single sign-on on **Sigstr** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from the application configuration to [Sigstr support team](mailto:support@sigstr.com). They set this setting to have the SAML SSO connection set properly on both sides.

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

### Create Sigstr test user

In this section, a user called Britta Simon is created in Sigstr. Sigstr supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Sigstr, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Sigstr tile in the Access Panel, you should be automatically signed in to the Sigstr for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
