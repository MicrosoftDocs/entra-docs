---
title: Configure OrgVitality SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and OrgVitality SSO.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and OrgVitality SSO so that I can control who has access to OrgVitality SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure OrgVitality SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate OrgVitality SSO with Microsoft Entra ID. When you integrate OrgVitality SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to OrgVitality SSO.
* Enable your users to be automatically signed-in to OrgVitality SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* OrgVitality SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* OrgVitality SSO supports **IDP** initiated SSO.

## Add OrgVitality SSO from the gallery

To configure the integration of OrgVitality SSO into Microsoft Entra ID, you need to add OrgVitality SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **OrgVitality SSO** in the search box.
1. Select **OrgVitality SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-orgvitality-sso'></a>

## Configure and test Microsoft Entra SSO for OrgVitality SSO

Configure and test Microsoft Entra SSO with OrgVitality SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in OrgVitality SSO.

To configure and test Microsoft Entra SSO with OrgVitality SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure OrgVitality SSO](#configure-orgvitality-sso)** - to configure the single sign-on settings on application side.
    1. **[Create OrgVitality SSO test user](#create-orgvitality-sso-test-user)** - to have a counterpart of B.Simon in OrgVitality SSO that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **OrgVitality SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://rpt.orgvitality.com/<COMPANY_NAME>/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://rpt.orgvitality.com/<COMPANY_NAME>Auth/default.aspx`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [OrgVitality SSO support team](https://orgvitality.com/contact-us/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your OrgVitality SSO application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**. OrgVitality SSO application expects **nameidentifier** to be mapped with **user.employeeid**, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

	![image](common/default-attributes.png)

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up OrgVitality SSO** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure OrgVitality SSO

To configure single sign-on on **OrgVitality SSO** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [OrgVitality SSO support team](https://orgvitality.com/contact-us/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create OrgVitality SSO test user

In this section, you create a user called Britta Simon in OrgVitality SSO. Work with [OrgVitality SSO support team](https://orgvitality.com/contact-us/) to add the users in the OrgVitality SSO platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the OrgVitality SSO for which you set up the SSO.

* You can use Microsoft My Apps. When you select the OrgVitality SSO tile in the My Apps, you should be automatically signed in to the OrgVitality SSO for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure OrgVitality SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
