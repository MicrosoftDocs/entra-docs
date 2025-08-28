---
title: Configure RedBrick Health for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and RedBrick Health.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and RedBrick Health so that I can control who has access to RedBrick Health, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure RedBrick Health for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate RedBrick Health with Microsoft Entra ID. When you integrate RedBrick Health with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to RedBrick Health.
* Enable your users to be automatically signed-in to RedBrick Health with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* RedBrick Health single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* RedBrick Health supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add RedBrick Health from the gallery

To configure the integration of RedBrick Health into Microsoft Entra ID, you need to add RedBrick Health from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **RedBrick Health** in the search box.
1. Select **RedBrick Health** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-redbrick-health'></a>

## Configure and test Microsoft Entra SSO for RedBrick Health

Configure and test Microsoft Entra SSO with RedBrick Health using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in RedBrick Health.

To configure and test Microsoft Entra SSO with RedBrick Health, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure RedBrick Health SSO](#configure-redbrick-health-sso)** - to configure the single sign-on settings on application side.
    1. **[Create RedBrick Health test user](#create-redbrick-health-test-user)** - to have a counterpart of B.Simon in RedBrick Health that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **RedBrick Health** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL:
    `https://www.redbrickhealth.com`

    b. In the **Reply URL** text box, type a URL:
    `https://sso-intg.redbrickhealth.com/sp/ACS.saml2`

	For Production Environment: `https://sso.redbrickhealth.com/sp/ACS.saml2`

    c. Select **Set additional URLs**.

    d. In the **Relay State** text box, type a URL using the following pattern:
    `https://api-sso2.redbricktest.com/identity/sso/nbound?target=https://vanity9-sso2.redbrickdev.com/portal&connection=<companyname>conn1`

	> [!NOTE]
	> Relay State value isn't real. Update this value with the actual Relay State. Contact [RedBrick Health Client support team](https://home.redbrickhealth.com/contact/) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. RedBrick Health application expects the SAML assertions in a specific format. Configure the following claims for this application. You can manage the values of these attributes from the **User Attributes** section on application integration page. On the **Set up Single Sign-On with SAML** page, select **Edit** button to open **User Attributes** dialog.

	![Screenshot shows User Attributes with the Edit icon selected.](common/edit-attribute.png)

1. In the **User Claims** section on the **User Attributes** dialog, configure SAML token attribute as shown in the image above and perform the following steps:

	| Name | Source Attribute|
	| ----------- | --------- |
	| principal name | ********** |
	| client id | ********** |
	| participant id | ********** |

	> [!NOTE]
	> These values are for reference purpose only. You need to define the attributes as per your organization's requirement. Please contact [RedBrick Health support team](https://home.redbrickhealth.com/contact/) to get more info about the required claims.

	a. Select **Add new claim** to open the **Manage user claims** dialog.

	![Screenshot shows User claims with the option to Add new claim.](common/new-save-attribute.png)

	![Screenshot shows the Manage user claims dialog box where you can enter the values described.](common/new-attribute-details.png)

	b. In the **Name** textbox, type the attribute name shown for that row.

	c. Leave the **Namespace** blank.

	d. Select Source as **Attribute**.

	e. From the **Source attribute** list, type the attribute value shown for that row.

	f. Select **Ok**

	g. Select **Save**.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up RedBrick Health** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure RedBrick Health SSO

To configure single sign-on on **RedBrick Health** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [RedBrick Health support team](https://home.redbrickhealth.com/contact/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create RedBrick Health test user

In this section, you create a user called B.Simon in RedBrick Health. Work with [RedBrick Health support team](https://home.redbrickhealth.com/contact/) to add the users in the RedBrick Health platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the RedBrick Health for which you set up the SSO.

* You can use Microsoft My Apps. When you select the RedBrick Health tile in the My Apps, you should be automatically signed in to the RedBrick Health for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure RedBrick Health you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
