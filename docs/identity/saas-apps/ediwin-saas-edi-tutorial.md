---
title: Configure Ediwin SaaS EDI for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Ediwin SaaS EDI.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Ediwin SaaS EDI so that I can control who has access to Ediwin SaaS EDI, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Ediwin SaaS EDI for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Ediwin SaaS EDI with Microsoft Entra ID. When you integrate Ediwin SaaS EDI with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Ediwin SaaS EDI.
* Enable your users to be automatically signed-in to Ediwin SaaS EDI with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Ediwin SaaS EDI single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Ediwin SaaS EDI supports **SP** initiated SSO.

## Add Ediwin SaaS EDI from the gallery

To configure the integration of Ediwin SaaS EDI into Microsoft Entra ID, you need to add Ediwin SaaS EDI from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Ediwin SaaS EDI** in the search box.
1. Select **Ediwin SaaS EDI** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-ediwin-saas-edi'></a>

## Configure and test Microsoft Entra SSO for Ediwin SaaS EDI

Configure and test Microsoft Entra SSO with Ediwin SaaS EDI using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Ediwin SaaS EDI.

To configure and test Microsoft Entra SSO with Ediwin SaaS EDI, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Ediwin SaaS EDI SSO](#configure-ediwin-saas-edi-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Ediwin SaaS EDI test user](#create-ediwin-saas-edi-test-user)** - to have a counterpart of B.Simon in Ediwin SaaS EDI that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Ediwin SaaS EDI** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a URL using the following pattern:
    `https://web.sedeb2b.com/<EdiwinDomain>`

    b. In the **Reply URL** textbox, type a URL using the following pattern:
    `https://web.sedeb2b.com/Ediwin/samlLogin/<EdiwinDomain>`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://web.sedeb2b.com/Ediwin/samlLogin/<EdiwinDomain>`

    > [!Note]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Ediwin SaaS EDI support team](mailto:cau@edicomgroup.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Ediwin SaaS EDI** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Attributes")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Ediwin SaaS EDI SSO

To configure single sign-on on **Ediwin SaaS EDI** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Ediwin SaaS EDI support team](mailto:cau@edicomgroup.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Ediwin SaaS EDI test user

In this section, you create a user called Britta Simon in Ediwin SaaS EDI. Work with [Ediwin SaaS EDI support team](mailto:cau@edicomgroup.com) to add the users in the Ediwin SaaS EDI platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Ediwin SaaS EDI Sign-on URL where you can initiate the login flow. 

* Go to Ediwin SaaS EDI Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Ediwin SaaS EDI tile in the My Apps, this option redirects to Ediwin SaaS EDI Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Ediwin SaaS EDI you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
