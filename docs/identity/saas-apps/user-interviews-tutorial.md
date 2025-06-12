---
title: Configure User Interviews for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and User Interviews.
services: active-directory
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 04/05/2024
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure User Interviews for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate User Interviews with Microsoft Entra ID. When you integrate User Interviews with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to User Interviews.
* Enable your users to be automatically signed-in to User Interviews with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* User Interviews single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* User Interviews supports both **SP and IDP** initiated SSO.
* User Interviews supports **Just In Time** user provisioning.

## Add User Interviews from the gallery

To configure the integration of User Interviews into Microsoft Entra ID, you need to add User Interviews from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **User Interviews** in the search box.
1. Select **User Interviews** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for User Interviews

Configure and test Microsoft Entra SSO with User Interviews using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in User Interviews.

To configure and test Microsoft Entra SSO with User Interviews, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure User Interviews SSO](#configure-user-interviews-sso)** - to configure the single sign-on settings on application side.
    1. **[Create User Interviews test user](#create-user-interviews-test-user)** - to have a counterpart of B.Simon in User Interviews that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **User Interviews** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using one of the following patterns:

    | **Identifier** |
    | -------------- |
    | `https://www.userinterviews.com/saml/metadata?team_id=<team_id>` |
    | `https://www.userinterviews.com/saml/metadata?<team_id>` |

    b. In the **Reply URL** text box, type one of the following URL/Pattern:

    | **Reply URL** |
    | -------------- |
    | `https://www.userinterviews.com/saml/consume?team_id=<team_id>` |
    | `https://www.userinterviews.com/saml/consume` |

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://www.userinterviews.com/saml/join?team_id=<team_id>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [User Interviews support team](mailto:support@userinterviews.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. User Interviews application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, User Interviews application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| -----| ---------------- |
	| first_name | user.givenname |
	| last_name | user.surname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up User Interviews** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure User Interviews SSO

1. Log in to User Interviews company site as an administrator.

1. Go to **Microsoft Entra Setup** > **Team settings** > **Advanced options** and perform the following steps:

    ![Screenshot shows the configuration.](./media/user-interviews-tutorial/configuration.png#lightbox "Configuration")

    a. Open the downloaded **Certificate (Base64)** into Notepad and paste the content into the **SSO Certificate** textbox.

    b. In the **SSO Entity ID** textbox, paste the **Microsoft Entra Identifier** which you have copied from the Microsoft Entra admin center.

    c. In the **SSO URL** textbox, paste the **Login URL** value which you copied from the Microsoft Entra admin center.

    d. Select **Save**.

    e. Copy the **ACS URL** and paste it in the **Reply URL** textbox in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

    f. Copy the **Entity ID** and paste it in the **Identifier (Entity ID)** textbox in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

### Create User Interviews test user

In this section, a user called Britta Simon is created in User Interviews. User Interviews supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in User Interviews, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to User Interviews Sign on URL where you can initiate the login flow.  
 
* Go to User Interviews Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the User Interviews for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the User Interviews tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the User Interviews for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure User Interviews you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).