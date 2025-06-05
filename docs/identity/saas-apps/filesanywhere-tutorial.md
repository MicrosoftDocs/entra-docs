---
title: Configure FilesAnywhere for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FilesAnywhere.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FilesAnywhere so that I can control who has access to FilesAnywhere, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure FilesAnywhere for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FilesAnywhere with Microsoft Entra ID.
Integrating FilesAnywhere with Microsoft Entra ID provides you with the following benefits:

* You can control in Microsoft Entra ID who has access to FilesAnywhere.
* You can enable your users to be automatically signed-in to FilesAnywhere (Single Sign-On) with their Microsoft Entra accounts.
* You can manage your accounts in one central location.

If you want to know more details about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).
If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* FilesAnywhere single sign-on enabled subscription

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* FilesAnywhere supports **SP** and **IDP** initiated SSO

* FilesAnywhere supports **Just In Time** user provisioning

## Adding FilesAnywhere from the gallery

To configure the integration of FilesAnywhere into Microsoft Entra ID, you need to add FilesAnywhere from the gallery to your list of managed SaaS apps.

**To add FilesAnywhere from the gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the search box, type **FilesAnywhere**, select **FilesAnywhere** from result panel then select **Add** button to add the application.

	 ![FilesAnywhere in the results list](common/search-new-app.png)

<a name='configure-and-test-azure-ad-single-sign-on'></a>

## Configure and test Microsoft Entra single sign-on

In this section, you configure and test Microsoft Entra single sign-on with FilesAnywhere based on a test user called **Britta Simon**.
For single sign-on to work, a link relationship between a Microsoft Entra user and the related user in FilesAnywhere needs to be established.

To configure and test Microsoft Entra single sign-on with FilesAnywhere, you need to complete the following building blocks:

1. **[Configure Microsoft Entra Single Sign-On](#configure-azure-ad-single-sign-on)** - to enable your users to use this feature.
2. **[Configure FilesAnywhere Single Sign-On](#configure-filesanywhere-single-sign-on)** - to configure the Single Sign-On settings on application side.
3. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
4. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
5. **[Create FilesAnywhere test user](#create-filesanywhere-test-user)** - to have a counterpart of Britta Simon in FilesAnywhere that's linked to the Microsoft Entra representation of user.
6. **[Test single sign-on](#test-single-sign-on)** - to verify whether the configuration works.

<a name='configure-azure-ad-single-sign-on'></a>

### Configure Microsoft Entra single sign-on

In this section, you enable Microsoft Entra single sign-on.

To configure Microsoft Entra single sign-on with FilesAnywhere, perform the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FilesAnywhere** application integration page, select **Single sign-on**.

    ![Configure single sign-on link](common/select-sso.png)

1. On the **Select a Single sign-on method** dialog, select **SAML/WS-Fed** mode to enable single sign-on.

    ![Single sign-on select mode](common/select-saml-option.png)

1. On the **Set up Single Sign-On with SAML** page, select **Edit** icon to open **Basic SAML Configuration** dialog.

	![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following step:

    ![Screenshot that shows the "Basic S A M L Configuration" section with the "Reply U R L" field highlighted and the "Save" button selected.](common/both-replyurl.png)

	In the **Reply URL** text box, type a URL using the following pattern:
    `https://<company name>.filesanywhere.com/saml20.aspx?c=<Client Id>`

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    ![FilesAnywhere Domain and URLs single sign-on information](common/both-signonurl.png)

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<sub domain>.filesanywhere.com/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Reply URL and Sign-On URL. Contact [FilesAnywhere Client support team](mailto:support@FilesAnywhere.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

6. FilesAnywhere application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Select Edit icon to add the attributes.

	![Screenshot that shows the "User Attributes" section with the "Edit" button selected.](common/edit-attribute.png)

	When the users signs up with FilesAnywhere they get the value of **clientid** attribute from [FilesAnywhere team](mailto:support@FilesAnywhere.com). You have to add the "Client ID" attribute with the unique value provided by FilesAnywhere.

7. In addition to above, FilesAnywhere application expects few more attributes to be passed back in SAML response. In the **User Claims** section on the **User Attributes** dialog, perform the following steps to add SAML token attribute as shown in the below table:

	| Name | Source Attribute|
	| ---------------| --------------- |    
	| clientid | *"uniquevalue"* |

	a. Select **Add new claim** to open the **Manage user claims** dialog.

	![Screenshot that shows the "User claims" dialog with "Add new claim" and "Save" selected.](common/new-save-attribute.png)

	![image](common/new-attribute-details.png)

	b. In the **Name** textbox, type the attribute name shown for that row.

	c. Leave the **Namespace** blank.

	d. Select Source as **Attribute**.

	e. From the **Source attribute** list, type the attribute value shown for that row.

	f. Select **Ok**

	g. Select **Save**.

8. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

9. On the **Set up FilesAnywhere** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

	a. Login URL

	b. Microsoft Entra Identifier

	c. Logout URL

### Configure FilesAnywhere Single Sign-On

To configure single sign-on on **FilesAnywhere** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [FilesAnywhere support team](mailto:support@FilesAnywhere.com). They set this setting to have the SAML SSO connection set properly on both sides.

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

### Create FilesAnywhere test user

In this section, a user called Britta Simon is created in FilesAnywhere. FilesAnywhere supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in FilesAnywhere, a new one is created after authentication.

### Test single sign-on 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the FilesAnywhere tile in the Access Panel, you should be automatically signed in to the FilesAnywhere for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional Resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
