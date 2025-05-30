---
title: Configure Image Relay for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Image Relay.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Image Relay so that I can control who has access to Image Relay, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Image Relay for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Image Relay with Microsoft Entra ID. When you integrate Image Relay with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Image Relay.
* Enable your users to be automatically signed-in to Image Relay with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Image Relay single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Image Relay supports **SP** initiated SSO.

## Add Image Relay from the gallery

To configure the integration of Image Relay into Microsoft Entra ID, you need to add Image Relay from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Image Relay** in the search box.
1. Select **Image Relay** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-image-relay'></a>

## Configure and test Microsoft Entra SSO for Image Relay

Configure and test Microsoft Entra SSO with Image Relay using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Image Relay.

To configure and test Microsoft Entra SSO with Image Relay, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Image Relay SSO](#configure-image-relay-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Image Relay test user](#create-image-relay-test-user)** - to have a counterpart of B.Simon in Image Relay that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Image Relay** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<COMPANYNAME>.imagerelay.com/sso/metadata`

	b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<COMPANYNAME>.imagerelay.com/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [Image Relay Client support team](http://support.imagerelay.com/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

4. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Image Relay** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Image Relay SSO

1. In another browser window, sign in to your Image Relay company site as an administrator.

2. In the toolbar on the top, select the **Users & Permissions** workload.

    ![Screenshot shows Users & Permissions selected from the toolbar.](./media/imagerelay-tutorial/users.png) 

3. Select **Create New Permission**.

    ![Screenshot shows a text box to enter Permission title and an option to choose Permission Type.](./media/imagerelay-tutorial/create-permission.png)

4. In the **Single Sign On Settings** workload, select the **This Group can only sign-in via Single Sign On** check box, and then select **Save**.

    ![Screenshot shows the Single Sign On Settings where you can select the option.](./media/imagerelay-tutorial/save-settings.png) 

5. Go to **Account Settings**.

    ![Screenshot shows the Account Settings toolbar option.](./media/imagerelay-tutorial/account.png) 

6. Go to the **Single Sign On Settings** workload.

    ![Screenshot shows the Single Sign On Settings menu option.](./media/imagerelay-tutorial/settings.png)

7. On the **SAML Settings** dialog, perform the following steps:

	![Screenshot shows the SAML Settings dialog box where you can enter the information.](./media/imagerelay-tutorial/information.png)

    a. In **Login URL** textbox, paste the value of **Login URL**..

    b. In **Logout URL**  textbox, paste the value of **Logout URL**..

    c. As **Name Id Format**, select **urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress**.

    d. As **Binding Options for Requests from the Service Provider (Image Relay)**, select **POST Binding**.

    e. Under **x.509 Certificate**, select **Update Certificate**.

    ![Screenshot shows the option to Update Certificate.](./media/imagerelay-tutorial/certificate.png)

    f. Open the downloaded certificate in notepad, copy the content, and then paste it into the **x.509 Certificate** textbox.

    ![Screenshot shows the x dot 509 Certificate.](./media/imagerelay-tutorial/update-certificate.png)

    g. In **Just-In-Time User Provisioning** section, select the **Enable Just-In-Time User Provisioning**.

    ![Screenshot shows the Just-In-Time User Provisioning section with the enable control selected.](./media/imagerelay-tutorial/provisioning.png)

    h. Select the permission group (for example, **SSO Basic**) which is allowed to sign in only through single sign-on.

    ![Screenshot shows the Just-In-Time User Provisioning section with S S O Basic selected.](./media/imagerelay-tutorial/user-provisioning.png)

    i. Select **Save**.

### Create Image Relay test user

The objective of this section is to create a user called Britta Simon in Image Relay.

**To create a user called Britta Simon in Image Relay, perform the following steps:**

1. Sign-on to your Image Relay company site as an administrator.

2. Go to **Users & Permissions** and select **Create SSO User**.

    ![Screenshot shows Create S S O User selected from the menu.](./media/imagerelay-tutorial/create-user.png) 

3. Enter the **Email**, **First Name**, **Last Name**, and **Company** of the user you want to provision and select the permission group (for example, SSO Basic) which is the group that can sign in only through single sign-on.

    ![Screenshot shows Create a S S O User page where you can enter the required information.](./media/imagerelay-tutorial/user-details.png)

4. Select **Create**.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Image Relay Sign-on URL where you can initiate the login flow. 

* Go to Image Relay Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Image Relay tile in the My Apps, this option redirects to Image Relay Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Image Relay you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
