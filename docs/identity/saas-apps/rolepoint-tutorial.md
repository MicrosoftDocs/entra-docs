---
title: Configure RolePoint for Single sign-on with Microsoft Entra ID
description: In this article,  you learn how to configure single sign-on between Microsoft Entra ID and RolePoint.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and RolePoint so that I can control who has access to RolePoint, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure RolePoint for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate RolePoint with Microsoft Entra ID. When you integrate RolePoint with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to RolePoint.
* Enable your users to be automatically signed-in to RolePoint with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A RolePoint subscription with single sign-on enabled.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* RolePoint supports SP-initiated SSO.

## Add RolePoint from the gallery

To configure the integration of RolePoint into Microsoft Entra ID, you need to add RolePoint from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **RolePoint** in the search box.
1. Select **RolePoint** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-rolepoint'></a>

## Configure and test Microsoft Entra SSO for RolePoint

Configure and test Microsoft Entra SSO with RolePoint using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in RolePoint.

To configure and test Microsoft Entra SSO with RolePoint, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure RolePoint SSO](#configure-rolepoint-sso)** - to configure the single sign-on settings on application side.
    1. **[Create RolePoint test user](#create-rolepoint-test-user)** - to have a counterpart of B.Simon in RolePoint that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **RolePoint** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

4. In the **Basic SAML Configuration** dialog box, perform the following steps:

    1. In the **Identifier (Entity ID)** box, type a URL using the following pattern:

       `https://app.rolepoint.com/<instancename>`

    1. In the **Sign on URL** box, type a URL using the following pattern:

       `https://<subdomain>.rolepoint.com/login`   

	> [!NOTE]
	> These values are placeholders. You need to use the actual Identifier and Sign on URL. We suggest that you use a unique string value in the identifier. Contact the [RolePoint support team](mailto:info@rolepoint.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** dialog box.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select the **Download** link next to **Federation Metadata XML**, per your requirements, and save the file on your computer.

	![Certificate download link](common/metadataxml.png)

6. In the **Set up RolePoint** section, copy the appropriate URLs, based on your requirements:

	![Copy the configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure RolePoint SSO

To set up single sign-on on the RolePoint side, you need to work with the [RolePoint support team](mailto:info@rolepoint.com). Send this team the Federation Metadata XML file and the URLs that you got. They'll configure RolePoint to ensure the SAML SSO connection is set properly on both sides.

### Create RolePoint test user

Next, you need to create a user named Britta Simon in RolePoint. Work with the [RolePoint support team](mailto:info@rolepoint.com) to add users to RolePoint. Users need to be created and activated before you can use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to RolePoint Sign-on URL where you can initiate the login flow. 

* Go to RolePoint Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the RolePoint tile in the My Apps, this option redirects to RolePoint Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure RolePoint you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
