---
title: Configure BenSelect for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and BenSelect.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and BenSelect so that I can control who has access to BenSelect, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure BenSelect for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate BenSelect with Microsoft Entra ID. When you integrate BenSelect with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to BenSelect.
* Enable your users to be automatically signed-in to BenSelect with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* BenSelect single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* BenSelect supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add BenSelect from the gallery

To configure the integration of BenSelect into Microsoft Entra ID, you need to add BenSelect from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **BenSelect** in the search box.
1. Select **BenSelect** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-benselect'></a>

## Configure and test Microsoft Entra SSO for BenSelect

Configure and test Microsoft Entra SSO with BenSelect using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in BenSelect.

To configure and test Microsoft Entra SSO with BenSelect, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure BenSelect SSO](#configure-benselect-sso)** - to configure the single sign-on settings on application side.
    1. **[Create BenSelect test user](#create-benselect-test-user)** - to have a counterpart of B.Simon in BenSelect that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **BenSelect** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://www.benselect.com/enroll/login.aspx?Path=<tenant name>`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Reply URL. Contact [BenSelect Client support team](mailto:support@selerix.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. BenSelect application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows User Attributes with default attributes such as givenname user.givenname and emailaddress user.mail.](common/edit-attribute.png)

1. Select the **Edit** icon to edit the **Name identifier value**.

	![Screenshot shows the User Attributes & Claims pane with the Edit icon called out.](media/benselect-tutorial/mail-prefix1.png)

1. On the **Manage user claims** section, perform the following steps:

	![Screenshot shows Manage user claims where you can enter the values described in this step.](media/benselect-tutorial/mail-prefix2.png)

	a. Select **Transformation** as a **Source**.

	b. In the **Transformation** dropdown list, select **ExtractMailPrefix()**.

	c. In the **Parameter 1** dropdown list, select **user.userprincipalname**.

	d. Select **Save**.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificateraw.png)

1. On the **Set up BenSelect** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure BenSelect SSO

To configure single sign-on on **BenSelect** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from the application configuration to [BenSelect support team](mailto:support@selerix.com). They set this setting to have the SAML SSO connection set properly on both sides.

> [!NOTE]
> You need to mention that this integration requires the SHA256 algorithm (SHA1 isn't supported) to set the SSO on the appropriate server like app2101, and so on.

### Create BenSelect test user

In this section, you create a user called Britta Simon in BenSelect. Work with [BenSelect support team](mailto:support@selerix.com) to add the users in the BenSelect platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the BenSelect for which you set up the SSO.

* You can use Microsoft My Apps. When you select the BenSelect tile in the My Apps, you should be automatically signed in to the BenSelect for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure BenSelect you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
