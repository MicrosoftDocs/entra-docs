---
title: Add multifactor authentication (MFA) to a customer app
description: Learn how to add multifactor authentication (MFA) to your consumer and business customer (CIAM) application. For example, add email one-time passcode as a second authentication factor to your CIAM sign-up and sign-in user flows.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: how-to
ms.date: 10/07/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to add multifactor authentication to my custoconsumer and business customer app.
---

# Add multifactor authentication (MFA) to an app

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[Multifactor authentication (MFA)](~/identity/authentication/concept-mfa-howitworks.md) adds a layer of security to your applications by requiring users to provide a second method for verifying their identity during sign-up or sign-in. External tenants support two methods for authentication as a second factor:

- **Email one-time passcode**: After the user signs in with their email and password, they are prompted for a passcode that is sent to their email. To allow the use of email one-time passcodes for MFA, set your local account authentication method to *Email with password*. If you choose *Email with one-time passcode*, customers who use this method for primary sign-in won't be able to use it for MFA secondary verification.
- **SMS-based authentication**: While SMS isn't an option for first factor authentication, it's available as a second factor for MFA. Users who sign in with email and password, email and one-time passcode, or social identities like Google or Facebook, are prompted for second verification using SMS. Our SMS MFA includes automatic fraud checks. If we suspect fraud, we'll ask the user to complete a CAPTCHA to confirm they're not a robot before sending the SMS code for verification. SMS is an add-on feature. Your tenant must be [linked](../external-identities-pricing.md#link-an-external-tenant-to-a-subscription) to an active, valid subscription. [Learn more](concept-multifactor-authentication-customers.md#sms-based-authentication)

This article describes how to enforce MFA for your customers by creating a Microsoft Entra Conditional Access policy and adding MFA to your sign-up and sign-in user flow.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=MFA)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “[Multi-factor authentication](https://woodgrovedemo.com/#usecase=MFA)” use case.

## Prerequisites

- A Microsoft Entra external tenant.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).
- An app that's registered in your external tenant and added to the sign-up and sign-in user flow.
- An account with at least the Security Administrator role to configure Conditional Access policies and MFA.
- SMS is an add-on feature and requires a [linked subscription](../external-identities-pricing.md#link-an-external-tenant-to-a-subscription). If your subscription expires or is cancelled, end users will no longer be able to authenticate using SMS, which could block them from signing in depending on your MFA policy.

## Create a Conditional Access policy

Create a Conditional Access policy in your external tenant that prompts users for MFA when they sign up or sign in to your app. (For more information, see [Common Conditional Access policy: Require MFA for all users](~/identity/conditional-access/policy-all-users-mfa-strength.md)).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator).

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.

1. Browse to **Protection** > **Conditional Access** > **Policies**, and then select **New policy**.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/new-policy.png" alt-text="Screenshot of the new policy button." lightbox="media/how-to-multifactor-authentication-customers/new-policy.png":::

1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.

1. Under **Assignments**, select the link under **Users**.

   a. On the **Include** tab, select **All users**.

   b. On the **Exclude** tab, select **Users and groups** and choose your organization's emergency access or break-glass accounts. Then choose **Select**.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/new-policy-users.png" alt-text="Screenshot of assigning users to the new policy." lightbox="media/how-to-multifactor-authentication-customers/new-policy-users.png":::

1. Select the link under **Target resources**.

   a. On the **Include** tab, choose one of the following options:

      - Choose **All resources (formerly 'All cloud apps')**.

      - Choose **Select resources** and select the link under **Select**. Find your app, select it, and then choose **Select**.

   b. On the **Exclude** tab, select any applications that don't require multifactor authentication.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/new-policy-apps.png" alt-text="Screenshot of assigning apps to the new policy." lightbox="media/how-to-multifactor-authentication-customers/new-policy-apps.png":::

1. Under **Access controls** select the link under **Grant**. Select **Grant access**, select **Require multifactor authentication**, and then choose **Select**.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/new-policy-grant-require-mfa.png" alt-text="Screenshot of requiring MFA." lightbox="media/how-to-multifactor-authentication-customers/new-policy-grant-require-mfa.png":::

1. Confirm your settings and set **Enable policy** to **On**.

1. Select **Create** to create to enable your policy.

## Enable email one-time passcode as an MFA method

Enable the email one-time passcode authentication method in your external tenant for all users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator).

1. Browse to **Protection** > **Authentication methods**.

1. In the **Method** list, select **Email OTP**.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/auth-methods-eotp.png" alt-text="Screenshot of the email one-time passcode option." lightbox="media/how-to-multifactor-authentication-customers/auth-methods-eotp.png":::

1. Under **Enable and Target**, turn the **Enable** toggle on.

1. Under **Include**, next to **Target**, select **All users**.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/enable-eotp.png" alt-text="Screenshot of enabling email one-time passcode." lightbox="media/how-to-multifactor-authentication-customers/enable-eotp.png":::

1. Select **Save**.

## Enable SMS as an MFA method

Enable the SMS authentication method in your external tenant for all users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator).

1. Browse to **Protection** > **Authentication methods**.

1. In the **Method** list, select **SMS**.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/auth-methods-sms.png" alt-text="Screenshot of the SMS option." lightbox="media/how-to-multifactor-authentication-customers/auth-methods-sms.png":::

1. Under **Enable and Target**, turn the **Enable** toggle on.

1. Under **Include**, next to **Target**, select **All users**.

   :::image type="content" source="media/how-to-multifactor-authentication-customers/enable-sms.png" alt-text="Screenshot of enabling SMS." lightbox="media/how-to-multifactor-authentication-customers/enable-sms.png":::

1. Select **Save**.

## Test the sign-in

In a private browser, open your application and select **Sign-in**. You should be prompted for another authentication method.
