---
title: Configure Druva for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Druva.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Druva so that I can control who has access to Druva, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Druva for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Druva with Microsoft Entra ID. When you integrate Druva with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Druva.
* Enable your users to be automatically signed-in to Druva with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Druva single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Druva supports **IDP** initiated SSO.
* Druva supports [Automated user provisioning](druva-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Druva from the gallery

To configure the integration of Druva into Microsoft Entra ID, you need to add Druva from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Druva** in the search box.
1. Select **Druva** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-druva'></a>

## Configure and test Microsoft Entra SSO for Druva

Configure and test Microsoft Entra SSO with Druva using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Druva.

To configure and test Microsoft Entra SSO with Druva, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Druva SSO](#configure-druva-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Druva test user](#create-druva-test-user)** - to have a counterpart of B.Simon in Druva that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Druva** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier (Entity ID)** text box, type the string value: `DCP-login`.
	
	b. In the **Reply URL (Assertion Consumer Service URL)** text box, type the URL: `https://cloud.druva.com/wrsaml/consume`.

1. Select **Save**.

1. Druva application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Druva application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| ------------------- | -------------------- |
	| emailAddress | user.email |
	| druva_auth_token | SSO Token generated from DCP Admin Console, without quotation marks.  For example: X-XXXXX-XXXX-S-A-M-P-L-E+TXOXKXEXNX=. Azure automatically adds quotation marks around the auth token. |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Druva** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Druva SSO

1. In a different web browser window, sign in to your Druva company site as an administrator.

1. Select the Druva logo on top left corner and then select **Druva Cloud Settings**.

	![Settings](./media/druva-tutorial/cloud.png "Settings")

1. On the **Single Sign-On** tab, select **Edit**.

	![Screenshot that shows the "Access Settings - Single Sign-On" tab with the "Edit" button selected.](./media/druva-tutorial/edit-tab.png "Single Sign-On Settings")

1. On the **Edit Single Sign-On Settings** page, perform the following steps:

	![Single Sign-On Settings](./media/druva-tutorial/configuration.png "Single Sign-On Settings")

	1. In **ID Provider Login URL** textbox, paste the value of **Login URL**.

	1. Open your base-64 encoded certificate in notepad, copy the content of it into your clipboard, and then paste it to the **ID Provider Certificate** textbox.

	   > [!NOTE]
	   > To Enable Single Sign-On for administrators, select **Administrators log into Druva Cloud through SSO provider** and **Allow failsafe access to Druva Cloud administrators(recommended)** checkboxes. Druva recommends to enable **Failsafe for Administrators** so that they have to access the DCP console in case of any failures in IdP. It also enables the administrators to use both SSO and DCP password to access the DCP console.

	1. Select **Save**. This enables the access to Druva Cloud Platform using SSO.

### Create Druva test user

In this section, a user called B.Simon is created in Druva. Druva supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Druva, a new one is created after authentication.

Druva also supports automatic user provisioning, you can find more details [here](./druva-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Druva for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Druva tile in the My Apps, you should be automatically signed in to the Druva for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Druva you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
