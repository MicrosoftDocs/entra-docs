---
title: Configure Viareport (Europe) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Viareport (Europe).

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Viareport (Europe) so that I can control who has access to Viareport (Europe), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Viareport (Europe) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Viareport (Europe) with Microsoft Entra ID. When you integrate Viareport (Europe) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Viareport (Europe).
* Enable your users to be automatically signed-in to Viareport (Europe) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Viareport (Europe) single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Viareport (Europe) supports **SP and IDP** initiated SSO

## Adding Viareport (Europe) from the gallery

To configure the integration of Viareport (Europe) into Microsoft Entra ID, you need to add Viareport (Europe) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Viareport (Europe)** in the search box.
1. Select **Viareport (Europe)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-single-sign-on'></a>

## Configure and test Microsoft Entra single sign-on

Configure and test Microsoft Entra SSO with Viareport (Europe) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Viareport (Europe).

To configure and test Microsoft Entra SSO with Viareport (Europe), complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
2. **[Configure Viareport (Europe) SSO](#configure-viareport-europe-sso)** - to configure the Single Sign-On settings on application side.
3. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
4. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
5. **[Create Viareport (Europe) test user](#create-viareport-europe-test-user)** - to have a counterpart of B.Simon in Viareport (Europe) that's linked to the Microsoft Entra representation of user.
6. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

### Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Viareport (Europe)** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://inativ.viareport.com/SSO/<tenant_id>/callback`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://inativ.viareport.com/SSO/<tenant_id>/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Reply URL and Sign-On URL. Contact [Viareport (Europe) Client support team](mailto:ycezard@viareport.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

4. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

### Configure Viareport (Europe) SSO

To configure single sign-on on **Viareport (Europe)** side, you need to send the **App Federation Metadata Url** to [Viareport (Europe) support team](mailto:ycezard@viareport.com). They set this setting to have the SAML SSO connection set properly on both sides.
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

### Create Viareport (Europe) test user

In this section, you create a user called B.Simon in Viareport (Europe). Work with [Viareport (Europe) support team](mailto:ycezard@viareport.com) to add the users in the Viareport (Europe) platform. Users must be created and activated before you use single sign-on.

### Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Viareport (Europe) tile in the Access Panel, you should be automatically signed in to the Viareport (Europe) for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional Resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
