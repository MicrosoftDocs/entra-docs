---
title: Configure Sage Intacct for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Sage Intacct.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 08/20/2024
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Sage Intacct so that I can control who has access to Sage Intacct, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Sage Intacct for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Sage Intacct with Microsoft Entra ID. When you integrate Sage Intacct with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Sage Intacct.
* Enable your users to be automatically signed-in to Sage Intacct with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Sage Intacct single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Sage Intacct supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Sage Intacct from the gallery

To configure the integration of Sage Intacct into Microsoft Entra ID, you need to add Sage Intacct from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Sage Intacct** in the search box.
1. Select **Sage Intacct** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-sage-intacct'></a>

## Configure and test Microsoft Entra SSO for Sage Intacct

Configure and test Microsoft Entra SSO with Sage Intacct using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Sage Intacct.

To configure and test Microsoft Entra SSO with Sage Intacct, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
2. **[Configure Sage Intacct SSO](#configure-sage-intacct-sso)** - to configure the single sign-on settings on application side.
    1. **[Set up individual users in Intacct](#set-up-individual-users-in-intacct)** - to have a counterpart of B.Simon in Sage Intacct that's linked to the Microsoft Entra representation of user.
6. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Sage Intacct** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier (Entity ID)** text box, type a unique identifier for your Sage Intacct company, with the following format:

   	   `https://saml.intacct.com`.

	b. In the **Reply URL** text box, add the following URLs:  

	| Reply URL |
	| --------------- |
	| `https://www.intacct.com/ia/acct/sso_response.phtml` (Select as the default.) |
	| `https://www-p01.intacct.com/ia/acct/sso_response.phtml` | 
	| `https://www-p02.intacct.com/ia/acct/sso_response.phtml` | 
	| `https://www-p03.intacct.com/ia/acct/sso_response.phtml` | 
	| `https://www-p04.intacct.com/ia/acct/sso_response.phtml` |  
	| `https://www-p05.intacct.com/ia/acct/sso_response.phtml` |
	| `https://www-p06.intacct.com/ia/acct/sso_response.phtml` |

1. The Sage Intacct application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Select **Edit** icon to open User Attributes dialog.

	![image](common/edit-attribute.png)

1. In the **Attributes & Claims** dialog, perform the following steps:

	a. Edit **Unique User Identifier (Name ID)** and set source attribute to user.mail and verify Name identifier format is set to Email address and select **Save**
	
	b. Remove all default Additional claims attributes by selecting ***...*** and Delete.
    
	| Attribute Name  |  Source Attribute|
	| ---------------| --------------- |
	| Company Name | **Sage Intacct Company ID** |
	| name | `<User ID>`|

    > [!NOTE]
    > Enter the `<User ID>` value should be same as the Sage Intacct **User ID**, which you enter in the **[Set up individual users in Intacct](#set-up-individual-users-in-intacct)**, which is explained later in the article. Usually, this is the prefix of the email address. In this case, you can set the source as a transformation and use ExtractMailPrefix() on user.mail parameter.

	c. Select **Add new claim** to open the **Manage user claims** dialog.

	d. In the **Name** textbox, type the attribute name shown for that row.

	e. Leave the **Namespace** blank.

	f. Select Source as **Attribute**.

	g. From the **Source attribute** list, type or select the attribute value shown for that row.

	h. Select **Ok**

	i. Select **Save**.
	
    > Repeat steps c-i to add both custom attributes.
	

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Edit** to open the dialog. Select **...** next to the Active certificate and select **PEM certificate download** to download the certificate and save it to your local drive.

	![The Certificate download link](common/certificate-base64-download.png)

1. On the **Set up Sage Intacct** section, copy the Login URL as you use it within Sage Intacct configuration.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Sage Intacct SSO

1. In a different web browser window, sign in to your Sage Intacct company site as an administrator.

1. Go to **Company**, select the **Setup** tab, and select **Company** under the Configuration section.

    ![Company](./media/intacct-tutorial/setup.png)

1. Select the **Security** tab, and then select **Edit**.

    ![screenshot for Security](./media/intacct-tutorial/security.png "Security")

1. In the **Single sign on (SSO)** section, perform the following steps:

    ![Single sign on](./media/intacct-tutorial/intacct-configuration.png)

    a. Select **Enable single sign on**.

    b. As **Identity provider type**, select **SAML 2.0**.

    c. In **Issuer URL** textbox, paste the value of **Identifier (Entity ID)**, which you created in the Basic SAML Configuration dialog.

    d. In **Login URL** textbox, paste the value of **Login URL**.

    e. Open your **PEM** encoded certificate in notepad, copy the content of it into your clipboard, and then paste it to the **Certificate** box.
    
    f. Set **Requested authentication content type** to **Exact**.

    g. Select **Save**.

### Set up individual users in Intacct

When SSO is enabled for your company, you can individually require users to use SSO when logging in to your company. After you set up a user for SSO, the user will no longer be able to use a password to log in to your company directly. Instead, that user will need to use single sign-on and be authenticated by your SSO identity provider as an authorized user. Any users who aren't set up for SSO can continue to log in to your company using the basic sign-in page.

**To enable SSO for a user, perform the following steps:**

1. Sign in to your **Sage Intacct** company.

1. Go to **Company**, select the **Admin** tab, then select **Users**.

    ![Screenshot for Users](./media/intacct-tutorial/users.png "Users")

1. Locate the desired user and select **Edit** next to it.

    ![Screenshot to Edit the user](./media/intacct-tutorial/user-edit.png "edit")

1. Select the **Single sign-on** tab and type the **Federated SSO user ID**. 

> [!NOTE] 
> This value is mapped with the Unique User Identifier found in Azure's Attributes & Claims dialog.

![Screenshot shows the User Information section where you can enter the Federated S S O user i d.](./media/intacct-tutorial/user-information.png "User Information")

> [!NOTE]
> To provision Microsoft Entra user accounts, you can use other Sage Intacct user account creation tools or APIs that are provided by Sage Intacct.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Sage Intacct for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Sage Intacct tile in the My Apps, you should be automatically signed in to the Sage Intacct for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Sage Intacct you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
