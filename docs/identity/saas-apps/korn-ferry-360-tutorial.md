---
title: Configure Korn Ferry 360 for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Korn Ferry 360.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Korn Ferry 360 so that I can control who has access to Korn Ferry 360, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Korn Ferry 360 for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Korn Ferry 360 with Microsoft Entra ID. When you integrate Korn Ferry 360 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Korn Ferry 360.
* Enable your users to be automatically signed-in to Korn Ferry 360 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Korn Ferry 360 single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Korn Ferry 360 supports **SP** initiated SSO.

## Add Korn Ferry 360 from the gallery

To configure the integration of Korn Ferry 360 into Microsoft Entra ID, you need to add Korn Ferry 360 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Korn Ferry 360** in the search box.
1. Select **Korn Ferry 360** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-korn-ferry-360'></a>

## Configure and test Microsoft Entra SSO for Korn Ferry 360

Configure and test Microsoft Entra SSO with Korn Ferry 360 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Korn Ferry 360.

To configure and test Microsoft Entra SSO with Korn Ferry 360, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Korn Ferry 360 SSO](#configure-korn-ferry-360-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Korn Ferry 360 test user](#create-korn-ferry-360-test-user)** - to have a counterpart of B.Simon in Korn Ferry 360 that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Korn Ferry 360** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<customidentifier>.kornferry.com/`

     b. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://surveys.kornferry.com/<customidentifier>`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Sign-on URL. Contact [Korn Ferry 360 Client support team](mailto:george.gold@kornferry.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Korn Ferry 360** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Korn Ferry 360 SSO

To configure single sign-on on **Korn Ferry 360** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Korn Ferry 360 support team](mailto:george.gold@kornferry.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Korn Ferry 360 test user

In this section, you create a user called B.Simon in Korn Ferry 360. Work with [Korn Ferry 360 support team](mailto:george.gold@kornferry.com) to add the users in the Korn Ferry 360 platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Korn Ferry 360 Sign-on URL where you can initiate the login flow. 

* Go to Korn Ferry 360 Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Korn Ferry 360 tile in the My Apps, this option redirects to Korn Ferry 360 Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Korn Ferry 360 you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
