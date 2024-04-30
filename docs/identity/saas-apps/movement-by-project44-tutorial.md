---
title: Microsoft Entra SSO integration with Movement by project44
description: Learn how to configure single sign-on between Microsoft Entra ID and Movement by project44.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 11/08/2023
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Movement by project44 so that I can control who has access to Movement by project44, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Movement by project44

In this tutorial, you'll learn how to integrate Movement by project44 with Microsoft Entra ID. When you integrate Movement by project44 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Movement by project44.
* Enable your users to be automatically signed-in to Movement by project44 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To integrate Microsoft Entra ID with Movement by project44, you need:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Movement by project44 single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Movement by project44 supports **SP** initiated SSO.
* Movement by project44 supports **Just In Time** user provisioning.

## Add Movement by project44 from the gallery

To configure the integration of Movement by project44 into Microsoft Entra ID, you need to add Movement by project44 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Movement by project44** in the search box.
1. Select **Movement by project44** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Movement by project44

Configure and test Microsoft Entra SSO with Movement by project44 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Movement by project44.

To configure and test Microsoft Entra SSO with Movement by project44, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-a-microsoft-entra-id-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-microsoft-entra-id-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Movement by project44 SSO](#configure-movement-by-project44-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Movement by project44 test user](#create-movement-by-project44-test-user)** - to have a counterpart of B.Simon in Movement by project44 that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Movement by project44** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://www.okta.com/saml2/service-provider/<provider-ID>`

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    |**Reply URL**|
    |-------------|
    |`https://project44-americas.okta.com/sso/saml2/<IdP-ID>`|
    |`https://project44-europe.okta.com/sso/saml2/<IdP-ID>`|

    c. In the **Sign on URL** text box, type a URL using one of the following patterns:

    |**Sign on URL**|
    |---------------|
    |`https://movement.project44.com/login?idpId=<IdP-ID>`|
    |`https://movement.eu.project44.com/login?idpId=<IdP-ID>`|

	> [!NOTE]
	> These values are not real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Movement by project44 support team](mailto:support@project44.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. Movement by project44 application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")
    
    > [!Note]
    > Please delete namespace manually for the above default attributes.

1. In addition to above, Movement by project44 application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| --------------- | --------- |
	| firstName | user.givenname |
	| lastName  | user.surname|

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Movement by project44** section, copy the appropriate URL(s) based on your requirement.

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

In this section, you'll enable B.Simon to use Microsoft Entra single sign-on by granting access to Movement by project44.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Movement by project44**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Movement by project44 SSO

To configure single sign-on on **Movement by project44** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [Movement by project44 support team](mailto:support@project44.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Movement by project44 test user

In this section, a user called Britta Simon is created in Movement by project44. Movement by project44 supports just-in-time user provisioning, which is enabled by default. There is no action item for you in this section. If a user doesn't already exist in Movement by project44, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Click on **Test this application** in Microsoft Entra admin center. This will redirect to Movement by project44 Sign-on URL where you can initiate the login flow.
 
* Go to Movement by project44 Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you click the Movement by project44 tile in the My Apps, this will redirect to Movement by project44 Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Movement by project44 you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
