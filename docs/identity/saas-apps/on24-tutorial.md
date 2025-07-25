---
title: Configure ON24 Virtual Environment SAML Connection for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ON24 Virtual Environment SAML Connection.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ON24 Virtual Environment SAML Connection so that I can control who has access to ON24 Virtual Environment SAML Connection, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure ON24 Virtual Environment SAML Connection for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ON24 Virtual Environment SAML Connection with Microsoft Entra ID. When you integrate ON24 Virtual Environment SAML Connection with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ON24 Virtual Environment SAML Connection.
* Enable your users to be automatically signed-in to ON24 Virtual Environment SAML Connection with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ON24 Virtual Environment SAML Connection single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* ON24 Virtual Environment SAML Connection supports **SP** and **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add ON24 Virtual Environment SAML Connection from the gallery

To configure the integration of ON24 Virtual Environment SAML Connection into Microsoft Entra ID, you need to add ON24 Virtual Environment SAML Connection from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ON24 Virtual Environment SAML Connection** in the search box.
1. Select **ON24 Virtual Environment SAML Connection** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-on24-virtual-environment-saml-connection'></a>

## Configure and test Microsoft Entra SSO for ON24 Virtual Environment SAML Connection

Configure and test Microsoft Entra SSO with ON24 Virtual Environment SAML Connection using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ON24 Virtual Environment SAML Connection.

To configure and test Microsoft Entra SSO with ON24 Virtual Environment SAML Connection, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ON24 Virtual Environment SAML Connection SSO](#configure-on24-virtual-environment-saml-connection-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ON24 Virtual Environment SAML Connection test user](#create-on24-virtual-environment-saml-connection-test-user)** - to have a counterpart of B.Simon in ON24 Virtual Environment SAML Connection that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ON24 Virtual Environment SAML Connection** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type one of the following values:

    | **Production Environment URL** |
	|------|
    | `SAML-VSHOW.on24.com` |
	| `SAML-Gateway.on24.com` |
	| `SAP PROD SAML-EliteAudience.on24.com` |
	|
                
	| **QA Environment URL** |
	|-----|
	| `SAMLQA-VSHOW.on24.com` |
	| `SAMLQA-Gateway.on24.com` |
	| `SAMLQA-EliteAudience.on24.com` |
	|

    b. In the **Reply URL** text box, type one of the following URLs:

    | **Production Environment URL** |
	|-----|
	| `https://federation.on24.com/sp/ACS.saml2` |
	| `https://federation.on24.com/sp/eyJ2c2lkIjoiU0FNTC1WU2hvdy5vbjI0LmNvbSJ9/ACS.saml2` |
	| `https://federation.on24.com/sp/eyJ2c2lkIjoiU0FNTC1HYXRld2F5Lm9uMjQuY29tIn0/ACS.saml2` |
	| `https://federation.on24.com/sp/eyJ2c2lkIjoiU0FNTC1FbGl0ZUF1ZGllbmNlLm9uMjQuY29tIn0/ACS.saml2` |
	|

	| **QA Environment URL** |
	|-------|
    | `https://qafederation.on24.com/sp/ACS.saml2` |
	| `https://qafederation.on24.com/sp/eyJ2c2lkIjoiU0FNTFFBLVZzaG93Lm9uMjQuY29tIn0/ACS.saml2` |
	| `https://qafederation.on24.com/sp/eyJ2c2lkIjoiU0FNTFFBLUdhdGV3YXkub24yNC5jb20ifQ/ACS.saml2` |
    | `https://qafederation.on24.com/sp/eyJ2c2lkIjoiU0FNTFFBLUVsaXRlQXVkaWVuY2Uub24yNC5jb20ifQ/ACS.saml2` |
	|

	c. Select **Set additional URLs**. 

	d. In the **Relay State** text box, type a URL using the following pattern: `https://vshow.on24.com/vshow/ms_azure_saml_test?r=<ID>`

5.  If you wish to configure the application in **SP** initiated mode, perform the following step:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://vshow.on24.com/vshow/<INSTANCE_NAME>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Relay State and Sign-on URL. Contact [ON24 Virtual Environment SAML Connection Client support team](https://www.on24.com/contact-us/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

4. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up ON24 Virtual Environment SAML Connection** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ON24 Virtual Environment SAML Connection SSO

To configure single sign-on on **ON24 Virtual Environment SAML Connection** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [ON24 Virtual Environment SAML Connection support team](https://www.on24.com/about-us/support/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ON24 Virtual Environment SAML Connection test user

In this section, you create a user called Britta Simon in ON24 Virtual Environment SAML Connection. Work with [ON24 Virtual Environment SAML Connection support team](https://www.on24.com/about-us/support/) to add the users in the ON24 Virtual Environment SAML Connection platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to ON24 Virtual Environment SAML Connection Sign on URL where you can initiate the login flow.  

* Go to ON24 Virtual Environment SAML Connection Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the ON24 Virtual Environment SAML Connection for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the ON24 Virtual Environment SAML Connection tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the ON24 Virtual Environment SAML Connection for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure ON24 Virtual Environment SAML Connection you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
