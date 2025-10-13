---
title: Configure Shmoop For Schools for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Shmoop For Schools.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Shmoop For Schools so that I can control who has access to Shmoop For Schools, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Shmoop For Schools for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Shmoop For Schools with Microsoft Entra ID. When you integrate Shmoop For Schools with Microsoft Entra ID, you can:

- Control in Microsoft Entra ID who has access to Shmoop For Schools.
- Enable your users to be automatically signed-in to Shmoop For Schools with their Microsoft Entra accounts.
- Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
- Shmoop For Schools single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

- Shmoop For Schools supports **SP** initiated SSO
- Shmoop For Schools supports **Just In Time** user provisioning

## Adding Shmoop For Schools from the gallery

To configure the integration of Shmoop For Schools into Microsoft Entra ID, you need to add Shmoop For Schools from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Shmoop For Schools** in the search box.
1. Select **Shmoop For Schools** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-shmoop-for-schools'></a>

## Configure and test Microsoft Entra SSO for Shmoop For Schools

Configure and test Microsoft Entra SSO with Shmoop For Schools using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Shmoop For Schools.

To configure and test Microsoft Entra SSO with Shmoop For Schools, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
2. **[Configure Shmoop For Schools SSO](#configure-shmoop-for-schools-sso)** - to configure the Single Sign-On settings on application side.
   1. **[Create Shmoop For Schools test user](#create-shmoop-for-schools-test-user)** - to have a counterpart of B.Simon in Shmoop For Schools that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Shmoop For Schools** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

   a. In the **Sign on URL** text box, type a URL using the following pattern:
   `https://schools.shmoop.com/public-api/saml2/start/<uniqueid>`

   b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
   `https://schools.shmoop.com/<uniqueid>`

   > [!NOTE]
   > These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Shmoop For Schools Client support team](mailto:support@shmoop.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Shmoop For Schools application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

   ![image](common/default-attributes.png)

1. In addition to above, Shmoop For Schools application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

   | Name | Source Attribute   |
   | ---- | ------------------ |
   | role | user.assignedroles |

   > [!NOTE]
   > Shmoop for School supports two roles for users: **Teacher** and **Student**. Set up these roles in Microsoft Entra ID so that users can be assigned the appropriate roles. To understand how to configure roles in Microsoft Entra ID, see [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui).

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

   ![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Shmoop For Schools SSO

To configure single sign-on on **Shmoop For Schools** side, you need to send the **App Federation Metadata Url** to [Shmoop For Schools support team](mailto:support@shmoop.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Shmoop For Schools test user

In this section, a user called B.Simon is created in Shmoop For Schools. Shmoop For Schools supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Shmoop For Schools, a new one is created after authentication.

> [!NOTE]
> If you need to create a user manually, contact the [Shmoop For Schools support team](mailto:support@shmoop.com).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

- Select **Test this application**, this option redirects to Shmoop For Schools Sign-on URL where you can initiate the login flow.

- Go to Shmoop For Schools Sign-on URL directly and initiate the login flow from there.

- You can use Microsoft My Apps. When you select the Shmoop For Schools tile in the My Apps, this option redirects to Shmoop For Schools Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Shmoop For Schools you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
