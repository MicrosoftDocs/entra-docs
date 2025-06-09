---
title: Configure Vibe HCM for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Vibe HCM.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Vibe HCM so that I can control who has access to Vibe HCM, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Vibe HCM for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Vibe HCM with Microsoft Entra ID. When you integrate Vibe HCM with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Vibe HCM.
* Enable your users to be automatically signed-in to Vibe HCM with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Vibe HCM single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Vibe HCM supports **SP** and **IDP** initiated SSO.

## Add Vibe HCM from the gallery

To configure the integration of Vibe HCM into Microsoft Entra ID, you need to add Vibe HCM from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Vibe HCM** in the search box.
1. Select **Vibe HCM** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-vibe-hcm'></a>

## Configure and test Microsoft Entra SSO for Vibe HCM

Configure and test Microsoft Entra SSO with Vibe HCM using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Vibe HCM.

To configure and test Microsoft Entra SSO with Vibe HCM, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Vibe HCM SSO](#configure-vibe-hcm-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Vibe HCM test user](#create-vibe-hcm-test-user)** - to have a counterpart of B.Simon in Vibe HCM that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Vibe HCM** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode the user doesn't have to perform any step as the app is already pre-integrated with Azure.

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<companyName>.vibehcm.com/portal.jsp`

    > [!NOTE]
	> The value isn't real. Update the value with the actual Sign-on URL. Contact [Vibe HCM Client support team](mailto:support@vibehcm.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

6. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Vibe HCM SSO

To configure single sign-on on **Vibe HCM** side, you need to send the **App Federation Metadata Url** to [Vibe HCM support team](mailto:support@vibehcm.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Vibe HCM test user

In this section, you create a user called Britta Simon in Vibe HCM. Work with [Vibe HCM support team](mailto:support@vibehcm.com) to add the users in the Vibe HCM platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Vibe HCM Sign on URL where you can initiate the login flow.  

* Go to Vibe HCM Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Vibe HCM for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Vibe HCM tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Vibe HCM for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Vibe HCM you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
