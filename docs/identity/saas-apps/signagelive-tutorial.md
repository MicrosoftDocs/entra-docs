---
title: Configure Signagelive for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Signagelive.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Signagelive so that I can control who has access to Signagelive, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Signagelive for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Signagelive with Microsoft Entra ID. When you integrate Signagelive with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Signagelive.
* Enable your users to be automatically signed-in to Signagelive with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Signagelive single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Signagelive supports SP-initiated SSO.
* Signagelive supports [Automated user provisioning](signagelive-provisioning-tutorial.md).

## Add Signagelive from the gallery

To configure the integration of Signagelive into Microsoft Entra ID, you need to add Signagelive from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Signagelive** in the search box.
1. Select **Signagelive** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-signagelive'></a>

## Configure and test Microsoft Entra SSO for Signagelive

Configure and test Microsoft Entra SSO with Signagelive using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Signagelive.

To configure and test Microsoft Entra SSO with Signagelive, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Signagelive SSO](#configure-signagelive-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Signagelive test user](#create-signagelive-test-user)** - to have a counterpart of B.Simon in Signagelive that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Signagelive** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

4. In the **Basic SAML Configuration** section, take the following step:

    In the **Sign-on URL** box, enter a URL that uses the following pattern:
    `https://login.signagelive.com/sso/<ORGANIZATIONALUNITNAME>`

	> [!NOTE]
	> The value isn't real. Update the value with the actual sign-on URL. To get the value, contact the [Signagelive Client support team](mailto:support@signagelive.com). You can also refer to the patterns that are shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Raw)** from the given options per your requirement. Then save it on your computer.

	![The Certificate download link](common/certificateraw.png)

6. In the **Set up Signagelive** section, copy the URL(s) that you need.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Signagelive SSO

To configure single sign-on on the Signagelive side, send the downloaded **Certificate (Raw)** and copied URLs to the [Signagelive support team](mailto:support@signagelive.com). They ensure that the SAML SSO connection is set properly on both sides.

### Create Signagelive test user

In this section, you create a user called Britta Simon in Signagelive. Work with the [Signagelive support team](mailto:support@signagelive.com) to add the users in the Signagelive platform. You must create and activate users before you use single sign-on.

Signagelive also supports automatic user provisioning, you can find more details [here](./signagelive-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Signagelive Sign-on URL where you can initiate the login flow. 

* Go to Signagelive Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Signagelive tile in the My Apps, this option redirects to Signagelive Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Signagelive you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
