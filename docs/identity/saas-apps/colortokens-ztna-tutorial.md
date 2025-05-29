---
title: Configure ColorTokens ZTNA for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ColorTokens ZTNA.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ColorTokens ZTNA so that I can control who has access to ColorTokens ZTNA, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ColorTokens ZTNA for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ColorTokens ZTNA with Microsoft Entra ID. When you integrate ColorTokens ZTNA with Microsoft Entra ID, you can:

- Control in Microsoft Entra ID who has access to ColorTokens ZTNA.
- Enable your users to be automatically signed-in to ColorTokens ZTNA with their Microsoft Entra accounts.
- Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
- ColorTokens ZTNA single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

- ColorTokens ZTNA supports **SP** initiated SSO

## Adding ColorTokens ZTNA from the gallery

To configure the integration of ColorTokens ZTNA into Microsoft Entra ID, you need to add ColorTokens ZTNA from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ColorTokens ZTNA** in the search box.
1. Select **ColorTokens ZTNA** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-colortokens-ztna'></a>

## Configure and test Microsoft Entra SSO for ColorTokens ZTNA

Configure and test Microsoft Entra SSO with ColorTokens ZTNA using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ColorTokens ZTNA.

To configure and test Microsoft Entra SSO with ColorTokens ZTNA, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ColorTokens ZTNA SSO](#configure-colortokens-ztna-sso)** - to configure the single sign-on settings on application side.
   1. **[Create ColorTokens ZTNA test user](#create-colortokens-ztna-test-user)** - to have a counterpart of B.Simon in ColorTokens ZTNA that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ColorTokens ZTNA** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

   a. In the **Sign on URL** text box, type a URL using the following pattern:
   `https://<tenantname>.spectrum.colortokens.com`

   > [!NOTE]
   > These values aren't real. Update these values with the actual Sign on URL, Identifier and Reply URL. Contact [ColorTokens ZTNA Client support team](mailto:support@colortokens.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. ColorTokens ZTNA application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

   ![image](common/default-attributes.png)

1. In addition to above, ColorTokens ZTNA application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

   | Name       | Source Attribute       |
   | ---------- | ---------------------- |
   | department | user.userprincipalname |
   | Group      | user.groups            |

   > [!NOTE]
   > Select [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui) to know how to create roles in Microsoft Entra ID.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

   ![The Certificate download link](common/metadataxml.png)

1. On the **Set up ColorTokens ZTNA** section, copy the appropriate URL(s) based on your requirement.

   ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ColorTokens ZTNA SSO

To configure single sign-on on **ColorTokens ZTNA** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [ColorTokens ZTNA support team](mailto:support@colortokens.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ColorTokens ZTNA test user

In this section, you create a user called Britta Simon in ColorTokens ZTNA. Work with [ColorTokens ZTNA support team](mailto:support@colortokens.com) to add the users in the ColorTokens ZTNA platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

- Select **Test this application**, this option redirects to ColorTokens ZTNA Sign-on URL where you can initiate the login flow.

- Go to ColorTokens ZTNA Sign-on URL directly and initiate the login flow from there.

- You can use Microsoft My Apps. When you select the ColorTokens ZTNA tile in the My Apps, this option redirects to ColorTokens ZTNA Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure ColorTokens ZTNA you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
