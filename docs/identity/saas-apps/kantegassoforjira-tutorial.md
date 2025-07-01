---
title: Configure Jira for Single sign-on in Microsoft Entra ID using Kantego SSO
description: Learn how to configure single sign-on between Microsoft Entra ID and Jira using Kantega SSO.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Kantega SSO for JIRA so that I can control who has access to Kantega SSO for JIRA, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Jira for Single sign-on in Microsoft Entra ID using Kantego SSO

This article will walk you through the steps of configuring single sign-on for your Microsoft Entra users in Jira. To achieve this, we is using the Kantega SSO app. Using this configuration, you be able to:

* Control which users have Jira access from Microsoft Entra ID.
* Automatically sign in to Jira when you have an active Microsoft Entra session.
* Manage your accounts in one central location.

Read more on the official [Kantega SSO documentation](https://kantega-sso.atlassian.net/wiki/spaces/KSE/pages/895844483/Azure+AD).

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Jira Data Center instance. You can [try it for free](https://www.atlassian.com/software/jira/download/data-center).
* Kantega SSO app for Jira from Atlassian Marketplace. You can [try it for free](https://marketplace.atlassian.com/apps/1211923/k-sso-saml-kerberos-openid-oidc-oauth-for-jira?tab=overview&hosting=datacenter).

## Scenario description

In this article,  you configure and test single sign-on with Microsoft Entra ID in a Jira test environment.

* Kantega SSO supports **SAML and OIDC**.
* Kantega SSO supports **SP and IDP** initiated SSO.
* Kantega SSO supports Automated user provisioning and deprovisioning (recommended).
* Kantega SSO supports Just-in-Time user provisioning.

## Add Kantega SSO for JIRA from the gallery

To configure the integration of Kantega SSO for JIRA into Microsoft Entra ID, you need to add Kantega SSO for JIRA from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Kantega SSO for JIRA** in the search box.
1. Select **Kantega SSO for JIRA** from the results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-kantega-sso-for-jira'></a>

## Configure and test Microsoft Entra SSO for Kantega SSO for JIRA

Configure and test Microsoft Entra SSO with Kantega SSO for JIRA using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Kantega SSO for JIRA.

To configure and test Microsoft Entra SSO with Kantega SSO for JIRA, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Kantega SSO for JIRA SSO](#configure-kantega-sso-for-jira-sso)** - to configure the single sign-on settings on the application side.
    1. **[Create Kantega SSO for JIRA test user](#create-kantega-sso-for-jira-test-user)** - to have a counterpart of B.Simon in Kantega SSO for JIRA linked to the Microsoft Entra representation of the user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Kantega SSO for JIRA** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<server-base-url>/plugins/servlet/no.kantega.saml/sp/<UNIQUE_ID>/login`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<server-base-url>/plugins/servlet/no.kantega.saml/sp/<UNIQUE_ID>/login`

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<server-base-url>/plugins/servlet/no.kantega.saml/sp/<UNIQUE_ID>/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL, and Sign-On URL. These values are received during the configuration of the Jira plugin.

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

7. On the **Set up Kantega SSO for JIRA** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Kantega SSO for JIRA SSO

Kantega SSO can be configured to use either SAML or OIDC as SSO protocol. Choose one of the following guides: 

* [Kantega SSO setup guide for Microsoft Entra ID with SAML](https://kantega-sso.atlassian.net/wiki/spaces/KSE/pages/896696394/Azure+AD+SAML)
* [Kantega SSO setup guide for Microsoft Entra ID with OIDC](https://kantega-sso.atlassian.net/wiki/spaces/KSE/pages/896598077/Azure+AD+OIDC)

### Create Kantega SSO for JIRA test user

To enable Microsoft Entra users to sign in to Kantega SSO for JIRA, you must provision them. The application supports Just-in-Time user provisioning, automatic user provisioning using SCIM, or you can set up users manually. Read more about the [different provisioning options](https://kantega-sso.atlassian.net/wiki/spaces/KSE/pages/1769694/User+provisioning).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with the following options. 

#### SP initiated:

* Select **Test this application**. this option redirects to Kantega SSO for JIRA Sign-on URL, where you can initiate the login flow.  

* Go to Kantega SSO for JIRA Sign-on URL directly and initiate the login flow.

#### IDP initiated:

* Select **Test this application**, in the Azure portal, and you should be automatically signed in to the Kantega SSO for JIRA, for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Kantega SSO for JIRA tile in the My Apps, you be redirected to the application sign-on page for initiating the login flow if configured in SP mode. If configured in IDP mode, you should be automatically signed in to the Kantega SSO for JIRA, for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Kantega SSO for JIRA, you can enforce session control, which protects the exfiltration and infiltration of your organization's sensitive data in real-time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
