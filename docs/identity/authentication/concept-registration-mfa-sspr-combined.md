---
title: Combined registration for SSPR and Microsoft Entra multifactor authentication
description: Learn about the combined registration experience for Microsoft Entra ID to let users register for both Microsoft Entra multifactor authentication and self-service password reset

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/01/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: tilarso
---
# Combined security information registration for Microsoft Entra overview

Before combined registration, users registered authentication methods for Microsoft Entra multifactor authentication and self-service password reset (SSPR) separately. People were confused that similar methods were used for multifactor authentication and SSPR but they had to register for both features. Now, with combined registration, users can register once and get the benefits of both multifactor authentication and SSPR. We recommend this video on [How to enable and configure SSPR in Microsoft Entra ID](https://www.youtube.com/watch?v=rA8TvhNcCvQ).


![My Account showing registered Security info for a user](media/concept-registration-mfa-sspr-combined/combined-security-info-defaults-registered.png)

Before enabling the new experience, review this administrator-focused documentation and the user-focused documentation to ensure you understand the functionality and effect of this feature. Base your training on the [user documentation](https://support.microsoft.com/account-billing/set-up-your-security-info-from-a-sign-in-prompt-28180870-c256-4ebf-8bd7-5335571bf9a8) to prepare your users for the new experience and help to ensure a successful rollout.

Combined registration has rolled out to all customers in Azure and Azure for US Government. The portal control that allows you to switch from legacy to combined registration experience is removed after your tenant migrates to the combined registratione.

*My Account* pages are localized based on the language settings of the computer accessing the page. Microsoft stores the most recent language used in the browser cache, so subsequent attempts to access the pages continue to render in the last language used. If you clear the cache, the pages re-render.

If you want to force a specific language, you can add `?lng=<language>` to the end of the URL, where `<language>` is the code of the language you want to render.

![Set up SSPR or other security verification methods](media/howto-registration-mfa-sspr-combined/combined-security-info-my-profile.png)

## Methods available in combined registration

Combined registration supports the authentication methods and actions in the following table.

| Method | Register | Change | Delete |
| --- | --- | --- | --- |
| Microsoft Authenticator | Yes (maximum of 5) | No | Yes |
| Other authenticator app | Yes (maximum of 5) | No | Yes |
| Hardware token | No | No | Yes |
| Phone | Yes (maximum of 2) | Yes | Yes |
| Alternate phone | Yes | Yes | Yes |
| Office phone* | Yes | Yes | Yes |
| Email | Yes | Yes | Yes |
| Security questions | Yes | No | Yes |
| Passwords | No | Yes | No |
| App passwords* | Yes | No | Yes |
| Passkey (FIDO2)*| Yes (maximum of 10)  | No | Yes |

> [!NOTE]
> If you enable Microsoft Authenticator for passwordless authentication mode in the Authentication methods policy, users need to also enable passwordless sign-in in the Authenticator app.
>
> Alternate phone can only be registered in *manage mode* on [Security info](https://aka.ms/mysecurityinfo) and requires Voice calls to be enabled in the Authentication methods policy.
>
> Office phone can only be registered in *Interrupt mode* if the users *Business phone* property has been set. Office phone can be added by users in *Manage mode* from [Security info](https://aka.ms/mysecurityinfo) without this requirement.
>
> App passwords are available only to users who have been enforced for per-user MFA. App passwords aren't available to users who are enabled for Microsoft Entra multifactor authentication by a Conditional Access policy.
>
> Passkeys (FIDO2) can also be provisioned by using a custom client or partner integration with Microsoft Graph. For more information, see our [APIs](https://aka.ms/passkeyprovision).

Users can set one of the following options as the default multifactor authentication method. 

- Microsoft Authenticator – push notification or passwordless
- Authenticator app or hardware token – code
- Phone call
- Text message

>[!NOTE]
>Virtual phone numbers aren't supported for Voice calls or SMS messages.

Third party authenticator apps don't provide push notification. As we continue to add more authentication methods to Microsoft Entra ID, those methods become available in combined registration.

## Combined registration modes

There are two modes of combined registration: 

- **Interrupt mode** is a wizard-like experience, presented to users when they register or refresh their security info at sign-in.
- **Manage mode** is part of the user profile and allows users to manage their security info.

For both modes, users who have previously registered a method that can be used for Microsoft Entra multifactor authentication need to perform multifactor authentication before they can access their security info. Users must confirm their information before continuing to use their previously registered methods. 



### Interrupt mode

Combined registration adheres to both multifactor authentication and SSPR policies, if both are enabled for your tenant. These policies control whether a user is interrupted for registration during sign-in and which methods are available for registration. If only an SSPR policy is enabled, then users will be able to skip (indefinitely) the registration interruption and complete it at a later time.

The following are sample scenarios where users might be prompted to register or refresh their security info:

- *multifactor authentication registration enforced through Microsoft Entra ID Protection:* Users are asked to register during sign-in. They register multifactor authentication methods and SSPR methods (if the user is enabled for SSPR).
- *multifactor authentication registration enforced through per-user multifactor authentication:* Users are asked to register during sign-in. They register multifactor authentication methods and SSPR methods (if the user is enabled for SSPR).
- *multifactor authentication registration enforced through Conditional Access or other policies:* Users are asked to register when they use a resource that requires multifactor authentication. They register multifactor authentication methods and SSPR methods (if the user is enabled for SSPR).
- *SSPR registration enforced:* Users are asked to register during sign-in. They register only SSPR methods.
- *SSPR refresh enforced:* Users are required to review their security info at an interval set by the admin. Users are shown their info and can confirm the current info or make changes if needed.

When registration is enforced, users are shown the minimum number of methods needed to be compliant with both multifactor authentication and SSPR policies, from most to least secure. Users going through combined registration where both MFA and SSPR registration are enforced and the SSPR policy requires two methods will first be required to register an MFA method as the first method and can select another MFA or SSPR specific method as the second registered method (such as email, security questions, and so on)

Consider the following example scenario:

- A user is enabled for SSPR. The SSPR policy requires two methods to reset and has enabled Microsoft Authenticator app, email, and phone.
- When the user chooses to register, two methods are required:
   - The user is shown Microsoft Authenticator app and phone by default.
   - The user can choose to register email instead of Authenticator app or phone.

When they set up Microsoft Authenticator, the user can click **I want to setup a different method** to register other authentication methods. The list of available methods is determined by the Authentication methods policy for the tenant. 

:::image type="content" border="true" source="media/concept-registration-mfa-sspr-combined/choose.png" alt-text="Screenshot of how to choose another method when you set up Microsoft Authenticator.":::

The following flowchart describes which methods are shown to a user when interrupted to register during sign-in:

![Combined security info flowchart](media/concept-registration-mfa-sspr-combined/combined-security-info-flow-chart.png)

If you have both multifactor authentication and SSPR enabled, we recommend that you enforce multifactor authentication registration.

If the SSPR policy requires users to review their security info at regular intervals, users are interrupted during sign-in and shown all their registered methods. They can confirm the current info if it's up to date, or they can make changes if they need to. Users must perform multifactor authentication to access this page.

### Manage mode

Users can go to [Security info](https://aka.ms/mysecurityinfo), or they can select **Security info** from My Account. From there, users can add methods, delete or change existing methods, change the default method, and more.


### Session controls for Combined Registration
By default Combined registration enforces all MFA capable users to strongly authenticate prior to registering or managing their security info. If a user is currently signed in and has previously completed MFA as part of  a valid session, no additional MFA will be required by default, unless a user is attempting to add or modify a passkey (FIDO2) method. Adding or modifying a passkey (FIDO2) method requires users to have strongly authenticated within the past 5 minutes. If MFA hasn't been completed in the past 5 minutes, the user will be asked to sign-in and complete fresh MFA. Organizations can modify the authentication requirements by defining [Conditional Access policies for securing security info registration.](~/identity/conditional-access/policy-all-users-security-info-registration.md).

Combined registration sessions are only valid for 15 minutes. If a users registration or management actions take longer than this time period, the session will expire and the user will be asked to sign back in to continue. 

## Key usage scenarios

### Change a password in MySignIns
A user navigates to [Security info](https://aka.ms/mysecurityinfo). After signing in, the user can change their password. If the user authenticates with a password and a multifactor authentication method, they will be able to use the enhanced user experience to change their password without entering their existing password. When finished, the user has the new password updated on the Security info page. Authentication methods such as Temporary Access Pass (TAP) aren't supported for password change unless the user knows their existing password.

>[!NOTE]
>If you have any links that point to the legacy change password experience, update them to the following forward link to direct users to the new **My Sign Ins Change Password** experience: [https://go.microsoft.com/fwlink/?linkid=2224198](https://go.microsoft.com/fwlink/?linkid=2224198). 

### Protect Security info registration with Conditional Access
To secure when and how users register for Microsoft Entra multifactor authentication and self-service password reset, you can use user actions in Conditional Access policy. This functionality may be enabled in organizations that want users to register for Microsoft Entra multifactor authentication and SSPR from a central location, such as a trusted network location during HR onboarding. Learn more on how to configure [common Conditional Access policies for securing security info registration.](~/identity/conditional-access/policy-all-users-security-info-registration.md)


### Set up security info during sign-in

An admin has enforced registration.

A user has not set up all required security info and goes to the Microsoft Entra admin center. After the user enters the user name and password, the user is prompted to set up security info. The user then follows the steps shown in the wizard to set up the required security info. If your settings allow it, the user can choose to set up methods other than those shown by default. After users complete the wizard, they review the methods they set up and their default method for multifactor authentication. To complete the setup process, the user confirms the info and continues to the Microsoft Entra admin center.

### Set up security info from My Account

An admin hasn't enforced registration.

A user who hasn't yet set up all required security info goes to [https://myaccount.microsoft.com](https://myaccount.microsoft.com). The user selects **Security info** in the left pane. From there, the user chooses to add a method, selects any of the methods available, and follows the steps to set up that method. When finished, the user sees the method that was set up on the Security info page.

### Set up other methods after partial registration

If a user has partially satisfied MFA or SSPR registration due to existing authentication method registrations performed by the user or admin, users will only be asked to register additional information allowed by the Authentication methods policy settings when registration is required. If more than one other authentication method is available for the user to choose and register, an option on the registration experience titled **I want to set up another method** will be shown and allow the user to set up their desired authentication method.  

:::image type="content" border="true" source="./media/concept-registration-mfa-sspr-combined/other-method.png" alt-text="Screenshot of how to set up another method." :::  

### Delete security info from My Account

A user who has previously set up at least one method navigates to [Security info](https://aka.ms/mysecurityinfo). The user chooses to delete one of the previously registered methods. When finished, the user no longer sees that method on the Security info page.

### Change the default method from My Account

A user who has previously set up at least one method that can be used for multifactor authentication navigates to [Security info](https://aka.ms/mysecurityinfo). The user changes the current default method to a different default method. When finished, the user sees the new default method on the Security info page.

### Switch directory

An external identity such as a B2B user may need to switch the directory to change the security registration information for a third-party tenant. 
In addition, users who access a resource tenant may be confused when they change settings in their home tenant but don't see the changes reflected in the resource tenant. 

For example, a user sets Microsoft Authenticator app push notification as the primary authentication to sign-in to home tenant and also has SMS/Text as another option. 
This user is also configured with SMS/Text option on a resource tenant. 
If this user removes SMS/Text as one of the authentication options on their home tenant, they get confused when access to the resource tenant asks them to respond to SMS/Text message. 

To switch the directory in the Microsoft Entra admin center, click the user account name in the upper right corner and click **Switch directory**.

![External users can switch directory.](media/concept-registration-mfa-sspr-combined/switch-directory.png)

Or, you can specify a tenant by URL to access security information.

`https://mysignins.microsoft.com/security-info?tenant=<Tenant Name>`

`https://mysignins.microsoft.com/security-info/?tenantId=<Tenant ID>`

> [!NOTE]
> Customers attempting to register or manage security info through combined registration or the My Sign-ins page should use a modern browser such as Microsoft Edge. 
> 
> IE11 is not officially supported for creating a webview or browser in applications as it will not work as expected in all scenarios.
> 
> Applications that have not been updated and are still using Azure AD Authentication Library (ADAL) that rely on legacy webviews can fallback to older versions of Internet Explorer. In these scenarios, users will experience a blank page when directed to the My Sign-ins page. To resolve this issue, switch to a modern browser.

## Next steps

To get started, see the tutorials to [enable self-service password reset](tutorial-enable-sspr.md) and [enable Microsoft Entra multifactor authentication](tutorial-enable-azure-mfa.md).

Learn how to [enable combined registration in your tenant](howto-registration-mfa-sspr-combined.md) or [force users to re-register authentication methods](howto-mfa-userdevicesettings.yml).

You can also review the [available methods for Microsoft Entra multifactor authentication and SSPR](concept-authentication-methods.md).
