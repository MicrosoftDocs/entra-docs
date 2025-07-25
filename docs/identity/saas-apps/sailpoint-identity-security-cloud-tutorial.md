---
title: Configure SailPoint Identity Security Cloud for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SailPoint Identity Security Cloud.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SailPoint Identity Security Cloud so that I can control who has access to SailPoint Identity Security Cloud, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SailPoint Identity Security Cloud for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SailPoint Identity Security Cloud with Microsoft Entra ID. When you integrate SailPoint Identity Security Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SailPoint Identity Security Cloud.
* Enable your users to be automatically signed-in to SailPoint Identity Security Cloud with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SailPoint Identity Security Cloud active subscription. If you don't have Identity Security Cloud, please contact [SailPoint Identity Security Cloud support team](mailto:support@sailpoint.com).

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SailPoint Identity Security Cloud supports **SP and IDP** initiated SSO.

## Add SailPoint Identity Security Cloud from the gallery

To configure the integration of SailPoint Identity Security Cloud into Microsoft Entra ID, you need to add SailPoint Identity Security Cloud from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SailPoint Identity Security Cloud** in the search box.
1. Select **SailPoint Identity Security Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-sailpoint-identitysecuritycloud'></a>

## Configure and test Microsoft Entra SSO for SailPoint Identity Security Cloud

Configure and test Microsoft Entra SSO with SailPoint Identity Security Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SailPoint Identity Security Cloud.

To configure and test Microsoft Entra SSO with SailPoint Identity Security Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SailPoint Identity Security Cloud SSO](#configure-sailpoint-identity-security-cloud-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SailPoint Identity Security Cloud test user](#create-sailpoint-identity-security-cloud-test-user)** - to have a counterpart of B.Simon in SailPoint Identity Security Cloud that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SailPoint Identity Security Cloud** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<TENANT_NAME>.identitynow.com/sp`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<TENANT_NAME>.login.sailpoint.com/saml/SSO/alias/<TENANT_NAME>-sp`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<TENANT_NAME>.identitynow.com/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [SailPoint Identity Security Cloud Client support team](mailto:support@sailpoint.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up SailPoint Identity Security Cloud** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SailPoint Identity Security Cloud SSO

1. In a different web browser window, sign in to your SailPoint Identity Security Cloud company site as an administrator.

1. Go to **Global -> Security Settings -> Service Provider** make the following configuration changes.

    [![Screenshot of sailpoint sso configuration.](./media/sailpoint-identitynow-tutorial/configuration.png "sailpoint")](./media/sailpoint-identitynow-tutorial/configuration.png#lightbox)

    a. Enable Remote Identity Provider.

    b. In the **Entity ID** field, paste **Entity ID** value, which you copied previously.

    c. In the **Login URL for Post** field, paste **Login URL** value, which you copied previously.

    d. In the **Login URL for Redirect** field, paste **Login URL** value, which you copied previously.

    e. In the **Logout URL** field, enter the value `https://<IDN Tenant>.login.sailpoint.com/signout`.

    f. In the **SAML Request Attribute** section, select the following values.

    * Identity Mapping Attribute - `uid`
    * SAML NameID - `Unspecified`
    * SAML Binding - `Post`
    * Exclude Requested Authentication Context - `checked`

    g. In the **Signing Certificate**, select **Import** to upload the downloaded **Certificate (Base64)** from Azure portal.

### Create SailPoint Identity Security Cloud test user

In this section, you create a user called Britta Simon in SailPoint Identity Security Cloud. Work with [SailPoint Identity Security Cloud support team](mailto:support@sailpoint.com) to add the users in the SailPoint Identity Security Cloud platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to SailPoint Identity Security Cloud Sign on URL where you can initiate the login flow.  

* Go to SailPoint Identity Security Cloud Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the SailPoint Identity Security Cloud for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the SailPoint Identity Security Cloud tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the SailPoint Identity Security Cloud for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure SailPoint Identity Security Cloud you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
