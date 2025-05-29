---
title: Configure FloQast for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FloQast.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FloQast so that I can control who has access to FloQast, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure FloQast for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FloQast with Microsoft Entra ID. When you integrate FloQast with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to FloQast.
* Enable your users to be automatically signed-in to FloQast with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* FloQast single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* FloQast supports **SP and IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add FloQast from the gallery

To configure the integration of FloQast into Microsoft Entra ID, you need to add FloQast from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **FloQast** in the search box.
1. Select **FloQast** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-floqast'></a>

## Configure and test Microsoft Entra SSO for FloQast

Configure and test Microsoft Entra SSO with FloQast using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in FloQast.

To configure and test Microsoft Entra SSO with FloQast, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure FloQast SSO](#configure-floqast-sso)** - to configure the single sign-on settings on application side.
    1. **[Create FloQast test user](#create-floqast-test-user)** - to have a counterpart of B.Simon in FloQast that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FloQast** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode,  perform the following step:

    a. In the **Identifier** text box, type one of the following URLs:

    | Identifier |
    | ---------- |
    | `https://go.floqast.com/` |
    | `https://eu.floqast.app/` |
    |

    b. In the **Reply URL** text box, type one of the following URLs:

    | Reply URL |
    | ---------- |
    | `https://go.floqast.com/api/sso/saml/azure` |
    | `https://eu.floqast.app/api/sso/saml/azure` |
    |


1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type one of the following URLs:

    | Sign-on URL |
    | ---------- |
    | `https://go.floqast.com/login/sso` |
    | `https://eu.floqast.app/login/sso` |
    |


1. FloQast application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

    ![image](common/default-attributes.png)

1. In addition to above, FloQast application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

    | Name | Source Attribute|
    | ------------- | -------------- |
    | FirstName | user.givenname |
    | LastName | user.surname |
    | Email | user.mail    |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

9. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog and perform the following step.

    ![Edit SAML Signing Certificate](common/edit-certificate.png)

    1. Select **Sign SAML response and assertion** from the **Signing Option**.

    1. Select **Save**.

1. On the **Set up FloQast** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure FloQast SSO

To configure single sign-on on **FloQast** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [FloQast support team](mailto:support@floqast.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create FloQast test user

In this section, you create a user called B.Simon in FloQast. Work with [FloQast support team](mailto:support@floqast.com) to add the users in the FloQast platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to FloQast Sign on URL where you can initiate the login flow.  

* Go to FloQast Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the FloQast for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the FloQast tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the FloQast for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure FloQast you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
