---
title: Add multifactor authentication (MFA) to a customer app
description: Learn how to add multifactor authentication (MFA) to your consumer and business customer (CIAM) application. For example, add email one-time passcode as a second authentication factor to your CIAM sign-up and sign-in user flows.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: how-to
ms.date: 06/26/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to add multifactor authentication to my custoconsumer and business customer app.
---

# Add multifactor authentication (MFA) to an app

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[Multifactor authentication (MFA)](~/identity/authentication/concept-mfa-howitworks.md) adds a layer of security to your applications. With MFA, customers who sign in with a username and password are prompted for a one-time passcode as a second verification method. This article describes how to enforce MFA for your customers by creating a Microsoft Entra Conditional Access policy and adding MFA to your sign-up and sign-in user flow.
In a Microsoft Entra External ID external tenant, you can add a layer of security to your consumer- and business customer-facing applications by enforcing multifactor authentication (MFA). With MFA, each time a user signs in, they're required to provide an email one-time passcode. This article describes how to enforce MFA for your customers by creating a Microsoft Entra Conditional Access policy and adding MFA to your sign-up and sign-in user flow.

> [!IMPORTANT]
> If you want to enable MFA, set your local account authentication method to **Email with password**. If you set your local account option to **Email with one-time passcode**, customers who use this method won't be able to sign in because the one-time passcode is already their first-factor sign-in method and can't be used as a second factor. Currently, one-time passcode is the only method available for MFA in external tenants.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=MFA)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “[Multi-factor authentication](https://woodgrovedemo.com/#usecase=MFA)” use case.

## Prerequisites

- A Microsoft Entra external tenant (if you don't have a tenant, you can start a <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">free trial</a>).
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md) with the local account authentication method set to **Email with password**.
- An app that's registered in your external tenant, added to the sign-up and sign-in user flow, and updated to point to the user flow for authentication.
- An account with at least the Security Administrator role to configure Conditional Access policies and MFA.

## Create a Conditional Access policy

Create a Conditional Access policy in your external tenant that prompts users for MFA when they sign up or sign in to your app. (For more information, see [Common Conditional Access policy: Require MFA for all users](~/identity/conditional-access/howto-conditional-access-policy-all-users-mfa.md)).

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

      - Choose **All cloud apps**.

      - Choose **Select apps** and select the link under **Select**. Find your app, select it, and then choose **Select**.

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

## Test the sign-in

In a private browser, open your application and select **Sign-in**. You should be prompted for another authentication method.
 
