---
title: Configure Learning Pool LMS for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Learning Pool LMS.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Learning Pool LMS so that I can control who has access to Learning Pool LMS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Learning Pool LMS for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Learning Pool LMS with Microsoft Entra ID. When you integrate Learning Pool LMS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Learning Pool LMS.
* Enable your users to be automatically signed-in to Learning Pool LMS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* An active subscription to Learning Pool LMS with Single Sign-on.

> [!NOTE]
> When you start a single sign-on project, a member of the Learning Pool LMS Delivery team will guide you through this process. If you aren't in contact with a member of the Learning Pool LMS Delivery team, speak to your Learning Pool LMS Account Manager.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Learning Pool LMS supports **SP** initiated SSO.

## Adding Learning Pool LMS from the gallery

To configure the integration of Learning Pool LMS into Microsoft Entra ID, you need to add Learning Pool LMS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Learning Pool LMS** in the search box.
1. Select **Learning Pool LMS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-learning-pool-lms'></a>

## Configure and test Microsoft Entra SSO for Learning Pool LMS

Configure and test Microsoft Entra SSO with Learning Pool LMS with an existing Azure user. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Learning Pool LMS.

To configure and test Microsoft Entra SSO with Learning Pool LMS, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
1. **[Assign a Microsoft Entra user](#assign-an-azure-ad-user)** - to enable that user to use Microsoft Entra single sign-on.
1. **[Configure Learning Pool LMS SSO](#configure-learning-pool-lms-sso)** - to configure the single sign-on settings on application side.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Learning Pool LMS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

	![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file**, perform the following steps:

	a. Select **Upload metadata file**.

    ![Upload metadata file](common/upload-metadata.png)

	b. Select **folder logo** to select the metadata file and select **Upload**.

	![choose metadata file](common/browse-upload-metadata.png)

	c. After the metadata file is successfully uploaded, the **Identifier** value gets auto populated in Basic SAML Configuration section.

	In the **Sign-on URL** text box, type the URL:
    `https://parliament.preview.Learningpool.com/auth/shibboleth/index.php`

	> [!Note]
	> If the **Identifier** value doesn't get auto populated, then please fill in the value manually according to your requirement.

5. You must send over at least one attribute which is used to match your Azure Users with the users on Learning Pool LMS. Normally, the default attributes are enough, but in some cases you may need to send over some custom attributes. The following screenshot shows the list of default attributes. Select the **Edit** icon to open the User Attributes dialog and add more attributes if required.

	![Screenshot shows User Attributes with the Edit icon selected.](common/edit-attribute.png)

6. In the **User Claims** section on the **User Attributes** dialog, edit the claims by using **Edit icon** or add the claims by using **Add new claim** to configure SAML token attribute as shown in the image above and perform the following steps: 

	a. Select **Add new claim** to open the **Manage user claims** dialog.

	![Screenshot shows User claims with the option to Add new claim.](common/new-save-attribute.png)

	![Screenshot shows the Manage user claims dialog box where you can enter the values described.](common/new-attribute-details.png)

	b. In the **Name** textbox, type the attribute name shown for that row.

	c. Leave the **Namespace** blank.

	d. Select Source as **Attribute**.

	e. From the **Source attribute** list, type the attribute value shown for that row.

	f. Select **Ok**

	g. Select **Save**.

7. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select the Copy button by the **App Federation Metadata Url** and pass that URL back to the Learning Pool Delivery team.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='assign-an-azure-ad-user'></a>

### Assign a Microsoft Entra user

In this section, you enable an existing Microsoft Entra user to use Azure single sign-on by granting access to Learning Pool LMS.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Learning Pool LMS**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select a suitable user from the Users list, then select the **Select** button at the bottom of the screen.
1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
1. In the **Add Assignment** dialog, select the **Assign** button.

## Configure Learning Pool LMS SSO

The Learning Pool Delivery team will use the **App Federation Metadata Url** to configure the LMS to accept SAML2 connections. You be asked to perform some testing steps to verify that the connection is configured correctly and the Learning Pool Delivery team will guide you through this process.

### Test SSO

You be guided through the testing process by the Learning Pool Delivery team.

## Related content

Once you configure Learning Pool LMS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
