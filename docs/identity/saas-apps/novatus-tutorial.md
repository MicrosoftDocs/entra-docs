---
title: Configure Novatus for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Novatus.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Novatus so that I can control who has access to Novatus, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Novatus for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Novatus with Microsoft Entra ID. When you integrate Novatus with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Novatus.
* Enable your users to be automatically signed-in to Novatus with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Novatus single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Novatus supports **SP** initiated SSO.

* Novatus supports **Just In Time** user provisioning.

## Add Novatus from the gallery

To configure the integration of Novatus into Microsoft Entra ID, you need to add Novatus from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Novatus** in the search box.
1. Select **Novatus** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-novatus'></a>

## Configure and test Microsoft Entra SSO for Novatus

Configure and test Microsoft Entra SSO with Novatus using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Novatus.

To configure and test Microsoft Entra SSO with Novatus, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    2. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
2. **[Configure Novatus SSO](#configure-novatus-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Novatus test user](#create-novatus-test-user)** - to have a counterpart of B.Simon in Novatus that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Novatus** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot showing the edit Basic SAML Configuration screen.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://sso.novatuscontracts.com/<companyname>`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [Novatus Client support team](mailto:jvinci@novatusinc.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Novatus** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Novatus SSO

To configure single sign-on on **Novatus** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Novatus support team](mailto:jvinci@novatusinc.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Novatus test user

In this section, a user called Britta Simon is created in Novatus. Novatus supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Novatus, a new one is created after authentication.

>[!NOTE]
>If you need to create a user manually, you need to contact the [Novatus support team](mailto:jvinci@novatusinc.com). 
> 

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Novatus Sign-on URL where you can initiate the login flow. 

* Go to Novatus Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Novatus tile in the My Apps, this option redirects to Novatus Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Novatus you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
