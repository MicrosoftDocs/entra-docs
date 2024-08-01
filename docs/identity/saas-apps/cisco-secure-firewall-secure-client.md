---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with Cisco Secure Firewall - Secure Client'
description: Learn how to configure single sign-on between Microsoft Entra ID and Cisco Secure Firewall - Secure Client.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 05/20/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cisco Secure Firewall - Secure Client so that I can control who has access to Cisco Secure Firewall - Secure Client, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with Cisco Secure Firewall - Secure Client

In this tutorial, you'll learn how to integrate Cisco Secure Firewall - Secure Client with Microsoft Entra ID. When you integrate Cisco Secure Firewall - Secure Client with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cisco Secure Firewall - Secure Client.
* Enable your users to be automatically signed-in to Cisco Secure Firewall - Secure Client with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Cisco Secure Firewall - Secure Client single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Cisco Secure Firewall - Secure Client supports only **IDP** initiated SSO.

## Adding Cisco Secure Firewall - Secure Client from the gallery

To configure the integration of Cisco Secure Firewall - Secure Client into Microsoft Entra ID, you need to add Cisco Secure Firewall - Secure Client from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Cisco Secure Firewall - Secure Client** in the search box.
1. Select **Cisco Secure Firewall - Secure Client** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-cisco-anyconnect'></a>

## Configure and test Microsoft Entra SSO for Cisco Secure Firewall - Secure Client

Configure and test Microsoft Entra SSO with Cisco Secure Firewall - Secure Client using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cisco Secure Firewall - Secure Client.

To configure and test Microsoft Entra SSO with Cisco Secure Firewall - Secure Client, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cisco Secure Firewall - Secure Client SSO](#configure-cisco-secure-firewall---secure-client-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cisco Secure Firewall - Secure Client test user](#create-cisco-secure-firewall---secure-client-test-user)** - to have a counterpart of B.Simon in Cisco Secure Firewall - Secure Client that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Cisco Secure Firewall - Secure Client** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, enter the values for the following fields:

   1. In the **Identifier** text box, type a URL using the following pattern:  
   `https://<SUBDOMAIN>.YourCiscoServer.com/saml/sp/metadata/<Tunnel_Group_Name>`

   1. In the **Reply URL** text box, type a URL using the following pattern:  
   `https://<YOUR_CISCO_ANYCONNECT_FQDN>/+CSCOE+/saml/sp/acs?tgname=<Tunnel_Group_Name>`

   > [!NOTE]
   > `<Tunnel_Group_Name>` is a case-sensitive and the value must not contain dots "." and slashes "/".

   > [!NOTE]
   > For clarification about these values, contact Cisco TAC support. Update these values with the actual Identifier and Reply URL provided by Cisco TAC. Contact the [Cisco Secure Firewall - Secure Client support team](https://www.cisco.com/c/en/us/support/index.html) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate file and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Cisco Secure Firewall - Secure Client** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

> [!NOTE]
> If you would like to on board multiple TGTs of the server then you need to add multiple instances of the Cisco Secure Firewall - Secure Client application from the gallery. You can also choose to upload your own certificate in Microsoft Entra ID for all these application instances. That way you can have same certificate for the applications but you can configure different Identifier and Reply URL for every application.

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to Cisco Secure Firewall - Secure Client.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Cisco Secure Firewall - Secure Client**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Cisco Secure Firewall - Secure Client SSO

1. You are going to do this on the CLI first, you might come back through and do an ASDM walk-through at another time.

1. Connect to your VPN Appliance, you are going to be using an ASA running 9.8 code train, and your VPN clients will be 4.6+.

1. First you will create a Trustpoint and import our SAML cert.

   ```
    config t

    crypto ca trustpoint AzureAD-AC-SAML
      revocation-check none
      no id-usage
      enrollment terminal
      no ca-check
    crypto ca authenticate AzureAD-AC-SAML
    -----BEGIN CERTIFICATE-----
    …
    PEM Certificate Text from download goes here
    …
    -----END CERTIFICATE-----
    quit
   ```

1. The following commands will provision your SAML IdP.

   ```
    webvpn
    saml idp https://sts.windows.net/xxxxxxxxxxxxx/ (This is your Azure AD Identifier from the Set up Cisco Secure Firewall - Secure Client section in the Azure portal)
    url sign-in https://login.microsoftonline.com/xxxxxxxxxxxxxxxxxxxxxx/saml2 (This is your Login URL from the Set up Cisco Secure Firewall - Secure Client section in the Azure portal)
    url sign-out https://login.microsoftonline.com/common/wsfederation?wa=wsignout1.0 (This is Logout URL from the Set up Cisco Secure Firewall - Secure Client section in the Azure portal)
    trustpoint idp AzureAD-AC-SAML
    trustpoint sp (Trustpoint for SAML Requests - you can use your existing external cert here)
    no force re-authentication
    no signature
    base-url https://my.asa.com
    ```

1. Now you can apply SAML Authentication to a VPN Tunnel Configuration.

   ```
   tunnel-group AC-SAML webvpn-attributes
      saml identity-provider https://sts.windows.net/xxxxxxxxxxxxx/
      authentication saml
   end

    write mem
   ```

   > [!NOTE]
   > There is a work around with the SAML IdP configuration. If you make changes to the IdP configuration you need to remove the saml identity-provider configuration from your Tunnel Group and re-apply it for the changes to become effective.

### Create Cisco Secure Firewall - Secure Client test user

In this section, you create a user called Britta Simon in Cisco Secure Firewall - Secure Client. Work with [Cisco Secure Firewall - Secure Client support team](https://www.cisco.com/c/en/us/support/index.html) to add the users in the Cisco Secure Firewall - Secure Client platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Click on **Test this application**, and you should be automatically signed in to the Cisco Secure Firewall - Secure Client for which you set up the SSO
* You can use Microsoft Access Panel. When you click the Cisco Secure Firewall - Secure Client tile in the Access Panel, you should be automatically signed in to the Cisco Secure Firewall - Secure Client for which you set up the SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Cisco Secure Firewall - Secure Client you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).