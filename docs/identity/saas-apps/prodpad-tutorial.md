---
title: Configure ProdPad for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ProdPad.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ProdPad so that I can control who has access to ProdPad, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ProdPad for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ProdPad with Microsoft Entra ID. When you integrate ProdPad with Microsoft Entra ID, you can:

- Control in Microsoft Entra ID who has access to ProdPad.
- Enable your users to be automatically signed-in to ProdPad with their Microsoft Entra accounts.
- Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
- ProdPad single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ProdPad supports **SP and IDP** initiated SSO.
* ProdPad supports **Just In Time** user provisioning.
* ProdPad supports [Automated user provisioning](prodpad-provisioning-tutorial.md).

## Adding ProdPad from the gallery

To configure the integration of ProdPad into Microsoft Entra ID, you need to add ProdPad from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ProdPad** in the search box.
1. Select **ProdPad** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-prodpad'></a>

## Configure and test Microsoft Entra SSO for ProdPad

Configure and test Microsoft Entra SSO with ProdPad using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ProdPad.

To configure and test Microsoft Entra SSO with ProdPad, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ProdPad SSO](#configure-prodpad-sso)** - to configure the single sign-on settings on application side.
   1. **[Create ProdPad test user](#create-prodpad-test-user)** - to have a counterpart of B.Simon in ProdPad that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ProdPad** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

   In the **Sign-on URL** text box, type the URL:
   `https://app.prodpad.com/login`

1. Select **Save**.

1. ProdPad application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

   ![image](common/default-attributes.png)

1. In addition to above, ProdPad application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

   | Name             | Source Attribute   |
   | ---------------- | ------------------ |
   | User.FirstName   | user.givenname     |
   | User.LastName    | user.surname       |
   | User.ProdpadRole | user.assignedroles |

   > [!NOTE]
   > ProdPad expects roles for users assigned to the application. Please set up these roles in Microsoft Entra ID so that users can be assigned the appropriate roles. To understand how to configure roles in Microsoft Entra ID, see [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui).

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

   ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up ProdPad** section, copy the appropriate URL(s) based on your requirement.

   ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ProdPad SSO

1. Go to Account Settings and select the Security tab.
1. Now select the SSO/SAML sub-tab.
1. Select the "Add authentication type" button and select Microsoft Entra from the dropdown.
1. Select the Next button on the Microsoft Entra modal.
1. Copy into the field labelled "IdP Entity ID/URL" in ProdPad, the URL from the field "Microsoft Entra Identifier" in Microsoft Entra.
1. Copy into the field "IdP SAML Single Sign-On URL" in ProdPad, the URL in the field "Login URL" in Microsoft Entra.
1. Copy into the field "Logout URL" in ProdPad, the URL in the field "Logout URL" in Microsoft Entra.
1. Paste the text of X.509 certificate (public key generated above) into the X.509 certificate field.

Now you must decide whether you want your users to login by IdP initiated login only or by IdP and SP initiated login. 

1. If you select IdP only, you users must login from the Microsoft Entra dashboard, rather than the ProdPad login page. 

   1. Select save. Your users can now use the ProdPad app link on their Microsoft Entra dashboard.

1. If you opt for IdP & SP initiated login
   1. you must set up the Domains that your users can login from, more about this [here](https://help.prodpad.com/article/704-domain-verification)
   1. Once set up and verified, select the domain from the Domains list.
   1. Hit save.

**Note: for a domain to appear as an option here it must be verified under the Domains tab.**

### Create ProdPad test user

In this section, a user called Britta Simon is created in ProdPad. ProdPad supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in ProdPad, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

#### SP initiated:

- Select **Test this application**, this option redirects to ProdPad Sign on URL where you can initiate the login flow.

- Go to ProdPad Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

- Select **Test this application**, and you should be automatically signed in to the ProdPad for which you set up the SSO

You can also use Microsoft Access Panel to test the application in any mode. When you select the ProdPad tile in the Access Panel, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the ProdPad for which you set up the SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure ProdPad you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
