---
title: Microsoft Entra SSO integration with Navigo Cloud SAML
description: Learn how to configure single sign-on between Microsoft Entra ID and Navigo Cloud SAML.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Navigo Cloud SAML so that I can control who has access to Navigo Cloud SAML, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Navigo Cloud SAML

In this tutorial, you'll learn how to integrate Navigo Cloud SAML with Microsoft Entra ID. When you integrate Navigo Cloud SAML with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Navigo Cloud SAML.
* Enable your users to be automatically signed-in to Navigo Cloud SAML with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To integrate Microsoft Entra ID with Navigo Cloud SAML, you need:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Navigo Cloud SAML single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Navigo Cloud SAML supports only **SP** initiated SSO.

## Add Navigo Cloud SAML from the gallery

To configure the integration of Navigo Cloud SAML into Microsoft Entra ID, you need to add Navigo Cloud SAML from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Navigo Cloud SAML** in the search box.
1. Select **Navigo Cloud SAML** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Navigo Cloud SAML

Configure and test Microsoft Entra SSO with Navigo Cloud SAML using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Navigo Cloud SAML.

To configure and test Microsoft Entra SSO with Navigo Cloud SAML, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-a-microsoft-entra-id-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-microsoft-entra-id-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Navigo Cloud SAML SSO](#configure-navigo-cloud-saml-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Navigo Cloud SAML test user](#create-navigo-cloud-saml-test-user)** - to have a counterpart of B.Simon in Navigo Cloud SAML that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Navigo Cloud SAML** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type one of the following URLs:

    |**Identifier (Entity ID)**|
    |--------------------------|
    |`https://login.navigocloud.com`|
    |`https://navigocloud-dev.fusionauth.io`|
    |`https://navigocloud.com`|
    |`https://beta.navigocloud.com`|
    |`https://demo1.navigocloud.com`|
    |`https://staging.navigocloud.com`|

    b. In the **Reply URL** textbox, type one of the following URLs:

    |**Reply URL**|
    |-------------|
    |`https://navigocloud-dev.fusionauth.io/samlv2/acs`|
    |`https://login.navigocloud.com/samlv2/acs`|

    c. In the **Sign on URL** text box, type one of the following URLs:

    |**Sign on URL**|
    |---------------|
    |`https://login.navigocloud.com`|
    |`https://navigocloud-dev.fusionauth.io`|
    |`https://navigocloud.com`|
    |`https://beta.navigocloud.com`|
    |`https://demo1.navigocloud.com`|
    |`https://staging.navigocloud.com`|

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificateraw.png "Certificate")

1. On the **Set up Navigo Cloud SAML** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user in the Microsoft Entra admin center called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-microsoft-entra-id-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use Microsoft Entra single sign-on by granting access to Navigo Cloud SAML.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Navigo Cloud SAML**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Navigo Cloud SAML SSO

To configure single sign-on on **Navigo Cloud SAML** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from Microsoft Entra admin center to [Navigo Cloud SAML support team](mailto:support@itouchinc.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Navigo Cloud SAML test user

In this section, you create a user called B.Simon in Navigo Cloud SAML. Work with [Navigo Cloud SAML support team](mailto:support@itouchinc.com) to add the users in the Navigo Cloud SAML platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Click on **Test this application** in Microsoft Entra admin center. This will redirect to Navigo Cloud SAML Sign-on URL where you can initiate the login flow.
 
* Go to Navigo Cloud SAML Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you click the Navigo Cloud SAML tile in the My Apps, this will redirect to Navigo Cloud SAML Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Navigo Cloud SAML you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
