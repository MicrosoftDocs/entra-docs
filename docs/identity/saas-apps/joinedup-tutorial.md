---
title: Configure JoinedUp for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and JoinedUp.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and JoinedUp so that I can control who has access to JoinedUp, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure JoinedUp for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate JoinedUp with Microsoft Entra ID. When you integrate JoinedUp with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to JoinedUp.
* Enable your users to be automatically signed-in to JoinedUp with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* JoinedUp single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* JoinedUp supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add JoinedUp from the gallery

To configure the integration of JoinedUp into Microsoft Entra ID, you need to add JoinedUp from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **JoinedUp** in the search box.
1. Select **JoinedUp** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-joinedup'></a>

## Configure and test Microsoft Entra SSO for JoinedUp

Configure and test Microsoft Entra SSO with JoinedUp using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in JoinedUp.

To configure and test Microsoft Entra SSO with JoinedUp, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure JoinedUp SSO](#configure-joinedup-sso)** - to configure the single sign-on settings on application side.
    1. **[Create JoinedUp test user](#create-joinedup-test-user)** - to have a counterpart of B.Simon in JoinedUp that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **JoinedUp** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step: 

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.joinedup.com`

	> [!NOTE]
	> This value isn't real. Update this value with the actual Sign on URL. Contact [JoinedUp Client support team](mailto:support@joinedup.com) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure JoinedUp SSO

To configure single sign-on on **JoinedUp** side, you need to send the **App Federation Metadata Url** to [JoinedUp support team](mailto:support@joinedup.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create JoinedUp test user

In this section, you create a user called Britta Simon in JoinedUp. Work with [JoinedUp support team](mailto:support@joinedup.com) to add the users in the JoinedUp platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to JoinedUp Sign-on URL where you can initiate the login flow. 

* Go to JoinedUp Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the JoinedUp tile in the My Apps, this option redirects to JoinedUp Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure JoinedUp you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
