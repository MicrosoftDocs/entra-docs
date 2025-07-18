---
title: Configure ARC Facilities for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ARC Facilities.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ARC Facilities so that I can control who has access to ARC Facilities, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ARC Facilities for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ARC Facilities with Microsoft Entra ID. When you integrate ARC Facilities with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ARC Facilities.
* Enable your users to be automatically signed-in to ARC Facilities with their Microsoft Entra accounts.
* Manage your accounts in one central location.


## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ARC Facilities single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ARC Facilities supports **IDP** initiated SSO

* ARC Facilities supports **Just In Time** user provisioning

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding ARC Facilities from the gallery

To configure the integration of ARC Facilities into Microsoft Entra ID, you need to add ARC Facilities from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ARC Facilities** in the search box.
1. Select **ARC Facilities** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-single-sign-on-for-arc-facilities'></a>

## Configure and test Microsoft Entra single sign-on for ARC Facilities

Configure and test Microsoft Entra SSO with ARC Facilities using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ARC Facilities.

To configure and test Microsoft Entra SSO with ARC Facilities, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ARC Facilities SSO](#configure-arc-facilities-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ARC Facilities test user](#create-arc-facilities-test-user)** - to have a counterpart of B.Simon in ARC Facilities that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ARC Facilities** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. ARC Facilities application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Select **Edit** icon to open User Attributes dialog.

	![Screenshot shows the User Attributes dialog box with the Edit icon called out.](common/edit-attribute.png)

1. In addition to above, ARC Facilities application expects few more attributes to be passed back in SAML response. In the **User Attributes & Claims** section on the **Group Claims (Preview)** dialog, perform the following steps:

	a. Select the **pen** next to **Groups returned in claim**.

	![Screenshot shows User Attributes & Claims with the pen next to Groups returned in claim called out.](./media/arc-facilities-tutorial/config01.png)

	b. In the **Group Claims** dialog, select **All Groups** from the radio list.

	c. Select **Source Attribute** of **Group ID**.

	d. Select **Save**.

    > [!NOTE]
    > ARC Facilities expects roles for users assigned to the application. Please set up these roles in Microsoft Entra ID so that users can be assigned the appropriate roles. To understand how to configure roles in Microsoft Entra ID, see [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui).

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up ARC Facilities** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ARC Facilities SSO

To configure single sign-on on **ARC Facilities** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [ARC Facilities support team](mailto:support@arcfacilities.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ARC Facilities test user

In this section, a user called Britta Simon is created in ARC Facilities. ARC Facilities supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in ARC Facilities, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the ARC Facilities for which you set up the SSO

* You can use Microsoft My Apps. When you select the ARC Facilities tile in the My Apps, you should be automatically signed in to the ARC Facilities for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure ARC Facilities you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
