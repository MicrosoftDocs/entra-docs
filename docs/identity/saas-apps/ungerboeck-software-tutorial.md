---
title: Configure Ungerboeck Software for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Ungerboeck Software.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Ungerboeck Software so that I can control who has access to Ungerboeck Software, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Ungerboeck Software for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Ungerboeck Software with Microsoft Entra ID. When you integrate Ungerboeck Software with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Ungerboeck Software.
* Enable your users to be automatically signed-in to Ungerboeck Software with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Ungerboeck Software single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Ungerboeck Software supports **SP** initiated SSO.

## Add Ungerboeck Software from the gallery

To configure the integration of Ungerboeck Software into Microsoft Entra ID, you need to add Ungerboeck Software from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Ungerboeck Software** in the search box.
1. Select **Ungerboeck Software** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-ungerboeck-software'></a>

## Configure and test Microsoft Entra SSO for Ungerboeck Software

Configure and test Microsoft Entra SSO with Ungerboeck Software using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Ungerboeck Software.

To configure and test Microsoft Entra SSO with Ungerboeck Software, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Ungerboeck Software SSO](#configure-ungerboeck-software-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Ungerboeck Software test user](#create-ungerboeck-software-test-user)** - to have a counterpart of B.Simon in Ungerboeck Software that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Ungerboeck Software** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** page, perform the following steps:

    1. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.ungerboeck.com/prod`

    1. In the **Identifier (Entity ID)** text box, type a URL using one of the following patterns:
    
    *  **For production environment**:

       - `https://<SUBDOMAIN>.ungerboeck.com/prod`
       - `https://<SUBDOMAIN>.ungerboeck.net/prod`
       - `https://<SUBDOMAIN>.ungerboeck.io/prod`

   * **For test environment**:

     - `https://<SUBDOMAIN>.ungerboeck.com/test`
     - `https://<SUBDOMAIN>.ungerboeck.net/test`
     - `https://<SUBDOMAIN>.ungerboeck.io/test`

   > [!NOTE]
   > These values aren't real. Update these values with the actual Sign on URL and Identifier which is explained later in the **Configure Ungerboeck Software Single Sign-On** section of the article.

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Edit SAML Signing Certificate](common/edit-certificate.png)

1. In the **SAML Signing Certificate** section, copy the **Thumbprint** and save it on your computer.

    ![Copy Thumbprint value](common/copy-thumbprint.png)

1. On the **Set up Ungerboeck Software** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Ungerboeck Software SSO

To configure single sign-on on **Ungerboeck Software** side, you need to send the **Thumbprint value** and appropriate copied URLs from the application configuration to [Ungerboeck Software support team](mailto:Rhonda.Jannings@ungerboeck.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Ungerboeck Software test user

In this section, you create a user called B.Simon in Ungerboeck Software. Work with [Ungerboeck Software support team](mailto:Rhonda.Jannings@ungerboeck.com) to add the users in the Ungerboeck Software platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Ungerboeck Software Sign-on URL where you can initiate the login flow. 

* Go to Ungerboeck Software Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Ungerboeck Software tile in the My Apps, this option redirects to Ungerboeck Software Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Ungerboeck Software you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
