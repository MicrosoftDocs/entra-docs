---
title: Configure ArcGIS Online for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ArcGIS Online.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ArcGIS Online so that I can control who has access to ArcGIS Online, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure ArcGIS Online for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ArcGIS Online with Microsoft Entra ID. When you integrate ArcGIS Online with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ArcGIS Online.
* Enable your users to be automatically signed-in to ArcGIS Online with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ArcGIS Online single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* ArcGIS Online supports **SP** initiated SSO.

## Add ArcGIS Online from the gallery

To configure the integration of ArcGIS Online into Microsoft Entra ID, you need to add ArcGIS Online from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ArcGIS Online** in the search box.
1. Select **ArcGIS Online** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-arcgis-online'></a>

## Configure and test Microsoft Entra SSO for ArcGIS Online

Configure and test Microsoft Entra SSO with ArcGIS Online using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ArcGIS Online.

To configure and test Microsoft Entra SSO with ArcGIS Online, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ArcGIS Online SSO](#configure-arcgis-online-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ArcGIS Online test user](#create-arcgis-online-test-user)** - to have a counterpart of B.Simon in ArcGIS Online that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ArcGIS Online** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `<COMPANY_NAME>.maps.arcgis.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.maps.arcgis.com/sharing/rest/oauth2/saml/signin`

    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<COMPANY_NAME>.maps.arcgis.com`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [ArcGIS Online Client support team](https://support.esri.com/en/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. To automate the configuration within **ArcGIS Online**, you need to install **My Apps Secure Sign-in browser extension** by selecting **Install the extension**.

1. After adding extension to the browser, select **setup ArcGIS Online** directs you to the ArcGIS Online application. From there, provide the admin credentials to sign into ArcGIS Online. The browser extension automatically configures the application for you and automate steps in section **Configure ArcGIS Online Single Sign-On**.

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ArcGIS Online SSO

1. In a different web browser window, sign in to your ArcGIS Online company site as an administrator

2. Go to the **Organization** > **Settings**. 

3. In the left menu, select **Security** and select **New SAML login** in the Logins tab.

    ![Screenshot shows Security.](./media/arcgis-tutorial/security.png)

4. In the **Set SAML login** window, choose the configuration as **One identity provider** and select **Next**.

    ![Screenshot shows Enterprise Logins.](./media/arcgis-tutorial/identity-provider.png "Enterprise Logins")

5. On the **Specify properties** tab, perform the following steps:

    ![Screenshot shows Set Identity Provider.](./media/arcgis-tutorial/set-saml-login.png "Set Identity Provider")

    a. In the **Name** textbox, type your organization’s name.

    b. For **Metadata source for Enterprise Identity Provider**, select **File**.

    c. Select **Choose File** to upload the **Federation Metadata XML** file, which you have downloaded previously.

    d. Select **Save**.

### Create ArcGIS Online test user

In order to enable Microsoft Entra users to log into ArcGIS Online, they must be provisioned into ArcGIS Online.  
In the case of ArcGIS Online, provisioning is a manual task.

**To provision a user account, perform the following steps:**

1. Log in to your **ArcGIS** tenant.

2. Go to the **Organization** > **Members** and select **Invite members**.

3. Select **Add members without sending invitations** method, and then select **Next**.

    ![Screenshot shows Add Members Automatically.](./media/arcgis-tutorial/add-members.png "Add Members Automatically")

1. In the **Compile member list**, select **New member** and select **Next**.

4. Fill the required fields in the following page and select **Next**.

    ![Screenshot shows Add and review.](./media/arcgis-tutorial/review.png "Add and review")

5. In the next page, select the member you want to add and select **Next**. 

1. Set the required member properties in the next page and select **Next**.

1. In the **Confirm and complete** tab, select **Add members** .

    ![Screenshot shows Add member.](./media/arcgis-tutorial/add.png "Add member")

    > [!NOTE]
    > The Microsoft Entra account holder receives an email and follow a link to confirm their account before it becomes active.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ArcGIS Online Sign-on URL where you can initiate the login flow. 

* Go to ArcGIS Online Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ArcGIS Online tile in the My Apps, this option redirects to ArcGIS Online Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure ArcGIS Online you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
