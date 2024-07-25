---
title: Microsoft Entra SSO integration with Pinpoint (SAML)
description: Learn how to configure single sign-on between Microsoft Entra ID and Pinpoint (SAML).

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Pinpoint (SAML) so that I can control who has access to Pinpoint (SAML), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Pinpoint (SAML)

In this article, you'll learn how to integrate Pinpoint (SAML) with Microsoft Entra ID. DDI’s Pinpoint platform makes it easy to design, deliver, and track blended learning journeys for leaders. Pinpoint is seamlessly integrated into DDI’s award-winning leadership development solutions. When you integrate Pinpoint (SAML) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Pinpoint (SAML).
* Enable your users to be automatically signed-in to Pinpoint (SAML) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for Pinpoint (SAML) in a test environment. Pinpoint (SAML) supports only **SP** initiated single sign-on.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Prerequisites

To integrate Microsoft Entra ID with Pinpoint (SAML), you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Pinpoint (SAML) single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the Pinpoint (SAML) application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-pinpoint-saml-from-the-azure-ad-gallery'></a>

### Add Pinpoint (SAML) from the Microsoft Entra gallery

Add Pinpoint (SAML) from the Microsoft Entra application gallery to configure single sign-on with Pinpoint (SAML). For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Pinpoint (SAML)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type the URL:
    `https://login.ddiworld.com`

    b. In the **Reply URL** textbox, type the URL:
    `https://login.ddiworld.com/SAML/sp/profile/post/acs`

    c. In the **Sign on URL** textbox, type a URL using the following pattern:
    `https://pinpoint.ddiworld.com/<CustomerName>`

    > [!Note]
    > This value is not real. Update this value with the actual Sign on URL. Contact [Pinpoint (SAML) Client support team](mailto:ssosupport@ddiworld.com) to get the value. You can also refer to the patterns shown in the Basic SAML Configuration section.
    
1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Pinpoint (SAML)** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

## Configure Pinpoint (SAML) SSO

To configure single sign-on on **Pinpoint (SAML)** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Pinpoint (SAML) support team](mailto:ssosupport@ddiworld.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Pinpoint (SAML) test user

In this section, you create a user called Britta Simon at Pinpoint (SAML). Work with [Pinpoint (SAML) support team](mailto:ssosupport@ddiworld.com) to add the users in the Pinpoint (SAML) platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Pinpoint (SAML) Sign-on URL where you can initiate the login flow. 

* Go to Pinpoint (SAML) Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Pinpoint (SAML) tile in the My Apps, this will redirect to Pinpoint (SAML) Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure Pinpoint (SAML) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
