---
title: Configure Foodee for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Foodee.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Foodee so that I can control who has access to Foodee, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Foodee for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Foodee with Microsoft Entra ID. When you integrate Foodee with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Foodee.
* Enable your users to be automatically signed-in to Foodee with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Foodee single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Foodee supports **SP and IDP** initiated SSO.
* Foodee supports **Just In Time** user provisioning.
* Foodee supports [Automated user provisioning](foodee-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Foodee from the gallery

To configure the integration of Foodee into Microsoft Entra ID, you need to add Foodee from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Foodee** in the search box.
1. Select **Foodee** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-foodee'></a>

## Configure and test Microsoft Entra SSO for Foodee

Configure and test Microsoft Entra SSO with Foodee using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Foodee.

To configure and test Microsoft Entra SSO with Foodee, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Foodee SSO](#configure-foodee-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Foodee test user](#create-foodee-test-user)** - to have a counterpart of B.Simon in Foodee that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Foodee** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://concierge.food.ee/sso/saml/<INSTANCENAME>/consume`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://concierge.food.ee/sso/saml/<INSTANCENAME>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Reply URL and Sign-On URL. Contact [Foodee Client support team](mailto:dev@food.ee) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Foodee** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

### Configure Foodee SSO




1. In a different web browser window, sign in to your Foodee company site as an administrator

4. Select **profile logo** on the top right corner of the page then navigate to **Single Sign On** and perform the following steps:

   ![Foodee configuration](./media/foodee-tutorial/profile-logo.png)

   1. In the **IDP NAME** text box, type the name like ex:Azure.
   1. Open the Federation Metadata XML in Notepad, copy its content and paste it in the **IDP METADATA XML** text box.
   1. Select **Save**.

### Create Foodee test user

In this section, a user called B.Simon is created in Foodee. Foodee supports just-in-time provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Foodee, a new one is created when you attempt to access Foodee.

Foodee also supports automatic user provisioning, you can find more details [here](./foodee-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

SP initiated:

* Select **Test this application**, this option redirects to Foodee Sign on URL where you can initiate the login flow.

* Go to Foodee Sign-on URL directly and initiate the login flow from there.

IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Foodee for which you set up the SSO

You can also use Microsoft My Apps to test the application in any mode. When you select the Foodee tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Foodee for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).


## Related content

Once you configure Foodee you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
