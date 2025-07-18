---
title: Configure Humanage for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Humanage.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Humanage so that I can control who has access to Humanage, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Humanage for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Humanage with Microsoft Entra ID. When you integrate Humanage with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Humanage.
* Enable your users to be automatically signed-in to Humanage with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Humanage single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Humanage supports **SP** initiated SSO
* Once you configure Humanage you can enforce session control, which protect exfiltration and infiltration of your organization’s sensitive data in real-time. Session control extend from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).

## Adding Humanage from the gallery

To configure the integration of Humanage into Microsoft Entra ID, you need to add Humanage from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Humanage** in the search box.
1. Select **Humanage** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-single-sign-on-for-humanage'></a>

## Configure and test Microsoft Entra single sign-on for Humanage

Configure and test Microsoft Entra SSO with Humanage using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Humanage.

To configure and test Microsoft Entra SSO with Humanage, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Humanage SSO](#configure-humanage-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Humanage test user](#create-humanage-test-user)** - to have a counterpart of B.Simon in Humanage that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Humanage** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://cppatest.cslab.com.ar/#/saml/< CUSTOMER NAME >`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://cppa.cslab.com.ar/#/entityId/< CUSTOMER NAME >`

    c. In the **Reply URL** textbox, type a URL using the following pattern:
    `https://authapi.cslab.com.ar/api/SamlConsume/< CUSTOMER NAME >`

    > [!NOTE]
	> These values aren't real. Update these values with the actual Sign-on URL, Identifier and Reply URL. Contact [Humanage support team](mailto:support@cardinalconsulting.atlassian.net) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificateraw.png)

1. On the **Set up Humanage** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Humanage SSO

To configure single sign-on on **Humanage** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from the application configuration to [Humanage support team](mailto:support@cardinalconsulting.atlassian.net). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Humanage test user

In this section, you create a user called Britta Simon in Humanage. Work with [Humanage support team](mailto:support@cardinalconsulting.atlassian.net) to add the users in the Humanage platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Humanage tile in the Access Panel, you should be automatically signed in to the Humanage for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)

- [What is session control in Microsoft Defender for Cloud Apps?](/cloud-app-security/proxy-intro-aad)

- [How to protect Humanage with advanced visibility and controls](/cloud-app-security/proxy-intro-aad)
