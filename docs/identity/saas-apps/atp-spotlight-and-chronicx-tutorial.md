---
title: Configure ATP SpotLight and ChronicX for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ATP SpotLight and ChronicX.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ATP SpotLight and ChronicX so that I can control who has access to ATP SpotLight and ChronicX, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ATP SpotLight and ChronicX for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ATP SpotLight and ChronicX with Microsoft Entra ID. When you integrate ATP SpotLight and ChronicX with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ATP SpotLight and ChronicX.
* Enable your users to be automatically signed-in to ATP SpotLight and ChronicX with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ATP SpotLight and ChronicX single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ATP SpotLight and ChronicX supports **SP** initiated SSO.

* ATP SpotLight and ChronicX supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add ATP SpotLight and ChronicX from the gallery

To configure the integration of ATP SpotLight and ChronicX into Microsoft Entra ID, you need to add ATP SpotLight and ChronicX from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ATP SpotLight and ChronicX** in the search box.
1. Select **ATP SpotLight and ChronicX** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-atp-spotlight-and-chronicx'></a>

## Configure and test Microsoft Entra SSO for ATP SpotLight and ChronicX

Configure and test Microsoft Entra SSO with ATP SpotLight and ChronicX using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ATP SpotLight and ChronicX.

To configure and test Microsoft Entra SSO with ATP SpotLight and ChronicX, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ATP SpotLight and ChronicX SSO](#configure-atp-spotlight-and-chronicx-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ATP SpotLight and ChronicX test user](#create-atp-spotlight-and-chronicx-test-user)** - to have a counterpart of B.Simon in ATP SpotLight and ChronicX that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ATP SpotLight and ChronicX** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the value:
    `urn:amazon:cognito:sp:ca-central-1_ELozbwSTo`

	b. In the **Reply URL** text box, type the URL:
	`https://atpprod.auth.ca-central-1.amazoncognito.com/saml2/idpresponse`

	c. In the **Sign on URL** text box, type a URL using one of the following patterns:

	| **Sign on URL** |
	|------|
    | `https://sandbox.<AppDomain>.com` |
	| `<CustomerSSOName>` | 
	| `https://<CustomerName>.<AppDomain>.com/` |

	> [!NOTE]
	> This value isn't  real. Update this value with the actual Sign on URL. Contact [ATP SpotLight and ChronicX Client support team](mailto:support@atp.com) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. ATP SpotLight and ChronicX application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, ATP SpotLight and ChronicX application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name  |  Source Attribute|
	| -------- | --------- |
	| organizationcode | <`organizationcode`> |
	| organizationname | <`organizationname`> |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up ATP SpotLight and ChronicX** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ATP SpotLight and ChronicX SSO

To configure single sign-on on **ATP SpotLight and ChronicX** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [ATP SpotLight and ChronicX support team](mailto:support@atp.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ATP SpotLight and ChronicX test user

In this section, a user called Britta Simon is created in ATP SpotLight and ChronicX. ATP SpotLight and ChronicX supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in ATP SpotLight and ChronicX, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ATP SpotLight and ChronicX Sign-on URL where you can initiate the login flow. 

* Go to ATP SpotLight and ChronicX Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ATP SpotLight and ChronicX tile in the My Apps, this option redirects to ATP SpotLight and ChronicX Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ATP SpotLight and ChronicX you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
