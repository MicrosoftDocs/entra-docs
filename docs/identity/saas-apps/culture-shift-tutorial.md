---
title: Configure Culture Shift for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Culture Shift.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Culture Shift so that I can control who has access to Culture Shift, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Culture Shift for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Culture Shift with Microsoft Entra ID. When you integrate Culture Shift with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Culture Shift.
* Enable your users to be automatically signed-in to Culture Shift with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Culture Shift single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Culture Shift supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Culture Shift from the gallery

To configure the integration of Culture Shift into Microsoft Entra ID, you need to add Culture Shift from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Culture Shift** in the search box.
1. Select **Culture Shift** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-culture-shift'></a>

## Configure and test Microsoft Entra SSO for Culture Shift

Configure and test Microsoft Entra SSO with Culture Shift using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Culture Shift.

To configure and test Microsoft Entra SSO with Culture Shift, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Culture Shift SSO](#configure-culture-shift-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Culture Shift test user](#create-culture-shift-test-user)** - to have a counterpart of B.Simon in Culture Shift that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Culture Shift** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the value:
    `urn:amazon:cognito:sp:eu-west-2_tWqrsHU3a`

    b. In the **Reply URL** text box, type the URL:
    `https://auth.reportandsupport.co.uk/saml2/idpresponse`

	c. In the **Sign on URL** text box, type the URL:
    `https://dashboard.reportandsupport.co.uk/`

1. Culture Shift application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Culture Shift application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| ----------| --------- |
	| displayname | user.displayname |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Culture Shift SSO

To configure single sign-on on **Culture Shift** side, you need to send the **App Federation Metadata Url** to [Culture Shift support team](mailto:tickets@culture-shift.co.uk). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Culture Shift test user

In this section, you create a user called Britta Simon in Culture Shift. Work with [Culture Shift support team](mailto:tickets@culture-shift.co.uk) to add the users in the Culture Shift platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Culture Shift Sign-on URL where you can initiate the login flow. 

* Go to Culture Shift Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Culture Shift tile in the My Apps, this option redirects to Culture Shift Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Culture Shift you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
