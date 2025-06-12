---
title: Configure Evidence.com for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Evidence.com.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Evidence.com so that I can control who has access to Evidence.com, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Evidence.com for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Evidence.com with Microsoft Entra ID. When you integrate Evidence.com with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Evidence.com.
* Enable your users to be automatically signed-in to Evidence.com with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Evidence.com single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Evidence.com supports **SP** initiated SSO.

## Add Evidence.com from the gallery

To configure the integration of Evidence.com into Microsoft Entra ID, you need to add Evidence.com from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Evidence.com** in the search box.
1. Select **Evidence.com** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-evidencecom'></a>

## Configure and test Microsoft Entra SSO for Evidence.com

Configure and test Microsoft Entra SSO with Evidence.com using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Evidence.com.

To configure and test Microsoft Entra SSO with Evidence.com, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Evidence.com SSO](#configure-evidencecom-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Evidence.com test user](#create-evidencecom-test-user)** - to have a counterpart of B.Simon in Evidence.com that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Evidence.com** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, perform the following steps:

    1. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<yourtenant>.evidence.com`

    1. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<yourtenant>.evidence.com`

    1. In the **Reply URL** textbox, type a URL using the following pattern: 
    `https://<your tenant>.evidence.com/?class=UIX&proc=Login`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Sign on URL, Identifier and Reply URL. Contact [Evidence.com Client support team](https://my.axon.com/s/contactsupport) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Evidence.com** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Evidence.com SSO

1. In a separate web browser window, sign into your Evidence.com tenant as an administrator and navigate to **Admin** Tab.

2. Select **Agency Single Sign On**.

3. Select **SAML Based Single Sign On**.

4. Copy the **Microsoft Entra Identifier**, **Login URL** and **Logout URL** values shown in the Azure portal and to the corresponding fields in Evidence.com.

5. Open your downloaded Certificate(Base64) file in notepad, copy the content of it into your clipboard, and then paste it to the **Security Certificate** box. 

6. Save the configuration in Evidence.com.

### Create Evidence.com test user

For Microsoft Entra users to be able to sign in, they must be provisioned for access inside the Evidence.com application. This section describes how to create Microsoft Entra user accounts inside Evidence.com.

**To provision a user account in Evidence.com:**

1. In a web browser window, sign into your Evidence.com company site as an administrator.

2. Navigate to **Admin** tab.

3. Select **Add User**.

4. Select the **Add** button.

5. The **Email Address** of the added user must match the username of the users in Microsoft Entra who you wish to give access. If the username and email address aren't the same value in your organization, you can use the **Evidence.com > Attributes > Single Sign-On** section of the Azure portal to change the nameidenitifer sent to Evidence.com to be the email address.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Evidence.com Sign-on URL where you can initiate the login flow. 

* Go to Evidence.com Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Evidence.com tile in the My Apps, this option redirects to Evidence.com Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Evidence.com you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
