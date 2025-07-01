---
title: Configure Active Directory SSO for DoubleYou for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Active Directory SSO for DoubleYou.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Active Directory SSO for DoubleYou so that I can control who has access to Active Directory SSO for DoubleYou, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Active Directory SSO for DoubleYou for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Active Directory SSO for DoubleYou with Microsoft Entra ID. When you integrate Active Directory SSO for DoubleYou with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Active Directory SSO for DoubleYou.
* Enable your users to be automatically signed-in to Active Directory SSO for DoubleYou with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Active Directory SSO for DoubleYou single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Active Directory SSO for DoubleYou supports **SP and IDP** initiated SSO.

## Add Active Directory SSO for DoubleYou from the gallery

To configure the integration of Active Directory SSO for DoubleYou into Microsoft Entra ID, you need to add Active Directory SSO for DoubleYou from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Active Directory SSO for DoubleYou** in the search box.
1. Select **Active Directory SSO for DoubleYou** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-active-directory-sso-for-doubleyou'></a>

## Configure and test Microsoft Entra SSO for Active Directory SSO for DoubleYou

Configure and test Microsoft Entra SSO with Active Directory SSO for DoubleYou using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Active Directory SSO for DoubleYou.

To configure and test Microsoft Entra SSO with Active Directory SSO for DoubleYou, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Active Directory SSO for DoubleYou SSO](#configure-active-directory-sso-for-doubleyou-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Active Directory SSO for DoubleYou test user](#create-active-directory-sso-for-doubleyou-test-user)** - to have a counterpart of B.Simon in Active Directory SSO for DoubleYou that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Active Directory SSO for DoubleYou** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `<company-id>.welfare.it`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<company-id>.welfare.it/<store-id>?`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<company-id>.welfare.it/microsoft/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Active Directory SSO for DoubleYou Client support team](mailto:info@double-you.it) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your Active Directory SSO for DoubleYou application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Active Directory SSO for DoubleYou expects this to be mapped with the user's email address. For that you can use **user.mail** attribute from the list or use the appropriate attribute value based on your organization configuration.
    
    ![image](common/default-attributes.png)

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Active Directory SSO for DoubleYou SSO

To configure single sign-on on **Active Directory SSO for DoubleYou** side, you need to send the **App Federation Metadata Url** to [Active Directory SSO for DoubleYou support team](mailto:info@double-you.it). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Active Directory SSO for DoubleYou test user

In this section, you create a user called Britta Simon in Active Directory SSO for DoubleYou. Work with [Active Directory SSO for DoubleYou support team](mailto:info@double-you.it) to add the users in the Active Directory SSO for DoubleYou platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Active Directory SSO for DoubleYou Sign on URL where you can initiate the login flow.  

* Go to Active Directory SSO for DoubleYou Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Active Directory SSO for DoubleYou for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Active Directory SSO for DoubleYou tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Active Directory SSO for DoubleYou for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Active Directory SSO for DoubleYou you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
