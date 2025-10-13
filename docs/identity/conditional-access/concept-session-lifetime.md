---
title: Conditional Access adaptive session lifetime policies
description: Learn how to use Conditional Access adaptive session lifetimes to enhance security.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: article
ms.date: 09/12/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: inbarc
---
# Conditional Access adaptive session lifetime policies

Conditional Access adaptive session lifetime policies let organizations restrict authentication sessions in complex deployments. Scenarios include:

* Resource access from an unmanaged or shared device
* Access to sensitive information from an external network
* High impact users
* Critical business applications

Conditional Access provides adaptive session lifetime policy controls, letting you create policies that target specific use cases within your organization without affecting all users.

Before exploring how to configure the policy, examine the default configuration.

## User sign-in frequency

Sign-in frequency specifies how long a user can access a resource before being asked to sign in again.

The Microsoft Entra ID default configuration for user sign-in frequency is a rolling window of 90 days. It might seem sensible to ask users for credentials often, but this approach can backfire. Users who habitually enter credentials without thinking might unintentionally provide them to malicious prompts.

Not asking a user to sign back in might seem alarming, but any IT policy violation revokes the session. Examples include a password change, a noncompliant device, or an account being disabled. You can also explicitly [revoke users’ sessions using Microsoft Graph PowerShell](/powershell/module/microsoft.graph.users.actions/revoke-mgusersigninsession). The Microsoft Entra ID default configuration is: **don’t ask users to provide their credentials if the security posture of their sessions hasn’t changed.**

The sign-in frequency setting works with apps that implement OAuth2 or OIDC protocols according to the standards. Most Microsoft native apps, like those for Windows, Mac, and Mobile including the following web applications comply with the setting.

* Word, Excel, PowerPoint Online
* OneNote Online
* Office.com
* Microsoft 365 Admin portal
* Exchange Online
* SharePoint and OneDrive
* Teams web client
* Dynamics CRM Online
* Azure portal

Sign-in frequency (SIF) works with non-Microsoft SAML applications and apps that use OAuth2 or OIDC protocols, as long as they don’t drop their own cookies and regularly redirect back to Microsoft Entra ID for authentication.

### User sign-in frequency and multifactor authentication

Previously, sign-in frequency applied only to first-factor authentication on Microsoft Entra joined, hybrid joined, and registered devices. Customers couldn’t easily reinforce multifactor authentication on those devices. Based on customer feedback, sign-in frequency now applies to multifactor authentication (MFA) as well.

[![A diagram showing how Sign in frequency and MFA work together.](media/howto-conditional-access-session-lifetime/conditional-access-flow-chart.png)](media/howto-conditional-access-session-lifetime/conditional-access-flow-chart.png#lightbox)

### User sign-in frequency and device identities

On Microsoft Entra joined and hybrid joined devices, unlocking the device or signing in interactively refreshes the Primary Refresh Token (PRT) every four hours. The last refresh timestamp recorded for the PRT compared with the current timestamp must be within the time allotted in SIF policy for the PRT to satisfy SIF and grant access to a PRT that has an existing MFA claim. On [Microsoft Entra registered devices](~/identity/devices/concept-device-registration.md), unlocking or signing in wouldn't satisfy the SIF policy because the user isn't accessing a Microsoft Entra registered device via a Microsoft Entra account. However, the [Microsoft Entra WAM](~/identity-platform/scenario-desktop-acquire-token-wam.md) plugin can refresh a PRT during native application authentication using WAM.

> [!NOTE]
> The timestamp captured from user log-in isn't necessarily the same as the last recorded timestamp of PRT refresh because of the 4-hour refresh cycle. The case when it's the same is when the PRT expired and a user log-in refreshes it for 4 hours. In the following examples, assume SIF policy is set to 1 hour and the PRT is refreshed at 00:00.

#### Example 1: When you continue to work on the same doc in SPO for an hour

* At 00:00, a user signs in to their Windows 11 Microsoft Entra joined device and starts work on a document stored on SharePoint Online.
* The user continues working on the same document on their device for an hour.
* At 01:00, the user is prompted to sign in again. This prompt is based on the sign-in frequency requirement in the Conditional Access policy configured by their administrator.

#### Example 2: When you pause work with a background task running in the browser, then interact again after the SIF policy time elapsed

* At 00:00, a user signs in to their Windows 11 Microsoft Entra joined device and starts to upload a document to SharePoint Online.
* At 00:10, the user gets up and takes a break locking their device. The background upload continues to SharePoint Online.
* At 02:45, the user returns from their break and unlocks the device. The background upload shows completion.
* At 02:45, the user is prompted to sign in when they interact again. This prompt is based on the sign-in frequency requirement in the Conditional Access policy configured by their administrator since the last sign-in happened at 00:00.

If the client app (under activity details) is a browser, we defer sign-in frequency enforcement of events and policies on background services until the next user interaction. On confidential clients, sign-in frequency enforcement on non-interactive sign-ins is deferred until the next interactive sign-in.

#### Example 3: With four hour refresh cycle of primary refresh token from unlock

Scenario 1 - User returns within cycle

* At 00:00, a user signs into their Windows 11 Microsoft Entra joined device and starts work on a document stored on SharePoint Online.
* At 00:30, the user gets up and takes a break locking their device.
* At 00:45, the user returns from their break and unlocks the device.
* At 01:00, the user is prompted to sign in again. This prompt is based on the sign-in frequency requirement in the Conditional Access policy configured by their administrator, 1 hour after the initial sign-in.

Scenario 2 - User returns outside cycle

* At 00:00, a user signs into their Windows 11 Microsoft Entra joined device and starts work on a document stored on SharePoint Online.
* At 00:30, the user gets up and takes a break locking their device.
* At 04:45, the user returns from their break and unlocks the device.
* At 05:45, the user is prompted to sign in again. This prompt is based on the sign-in frequency requirement in the Conditional Access policy configured by their administrator. It's now 1 hour after the PRT was refreshed at 04:45, and over 4 hours since the initial sign-in at 00:00.

### Require reauthentication every time

There are scenarios where customers might want to require a fresh authentication, every time a user performs specific actions like:

* Accessing sensitive applications.
* Securing resources behind VPN or Network as a Service (NaaS) providers.
* Securing privileged role elevation in PIM​.
* Protecting user sign-ins to Azure Virtual Desktop machines.
* Protecting risky users and risky sign-ins​ identified by Microsoft Entra ID Protection.
* Securing sensitive user actions like Microsoft Intune enrollment.

When administrators select **Every time**, it requires full reauthentication when the session is evaluated. For example, if the user closed and opened their browser during the session lifetime, they aren't prompted for reauthentication. Sign-in frequency set to every time works best when the resource has the logic to identify when a client should get a new token. These resources redirect the user back to Microsoft Entra only once the session expires.

Administrators should limit the number of applications they enforce a policy requiring users to reauthenticate every time with. Triggering reauthentication too frequently can increase security friction to a point that it causes users to experience MFA fatigue and open the door to phishing. Web applications usually provide a less disruptive experience than their desktop counterparts when require reauthentication every time is enabled. We factor for five minutes of clock skew when every time is selected in policy, so that we don’t prompt users more often than once every five minutes.

> [!WARNING]
> Using sign-in frequency to require reauthentication every time, without multifactor authentication might result in sign-in looping for your users.

* For applications in the Microsoft 365 stack, we recommend using [time-based user sign-in frequency](#user-sign-in-frequency) for a better user experience.
* For the Azure portal and the Microsoft Entra admin center, we recommend either using [time-based user sign-in frequency](#user-sign-in-frequency) or to [require reauthentication on PIM activation](../../id-governance/privileged-identity-management/pim-how-to-change-default-settings.md#on-activation-require-microsoft-entra-conditional-access-authentication-context) using authentication context for a better user experience.

## Persistence of browsing sessions

A persistent browser session lets users stay signed in after closing and reopening their browser window.

Microsoft Entra ID's default for browser session persistence lets users on personal devices decide whether to persist the session by showing a **Stay signed in?** prompt after successful authentication. If browser persistence is set up in AD FS using the guidance in [AD FS single sign-on settings](/windows-server/identity/ad-fs/operations/ad-fs-single-sign-on-settings#enable-psso-for-office-365-users-to-access-sharepoint-online), the policy is followed, and the Microsoft Entra session is persisted as well. You configure whether users in your tenant see the **Stay signed in?** prompt by changing the appropriate setting in the [company branding pane](~/fundamentals/how-to-customize-branding.md).

In persistent browsers, cookies remain stored on the user's device even after the browser is closed. These cookies might access Microsoft Entra artifacts, which remain usable until token expiration, regardless of the Conditional Access policies applied to the resource environment. So, token caching can be in direct violation of desired security policies for authentication. Storing tokens beyond the current session might seem convenient, but it can create a security vulnerability by allowing unauthorized access to Microsoft Entra artifacts.

## Configuring authentication session controls

Conditional Access is a Microsoft Entra ID P1 or P2 capability that requires a premium license. To learn more about Conditional Access, see [What is Conditional Access in Microsoft Entra ID?](overview.md#license-requirements).

> [!WARNING]
> If you're using the [configurable token lifetime](~/identity-platform/configurable-token-lifetimes.md) feature currently in public preview, don't create two different policies for the same user or app combination: one with this feature and another with the configurable token lifetime feature. Microsoft retired the configurable token lifetime feature for refresh and session token lifetimes on January 30, 2021, and replaced it with the Conditional Access authentication session management feature.
>
> Before enabling sign-in frequency, ensure other reauthentication settings are disabled in your tenant. If "Remember MFA on trusted devices" is enabled, disable it before using sign-in frequency, as using these two settings together might prompt users unexpectedly. To learn more about reauthentication prompts and session lifetime, see [Optimize reauthentication prompts and understand session lifetime for Microsoft Entra multifactor authentication](~/identity/authentication/concepts-azure-multi-factor-authentication-prompts-session-lifetime.md).

## Next steps

* [Configure session lifetimes in Conditional Access policies](howto-conditional-access-session-lifetime.md)
* To set up Conditional Access policies for your environment, see the article [Plan a Conditional Access deployment](plan-conditional-access.md).
