---
title: Configure myPolicies for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and myPolicies.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and myPolicies so that I can control who has access to myPolicies, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure myPolicies for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate myPolicies with Microsoft Entra ID. When you integrate myPolicies with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to myPolicies.
* Enable your users to be automatically signed-in to myPolicies with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* myPolicies single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* myPolicies supports **IDP** initiated SSO.

* myPolicies supports [Automated user provisioning](mypolicies-provisioning-tutorial.md).

## Add myPolicies from the gallery

To configure the integration of myPolicies into Microsoft Entra ID, you need to add myPolicies from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **myPolicies** in the search box.
1. Select **myPolicies** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-mypolicies'></a>

## Configure and test Microsoft Entra SSO for myPolicies

Configure and test Microsoft Entra SSO with myPolicies using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in myPolicies.

To configure and test Microsoft Entra SSO with myPolicies, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure myPolicies SSO](#configure-mypolicies-sso)** - to configure the single sign-on settings on application side.
    1. **[Create myPolicies test user](#create-mypolicies-test-user)** - to have a counterpart of B.Simon in myPolicies that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **myPolicies** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up Single Sign-On with SAML** page, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<tenantname>.mypolicies.com/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<tenantname>.mypolicies.com/users/auth/saml/callback`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [myPolicies Client support team](mailto:support@mypolicies.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up myPolicies** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure myPolicies SSO

To configure single sign-on on **myPolicies** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [myPolicies support team](mailto:support@mypolicies.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create myPolicies test user

In this section, you create a user called Britta Simon in myPolicies. Work with [myPolicies support team](mailto:support@mypolicies.com) to add the users in the myPolicies platform. Users must be created and activated before you use single sign-on.

myPolicies also supports automatic user provisioning, you can find more details [here](./mypolicies-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the myPolicies for which you set up the SSO.

* You can use Microsoft My Apps. When you select the myPolicies tile in the My Apps, you should be automatically signed in to the myPolicies for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure myPolicies you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
