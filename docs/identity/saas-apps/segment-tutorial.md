---
title: Configure Segment for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Segment.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Segment so that I can control who has access to Segment, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Segment for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Segment with Microsoft Entra ID. When you integrate Segment with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Segment.
* Enable your users to be automatically signed-in to Segment with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Segment single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Segment supports **SP and IDP** initiated SSO.
* Segment supports **Just In Time** user provisioning.
* Segment supports [Automated user provisioning](segment-provisioning-tutorial.md).

## Add Segment from the gallery

To configure the integration of Segment into Microsoft Entra ID, you need to add Segment from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Segment** in the search box.
1. Select **Segment** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-segment'></a>

## Configure and test Microsoft Entra SSO for Segment

Configure and test Microsoft Entra SSO with Segment using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Segment.

To configure and test Microsoft Entra SSO with Segment, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Segment SSO](#configure-segment-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Segment test user](#create-segment-test-user)** - to have a counterpart of B.Simon in Segment that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Segment** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `urn:auth0:segment-prod:samlp-<CUSTOMER_VALUE>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://segment-prod.auth0.com/login/callback?connection=<CUSTOMER_VALUE>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://app.segment.com`

	> [!NOTE]
	> These values are placeholders. You need to use the actual Identifier and Reply URL. Steps for getting these values are described later in this article.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Segment** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Segment SSO

1. In a new web browser window, sign in to your Segment company site as an administrator.

1. Select **Settings Icon** and scroll down to **AUTHENTICATION** and select **Connections**.

    ![Screenshot that shows the "Settings" icon selected, and "Connections" selected from the "Authentication" menu.](./media/segment-tutorial/connections.PNG)

1. Select **Add new Connection**.

    ![Screenshot that shows the "Connections" section with the "Add new Connection" button selected.](./media/segment-tutorial/new-connections.PNG)

1. Select **SAML 2.0** as a connection to configure and select **Select Connection** button.

    ![Screenshot that shows the "Choose a Connection" section with "S A M L 2.0" and the "Select Connection" button selected.](./media/segment-tutorial/select-connections.PNG)

1. On the following page, perform the following steps:

    ![Screenshot that shows the "Configure Identity Provider" page with the "Single Sign-On U R L" and "Audience U R L" text boxes highlighted, and the "Next" button selected.](./media/segment-tutorial/configure.PNG)

    a. Copy the **Single Sign-On URL** value and paste it into the **Reply URL** box in the **Basic SAML Configuration** dialog box.

    b. Copy the ****Audience URL**** value and paste it into the **Identifier URL** box in the **Basic SAML Configuration** dialog box.

    c. Select **Next**.

    ![Segment Configuration](./media/segment-tutorial/certificate.PNG)

1. In the **SAML 2.0 Endpoint URL** box, paste the **Login URL** value that you copied.

1. Open the downloaded **Certificate(Base64)** into Notepad and paste the content into the **Public Certificate** textbox.

1. Select **Configure Connection**.

### Create Segment test user

In this section, a user called B.Simon is created in Segment. Segment supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Segment, a new one is created after authentication.

Segment also supports automatic user provisioning, you can find more details [here](./segment-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Segment Sign on URL where you can initiate the login flow.  

* Go to Segment Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Segment for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Segment tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Segment for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Segment you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
