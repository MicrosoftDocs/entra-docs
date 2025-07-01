---
title: Configure TimeTrack for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and TimeTrack.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and TimeTrack so that I can control who has access to TimeTrack, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure TimeTrack for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate TimeTrack with Microsoft Entra ID. When you integrate TimeTrack with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to TimeTrack.
* Enable your users to be automatically signed-in to TimeTrack with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* TimeTrack single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* TimeTrack supports **SP and IDP** initiated SSO.

## Add TimeTrack from the gallery

To configure the integration of TimeTrack into Microsoft Entra ID, you need to add TimeTrack from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **TimeTrack** in the search box.
1. Select **TimeTrack** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-timetrack'></a>

## Configure and test Microsoft Entra SSO for TimeTrack

Configure and test Microsoft Entra SSO with TimeTrack using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in TimeTrack.

To configure and test Microsoft Entra SSO with TimeTrack, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure TimeTrack SSO](#configure-timetrack-sso)** - to configure the single sign-on settings on application side.
    1. **[Create TimeTrack test user](#create-timetrack-test-user)** - to have a counterpart of B.Simon in TimeTrack that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **TimeTrack** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<tenant>.timetrackenterprise.com/api/v2/azure/saml20`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<tenant>.timetrackenterprise.com/api/v2/azure/callback`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<tenant>.timetrackenterprise.com`

    d. In the **Relay State** text box, type a URL using the following pattern:
    `<ID>`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier, Reply URL, Sign-on URL and Relay State. Contact [TimeTrack Client support team](mailto:info@timetrackapp.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Edit SAML Signing Certificate](common/edit-certificate.png)

1. In the **SAML Signing Certificate** section, copy the **Thumbprint Value** and save it on your computer.

    ![Copy Thumbprint value](common/copy-thumbprint.png)

1. On the **Set up TimeTrack** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure TimeTrack SSO

To configure single sign-on on **TimeTrack** side, you need to send the **Thumbprint Value** and appropriate copied URLs from the application configuration to [TimeTrack support team](mailto:info@timetrackapp.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create TimeTrack test user

In this section, you create a user called Britta Simon in TimeTrack. Work with [TimeTrack support team](mailto:info@timetrackapp.com) to add the users in the TimeTrack platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to TimeTrack Sign on URL where you can initiate the login flow.  

* Go to TimeTrack Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the TimeTrack for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the TimeTrack tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the TimeTrack for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure TimeTrack you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
