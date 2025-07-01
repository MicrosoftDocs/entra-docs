---
title: Configure IVM Smarthub for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and IVM Smarthub.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and IVM Smarthub so that I can control who has access to IVM Smarthub, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure IVM Smarthub for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate IVM Smarthub with Microsoft Entra ID. When you integrate IVM Smarthub with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to IVM Smarthub.
* Enable your users to be automatically signed-in to IVM Smarthub with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* IVM Smarthub single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* IVM Smarthub supports **SP** initiated SSO.

## Add IVM Smarthub from the gallery

To configure the integration of IVM Smarthub into Microsoft Entra ID, you need to add IVM Smarthub from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **IVM Smarthub** in the search box.
1. Select **IVM Smarthub** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-ivm-smarthub'></a>

## Configure and test Microsoft Entra SSO for IVM Smarthub

Configure and test Microsoft Entra SSO with IVM Smarthub using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user at IVM Smarthub.

To configure and test Microsoft Entra SSO with IVM Smarthub, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure IVM Smarthub SSO](#configure-ivm-smarthub-sso)** - to configure the single sign-on settings on application side.
    1. **[Create IVM Smarthub test user](#create-ivm-smarthub-test-user)** - to have a counterpart of B.Simon in IVM Smarthub that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **IVM Smarthub** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a URL using the following pattern:
    `https://<Environment>.ivminc.com/saml`

    b. In the **Reply URL** textbox, type a URL using the following pattern:
    `https://<Environment>.ivminc.com/signin-saml-<CustomerName>`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<Environment>.ivmsmarthub.com`

    > [!Note]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [IVM Smarthub support team](mailto:icssupport@ivminc.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up IVM Smarthub** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows how to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure IVM Smarthub SSO

To configure single sign-on on **IVM Smarthub** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [IVM Smarthub support team](mailto:icssupport@ivminc.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create IVM Smarthub test user

In this section, you create a user called Britta Simon at IVM Smarthub. Work with [IVM Smarthub support team](mailto:icssupport@ivminc.com) to add the users in the IVM Smarthub platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to IVM Smarthub Sign-on URL where you can initiate the login flow. 

* Go to IVM Smarthub Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the IVM Smarthub tile in the My Apps, this option redirects to IVM Smarthub Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure IVM Smarthub you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
