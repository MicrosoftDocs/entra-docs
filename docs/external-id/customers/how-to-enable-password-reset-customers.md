---
title: Enable self-service password reset
description: Learn how to enable self-service password reset so your customers can reset their own passwords without admin assistance.
ms.topic: how-to
ms.date: 09/16/2025
ms.custom: it-pro, sfi-image-nochange
#Customer intent: As an it admin, I want to enable self-service password reset so my customers can reset their own passwords without admin assistance.
---

# Enable self-service password reset

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Self-service password reset (SSPR) in Microsoft Entra External ID gives customers the ability to change or reset their password, with no administrator or help desk involvement. If a customer's account is locked or they forget their password, they can follow prompts to unblock themselves and get back to work.

## How the password reset process works

Self-service password reset (SSPR) supports two authentication methods: email one-time passcode (Email OTP) and SMS. When SSPR is enabled, users who forget their password can verify their identity using either Email OTP or SMS. With one-time passcode authentication, a passcode is sent by email or SMS. After entering the passcode, the user is prompted to create a new password.

The process works as follows:

1. From the app, the user selects **Sign in**.
1. On the sign-in page, they enter their email address and choose **Next**.
1. If the user forgot their password, they select **Forgot password?**.
1. The user is prompted to choose how to verify their identity. They can select a one-time passcode sent to their email or phone, based on the methods they registered.
1. A one-time passcode is sent to the email address they entered on the first page or to their registered phone number.
1. The user enters the passcode to continue.
1. After successfully verifying their identity, the user is prompted to create a new password.

## Prerequisites

- If you haven't already created your own external tenant, create one now.
- Have at least the [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator) role.
- If you haven't already created a User flow, [create one](how-to-user-flow-sign-up-sign-in-customers.md) now.

## Enable self-service password reset for customers

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **External Identities** > **User flows**.
1. From the list of **User flows**, select the user flow you want to enable SSPR.
1. Make sure that the sign-up user flow registers **Email with password** as an authentication method under **Identity providers**.

    :::image type="content" source="media/how-to-enable-password-reset-customers/email-authentication-method.png" alt-text="Screenshot that shows how to enable email authentication.":::

### Enable authentication method for password reset

To enable self-service password reset, configure the authentication method for all users or for a specific group in your tenant. Choose one of the following tabs to see the steps for each method.

# [Email OTP](#tab/emailotp)

The following steps show how to enable **Email OTP** as an authentication method for self-service password reset.

   1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu.
   1. Browse to **Entra ID** > **Authentication methods**.
   1. Under **Policies** > **Method** select **Email OTP**.

      :::image type="content" source="media/how-to-enable-password-reset-customers/authentication-methods.png" alt-text="Screenshot that shows authentication methods.":::

   1. Under **Enable and Target**, turn on Email OTP.
   1. Under **Include**, choose **All users** or **Select groups** to specify who can use this method.

      :::image type="content" source="media/how-to-enable-password-reset-customers/enable-otp.png" alt-text="Screenshot of enabling OTP.":::

   1. Select **Save**.

# [SMS](#tab/sms)

To use SMS for self-service password reset, users need to register their phone number as a multifactor authentication (MFA) method. There are two ways to do this:

- MFA registration happens automatically when an admin sets up a Conditional Access policy that requires [MFA](/entra/identity/conditional-access/policy-all-users-mfa-strength).
- Admins can manually add their phone number under [Authentication methods](/entra/identity/authentication/howto-mfa-userdevicesettings#add-or-change-authentication-methods-for-a-user).

The following steps show how to enable **SMS** as an authentication method for self-service password reset.

   1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu.
   1. Browse to **Entra ID** > **Authentication methods**.
   1. Under **Policies** > **Method** select **SMS**.

      :::image type="content" source="media/how-to-enable-password-reset-customers/authentication-methods-sms.png" alt-text="Screenshot that shows authentication methods including SMS.":::

   1. Under **Enable and Target**, turn on SMS.
   1. Under **Include**, choose **All users** or **Select groups** to specify who can use this method.

      :::image type="content" source="media/how-to-enable-password-reset-customers/enable-sms.png" alt-text="Screenshot of enabling SMS.":::

   > [!NOTE]
   > Self-service password reset with Phone SMS includes built-in integration with the Phone Reputation platform to detect telephony fraud in real time. Each request returns an *Allow*, *Block*, or *Challenge* decision to help protect users. SMS-based password reset is part of an add-on feature with [tiered pricing](/entra/external-id/customers/concept-multifactor-authentication-customers#sms-pricing-tiers-by-countryregion) based on location or region. Charges per SMS include fraud protection services.

   6. Select **I Acknowledge** to accept the SMS terms of use.
   7. Select **Save**.

---

### Enable the password reset link (optional)

You can hide, show, or customize the self-service password reset link on the sign-in page.

1. In the search bar, type and select **Company Branding**.
1. Under **Default sign-in** select **Edit**.
1. On the **Sign-in form** tab, scroll to the **Self-service password reset** section and select **Show self-service password reset**. 
   
   :::image type="content" source="media/how-to-customize-branding-customers/company-branding-self-service-password-reset.png" alt-text="Screenshot of the company branding Self-service password reset.":::

1. Select **Review + save** and **Save** on the **Review** tab. 

For more details, check out the [Customize the neutral branding in your external tenant](how-to-customize-branding-customers.md#to-customize-self-service-password-reset) article.

## Test self-service password reset

To go through the self-service password reset flow:

1. Open your  application, and select **Sign-in**.

1. In the sign-in page, enter your **Email address** and select **Next**.
	
   :::image type="content" source="media/how-to-enable-password-reset-customers/sign-in.png" alt-text="Screenshot that shows the sign-in page.":::
    
1. Select the **Forgot password?** link.

   :::image type="content" source="media/how-to-enable-password-reset-customers/forgot-password.png" alt-text="Screenshot that shows the forgot password link.":::

1. If SMS is available for self-service password reset, you can choose to receive a one-time passcode by email or phone. Enter the passcode sent to your email address or phone number.
1. Once you're authenticated, you're prompted to enter a new password. Provide a **New password**, and **Confirm password**, then select **Reset password** to sign in to your application.

   :::image type="content" source="media/how-to-enable-password-reset-customers/update-password.png" alt-text="Screenshot that shows the update password screen.":::

## Related content

- Add [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), [Apple](how-to-apple-federation-customers.md), or a custom [OIDC federation](how-to-custom-oidc-federation-customers.md) federation.
