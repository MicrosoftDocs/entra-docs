---
title: Configure Nexonia for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Nexonia.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Nexonia so that I can control who has access to Nexonia, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Nexonia for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Nexonia with Microsoft Entra ID.
Integrating Nexonia with Microsoft Entra ID provides you with the following benefits:

* You can control in Microsoft Entra ID who has access to Nexonia.
* You can enable your users to be automatically signed-in to Nexonia (Single Sign-On) with their Microsoft Entra accounts.
* You can manage your accounts in one central location.

If you want to know more details about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).
If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Nexonia single sign-on enabled subscription

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Nexonia supports **IDP** initiated SSO

## Adding Nexonia from the gallery

To configure the integration of Nexonia into Microsoft Entra ID, you need to add Nexonia from the gallery to your list of managed SaaS apps.

**To add Nexonia from the gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the search box, type **Nexonia**, select **Nexonia** from result panel then select **Add** button to add the application.

	 ![Nexonia in the results list](common/search-new-app.png)

<a name='configure-and-test-azure-ad-single-sign-on'></a>

## Configure and test Microsoft Entra single sign-on

In this section, you configure and test Microsoft Entra single sign-on with Nexonia based on a test user called **Britta Simon**.
For single sign-on to work, a link relationship between a Microsoft Entra user and the related user in Nexonia needs to be established.

To configure and test Microsoft Entra single sign-on with Nexonia, you need to complete the following building blocks:

1. **[Configure Microsoft Entra Single Sign-On](#configure-azure-ad-single-sign-on)** - to enable your users to use this feature.
2. **[Configure Nexonia Single Sign-On](#configure-nexonia-single-sign-on)** - to configure the Single Sign-On settings on application side.
3. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
4. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
5. **[Create Nexonia test user](#create-nexonia-test-user)** - to have a counterpart of Britta Simon in Nexonia that's linked to the Microsoft Entra representation of user.
6. **[Test single sign-on](#test-single-sign-on)** - to verify whether the configuration works.

<a name='configure-azure-ad-single-sign-on'></a>

### Configure Microsoft Entra single sign-on

In this section, you enable Microsoft Entra single sign-on.

To configure Microsoft Entra single sign-on with Nexonia, perform the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Nexonia** application integration page, select **Single sign-on**.

    ![Configure single sign-on link](common/select-sso.png)

1. On the **Select a Single sign-on method** dialog, select **SAML/WS-Fed** mode to enable single sign-on.

    ![Single sign-on select mode](common/select-saml-option.png)

1. On the **Set up Single Sign-On with SAML** page, select **Edit** icon to open **Basic SAML Configuration** dialog.

	![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up Single Sign-On with SAML** page, perform the following steps:

    ![Nexonia Domain and URLs single sign-on information](common/idp-intiated.png)

    a. In the **Identifier** text box, type a URL:
    `Nexonia`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://system.nexonia.com/assistant/saml.do?orgCode=<organizationcode>`

	> [!NOTE]
	> The Reply URL value isn't real. Update the value with the actual Reply URL. Contact [Nexonia Client support team](https://nexonia.zendesk.com/hc/requests/new) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Nexonia** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

	a. Login URL

	b. Microsoft Entra Identifier

	c. Logout URL

### Configure Nexonia Single Sign-On

To configure single sign-on on **Nexonia** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Nexonia support team](https://nexonia.zendesk.com/hc/requests/new). They set this setting to have the SAML SSO connection set properly on both sides.

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

### Create Nexonia test user

In this section, you create a user called Britta Simon in Nexonia. Work with [Nexonia support team](https://nexonia.zendesk.com/hc/requests/new) to add the users in the Nexonia platform. Users must be created and activated before you use single sign-on.

### Test single sign-on 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Nexonia tile in the Access Panel, you should be automatically signed in to the Nexonia for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional Resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
