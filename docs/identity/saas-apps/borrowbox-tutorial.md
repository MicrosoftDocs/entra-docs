---
title: Configure BorrowBox for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and BorrowBox.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and BorrowBox so that I can control who has access to BorrowBox, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure BorrowBox for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate BorrowBox with Microsoft Entra ID. When you integrate BorrowBox with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to BorrowBox.
* Enable your users to be automatically signed-in to BorrowBox with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* BorrowBox single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* BorrowBox supports **SP and IDP** initiated SSO.
* BorrowBox supports **Just In Time** user provisioning.

## Add BorrowBox from the gallery

To configure the integration of BorrowBox into Microsoft Entra ID, you need to add BorrowBox from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **BorrowBox** in the search box.
1. Select **BorrowBox** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-borrowbox'></a>

## Configure and test Microsoft Entra SSO for BorrowBox

Configure and test Microsoft Entra SSO with BorrowBox using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in BorrowBox.

To configure and test Microsoft Entra SSO with BorrowBox, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure BorrowBox SSO](#configure-borrowbox-sso)** - to configure the single sign-on settings on application side.
    1. **[Create BorrowBox test user](#create-borrowbox-test-user)** - to have a counterpart of B.Simon in BorrowBox that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **BorrowBox** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://fe.bolindadigital.com/wldcs_bol_fo/b2i/mainPage.html?b2bSite=<ID>`

    > [!NOTE]
    > The value isn't real. Update the value with the actual Sign-on URL. Contact [BorrowBox Client support team](mailto:borrowbox@bolinda.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your BorrowBox application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**. BorrowBox application expects **nameidentifier** to be mapped with **user.mail**, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

    ![image](common/edit-attribute.png)

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up BorrowBox** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure BorrowBox SSO

To configure single sign-on on **BorrowBox** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [BorrowBox support team](mailto:borrowbox@bolinda.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create BorrowBox test user

In this section, a user called Britta Simon is created in BorrowBox. BorrowBox supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in BorrowBox, a new one is created after authentication.

> [!Note]
> If you need to create a user manually, contact [BorrowBox support team](mailto:borrowbox@bolinda.com).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to BorrowBox Sign on URL where you can initiate the login flow.  

* Go to BorrowBox Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the BorrowBox for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the BorrowBox tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the BorrowBox for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure BorrowBox you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
