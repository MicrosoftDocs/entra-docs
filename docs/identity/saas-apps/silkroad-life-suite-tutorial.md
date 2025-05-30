---
title: Configure SilkRoad Life Suite for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SilkRoad Life Suite.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SilkRoad Life Suite so that I can control who has access to SilkRoad Life Suite, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure SilkRoad Life Suite for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SilkRoad Life Suite with Microsoft Entra ID. When you integrate SilkRoad Life Suite with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SilkRoad Life Suite.
* Enable your users to be automatically signed-in to SilkRoad Life Suite with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SilkRoad Life Suite single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* SilkRoad Life Suite supports **SP** initiated SSO.

## Add SilkRoad Life Suite from the gallery

To configure the integration of SilkRoad Life Suite into Microsoft Entra ID, you need to add SilkRoad Life Suite from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SilkRoad Life Suite** in the search box.
1. Select **SilkRoad Life Suite** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-silkroad-life-suite'></a>

## Configure and test Microsoft Entra SSO for SilkRoad Life Suite

Configure and test Microsoft Entra SSO with SilkRoad Life Suite using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SilkRoad Life Suite.

To configure and test Microsoft Entra SSO with SilkRoad Life Suite, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SilkRoad Life Suite SSO](#configure-silkroad-life-suite-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SilkRoad Life Suite test user](#create-silkroad-life-suite-test-user)** - to have a counterpart of B.Simon in SilkRoad Life Suite that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SilkRoad Life Suite** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file**, perform the following steps:

    > [!NOTE]
    > You get the **Service Provider metadata file** explained later in this article.

	a. Select **Upload metadata file**.

    ![Screenshot shows Basic SAML Configuration with the Upload metadata file link.](common/upload-metadata.png)

	b. Select **folder logo** to select the metadata file and select **Upload**.

	![Screenshot shows a dialog box where you can select and upload a file.](common/browse-upload-metadata.png)

	c. Once the metadata file is successfully uploaded, the **Identifier** and **Reply URL** values get auto populated in Basic SAML Configuration section.

	> [!Note]
	> If the **Identifier** and **Reply URL** values aren't getting auto populated, then fill in the values manually according to your requirement.

    d. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.silkroad-eng.com/Authentication/`

5. On the **Basic SAML Configuration** section, if you don't have **Service Provider metadata file**, perform the following steps:

    a. In the **Identifier** box, type a URL using one of the following patterns:

    | Identifier URL |
    |-----|
    |`https://<SUBDOMAIN>.silkroad-eng.com/Authentication/SP`|
	|`https://<SUBDOMAIN>.silkroad.com/Authentication/SP`|
    

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | Reply URL |
    |-----|
	|`https://<SUBDOMAIN>.silkroad-eng.com/Authentication/`|
	|`https://<SUBDOMAIN>.silkroad.com/Authentication/`|

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.silkroad-eng.com/Authentication/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier,Reply URL and Sign-On URL. Contact [SilkRoad Life Suite Client support team](https://www.silkroad.com/locations/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

7. On the **Set up SilkRoad Life Suite** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SilkRoad Life Suite SSO

1. Sign in to your SilkRoad company site as administrator.

    > [!NOTE]
    > To obtain access to the SilkRoad Life Suite Authentication application for configuring federation with Microsoft Entra ID, please contact SilkRoad Support or your SilkRoad Services representative.

1. Go to **Service Provider**, and then select **Federation Details**.

    ![Screenshot shows Federation Details selected from Service Provider.](./media/silkroad-life-suite-tutorial/details.png)

1. Select **Download Federation Metadata**, and then save the metadata file on your computer. Use Downloaded Federation Metadata as a **Service Provider metadata file** in the **Basic SAML Configuration** section.

    ![Screenshot shows the Download Federation Metadata link.](./media/silkroad-life-suite-tutorial/metadata.png)

1. In your **SilkRoad** application, select **Authentication Sources**.

    ![Screenshot shows Authentication Sources selected.](./media/silkroad-life-suite-tutorial/sources.png) 

1. Select **Add Authentication Source**.

    ![Screenshot shows the Add Authentication Source link.](./media/silkroad-life-suite-tutorial/add-source.png)

1. In the **Add Authentication Source** section, perform the following steps:

    ![Screenshot shows Add Authentication Source with the Create Identity Provider using File Data button selected.](./media/silkroad-life-suite-tutorial/metadata-file.png)
  
    a. Under **Option 2 - Metadata File**, select **Browse** to upload the downloaded metadata file from Azure portal.
  
    b. Select **Create Identity Provider using File Data**.

1. In the **Authentication Sources** section, select **Edit**.

    ![Screenshot shows Authentication Sources with the Edit option selected.](./media/silkroad-life-suite-tutorial/edit-source.png)

1. On the **Edit Authentication Source** dialog, perform the following steps:

    ![Screenshot shows the Edit Authentication Source dialog box where you can enter the values described.](./media/silkroad-life-suite-tutorial/authentication.png)

    a. As **Enabled**, select **Yes**.

	b. In the **EntityId** textbox, paste the value of **Microsoft Entra Identifier**..

    c. In the **IdP Description** textbox, type a description for your configuration (for example: **Microsoft Entra SSO**).

	d. In the **Metadata File** textbox, Upload the **metadata** file which you have downloaded previously.
  
    e. In the **IdP Name** textbox, type a name that's specific to your configuration (for example: *Azure SP*).
  
	f. In the **Logout Service URL** textbox, paste the value of **Logout URL**..

	g. In the **Sign-on service URL** textbox, paste the value of **Login URL**..

    h. Select **Save**.

1. Disable all other authentication sources.

    ![Screenshot shows Authentication Sources where you can disable other sources.](./media/silkroad-life-suite-tutorial/manage-source.png)

### Create SilkRoad Life Suite test user

In this section, you create a user called Britta Simon in SilkRoad Life Suite. Work with [SilkRoad Life Suite Client support team](https://www.silkroad.com/locations/) to add the users in the SilkRoad Life Suite platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to SilkRoad Life Suite Sign-on URL where you can initiate the login flow. 

* Go to SilkRoad Life Suite Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the SilkRoad Life Suite tile in the My Apps, this option redirects to SilkRoad Life Suite Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure SilkRoad Life Suite you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
