---
title: Configure Predictix Price Reporting for Single sign-on with Microsoft Entra ID
description: In this article,  you learn how to configure single sign-on between Microsoft Entra ID and Predictix Price Reporting.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Predictix Price Reporting so that I can control who has access to Predictix Price Reporting, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Predictix Price Reporting for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Predictix Price Reporting with Microsoft Entra ID. When you integrate Predictix Price Reporting with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Predictix Price Reporting.
* Enable your users to be automatically signed-in to Predictix Price Reporting with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Predictix Price Reporting single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Predictix Price Reporting supports SP-initiated SSO.

## Add Predictix Price Reporting from the gallery

To configure the integration of Predictix Price Reporting into Microsoft Entra ID, you need to add Predictix Price Reporting from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Predictix Price Reporting** in the search box.
1. Select **Predictix Price Reporting** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-predictix-price-reporting'></a>

## Configure and test Microsoft Entra SSO for Predictix Price Reporting

Configure and test Microsoft Entra SSO with Predictix Price Reporting using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Predictix Price Reporting.

To configure and test Microsoft Entra SSO with Predictix Price Reporting, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Predictix Price Reporting SSO](#configure-predictix-price-reporting-sso)** - to configure the single sign-on settings on application side.
   1. **[Create a Predictix Price Reporting test user](#create-a-predictix-price-reporting-test-user)** - to have a counterpart of B.Simon in Predictix Price Reporting that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Predictix Price Reporting** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

4. In the **Basic SAML Configuration** dialog box, perform the following steps:

    a. In the **Identifier (Entity ID)** box, type a URL using one of the following patterns:
    
    | **Identifier** |
    |-------|
    | `https://<companyname-pricing>.predictix.com` |
    | `https://<companyname-pricing>.dev.predictix.com` |

	b. In the **Sign on URL** box, type a URL using the following pattern:
     `https://<companyname-pricing>.predictix.com/sso/request`

	> [!NOTE]
	> These values are placeholders. Update these values with the actual Identifier and Sign on URL. Contact the [Predictix Price Reporting support team](https://www.infor.com/customer-center) to get the values. You can also refer to the patterns shown in the **Basic SAML Configuration** dialog box.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select the **Download** link next to **Certificate (Base64)**, per your requirements, and save the certificate on your computer:

	![Certificate download link](common/certificatebase64.png)

6. In the **Set up Predictix Price Reporting** section, copy the appropriate URLs, based on your requirements.

	![Copy the configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Predictix Price Reporting SSO

To configure single sign-on on the Predictix Price Reporting side, you need to send the certificate that you downloaded and the URLs that you copied to the [Predictix Price Reporting support team](https://www.infor.com/customer-center). This team ensures the SAML SSO connection is set properly on both sides.

### Create a Predictix Price Reporting test user

Next, you need to create a user named Britta Simon in Predictix Price Reporting. Work with the [Predictix Price Reporting support team](https://www.infor.com/customer-center) to add users. Users need to be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Predictix Price Reporting Sign-on URL where you can initiate the login flow. 

* Go to Predictix Price Reporting Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Predictix Price Reporting tile in the My Apps, this option redirects to Predictix Price Reporting Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Predictix Price Reporting you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
