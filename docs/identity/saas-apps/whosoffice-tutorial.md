---
title: Configure WhosOffice for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and WhosOffice.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and WhosOffice so that I can control who has access to WhosOffice, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure WhosOffice for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate WhosOffice with Microsoft Entra ID. When you integrate WhosOffice with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to WhosOffice.
* Enable your users to be automatically signed-in to WhosOffice with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* WhosOffice single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* WhosOffice supports **SP and IDP** initiated SSO

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding WhosOffice from the gallery

To configure the integration of WhosOffice into Microsoft Entra ID, you need to add WhosOffice from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **WhosOffice** in the search box.
1. Select **WhosOffice** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-whosoffice'></a>

## Configure and test Microsoft Entra SSO for WhosOffice

Configure and test Microsoft Entra SSO with WhosOffice using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in WhosOffice.

To configure and test Microsoft Entra SSO with WhosOffice, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure WhosOffice SSO](#configure-whosoffice-sso)** - to configure the single sign-on settings on application side.
    1. **[Create WhosOffice test user](#create-whosoffice-test-user)** - to have a counterpart of B.Simon in WhosOffice that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **WhosOffice** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.my.whosoffice.com/int/azure/consume.aspx`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.my.whosoffice.com/int/azure`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Reply URL and Sign-on URL. Contact [WhosOffice Client support team](mailto:support@whosoffice.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up WhosOffice** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure WhosOffice SSO




1. In a different web browser window, sign in to your WhosOffice company site as an administrator

1. Select **Settings** and select **Company**.

    ![Screenshot shows Company selected from Settings.](./media/whosoffice-tutorial/configuration1.png)

1. Select **Apps/Integrations**.

1. Select **Microsoft Azure** from the provider dropdown and select **Activate Login Provider**.

    ![Screenshot shows Activate Login Provider selected for Microsoft Azure.](./media/whosoffice-tutorial/configuration3.png)

1. Upload the downloaded federation metadata file from Azure portal by selecting the **Upload** option.
    
    ![Screenshot shows the Upload option for a Meta Data file.](./media/whosoffice-tutorial/configuration4.png)

### Create WhosOffice test user

1. In a different web browser window, sign into WhosOffice website as an administrator.

1. Select **Settings** and select **Users**.

    ![Screenshot shows Users selected from Settings.](./media/whosoffice-tutorial/user1.png)

1. Select **Create new User**.

    ![Screenshot shows Create new User selected.](./media/whosoffice-tutorial/user2.png)

1. Provide the necessary details of the user as per your organization requirement.

    ![Screenshot shows the new User dialog box where you can enter user data.](./media/whosoffice-tutorial/user3.png)

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

#### SP initiated:

* Select **Test this application**, this option redirects to WhosOffice Sign on URL where you can initiate the login flow.

* Go to WhosOffice Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the WhosOffice for which you set up the SSO

You can also use Microsoft My Apps to test the application in any mode. When you select the WhosOffice tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the WhosOffice for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure WhosOffice you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
