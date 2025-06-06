---
title: Configure SignalFx for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SignalFx.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SignalFx so that I can control who has access to SignalFx, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SignalFx for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SignalFx with Microsoft Entra ID. When you integrate SignalFx with Microsoft Entra ID, you can:

* Control from Microsoft Entra ID who has access to SignalFx.
* Enable your users to be automatically signed-in to SignalFx with their Microsoft Entra accounts.
* Manage your accounts in one location (the Azure portal).

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SignalFx single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SignalFx supports **IDP** initiated SSO.
* SignalFx supports **Just In Time** user provisioning.

## Step 1: Add the SignalFx application in Azure

Use these instructions to add the SignalFx application to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SignalFx** in the search box.
1. Select **SignalFx** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
1. Leave the Microsoft Entra admin center open, and then open a new browser tab.

## Step 2: Begin SignalFx SSO configuration

Use these instructions to begin the configuration process for the SignalFx SSO.

1. In the newly opened tab, access and log into the SignalFx UI. 
1. In the top menu, select **Integrations**. 
1. In the search field, enter and select **Microsoft Entra ID**.
1. Select **Create New Integration**.
1. In **Name**, enter an easily recognizable name that your users will understand.
1. Mark **Show on login page**.
    * This feature will display a customized button in the login page that your users can select on. 
    * The information you entered in **Name** appears on the button. As a result, enter a **Name** that your users will recognize. 
    * This option will only function if you use a custom subdomain for the SignalFx application, such as **yourcompanyname.signalfx.com**. To obtain a custom subdomain, contact SignalFx support. 
1. Copy the **Integration ID**. you need this information in a later step. 
1. Leave the SignalFx UI open. 

<a name='step-3-configure-azure-ad-sso'></a>

## Step 3: Configure Microsoft Entra SSO

Use these instructions to enable Microsoft Entra SSO.

1. Return to the Microsoft Entra admin center, and on the **SignalFx** application integration page, locate the **Manage** section, and then select **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, perform the following steps: 

    a. In **Identifier**, enter the following URL `https://api.<realm>.signalfx.com/v1/saml/metadata` and replace `<realm>` with your SignalFx realm, and `<integration ID>` with the Integration ID you copied earlier from the SignalFx UI. (except realm US0, the url should be `https://api.signalfx.com/v1/saml/metadata`). 

    b. In **Reply URL**, enter the following URL `https://api.<realm>.signalfx.com/v1/saml/acs/<integration ID>` and replace `<realm>` with your SignalFx realm, and `<integration ID>` with the **Integration ID** you copied earlier from the SignalFx UI. (except US0, the url should be `https://api.signalfx.com/v1/saml/acs/<integration ID>`)

1. SignalFx application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. 
    
1. Review and verify that the following claims map to the source attributes that are populated in the Active Directory. 

    | Name |  Source Attribute|
    | ------------------- | -------------------- |
    | User.FirstName  | user.givenname |
    | User.email  | user.mail |
    | PersonImmutableID       | user.userprincipalname    |
    | User.LastName       | user.surname    |

    > [!NOTE]
    > This process requires that your Active Directory is configured with at least one verified custom domain, and has access to the email accounts in this domain. If you're unsure or need assistance with this configuration, please contact SignalFx support.  

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)**, and then select **Download**. Download the certificate, and save it on your computer. Then, copy the **App Federation Metadata Url** value; you need this information in a later step in the SignalFx UI. 

    ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up SignalFx** section, copy the **Microsoft Entra Identifier** value. you need this information in a later step in the SignalFx UI. 

<a name='step-4-create-an-azure-ad-test-user'></a>

## Step 4: Create a Microsoft Entra test user

In this section, you create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='step-5-assign-the-azure-ad-test-user'></a>

## Step 5: Assign the Microsoft Entra test user

In this section, you enable B.Simon to use single sign-on by granting access to SignalFx.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SignalFx**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, select the **Assign** button.

## Step 6: Complete the SignalFx SSO configuration 

1. Open the previous tab, and return to the SignalFx UI to view the current Microsoft Entra integration page. 
1. Next to **Certificate (Base64)**, select **Upload File**, and then locate the **Base64 encoded certificate** file that you previously downloaded previously.
1. Next to **Microsoft Entra Identifier**, paste the **Microsoft Entra Identifier** value that you copied earlier. 
1. Next to **Federation Metadata URL**, paste the **App Federation Metadata Url** value that you copied earlier. 
1. Select **Save**.

## Step 7: Test SSO

Review the following information regarding how to test SSO, and expectations for logging into SignalFx for the first time. 

### Test logins

* To test the login, you should use a private / incognito window, or you can log out. If not, cookies for the user who configured the application will interfere and prevent a successful login with the test user.

* When a new test user logs in for the first time, Azure will force a password change. When this occurs, the SSO login process isn't completed; the test user is directed to the Azure portal. To troubleshoot, the test user should change their password, and navigate to the SignalFx login page or to the MyApps and try again.
    * When you select the SignalFx tile in the MyApps, you should be automatically logged into the SignalFx. 
        * For more information about the MyApps, see [Introduction to the MyApps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

* SignalFx application can be accessed from the MyApps or via a custom login page assigned to the organization. The test user should test the integration starting from either of these locations.
    * The test user can use the credentials created earlier in this process for **b.simon\@contoso.com**.

### First-time logins

* When a user logs into SignalFx from the SAML SSO for the first time, the user will receive a SignalFx email with a link. The user must select the link for authentication purposes. This email validation will only take place for first-time users. 

* SignalFx supports **Just In Time** user creation, which means that if a user doesn't exist in SignalFx, then the user's account is created upon first login attempt.

## Related content

Once you configure SignalFx you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
