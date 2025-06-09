---
title: Configure Shutterstock for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Shutterstock.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Shutterstock so that I can control who has access to Shutterstock, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Shutterstock for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Shutterstock with Microsoft Entra ID. When you integrate Shutterstock with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Shutterstock.
* Enable your users to be automatically signed-in to Shutterstock with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Shutterstock single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Shutterstock supports **SP and IDP** initiated SSO

## Adding Shutterstock from the gallery

To configure the integration of Shutterstock into Microsoft Entra ID, you need to add Shutterstock from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Shutterstock** in the search box.
1. Select **Shutterstock** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-shutterstock'></a>

## Configure and test Microsoft Entra SSO for Shutterstock

Configure and test Microsoft Entra SSO with Shutterstock using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Shutterstock.

To configure and test Microsoft Entra SSO with Shutterstock, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Shutterstock SSO](#configure-shutterstock-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Shutterstock test user](#create-shutterstock-test-user)** - to have a counterpart of B.Simon in Shutterstock that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Shutterstock** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type the URL:
    `https://accounts.shutterstock.com/saml`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://accounts.shutterstock.com/saml/<CUSTOMER_ID>/callback`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://accounts.shutterstock.com/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Shutterstock Client support team](mailto:premierintegrations@shutterstock.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Shutterstock** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Shutterstock SSO

To configure single sign-on on **Shutterstock** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Shutterstock support team](mailto:premierintegrations@shutterstock.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Shutterstock test user

In this section, you create a user called Britta Simon in Shutterstock. Work with [Shutterstock support team](mailto:premierintegrations@shutterstock.com) to add the users in the Shutterstock platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Shutterstock Sign on URL where you can initiate the login flow.  

* Go to Shutterstock Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Shutterstock for which you set up the SSO 

You can also use Microsoft Access Panel to test the application in any mode. When you select the Shutterstock tile in the Access Panel, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Shutterstock for which you set up the SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Shutterstock you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
