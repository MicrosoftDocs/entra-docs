---
title: Configure ContractSafe Saml2 SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ContractSafe Saml2 SSO.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ContractSafe Saml2 SSO so that I can control who has access to ContractSafe Saml2 SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ContractSafe Saml2 SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ContractSafe Saml2 SSO with Microsoft Entra ID. When you integrate ContractSafe Saml2 SSO with Microsoft Entra ID, you can:

* Control who has access to ContractSafe Saml2 SSO in Microsoft Entra ID.
* Enable your users to automatically sign in to ContractSafe Saml2 SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location: the Azure portal.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A ContractSafe Saml2 SSO subscription with SSO enabled.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ContractSafe Saml2 SSO supports **IDP**-initiated SSO.

## Add ContractSafe Saml2 SSO from the gallery

To configure the integration of ContractSafe Saml2 SSO into Microsoft Entra ID, you need to add ContractSafe Saml2 SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ContractSafe Saml2 SSO** in the search box.
1. Select **ContractSafe Saml2 SSO** from the results panel, and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-contractsafe-saml2-sso'></a>

## Configure and test Microsoft Entra SSO for ContractSafe Saml2 SSO

Configure and test Microsoft Entra SSO with ContractSafe Saml2 SSO by using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ContractSafe Saml2 SSO.

To configure and test Microsoft Entra SSO with ContractSafe Saml2 SSO, perform the following steps:

1. [Configure Microsoft Entra SSO](#configure-azure-ad-sso) to enable your users to use this feature.
   1. Create a Microsoft Entra test user to test Microsoft Entra SSO by using the **B.Simon** account.
   1. Assign the Microsoft Entra test user to enable **B.Simon** to use Microsoft Entra SSO.
1. [Configure ContractSafe Saml2 SSO](#configure-contractsafe-saml2-sso) to configure the SSO settings on application side.
   1. [Create a ContractSafe Saml2 SSO test user](#create-a-contractsafe-saml2-sso-test-user) to have a counterpart of **B.Simon** in ContractSafe Saml2 SSO that's linked to the Microsoft Entra representation of the user.
1. [Test SSO](#test-sso) to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Azure portal:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ContractSafe Saml2 SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

   a. In the **Identifier** text box, type a URL by using the following pattern:
    `https://app.contractsafe.com/saml2_auth/<UNIQUEID>/acs/`

   b. In the **Reply URL** text box, type a URL by using the following pattern:
    `https://app.contractsafe.com/saml2_auth/<UNIQUEID>/acs/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact the [ContractSafe Saml2 SSO Client support team](mailto:support@contractsafe.com) to get these values. You can also refer to the formats shown in the **Basic SAML Configuration** section.

1. ContractSafe Saml2 SSO expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Common default attributes](common/default-attributes.png)

1. In addition to the default attributes, the ContractSafe Saml2 SSO application expects a few more attributes to be passed back in the SAML response. These attributes are pre-populated, but you can review them according to your requirements. The following list shows the additional attributes.

	| Name | Source attribute|
	| ---------------| --------------- |
	| emailname | user.userprincipalname |
	| email | user.onpremisesuserprincipalname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML**. Select **Download** to download the certificate, and then save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. In the **Set up ContractSafe Saml2 SSO** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ContractSafe Saml2 SSO

To configure SSO on the **ContractSafe Saml2 SSO** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs to the [ContractSafe Saml2 SSO support team](mailto:support@contractsafe.com). The team is responsible for setting the SAML SSO connection properly on both sides.

### Create a ContractSafe Saml2 SSO test user

Create a user called B.Simon in ContractSafe Saml2 SSO. Work with the [ContractSafe Saml2 SSO support team](mailto:support@contractsafe.com) to add the users in the ContractSafe Saml2 SSO platform. Users must be created and activated before you use SSO.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the ContractSafe Saml2 SSO for which you set up the SSO.

* You can use Microsoft My Apps. When you select the ContractSafe Saml2 SSO tile in the My Apps, you should be automatically signed in to the ContractSafe Saml2 SSO for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ContractSafe Saml2 SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
