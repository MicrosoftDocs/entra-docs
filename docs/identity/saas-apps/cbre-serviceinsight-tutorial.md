---
title: Configure CBRE ServiceInsight for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and CBRE ServiceInsight.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and CBRE ServiceInsight so that I can control who has access to CBRE ServiceInsight, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure CBRE ServiceInsight for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate CBRE ServiceInsight with Microsoft Entra ID. When you integrate CBRE ServiceInsight with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to CBRE ServiceInsight.
* Enable your users to be automatically signed-in to CBRE ServiceInsight with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* CBRE ServiceInsight single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* CBRE ServiceInsight supports **SP** initiated SSO.
* CBRE ServiceInsight supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add CBRE ServiceInsight from the gallery

To configure the integration of CBRE ServiceInsight into Microsoft Entra ID, you need to add CBRE ServiceInsight from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **CBRE ServiceInsight** in the search box.
1. Select **CBRE ServiceInsight** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-cbre-serviceinsight'></a>

## Configure and test Microsoft Entra SSO for CBRE ServiceInsight

Configure and test Microsoft Entra SSO with CBRE ServiceInsight using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in CBRE ServiceInsight.

To configure and test Microsoft Entra SSO with CBRE ServiceInsight, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure CBRE ServiceInsight SSO](#configure-cbre-serviceinsight-sso)** - to configure the single sign-on settings on application side.
    1. **[Create CBRE ServiceInsight test user](#create-cbre-serviceinsight-test-user)** - to have a counterpart of B.Simon in CBRE ServiceInsight that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **CBRE ServiceInsight** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type the URL:
    `https://adfs4.mainstreamsasp.com/adfs/ls/`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [CBRE ServiceInsight Client support team](mailto:SISupport@cbre.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure CBRE ServiceInsight SSO

To configure single sign-on on **CBRE ServiceInsight** side, you need to send the **App Federation Metadata Url** to [CBRE ServiceInsight support team](mailto:SISupport@cbre.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create CBRE ServiceInsight test user

In this section, a user called Britta Simon is created in CBRE ServiceInsight. CBRE ServiceInsight supports just-in-time provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in CBRE ServiceInsight, a new one is created when you attempt to access CBRE ServiceInsight.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to CBRE ServiceInsight Sign-on URL where you can initiate the login flow. 

* Go to CBRE ServiceInsight Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the CBRE ServiceInsight tile in the My Apps, this option redirects to CBRE ServiceInsight Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure CBRE ServiceInsight you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
