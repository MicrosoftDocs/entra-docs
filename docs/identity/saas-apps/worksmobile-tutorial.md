---
title: Configure LINE WORKS for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and LINE WORKS.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and LINE WORKS so that I can control who has access to LINE WORKS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure LINE WORKS for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate LINE WORKS with Microsoft Entra ID.
Integrating LINE WORKS with Microsoft Entra ID provides you with the following benefits:

* You can control in Microsoft Entra ID who has access to LINE WORKS.
* You can enable your users to be automatically signed-in to LINE WORKS (Single Sign-On) with their Microsoft Entra accounts.
* You can manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* LINE WORKS single sign-on enabled subscription

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* LINE WORKS supports **SP** initiated SSO

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding LINE WORKS from the gallery

To configure the integration of LINE WORKS into Microsoft Entra ID, you need to add LINE WORKS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **LINE WORKS** in the search box.
1. Select **LINE WORKS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso'></a>

## Configure and test Microsoft Entra SSO

Configure and test Microsoft Entra SSO with LINE WORKS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in LINE WORKS.

To configure and test Microsoft Entra SSO with LINE WORKS, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
    * **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
2. **[Configure LINE WORKS SSO](#configure-line-works-sso)** - to configure the Single Sign-On settings on application side.
    * **[Create LINE WORKS test user](#create-line-works-test-user)** - to have a counterpart of Britta Simon in LINE WORKS that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

### Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **LINE WORKS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://auth.worksmobile.com/d/login/<domain>/`

    b. In the **Response URL** text box, type a URL using the following pattern:
    `https://auth.worksmobile.com/acs/ <domain>`

    > [!NOTE]
    > These values aren't real. Update these values with actual Sign-On URL and Response URL. Contact [LINE WORKS support team](https://line.worksmobile.com/jp/en/contactus/) to get the values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up LINE WORKS** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure LINE WORKS SSO

To configure single sign-on on **LINE WORKS** side, please read the [LINE WORKS SSO documents](https://jp1-developers.worksmobile.com/jp/docs/?lang=en) and configure a LINE WORKS setting.

> [!NOTE]
> You need to convert the downloaded Certificate file from .cert to .pem


### Create LINE WORKS test user

In this section, you create a user called Britta Simon in LINE WORKS. Access [LINE WORKS admin page](https://admin.worksmobile.com) and add the users in the LINE WORKS platform.

### Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

1. Select **Test this application**, this option redirects to LINE WORKS Sign-on URL where you can initiate the login flow. 

2. Go to LINE WORKS Sign-on URL directly and initiate the login flow from there.

3. You can use Microsoft Access Panel. When you select the LINE WORKS tile in the Access Panel, this option redirects to LINE WORKS Sign-on URL. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure LINE WORKS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
