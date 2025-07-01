---
title: Configure RightAnswers for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and RightAnswers.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and RightAnswers so that I can control who has access to RightAnswers, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure RightAnswers for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate RightAnswers with Microsoft Entra ID. When you integrate RightAnswers with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to RightAnswers.
* Enable your users to be automatically signed-in to RightAnswers with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To configure Microsoft Entra integration with RightAnswers, you need the following items:

* A Microsoft Entra subscription. If you don't have a Microsoft Entra environment, you can get a [free account](https://azure.microsoft.com/free/).
* RightAnswers single sign-on enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* RightAnswers supports **SP** initiated SSO.

## Add RightAnswers from the gallery

To configure the integration of RightAnswers into Microsoft Entra ID, you need to add RightAnswers from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **RightAnswers** in the search box.
1. Select **RightAnswers** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-rightanswers'></a>

## Configure and test Microsoft Entra SSO for RightAnswers

Configure and test Microsoft Entra SSO with RightAnswers using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in RightAnswers.

To configure and test Microsoft Entra SSO with RightAnswers, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure RightAnswers SSO](#configure-rightanswers-sso)** - to configure the single sign-on settings on application side.
    1. **[Create RightAnswers test user](#create-rightanswers-test-user)** - to have a counterpart of B.Simon in RightAnswers that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **RightAnswers** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<subdomain>.rightanswers.com:<identifier>/portal`

    b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<subdomain>.rightanswers.com/portal/ss/`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [RightAnswers Client support team](https://uplandsoftware.com/rightanswers/contact/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up RightAnswers** section, copy the appropriate URL(s) as per your requirement.

    ![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure RightAnswers SSO

To configure single sign-on on **RightAnswers** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [RightAnswers support team](https://uplandsoftware.com/rightanswers/contact/). They set this setting to have the SAML SSO connection set properly on both sides.

> [!NOTE]
> Your RightAnswers support team has to do the actual SSO configuration. You get a notification when SSO has been enabled for your subscription.

### Create RightAnswers test user

To enable Microsoft Entra users to sign in to RightAnswers, they must be provisioned into RightAnswers. When RightAnswers, provisioning is an automated task so there is no action item for you.

Users are automatically created if necessary during the first single sign-on attempt.

> [!NOTE]
> You can use any other RightAnswers user account creation tools or APIs provided by RightAnswers to provision Microsoft Entra user accounts.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to RightAnswers Sign-on URL where you can initiate the login flow. 

* Go to RightAnswers Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the RightAnswers tile in the My Apps, this option redirects to RightAnswers Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure RightAnswers you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
