---
title: Configure Delivery Scheduling Tool for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Delivery Scheduling Tool.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Delivery Scheduling Tool so that I can control who has access to Delivery Scheduling Tool, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Delivery Scheduling Tool for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Delivery Scheduling Tool with Microsoft Entra ID. When you integrate Delivery Scheduling Tool with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Delivery Scheduling Tool.
* Enable your users to be automatically signed-in to Delivery Scheduling Tool with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Delivery Scheduling Tool single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Delivery Scheduling Tool supports both **SP and IDP** initiated SSO.

## Add Delivery Scheduling Tool from the gallery

To configure the integration of Delivery Scheduling Tool into Microsoft Entra ID, you need to add Delivery Scheduling Tool from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Delivery Scheduling Tool** in the search box.
1. Select **Delivery Scheduling Tool** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Delivery Scheduling Tool

Configure and test Microsoft Entra SSO with Delivery Scheduling Tool using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Delivery Scheduling Tool.

To configure and test Microsoft Entra SSO with Delivery Scheduling Tool, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Delivery Scheduling Tool SSO](#configure-delivery-scheduling-tool-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Delivery Scheduling Tool test user](#create-delivery-scheduling-tool-test-user)** - to have a counterpart of B.Simon in Delivery Scheduling Tool that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Delivery Scheduling Tool** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type one of the following URLs:

    |**Identifier**|
    |--------------|
    |`https://saml.quickbase.com`|
    |`https://microsoftlearning.quickbase.com`|

    b. In the **Reply URL** text box, type one of the following URLs:

    |**Reply URL**|
    |-------------|
    |`https://saml.quickbase.com/saml/SSOAssert.aspx`|
    |`https://microsoftlearning.quickbase.com/saml/SSOAssert.aspx`|

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://saml.quickbase.com`

1. Delivery Scheduling Tool application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

    > [!Note]
    > Please rename **emailaddress** to **EmailAddress**  and remove namespace for all the default attributes under **Additional Claim** Section shown in the above screenshot to work SSO connection properly on both sides as per application side requirement and also map **name** and **Unique User Identifier (Name ID)** attributes to **user.onpremisessamaccountname** in the portal.

1. In addition to above, Delivery Scheduling Tool application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| ---- | ---------------- |
	| FirstName | user.givenname |
	| LastName | user.surname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Delivery Scheduling Tool** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Delivery Scheduling Tool SSO

To configure single sign-on on **Delivery Scheduling Tool** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [Delivery Scheduling Tool support team](mailto:LP.Tier2@accenture.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Delivery Scheduling Tool test user

In this section, you create a user called B.Simon in Delivery Scheduling Tool. Work with [Delivery Scheduling Tool support team](mailto:LP.Tier2@accenture.com) to add the users in the Delivery Scheduling Tool platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Delivery Scheduling Tool Sign on URL where you can initiate the login flow.  
 
* Go to Delivery Scheduling Tool Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the Delivery Scheduling Tool for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the Delivery Scheduling Tool tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Delivery Scheduling Tool for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Delivery Scheduling Tool you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
