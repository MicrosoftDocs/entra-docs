---
title: Configure Axiad Conductor for Entra ID for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Axiad Conductor for Entra ID.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Axiad Conductor for Entra ID so that I can control who has access to Axiad Conductor for Entra ID, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Axiad Conductor for Entra ID for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Axiad Conductor for Entra ID with Microsoft Entra ID. When you integrate Axiad Conductor for Entra ID with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Axiad Conductor for Entra ID.
* Enable your users to be automatically signed-in to Axiad Conductor for Entra ID with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Axiad Conductor for Entra ID single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Axiad Conductor for Entra ID supports **SP** and **IDP** initiated SSO.
* Axiad Conductor for Entra ID supports [Automated user provisioning](axiad-cloud-provisioning-tutorial.md).

## Add Axiad Conductor for Entra ID from the gallery

To configure the integration of Axiad Conductor for Entra ID into Microsoft Entra ID, you need to add Axiad Conductor for Entra ID from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Axiad Conductor for Entra ID** in the search box.
1. Select **Axiad Conductor for Entra ID** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-axiad-cloud'></a>

## Configure and test Microsoft Entra SSO for Axiad Conductor for Entra ID

Configure and test Microsoft Entra SSO with Axiad Conductor for Entra ID using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Axiad Conductor for Entra ID.

To configure and test Microsoft Entra SSO with Axiad Conductor for Entra ID, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Axiad Conductor for Entra ID SSO](#configure-axiad-conductor-for-entra-id-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Axiad Conductor for Entra ID test user](#create-axiad-conductor-for-entra-id-test-user)** - to have a counterpart of B.Simon in Axiad Conductor for Entra ID that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Axiad Conductor for Entra ID** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps: 

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://access-<tenantName>.<platform>.axiadids.net/auth/realms/master`

    b. In the **Reply URL** textbox, type one of the following URLs:

    | Reply URL |
    |----|
    | `https://access-user-<tenantName>.<platform>.axiadids.net/auth/realms/master/broker/saml/endpoint` |
    | `https://access-<tenantName>.<platform>.axiadids.net/auth/realms/master/broker/saml/endpoint` |

    c. In the **Sign on URL** text box, type one of the following URLs:  

    | Sign on URL |
    |----|
    | `https://portal-<tenantName>.<platform>.axiadids.net/user` |
    | `https://portal-<tenantName>.<platform>.axiadids.net/operator` |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Axiad Conductor for Entra ID support team](mailto:support@axiad.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Axiad Conductor for Entra ID** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Axiad Conductor for Entra ID SSO

To configure single sign-on on **Axiad Conductor for Entra ID** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Axiad Conductor for Entra ID support team](mailto:support@axiad.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Axiad Conductor for Entra ID test user

In this section, you create a user called Britta Simon in Axiad Conductor for Entra ID. Work with [Axiad Conductor for Entra ID support team](mailto:support@axiad.com) to add the users in the Axiad Conductor for Entra ID platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Axiad Conductor for Entra ID Sign-on URL where you can initiate the login flow. 

* Go to Axiad Conductor for Entra ID Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Axiad Conductor for Entra ID tile in the My Apps, this option redirects to Axiad Conductor for Entra ID Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Axiad Conductor for Entra ID you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
