---
title: Configure Beeline Enterprise for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Beeline Enterprise.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 08/29/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Beeline Enterprise so that I can control who has access to Beeline Enterprise, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Beeline Enterprise for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Beeline Enterprise with Microsoft Entra ID. When you integrate Beeline Enterprise with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Beeline Enterprise.
* Enable your users to be automatically signed-in to Beeline Enterprise with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Beeline Enterprise single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Beeline Enterprise supports **SP** and **IDP** initiated SSO.

## Add Beeline Enterprise from the gallery

To configure the integration of Beeline Enterprise into Microsoft Entra ID, you need to add Beeline Enterprise from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Browse Microsoft Entra Gallery** section, type **Beeline Enterprise** in the search box.
1. Select **Beeline Enterprise** from the results panel and then select **Create**. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-beeline'></a>

## Configure and test Microsoft Entra SSO for Beeline Enterprise

Configure and test Microsoft Entra SSO with Beeline Enterprise using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Beeline Enterprise.

To configure and test Microsoft Entra SSO with Beeline Enterprise, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Beeline Enterprise SSO](#configure-beeline-enterprise-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Beeline Enterprise test user](#create-beeline-enterprise-test-user)** - to have a counterpart of B.Simon in Beeline that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Beeline Enterprise** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `urn:auth0:<Auth0TenantName>:<CustomerName>-SSO`

    b. In the **Reply URL** text box, type a URL using the following pattern: 
    `https://<Auth0TenantName>.<Auth0Environment>.beeline.com/login/callback?connection=<CustomerName>-SSO`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<Environment>.beeline.com/<CustomerName>/security/auth0/auth0spinitiatedssohandler.ashx`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Beeline Enterprise support team](mailto:support@beeline.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Select **Save**.

1. The Beeline Enterprise application expects the SAML assertions in a specific format. Please work with [Beeline Enterprise support team](mailto:support@beeline.com) first to identify the correct user identifier which is mapped into the application. Also please take the guidance from [Beeline Enterprise support team](mailto:support@beeline.com) about the attribute which they want to use for this mapping. You can manage the value of this attribute from the **User Attributes** tab of the application. The following screenshot shows an example for this. Here we have mapped the **User Identifier** claim with the **userprincipalname** attribute, which provides unique user ID, which is sent to the Beeline Enterprise application in every successful SAML response.

    ![Screenshot shows the image of default attributes.](common/edit-attribute.png "Image")

1. Browse to **Entra ID** > **Enterprise apps** > **Beeline Enterprise** > **Manage** > **Single sign-on**.
1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. In the **Set up Beeline Enterprise** section, copy the **Login URL** and **Logout URL**.
    
    ![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Beeline Enterprise SSO

To configure single sign-on on **Beeline Enterprise** side, you need to send the following items that you gathered from a step earlier in this article to the [Beeline Enterprise support team](mailto:support@beeline.com). They will configure single sign-on on the **Beeline Enterprise** side.

* **Certificate (Base64)**
* **Login URL**
* **Logout URL**

### Create Beeline Enterprise test user

In this section, you create a user, Britta Simon, in Beeline Enterprise. The Beeline Enterprise application needs all users to be provisioned in the application before doing Single Sign On. So work with the [Beeline Enterprise support team](mailto:support@beeline.com) to provision all these users into the application.

## Test SSO

In this section, you have two different ways to test your Microsoft Entra single sign-on configuration.

* Browse to **Entra ID** > **Enterprise apps** > **Beeline Enterprise** > **Manage** > **Single sign-on**. Select **Test this application**, and you should be automatically signed in to the Beeline Enterprise for which you set up the SSO.

* You can use Microsoft My Apps. When you select the **Beeline Enterprise** tile in **My Apps**, you should be automatically signed in to the Beeline Enterprise site for which you set up the SSO. For more information about the My Apps portal, see [Introduction to the My Apps portal](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Beeline Enterprise you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).