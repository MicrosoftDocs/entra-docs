---
title: Configure Float for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Float.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Float so that I can control who has access to Float, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Float for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Float with Microsoft Entra ID. When you integrate Float with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Float.
* Enable your users to be automatically signed-in to Float with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Float subscription. If you don't have a subscription, you can get a [free account](https://app.float.com/join?).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Float supports **SP and IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Float from the gallery

To configure the integration of Float into Microsoft Entra ID, you need to add Float from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Float** in the search box.
1. Select **Float** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-float'></a>

## Configure and test Microsoft Entra SSO for Float

Configure and test Microsoft Entra SSO with Float using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Float.

To configure and test Microsoft Entra SSO with Float, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Float SSO](#configure-float-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Float test user](#create-float-test-user)** - to have a counterpart of B.Simon in Float that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Float** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type the URL: `https://app.float.com/sso/metadata`.

    b. In the **Reply URL** text box, type a URL using the following pattern: `https://<HOSTNAME>.float.com/sso/azuread`.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern: `https://<HOSTNAME>.float.com/login`.

    > [!NOTE]
    > These values aren't real. Update these values with the actual Reply URL and Sign-on URL. Replace \<hostname\> with your Float hostname. Contact [Float Client support team](mailto:support@float.com) if you're unsure. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Float application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

    ![image](common/default-attributes.png)

1. In addition to above, Float application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
    
    | Name | Source Attribute|
    | ---------------| --------- |
    | email | user.userprincipalname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Float** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Float SSO

To configure single sign-on on **Float** side, visit the Float Team Settings section and select Configure from the Authentication module. Paste the Microsoft Entra Login URL in the SAML 2.0 Endpoint URL field, paste the Microsoft Entra Identifier in the Identity Provider Issuer URL field, paste the full text from the downloaded **Certificate (Base64)** in the X.509 Certificate field, and Save.

### Create Float test user

In this section, create a user called Britta Simon in Float. Add the user from the People section or Team Settings Guest section, and grant them an access right. Users must be created and accept the invitation before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Float Sign on URL where you can initiate the login flow.  

* Go to Float Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Float for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Float tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Float for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Float you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
