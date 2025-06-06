---
title: Configure Infor Retail – Information Management for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Infor Retail – Information Management.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Infor Retail - Information Management so that I can control who has access to Infor Retail - Information Management, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Infor Retail – Information Management for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Infor Retail – Information Management with Microsoft Entra ID. When you integrate Infor Retail – Information Management with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Infor Retail – Information Management.
* Enable your users to be automatically signed-in to Infor Retail – Information Management with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Infor Retail – Information Management single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Infor Retail – Information Management supports **SP and IDP** initiated SSO.

## Add Infor Retail – Information Management from the gallery

To configure the integration of Infor Retail – Information Management into Microsoft Entra ID, you need to add Infor Retail – Information Management from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Infor Retail – Information Management** in the search box.
1. Select **Infor Retail – Information Management** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-infor-retail--information-management'></a>

## Configure and test Microsoft Entra SSO for Infor Retail – Information Management

Configure and test Microsoft Entra SSO with Infor Retail – Information Management using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Infor Retail – Information Management.

To configure and test Microsoft Entra SSO with Infor Retail – Information Management, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Infor Retail Information Management SSO](#configure-infor-retail-information-management-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Infor Retail Information Management test user](#create-infor-retail-information-management-test-user)** - to have a counterpart of B.Simon in Infor Retail – Information Management that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Infor Retail – Information Management** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
	 
    | Identifier URL |
    |----|
    |`https://<COMPANY_NAME>.mingle.infor.com`|
    |`http://<COMPANY_NAME>.mingledev.infor.com`|
    |

    b. In the **Reply URL** text box, type a URL using the following pattern: 
    `https://<COMPANY_NAME>.mingle.infor.com/sp/ACS.saml2`

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<COMPANY_NAME>.mingle.infor.com/<COMPANY_CODE>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Infor Retail – Information Management Client support team](mailto:innovate@infor.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

7. On the **Set up Infor Retail – Information Management** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Infor Retail Information Management SSO

To configure single sign-on on **Infor Retail – Information Management** side, you need to send the downloaded **Metadata XML** and appropriate copied URLs from the application configuration to [Infor Retail – Information Management support team](mailto:innovate@infor.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Infor Retail Information Management test user

In this section, you create a user called Britta Simon in Infor Retail – Information Management. Work with [Infor Retail – Information Management support team](mailto:innovate@infor.com) to add the users in the Infor Retail – Information Management platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Infor Retail – Information Management Sign on URL where you can initiate the login flow.  

* Go to Infor Retail – Information Management Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Infor Retail – Information Management for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Infor Retail – Information Management tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Infor Retail – Information Management for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Infor Retail – Information Management you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
