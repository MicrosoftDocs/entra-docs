---
title: Configure Veracode for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Veracode.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Veracode so that I can control who has access to Veracode, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Veracode for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Veracode with Microsoft Entra ID. When you integrate Veracode with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Veracode.
* Enable your users to be automatically signed-in to Veracode with their Microsoft Entra accounts.
* Manage your accounts in one central location: the Azure portal.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Veracode single sign-on (SSO)-enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment. Veracode supports identity provider initiated SSO and just-in-time user provisioning.

## Add Veracode from the gallery

To configure the integration of Veracode into Microsoft Entra ID, add Veracode from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type "Veracode" in the search box.
1. Select **Veracode** from the results panel, and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-veracode'></a>

## Configure and test Microsoft Entra SSO for Veracode

Configure and test Microsoft Entra SSO with Veracode by using a test user called **B.Simon**. For SSO to work, you must establish a link between a Microsoft Entra user and the related user in Veracode.

To configure and test Microsoft Entra SSO with Veracode, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** to enable your users to use this feature.
    * **Create a Microsoft Entra test user** to test Microsoft Entra single sign-on with B.Simon.
    * **Assign the Microsoft Entra test user** to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Veracode SSO](#configure-veracode-sso)** to configure the single sign-on settings on the application side.
    * **[Create a Veracode test user](#create-veracode-test-user)** to have a counterpart of B.Simon in Veracode linked to the Microsoft Entra representation of the user.
1. **[Test SSO](#test-sso)** to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. In the Microsoft Entra ID navigate to the **Veracode** application page under **Enterprise Applications**, scroll down to the **Manage** section, and select **single sign-on**.
1. Again under the **Manage** tab, select **Single sign-on**, then select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png)

1. The Relay state field should be autopopulated with `https://web.analysiscenter.veracode.com/login/#/saml`. The rest of these fields will populate after setting up SAML within the Veracode Platform.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)**. Select **Download** to download the certificate and save it on your computer.

	![Screenshot of SAML Signing Certificate section, with Download link highlighted.](common/certificatebase64.png)

1. Veracode expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot of User Attributes & Claims section.](common/default-attributes.png)

1. Veracode also expects a few more attributes to be passed back in the SAML response. These attributes are also pre-populated, but you can review them per your requirements.

	| Name | Source attribute|
	| ---------------| --------------- |
	| firstname |User.givenname |
	| lastname |User.surname |
	| email |User.mail |

1. On the **Set up Veracode** section, copy and save the provided URLs to use later in your Veracode Platform SAML setup.

	![Screenshot of Set up Veracode section, with configuration URLs highlighted.](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Veracode SSO

Notes:

* These instructions assume you're using the new [Single Sign On/Just-in-Time Provisioning feature from Veracode](https://docs.veracode.com/r/about_saml). To activate this feature if it isn't already active, please contact Veracode Support.  
* These instructions are valid for all [Veracode regions](https://docs.veracode.com/r/Region_Domains_for_Veracode_APIs).

1. In a different web browser window, sign in to your Veracode company site as an administrator. 

1. From the menu on the top, select **Settings** > **Admin**.
   
    ![Screenshot of Veracode Administration, with Settings icon and Admin highlighted.](./media/veracode-tutorial/admin.png "Administration")

1. Select the **SAML Certificate** tab.

1. In the **SAML Certificate** section, perform the following steps:

    ![Screenshot of Organization SAML Settings section.](./media/veracode-tutorial/saml.png "Administration")

    a.  For **Issuer**, paste the value of the **Microsoft Entra Identifier** that you've copied.
    
    b. For **Assertion Signing Certificate**, select **Choose File** to upload your downloaded certificate.

    c. Note the values of the three URLs (**SAML Assertion URL**, **SAML Audience URL**, **Relay state URL**).

    d. Select **Save**. 
    
1. Take the values of the **SAML Assertion URL**, **SAML Audience URL** and **Relay state URL** and update them in the Microsoft Entra settings for the Veracode integration (follow the table below for proper conversions) NOTE: **Relay State** is NOT optional.

	| Veracode URL | Microsoft Entra ID Field|
	| ---------------| --------------- |
	| SAML Audience URL |Identifier (Entity ID) |
	| SAML Assertion URL |Reply URL (Assertion Consumer Service URL) |
	| Relay State URL |Relay State |

1. Select the **JIT Provisioning** tab.

    ![Screenshot of JIT Provisioning tab, with various options highlighted.](./media/veracode-tutorial/just-in-time.png "JIT Provisioning")

1. In the **Organization Settings** section, toggle the **Configure Default Settings for Just-in-Time user provisioning** setting to **On**. 

1. In the **Basic Settings** section, for **User Data Updates**, select **Prefer Veracode User Data**. This will cause conflicts between data passed in the SAML assertion from Microsoft Entra ID and user data in the Veracode platform to be resolved using the Veracode user data.

1. In the **Access Settings** section, under **User Roles**, select from the following For more information about Veracode user roles, see the [Veracode Documentation](https://docs.veracode.com/r/c_role_permissions):

    ![Screenshot of JIT Provisioning User Roles, with various options highlighted.](./media/veracode-tutorial/user-roles.png "JIT Provisioning")

      * **Policy Administrator**
      * **Reviewer**
      * **Security Lead**
      * **Executive**
      * **Submitter**
      * **Creator**
      * **All Scan Types**

### Create Veracode test user

In this section, a user called B.Simon is created in Veracode. Veracode supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Veracode, a new one is created after authentication.

> [!NOTE]
> You can use any other Veracode user account creation tools or APIs provided by Veracode to provision Microsoft Entra user accounts.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Veracode for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Veracode tile in the My Apps, you should be automatically signed in to the Veracode for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Veracode you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).