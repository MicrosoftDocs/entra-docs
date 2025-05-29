---
title: Configure InfinityQS ProFicient on Demand for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and InfinityQS ProFicient on Demand.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and InfinityQS ProFicient on Demand so that I can control who has access to InfinityQS ProFicient on Demand, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure InfinityQS ProFicient on Demand for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate InfinityQS ProFicient on Demand with Microsoft Entra ID. When you integrate InfinityQS ProFicient on Demand with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to InfinityQS ProFicient on Demand.
* Enable your users to be automatically signed-in to InfinityQS ProFicient on Demand with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* InfinityQS ProFicient on Demand single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* InfinityQS ProFicient on Demand supports **IDP** initiated SSO.

## Add InfinityQS ProFicient on Demand from the gallery

To configure the integration of InfinityQS ProFicient on Demand into Microsoft Entra ID, you need to add InfinityQS ProFicient on Demand from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **InfinityQS ProFicient on Demand** in the search box.
1. Select **InfinityQS ProFicient on Demand** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-infinityqs-proficient-on-demand'></a>

## Configure and test Microsoft Entra SSO for InfinityQS ProFicient on Demand

Configure and test Microsoft Entra SSO with InfinityQS ProFicient on Demand using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in InfinityQS ProFicient on Demand.

To configure and test Microsoft Entra SSO with InfinityQS ProFicient on Demand, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure InfinityQS ProFicient on Demand SSO](#configure-infinityqs-proficient-on-demand-sso)** - to configure the single sign-on settings on application side.
    1. **[Create InfinityQS ProFicient on Demand test user](#create-infinityqs-proficient-on-demand-test-user)** - to have a counterpart of B.Simon in InfinityQS ProFicient on Demand that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **InfinityQS ProFicient on Demand** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section the application is pre-configured in **IDP** initiated mode and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up InfinityQS ProFicient on Demand** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure InfinityQS ProFicient on Demand SSO

To configure single sign-on on **InfinityQS ProFicient on Demand** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [InfinityQS ProFicient on Demand support team](mailto:support@infinityqs.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create InfinityQS ProFicient on Demand test user

In this section, you create a user called Britta Simon in InfinityQS ProFicient on Demand. Work with [InfinityQS ProFicient on Demand support team](mailto:support@infinityqs.com) to add the users in the InfinityQS ProFicient on Demand platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the InfinityQS ProFicient on Demand for which you set up the SSO.

* You can use Microsoft My Apps. When you select the InfinityQS ProFicient on Demand tile in the My Apps, you should be automatically signed in to the InfinityQS ProFicient on Demand for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure InfinityQS ProFicient on Demand you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
