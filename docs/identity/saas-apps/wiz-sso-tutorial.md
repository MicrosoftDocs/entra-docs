---
title: Configure Wiz SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Wiz SSO.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Wiz SSO so that I can control who has access to Wiz SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Wiz SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Wiz SSO with Microsoft Entra ID. When you integrate Wiz SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Wiz SSO.
* Enable your users to be automatically signed-in to Wiz SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Wiz SSO single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Wiz SSO supports **SP** initiated SSO.
* Wiz SSO supports **Just In Time** user provisioning.

## Add Wiz SSO from the gallery

To configure the integration of Wiz SSO into Microsoft Entra ID, you need to add Wiz SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Wiz SSO** in the search box.
1. Select **Wiz SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-wiz-sso'></a>

## Configure and test Microsoft Entra SSO for Wiz SSO

Configure and test Microsoft Entra SSO with Wiz SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user at Wiz SSO.

To configure and test Microsoft Entra SSO with Wiz SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Wiz SSO](#configure-wiz-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Wiz SSO test user](#create-wiz-sso-test-user)** - to have a counterpart of B.Simon in Wiz SSO linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Wiz SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a value using the following pattern:
    `urn:amazon:cognito:sp:<region_identifier>`

    b. In the **Reply URL** textbox, type a URL using the following pattern:
    `https://<Uuid>.auth.<Region>.amazoncognito.com/saml2/idpresponse`

    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.wiz.io/idp-login?clientId=<CLIENT_ID>&idp=<IDP_INSTANCE>`

    > [!Note]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Wiz SSO support team](mailto:delivery@wiz.io) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your Wiz SSO application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Wiz SSO expects this to be mapped with the user's email address. For that you can use **user.mail** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Attributes")

1. In addition to previous step, Wiz SSO application expects few more attributes to be passed back in SAML response, which are shown in the following table. These attributes are also pre populated but you can review them as per your requirements.

    | Name | Source Attribute|
    | ------------ | --------- |
    | name | user.displayname |
    | groups | user.groups |

    To create these extra claims:

   a. Go to **User Attributes & Claims**, and select **Edit**.

   b. Select **Add a group claim**.

   c. Select **All groups**.

   d. Under **Advanced options**, select the **Customize the name of the group claim** check box.

   e. For **Name**, enter **groups**.
   
   f. Select **Save**.   

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Wiz SSO** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Wiz SSO

To configure single sign-on on **Wiz SSO** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Wiz SSO support team](mailto:delivery@wiz.io). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Wiz SSO test user

In this section, a user called B.Simon is created in Speexx. Speexx supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Speexx, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Wiz SSO Sign-on URL where you can initiate the sign-in flow. 

* Go to Wiz SSO Sign-on URL directly and initiate the sign-in flow from there.

* You can use Microsoft My Apps. When you select the Wiz SSO tile in the My Apps, this option redirects to Wiz SSO Sign-On URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Wiz SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
