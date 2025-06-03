---
title: Configure SumTotalCentral for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SumTotalCentral.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SumTotalCentral so that I can control who has access to SumTotalCentral, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure SumTotalCentral for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SumTotalCentral with Microsoft Entra ID. When you integrate SumTotalCentral with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SumTotalCentral.
* Enable your users to be automatically signed-in to SumTotalCentral with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SumTotalCentral single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SumTotalCentral supports **SP** initiated SSO.
    
> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add SumTotalCentral from the gallery

To configure the integration of SumTotalCentral into Microsoft Entra ID, you need to add SumTotalCentral from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SumTotalCentral** in the search box.
1. Select **SumTotalCentral** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso'></a>

## Configure and test Microsoft Entra SSO

Configure and test Microsoft Entra SSO with SumTotalCentral using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SumTotalCentral.

To configure and test Microsoft Entra SSO with SumTotalCentral, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
    1. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
2. **[Configure SumTotalCentral SSO](#configure-sumtotalcentral-sso)** - to configure the Single Sign-On settings on application side.
    1. **[Create SumTotalCentral test user](#create-sumtotalcentral-test-user)** - to have a counterpart of Britta Simon in SumTotalCentral that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SumTotalCentral** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot for Edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<subdomain>.sumtotalsystems.com/sites/default`

    b. In the **Identifier (Entity ID)** text box, type the value:
    `SumTotalFederationGateway`

    c. In the **Reply URL** textbox, enter a URL using the following pattern:    
    `https://<subdomain>.sumtotalsystems.com/Broker/Token/CUSTOM_URL`

	> [!NOTE]
	> These values aren't real. Update the value with the actual Sign-On URL and Reply URL. Contact [SumTotalCentral Client support team](http://www.sumtotalsystems.com/support/) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![Screenshot for The Certificate download link.](common/metadataxml.png)

6. On the **Set up SumTotalCentral** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot for Copy configuration URLs.](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SumTotalCentral SSO

To configure single sign-on on **SumTotalCentral** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [SumTotalCentral support team](http://www.sumtotalsystems.com/support/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create SumTotalCentral test user

In this section, you create a user called Britta Simon in SumTotalCentral. Work with [SumTotalCentral support team](http://www.sumtotalsystems.com/support/) to add the users in the SumTotalCentral platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to SumTotalCentral Sign-on URL where you can initiate the login flow. 

* Go to SumTotalCentral Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the SumTotalCentral tile in the My Apps, this option redirects to SumTotalCentral Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure SumTotalCentral you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
