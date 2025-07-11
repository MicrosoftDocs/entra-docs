---
title: Configure ExpenseMe Pro (by Inlogik) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ExpenseMe Pro (by Inlogik).

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/03/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ProMaster (by Inlogik) so that I can control who has access to ProMaster (by Inlogik), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure ExpenseMe Pro (by Inlogik) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ExpenseMe Pro (by Inlogik) with Microsoft Entra ID. When you integrate ExpenseMe Pro (by Inlogik) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ExpenseMe Pro (by Inlogik).
* Enable your users to be automatically signed-in to ExpenseMe Pro (by Inlogik) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ExpenseMe Pro (by Inlogik) single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* ExpenseMe Pro (by Inlogik) supports **SP** and **IDP** initiated SSO.

## Add ExpenseMe Pro (by Inlogik) from the gallery

To configure the integration of ExpenseMe Pro (by Inlogik) into Microsoft Entra ID, you need to add ExpenseMe Pro (by Inlogik) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ExpenseMe Pro (by Inlogik)** in the search box.
1. Select **ExpenseMe Pro (by Inlogik)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-expenseme-pro-by-inlogik'></a>

## Configure and test Microsoft Entra SSO for ExpenseMe Pro (by Inlogik)

Configure and test Microsoft Entra SSO with ExpenseMe Pro (by Inlogik) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ExpenseMe Pro (by Inlogik).

To configure and test Microsoft Entra SSO with ExpenseMe Pro (by Inlogik), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ExpenseMe Pro (by Inlogik) SSO](#configure-expenseme-pro-by-inlogik-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ExpenseMe Pro (by Inlogik) test user](#create-expenseme-pro-by-inlogik-test-user)** - to have a counterpart of B.Simon in ExpenseMe Pro (by Inlogik) that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ExpenseMe Pro (by Inlogik)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://secure.inlogik.com/<COMPANYNAME>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://secure.inlogik.com/<COMPANYNAME>/saml/acs`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL (Optional)** text box, type a URL using the following pattern:
    `https://secure.inlogik.com/<COMPANYNAME>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [ExpenseMe Pro (by Inlogik) support team](https://www.inlogik.com/contact) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ExpenseMe Pro (by Inlogik) SSO

To configure single sign-on on **ExpenseMe Pro (by Inlogik)** side, you need to send the **App Federation Metadata Url** to [ExpenseMe Pro (by Inlogik) support team](https://www.inlogik.com/contact). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ExpenseMe Pro (by Inlogik) test user

In this section, you create a user called B.Simon in ExpenseMe Pro (by Inlogik). Work with [ExpenseMe Pro (by Inlogik) support team](https://www.inlogik.com/contact) to add the users in the ExpenseMe Pro (by Inlogik) platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to ExpenseMe Pro (by Inlogik) Sign on URL where you can initiate the login flow.  

* Go to ExpenseMe Pro (by Inlogik) Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the ExpenseMe Pro (by Inlogik) for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the ExpenseMe Pro (by Inlogik) tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the ExpenseMe Pro (by Inlogik) for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ExpenseMe Pro (by Inlogik) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).