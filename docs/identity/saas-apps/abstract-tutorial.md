---
title: Configure Abstract for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Abstract.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Abstract so that I can control who has access to Abstract, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Abstract for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Abstract with Microsoft Entra ID. When you integrate Abstract with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Abstract.
* Enable your users to be automatically signed-in to Abstract with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Abstract single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Abstract supports **SP and IDP** initiated SSO.

## Add Abstract from the gallery

To configure the integration of Abstract into Microsoft Entra ID, you need to add Abstract from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Abstract** in the search box.
1. Select **Abstract** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-abstract'></a>

## Configure and test Microsoft Entra SSO for Abstract

Configure and test Microsoft Entra SSO with Abstract using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Abstract.

To configure and test Microsoft Entra SSO with Abstract, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Abstract SSO](#configure-abstract-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Abstract test user](#create-abstract-test-user)** - to have a counterpart of B.Simon in Abstract that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Abstract** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section the application is pre-configured in **IDP** initiated mode and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://app.abstract.com/signin`

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

    ![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Abstract SSO

Make sure to retrieve your `App Federation Metadata Url` and the `Azure AD Identifier`, as you need those to configure SSO on Abstract.

You find that information on the **Set up Single Sign-On with SAML** page:

* The `App Federation Metadata Url` is located in the **SAML Signing Certificate** section.
* The `Azure AD Identifier` is located in the **Set up Abstract** section.

You're now ready to configure SSO on Abstract:

>[!Note]
>you need to authenticate with an organization Admin account to access the SSO settings on Abstract.

1. Open the [Abstract web app](https://app.abstract.com/).
2. Go to the **Permissions** page in the left side bar.
3. In the **Configure SSO** section, enter your **Metadata URL** and **Entity ID**.
4. Enter any manual exceptions you might have. Emails listed in the manual exceptions section bypass SSO and be able to log in with email and password. 
5. Select **Save Changes**.

>[!Note] 
>You’ll need to use primary email addresses in the manual exceptions list. SSO activation fails if the email you list is a user’s secondary email. If that happens, you’ll see an error message with the primary email for the failing account. Add that primary email to the manual exceptions list after you’ve verified you know the user.

### Create Abstract test user

To test SSO on Abstract:

1. Open the [Abstract web app](https://app.abstract.com/).
2. Go to the **Permissions** page in the left side bar.
3. Select **Test with my Account**. If the test fails, please [contact our support team](https://help.abstract.com/hc/).

>[!Note]
>you need to authenticate with an organization Admin account to access the SSO settings on Abstract. This organization Admin account needs to be assigned to Abstract.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Abstract Sign on URL where you can initiate the login flow.  

* Go to Abstract Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Abstract for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Abstract tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Abstract for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Abstract you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
