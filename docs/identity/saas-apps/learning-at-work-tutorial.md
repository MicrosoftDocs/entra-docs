---
title: Configure Learning at Work for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Learning at Work.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Learning at Work so that I can control who has access to Learning at Work, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Learning at Work for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Learning at Work with Microsoft Entra ID. When you integrate Learning at Work with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Learning at Work.
* Enable your users to be automatically signed-in to Learning at Work with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Learning at Work single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Learning at Work supports **SP** initiated SSO.

## Add Learning at Work from the gallery

To configure the integration of Learning at Work into Microsoft Entra ID, you need to add Learning at Work from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Learning at Work** in the search box.
1. Select **Learning at Work** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-learning-at-work'></a>

## Configure and test Microsoft Entra SSO for Learning at Work

Configure and test Microsoft Entra SSO with Learning at Work using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Learning at Work.

To configure and test Microsoft Entra SSO with Learning at Work, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Learning at Work SSO](#configure-learning-at-work-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Learning at Work test user](#create-learning-at-work-test-user)** - to have a counterpart of B.Simon in Learning at Work that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Learning at Work** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<subdomain>.sabacloud.com/Saba/Web/<company code>`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<subdomain>.sabacloud.com/Saba/saml/SSO/alias/<company name>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Learning at Work Client support team](https://www.learninga-z.com/site/contact/support) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

5. Learning at Work application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**.

	You can update the **nameidentifier** value in Microsoft Entra ID based on your Organization setup and this value needs to match with the **User ID** in the SABA cloud, for that you need to edit the attribute mapping by selecting **pencil** icon and change the attribute mapping.

	![image](common/edit-attribute.png)

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up Learning at Work** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Learning at Work SSO

To configure single sign-on on **Learning at Work** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Learning at Work support team](https://www.learninga-z.com/site/contact/support). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Learning at Work test user

In this section, you create a user called B.Simon in Learning at Work. Work with [Learning at Work support team](https://www.learninga-z.com/site/contact/support) to add the users in the Learning at Work platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Learning at Work Sign-on URL where you can initiate the login flow. 

* Go to Learning at Work Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Learning at Work tile in the My Apps, this option redirects to Learning at Work Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Learning at Work you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
