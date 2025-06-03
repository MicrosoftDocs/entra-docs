---
title: Configure Qualtrics for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Qualtrics.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Qualtrics so that I can control who has access to Qualtrics, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Qualtrics for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Qualtrics with Microsoft Entra ID. When you integrate Qualtrics with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Qualtrics.
* Enable your users to be automatically signed in to Qualtrics with their Microsoft Entra accounts.
* Manage your accounts in one central location: the Azure portal.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Qualtrics subscription enabled for single sign-on (SSO).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Qualtrics supports **SP** and **IDP** initiated SSO.
* Qualtrics supports **Just In Time** user provisioning.

## Add Qualtrics from the gallery

To configure the integration of Qualtrics into Microsoft Entra ID, you need to add Qualtrics from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Qualtrics** in the search box.
1. Select **Qualtrics** from results, and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-single-sign-on-for-sap-qualtrics'></a>

## Configure and test Microsoft Entra single sign-on for Qualtrics

Configure and test Microsoft Entra SSO with Qualtrics, by using a test user called **B.Simon**. For SSO to work, you need to establish a linked relationship between a Microsoft Entra user and the related user in Qualtrics.

To configure and test Microsoft Entra SSO with Qualtrics, complete the following building blocks:

1. [Configure Microsoft Entra SSO](#configure-azure-ad-sso) to enable your users to use this feature.
    1. Create a Microsoft Entra test user to test Microsoft Entra single sign-on with B.Simon.
    1. Assign the Microsoft Entra test user to enable B.Simon to use Microsoft Entra single sign-on.
1. [Configure Qualtrics SSO](#configure-qualtrics-sso) to configure the single sign-on settings on the application side.
    1. [Create a Qualtrics test user](#create-qualtrics-test-user) to have a counterpart of B.Simon in Qualtrics, linked to the Microsoft Entra representation of the user.
1. [Test SSO](#test-sso) to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Qualtrics** application integration page, find the **Manage** section. Select **single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, if you want to configure the application in **IDP** initiated mode, enter the values for the following fields:
    
    a. In the **Identifier** text box, type a URL that uses the following pattern:

	`https://< DATACENTER >.qualtrics.com`
   
    b. In the **Reply URL** text box, type a URL that uses the following pattern:

    `https://< DATACENTER >.qualtrics.com/login/v1/sso/saml2/default-sp`

    c. In the **Relay State** text box, type a URL that uses the following pattern:

    `https://< brandID >.< DATACENTER >.qualtrics.com`

1. Select **Set additional URLs**, and perform the following step if you want to configure the application in **SP** initiated mode:

    In the **Sign-on URL** textbox, type a URL that uses the following pattern:

    `https://< brandID >.< DATACENTER >.qualtrics.com`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Sign-on URL, Identifier, Reply URL, and Relay State. To get these values, contact the [Qualtrics Client support team](https://www.qualtrics.com/support/). You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select the copy icon to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Qualtrics SSO

To configure single sign-on on the Qualtrics side, send the copied **App Federation Metadata Url** to the [Qualtrics support team](https://www.qualtrics.com/support/). The support team ensures that the SAML SSO connection is set properly on both sides.

### Create Qualtrics test user

Qualtrics supports just-in-time user provisioning, which is enabled by default. There's no additional action for you to take. If a user doesn't already exist in Qualtrics, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Qualtrics Sign on URL where you can initiate the login flow.  

* Go to Qualtrics Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Qualtrics for which you set up the SSO.

You can also use Microsoft My Apps to test the application in any mode. When you select the Qualtrics tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Qualtrics for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

After you configure Qualtrics, you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. For more information, see [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
