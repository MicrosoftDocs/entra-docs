---
title: Configure Explanation-Based Auditing System for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Explanation-Based Auditing System.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Explanation-Based Auditing System so that I can control who has access to Explanation-Based Auditing System, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Explanation-Based Auditing System for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Explanation-Based Auditing System with Microsoft Entra ID.
Integrating Explanation-Based Auditing System with Microsoft Entra ID provides you with the following benefits:

* You can control in Microsoft Entra ID who has access to Explanation-Based Auditing System.
* You can enable your users to be automatically signed-in to Explanation-Based Auditing System (Single Sign-On) with their Microsoft Entra accounts.
* You can manage your accounts in one central location.

If you want to know more details about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).
If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Explanation-Based Auditing System single sign-on enabled subscription

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Explanation-Based Auditing System supports **SP** initiated SSO

* Explanation-Based Auditing System supports **just-in-time** user Provisioning 

## Adding Explanation-Based Auditing System from the gallery

To configure the integration of Explanation-Based Auditing System into Microsoft Entra ID, you need to add Explanation-Based Auditing System from the gallery to your list of managed SaaS apps.

**To add Explanation-Based Auditing System from the gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the search box, type **Explanation-Based Auditing System**, select **Explanation-Based Auditing System** from result panel then select **Add** button to add the application.

	 ![Explanation-Based Auditing System in the results list](common/search-new-app.png)

<a name='configure-and-test-azure-ad-single-sign-on'></a>

## Configure and test Microsoft Entra single sign-on

In this section, you configure and test Microsoft Entra single sign-on with Explanation-Based Auditing System based on a test user called **Britta Simon**.
For single sign-on to work, a link relationship between a Microsoft Entra user and the related user in Explanation-Based Auditing System needs to be established.

To configure and test Microsoft Entra single sign-on with Explanation-Based Auditing System, you need to complete the following building blocks:

1. **[Configure Microsoft Entra Single Sign-On](#configure-azure-ad-single-sign-on)** - to enable your users to use this feature.
2. **[Configure Explanation-Based Auditing System Single Sign-On](#configure-explanation-based-auditing-system-single-sign-on)** - to configure the Single Sign-On settings on application side.
3. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
4. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
5. **[Create Explanation-Based Auditing System test user](#create-explanation-based-auditing-system-test-user)** - to have a counterpart of Britta Simon in Explanation-Based Auditing System that's linked to the Microsoft Entra representation of user.
6. **[Test single sign-on](#test-single-sign-on)** - to verify whether the configuration works.

<a name='configure-azure-ad-single-sign-on'></a>

### Configure Microsoft Entra single sign-on

In this section, you enable Microsoft Entra single sign-on.

To configure Microsoft Entra single sign-on with Explanation-Based Auditing System, perform the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Explanation-Based Auditing System** application integration page, select **Single sign-on**.

    ![Configure single sign-on link](common/select-sso.png)

1. On the **Select a Single sign-on method** dialog, select **SAML/WS-Fed** mode to enable single sign-on.

    ![Single sign-on select mode](common/select-saml-option.png)

1. On the **Set up Single Sign-On with SAML** page, select **Edit** icon to open **Basic SAML Configuration** dialog.

	![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    ![Explanation-Based Auditing System Domain and URLs single sign-on information](common/sp-signonurl.png)

    In the **Sign-on URL** text box, type a URL:
    `https://ebas.maizeanalytics.com`

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

### Configure Explanation-Based Auditing System Single Sign-On

To configure single sign-on on **Explanation-Based Auditing System** side, you need to send the **App Federation Metadata Url** to [Explanation-Based Auditing System support team](mailto:support@maizeanalytics.com). They set this setting to have the SAML SSO connection set properly on both sides.

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

### Create Explanation-Based Auditing System test user

In this section, a user called Britta Simon is created in Explanation-Based Auditing System. Explanation-Based Auditing System supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Explanation-Based Auditing System, a new one is created after authentication.

### Test single sign-on 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Explanation-Based Auditing System tile in the Access Panel, you should be automatically signed in to the Explanation-Based Auditing System for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional Resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
