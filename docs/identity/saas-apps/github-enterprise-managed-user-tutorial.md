---
title: Configure a GitHub enterprise with Enterprise Managed Users for SAML Single sign-on with Microsoft Entra ID
description: Learn how to configure SAML single sign-on between Microsoft Entra ID and a GitHub enterprise with Enterprise Managed Users.
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/22/2024
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure SAML single sign-on between Microsoft Entra ID and a GitHub enterprise with Enterprise Managed Users so that I can control who has access to the type of GitHub enterprise, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure a GitHub enterprise with Enterprise Managed Users for SAML Single sign-on with Microsoft Entra ID

In this article, you learn how to setup a SAML integration for a GitHub enterprise with Enterprise Managed Users with Microsoft Entra ID. Setting up a SAML or [OIDC](https://docs.github.com/enterprise-cloud@latest/admin/managing-iam/configuring-authentication-for-enterprise-managed-users/configuring-oidc-for-enterprise-managed-users) authentication integration, in addition to setting up [SCIM provisioning](./github-enterprise-managed-user-provisioning-tutorial.md), is required for a GitHub enterprise with Enterprise Managed Users. Setting up authentication and [SCIM provisioning](./github-enterprise-managed-user-provisioning-tutorial.md) for a GitHub enterprise with Enterprise Managed Users allows an admin to:

* Control in Microsoft Entra ID who has access to a GitHub enterprise with Enterprise Managed Users.
* Enable your users to log into a GitHub Enterprise Managed User account via SSO.
* Provision users and groups to the enterprise (once both the authentication and SCIM provisioning integrations have been setup). GitHub teams can be mapped to SCIM-provisioned groups. 
* Manage your accounts and groups in one central location, Entra ID.

> [!NOTE]
> A GitHub.com enterprise account with Enterprise Managed Users is a specific type of enterprise. This is determined with you request or [create a new GitHub enterprise account](https://docs.github.com/en/enterprise-cloud@latest/admin/managing-your-enterprise-account/creating-an-enterprise-account) on GitHub.com. You can read more about the different types of GitHub enterprises in [this GitHub article](https://docs.github.com/en/enterprise-cloud@latest/admin/managing-iam/understanding-iam-for-enterprises/choosing-an-enterprise-type-for-github-enterprise-cloud). If you do not have an enterprise that is setup for Enterprise Managed Users, please see [this GitHub article](https://docs.github.com/en/enterprise-cloud@latest/admin/managing-iam/understanding-iam-for-enterprises/about-identity-and-access-management#authentication-through-githubcom-with-additional-saml-access-restriction) for more details and links. 

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* GitHub Enterprise Managed User single sign-on (SSO) enabled subscription.
* A GitHub enterprise that is setup for Enterprise Managed Users.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* GitHub Enterprise Managed User supports both **SP and IDP** initiated SSO.
* GitHub Enterprise Managed User requires [**Automated** user provisioning](./github-enterprise-managed-user-provisioning-tutorial.md).

## Adding GitHub Enterprise Managed User from the gallery

To configure the integration of GitHub Enterprise Managed User into Microsoft Entra ID, you need to add GitHub Enterprise Managed User from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. Type **GitHub Enterprise Managed User** in the search box.
1. Select **GitHub Enterprise Managed User** from results panel and then select the **Create** button. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-github-enterprise-managed-user'></a>

## Configure and test Microsoft Entra SAML SSO for a GitHub enterprise with Enterprise Managed Users

To configure and test Microsoft Entra SSO with GitHub Enterprise Managed User, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable SAML Single Sign On in your Microsoft Entra tenant.
1. **[Configure GitHub Enterprise Managed User SSO](#configure-github-enterprise-managed-user-sso)** - to configure the single sign-on settings in your GitHub Enterprise.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SAML SSO

Follow these steps to enable Microsoft Entra SAML SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **GitHub Enterprise Managed User** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png)

1. Ensure that you have your Enterprise URL before you begin. The ENTITY field mentioned below is the Enterprise name of your EMU-enabled Enterprise URL. For example, https://github.com/enterprises/contoso - **contoso** is the ENTITY. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://github.com/enterprises/{enterprise}`
    
    > [!NOTE]
    > Note the identifier format is different from the application's suggested format - please follow the format above. In addition, please ensure the **Identifier doesn't contain a trailing slash.
    
    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://github.com/enterprises/{enterprise}/saml/consume`
    

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://github.com/enterprises/{enterprise}/sso`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (PEM)** and select **PEM certificate download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificate-base64-download.png "Certificate")

1. On the **Set up GitHub Enterprise Managed User** section, copy the URLs below and save it for configuring GitHub below.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you assign your account to GitHub Enterprise Managed User in order to complete SSO setup.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **GitHub Enterprise Managed User**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select your account from the Users list, then select the **Select** button at the bottom of the screen.
1. In the **Select a role** dialog, select the **Enterprise Owner** role, then select the **Select** button at the bottom of the screen. Your account is assigned as an Enterprise Owner for your GitHub instance when you provision your account in the next article. 
1. In the **Add Assignment** dialog, select the **Assign** button.

## Configure GitHub Enterprise Managed User SSO

To configure single sign-on on **GitHub Enterprise Managed User** side, you require the following items from the Entra ID app:

1. The URLs from your Microsoft Entra Enterprise Managed User Application above: the `Login URL` and the `Microsoft Entra Identifier`.
2. The downloaded base64 certificate.
1. The username and password for [the setup user account](https://docs.github.com/enterprise-cloud@latest/admin/managing-iam/understanding-iam-for-enterprises/getting-started-with-enterprise-managed-users#create-the-setup-user) for your GitHub enterprise.

### Enable GitHub Enterprise Managed User SAML SSO

In this section, you take the information provided from Microsoft Entra ID above and enter them into your Enterprise settings to enable SSO support.

1. Follow the steps in [this GitHub documentation](https://docs.github.com/enterprise-cloud@latest/admin/managing-iam/configuring-authentication-for-enterprise-managed-users/configuring-saml-single-sign-on-for-enterprise-managed-users#configure-your-enterprise) to configure SAML authentication for your enterprise.
1. When entering the `Sign-on URL`, note that this is the Login URL that you copied from Microsoft Entra ID above.
1. When entering the `Issuer`, note that this is the `Microsoft Entra Identifier` that you copied from Microsoft Entra ID above.
1. When entering the Public Certificate, open the base64 certificate that you downloaded above and paste the text contents of that file into this dialog.
1. After completing the steps in GitHub documentation to configure SAML authentication for your enterprise, only SCIM-provisioned enterprise managed users will be able to access the enterprise (with the exception of logging in with the setup user account and using an enterprise recovery code). Complete the steps in the Provisioning tutorial below to configure SCIM provisioning for the GitHub enterprise, so that you can provision Enterprise Managed Users and groups. Users will not be able to log in and access the enterprise until these steps are completed and their user accounts have been SCIM provisioned in the enterprise.

## Related content

GitHub Enterprise Managed User **requires** all accounts to be created through automatic (SCIM) user provisioning, you can find more details [here](./github-enterprise-managed-user-provisioning-tutorial.md) on how to configure automatic user provisioning.
