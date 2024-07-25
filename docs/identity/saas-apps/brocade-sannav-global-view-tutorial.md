---
title: Microsoft Entra SSO integration with Brocade SANnav Global View
description: Learn how to configure single sign-on between Microsoft Entra ID and Brocade SANnav Global View.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Brocade SANnav Global View so that I can control who has access to Brocade SANnav Global View, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Brocade SANnav Global View

In this tutorial, you'll learn how to integrate Brocade SANnav Global View with Microsoft Entra ID. When you integrate Brocade SANnav Global View with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Brocade SANnav Global View.
* Enable your users to be automatically signed-in to Brocade SANnav Global View with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To integrate Microsoft Entra ID with Brocade SANnav Global View, you need:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* SANnav Global View application installed with a valid subscription license.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Brocade SANnav Global View supports both **SP and IDP** initiated SSO.

## Add Brocade SANnav Global View from the gallery

To configure the integration of Brocade SANnav Global View into Microsoft Entra ID, you need to add Brocade SANnav Global View from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Brocade SANnav Global View** in the search box.
1. Select **Brocade SANnav Global View** from the results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Brocade SANnav Global View

Configure and test Microsoft Entra SSO with Brocade SANnav Global View using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra group(s) and a Brocade Global view group. 

To configure and test Microsoft Entra SSO with Brocade SANnav Global View, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-a-microsoft-entra-id-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Create SANnav Group and assign the user to the group](#create-sannav-group-and-assign-the-user-to-the-group)** - to enable B.Simon to use Microsoft Entra single sign-on. Add importing the SANnav Global View metadata file.
1. **[Configure Brocade SANnav Global View SSO](#configure-brocade-sannav-global-view-sso)** - to configure the single sign-on settings on application side. 
    1. **[Create Brocade SANnav Global View groups](#create-brocade-sannav-global-view-groups)** - Assume B. Simon is part of the "SANnav Administrator" group in Microsoft Entra. Add importing the Microsoft Entra metadata.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Brocade SANnav Global View** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file**, then perform the following steps:

	a. Click **Upload metadata file**.

    ![Screenshot shows how to upload metadata file.](common/upload-metadata.png "File")

	b. Click on **folder logo** to select the metadata file and click **Upload**.

	![Screenshot shows how to choose metadata file.](common/browse-upload-metadata.png "Folder")

	c. After the metadata file is successfully uploaded, the **Identifier** and **Reply URL** values get auto populated in **Basic SAML Configuration** section.

	> [!Note]
	> You will get the **Service Provider metadata file** from the **Configure Brocade SANnav Global View SSO** section, which is explained later in the tutorial. If the **Identifier** and **Reply URL** values do not get auto populated, then fill in the values manually according to your requirement.

1. Brocade SANnav Global View application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows user attributes and claims with default values.](common/default-attributes.png "Claims")

1. In addition, Brocade SANnav Global View application expects a few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ---------------|  --------- |
	| username | user.displayname |
	| groups | user.groups |

	> [!Note]
	> Please refer [this](~/identity/hybrid/connect/how-to-connect-fed-group-claims.md#add-group-claims-to-tokens-for-saml-applications-using-sso-configuration) link on how to add the groups attribute in the Attributes & Claims section.
	
1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

<a name='create-a-microsoft-entra-id-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user in the Microsoft Entra admin center called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

### Create SANnav Group and assign the user to the group

In this section, you'll enable B.Simon to use Microsoft Entra single sign-on by granting access to Brocade SANnav Global View.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Brocade SANnav Global View**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Brocade SANnav Global View SSO

1. Log in to your Brocade SANnav Global View company site as an administrator.

1. Go to **SANnav** tab and perform the following steps in the SANnav Authentication and Authorization page:

	![Screenshot shows settings of Identity Provider configuration.](./media/brocade-sannav-global-view-tutorial/settings.png "Account")

	1. Select Primary Authentication as **SAML**.

	1. Click **Import** to upload the downloaded **Federation Metadata XML** file from Microsoft Entra admin center.

	1. Click **Enable**.

1. Navigate to **SAML Service Provider (SP)** and click **Download the Service Provider Metadata XML** file and upload it in the **Basic SAML Configuration** section in Microsoft Entra admin center.

	![Screenshot shows settings of Service Provider Metadata.](./media/brocade-sannav-global-view-tutorial/values.png "Provider")

### Create Brocade SANnav Global View groups

In this section, you create a group called "SANnav_Group" in the Brocade SANnav Global View as shown in the below screenshot.

![Screenshot shows how to create groups in brocade.](./media/brocade-sannav-global-view-tutorial/groups.png "Screen")

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Click on **Test this application** in Microsoft Entra admin center. This will redirect to Brocade SANnav Global View Sign-on URL where you can initiate the login flow.  

* Go to Brocade SANnav Global View Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Click on **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the Brocade SANnav Global View for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you click the Brocade SANnav Global View tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Brocade SANnav Global View for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next Steps

Once you configure Brocade SANnav Global View you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
