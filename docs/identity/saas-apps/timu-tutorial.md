---
title: Configure TIMU for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and TIMU.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and TIMU so that I can control who has access to TIMU, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure TIMU for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate TIMU with Microsoft Entra ID. When you integrate TIMU with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to TIMU.
* Enable your users to be automatically signed-in to TIMU with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* TIMU single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* TIMU supports **SP** initiated SSO

* TIMU supports **Just In Time** user provisioning

## Adding TIMU from the gallery

To configure the integration of TIMU into Microsoft Entra ID, you need to add TIMU from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **TIMU** in the search box.
1. Select **TIMU** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-timu'></a>

## Configure and test Microsoft Entra SSO for TIMU

Configure and test Microsoft Entra SSO with TIMU using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in TIMU.

To configure and test Microsoft Entra SSO with TIMU, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure TIMU SSO](#configure-timu-sso)** - to configure the single sign-on settings on application side.
    1. **[Create TIMU test user](#create-timu-test-user)** - to have a counterpart of B.Simon in TIMU that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **TIMU** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type one of the following URLs:

    | Sign-on URL |
    |-------------|
    | `https://auth.timu.com` |
    | `https://auth.timu.life` |
    |

    b. In the **Identifier (Entity ID)** text box, type one of the following patterns:
    
    | Identifier |
    |-------------|
    | `https://<SUBDOMAIN>.timu.com/api/login/saml/callback` |
    | `https://<SUBDOMAIN>.timu.life/api/login/saml/callback`|
    |

    c. In the **Reply URL** text box, type one of the following patterns:
    
    | Reply URL |
    |-------------|
    | `https://<SUBDOMAIN>.timu.com/api/login/saml/callback` |
    | `https://<SUBDOMAIN>.timu.life/api/login/saml/callback`|
    |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [TIMU Client support team](mailto:support@timu.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure TIMU SSO

To configure single sign-on on **TIMU** side, you need to send the **App Federation Metadata Url** to [TIMU support team](mailto:support@timu.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create TIMU test user

In this section, a user called Britta Simon is created in TIMU. TIMU supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in TIMU, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to TIMU Sign-on URL where you can initiate the login flow. 

* Go to TIMU Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft Access Panel. When you select the TIMU tile in the Access Panel, this option redirects to TIMU Sign-on URL. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure TIMU you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
