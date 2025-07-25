---
title: Configure Central Desktop for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Central Desktop.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 06/19/2024
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Central Desktop so that I can control who has access to Central Desktop, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Central Desktop for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Central Desktop with Microsoft Entra ID. When you integrate Central Desktop with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Central Desktop.
* Enable your users to be automatically signed-in to Central Desktop with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Central Desktop single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Central Desktop supports **SP** initiated SSO.

## Add Central Desktop from the gallery

To configure the integration of Central Desktop into Microsoft Entra ID, you need to add Central Desktop from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Central Desktop** in the search box.
1. Select **Central Desktop** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-central-desktop'></a>

## Configure and test Microsoft Entra SSO for Central Desktop

Configure and test Microsoft Entra SSO with Central Desktop using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Central Desktop.

To configure and test Microsoft Entra SSO with Central Desktop, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Central Desktop SSO](#configure-central-desktop-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Central Desktop test user](#create-central-desktop-test-user)** - to have a counterpart of B.Simon in Central Desktop that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Central Desktop** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** box, type a URL using one of the following patterns:

    | **Identifier** |
    |-------|
    | `https://<companyname>.centraldesktop.com/saml2-metadata.php` |
    | `https://<companyname>.imeetcentral.com/saml2-metadata.php` |

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<companyname>.centraldesktop.com/saml2-assertion.php`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<companyname>.centraldesktop.com`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier,Reply URL and Sign on URL. Contact [Central Desktop support team](https://www.centraldesktop.com/contact) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Raw)** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/certificateraw.png)

6. On the **Set up Central Desktop** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Central Desktop SSO

1. Sign in to your **Central Desktop** tenant.

2. Go to **Settings**. Select **Advanced**, and then select **Single Sign On**.

    ![Setup - Advanced.](./media/central-desktop-tutorial/settings.png "Setup - Advanced")

3. On the **Single Sign On Settings** page, perform the following steps:

    ![Single sign-on settings.](./media/central-desktop-tutorial/configuration.png "Single Sign On Settings")

    a. Select **Enable SAML v2 Single Sign On**.

    b. In the **SSO URL** box, paste the **Microsoft Entra Identifier** value that you copied.

    c. In the **SSO Login URL** box, paste the **Login URL** value that you copied.

    d. In the **SSO Logout URL** box, paste the **Logout URL** value that you copied.

4. In the **Message Signature Verification Method** section, perform the following steps:

    ![Message signature verification method](./media/central-desktop-tutorial/certificate.png "Message Signature Verification Method")

    a. Select **Certificate**.

    b. In the **SSO Certificate** list, select **RSH SHA256**.

    c. Open your downloaded certificate in Notepad. Then copy the content of certificate and paste it into the **SSO Certificate** field.

    d. Select **Display a link to your SAMLv2 login page**.

    e. Select **Update**.

### Create Central Desktop test user

For Microsoft Entra users to be able to sign in, they must be provisioned in the Central Desktop application. This section describes how to create Microsoft Entra user accounts in Central Desktop.

> [!NOTE]
> To provision Microsoft Entra user accounts, you can use any other Central Desktop user account creation tools or APIs that are provided by Central Desktop.

**To provision user accounts to Central Desktop:**

1. Sign in to your Central Desktop tenant.

2. Select **People** and then select **Add Internal Members**.

    ![People.](./media/central-desktop-tutorial/members.png "People")

3. In the **Email Address of New Members** box, type a Microsoft Entra account that you want to provision, and then select **Next**.

    ![Email addresses of new members.](./media/central-desktop-tutorial/add-members.png "Email addresses of new members")

4. Select **Add Internal member(s)**.

    ![Add internal member.](./media/central-desktop-tutorial/account.png "Add internal member")

   > [!NOTE]
   > The users that you add receive an email that includes a confirmation link for activating their accounts.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Central Desktop Sign-on URL where you can initiate the login flow. 

* Go to Central Desktop Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Central Desktop tile in the My Apps, this option redirects to Central Desktop Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Central Desktop you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
