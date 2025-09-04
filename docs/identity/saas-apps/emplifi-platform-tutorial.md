---
title: Configure Emplifi platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Emplifi platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Emplifi platform so that I can control who has access to Emplifi platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Emplifi platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Emplifi platform with Microsoft Entra ID. When you integrate Emplifi platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Emplifi platform.
* Enable your users to be automatically signed-in to Emplifi platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Emplifi platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Emplifi platform supports **SP and IDP** initiated SSO.

## Add Emplifi platform from the gallery

To configure the integration of Emplifi platform into Microsoft Entra ID, you need to add Emplifi platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Emplifi platform** in the search box.
1. Select **Emplifi platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-emplifi-platform'></a>

## Configure and test Microsoft Entra SSO for Emplifi platform

Configure and test Microsoft Entra SSO with Emplifi platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Emplifi platform.

To configure and test Microsoft Entra SSO with Emplifi platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Emplifi platform SSO](#configure-emplifi-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Emplifi platform test user](#create-emplifi-platform-test-user)** - to have a counterpart of B.Simon in Emplifi platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Emplifi platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using one of the following patterns:

    | **Identifier** |
    |-------|
    | `https://<CustomerName>.account.socialbakers.com` |
    | `https://<CustomerName>.account.emplifi.io` |

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<CustomerName>.account.emplifi.io/login/saml`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<CustomerName>.account.emplifi.io`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Emplifi platform Client support team](mailto:support@emplifi.io) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your Emplifi platform application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Box expects this to be mapped with the user's email address. For that you can use **user.mail** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![image](common/default-attributes.png)

1. In addition to above, Emplifi platform application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| --------| --------- |
	| firstName | user.givenname |
    | lastName | user.surname |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Emplifi platform SSO

To configure single sign-on on **Emplifi platform** side, you need to send the **App Federation Metadata Url** to [Emplifi platform support team](mailto:support@emplifi.io). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Emplifi platform test user

In this section, you create a user called Britta Simon in Emplifi platform. Work with [Emplifi platform support team](mailto:support@emplifi.io) to add the users in the Emplifi platform platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Emplifi platform Sign on URL where you can initiate the login flow.  

* Go to Emplifi platform Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Emplifi platform for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Emplifi platform tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Emplifi platform for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Emplifi platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
