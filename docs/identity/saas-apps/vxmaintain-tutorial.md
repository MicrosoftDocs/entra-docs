---
title: Configure vxMaintain for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and vxMaintain.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and vxMaintain so that I can control who has access to vxMaintain, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure vxMaintain for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate vxMaintain with Microsoft Entra ID. When you integrate vxMaintain with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to vxMaintain.
* Enable your users to be automatically signed-in to vxMaintain with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To configure Microsoft Entra integration with vxMaintain, you need the following items:

* A Microsoft Entra subscription. If you don't have a Microsoft Entra environment, you can get a [free account](https://azure.microsoft.com/free/).
* vxMaintain single sign-on enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* vxMaintain supports **IDP** initiated SSO.

## Add vxMaintain from the gallery

To configure the integration of vxMaintain into Microsoft Entra ID, you need to add vxMaintain from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **vxMaintain** in the search box.
1. Select **vxMaintain** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-vxmaintain'></a>

## Configure and test Microsoft Entra SSO for vxMaintain

Configure and test Microsoft Entra SSO with vxMaintain using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in vxMaintain.

To configure and test Microsoft Entra SSO with vxMaintain, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure vxMaintain SSO](#configure-vxmaintain-sso)** - to configure the single sign-on settings on application side.
    1. **[Create vxMaintain test user](#create-vxmaintain-test-user)** - to have a counterpart of B.Simon in vxMaintain that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **vxMaintain** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<company name>.verisae.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<company name>.verisae.com/DataNett/action/ssoConsume/mobile?_log=true`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [vxMaintain Client support team](https://www.hubspot.com/company/contact) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

6. On the **Set up vxMaintain** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata") 

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure vxMaintain SSO

To configure single sign-on on **vxMaintain** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [vxMaintain support team](https://www.hubspot.com/company/contact). They set this setting to have the SAML SSO connection set properly on both sides.

### Create vxMaintain test user

In this section, you create a user called Britta Simon in vxMaintain. Work with [vxMaintain support team](https://www.hubspot.com/company/contact) to add the users in the vxMaintain platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the vxMaintain for which you set up the SSO.

* You can use Microsoft My Apps. When you select the vxMaintain tile in the My Apps, you should be automatically signed in to the vxMaintain for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure vxMaintain you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
