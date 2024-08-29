---
title: 'Tutorial: Microsoft Entra integration with ICIMS'
description: Learn how to configure single sign-on between Microsoft Entra ID and ICIMS.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 08/29/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and the ICIMS Talent Cloud so that I can control who has access to ICIMS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with ICIMS

In this tutorial, you'll learn how to integrate ICIMS with Microsoft Entra ID. When you integrate ICIMS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ICIMS.
* Enable your users to be automatically signed-in to ICIMS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* An iCIMS ATS subscription.
* Access to submit support tickets at community.icims.com

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* ICIMS supports **SP** initiated SSO.

## Add ICIMS from the gallery

To configure the integration of ICIMS into Microsoft Entra ID, you need to use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)  Configure and test Microsoft Entra SSO with ICIMS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ICIMS.

To configure and test Microsoft Entra SSO with ICIMS, perform the following steps:

1. **[Configure Microsoft Entra Application Registration](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Add credentials to your Entra Application](#add-credentials-to-your-entra-application)** - to establish a client secret for the SSO integration.
    1. **[Create a Microsoft Entra test user](#create-a-microsoft-entra-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-microsoft-entra-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ICIMS SSO](#configure-icims-sso)** - to configure the single sign-on settings on application side.
    1. **[Determine how you want to map your users between Entra and iCIMS](#determine-how-you-want-to-map-your-users-between-entra-and-icims)** - to configure how to map user accounts between iCIMS and Entra.
    1. **[Submit a support ticket for your SSO integration](#submit-a-support-ticket-for-your-sso-integration)** - to provide iCIMS staff with the details needed to configure your SSO integration.
    1. **[Create ICIMS test user](#create-icims-test-user)** - to have a counterpart of B.Simon in ICIMS that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra Application Registration

Follow these steps to create a Microsoft Entra Application Registration for your iCIMS application.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
2. If you have access to multiple tenants, use the Settings icon in the top menu to switch to the tenant in which you want to register the application from the Directories + subscriptions menu.
3. Browse to **Identity** > **Applications** > **App registrations** and select **New registration**.
4. Enter a display Name for your application. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time and multiple app registrations can share the same name.
5. Specify who can use the application, sometimes called its sign-in audience as **Accounts in this organizational directory only**.
6. Specify a Redirect URI based on your ICIMS datacenter:

    a. US: https://login.icims.com/login/callback

	b. EU: https://login.icims.ca/login/callback

	c. CA: https://login.icims.eu/login/callback

> [!NOTE]  
> If you are not sure about which redirect URI to use, navigate to your iCIMS ATS domain without being logged in.  The domain is in the format `<customernickname>.icims.com`, for example notacustomer.icims.com. You will be redirected to a login page whose domain will match one of the options datacenter domains listed on step 6.

7. Make note of your application/client_id.

### Add credentials to your Entra Application

In this section, you'll add a client secret for your application.

1. In the Microsoft Entra admin center, in App registrations, select your application.
2. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
3. Add a description for your client secret.
4. Select an expiration for the secret or specify a custom lifetime.

    > [!NOTE]  
    > Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months.  Microsoft recommends that you set an expiration value of less than 12 months.
 
    > [!NOTE]  
    > You must contact iCIMS Technical Support at least 30 days in advance of expiration to provide a new secret and avoid a service interruption.
 
5. Record the Client secret and expiration date to provide to the iCIMS support team.

    > [!NOTE]  
    > If your organization does not want to configure a client secret, you can leverage an OpenID Connect integration and utilize front-channel authentication with the implicit grant flow.

### Add permissions to your Entra Application

In this section, you'll add a permission to your application to sign in users and read the signed-in users' profiles.

1. In the Microsoft Entra admin center, in App registrations, select your application.
2. From the Overview page of your client application, select **API permissions** > **Add a permission** > **Microsoft Graph**.
3. Select Delegated permissions.
4. Under Select permissions, select the following permissions:

 	a. Delegated Users > User.Read
    > [!NOTE]  
    > iCIMS recommends that you grant Admin Consent to User.Read to avoid prompting users to trust the Microsoft Entra ID Application.
  	
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

In this section, you'll enable B.Simon to use single sign-on by granting access to ICIMS.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **ICIMS**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. Assign the "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure ICIMS SSO

### Determine how you want to map your users between Entra and iCIMS

You must determine the  Match From and Match To settings to map your organization’s Entra user accounts to your iCIMS ATS users as desired. 
The Match From setting indicates which Microsoft Entra ID attribute to match against an ATS user account. The Match To setting indicates the ATS user attribute to match against.

#### Match From setting options:
1. **Subject / NameID**: An immutable identifier for the user, unique with respect to the Microsoft Entra ID application used to authenticate the user. If a single user signs into two different apps using two different client IDs, those apps will receive two different values for the subject claim.
2. **OID**: The immutable identifier for an object in the Microsoft identity system, in this case, a user account. This ID uniquely identifies the user across applications. Two different applications signing in the same user will receive the same value in the oid claim. The Microsoft Graphs will return this ID as the id property for a given user account.
3. **Email**: The email of the user. Emails are mutable and only need to match during the first login, at which point the account is bound with an ATS user.  This option is not recommended for mutable email addresses.

> [!NOTE]  
> iCIMS recommends that you verify the Microsoft Entra ID user’s email address before accessing iCIMS ATS via Corporate SSO. This prevents linking an account with an invalid email address.

#### Match To setting options:
1. **Login**: The ATS person record’s log in field, also known as the username.
2. **Email**: The ATS person record’s email field.
3. **ExternalID**: The ATS person record’s external ID field.

### Submit a support ticket for your SSO integration
 
In this section, you'll submit a support ticket to request iCIMS technical support set up your SSO integration.

1. Ask your iCIMS user admin to visit https://community.icims.com/login.
2. Click Support > Create a Case.
3. When submitting the ticket please provide the following details:
    - Provide the **application (client) id**.
    - Provide the **client secret**.
	- Provide the **Microsoft Microsoft Entra ID Domain**.
	- Provide the **IdP Domain(s)** - Typically, the domain of your organization’s corporate email addresses (e.g., corporate-domain.com is the domain of name@corporate-domain.com.).  Your organization can leverage multiple IdP domains.  The domain must be unique within the region (e.g, gmail.com is an invalid domain.)
    - Provide the **display name** for the integration. This is the name that displays for your organization’s employee users.
    - Provide your organization’s **logo URL** for the integration. It is displayed as a 20x20 pixel square.  
	- Disclose whether you are enforcing Two-step Verification or **Multi-Factor Authentication**. Answer yes or no.
	- Provide the user **Match From** and **Match To** settings you selected in the previous step.

### Create ICIMS test user

In this section, you'll enable B.Simon to use single sign-on by creating a record in ICIMS for that user.

1. Browser to your ATS application at `<customernickname>.icims.com`.
1. Login as a user admin.
1. Select Create > People > Employee.
1. Provided details for this employee including name, email. 
1. Once you've created the user based on your **MatchTo** setting fill out the appropriate field to match the data you expect to send via the **MatchFrom** setting.  For example, if your MatchFrom is **OID** and your MatchTo is **External ID**, then visit the Login tab and edit the externalID to be Simon B.'s OID.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

1. Once iCIMS support has setup the SSO integration they will provide a test url.
1. The url will be in the format, https://iam-federated-testing-bff.production.env.icims.tools/login/hs-#####-azure. The digits in the url are your unique icims ATS customer ID.

## Next steps

Once you configure ICIMS, you can enforce that specific user groups must use SSO. Feel free to ask for help at https://community.icims.com.