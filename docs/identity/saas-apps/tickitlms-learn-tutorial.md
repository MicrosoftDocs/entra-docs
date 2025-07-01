---
title: Configure TickitLMS Learn for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and TickitLMS Learn.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and TickitLMS Learn so that I can control who has access to TickitLMS Learn, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure TickitLMS Learn for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate TickitLMS Learn with Microsoft Entra ID. When you integrate TickitLMS Learn with Microsoft Entra ID, you can:

- Control in Microsoft Entra ID who has access to TickitLMS Learn.
- Enable your users to be automatically signed-in to TickitLMS Learn with their Microsoft Entra accounts.
- Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
- TickitLMS Learn single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

- TickitLMS Learn supports **SP and IDP** initiated SSO

## Adding TickitLMS Learn from the gallery

To configure the integration of TickitLMS Learn into Microsoft Entra ID, you need to add TickitLMS Learn from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **TickitLMS Learn** in the search box.
1. Select **TickitLMS Learn** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-tickitlms-learn'></a>

## Configure and test Microsoft Entra SSO for TickitLMS Learn

Configure and test Microsoft Entra SSO with TickitLMS Learn using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in TickitLMS Learn.

To configure and test Microsoft Entra SSO with TickitLMS Learn, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure TickitLMS Learn SSO](#configure-tickitlms-learn-sso)** - to configure the single sign-on settings on application side.
   1. **[Create TickitLMS Learn test user](#create-tickitlms-learn-test-user)** - to have a counterpart of B.Simon in TickitLMS Learn that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **TickitLMS Learn** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

   In the **Sign-on URL** text box, type the URL:
   `https://learn.tickitlms.com/sso/login`

1. Select **Save**.

1. TickitLMS Learn application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

   ![image](common/default-attributes.png)

1. In addition to above, TickitLMS Learn application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

   | Name        | Source Attribute |
   | ----------- | ---------------- |
   | samlaccount | user.samlaccount |
   | employeeid  | user.employeeid  |
   | role        | user.role        |
   | department  | user.department  |
   | reportsto   | user.reportsto   |

   > [!NOTE]
   > TickitLMS Learn expects roles for users assigned to the application. Please set up these roles in Microsoft Entra ID so that users can be assigned the appropriate roles. To understand how to configure roles in Microsoft Entra ID, see [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui).

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

   ![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure TickitLMS Learn SSO

To configure single sign-on on **TickitLMS Learn** side, you need to send the **App Federation Metadata Url** to [TickitLMS Learn support team](mailto:support@tickitlms.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create TickitLMS Learn test user

In this section, you create a user called Britta Simon in TickitLMS Learn. Work with [TickitLMS Learn support team](mailto:support@tickitlms.com) to add the users in the TickitLMS Learn platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

#### SP initiated:

- Select **Test this application**, this option redirects to TickitLMS Learn Sign on URL where you can initiate the login flow.

- Go to TickitLMS Learn Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

- Select **Test this application**, and you should be automatically signed in to the TickitLMS Learn for which you set up the SSO

You can also use Microsoft My Apps to test the application in any mode. When you select the TickitLMS Learn tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the TickitLMS Learn for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure TickitLMS Learn you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
