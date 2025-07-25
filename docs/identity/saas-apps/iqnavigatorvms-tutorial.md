---
title: Configure IQNavigator VMS for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and IQNavigator VMS.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and IQNavigator VMS so that I can control who has access to IQNavigator VMS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure IQNavigator VMS for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate IQNavigator VMS with Microsoft Entra ID. When you integrate IQNavigator VMS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to IQNavigator VMS.
* Enable your users to be automatically signed-in to IQNavigator VMS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* IQNavigator VMS single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* IQNavigator VMS supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add IQNavigator VMS from the gallery

To configure the integration of IQNavigator VMS into Microsoft Entra ID, you need to add IQNavigator VMS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **IQNavigator VMS** in the search box.
1. Select **IQNavigator VMS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-iqnavigator-vms'></a>

## Configure and test Microsoft Entra SSO for IQNavigator VMS

Configure and test Microsoft Entra SSO with IQNavigator VMS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in IQNavigator VMS.

To configure and test Microsoft Entra SSO with IQNavigator VMS, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure IQNavigator VMS SSO](#configure-iqnavigator-vms-sso)** - to configure the single sign-on settings on application side.
    1. **[Create IQNavigator VMS test user](#create-iqnavigator-vms-test-user)** - to have a counterpart of B.Simon in IQNavigator VMS that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **IQNavigator VMS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the value:
    `iqn.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<subdomain>.iqnavigator.com/security/login?client_name=https://sts.window.net/<instance name>`

    c. Select **Set additional URLs**.

    d. In the **Relay State** text box, type a URL using the following pattern:
    `https://<subdomain>.iqnavigator.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Reply URL and Relay State. Contact [IQNavigator VMS Client support team](https://www.beeline.com/contact-support/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. IQNavigator application expect the Unique User Identifier value in the Name Identifier claim. Customer can map the correct value for the Name Identifier claim. In this case we have mapped the user.UserPrincipalName for the demo purpose. But according to your organization settings you should map the correct value for it.

	![Screenshot shows the image of IQNavigator application.](common/edit-attribute.png "Image")

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure IQNavigator VMS SSO

To configure single sign-on on **IQNavigator VMS** side, you need to send the **App Federation Metadata Url** to [IQNavigator VMS support team](https://www.beeline.com/contact-support/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create IQNavigator VMS test user

In this section, you create a user called Britta Simon in IQNavigator VMS. Work with [IQNavigator VMS support team](https://www.beeline.com/contact-support/) to add the users in the IQNavigator VMS platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the IQNavigator VMS for which you set up the SSO.

* You can use Microsoft My Apps. When you select the IQNavigator VMS tile in the My Apps, you should be automatically signed in to the IQNavigator VMS for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure IQNavigator VMS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
