---
title: Configure Shopify Plus for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Shopify Plus.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Shopify Plus so that I can control who has access to Shopify Plus, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Shopify Plus for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Shopify Plus with Microsoft Entra ID. When you integrate Shopify Plus with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Shopify Plus.
* Enable your users to be automatically signed-in to Shopify Plus with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Shopify Plus single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Shopify Plus supports **SP and IDP** initiated SSO.
* Shopify Plus supports [Automated user provisioning](shopify-plus-provisioning-tutorial.md).

## Add Shopify Plus from the gallery

To configure the integration of Shopify Plus into Microsoft Entra ID, you need to add Shopify Plus from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Shopify Plus** in the search box.
1. Select **Shopify Plus** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-shopify-plus'></a>

## Configure and test Microsoft Entra SSO for Shopify Plus

Configure and test Microsoft Entra SSO with Shopify Plus using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Shopify Plus.

To configure and test Microsoft Entra SSO with Shopify Plus, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Shopify Plus SSO](#configure-shopify-plus-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Shopify Plus test user](#create-shopify-plus-test-user)** - to have a counterpart of B.Simon in Shopify Plus that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Shopify Plus** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://accounts.shopify.com/saml/consume/organization/<ORGANIZATION_ID>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://shopify.plus/login`

	> [!NOTE]
	> The Reply URL value isn't real. Update the value with the actual Reply URL. Contact [Shopify Plus Client support team](mailto:plus-user-management@shopify.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Shopify Plus application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Shopify Plus application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| ---- | --------------- |
	| email | user.mail |

1. Change the **Name ID** format to **Persistent**. Select the **Unique User Identifier (Name ID)** option, and then select the **Name identifier** format. Select **Persistent** for this option. Save your changes.
1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select the copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Shopify Plus SSO

To view the full steps, see [Shopify's documentation on setting up SAML integrations](https://help.shopify.com/en/manual/shopify-plus/saml).

To configure single sign-on on the **Shopify Plus** side, copy the **App Federation Metadata URL** from Microsoft Entra ID. Then, log into the [organization admin](https://shopify.plus) and go to **Users** > **Security**. Select **Set up configuration**, and then paste your App Federation Metadata URL in the **Identity provider metadata URL** section. Select **Add** to complete this step.

### Create Shopify Plus test user

In this section, you create a user called B.Simon in Shopify Plus. Return to the **Users** section and add a user by entering their email and permissions. Users must be created and activated before you use single sign-on.

> [!NOTE]
> Shopify Plus also supports automatic user provisioning, you can find more details [here](./shopify-plus-provisioning-tutorial.md) on how to configure automatic user provisioning.

### Enforce SAML authentication

> [!NOTE]
> We recommend testing the integration by using individual users before applying broadly.

Individual users:
1. Go to an individual user’s page in Shopify Plus with an email domain that’s managed by Microsoft Entra ID and verified in Shopify Plus.
1. In the SAML authentication section, select **Edit**, select **Required**, and then select **Save**.
1. Test that this user can successfully sign in via the idP-initiated and SP-initiated flows.

For all users under an email domain:
1. Return to the **Security** page.
1. Select **Required** for your SAML authentication setting. This enforces SAML for all users with that email domain across Shopify Plus.
1. Select **Save**.

> [!IMPORTANT]
> Enabling SAML for all users under an email domain affects all users who use this application. Users won't be able to sign in by using their regular sign-in page. They will only be able to access the app through Microsoft Entra ID. Shopify doesn't provide a backup sign-in URL at which users can sign in by using their normal username and password. You can contact Shopify Support to turn off SAML, if necessary.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Shopify Plus Sign on URL where you can initiate the login flow.  

* Go to Shopify Plus Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Shopify Plus for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Shopify Plus tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Shopify Plus for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Shopify Plus you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
