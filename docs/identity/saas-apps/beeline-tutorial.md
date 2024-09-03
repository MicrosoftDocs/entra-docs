---
title: 'Tutorial: Microsoft Entra integration with Beeline Enterprise'
description: Learn how to configure single sign-on between Microsoft Entra ID and Beeline Enterprise.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 08/29/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Beeline Enterprise so that I can control who has access to Beeline Enterprise, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Tutorial: Microsoft Entra integration with Beeline Enterprise

In this tutorial, you'll learn how to integrate Beeline Enterprise with Microsoft Entra ID. When you integrate Beeline Enterprise with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Beeline Enterprise.
* Enable your users to be automatically signed-in to Beeline Enterprise with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Beeline Enterprise single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra single sign-on in a test environment.

* Beeline Enterprise supports **SP** and **IDP** initiated SSO.

## Add Beeline Enterprise from the gallery

To configure the integration of Beeline Enterprise into Microsoft Entra ID, you need to add Beeline Enterprise from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Browse Microsoft Entra Gallery** section, type **Beeline Enterprise** in the search box.
1. Select **Beeline Enterprise** from the results panel and then click **Create**. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-beeline'></a>

## Configure and test Microsoft Entra SSO for Beeline Enterprise

Configure and test Microsoft Entra SSO with Beeline Enterprise using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Beeline Enterprise.

To configure and test Microsoft Entra SSO with Beeline Enterprise, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Beeline Enterprise SSO](#configure-beeline-enterprise-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Beeline Enterprise test user](#create-beeline-enterprise-test-user)** - to have a counterpart of B.Simon in Beeline that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Beeline Enterprise** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `urn:auth0:<Auth0TenantName>:<CustomerName>-SSO`

    b. In the **Reply URL** text box, type a URL using the following pattern: 
    `https://<Auth0TenantName>.<Auth0Environment>.beeline.com/login/callback?connection=<CustomerName>-SSO`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<Environment>.beeline.com/<CustomerName>/security/auth0/auth0spinitiatedssohandler.ashx`

    > [!NOTE]
    > These values are not real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Beeline Enterprise support team](mailto:support@beeline.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Click **Save**.

1. The Beeline Enterprise application expects the SAML assertions in a specific format. Please work with [Beeline Enterprise support team](mailto:support@beeline.com) first to identify the correct user identifier which will be mapped into the application. Also please take the guidance from [Beeline Enterprise support team](mailto:support@beeline.com) about the attribute which they want to use for this mapping. You can manage the value of this attribute from the **User Attributes** tab of the application. The following screenshot shows an example for this. Here we have mapped the **User Identifier** claim with the **userprincipalname** attribute, which provides unique user ID, which will be sent to the Beeline Enterprise application in every successful SAML response.

    ![Screenshot shows the image of default attributes.](common/edit-attribute.png "Image")

1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Beeline Enterprise** > **Manage** > **Single sign-on**.
1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. In the **Set up Beeline Enterprise** section, copy the **Login URL** and **Logout URL**.
    
    ![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

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

In this section, you'll enable B.Simon to use single sign-on by granting access to Beeline Enterprise.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Beeline Enterprise**.
1. In the app's overview page, select **Assign users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Beeline Enterprise SSO

To configure single sign-on on **Beeline Enterprise** side, you need to send the following items that you gathered from a step earlier in this tutorial to the [Beeline Enterprise support team](mailto:support@beeline.com). They will configure single sign-on on the **Beeline Enterprise** side.

* **Certificate (Base64)**
* **Login URL**
* **Logout URL**

### Create Beeline Enterprise test user

In this section, you will create a user, Britta Simon, in Beeline Enterprise. The Beeline Enterprise application needs all users to be provisioned in the application before doing Single Sign On. So work with the [Beeline Enterprise support team](mailto:support@beeline.com) to provision all these users into the application.

## Test SSO

In this section, you have two different ways to test your Microsoft Entra single sign-on configuration.

* Browse to **Identity** > **Applications** > **Enterprise applications** > **Beeline Enterprise** > **Manage** > **Single sign-on**. Click **Test this application**, and you should be automatically signed in to the Beeline Enterprise for which you set up the SSO.

* You can use Microsoft My Apps. When you click the **Beeline Enterprise** tile in **My Apps**, you should be automatically signed in to the Beeline Enterprise site for which you set up the SSO. For more information about the My Apps portal, see [Introduction to the My Apps portal](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Beeline Enterprise you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).