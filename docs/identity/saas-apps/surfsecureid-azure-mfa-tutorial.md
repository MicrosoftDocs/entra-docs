---
title: Configure SURFsecureID - Azure MFA for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SURFsecureID - Azure MFA.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SURFsecureID - Azure MFA so that I can control who has access to SURFsecureID - Azure MFA, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SURFsecureID - Azure MFA for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SURFsecureID - Azure MFA with Microsoft Entra ID. When you integrate SURFsecureID - Azure MFA with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SURFsecureID - Azure MFA.
* Enable your users to be automatically signed-in to SURFsecureID - Azure MFA with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SURFsecureID - Azure MFA single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SURFsecureID - Azure MFA supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add SURFsecureID - Azure MFA from the gallery

To configure the integration of SURFsecureID - Azure MFA into Microsoft Entra ID, you need to add SURFsecureID - Azure MFA from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SURFsecureID - Azure MFA** in the search box.
1. Select **SURFsecureID - Azure MFA** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-surfsecureid---azure-mfa'></a>

## Configure and test Microsoft Entra SSO for SURFsecureID - Azure MFA

Configure and test Microsoft Entra SSO with SURFsecureID - Azure MFA using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SURFsecureID - Azure MFA.

To configure and test Microsoft Entra SSO with SURFsecureID - Azure MFA, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SURFsecureID - Azure MFA SSO](#configure-surfsecureid---azure-mfa-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SURFsecureID - Azure MFA test user](#create-surfsecureid---azure-mfa-test-user)** - to have a counterpart of B.Simon in SURFsecureID - Azure MFA that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SURFsecureID - Azure MFA** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type one of the following URLs:

    | **Environment** | **URL** |
    |-------|------|
    | Staging | `https://azuremfa.test.surfconext.nl/saml/metadata` |
    | Production | `https://azuremfa.surfconext.nl/saml/metadata` |

    b. In the **Reply URL** textbox, type one of the following URLs:

    | **Environment** | **URL** |
    |-------|------|
    | Staging | `https://azuremfa.test.surfconext.nl/saml/acs` |
    | Production | `https://azuremfa.surfconext.nl/saml/acs` |

	b. In the **Sign on URL** text box, type one of the following URLs:
    
    | **Environment** | **URL** |
    |-------|------|
    | Staging | `https://sa.test.surfconext.nl` |
    | Production | `https://sa.surfconext.nl` |

1. SURFsecureID - Azure MFA application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, SURFsecureID - Azure MFA application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute |
	| --------- | --------- |
	| urn:mace:dir:attribute-def:mail | user.mail |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SURFsecureID - Azure MFA SSO

To configure single sign-on on **SURFsecureID - Azure MFA** side, you need to send the **App Federation Metadata Url** to [SURFsecureID - Azure MFA support team](mailto:support@surfconext.nl). They set this setting to have the SAML SSO connection set properly on both sides.

### Create SURFsecureID - Azure MFA test user

In this section, you create a user called Britta Simon in SURFsecureID - Azure MFA. Work with [SURFsecureID - Azure MFA support team](mailto:support@surfconext.nl) to add the users in the SURFsecureID - Azure MFA platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to SURFsecureID - Azure MFA Sign-on URL where you can initiate the login flow. 

* Go to SURFsecureID - Azure MFA Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the SURFsecureID - Azure MFA tile in the My Apps, this option redirects to SURFsecureID - Azure MFA Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure SURFsecureID - Azure MFA you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
