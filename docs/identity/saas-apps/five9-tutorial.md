---
title: Configure Five9 Plus Adapter (CTI, Contact Center Agents) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Five9 Plus Adapter (CTI, Contact Center Agents).

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Five9 Plus Adapter (CTI, Contact Center Agents) so that I can control who has access to Five9 Plus Adapter (CTI, Contact Center Agents), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Five9 Plus Adapter (CTI, Contact Center Agents) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Five9 Plus Adapter (CTI, Contact Center Agents) with Microsoft Entra ID. When you integrate Five9 Plus Adapter (CTI, Contact Center Agents) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Five9 Plus Adapter (CTI, Contact Center Agents).
* Enable your users to be automatically signed-in to Five9 Plus Adapter (CTI, Contact Center Agents) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Five9 Plus Adapter (CTI, Contact Center Agents) single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Five9 Plus Adapter (CTI, Contact Center Agents) supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Five9 Plus Adapter (CTI, Contact Center Agents) from the gallery

To configure the integration of Five9 Plus Adapter (CTI, Contact Center Agents) into Microsoft Entra ID, you need to add Five9 Plus Adapter (CTI, Contact Center Agents) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Five9 Plus Adapter (CTI, Contact Center Agents)** in the search box.
1. Select **Five9 Plus Adapter (CTI, Contact Center Agents)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-five9-plus-adapter-cti-contact-center-agents'></a>

## Configure and test Microsoft Entra SSO for Five9 Plus Adapter (CTI, Contact Center Agents)

Configure and test Microsoft Entra SSO with Five9 Plus Adapter (CTI, Contact Center Agents) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Five9 Plus Adapter (CTI, Contact Center Agents).

To configure and test Microsoft Entra SSO with Five9 Plus Adapter (CTI, Contact Center Agents), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Five9 Plus Adapter (CTI, Contact Center Agents) SSO](#configure-five9-plus-adapter-cti-contact-center-agents-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Five9 Plus Adapter (CTI, Contact Center Agents) test user](#create-five9-plus-adapter-cti-contact-center-agents-test-user)** - to have a counterpart of B.Simon in Five9 Plus Adapter (CTI, Contact Center Agents) that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Five9 Plus Adapter (CTI, Contact Center Agents)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up Single Sign-On with SAML** page, perform the following steps:

    a. In the **Identifier** text box, type one of the following URLs:
    
	|    Environment      |       URL      |
	| :-- | :-- |
	| For “Five9 Plus Adapter for Microsoft Dynamics CRM” | `https://app.five9.com/appsvcs/saml/metadata/alias/msdc` |
	| For “Five9 Plus Adapter for Zendesk” | `https://app.five9.com/appsvcs/saml/metadata/alias/zd` |
	| For “Five9 Plus Adapter for Agent Desktop Toolkit” | `https://app.five9.com/appsvcs/saml/metadata/alias/adt` |

    b. In the **Reply URL** text box, type one of the following URLs:

    |      Environment     |      URL      |
	| :--                  | :--           |
	| For “Five9 Plus Adapter for Microsoft Dynamics CRM” | `https://app.five9.com/appsvcs/saml/SSO/alias/msdc` |
	| For “Five9 Plus Adapter for Zendesk” | `https://app.five9.com/appsvcs/saml/SSO/alias/zd` |
	| For “Five9 Plus Adapter for Agent Desktop Toolkit” | `https://app.five9.com/appsvcs/saml/SSO/alias/adt` |

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

7. On the **Set up Five9 Plus Adapter (CTI, Contact Center Agents)** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Five9 Plus Adapter (CTI, Contact Center Agents) SSO

1. To configure single sign-on on **Five9 Plus Adapter (CTI, Contact Center Agents)** side, you need to send the downloaded **Certificate(Base64)** and appropriate copied URL(s) to [Five9 Plus Adapter (CTI, Contact Center Agents) support team](https://www.five9.com/about/contact). Also additionally, for configuring SSO further please follow the below steps according to the adapter:

	a. “Five9 Plus Adapter for Agent Desktop Toolkit” Admin Guide: [https://webapps.five9.com/assets/files/for_customers/documentation/integrations/agent-desktop-toolkit/plus-agent-desktop-toolkit-administrators-guide.pdf](https://webapps.five9.com/assets/files/for_customers/documentation/integrations/agent-desktop-toolkit/plus-agent-desktop-toolkit-administrators-guide.pdf)
	
	b. “Five9 Plus Adapter for Microsoft Dynamics CRM” Admin Guide: [https://manualzz.com/download/25793001](https://manualzz.com/download/25793001)
	
	c. “Five9 Plus Adapter for Zendesk” Admin Guide: [https://webapps.five9.com/assets/files/for_customers/documentation/integrations/zendesk/zendesk-plus-administrators-guide.pdf](https://webapps.five9.com/assets/files/for_customers/documentation/integrations/zendesk/zendesk-plus-administrators-guide.pdf)

### Create Five9 Plus Adapter (CTI, Contact Center Agents) test user

In this section, you create a user called Britta Simon in Five9 Plus Adapter (CTI, Contact Center Agents). Work with [Five9 Plus Adapter (CTI, Contact Center Agents) support team](https://www.five9.com/about/contact) to add the users in the Five9 Plus Adapter (CTI, Contact Center Agents) platform. Users must be created and activated before you use single sign-on. 

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Five9 Plus Adapter (CTI, Contact Center Agents) for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Five9 Plus Adapter (CTI, Contact Center Agents) tile in the My Apps, you should be automatically signed in to the Five9 Plus Adapter (CTI, Contact Center Agents) for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Five9 Plus Adapter (CTI, Contact Center Agents) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
