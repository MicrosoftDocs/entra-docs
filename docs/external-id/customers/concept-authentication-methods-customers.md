---
title: Identity Providers
description: Learn about sign-in and MFA options for customer identity and access management (CIAM) in external tenants, including email, one-time passcodes, Google and Facebook. 
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: concept-article
ms.date: 05/15/2024
ms.author: mimart
ms.custom: it-pro, seo-july-2024
---

# Sign-in options and identity providers for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

> [!TIP]
> This article applies to External ID in external tenants. For information about workforce tenants, see [Identity providers for External ID in workforce tenants](../identity-providers.md).

With Microsoft Entra External ID, you can create secure, customized sign-in experiences for your consumer- and business customer-facing apps. In an external tenant, there are several ways for users to sign up for your app. They can create an account using their email and either a password or a one-time passcode. Or, if you enable sign-in with Facebook and Google, they can sign in with their own social account. You can also add a layer of security by enforcing multifactor authentication (MFA) so that each time a user signs in, they're required to provide a one-time passcode for verification.

This article describes the authentication methods and identity providers available in external tenants.

## Email and password sign-in

Email sign-up is enabled by default in your local account identity provider settings. With the email option, customers can sign up and sign in with their email address and a password.

- **Sign-up**: Customers are prompted for an email address, which is verified at sign-up with a one-time passcode. The customer then enters any other information requested on the sign-up page, for example, display name, given name, and surname. Then they select Continue to create an account.

- **Sign-in**: After the customer signs up and creates an account, they can sign in by entering their email address and password.

- **Password reset**: If you enable email and password sign-in, a password reset link appears on the password page. If the customer forgets their password, selecting this link sends a one-time passcode to their email address. After verification, the customer can choose a new password.

   :::image type="content" source="media/concept-authentication-methods-customers/email-password-sign-in.png" alt-text="Screenshots of the email with password sign-in screens." border="false":::

When you [create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md#create-and-customize-a-user-flow), **Email with password** is the default option.

## Email with one-time passcode sign-in

Email with one-time passcode is an option in your local account identity provider settings. With this option, the customer signs in with a temporary passcode instead of a stored password each time they sign in.

- **Sign-up**: Customers can sign up with their email address and request a temporary code, which is sent to their email address. Then they enter this code to continue signing in.

- **Sign-in**: After the customer signs up and creates an account, each time they sign they'll enter their email address and receive a temporary passcode.

   :::image type="content" source="media/concept-authentication-methods-customers/email-passcode-sign-in.png" alt-text="Screenshots of the email with one-time passcode sign-in screens." border="false":::

> [!IMPORTANT]
> If you want to enable [multifactor authentication (MFA)](how-to-multifactor-authentication-customers.md), set your local account authentication method to **Email with password**. If you set your local account option to **Email with one-time passcode**, customers who use this method won't be able to sign in because the one-time passcode is already their first-factor sign-in method and can't be used as a second factor. Currently, other verification methods aren't available for customer scenarios.

When you [create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md#create-and-customize-a-user-flow), **Email one-time passcode** is one of the local account options.

## Social identity providers: Facebook and Google

For an optimal sign-in experience, federate with social identity providers whenever possible so you can give your customers a seamless sign-up and sign-in experience. In an external tenant, you can allow a customer to sign up and sign in using their own Facebook or Google account. When a customer signs up for your app using their social account, the social identity provider creates, maintains, and manages identity information while providing authentication services to applications.

When you enable social identity providers, customers can select from the social identity providers options you make available on the sign-up page. To set up social identity providers in your external tenant, you create an application at the identity provider and configure credentials. You obtain a client or app ID and a client or app secret, which you can then add to your external tenant.

### Google sign-in (preview)

By setting up federation with Google, you can allow customers to sign in to your applications with their own Gmail accounts. After you add Google as one of your application's sign-in options, on the sign-in page, users can sign in to Microsoft Entra External ID with a Google account.

The following screenshots show the sign-in with Google experience. In the sign-in page, users select **Sign-in with Google**. At that point, the user is redirected to the Google identity provider to complete the sign-in.

   :::image type="content" source="media/concept-authentication-methods-customers/google-sign-in.png" alt-text="Screenshots of google sign-in screens." border="false":::

Learn how to [add Google as an identity provider](how-to-google-federation-customers.md).

### Facebook sign-in (preview)

By setting up federation with Facebook, you can allow invited users to sign in to your applications with their own Facebook accounts. After you add Facebook as one of your application's sign-in options, on the sign-in page, users can sign-in to Microsoft Entra External ID with a Facebook account.

The following screenshots show the sign-in with Facebook experience. In the sign-in page, users select **Sign-in with Facebook**. Then the user is redirected to the Facebook identity provider to complete the sign-in.

   :::image type="content" source="media/concept-authentication-methods-customers/facebook-sign-in.png" alt-text="Screenshots of Facebook sign-in screens." border="false":::

Learn how to [add Facebook as an identity provider](how-to-facebook-federation-customers.md).

### Updating sign-in methods

At any time, you can update the sign-in options for an app. For example, you can add social identity providers or change the local account sign-in method.

When you change sign-in methods, the change affects only new users. Existing users continue to sign in using their original method. For example, suppose you start out with the email and password sign-in method, and then change to email with one-time passcode. New users sign in using a one-time passcode, but any users who already signed up with an email and password continue to be prompted for their email and password.

## Microsoft Graph APIs

The following Microsoft Graph API operations are supported for managing identity providers and authentication methods in Microsoft Entra External ID:

- To identify what identity providers and authentication methods are supported, you call the [List availableProviderTypes](/graph/api/identityproviderbase-availableprovidertypes) API.
- To identify the identity providers and authentication methods that are already configured and enabled in the tenant, you call the [List identityProviders](/graph/api/identitycontainer-list-identityproviders) API.
- To enable a supported identity provider or authentication method, you call the [Create identityProvider](/graph/api/identitycontainer-post-identityproviders) API.

## Next steps

- [Enable multifactor authentication (MFA)](how-to-multifactor-authentication-customers.md)
- [Add Facebook as an identity provider](how-to-facebook-federation-customers.md)
- [Add Google as an identity provider](how-to-google-federation-customers.md)
