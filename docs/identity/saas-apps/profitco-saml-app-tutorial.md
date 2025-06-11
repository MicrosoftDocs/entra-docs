---
title: Configure Profit.co for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Profit.co.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Profit.co so that I can control who has access to Profit.co, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Profit.co for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Profit.co with Microsoft Entra ID. When you integrate Profit.co with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Profit.co.
* Enable your users to be automatically signed in to Profit.co with their Microsoft Entra accounts.
* Manage your accounts in one central location, the Azure portal.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Profit.co single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Profit.co supports IDP initiated SSO.

## Add Profit.co from the gallery

To configure the integration of Profit.co into Microsoft Entra ID, you need to add Profit.co from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Profit.co** in the search box.
1. Select **Profit.co** from the results panel, and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-profitco'></a>

## Configure and test Microsoft Entra SSO for Profit.co

Configure and test Microsoft Entra SSO with Profit.co by using a test user called **B.Simon**. For SSO to work, establish a linked relationship between a Microsoft Entra user and the related user in Profit.co.

Here are the general steps to configure and test Microsoft Entra SSO with Profit.co:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Profit.co SSO](#configure-profitco-sso)** to configure the single sign-on settings on the application side.
    1. **[Create a Profit.co test user](#create-a-profitco-test-user)** to have a counterpart of B.Simon in Profit.co. This counterpart is linked to the Microsoft Entra representation of the user.
1. **[Test SSO](#test-sso)** to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Profit.co** application integration page, find the **Manage** section. Select **single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot of Set up single sign-on with SAML page, with pencil icon highlighted](common/edit-urls.png)

1. In the **Basic SAML Configuration** section, the application is preconfigured and the necessary URLs are already pre-populated in Azure. Users need to save the configuration by selecting the **Save** button.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select the **Copy** button. This copies the **App Federation Metadata Url** and saves it on your computer.

    ![Screenshot of the SAML Signing Certificate, with the copy button highlighted](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Profit.co SSO

To configure single sign-on on the Profit.co side, you need to send the App Federation Metadata URL to the [Profit.co support team](mailto:support@profit.co). They configure this setting to have the SAML SSO connection set properly on both sides.

### Create a Profit.co test user

In this section, you create a user called B.Simon in Profit.co. Work with the [Profit.co support team](mailto:support@profit.co) to add the users in the Profit.co platform. You can't use single sign-on until you create and activate users.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Profit.co for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Profit.co tile in the My Apps, you should be automatically signed in to the Profit.co for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Profit.co you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
