---
title: Configure IBM Kenexa Survey Enterprise for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and IBM Kenexa Survey Enterprise.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and IBM Kenexa Survey Enterprise so that I can control who has access to IBM Kenexa Survey Enterprise, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure IBM Kenexa Survey Enterprise for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate IBM Kenexa Survey Enterprise with Microsoft Entra ID. When you integrate IBM Kenexa Survey Enterprise with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to IBM Kenexa Survey Enterprise.
* Enable your users to be automatically signed-in to IBM Kenexa Survey Enterprise with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* IBM Kenexa Survey Enterprise single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* IBM Kenexa Survey Enterprise supports **IDP** initiated SSO.

## Add IBM Kenexa Survey Enterprise from the gallery

To configure the integration of IBM Kenexa Survey Enterprise into Microsoft Entra ID, you need to add IBM Kenexa Survey Enterprise from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **IBM Kenexa Survey Enterprise** in the search box.
1. Select **IBM Kenexa Survey Enterprise** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-ibm-kenexa-survey-enterprise'></a>

## Configure and test Microsoft Entra SSO for IBM Kenexa Survey Enterprise

Configure and test Microsoft Entra SSO with IBM Kenexa Survey Enterprise using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in IBM Kenexa Survey Enterprise.

To configure and test Microsoft Entra SSO with IBM Kenexa Survey Enterprise, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure IBM Kenexa Survey Enterprise SSO](#configure-ibm-kenexa-survey-enterprise-sso)** - to configure the single sign-on settings on application side.
    1. **[Create IBM Kenexa Survey Enterprise test user](#create-ibm-kenexa-survey-enterprise-test-user)** - to have a counterpart of B.Simon in IBM Kenexa Survey Enterprise that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **IBM Kenexa Survey Enterprise** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up Single Sign-On with SAML** page, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://surveys.kenexa.com/<companycode>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://surveys.kenexa.com/<companycode>/tools/sso.asp`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [IBM Kenexa Survey Enterprise Client support team](https://www.ibm.com/support/home/?lnk=fcw) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

5. The IBM Kenexa Survey Enterprise application expects to receive the Security Assertions Markup Language (SAML) assertions in a specific format, which requires you to add custom attribute mappings to the configuration of your SAML token attributes. The value of the user-identifier claim in the response must match the SSO ID that's configured in the Kenexa system. To map the appropriate user identifier in your organization as SSO Internet Datagram Protocol (IDP), work with the [IBM Kenexa Survey Enterprise support team](https://www.ibm.com/support/home/?lnk=fcw).

	By default, Microsoft Entra ID sets the user identifier as the user principal name (UPN) value. You can change this value on the **User Attributes** tab, as shown in the following screenshot. The integration works only after you've completed the mapping correctly.

	![image](common/edit-attribute.png)

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

7. On the **Set up IBM Kenexa Survey Enterprise** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure IBM Kenexa Survey Enterprise SSO

To configure single sign-on on **IBM Kenexa Survey Enterprise** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [IBM Kenexa Survey Enterprise support team](https://www.ibm.com/support/home/?lnk=fcw). They set this setting to have the SAML SSO connection set properly on both sides.

### Create IBM Kenexa Survey Enterprise test user

In this section, you create a user called Britta Simon in IBM Kenexa Survey Enterprise.

To create users in the IBM Kenexa Survey Enterprise system and map the SSO ID for them, you can work with the [IBM Kenexa Survey Enterprise support team](https://www.ibm.com/support/home/?lnk=fcw). This SSO ID value should also be mapped to the user identifier value from Microsoft Entra ID. You can change this default setting on the **Attribute** tab.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the IBM Kenexa Survey Enterprise for which you set up the SSO.

* You can use Microsoft My Apps. When you select the IBM Kenexa Survey Enterprise tile in the My Apps, you should be automatically signed in to the IBM Kenexa Survey Enterprise for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure IBM Kenexa Survey Enterprise you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
