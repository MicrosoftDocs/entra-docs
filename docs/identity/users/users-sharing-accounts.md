---
title: Sharing accounts and credentials
description: Learn how to configure shared accounts in Microsoft Entra ID using password-based single sign-on so multiple users can securely access apps without sharing passwords directly.
ms.topic: how-to
ms.date: 03/18/2026
ms.reviewer: yukarppa
ms.custom: it-pro
ai-usage: ai-assisted

---
# Share accounts with Microsoft Entra ID

In Microsoft Entra ID, part of Microsoft Entra, sometimes organizations need to use a single username and password for multiple people, which often happens in the following cases:

* When accessing applications that require a unique sign in and password for each user, whether on-premises apps or consumer cloud services (for example, corporate social media accounts).
* When creating multi-user environments. You might have a single, local account that has elevated privileges and is used to do core setup, administration, and recovery activities. For example, an Application Administrator account for Microsoft 365 or the root account in Salesforce.

Traditionally, these accounts are shared by distributing the credentials (username and password) to the right individuals, or storing them in a shared location where multiple trusted agents can access them.

The traditional sharing model has several drawbacks:

* Enabling access to new applications requires you to distribute credentials to everyone that needs access.
* Each shared application might require its own unique set of shared credentials, requiring users to remember multiple sets of credentials. When users have to remember many credentials, the risk increases that they resort to risky practices (for example, writing down passwords).
* You can't tell who has access to an application.
* You can't tell who *accessed* an application.
* When you want to remove access to an application, you have to update the credentials and redistribute them to everyone that needs access to that application.

## Prerequisites

To configure shared accounts, you need the following resources and roles:

* An Enterprise Mobility Suite (EMS) or Microsoft Entra ID P1 or P2 license plan for each user who accesses shared accounts. For more information, see [Microsoft Entra plans and pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).
* A user account with at least the [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role to configure SSO and assign users. The [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role also works.
* At least the [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator) role to create security groups. If your tenant allows users to create security groups, this role isn't required.
* An application that supports password-based single sign-on (SSO).

<a name='azure-active-directory-account-sharing'></a>

## Microsoft Entra account sharing

Microsoft Entra ID provides a new approach to using shared accounts that eliminates these drawbacks.

The Microsoft Entra administrator configures which applications a user can access by using the Access Panel and choosing the type of single sign-on best suited for that application. One of those types, *password-based single sign-on*, lets Microsoft Entra ID act as a kind of "broker" during the sign-in process for that app.

Users sign in once with their organizational account. This account is the same one they regularly use to access their desktop or email. They can discover and access only those applications that they're assigned to. With shared accounts, this list of applications can include any number of shared credentials. The end-user doesn't need to remember or write down the various accounts they might be using.

Shared accounts increase oversight, improve usability, and enhance your security. Users with permissions to use the credentials don't see the shared password, but rather get permissions to use the password as part of an orchestrated authentication flow. Further, some password SSO applications give you the option of using Microsoft Entra ID to periodically rollover (update) passwords. The system uses large, complex passwords, which increase account security. The administrator can easily grant or revoke access to an application, knows who has access to the account, and who accessed it in the past.

Microsoft Entra ID supports shared accounts for any Enterprise Mobility Suite (EMS) or Microsoft Entra ID P1 or P2 license plan, across all types of password single sign-on applications. You can share accounts for any of thousands of preintegrated applications in the application gallery and can add your own password-authenticating application with [custom SSO apps](~/identity/enterprise-apps/what-is-single-sign-on.md).

Microsoft Entra features that enable account sharing include:

* [Password single sign-on](~/identity/enterprise-apps/plan-sso-deployment.md#single-sign-on-options)
* Password single sign-on agent
* [Group assignment](groups-self-service-management.md)
* Custom Password apps
* [Usage and insights reports](~/identity/monitoring-health/concept-usage-insights-report.md)
* End-user access portals
* [App proxy](/entra/identity/app-proxy)
* [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/azure-active-directory-apps)

## Configure a shared account

To set up a shared account using password-based SSO, complete the following steps.

### Step 1: Add the application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Select **New application**.
1. Search the gallery for the application you want to add, or select **Create your own application** if the app isn't listed. For more information, see [Add an enterprise application](~/identity/enterprise-apps/add-application-portal.md).

### Step 2: Configure password-based SSO

1. Select the application you added, then select **Single sign-on** in the left menu.
1. Select **Password-based** as the single sign-on mode.
1. Enter the URL for the sign-in page of the application.
1. Select **Save**.

Microsoft Entra ID parses the HTML of the sign-in page for username and password input fields. If the automatic parsing fails, you can manually configure the sign-in fields. For detailed instructions, see [Add password-based single sign-on to an application](~/identity/enterprise-apps/configure-password-single-sign-on-non-gallery-applications.md).

### Step 3: Create a security group

Create a security group for each set of users who share the same application credentials. Creating groups requires at least the [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator) role, unless your tenant allows users to create security groups.

1. Browse to **Entra ID** > **Groups** > **All groups**.
1. Select **New group**.
1. Set **Group type** to **Security**.
1. Provide a name that identifies the shared account and application (for example, "Marketing - Social Media Account").
1. Add the users who need access to the shared account as members.
1. Select **Create**.

For more information, see [Use a group to manage access to SaaS applications](groups-saasapps.md).

### Step 4: Assign the group and set shared credentials

1. Browse to **Entra ID** > **Enterprise apps** > **All applications** and select the application.
1. Select **Users and groups**, then select **Add user/group**.
1. Select the security group you created and complete the assignment.
1. Select **Users and groups** again, select the checkbox for the group's row, and then select **Update Credentials**.
1. Enter the shared username and password for the application. Microsoft Entra ID securely stores the credentials and provides them to group members during sign-in.

> [!TIP]
> After the application is deployed, individuals don't need the password of the shared account. Consider setting a long, complex password. Microsoft Entra ID stores the password and the users don't see it.

### Step 5: Configure password rotation (optional)

If the application supports it, configure automatic rollover of the password. Automatic password rotation provides another layer of security because not even the administrator who set up the shared account needs to know the password after the initial configuration.

## Access a shared account

After an administrator configures a shared account, end users access the application in the following way:

1. Navigate to the [My Apps portal](https://myapps.microsoft.com) and sign in with your organizational account.
1. Find and select the shared application tile. If you have the My Apps Secure Sign-in Extension installed, the application launches and Microsoft Entra ID automatically submits the shared credentials.

> [!NOTE]
> The My Apps browser extension is required for password-based SSO applications. Users are prompted to install the extension when they first launch a password-based SSO app. The extension is available for [Microsoft Edge](https://microsoftedge.microsoft.com/addons/detail/my-apps-secure-signin-ex/gaaceiggkkiffbfdpmfapegoiohkiipl) and [Google Chrome](https://chrome.google.com/webstore/detail/my-apps-secure-sign-in-ex/ggjhpefgjjfobnfoldnjipclpcfbgbhl). For mobile devices, use Microsoft Edge mobile and enable password-based SSO in **Settings** > **Privacy and Security** > **Microsoft Entra Password SSO**.

End users don't see or interact with the shared credentials directly. Microsoft Entra ID handles the credential submission as part of an orchestrated authentication flow.

## Security considerations

When using shared accounts, keep the following security practices in mind:

* **Credential visibility**: Users with permissions to use the shared credentials don't see the actual password. Microsoft Entra ID brokers the authentication on their behalf.
* **Multifactor authentication (MFA)**: You can require MFA for users who access shared accounts to provide another layer of protection. For more information, see [How Microsoft Entra multifactor authentication works](~/identity/authentication/concept-mfa-howitworks.md).
* **Access management**: Use [Microsoft Entra self-service group management](groups-self-service-management.md) to delegate the ability to manage who has access to the application. Group owners can add or remove members without administrator involvement.
* **Password complexity**: Set a long, complex password for the shared account since end users don't need to know or type the password.
* **Audit and monitoring**: Microsoft Entra ID logs sign-in activity, so administrators can see who accessed the application and when.

## Related content

* [Application management in Microsoft Entra ID](~/identity/enterprise-apps/what-is-application-management.md)
* [Add password-based single sign-on to an application](~/identity/enterprise-apps/configure-password-single-sign-on-non-gallery-applications.md)
* [Troubleshoot password-based single sign-on](~/identity/enterprise-apps/troubleshoot-password-based-sso.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md)
* [My Apps portal overview](~/identity/enterprise-apps/myapps-overview.md)
* [What is Conditional Access?](~/identity/conditional-access/overview.md)
* [Self-service group management](groups-self-service-management.md)
