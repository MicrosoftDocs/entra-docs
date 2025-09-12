---
title: Configure HCL BigFix Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and HCL BigFix Platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and HCL BigFix Platform so that I can control who has access to HCL BigFix Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure HCL BigFix Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate HCL BigFix Platform with Microsoft Entra ID. When you integrate HCL BigFix Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to HCL BigFix Platform.
* Enable your users to be automatically signed-in to HCL BigFix Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* HCL BigFix Platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* HCL BigFix Platform supports only **SP** initiated SSO.

## Add HCL BigFix Platform from the gallery

To configure the integration of HCL BigFix Platform into Microsoft Entra ID, you need to add HCL BigFix Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **HCL BigFix Platform** in the search box.
1. Select **HCL BigFix Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for HCL BigFix Platform

Configure and test Microsoft Entra SSO with HCL BigFix Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in HCL BigFix Platform.

To configure and test Microsoft Entra SSO with HCL BigFix Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure HCL BigFix Platform SSO](#configure-hcl-bigfix-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create HCL BigFix Platform test user](#create-hcl-bigfix-platform-test-user)** - to have a counterpart of B.Simon in HCL BigFix Platform that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **HCL BigFix Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<BigFix_WebUI_server_fqdn>/saml`

    b. In the **Reply URL** textbox, type a URL using one of the following patterns:

    |**Reply URL**|
    |-------------|
    |`https://<BigFix_WebUI_server_fqdn>/saml`|
    |`https://<BigFix_Web_Reports_server_fqdn>:8083/saml`|
    |`https://<BigFix_Root_server_fqdn>:52311/saml`|

    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<BigFix_WebUI_server_fqdn>/saml`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [HCL BigFix Platform support team](https://support.hcltechsw.com/csm) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up HCL BigFix Platform** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

### Create a Microsoft Entra ID test user

In this section, you create a test user in the Microsoft Entra admin center called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

### Assign the Microsoft Entra ID test user

In this section, you enable B.Simon to use Microsoft Entra single sign-on by granting access to HCL BigFix Platform.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **HCL BigFix Platform**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, select the **Assign** button.

## Configure HCL BigFix Platform SSO

To configure single sign-on on **HCL BigFix Platform** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [HCL BigFix Platform support team](https://support.hcltechsw.com/csm). They set this setting to have the SAML SSO connection set properly on both sides. For more information, please refer this [link](https://help.hcltechsw.com/bigfix/10.0/platform/Platform/Config/c_how_to_configure_bigfix_to_int.html).

### Create HCL BigFix Platform test user

In this section, you create a user called B.Simon in HCL BigFix Platform. Work with [HCL BigFix Platform support team](https://support.hcltechsw.com/csm) to add the users in the HCL BigFix Platform platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to HCL BigFix Platform Sign-on URL where you can initiate the login flow.
 
* Go to HCL BigFix Platform Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the HCL BigFix Platform tile in the My Apps, this option redirects to HCL BigFix Platform Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure HCL BigFix Platform you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
