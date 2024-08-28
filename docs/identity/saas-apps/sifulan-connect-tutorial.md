---
title: Microsoft Entra SSO integration with SIFULAN Connect
description: Learn how to configure single sign-on between Microsoft Entra ID and SIFULAN Connect.
services: active-directory
author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 08/14/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with SIFULAN Connect

In this tutorial, you'll learn how to integrate SIFULAN Connect with Microsoft Entra ID. When you integrate SIFULAN Connect with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SIFULAN Connect.
* Enable your users to be automatically signed-in to SIFULAN Connect with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To integrate Microsoft Entra ID with SIFULAN Connect, you need:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* SIFULAN Connect single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* SIFULAN Connect supports **SP** initiated SSO.

## Add SIFULAN Connect from the gallery

To configure the integration of SIFULAN Connect into Microsoft Entra ID, you need to add SIFULAN Connect from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **SIFULAN Connect** in the search box.
1. Select **SIFULAN Connect** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for SIFULAN Connect

Configure and test Microsoft Entra SSO with SIFULAN Connect using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SIFULAN Connect.

To configure and test Microsoft Entra SSO with SIFULAN Connect, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra ID test user](#create-a-microsoft-entra-id-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra ID test user](#assign-the-microsoft-entra-id-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SIFULAN Connect SSO](#configure-sifulan-connect-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SIFULAN Connect test user](#create-sifulan-connect-test-user)** - to have a counterpart of B.Simon in SIFULAN Connect that is linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **SIFULAN Connect** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<Sub-DomainName>/idp/shibboleth`

    b. In the **Reply URL** text box, type the URL:
    `https://<Sub-DomainName>/idp/shibboleth`
    
    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<Sub-DomainName>/idp/profile/SAML2/POST/SSO`

	> [!NOTE]
	> These values are not real. Update these values with the actual Identifier and Sign on URL. Contact [SIFULAN Connect support team](mailto:support@sifulan.my) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. SIFULAN Connect application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes.](common/default-attributes.png "Image")

1. In addition to above, SIFULAN Connect application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ---------------| -------------- |
	| groups | user.groups |
	| urn:oid:2.16.840.1.113730.3.1.3 |  user.employeeid |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up SIFULAN Connect** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows copy configuration URLs.](common/copy-configuration-urls.png "Configuration")

### Create a Microsoft Entra ID test user

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

### Assign the Microsoft Entra ID test user

In this section, you'll enable B.Simon to use Microsoft Entra single sign-on by granting access to SIFULAN Connect.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **SIFULAN Connect**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure SIFULAN Connect SSO

To configure single sign-on on **SIFULAN Connect** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [SIFULAN Connect support team](mailto:support@sifulan.my). They set this setting to have the SAML SSO connection set properly on both sides.

### Create SIFULAN Connect test user

In this section, you create a user called B.Simon in SIFULAN Connect. Work with [SIFULAN Connect support team](mailto:support@sifulan.my) to add the users in the SIFULAN Connect platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the My Apps.

#### SP initiated:

* Click on **Test this application** in Microsoft Entra admin center. This will redirect to SIFULAN Connect Sign on URL where you can initiate the login flow.  
* Go to SIFULAN Connect Sign-on URL directly and initiate the login flow from there.

## Next steps

Once you configure SIFULAN Connect you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
