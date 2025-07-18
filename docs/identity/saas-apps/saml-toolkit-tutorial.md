---
title: Configure Microsoft Entra SAML Toolkit for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Microsoft Entra SAML Toolkit.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Microsoft Entra SAML Toolkit so that I can control who has access to Microsoft Entra SAML Toolkit, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Microsoft Entra SAML Toolkit for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Microsoft Entra SAML Toolkit with Microsoft Entra ID. When you integrate Microsoft Entra SAML Toolkit with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Microsoft Entra SAML Toolkit.
* Enable your users to be automatically signed-in to Microsoft Entra SAML Toolkit with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Microsoft Entra SAML Toolkit single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Microsoft Entra SAML Toolkit supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

<a name='add-azure-ad-saml-toolkit-from-the-gallery'></a>

## Add Microsoft Entra SAML Toolkit from the gallery

To configure the integration of Microsoft Entra SAML Toolkit into Microsoft Entra ID, you need to add Microsoft Entra SAML Toolkit from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Microsoft Entra SAML Toolkit** in the search box.
1. Select **Microsoft Entra SAML Toolkit** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-azure-ad-saml-toolkit'></a>

## Configure and test Microsoft Entra SSO for Microsoft Entra SAML Toolkit

Configure and test Microsoft Entra SSO with Microsoft Entra SAML Toolkit using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Microsoft Entra SAML Toolkit.

To configure and test Microsoft Entra SSO with Microsoft Entra SAML Toolkit, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    * **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Microsoft Entra SAML Toolkit SSO](#configure-azure-ad-saml-toolkit-sso)** - to configure the single sign-on settings on application side.
    * **[Create Microsoft Entra SAML Toolkit test user](#create-azure-ad-saml-toolkit-test-user)** - to have a counterpart of B.Simon in Microsoft Entra SAML Toolkit that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Microsoft Entra SAML Toolkit** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Reply URL** text box, type the URL:
    `https://samltoolkit.azurewebsites.net/SAML/Consume`

    b. In the **Sign on URL** text box, type the URL:
    `https://samltoolkit.azurewebsites.net/`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificateraw.png)

1. On the **Set up Microsoft Entra SAML Toolkit** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

<a name='configure-azure-ad-saml-toolkit-sso'></a>

## Configure Microsoft Entra SAML Toolkit SSO

1. Open a new web browser window, if you have not registered in the Microsoft Entra SAML Toolkit website, first register by selecting the **Register**. If you have registered already, sign into your Microsoft Entra SAML Toolkit company site using the registered sign-in credentials.

	![Microsoft Entra SAML Toolkit Register](./media/saml-toolkit-tutorial/register.png)

1. In the **SAML Toolkit** window, select **SAML Configuration**.

1. Select **Create**.

	![Microsoft Entra SAML Toolkit](./media/saml-toolkit-tutorial/createsso.png)

1. On the **SAML SSO Configuration** page, perform the following steps:

	![Microsoft Entra SAML Toolkit Create SSO Configuration](./media/saml-toolkit-tutorial/fill-details.png)

	1. In the **Login URL** textbox, paste the **Login URL** value, which you copied previously.

	1. In the **Microsoft Entra Identifier** textbox, paste the **Microsoft Entra Identifier** value, which you copied previously.

	1. In the **Logout URL** textbox, paste the **Logout URL** value, which you copied previously.

	1. Select **Choose File** and upload the **Certificate (Raw)** file which you have downloaded.

	1. Select **Create**.

    1. Copy Sign-on URL, Identifier and ACS URL values on SAML Toolkit SSO configuration page and paste into respected textboxes in the **Basic SAML Configuration section**.

<a name='create-azure-ad-saml-toolkit-test-user'></a>

### Create Microsoft Entra SAML Toolkit test user

In this section, a user called B.Simon is created in Microsoft Entra SAML Toolkit. Please create a test user in the tool by registering a new user and provide all the user details. 

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Microsoft Entra SAML Toolkit Sign-on URL where you can initiate the login flow. 

* Go to Microsoft Entra SAML Toolkit Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Microsoft Entra SAML Toolkit tile in the My Apps, this option redirects to Microsoft Entra SAML Toolkit Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Microsoft Entra SAML Toolkit you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
