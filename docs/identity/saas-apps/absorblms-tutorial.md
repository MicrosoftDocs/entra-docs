---
title: Configure Absorb LMS for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Absorb LMS.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Absorb LMS so that I can control who has access to Absorb LMS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Absorb LMS for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Absorb LMS with Microsoft Entra ID. When you integrate Absorb LMS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Absorb LMS.
* Enable your users to be automatically signed-in to Absorb LMS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Absorb LMS single sign-on enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Absorb LMS supports **IDP** initiated SSO

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Absorb LMS from the gallery

To configure the integration of Absorb LMS into Microsoft Entra ID, you need to add Absorb LMS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Absorb LMS** in the search box.
1. Select **Absorb LMS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-absorb-lms'></a>

## Configure and test Microsoft Entra SSO for Absorb LMS

Configure and test Microsoft Entra SSO with Absorb LMS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Absorb LMS.

To configure and test Microsoft Entra SSO with Absorb LMS, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Absorb LMS SSO](#configure-absorb-lms-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Absorb LMS test user](#create-absorb-lms-test-user)** - to have a counterpart of B.Simon in Absorb LMS that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Absorb LMS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up Single Sign-On with SAML** page, select **Edit** button to open **Basic SAML Configuration** dialog.

    If you're using **Absorb 5 - UI** use the following configuration:

    a. In the **Identifier** text box, type a URL using the following pattern::
    `https://<SUBDOMAIN>.myabsorb.com/account/saml`

    b. In the **Reply URL** text box, type a URL using the following pattern::
    `https://<SUBDOMAIN>.myabsorb.com/account/saml`

    If you're using **Absorb 5 - New Learner Experience** use the following configuration:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.myabsorb.com/api/rest/v2/authentication/saml`

    b. In the **Reply URL** text box, type a URL using the following pattern: :
    `https://<SUBDOMAIN>.myabsorb.com/api/rest/v2/authentication/saml`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Absorb LMS Client support team](https://support.absorblms.com/hc/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**.

    ![image](common/edit-attribute.png)

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up Absorb LMS** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Absorb LMS SSO

1. In a new web browser window, sign in to your Absorb LMS company site as an administrator.

2. Select the **Account** button at the top right.

3. In the Account pane, select **Portal Settings**.

    ![The Portal Settings link](./media/absorblms-tutorial/portal.png)

4. Select the **Manage SSO Settings** tab.

    ![The Users tab](./media/absorblms-tutorial/sso.png)

5. On the **Manage Single Sign-On Settings** page, do the following:

   ![Screenshot shows the single sign-on configuration page.](./media/absorblms-tutorial/settings.png)

    a. In the **Name** textbox, enter the name like Microsoft Entra Marketplace SSO.

    b. Select **SAML** as a **Method**.

    c. In Notepad, open the certificate that you downloaded. Remove the **---BEGIN CERTIFICATE---** and **---END CERTIFICATE---** tags. Then, in the **Key** box, paste the remaining content.

    d. In the **Mode** box, select **Identity Provider Initiated**.

    e. In the **Id Property** box, select the attribute that you configured as the user identifier in Microsoft Entra ID. For example, if *nameidentifier* is selected in Microsoft Entra ID, select **Username**.

    f. Select **Sha256** as a **Signature Type**.

    g. In the **Login URL** box, paste the **User Access URL** from the application's **Properties** page.

    h. In the **Logout URL**, paste the **Sign-Out URL** value that you copied from the **Configure sign-on** window.

    i. Toggle **Automatically Redirect** to **On**.

6. Select **Save.**

    ![The Only Allow SSO Login toggle](./media/absorblms-tutorial/save.png)

### Create Absorb LMS test user

For Microsoft Entra users to sign in to Absorb LMS, they must be set up in Absorb LMS. In the case of Absorb LMS, provisioning is a manual task.

**To configure user provisioning, perform the following steps:**

1. Sign in to your Absorb LMS company site as an administrator.

2. In the **Users** pane, select **Users**.

    ![The Users link](./media/absorblms-tutorial/users.png)

3. Select **User** tab.

    ![The Add New drop-down list](./media/absorblms-tutorial/add.png)

4. On the **Add User** page, do the following:

    ![The Add User page](./media/absorblms-tutorial/user.png)

    a. In the **First Name** box, type the first name, such as **Britta**.

    b. In the **Last Name** box, type the last name, such as **Simon**.

    c. In the **Username** box, type a full name, such as **Britta Simon**.

    d. In the **Password** box, type user password.

    e. In the **Confirm Password** box, retype the password.

    f. Set the **Is Active** toggle to **Active**.

5. Select **Save.**

    ![The Only Allow SSO Login toggle](./media/absorblms-tutorial/save.png)

    > [!NOTE]
    > By Default, User Provisioning isn't  enabled in SSO. If the customer wants to enable this feature, they have to set it up as mentioned in [this](https://support.absorblms.com/hc/en-us/articles/360014083294-Incoming-SAML-2-0-SSO-Account-Provisioning) documentation. Also please note that User Provisioning is only available on **Absorb 5 - New Learner Experience** with ACS URL-`https://company.myabsorb.com/api/rest/v2/authentication/saml`

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Absorb LMS for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Absorb LMS tile in the My Apps, you should be automatically signed in to the Absorb LMS for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Absorb LMS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
