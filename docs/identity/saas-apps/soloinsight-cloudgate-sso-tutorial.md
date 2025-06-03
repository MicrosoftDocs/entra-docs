---
title: Configure Soloinsight-CloudGate SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Soloinsight-CloudGate SSO.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Soloinsight-CloudGate SSO so that I can control who has access to Soloinsight-CloudGate SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Soloinsight-CloudGate SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Soloinsight-CloudGate SSO with Microsoft Entra ID. When you integrate Soloinsight-CloudGate SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Soloinsight-CloudGate SSO.
* Enable your users to be automatically signed-in to Soloinsight-CloudGate SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Soloinsight-CloudGate SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Soloinsight-CloudGate SSO supports **SP** initiated SSO.
* Soloinsight-CloudGate SSO supports [Automated user provisioning](soloinsight-cloudgate-sso-provisioning-tutorial.md).

## Add Soloinsight-CloudGate SSO from the gallery

To configure the integration of Soloinsight-CloudGate SSO into Microsoft Entra ID, you need to add Soloinsight-CloudGate SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Soloinsight-CloudGate SSO** in the search box.
1. Select **Soloinsight-CloudGate SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-soloinsight-cloudgate-sso'></a>

## Configure and test Microsoft Entra SSO for Soloinsight-CloudGate SSO

Configure and test Microsoft Entra SSO with Soloinsight-CloudGate SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Soloinsight-CloudGate SSO.

To configure and test Microsoft Entra SSO with Soloinsight-CloudGate SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Soloinsight-CloudGate SSO](#configure-soloinsight-cloudgate-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Soloinsight-CloudGate SSO test user](#create-soloinsight-cloudgate-sso-test-user)** - to have a counterpart of B.Simon in Soloinsight-CloudGate SSO that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

### Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Soloinsight-CloudGate SSO** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** page, perform the following steps:

    1. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.sigateway.com/login`

    1. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.sigateway.com/process/sso`

   > [!NOTE]
   > These values aren't real. Update these values with the actual Sign on URL and Identifier which is explained later in the **Configure Soloinsight-CloudGate SSO Single Sign-On** section of the article.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

   ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Soloinsight-CloudGate SSO** section, copy the appropriate URL(s) based on your requirement.

   ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Soloinsight-CloudGate SSO




1. In a different web browser window, sign in to your Soloinsight-CloudGate SSO company site as an administrator

4. To get the values that are to be pasted in the Azure portal while configuring Basic SAML, sign in to the CloudGate Web Portal using your credentials then access the SSO settings, which can be found on the following path **Home>Administration>System settings>General**.

	![CloudGate SSO Settings](./media/soloinsight-cloudgate-sso-tutorial/main-settings.png)

5. **SAML Consumer URL**

	* Copy the links available against the **Saml Consumer URL** and the **Redirect URL** fields and paste them in the Azure portal **Basic SAML Configuration** section for **Identifier (Entity ID)** and **Reply URL** fields respectively.

		![SAMLIdentifier](./media/soloinsight-cloudgate-sso-tutorial/identifier.png)

6. **SAML Signing Certificate**

	* Go to the source of the Certificate (Base64) file that was downloaded from Azure portal SAML Signing Certificate lists and right-select it. Choose **Edit with Notepad++** option from the list. 

		![SAMLcertificate](./media/soloinsight-cloudgate-sso-tutorial/certificate-file.png)

	* Copy the content in the Certificate (Base64) Notepad++ file.

		![Certificate copy](./media/soloinsight-cloudgate-sso-tutorial/certificate-copy.png)

	* Paste the content in the CloudGate Web Portal SSO settings **Certificate** field and select Save button.

		![Certificate portal](./media/soloinsight-cloudgate-sso-tutorial/certificate-portal.png)

7. **Default Group**

	* Select **Business Admin** from the drop-down list of the **Default Group** option in the CloudGate Web Portal

		![Default group](./media/soloinsight-cloudgate-sso-tutorial/default-group.png)

8. **AD Identifier and Login URL**

	* The copied **Login URL** **Set up Soloinsight-CloudGate SSO** configurations are to be entered in the CloudGate Web Portal SSO settings section.

	* Paste the **Login URL** link from Azure portal in the CloudGate Web Portal **AD Login URL** field.

	* Paste the **Microsoft Entra Identifier** link from Azure portal in the CloudGate Web Portal **AD Identifier** field

		![Ad login](./media/soloinsight-cloudgate-sso-tutorial/ad-login.png)

### Create Soloinsight-CloudGate SSO test user

To Create a test user, Select **Employees** from the main menu of your CloudGate Web Portal and fill out the Add New employee form. The Authority Level that's to be assigned to the test user is **Business Admin** Select **Create** once all the required fields are filled.

![Employee test](./media/soloinsight-cloudgate-sso-tutorial/employee-test.png)

> [!NOTE]
> Soloinsight-CloudGate SSO also supports automatic user provisioning, you can find more details [here](./soloinsight-cloudgate-sso-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Soloinsight-CloudGate SSO Sign-on URL where you can initiate the login flow. 

* Go to Soloinsight-CloudGate SSO Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Soloinsight-CloudGate SSO tile in the My Apps, this option redirects to Soloinsight-CloudGate SSO Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Soloinsight-CloudGate SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
