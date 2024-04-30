---
title: 'Tutorial: Microsoft Entra SSO integration with Broker groupe Achat Solutions'
description: Learn how to configure single sign-on between Microsoft Entra ID and Broker groupe Achat Solutions.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Broker groupe Achat Solutions so that I can control who has access to Broker groupe Achat Solutions, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra SSO integration with Broker groupe Achat Solutions

In this tutorial, you'll learn how to integrate Broker groupe Achat Solutions with Microsoft Entra ID. When you integrate Broker groupe Achat Solutions with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Broker groupe Achat Solutions.
* Enable your users to be automatically signed-in to Broker groupe Achat Solutions with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Broker groupe Achat Solutions single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Broker groupe Achat Solutions supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Broker groupe Achat Solutions from the gallery

To configure the integration of Broker groupe Achat Solutions into Microsoft Entra ID, you need to add Broker groupe Achat Solutions from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Broker groupe Achat Solutions** in the search box.
1. Select **Broker groupe Achat Solutions** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. You can learn more about Office 365 wizards [here](/microsoft-365/admin/misc/azure-ad-setup-guides?view=o365-worldwide&preserve-view=true).

<a name='configure-and-test-azure-ad-sso-for-broker-groupe-achat-solutions'></a>

## Configure and test Microsoft Entra SSO for Broker groupe Achat Solutions

Configure and test Microsoft Entra SSO with Broker groupe Achat Solutions using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Broker groupe Achat Solutions.

To configure and test Microsoft Entra SSO with Broker groupe Achat Solutions, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
   1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Broker groupe Achat Solutions SSO](#configure-broker-groupe-achat-solutions-sso)** - to configure the single sign-on settings on application side.
   1. **[Create Broker groupe Achat Solutions test user](#create-broker-groupe-achat-solutions-test-user)** - to have a counterpart of B.Simon in Broker groupe Achat Solutions that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Broker groupe Achat Solutions** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:
   
   a. In the **Reply URL** text box, type the URL:
   `https://id.awsolutions.fr/auth/realms/awsolutions`

   b. In the **Sign-on URL** text box, type a URL using the following pattern:
   `https://app.marcoweb.fr/Marco?idp_hint=<INSTANCENAME>`
   
   > [!NOTE]
   > This value is not real. Update this value with the actual Sign-on URL. Contact [Broker groupe Achat Solutions Client support team](mailto:devops@achatsolutions.fr) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, click copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to Broker groupe Achat Solutions.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Broker groupe Achat Solutions**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Broker groupe Achat Solutions SSO

To configure single sign-on on **Broker groupe Achat Solutions** side, you need to send the **App Federation Metadata Url** to [Broker groupe Achat Solutions support team](mailto:devops@achatsolutions.fr). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Broker groupe Achat Solutions test user

In this section, you create a user called Britta Simon at Broker groupe Achat Solutions. Work with [Broker groupe Achat Solutions support team](mailto:devops@achatsolutions.fr) to add the users in the Broker groupe Achat Solutions platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Broker groupe Achat Solutions Sign-on URL where you can initiate the login flow. 

* Go to Broker groupe Achat Solutions Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Broker groupe Achat Solutions tile in the My Apps, this will redirect to Broker groupe Achat Solutions Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Broker groupe Achat Solutions you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
