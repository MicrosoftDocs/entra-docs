---
title: Configure InformaCast for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and InformaCast.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and InformaCast so that I can control who has access to InformaCast, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure InformaCast for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate InformaCast with Microsoft Entra ID. When you integrate InformaCast with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to InformaCast.
* Enable your users to be automatically signed-in to InformaCast with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* InformaCast single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* InformaCast supports **SP and IDP** initiated SSO.
* InformaCast supports [Automated user provisioning](informacast-provisioning-tutorial.md).

## Add InformaCast from the gallery

To configure the integration of InformaCast into Microsoft Entra ID, you need to add InformaCast from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **InformaCast** in the search box.
1. Select **InformaCast** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-informacast'></a>

## Configure and test Microsoft Entra SSO for InformaCast

Configure and test Microsoft Entra SSO with InformaCast using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in InformaCast.

To configure and test Microsoft Entra SSO with InformaCast, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure InformaCast SSO](#configure-informacast-sso)** - to configure the single sign-on settings on application side.
    1. **[Create InformaCast test user](#create-informacast-test-user)** - to have a counterpart of B.Simon in InformaCast that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **InformaCast** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://admin.icmobile.singlewire.com`

1. Select **Save**.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure InformaCast SSO

To configure single sign-on on **InformaCast** side, you need to send the **App Federation Metadata Url** to [InformaCast support team](mailto:support@singlewire.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create InformaCast test user

In this section, you create a user called Britta Simon in InformaCast. Work with [InformaCast support team](mailto:support@singlewire.com) to add the users in the InformaCast platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

1. Select **Test this application**, this option redirects to InformaCast Sign on URL where you can initiate the login flow.  

1. Go to InformaCast Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the InformaCast for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the InformaCast tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the InformaCast for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure InformaCast you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
