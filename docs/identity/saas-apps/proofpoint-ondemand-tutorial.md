---
title: Configure Proofpoint on Demand for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Proofpoint on Demand.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Proofpoint on Demand so that I can control who has access to Proofpoint on Demand, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Proofpoint on Demand for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Proofpoint on Demand with Microsoft Entra ID. When you integrate Proofpoint on Demand with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Proofpoint on Demand.
* Enable your users to be automatically signed-in to Proofpoint on Demand with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Proofpoint on Demand single sign-on (SSO) enabled subscription.

> [!NOTE]
> If you're using MFA or Passwordless authentication with Microsoft Entra ID then switch off the AuthnContext value in the SAML Request. Otherwise Microsoft Entra ID will throw the error on mismatch of the AuthnContext and doesn't send the token back to the application.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Proofpoint on Demand supports **SP** initiated SSO.

## Add Proofpoint on Demand from the gallery

To configure the integration of Proofpoint on Demand into Microsoft Entra ID, you need to add Proofpoint on Demand from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Proofpoint on Demand** in the search box.
1. Select **Proofpoint on Demand** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-proofpoint-on-demand'></a>

## Configure and test Microsoft Entra SSO for Proofpoint on Demand

Configure and test Microsoft Entra SSO with Proofpoint on Demand using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Proofpoint on Demand.

To configure and test Microsoft Entra SSO with Proofpoint on Demand, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Proofpoint on Demand SSO](#configure-proofpoint-on-demand-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Proofpoint on Demand test user](#create-proofpoint-on-demand-test-user)** - to have a counterpart of B.Simon in Proofpoint on Demand that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Proofpoint on Demand** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** box, type a URL using the following pattern:
    `https://<hostname>.pphosted.com/ppssamlsp`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<hostname>.pphosted.com:portnumber/v1/samlauth/samlconsumer`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<hostname>.pphosted.com/ppssamlsp_hostname`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Proofpoint on Demand Client support team](https://www.proofpoint.com/us/support-services) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Proofpoint on Demand** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Proofpoint on Demand SSO

To configure single sign-on on **Proofpoint on Demand** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Proofpoint on Demand support team](https://www.proofpoint.com/us/support-services). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Proofpoint on Demand test user

In this section, you create a user called Britta Simon in Proofpoint on Demand. Work with [Proofpoint on Demand Client support team](https://www.proofpoint.com/us/support-services) to add users in the Proofpoint on Demand platform.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Proofpoint on Demand Sign-on URL where you can initiate the login flow. 

* Go to Proofpoint on Demand Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Proofpoint on Demand tile in the My Apps, this option redirects to Proofpoint on Demand Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Proofpoint on Demand you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
