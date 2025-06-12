---
title: Configure HyperAnna for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and HyperAnna.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and HyperAnna so that I can control who has access to HyperAnna, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure HyperAnna for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate HyperAnna with Microsoft Entra ID. When you integrate HyperAnna with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to HyperAnna.
* Enable your users to be automatically signed-in to HyperAnna with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* HyperAnna single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* HyperAnna supports **SP and IDP** initiated SSO

## Adding HyperAnna from the gallery

To configure the integration of HyperAnna into Microsoft Entra ID, you need to add HyperAnna from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **HyperAnna** in the search box.
1. Select **HyperAnna** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-single-sign-on'></a>

## Configure and test Microsoft Entra single sign-on

Configure and test Microsoft Entra SSO with HyperAnna using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in HyperAnna.

To configure and test Microsoft Entra SSO with HyperAnna, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
2. **[Configure HyperAnna SSO](#configure-hyperanna-sso)** - to configure the Single Sign-On settings on application side.
3. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
4. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
5. **[Create HyperAnna test user](#create-hyperanna-test-user)** - to have a counterpart of Britta Simon in HyperAnna that's linked to the Microsoft Entra representation of user.
6. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

### Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **HyperAnna** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    In the **Reply URL** text box, type a URL using any one of the following pattern:

    ```http
    https://microsoft.hyperanna.com/userservice/auth/saml
    https://anna.hyperanna.com/userservice/auth/saml
    ```

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using any one of the following pattern:

    ```http
    https://microsoft.hyperanna.com/
    https://anna.hyperanna.com/
    ```

4. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up HyperAnna** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

### Configure HyperAnna SSO

To configure single sign-on on **HyperAnna** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [HyperAnna support team](mailto:support@hyperanna.com). They set this setting to have the SAML SSO connection set properly on both sides.
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

### Create HyperAnna test user

In this section, you create a user called Britta Simon in HyperAnna. Work with [HyperAnna support team](mailto:support@hyperanna.com) to add the users in the HyperAnna platform. Users must be created and activated before you use single sign-on.

### Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the HyperAnna tile in the Access Panel, you should be automatically signed in to the HyperAnna for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
