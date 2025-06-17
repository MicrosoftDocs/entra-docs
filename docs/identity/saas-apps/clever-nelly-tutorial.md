---
title: Configure Clever Nelly for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Clever Nelly.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Clever Nelly so that I can control who has access to Clever Nelly, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Clever Nelly for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Clever Nelly with Microsoft Entra ID. When you integrate Clever Nelly with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Clever Nelly.
* Enable your users to be automatically signed-in to Clever Nelly with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Clever Nelly single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Clever Nelly supports **SP and IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Clever Nelly from the gallery

To configure the integration of Clever Nelly into Microsoft Entra ID, you need to add Clever Nelly from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Clever Nelly** in the search box.
1. Select **Clever Nelly** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-clever-nelly'></a>

## Configure and test Microsoft Entra SSO for Clever Nelly

Configure and test Microsoft Entra SSO with Clever Nelly using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Clever Nelly.

To configure and test Microsoft Entra SSO with Clever Nelly, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Clever Nelly SSO](#configure-clever-nelly-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Clever Nelly test user](#create-clever-nelly-test-user)** - to have a counterpart of B.Simon in Clever Nelly that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Clever Nelly** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type one of the following URLs:

    | Environment | URL Pattern |
    | - | - |
    | Test | `https://test.elephantsdontforget.com/plato`|
    | Production | `https://secure.elephantsdontforget.com/plato` |
    | | |

    b. In the **Reply URL** text box, type one of the following URLs:

    | Environment | URL Pattern |
    | - | - |
    | Test | `https://test.elephantsdontforget.com/plato/callback?client_name=SAML2Client`|
    | Production | `https://secure.elephantsdontforget.com/plato/callback?client_name=SAML2Client` |
    | | |

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type one of the following URLs::

    | Environment | URL Pattern |
    | - | - |
    | Test | `https://test.elephantsdontforget.com/plato/sso/microsoft/index.xhtml`|
    | Production | `https://secure.elephantsdontforget.com/plato/sso/microsoft/index.xhtml` |
    | | |

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Clever Nelly SSO

To configure single sign-on on **Clever Nelly** side, you need to send the **App Federation Metadata Url** to [Clever Nelly support team](mailto:support@elephantsdontforget.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Clever Nelly test user

In this section, you create a user called Britta Simon in Clever Nelly. Work with [Clever Nelly support team](mailto:support@elephantsdontforget.com) to add the users in the Clever Nelly platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Clever Nelly Sign on URL where you can initiate the login flow.  

* Go to Clever Nelly Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Clever Nelly for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Clever Nelly tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Clever Nelly for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Clever Nelly you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
