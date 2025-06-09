---
title: Configure Secret Server (on-premises) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Secret Server (on-premises).
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Secret Server (On-Premises) so that I can control who has access to Secret Server (On-Premises), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Secret Server (on-premises) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Secret Server (on-premises) with Microsoft Entra ID. When you integrate Secret Server (on-premises) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Secret Server (on-premises).
* Enable your users to be automatically signed-in to Secret Server (on-premises) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Secret Server (on-premises) single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Secret Server (on-premises) supports **SP and IDP** initiated SSO.

## Add Secret Server (on-premises) from the gallery

To configure the integration of Secret Server (on-premises) into Microsoft Entra ID, you need to add Secret Server (on-premises) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Secret Server (On-Premises)** in the search box.
1. Select **Secret Server (On-Premises)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-secret-server-on-premises'></a>

## Configure and test Microsoft Entra SSO for Secret Server (on-premises)

Configure and test Microsoft Entra SSO with Secret Server (on-premises) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Secret Server (on-premises).

To configure and test Microsoft Entra SSO with Secret Server (on-premises), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Secret Server (On-Premises) SSO](#configure-secret-server-on-premises-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Secret Server (On-Premises) test user](#create-secret-server-on-premises-test-user)** - to have a counterpart of B.Simon in Secret Server (on-premises) that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Secret Server (On-Premises)** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type the URL:
    `https://secretserveronpremises.azure`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SecretServerURL>/SAML/AssertionConsumerService.aspx`

    > [!NOTE]
	> The Entity ID shown above is an example only and you're free to choose any unique value that identifies your Secret Server instance in Microsoft Entra ID. You need to send this Entity ID to [Secret Server (On-Premises) Client support team](https://support.delinea.com/s/) and they configure it on their side. For more details, please read [this article](https://docs.delinea.com/online-help/library/start.htm).

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SecretServerURL>/login.aspx`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Reply URL and Sign-On URL. Contact [Secret Server (On-Premises) Client support team](https://support.delinea.com/s/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Single Sign-On with SAML** page, select the **Edit** icon to open **SAML Signing Certificate** dialog.

    ![Screenshot that shows the "S A M L Signing Certificate" section with the "Certificate (Base64" "Download" action selected.)](./media/secretserver-on-premises-tutorial/edit-saml-signon.png)

1. Select **Signing Option** as **Sign SAML response and assertion**.

    ![Signing options](./media/secretserver-on-premises-tutorial/signing-option.png)

1. On the **Set up Secret Server (On-Premises)** section, copy one or more appropriate URLs based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Secret Server (on-premises) SSO

To configure single sign-on on the **Secret Server (On-Premises)** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs to the [Secret Server (on-premises) support team](https://support.delinea.com/s/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Secret Server (on-premises) test user

In this section, you create a user called Britta Simon in Secret Server (on-premises). Work with [Secret Server (on-premises) support team](https://support.delinea.com/s/) to add the users in the Secret Server (on-premises) platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Secret Server (on-premises) Sign-on URL where you can initiate the sign-in flow.  

* Go to Secret Server (on-premises) Sign on URL directly and initiate the sign-in flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Secret Server (on-premises) for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Secret Server (on-premises) tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the sign-in flow and if configured in IDP mode, you should be automatically signed in to the Secret Server (on-premises) for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Secret Server (on-premises) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
