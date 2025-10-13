---
title: Configure Smart360 for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Smart360.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Smart360 so that I can control who has access to Smart360, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Smart360 for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Smart360 with Microsoft Entra ID. When you integrate Smart360 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Smart360.
* Enable your users to be automatically signed-in to Smart360 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Smart360 single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Smart360 supports **SP** initiated SSO.
* Smart360 supports **Just In Time** user provisioning.

## Add Smart360 from the gallery

To configure the integration of Smart360 into Microsoft Entra ID, you need to add Smart360 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Smart360** in the search box.
1. Select **Smart360** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-smart360'></a>

## Configure and test Microsoft Entra SSO for Smart360

Configure and test Microsoft Entra SSO with Smart360 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Smart360.

To configure and test Microsoft Entra SSO with Smart360, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Smart360 SSO](#configure-smart360-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Smart360 test user](#create-smart360-test-user)** - to have a counterpart of B.Simon in Smart360 that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Smart360** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `urn:sso:<CustomerName>:smart360:primary`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<CustomerName>.smart360.biz/smart360/saml/SSO`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<CustomerName>.smart360.biz`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Smart360 Client support team](mailto:support@smart360.biz) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.
    
1. Your Smart360 application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Select **Edit** icon to open **User Attributes** dialog.

   ![Screenshot shows User Attributes with the Edit icon selected.](common/edit-attribute.png)

1. In addition to above, Smart360 application expects few more attributes to be passed back in SAML response. In the **User Claims** section on the **User Attributes** dialog, perform the following steps to add SAML token attribute as shown in the below table:

   | Name     | Source Attribute   |
   | -------- | ------------------ |
   | role | user.assignedroles |

   > [!NOTE]
   > Please select [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui) to know how to configure Role in Microsoft Entra ID.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Smart360 SSO

To configure single sign-on on **Smart360** side, you need to send the **App Federation Metadata Url** to [Smart360 support team](mailto:support@smart360.biz). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Smart360 test user

In this section, a user called Britta Simon is created in Smart360. Smart360 supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Smart360, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Smart360 Sign-on URL where you can initiate the login flow. 

* Go to Smart360 Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Smart360 tile in the My Apps, this option redirects to Smart360 Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Smart360 you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
