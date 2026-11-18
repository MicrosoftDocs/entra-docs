---
title: Create a Sign-up and Sign-in User Flow
description: Create a Microsoft Entra External ID user flow to configure sign-up and sign-in methods and collect customer attributes for apps in your external tenant.
ms.topic: how-to
ms.date: 11/11/2026
ms.reviewer: kengaderdus
ms.custom: it-pro, seo-july-2024, sfi-image-nochange, msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As a developer or IT administrator, I want to configure a user flow so that customers can sign up and sign in to my application.
---

# Create a sign-up and sign-in user flow in Microsoft Entra External ID

A user flow defines how customers sign up and sign in to your application and which attributes you collect.

[!INCLUDE [authentication-approaches](../includes/applies-to-authentication-approaches.md)]

Configure methods such as email and password, one-time passcodes, social accounts from [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), or [Apple](how-to-apple-federation-customers.md), or custom [OpenID Connect (OIDC) federation](how-to-custom-oidc-federation-customers.md). Confirm availability for your integration in the [methods and journeys comparison](concept-supported-features-customers.md#methods-and-journeys-by-approach).

Page layout settings and the **Stay signed in?** prompt guidance in this article apply to Microsoft-hosted pages.

Before you begin, review the [Prerequisites](#prerequisites) for your external tenant and optional sign-in methods. After you create the user flow, [add your application to the user flow](how-to-user-flow-add-application.md). Multiple applications can share a user flow, but each application can have only one user flow.

## Prerequisites

- **A Microsoft Entra external tenant**: Before you begin, create your Microsoft Entra external tenant. You can set up a <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">free trial</a>, or you can create a new external tenant in Microsoft Entra ID.
- **Email one-time passcode enabled (optional)**: If you want customers to use their email address and a one-time passcode each time they sign in, make sure Email one-time passcode is enabled at the tenant level (in the [Microsoft Entra admin center](https://entra.microsoft.com/), navigate to **External Identities** > **All Identity Providers** > **Email One-time-passcode**).
- **Custom attributes defined (optional)**: User attributes are values collected from the user during self-service sign-up. Microsoft Entra ID comes with a built-in set of attributes, but you can [define custom attributes to collect during sign-up](how-to-define-custom-attributes.md). Define custom attributes in advance so they're available when you set up your user flow. Or you can create and add them later.
- **Identity providers defined (optional)**: You can set up federation with [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md) or an [OIDC identity provider](how-to-custom-oidc-federation-customers.md) in advance, and then select them as sign-in options as you create the user flow.

## Create and customize a user flow

Follow these steps to create a user flow a customer can use to sign in or sign up for an application. These steps describe how to add a new user flow, select the attributes you want to collect, and change the order of the attributes on the sign-up page.

### To add a new user flow

Create the user flow in your external tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.

1. Browse to **Entra ID** > **External Identities** > **User flows**.

1. Select **New user flow**.

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/new-user-flow.png" alt-text="Screenshot of the new user flow option.":::

1. On the **Create** page, enter a **Name** for the user flow (for example, "SignUpSignIn").

1. Under **Identity providers**, select the **Email Accounts** check box, and then select one of these options:

    - **Email with password**: Allows new users to sign up and sign in using an email address as the sign-in name and a password as their first-factor authentication method. On Microsoft-hosted pages, you can also [customize the self-service password reset link](how-to-customize-branding-customers.md#to-customize-self-service-password-reset). If you plan to require multifactor authentication, this option lets you choose from email one-time passcodes, SMS text codes, or both as second-factor methods.

    - **Email one-time passcode**: Allows new users to sign up and sign in using an email address as the sign-in name and email one-time passcode as their first-factor authentication method. If you plan to require multifactor authentication, you can enable SMS text codes as a second-factor method.

   > [!NOTE]
   > The **Microsoft Entra ID Sign up** option is unavailable because although customers can sign up for a local account using an email from another Microsoft Entra organization, Microsoft Entra federation isn't used to authenticate them. **[Google](how-to-google-federation-customers.md)** and **[Facebook](how-to-facebook-federation-customers.md)** become available only after you set up federation with them. [Learn more about authentication methods and identity providers](concept-authentication-methods-customers.md).

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/create-user-flow-identity-providers.png" alt-text="Screenshot of Identity provider options on the Create a user flow page.":::

1. Under **User attributes**, choose the attributes you want to collect from the user during sign-up.

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes.png" alt-text="Screenshot of the user attribute options on the Create a user flow page." lightbox="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes.png":::

1. Select **Show more** to choose from the full list of attributes, including **Job Title**, **Display Name**, and **Postal Code**.

   This list also includes any [custom attributes you defined](how-to-define-custom-attributes.md). Select the checkbox next to each attribute you want to collect from the user during sign-up.

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes-show-more.png" alt-text="Screenshot of the user attribute pane after selecting Show more." lightbox="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes-show-more.png":::

1. Select **OK**.

1. Select **Create** to create the user flow.

## Control the 'Stay signed in?' prompt

For Microsoft-hosted authentication, after a customer signs in to an app that uses your user flow, they see a **Stay signed in?** prompt by default. The prompt asks whether to stay signed in across browser sessions. If the user selects **Yes**, a persistent authentication cookie is issued and they remain signed in across browser sessions. If they select **No**, a non-persistent cookie is issued.

For Microsoft-hosted pages, applying custom branding or requiring multifactor authentication doesn't change whether the prompt appears. To override the default prompt behavior, use a Conditional Access policy.

The prompt isn't a user flow setting. To change or suppress it, configure the **Persistent browser session** session control in a Conditional Access policy that targets your customers and apps:

- **Always persistent**: The browser session is always persisted. The **Stay signed in?** prompt isn't shown.
- **Never persistent**: The browser session ends when the browser is closed. The **Stay signed in?** prompt isn't shown.

For details about the session control and how to apply it, see [Conditional Access: Session - Persistent browser session](~/identity/conditional-access/concept-conditional-access-session.md#persistent-browser-session) and [Configure authentication session management](~/identity/conditional-access/concept-session-lifetime.md#persistence-of-browsing-sessions).

## Next steps

- [Add your application to the user flow](how-to-user-flow-add-application.md).
- [Create custom user attributes and customize the order of the attributes on the sign-up page](how-to-define-custom-attributes.md).
