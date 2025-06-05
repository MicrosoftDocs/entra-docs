---
title: Configure SurveyMonkey Enterprise for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SurveyMonkey Enterprise.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SurveyMonkey Enterprise so that I can control who has access to SurveyMonkey Enterprise, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SurveyMonkey Enterprise for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SurveyMonkey Enterprise with Microsoft Entra ID. When you integrate SurveyMonkey Enterprise with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SurveyMonkey Enterprise.
* Enable your users to be automatically signed-in to SurveyMonkey Enterprise with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SurveyMonkey Enterprise single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SurveyMonkey Enterprise supports **IDP** initiated SSO.
* SurveyMonkey Enterprise supports [Automated user provisioning](surveymonkey-enterprise-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add SurveyMonkey Enterprise from the gallery

To configure the integration of SurveyMonkey Enterprise into Microsoft Entra ID, you need to add SurveyMonkey Enterprise from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SurveyMonkey Enterprise** in the search box.
1. Select **SurveyMonkey Enterprise** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-surveymonkey-enterprise'></a>

## Configure and test Microsoft Entra SSO for SurveyMonkey Enterprise

Configure and test Microsoft Entra SSO with SurveyMonkey Enterprise using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SurveyMonkey Enterprise.

To configure and test Microsoft Entra SSO with SurveyMonkey Enterprise, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SurveyMonkey Enterprise SSO](#configure-surveymonkey-enterprise-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SurveyMonkey Enterprise test user](#create-surveymonkey-enterprise-test-user)** - to have a counterpart of B.Simon in SurveyMonkey Enterprise that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SurveyMonkey Enterprise** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. SurveyMonkey Enterprise application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

    ![image](common/edit-attribute.png)

6. In addition to above, SurveyMonkey Enterprise application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirement.

    | Name | Source Attribute|
	| ---------------| --------------- |
	| Email | user.mail |
    | FirstName | user.givenname |
    | LastName | user.surname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up SurveyMonkey Enterprise** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SurveyMonkey Enterprise SSO

To configure single sign-on on **SurveyMonkey Enterprise** side, please refer [this](https://help.surveymonkey.com/teams/single-sign-on/#set-up) article.

### Create SurveyMonkey Enterprise test user

It isn't necessary to create a test user in SurveyMonkey Enterprise. User accounts are provisioned, if the user chooses to create a new account, based on the SAML assertion. Your SurveyMonkey Enterprise Customer Success Manager will provide steps to complete this process after your Azure metadata has been added to the SurveyMonkey Enterprise configuration and it's ready to be validated.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the SurveyMonkey Enterprise for which you set up the SSO.

* You can use Microsoft My Apps. When you select the SurveyMonkey Enterprise tile in the My Apps, you should be automatically signed in to the SurveyMonkey Enterprise for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure SurveyMonkey Enterprise you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
