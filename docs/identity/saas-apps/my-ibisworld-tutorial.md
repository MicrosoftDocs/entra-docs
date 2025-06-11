---
title: Configure My IBISWorld for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and My IBISWorld.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and My IBISWorld so that I can control who has access to My IBISWorld, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure My IBISWorld for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate My IBISWorld with Microsoft Entra ID. When you integrate My IBISWorld with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to My IBISWorld.
* Enable your users to be automatically signed-in to My IBISWorld with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* My IBISWorld single sign-on (SSO) enabled subscription.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* My IBISWorld supports **SP and IDP** initiated SSO.
* My IBISWorld supports **Just In Time** user provisioning.

## Adding My IBISWorld from the gallery

To configure the integration of My IBISWorld into Microsoft Entra ID, you need to add My IBISWorld from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **My IBISWorld** in the search box.
1. Select **My IBISWorld** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-my-ibisworld'></a>

## Configure and test Microsoft Entra SSO for My IBISWorld

Configure and test Microsoft Entra SSO with My IBISWorld using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in My IBISWorld.

To configure and test Microsoft Entra SSO with My IBISWorld, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure My IBISWorld SSO](#configure-my-ibisworld-sso)** - to configure the single sign-on settings on application side.
    1. **[Create My IBISWorld test user](#create-my-ibisworld-test-user)** - to have a counterpart of B.Simon in My IBISWorld that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **My IBISWorld** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode:

    In the **Relay State** text box, type the URL: `RPID=http://fedlogin.ibisworld.com` and leave the **Sign-on URL** text box empty.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    Contact your IBISWorld Client Relationship Manager for Sign-on URL from IBISWorld and set it into the **Sign-on URL** text box.

1. Select **Save**.

1. My IBISWorld application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, My IBISWorld application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| ---------------- | --------- |
	| department | user.department |
	| language | user.preferredlanguage |
	| phone | user.telephonenumber |
	| title | user.jobtitle |
    | userid | user.employeeid |
    | country | user.country |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)
1. Send the **App Federation Metadata Url** (or Metadata file from previous step) to your IBISWorld Client Relationship Manager

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure My IBISWorld SSO

To configure single sign-on on **My IBISWorld** side, you need to send the **App Federation Metadata Url** to your IBISWorld Client Relationship Manager. We'll need this to have the SAML SSO connection set properly on both sides.

If you have any questions, please contact your IBISWorld Client Relationship Manager and they'll liaise with IBISWorld IT Department.

### Create My IBISWorld test user

In this section, a user called Britta Simon is created in My IBISWorld. My IBISWorld supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in My IBISWorld, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to My IBISWorld Sign on URL where you can initiate the sign in flow.  

* Go to My IBISWorld Sign-on URL directly and initiate the sign in flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the My IBISWorld for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you select the My IBISWorld tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the sign in flow and if configured in IDP mode, you should be automatically signed in to the My IBISWorld for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure My IBISWorld you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
