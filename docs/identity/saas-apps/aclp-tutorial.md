---
title: Configure ACLP for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ACLP.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ACLP so that I can control who has access to ACLP, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure ACLP for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ACLP with Microsoft Entra ID. When you integrate ACLP with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ACLP.
* Enable your users to be automatically signed-in to ACLP with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To configure Microsoft Entra integration with ACLP, you need the following items:

* A Microsoft Entra subscription. If you don't have a Microsoft Entra environment, you can get a [free account](https://azure.microsoft.com/free/).
* ACLP single sign-on enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* ACLP supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add ACLP from the gallery

To configure the integration of ACLP into Microsoft Entra ID, you need to add ACLP from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ACLP** in the search box.
1. Select **ACLP** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-aclp'></a>

## Configure and test Microsoft Entra SSO for ACLP

Configure and test Microsoft Entra SSO with ACLP using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ACLP.

To configure and test Microsoft Entra SSO with ACLP, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ACLP SSO](#configure-aclp-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ACLP test user](#create-aclp-test-user)** - to have a counterpart of B.Simon in ACLP that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ACLP** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://access.sans.org/go/<COMPANYNAME>`

	> [!NOTE]
	> The value isn't  real. Update the value with the actual Sign-On URL. Contact [ACLP Client support team](mailto:mrichards@sans.org) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ACLP SSO

To configure single sign-on on **ACLP** side, you need to send the **App Federation Metadata Url** to [ACLP support team](mailto:mrichards@sans.org). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ACLP test user

In this section, you create a user called Britta Simon in ACLP. Work with [ACLP support team](mailto:mrichards@sans.org) to add the users in the ACLP platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ACLP Sign-on URL where you can initiate the login flow. 

* Go to ACLP Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ACLP tile in the My Apps, this option redirects to ACLP Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ACLP you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
