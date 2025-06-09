---
title: Configure Nomadesk for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Nomadesk.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Nomadesk so that I can control who has access to Nomadesk, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Nomadesk for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Nomadesk with Microsoft Entra ID. When you integrate Nomadesk with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Nomadesk.
* Enable your users to be automatically signed-in to Nomadesk with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Nomadesk single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Nomadesk supports **SP** initiated SSO.

* Nomadesk supports **Just In Time** user provisioning.

## Add Nomadesk from the gallery

To configure the integration of Nomadesk into Microsoft Entra ID, you need to add Nomadesk from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Nomadesk** in the search box.
1. Select **Nomadesk** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-nomadesk'></a>

## Configure and test Microsoft Entra SSO for Nomadesk

Configure and test Microsoft Entra SSO with Nomadesk using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Nomadesk.

To configure and test Microsoft Entra SSO with Nomadesk, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Nomadesk SSO](#configure-nomadesk-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Nomadesk test user](#create-nomadesk-test-user)** - to have a counterpart of B.Simon in Nomadesk that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Nomadesk** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://secure.nomadesk.com/saml/<instancename>`

	b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://mynomadesk.com/logon/saml/<TENANTID>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [Nomadesk Client support team](mailto:support@nomadesk.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Nomadesk** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Nomadesk SSO

To configure single sign-on on **Nomadesk** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Nomadesk support team](mailto:support@nomadesk.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Nomadesk test user

In this section, a user called Britta Simon is created in Nomadesk. Nomadesk supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Nomadesk, a new one is created after authentication.

>[!NOTE]
>If you need to create a user manually, you need to contact the [Nomadesk support team](mailto:support@nomadesk.com).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Nomadesk Sign-on URL where you can initiate the login flow. 

* Go to Nomadesk Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Nomadesk tile in the My Apps, this option redirects to Nomadesk Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Nomadesk you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
