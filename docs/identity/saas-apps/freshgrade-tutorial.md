---
title: Configure FreshGrade for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FreshGrade.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FreshGrade so that I can control who has access to FreshGrade, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure FreshGrade for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FreshGrade with Microsoft Entra ID. When you integrate FreshGrade with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to FreshGrade.
* Enable your users to be automatically signed-in to FreshGrade with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* FreshGrade single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* FreshGrade supports **SP** initiated SSO.

## Add FreshGrade from the gallery

To configure the integration of FreshGrade into Microsoft Entra ID, you need to add FreshGrade from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **FreshGrade** in the search box.
1. Select **FreshGrade** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-freshgrade'></a>

## Configure and test Microsoft Entra SSO for FreshGrade

Configure and test Microsoft Entra SSO with FreshGrade using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in FreshGrade.

To configure and test Microsoft Entra SSO with FreshGrade, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure FreshGrade SSO](#configure-freshgrade-sso)** - to configure the single sign-on settings on application side.
    1. **[Create FreshGrade test user](#create-freshgrade-test-user)** - to have a counterpart of B.Simon in FreshGrade that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FreshGrade** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier (Entity ID)** textbox, type a URL using one of the following patterns:

	| **Identifier** |
    |-------------|
    |`https://login.onboarding.freshgrade.com:443/saml/metadata/alias/<instancename>`|
    |`https://login.freshgrade.com:443/saml/metadata/alias/<instancename>`|

    b. In the **Sign-on URL** textbox, type a URL using one of the following patterns:
    
    | **Sign-on URL** |
    |------------|
    |`https://<subdomain>.freshgrade.com/login`|
    |`https://<subdomain>.onboarding.freshgrade.com/login`|

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [FreshGrade Client support team](mailto:support@freshgrade.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure FreshGrade SSO

To configure single sign-on on **FreshGrade** side, you need to send the **App Federation Metadata Url** to [FreshGrade support team](mailto:support@freshgrade.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create FreshGrade test user

In this section, you create a user called Britta Simon in FreshGrade. Work with [FreshGrade support team](mailto:support@freshgrade.com) to add the users in the FreshGrade platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to FreshGrade Sign-on URL where you can initiate the login flow. 

* Go to FreshGrade Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the FreshGrade tile in the My Apps, this option redirects to FreshGrade Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure FreshGrade you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
