---
title: Set up a test environment for your app
description: Learn how to set up a Microsoft Entra test environment so you can test your application integrated with Microsoft identity platform. Evaluate whether you need a separate tenant for testing or if you can use your production tenant.
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.date: 01/24/2025
ms.reviewer: 
ms.service: identity-platform

ms.topic: how-to
#Customer intent: As a developer, I want to set up a test environment so that I can test my app integrated with Microsoft identity platform.
---

# Set up your application's Microsoft Entra test environment

To help move your app through the development, test, and production lifecycle, set up a Microsoft Entra test environment. You can use your Microsoft Entra test environment during the early stages of app development and long-term as a permanent test environment.

<a name='dedicated-test-tenant-or-production-azure-ad-tenant'></a>

## Choose between a dedicated test tenant or production Microsoft Entra tenant

You need to decide whether to use a dedicated test tenant or your production tenant for testing.

Using a production tenant can simplify some testing aspects but requires proper isolation between test and production resources, especially for high-privilege scenarios.

Avoid using your production tenant if:

- Your app requires tenant-wide unique settings, such as app-only permissions needing admin consent.
- You can't risk unauthorized access to test resources by tenant members.
- Your production environment could be disrupted by configuration changes.
- You can't create users or test data in your production tenant.
- Your production tenant has policies requiring user interaction during authentication, like mandatory multifactor authentication. In such cases, you can't use automated sign-ins for integration testing.
- Your [service or throttling limits](../identity/users/directory-service-limits-restrictions.md) could be exceeded by adding nonproduction resources.

If these restrictions apply, set up a [test environment in a separate tenant](#set-up-a-test-environment-in-a-separate-tenant).

If not, you can set up a [test environment in your production tenant](#set-up-a-test-environment-in-your-production-tenant). Users with privileged roles in your production tenant (such as Cloud Application Administrator) can access its resources and change its configuration at any time. To prevent access to any test resources or configuration, put that data in a separate tenant.

## Set up a test environment in a separate tenant

Setting up a test environment in a separate tenant ensures that your production environment remains unaffected by changes or configurations made during testing. You need to set up a test tenant, populate it with users, and configure it with policies that match your production tenant.

### Get a test tenant

If you don't already have a dedicated test tenant, you can create one for free using the Microsoft 365 Developer Program or manually create one yourself.

### [Microsoft 365 Developer Program](#tab/microsoft-365-developer-program)

The recommended approach is to join the [Microsoft 365 Developer Program](/office/developer-program/microsoft-365-developer-program). This program is free and can have test user accounts and sample data packs automatically added to the tenant.

1. Open the [Microsoft 365 Developer Program](https://developer.microsoft.com/en-us/microsoft-365/dev-program) page and select **Join now**.
2. Sign in with a new Microsoft account or use an existing (work) account.
3. On the sign-up page select your region, enter a company name, and accept the terms and conditions of the program before you select **Next**.
4. Select on **Set Up Subscription**. Specify the region where you want to create your new tenant, create a username, domain, and enter a password. A new tenant is created and the first administrator of the tenant is added.
5. Enter the security information, which is needed to protect the administrator account of your new tenant. This sets up multifactor authentication for the account.

### [Create a tenant manually](#tab/create-tenant-manually)

You can [manually create a tenant](quickstart-create-new-tenant.md), which is empty upon creation and needs to be configured with test data.

---

### Populate your tenant with users


For convenience, you can invite yourself and other members of your development team to be guest users in the tenant. This creates separate guest objects in the test tenant, but means you only have to manage one set of credentials for your corporate account and your test account.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Invite external user** and invite your work account email address.
1. Repeat for other members of the development and/or testing team for your application.

You can also create test users in your test tenant. If you used one of the Microsoft 365 sample packs, you may already have some test users in your tenant. If not, you should be able to create some yourself as the tenant administrator.

1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Create new user** and create some new test users in your directory.

<a name='get-an-azure-ad-subscription-optional'></a>

### Get a Microsoft Entra subscription (optional)

If you want to fully test Microsoft Entra ID P1 or P2 features on your application, you need to sign up your tenant for a [Premium P1 or Premium P2 license](https://azure.microsoft.com/pricing/details/active-directory/).

If you signed up using the Microsoft 365 Developer program, your test tenant comes with Microsoft Entra ID P2 licenses. If not, you can still enable a one month [free trial of Microsoft Entra ID P1 or P2](https://azure.microsoft.com/trial/get-started-active-directory/).

### Create and configure an app registration

You need to create an app registration to use in your test environment. This should be a separate registration from your eventual production app registration, to maintain security isolation between your test environment and your production environment. How you configure your application depends on the type of app you're building. For more information, see [register an application](./quickstart-register-app.md).

### Populate your tenant with policies

If a single organization (often referred to as single tenant) will primarily use your app, and you have access to the production tenant, reduce the chances of unexpected errors in production by replicating the settings of your production tenant that can affect your app's behavior as much as possible. 

#### Conditional Access policies

Replicating Conditional Access policies ensures you don't encounter unexpected blocked access when moving to production and your application can appropriately handle the errors it's likely to receive.

Viewing your production tenant Conditional Access policies may need to be performed by a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).

1. Go to **Entra ID** > **Enterprise apps** > **Conditional Access**.
1. View the list of policies in your tenant, and select the first policy.
1. Navigate to **Cloud apps or actions**.
1. If the policy only applies to a select group of apps, then move on to the next policy. If not, then it will likely apply to your app as well when you move to production. You should copy the policy over to your test tenant.

In a new tab or browser session, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) to access your test tenant.

1. Browse to **Entra ID** > **Conditional Access**.
1. Select **Create new policy**
1. Copy the settings from the production tenant policy, identified through the previous steps.

#### Permission grant policies

Replicating permission grant policies ensures you don't encounter unexpected prompts for admin consent when moving to production.

Browse to **Entra ID** > **Enterprise apps** > **Consent and permissions** > **User consent** settings. Copy the settings there to your test tenant.

#### Token lifetime policies

Replicating token lifetime policies ensures tokens issued to your application don't expire unexpectedly in production.

Token lifetime policies can currently only be managed through PowerShell. Read about [configurable token lifetimes](configurable-token-lifetimes.md) to learn about identifying any token lifetime policies that apply to your whole production organization. Copy those policies to your test tenant.

## Set up a test environment in your production tenant

If you can safely constrain your test app in your production tenant, then you can configure your tenant for testing purposes.

### Create and configure an app registration

You need to create an app registration to use in your test environment. This should be a separate registration from your eventual production app registration, to maintain security isolation between your test environment and your production environment. How you configure your application depends on the type of app you're building. For more information, check out the [app registration steps for your app scenario](scenario-web-app-sign-user-app-registration.md) in the left navigation pane.

### Create some test users

You need to create some test users with associated test data to use while testing your scenarios. This step might need to be performed by an admin.

1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Create new user** and create some new test users in your directory.

### Add the test users to a group (optional)

For convenience, you can assign all these users to a group, which makes other assignment operations easier.

1. Browse to **Entra ID** > **Groups** > **All groups**.
1. Select **New group**.
1. Select either **Security** or **Microsoft 365** for group type.
1. Name your group.
1. Add the test users created in the previous step.

### Restrict your test application to specific users

You can restrict the users in your tenant that are allowed to use your test application to specific users or groups, through user assignment. When you [created an app through App registrations](#create-and-configure-an-app-registration), a representation of your app was created in **Enterprise applications** as well. Use the **Enterprise applications** settings to restrict who can use the application in your tenant.

> [!IMPORTANT]
> If your app is a [multitenant app](v2-supported-account-types.md), this operation doesn't restrict users in other tenants from signing into and using your app. It will only restrict users in the tenant that user assignment is configured in.

For detailed instructions on restricting an app to specific users in a tenant, go to [restricting your app to a set of users](howto-restrict-your-app-to-a-set-of-users.md).

## Next step

Learn about Microsoft Entra usage constraints and service limits you might hit [here](../identity/users/directory-service-limits-restrictions.md). General Azure subscription and service limits, quotas, and constraints can be found [here](/azure/azure-resource-manager/management/azure-subscription-service-limits).

For more detailed information about test environments, read [Securing Azure environments with Microsoft Entra ID](https://azure.microsoft.com/resources/securing-azure-environments-with-azure-active-directory/).
