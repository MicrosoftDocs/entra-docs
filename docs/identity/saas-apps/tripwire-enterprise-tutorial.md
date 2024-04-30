---
title: Microsoft Entra SSO integration with Tripwire Enterprise
description: Learn how to configure single sign-on between Microsoft Entra ID and Tripwire Enterprise.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 01/02/2023
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Tripwire Enterprise so that I can control who has access to Tripwire Enterprise, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Tripwire Enterprise

In this article, you'll learn how to integrate Tripwire Enterprise with Microsoft Entra ID. Tripwire Enterprise is the leading compliance monitoring solution, using file integrity monitoring (FIM) and security configuration management (SCM). When you integrate Tripwire Enterprise with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Tripwire Enterprise.
* Enable your users to be automatically signed-in to Tripwire Enterprise with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for Tripwire Enterprise in a test environment. Tripwire Enterprise supports **IDP** initiated single sign-on.

## Prerequisites

To integrate Microsoft Entra ID with Tripwire Enterprise, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: Global Administrator, Cloud Application Administrator, Application Administrator, or owner of the service principal.
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Tripwire Enterprise single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the Tripwire Enterprise application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-tripwire-enterprise-from-the-azure-ad-gallery'></a>

### Add Tripwire Enterprise from the Microsoft Entra gallery

Add Tripwire Enterprise from the Microsoft Entra application gallery to configure single sign-on with Tripwire Enterprise. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Tripwire Enterprise** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file** then perform the following steps:

	a. Click **Upload metadata file**.

    ![Screenshot shows how to upload metadata file.](common/upload-metadata.png "File")

	b. Click on **folder logo** to select the metadata file and click **Upload**.

	![Screenshot shows to choose metadata file.](common/browse-upload-metadata.png "Folder")

	c. After the metadata file is successfully uploaded, the **Identifier** and **Reply URL** values get auto populated in Basic SAML Configuration section.

1. Your Tripwire Enterprise application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Tripwire Enterprise expects this to be mapped with the user's email address. For that you can use **user.mailnickname** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![Screenshot shows the image of token attributes.](common/default-attributes.png "Attributes")

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

## Configure Tripwire Enterprise SSO

To configure single sign-on in Tripwire Enterprise, please see **Using Tripwire Enterprise with SAML Authentication** section in the Tripwire Enterprise Hardeing Guide, available for download on the [Tripwire Customer Center](https://tripwireinc.force.com/customers/home). If you require assistance, contact [Tripwire Enterprise support team](mailto:support@tripwire.com).

### Create Tripwire Enterprise test user

To create a Tripwire Enterprise user, please see **Creating a User Account** section in the Tripwire Enterprise User Guide, available for download on the [Tripwire Customer Center](https://tripwireinc.force.com/customers/home). If you require assistance, contact [Tripwire Enterprise support team](mailto:support@tripwire.com).

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Click on **Test this application**, and you should be automatically signed in to the Tripwire Enterprise for which you set up the SSO.

* You can use Microsoft My Apps. When you click the Tripwire Enterprise tile in the My Apps, you should be automatically signed in to the Tripwire Enterprise for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure Tripwire Enterprise you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
