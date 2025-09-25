---
title: Configure Datto File Protection Single Sign On for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Datto File Protection Single Sign On.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Datto File Protection Single Sign On so that I can control who has access to Datto File Protection Single Sign On, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Datto File Protection Single Sign On for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Datto File Protection Single Sign On with Microsoft Entra ID. When you integrate Datto File Protection Single Sign On with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Datto File Protection Single Sign On.
* Enable your users to be automatically signed-in to Datto File Protection Single Sign On with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Datto File Protection Single Sign On enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Datto File Protection Single Sign On supports **SP** and **IDP** initiated SSO.

## Add Datto File Protection Single Sign On from the gallery

To configure the integration of Datto File Protection Single Sign On into Microsoft Entra ID, you need to add Datto File Protection Single Sign On from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Datto File Protection Single Sign On** in the search box.
1. Select **Datto File Protection Single Sign On** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-datto-file-protection-single-sign-on'></a>

## Configure and test Microsoft Entra SSO for Datto File Protection Single Sign On

Configure and test Microsoft Entra SSO with Datto File Protection Single Sign On using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Datto File Protection Single Sign On.

To configure and test Microsoft Entra SSO with Datto File Protection Single Sign On, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Datto File Protection Single Sign On SSO](#configure-datto-file-protection-single-sign-on-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Datto File Protection Single Sign On test user](#create-datto-file-protection-single-sign-on-test-user)** - to have a counterpart of B.Simon in Datto File Protection Single Sign On that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Datto File Protection Single Sign On** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **SP** initiated mode then perform the following steps:

    a. In the **Identifier** textbox, type the URL:
    `https://saml.fileprotection.datto.com/singlesignon/saml/metadata`

    b. In the **Reply URL** textbox, type the URL:
    `https://saml.fileprotection.datto.com/singlesignon/saml/SSO`

    c. In the **Sign on URL** textbox, type a URL using the following pattern:
    `https://<SUBDOMAIN>.fileprotection.datto.com`
    
    > [!NOTE]
	> This value isn't real. Update this value with the actual Sign on URL. Contact [Datto File Protection Single Sign On Client support team](mailto:ms-sso-support@ot.soonr.com) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Datto File Protection Single Sign On SSO

To configure single sign-on on **Datto File Protection Single Sign On** side, you need to send the **App Federation Metadata Url** to [Datto File Protection Single Sign On support team](mailto:ms-sso-support@ot.soonr.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Datto File Protection Single Sign On test user

In this section, you create a user called Britta Simon in Datto File Protection Single Sign On. Work with [Datto File Protection Single Sign On support team](mailto:ms-sso-support@ot.soonr.com) to add the users in the Datto File Protection Single Sign On platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Datto File Protection Single Sign On Sign on URL where you can initiate the login flow.  

* Go to Datto File Protection Single Sign On Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Datto File Protection Single Sign On for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Datto File Protection Single Sign On tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Datto File Protection Single Sign On for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Datto File Protection Single Sign On you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
