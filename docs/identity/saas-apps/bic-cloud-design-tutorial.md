---
title: Configure BIC Process Design for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and BIC Process Design.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and BIC Process Design so that I can control who has access to BIC Process Design, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure BIC Process Design for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate BIC Process Design with Microsoft Entra ID. When you integrate BIC Process Design with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to BIC Process Design.
* Enable your users to be automatically signed-in to BIC Process Design with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* BIC Process Design single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* BIC Process Design supports **SP** initiated SSO.
* BIC Process Design supports [Automated user provisioning](bic-cloud-design-provisioning-tutorial.md).

## Add BIC Process Design from the gallery

To configure the integration of BIC Process Design into Microsoft Entra ID, you need to add BIC Process Design from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **BIC Process Design** in the search box.
1. Select **BIC Process Design** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-bic-process-design'></a>

## Configure and test Microsoft Entra SSO for BIC Process Design

Configure and test Microsoft Entra SSO with BIC Process Design using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in BIC Process Design.

To configure and test Microsoft Entra SSO with BIC Process Design, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure BIC Process Design SSO](#configure-bic-process-design-sso)** - to configure the single sign-on settings on application side.
    1. **[Create BIC Process Design test user](#create-bic-process-design-test-user)** - to have a counterpart of B.Simon in BIC Process Design that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **BIC Process Design** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file**, perform the following steps:

	a. Select **Upload metadata file**.

    ![Upload metadata file](common/upload-metadata.png)

	b. Select **folder logo** to select the metadata file and select **Upload**.

	![choose metadata file](common/browse-upload-metadata.png)

	c. After the metadata file is successfully uploaded, the **Identifier** value gets auto populated in Basic SAML Configuration section.

	d. In the **Sign-on URL** text box, type a URL using one of the following patterns:

    | Sign-on URL |
	|-----|
    | `https://<CUSTOMER_SPECIFIC_NAME/TENANT>.biccloud.com` |
    | `https://<CUSTOMER_SPECIFIC_NAME/TENANT>.biccloud.de` |
    
	> [!Note]
	> If the **Identifier** value doesn't get auto populated, then please fill in the value manually according to your requirement. The Sign-on URL value isn't real. Update this value with the actual Sign-on URL. Contact [BIC Process Design Client support team](mailto:bicsupport@gbtec.de) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. BIC Process Design application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, BIC Process Design application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| ------------ | --------- |
	| Name | user.name |
	| E-Mail Address | user.mail |
	| Name ID | user.userprincipalname |
	| email | user.mail |
	| nametest | user.displayname |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure BIC Process Design SSO

To configure single sign-on on **BIC Process Design** side, you need to send the **App Federation Metadata Url** to [BIC Process Design support team](mailto:bicsupport@gbtec.de). They set this setting to have the SAML SSO connection set properly on both sides.

### Create BIC Process Design test user

In this section, you create a user called B.Simon in BIC Process Design. Work with [BIC Process Design support team](mailto:bicsupport@gbtec.de) to add the users in the BIC Process Design platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to BIC Process Design Sign-on URL where you can initiate the login flow. 

* Go to BIC Process Design Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the BIC Process Design tile in the My Apps, this option redirects to BIC Process Design Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure BIC Process Design you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
