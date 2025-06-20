---
title: Configure Coverity Static Application Security Testing for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Coverity Static Application Security Testing.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Coverity Static Application Security Testing so that I can control who has access to Coverity Static Application Security Testing, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Coverity Static Application Security Testing for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Coverity Static Application Security Testing with Microsoft Entra ID. When you integrate Coverity Static Application Security Testing with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Coverity Static Application Security Testing.
* Enable your users to be automatically signed-in to Coverity Static Application Security Testing with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Coverity Static Application Security Testing single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Coverity Static Application Security Testing supports **SP and IDP** initiated SSO.

## Add Coverity Static Application Security Testing from the gallery

To configure the integration of Coverity Static Application Security Testing into Microsoft Entra ID, you need to add Coverity Static Application Security Testing from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Coverity Static Application Security Testing** in the search box.
1. Select **Coverity Static Application Security Testing** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-coverity-static-application-security-testing'></a>

## Configure and test Microsoft Entra SSO for Coverity Static Application Security Testing

Configure and test Microsoft Entra SSO with Coverity Static Application Security Testing using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Coverity Static Application Security Testing.

To configure and test Microsoft Entra SSO with Coverity Static Application Security Testing, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Coverity Static Application Security Testing SSO](#configure-coverity-static-application-security-testing-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Coverity Static Application Security Testing test user](#create-coverity-static-application-security-testing-test-user)** - to have a counterpart of B.Simon in Coverity Static Application Security Testing that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Coverity Static Application Security Testing** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps: 

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<COVERITYURL>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<COVERITYURL>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<COVERITYURL>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Coverity Static Application Security Testing Client support team](mailto:software-integrity-support@synopsys.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (PEM)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificate-base64-download.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Coverity Static Application Security Testing SSO

To configure single sign-on on **Coverity Static Application Security Testing** side, you need to send the downloaded **Certificate (PEM)** and appropriate copied URLs from the application configuration to [Coverity Static Application Security Testing support team](mailto:software-integrity-support@synopsys.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Coverity Static Application Security Testing test user

In this section, you create a user called Britta Simon in Coverity Static Application Security Testing. Work with [Coverity Static Application Security Testing support team](mailto:software-integrity-support@synopsys.com) to add the users in the Coverity Static Application Security Testing platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Coverity Static Application Security Testing Sign on URL where you can initiate the login flow.  

* Go to Coverity Static Application Security Testing Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Coverity Static Application Security Testing for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Coverity Static Application Security Testing tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Coverity Static Application Security Testing for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Coverity Static Application Security Testing you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
