---
title: 'Tutorial: Microsoft Entra SSO integration with Blue Access for Members (BAM)'
description: Learn how to configure single sign-on between Microsoft Entra ID and Blue Access for Members (BAM).

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Blue Access for Members (BAM) so that I can control who has access to Blue Access for Members (BAM), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra SSO integration with Blue Access for Members (BAM)

In this tutorial, you'll learn how to integrate Blue Access for Members (BAM) with Microsoft Entra ID. When you integrate Blue Access for Members (BAM) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Blue Access for Members (BAM).
* Enable your users to be automatically signed-in to Blue Access for Members (BAM) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Blue Access for Members (BAM) single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Blue Access for Members (BAM) supports **IDP** initiated SSO.

## Add Blue Access for Members (BAM) from the gallery

To configure the integration of Blue Access for Members (BAM) into Microsoft Entra ID, you need to add Blue Access for Members (BAM) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Blue Access for Members (BAM)** in the search box.
1. Select **Blue Access for Members (BAM)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-blue-access-for-members-bam'></a>

## Configure and test Microsoft Entra SSO for Blue Access for Members (BAM)

Configure and test Microsoft Entra SSO with Blue Access for Members (BAM) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Blue Access for Members (BAM).

To configure and test Microsoft Entra SSO with Blue Access for Members (BAM), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Blue Access for Members (BAM) SSO](#configure-blue-access-for-members-bam-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Blue Access for Members (BAM) test user](#create-blue-access-for-members-bam-test-user)** - to have a counterpart of B.Simon in Blue Access for Members (BAM) that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Blue Access for Members (BAM)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `<Custom Domain Value>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<CUSTOMURL>/affwebservices/public/saml2assertionconsumer`

    c. Click **Set additional URLs**.

    d. In the **Relay State** text box, type a URL using the following pattern:
    `https://<CUSTOMURL>/BAMSSOServlet/sso/BamInboundSsoServlet`

	> [!NOTE]
	> These values are not real. Update these values with the actual Identifier, Reply URL and Relay State. Contact [Blue Access for Members (BAM) Client support team](https://www.bcbstx.com/contact-us) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Blue Access for Members (BAM) application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attribute mappings.](common/default-attributes.png "Attributes")

1. In addition to above, Blue Access for Members (BAM) application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ------------ | --------- |
	| ClientID | `<ClientID>` |
    | UID | `<UID>` |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Blue Access for Members (BAM)** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to Blue Access for Members (BAM).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Blue Access for Members (BAM)**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
1. If you're expecting any role value in the SAML assertion, in the **Select Role** dialog, select the appropriate role for the user from the list and then click the **Select** button at the bottom of the screen.
1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Blue Access for Members (BAM) SSO

To configure single sign-on on **Blue Access for Members (BAM)** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Blue Access for Members (BAM) support team](https://www.bcbstx.com/contact-us). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Blue Access for Members (BAM) test user

In this section, you create a user called B.Simon in Blue Access for Members (BAM). Work with [Blue Access for Members (BAM) support team](https://www.bcbstx.com/contact-us) to add the users in the Blue Access for Members (BAM) platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Click on **Test this application**, and you should be automatically signed in to the Blue Access for Members (BAM) for which you set up the SSO.

* You can use Microsoft My Apps. When you click the Blue Access for Members (BAM) tile in the My Apps, you should be automatically signed in to the Blue Access for Members (BAM) for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Next steps

Once you configure Blue Access for Members (BAM) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
