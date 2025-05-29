---
title: Configure Pulse Secure PCS for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Pulse Secure PCS.
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Pulse Secure PCS so that I can control who has access to Pulse Secure PCS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Pulse Secure PCS for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Pulse Secure PCS with Microsoft Entra ID. When you integrate Pulse Secure PCS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Pulse Secure PCS.
* Enable your users to be automatically signed-in to Pulse Secure PCS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Pulse Secure PCS single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Pulse Secure PCS supports **SP** initiated SSO

## Adding Pulse Secure PCS from the gallery

To configure the integration of Pulse Secure PCS into Microsoft Entra ID, you need to add Pulse Secure PCS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Pulse Secure PCS** in the search box.
1. Select **Pulse Secure PCS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-pulse-secure-pcs'></a>

## Configure and test Microsoft Entra SSO for Pulse Secure PCS

Configure and test Microsoft Entra SSO with Pulse Secure PCS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Pulse Secure PCS.

To configure and test Microsoft Entra SSO with Pulse Secure PCS, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Pulse Secure PCS SSO](#configure-pulse-secure-pcs-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Pulse Secure PCS test user](#create-pulse-secure-pcs-test-user)** - to have a counterpart of B.Simon in Pulse Secure PCS that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Pulse Secure PCS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<FQDN of PCS>/dana-na/auth/saml-consumer.cgi`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<FQDN of PCS>/dana-na/auth/saml-endpoint.cgi?p=sp1`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://[FQDN of PCS]/dana-na/auth/saml-consumer.cgi`


	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL,Reply URL and Identifier. Contact [Pulse Secure PCS Client support team](mailto:support@pulsesecure.net) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Pulse Secure PCS** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Pulse Secure PCS SSO

This section covers the SAML configurations required to configure PCS as SAML SP. The other basic configurations like creating Realms and Roles aren't covered.

**Pulse Connect Secure configurations include:**

* Configuring Microsoft Entra ID as SAML Metadata Provider
* Configuring SAML Auth Server
* Assigning to respective Realms and Roles

<a name='configuring-azure-ad-as-saml-metadata-provider'></a>

#### Configuring Microsoft Entra ID as SAML Metadata Provider

Perform the following steps in the following page:

![Pulse Connect Secure configuration](./media/pulse-secure-pcs-tutorial/saml-configuration.png)

1. Log into the Pulse Connect Secure admin console
1. Navigate to **System -> Configuration -> SAML**
1. Select **New Metadata Provider**
1. Provide the valid Name in the **Name** textbox
1. Upload the downloaded metadata XML file from Azure portal  into the **Microsoft Entra metadata file**.
1. Select **Accept Unsigned Metadata**
1. Select Roles as **Identity Provider**
1. Select **Save changes**.

#### Steps to create a SAML Auth Server:

1. Navigate to **Authentication -> Auth Servers**
1. Select **New: SAML Server** and select **New Server**

    ![Pulse Connect Secure auth server](./media/pulse-secure-pcs-tutorial/new-saml-server.png)

1. Perform the following steps in the settings page:

    ![Pulse Connect Secure auth server settings](./media/pulse-secure-pcs-tutorial/server-settings.png)

    a. Provide **Server Name** in the textbox.

    b. Select **SAML Version 2.0** and **Configuration Mode** as **Metadata**.

    c. Copy the **Connect Secure Entity Id** value and paste it into the **Identifier URL** box in the **Basic SAML Configuration** dialog box.

    d. Select Microsoft Entra Entity Id value from the **Identity Provider Entity Id drop down list**.

    e. Select Microsoft Entra Login URL value from the **Identity Provider Single Sign-On Service URL drop down list**.

    f. **Single Logout** is an optional setting. If this option is selected, it prompts for a new authentication after logout. If this option isn't selected and you have not closed the browser, you can reconnect without authentication.

    g. Select the **Requested Authn Context Class** as **Password** and the **Comparison Method** as **exact**.

    h. Set the **Metadata Validity** in terms of number of days.
    
    i. Select **Save Changes**

### Create Pulse Secure PCS test user

In this section, you create a user called Britta Simon in Pulse Secure PCS. Work with [Pulse Secure PCS support team](mailto:support@pulsesecure.net) to add the users in the Pulse Secure PCS platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

1. Select **Test this application**, this option redirects to Pulse Secure PCS Sign-on URL where you can initiate the login flow. 

2. Go to Pulse Secure PCS Sign-on URL directly and initiate the login flow from there.

3. You can use Microsoft Access Panel. When you select the Pulse Secure PCS tile in the Access Panel, this option redirects to Pulse Secure PCS Sign-on URL. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Pulse Secure PCS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
