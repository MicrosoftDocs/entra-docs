---
title: Configure Freight Audit for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Freight Audit.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 04/19/2024
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Freight Audit so that I can control who has access to Freight Audit, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Freight Audit for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Freight Audit with Microsoft Entra ID. When you integrate Freight Audit with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Freight Audit.
* Enable your users to be automatically signed-in to Freight Audit with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Freight Audit single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Freight Audit supports **IDP** initiated SSO.
* Freight Audit supports **Just In Time** user provisioning.

## Add Freight Audit from the gallery

To configure the integration of Freight Audit into Microsoft Entra ID, you need to add Freight Audit from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Freight Audit** in the search box.
1. Select **Freight Audit** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Freight Audit

Configure and test Microsoft Entra SSO with Freight Audit using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Freight Audit.

To configure and test Microsoft Entra SSO with Freight Audit, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Freight Audit SSO](#configure-freight-audit-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Freight Audit test user](#create-freight-audit-test-user)** - to have a counterpart of B.Simon in Freight Audit that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Freight Audit** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

   1. In the **Identifier** text box, type a URL using the following pattern:

    `https://login.controlpay.com/identifier/saml2/<company>` or any other value Freight Audit has suggested.

   1. In the **Reply URL** text box, type a URL using the following pattern:

    `https://login.controlpay.com/reply/saml2/<company>` or any other value Freight Audit has suggested.

    > [!NOTE]
	> These values aren't real. Update these values with actual Identifier and Reply URL. Contact [Freight Audit support team](mailto:tp_fa_sso-ug@trimble.com) to get the values. You can also refer to the patterns shown in the Basic SAML Configuration section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Freight Audit SSO

To configure single sign-on on **Freight Audit** side, you need to send the **App Federation Metadata Url** to [Freight Audit support team](mailto:tp_fa_sso-ug@trimble.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Freight Audit test user

In this section, a user called Britta Simon is created in Freight Audit. Freight Audit supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Freight Audit, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select Test this application in Microsoft Entra admin center and you should be automatically signed in to the Freight Audit for which you set up the SSO.
 
* You can use Microsoft My Apps. When you select the Freight Audit tile in the My Apps, you should be automatically signed in to the Freight Audit for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Freight Audit you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).