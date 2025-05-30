---
title: Configure Land Gorilla for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Land Gorilla.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Land Gorilla Client so that I can control who has access to Land Gorilla Client, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Land Gorilla for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Land Gorilla with Microsoft Entra ID. When you integrate Land Gorilla with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Land Gorilla.
* Enable your users to be automatically signed-in to Land Gorilla with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Land Gorilla single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Land Gorilla supports **IDP** initiated SSO.

## Add Land Gorilla from the gallery

To configure the integration of Land Gorilla into Microsoft Entra ID, you need to add Land Gorilla from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Land Gorilla** in the search box.
1. Select **Land Gorilla** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-land-gorilla'></a>

## Configure and test Microsoft Entra SSO for Land Gorilla

Configure and test Microsoft Entra SSO with Land Gorilla using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Land Gorilla.

To configure and test Microsoft Entra SSO with Land Gorilla, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Land Gorilla SSO](#configure-land-gorilla-sso)** - to configure the single sign-on settings on application side.
   1. **[Create Land Gorilla test user](#create-land-gorilla-test-user)** - to have a counterpart of B.Simon in Land Gorilla that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Land Gorilla** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

   a. In the **Identifier** text box, type a URL using one of the following patterns:

   | **Identifier** |
   |------|
   | `https://<customer domain>.landgorilla.com/` |
   | `https://www.<customer domain>.landgorilla.com` |

   b. In the **Reply URL** text box, type a URL using one of the following patterns:

   | **Reply URL** |
   |-----|
   | `https://<customer domain>.landgorilla.com/simplesaml/module.php/core/authenticate.php` |
   | `https://www.<customer domain>.landgorilla.com/simplesaml/module.php/core/authenticate.php` |
   | `https://<customer domain>.landgorilla.com/simplesaml/module.php/saml/sp/saml2-acs.php/default-sp` |
   | `https://www.<customer domain>.landgorilla.com/simplesaml/module.php/saml/sp/saml2-acs.php/default-sp` |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Here we suggest you to use the unique value of string in the Identifier. Contact [Land Gorilla Client support team](https://www.landgorilla.com/support/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Land Gorilla** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Land Gorilla SSO

To configure single sign-on on **Land Gorilla** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Land Gorilla support team](https://www.landgorilla.com/support/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Land Gorilla test user

In this section, you create a user called Britta Simon in Land Gorilla. Work with [Land Gorilla support team](https://www.landgorilla.com/support/) to add the users in the Land Gorilla platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Land Gorilla for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Land Gorilla tile in the My Apps, you should be automatically signed in to the Land Gorilla for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Land Gorilla you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
