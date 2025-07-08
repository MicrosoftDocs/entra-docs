---
title: Configure Pantheon for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Pantheon.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Pantheon so that I can control who has access to Pantheon, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Pantheon for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Pantheon with Microsoft Entra ID. When you integrate Pantheon with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Pantheon.
* Enable your users to be automatically signed-in to Pantheon with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Pantheon single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Pantheon supports **IDP** initiated SSO.

## Add Pantheon from the gallery

To configure the integration of Pantheon into Microsoft Entra ID, you need to add Pantheon from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Pantheon** in the search box.
1. Select **Pantheon** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-pantheon'></a>

## Configure and test Microsoft Entra SSO for Pantheon

Configure and test Microsoft Entra SSO with Pantheon using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Pantheon.

To configure and test Microsoft Entra SSO with Pantheon, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Pantheon SSO](#configure-pantheon-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Pantheon test user](#create-pantheon-test-user)** - to have a counterpart of B.Simon in Pantheon that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Pantheon** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `urn:auth0:pantheon:<orgname>-SSO`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://pantheon.auth0.com/login/callback?connection=<orgname>-SSO`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Pantheon Client support team](https://pantheon.io/docs/getting-support/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Pantheon application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**. Pantheon application expects **nameidentifier** to be mapped with **user.mail**, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

	![image](common/edit-attribute.png)

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Pantheon** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Pantheon SSO

To configure single sign-on on **Pantheon** side, you need to send the downloaded **Certificate(Base64)** and appropriate copied URLs to [Pantheon support team](https://pantheon.io/docs/getting-support/).

> [!Note]
> You also need to provide the Email Domain(s) information and Date Time when you want to enable this connection. You can find more details about it from [here](https://pantheon.io/docs/sso-organizations/).

### Create Pantheon test user

In this section, you create a user called B.Simon in Pantheon. Please follow the below steps to add the user in Pantheon. 

>[!NOTE] 
>For SSO to work user needs to be created first in Pantheon.

1. Sign in to Pantheon with admin credentials.

2. Navigate to **Organization** dashboard page.
 
3. Select **People**.

4. Select **Add user**.

5. Enter the user's email address.

6. Choose the user's role.

7. Select **Add user**.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Pantheon for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Pantheon tile in the My Apps, you should be automatically signed in to the Pantheon for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Pantheon you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
