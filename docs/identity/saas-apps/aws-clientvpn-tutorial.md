---
title: Configure AWS ClientVPN for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and AWS ClientVPN.
author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/09/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and AWS ClientVPN so that I can control who has access to AWS ClientVPN, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure AWS ClientVPN for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate AWS ClientVPN with Microsoft Entra ID. When you integrate AWS ClientVPN with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to AWS ClientVPN.
* Enable your users to be automatically signed-in to AWS ClientVPN with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* AWS ClientVPN single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* AWS ClientVPN supports **SP** initiated SSO.

* AWS ClientVPN supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add AWS ClientVPN from the gallery

To configure the integration of AWS ClientVPN into Microsoft Entra ID, you need to add AWS ClientVPN from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **AWS ClientVPN** in the search box.
1. Select **AWS ClientVPN** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-aws-clientvpn'></a>

## Configure and test Microsoft Entra SSO for AWS ClientVPN

Configure and test Microsoft Entra SSO with AWS ClientVPN using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in AWS ClientVPN.

To configure and test Microsoft Entra SSO with AWS ClientVPN, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure AWS ClientVPN SSO](#configure-aws-clientvpn-sso)** - to configure the single sign-on settings on application side.
    1. **[Create AWS ClientVPN test user](#create-aws-clientvpn-test-user)** - to have a counterpart of B.Simon in AWS ClientVPN that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **AWS ClientVPN** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<LOCALHOST>`

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | Reply URL |
    |------------|
    | `http://<LOCALHOST>` |
    | `https://self-service.clientvpn.amazonaws.com/api/auth/sso/saml` |
    |

	> [!NOTE]
	> These values aren't real.  Update these values with the actual Sign on URL and Reply URL.  The Sign on URL and Reply URL can have the same value (`http://127.0.0.1:35001`). Refer to [AWS Client VPN Documentation](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html#ad) for details.   You can also refer to the patterns shown in the **Basic SAML Configuration** section. Contact [AWS ClientVPN support team](https://aws.amazon.com/contact-us/) for any configuration issues. 

1. AWS ClientVPN application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, AWS ClientVPN application expects few more attributes to be passed back in the SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| -------------- | --------- |
	| memberOf | user.groups |
    | FirstName | user.givenname |
    | LastName | user.surname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. In the **SAML Signing Certificate** section, select the edit icon and change the **Signing Option** to **Sign SAML response and assertion**. Select **Save**.

1. On the **Set up AWS ClientVPN** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure AWS ClientVPN SSO

Follow the instructions given in the [link](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html#federated-authentication) to configure single sign-on on AWS ClientVPN side.

### Create AWS ClientVPN test user

In this section, a user called Britta Simon is created in AWS ClientVPN. AWS ClientVPN supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in AWS ClientVPN, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to AWS ClientVPN Sign-on URL where you can initiate the login flow. 

* Go to AWS ClientVPN Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the AWS ClientVPN tile in the My Apps, this option redirects to AWS ClientVPN Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure AWS ClientVPN you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
