---
title: Configure SuperAnnotate for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SuperAnnotate.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SuperAnnotate so that I can control who has access to SuperAnnotate, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SuperAnnotate for Single sign-on with Microsoft Entra ID

In this article, you learn how to integrate SuperAnnotate with Microsoft Entra ID. SuperAnnotate is the all-in-one AI data infrastructure platform that helps ML and data teams save time on building accurate AI models with the highest quality training data - SuperData. When you integrate SuperAnnotate with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SuperAnnotate.
* Enable your users to be automatically signed-in to SuperAnnotate with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for SuperAnnotate in a test environment. SuperAnnotate supports only **SP** initiated single sign-on.

## Prerequisites

To integrate Microsoft Entra ID with SuperAnnotate, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* SuperAnnotate single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the SuperAnnotate application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-superannotate-from-the-azure-ad-gallery'></a>

### Add SuperAnnotate from the Microsoft Entra gallery

Add SuperAnnotate from the Microsoft Entra application gallery to configure single sign-on with SuperAnnotate. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SuperAnnotate** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier** textbox, type a value using the following pattern:
	`urn:amazon:cognito:sp:<USER_POOL_ID>` 

	b. In the **Reply URL** textbox, type a URL using the following pattern:
	`https://<DOMAIN PREFIX>.auth.<REGION>.amazoncognito.com/saml2/idpresponse`

	c. In the **Sign on URL** textbox, type the URL:
	`https://auth.superannotate.com/login`

	> [!Note]
    > These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [SuperAnnotate support team](mailto:support@superannotate.com) to get these values. You can also refer to the patterns shown in the Basic SAML Configuration section.

1. SuperAnnotate application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, SuperAnnotate application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ---------------|  --------- |
    | groups | user.groups [ApplicationGroup] |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, copy the **App Federation Metadata Url** or download the **Federation Metadata XML** and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

## Configure SuperAnnotate SSO

To configure single sign-on on **SuperAnnotate** side, you need to set up the copied **App Federation Metadata Url** or the downloaded **Federation Metadata XML** in the SSO setup page of the SuperAnnotate side to have the SAML SSO connection set properly on both sides.

### Create SuperAnnotate test user

In this section, you create a user called Britta Simon in SuperAnnotate. Work with [SuperAnnotate support team](mailto:support@superannotate.com) to add the users in the SuperAnnotate platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to SuperAnnotate Sign-on URL where you can initiate the login flow. 

* Go to SuperAnnotate Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the SuperAnnotate tile in the My Apps, this option redirects to SuperAnnotate Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Related content

Once you configure SuperAnnotate you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
