---
title: Configure AlexisHR for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and AlexisHR.
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 09/01/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and AlexisHR so that I can control who has access to AlexisHR, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure AlexisHR for Single sign-on with Microsoft Entra ID

In this article, you learn how to integrate AlexisHR with Microsoft Entra ID. When you integrate AlexisHR with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to AlexisHR.
* Enable your users to be automatically signed-in to AlexisHR with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* AlexisHR single sign-on (SSO) enabled subscription.

## Scenario description

In this article, you configure and test SAML SSO between Microsoft Entra ID and AlexisHR in a test environment.

* AlexisHR supports **IdP-initiated** SSO.
* You will first create a **basic (mock) SAML configuration** in Microsoft Entra ID to obtain the Login URL and certificate, then configure SSO in AlexisHR, and finally return to Microsoft Entra ID to update the Identifier and Reply URL with the real values from AlexisHR.

## Add AlexisHR from the gallery

To configure the integration of AlexisHR into Microsoft Entra ID, you need to add AlexisHR from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
2. Browse to **Microsoft Entra ID** > **Enterprise applications** > **New application**.
3. In the **Add from the gallery** section, type **AlexisHR** in the search box.
4. Select **AlexisHR** from the results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-alexishr'></a>

## Configure and test Microsoft Entra SSO for AlexisHR

Configure and test Microsoft Entra SSO with AlexisHR using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in AlexisHR.

To configure and test Microsoft Entra SSO with AlexisHR, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** – to enable your users to use this feature.
2. **[Create and assign a Microsoft Entra test user](#create-an-azure-ad-test-user)** – to validate single sign-on.
3. **[Configure AlexisHR SSO](#configure-alexishr-sso)** – to configure single sign-on in AlexisHR.
4. **[Update Microsoft Entra SSO with real values](#update-azure-ad-sso)** – to replace the placeholder values with real ones.
5. **[Test SSO](#test-sso)** – to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO (initial mock setup)

Follow these steps to enable Microsoft Entra SSO with temporary values.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
2. Browse to **Microsoft Entra ID** > **Enterprise applications** > **AlexisHR** > **Single sign-on**.
3. On the **Select a single sign-on method** page, select **SAML**.
4. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

5. In the **Basic SAML Configuration** section, enter **placeholder values** for the first setup:
   - **Identifier (Entity ID)**: `urn:auth0:alexishr:<YOUR_CONNECTION_NAME>`
   - **Reply URL (Assertion Consumer Service URL)**: `https://auth.alexishr.com/login/callback?connection=<YOUR_CONNECTION_NAME>`

   Example:
   - Company: `acme`
   - Date: `20250901`
   - Identifier: `urn:auth0:alexishr:acme-20250901`
   - Reply URL: `https://auth.alexishr.com/login/callback?connection=acme-20250901`

   > [!NOTE]
   > These values are placeholders only. After you configure AlexisHR SSO, you'll return to this page and replace them with the real **Audience URI** and **Assertion Consumer Service URL** values provided by AlexisHR.

6. In the **Attributes & Claims** section, set **Name ID format** to **Email address** and ensure the **Name ID** value is **user.email**.

7. In the **SAML Signing Certificate** section, select **Certificate (Base64)** and **Download**. This file has *.cer extension and is PEM-encoded and will be needed later during the AlexisHR setup.

8. In the **Set up AlexisHR** section, copy the **Login URL** and **Logout URL** values. These values will also be needed in the AlexisHR setup.

> [!IMPORTANT]
> Testing will only work **after** you complete the AlexisHR setup and update the Identifier and Reply URL in Microsoft Entra ID with the real values.

<a name='create-an-azure-ad-test-user'></a>

## Create and assign a Microsoft Entra test user

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

<a name='configure-alexishr-sso'></a>

## Configure AlexisHR SSO

1. Log in to your AlexisHR company site as an administrator.
2. Go to **Settings** > **SAML Single sign-on** and select **New identity provider**.
3. In the **New identity provider** section:
   - **Identity provider SSO URL**: paste the **Login URL** from Microsoft Entra ID.
   - **Identity provider sign out URL**: paste the **Logout URL** from Microsoft Entra ID.
   - **Public x509 certificate**: open the downloaded **Certificate (Base64)** file in a text editor and paste the **entire PEM content** (including the `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----` lines) without modifying any line breaks.
4. Select **Create identity provider**.
5. After creating the identity provider, AlexisHR provides:
   - **Audience URI**
   - **Assertion Consumer Service URL**  
   These values will be used to update Microsoft Entra ID.

<a name='update-azure-ad-sso'></a>

## Update Microsoft Entra SSO with real values

1. Return to **Microsoft Entra admin center** > **Enterprise applications** > **AlexisHR** > **Single sign-on**.
2. Edit the **Basic SAML Configuration** section.
3. Replace the temporary placeholder values with:
   - **Identifier (Entity ID)**: paste **Audience URI** from AlexisHR.
   - **Reply URL (Assertion Consumer Service URL)**: paste **Assertion Consumer Service URL** from AlexisHR.
4. Save the changes.

<a name='create-alexishr-test-user'></a>

## Create AlexisHR test user

1. Work with [AlexisHR support team](mailto:support@alexishr.com) to add a test user (for example, Britta Simon) in the AlexisHR platform.
2. Ensure the user is created and activated before testing single sign-on.

<a name='test-sso'></a>

## Test SSO

1. In the **Microsoft Entra admin center**, go to the **AlexisHR** app and select **Test this application**. You should be automatically signed in to AlexisHR.
2. Alternatively, open [My Apps](https://myapps.microsoft.com), select the **AlexisHR** tile, and confirm that you are automatically signed in. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure AlexisHR you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
