---
title: Microsoft Entra SSO integration with Compliance Genie
description: Learn how to configure single sign-on between Microsoft Entra ID and Compliance Genie.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 01/27/2023
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Compliance Genie so that I can control who has access to Compliance Genie, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Compliance Genie

In this article, you'll learn how to integrate Compliance Genie with Microsoft Entra ID. Compliance Genie is an all-in-One Health & Safety App, allowing to manage and keep track of health & safety across your company for risk assessments, incident management, audits and documentation. When you integrate Compliance Genie with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Compliance Genie.
* Enable your users to be automatically signed-in to Compliance Genie with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for Compliance Genie in a test environment. Compliance Genie supports both **SP** initiated single sign-on and also supports **Just In Time** user provisioning.

## Prerequisites

To integrate Microsoft Entra ID with Compliance Genie, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: Global Administrator, Cloud Application Administrator, Application Administrator, or owner of the service principal.
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Compliance Genie single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the Compliance Genie application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-compliance-genie-from-the-azure-ad-gallery'></a>

### Add Compliance Genie from the Microsoft Entra gallery

Add Compliance Genie from the Microsoft Entra application gallery to configure single sign-on with Compliance Genie. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Compliance Genie** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a URL using the following pattern:
    `https://login.microsoftonline.com/<TenantID>`

    b. In the **Reply URL** textbox, type a URL using the following pattern:
    `https://login.be-safetech.com/Login/AzureAssertionConsumerService/<COMPANYID>`

    c. In the **Sign on URL** textbox, type the URL:
    `https://login.be-safetech.com/Login/Azure`

    > [!NOTE]
    > These values are not real. Update these values with the actual Identifier and Reply URL. Contact [Compliance Genie Client support team](mailto:admin@be-safetech.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, click copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

## Configure Compliance Genie SSO

To configure single sign-on on **Compliance Genie** side, you need to send the **App Federation Metadata Url** to [Compliance Genie support team](mailto:admin@be-safetech.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Compliance Genie test user

In this section, a user called B.Simon is created in Compliance Genie. Compliance Genie supports just-in-time user provisioning, which is enabled by default. There is no action item for you in this section. If a user doesn't already exist in Compliance Genie, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Compliance Genie Sign-on URL where you can initiate the login flow. 

* Go to Compliance Genie Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Compliance Genie tile in the My Apps, this will redirect to Compliance Genie Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure Compliance Genie you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
