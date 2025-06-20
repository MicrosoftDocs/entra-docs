---
title: Configure Blink for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Blink.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Blink so that I can control who has access to Blink, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Blink for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Blink with Microsoft Entra ID. When you integrate Blink with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Blink.
* Enable your users to be automatically signed-in to Blink with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Blink single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Blink supports **SP** initiated SSO.
* Blink supports **Just In Time** user provisioning.
* Blink supports [Automated user provisioning](blink-provisioning-tutorial.md).

## Adding Blink from the gallery

To configure the integration of Blink into Microsoft Entra ID, you need to add Blink from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Blink** in the search box.
1. Select **Blink** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-blink'></a>

## Configure and test Microsoft Entra SSO for Blink

Configure and test Microsoft Entra SSO with Blink using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Blink.

To configure and test Microsoft Entra SSO with Blink, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Blink SSO](#configure-blink-sso)** - to configure the Single Sign-On settings on application side.
    1. **[Create Blink test user](#create-blink-test-user)** - to have a counterpart of B.Simon in Blink that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Blink** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    1. In the **Sign on URL** text box, type a URL using one of the following patterns:

    | Sign-on URL|
    |------------|
    | `https://app.joinblink.com` |
    | `https://<SUBDOMAIN>.joinblink.com` |

    2. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:

    `https://api.joinblink.com/saml/o-<TENANTID>`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Blink Client support team](https://help.joinblink.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Blink Meetings application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Select **Edit** icon to open User Attributes dialog.

    ![image](common/edit-attribute.png)

1. In addition to above, Blink Meetings application expects few more attributes to be passed back in SAML response. In the User Claims section on the User Attributes dialog, perform the following steps to add SAML token attribute as shown in the below table:

    | Name | Source Attribute|
    | ---------------|  --------- |
    |   first_name    | user.givenname |
    |   second_name    | user.surname |
    |   email       | user.mail |
    | | |

    1. Select **Add new claim** to open the **Manage user claims** dialog.

    1. In the **Name** textbox, type the attribute name shown for that row.

    1. Leave the **Namespace** blank.

    1. Select Source as **Attribute**.

    1. From the **Source attribute** list, type the attribute value shown for that row.

    1. Select **Save**.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up Blink** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Blink SSO

To configure single sign-on on **Blink** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Blink support team](https://help.joinblink.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Blink test user

In this section, a user called Britta Simon is created in Blink. Blink supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Blink, a new one is created after authentication.

Blink also supports automatic user provisioning, you can find more details [here](./blink-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, this option redirects to Blink Sign-on URL where you can initiate the login flow.

* Go to Blink Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Blink tile in the My Apps, this option redirects to Blink Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Blink you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
