---
title: Microsoft account (MSA) Server Side API Reference
description: Comprehensive guide for understanding and using the Microsoft Authentication Library (MSAL) and Microsoft Account (MSA) Server Side APIs.
author: OwenRichards1
manager: CelesteDG

ms.service: identity-platform
ms.topic: how-to
ms.workload: identity
ms.date: 03/19/2024
ms.author: owenrichards
ms.reviewer: asteen
ms.custom: 
#Customer intent: As a customer, I intend to understand the Microsoft Account (MSA) Server Side API, their parameters, and how to use them in the development of applications that integrate with Microsoft accounts.
---

# Microsoft account (MSA) Server Side API Reference

Microsoft accounts (MSA) are a single sign-on web service that allows users to log in to websites, applications, and services using a single set of credentials. The Microsoft Account (MSA) Server Side API provides a range of parameters that can be used to customize the authentication process and enhance the user experience. 

These parameters can be utilized with MSAL on a Windows platform, facilitating the development of Windows applications that integrate seamlessly with users signing in through Microsoft accounts.

## MSA Server Side API

These are passed to `login.microsoftonline.com` or `login.live.com` as URL parameters, in the format `login.microsoftonline.com?parametername=value`.

| Parameter | Value | Notes |
| --------- | ----- | ----- |
| `ImplicitAssociate` | 0/1 | If set to 1, the Microsoft Account (MSA) that the user uses to sign in is automatically linked to the application on Windows, without requiring user confirmation. <br/>**Note:** This doesn't enable single sign-on (SSO) for the user. |
| `LoginHint` | username | Prepopulates the username during sign-in, unless already provided (for example, via a refresh token). Users can modify this prepopulated username if needed. |
| `cobrandid` | cobranding GUID | This parameter applies cobranding to the sign-in user experience. Cobranding enables customization of elements like the app logo, background image, subtitle text, description text, and button colors. If you’re integrating an application with Microsoft account sign-in and wish to customize the sign-in screen, reach out to Microsoft support.|
| `client_flight` | String | `client_flight` is a passthrough parameter that is returned to the application upon completion of the sign-in process. The value of this parameter is logged to the telemetry stream and is utilized by applications to tie together their authentication requests. This can be beneficial for correlating sign-in requests, even if not all applications have access to this telemetry stream. Applications such as Office Union, Teams, and others are notable users of this parameter. |
| `lw` | 0/1 | **Note: This feature is deprecated.** Enables Lightweight Signup. If enabled, users signing up through the authentication flow aren't required to enter their first name, last name, country, and date of birth, unless mandated by laws applicable to the user’s region. |
| `fl` | `phone2`,<br/> `email`,<br/> `wld`,<br/> `wld2`,<br/> `easi`,<br/> `easi2` | **Note: This feature is deprecated.** This parameter controls the username options provided during the sign-up process:<br/> `phone` – Restricts username to phone number,<br/>`phone2` – Defaults to phone number, but allows other options,<br/>`email` – Restricts username to email (Outlook or EASI),<br/>`wld` – Restricts username to Outlook,<br/>`wld2` – Defaults to Outlook, but allows other options, including phone,<br/>`easi` – Restricts username to EASI,<br/>`easi2` – Defaults to EASI, but allows other options, including phone. |
| `nopa` | 0/1/2 | **Note: This feature is deprecated.** Enables passwordless signup. A value of 1 allows signup without a password, but enforces password creation after 30 days. A value of 2 allows signup without a password indefinitely. To use value 2, apps must be added to an allowlist through a manual process. |
| `coa` | 0/1 | **Note: This feature is deprecated.** Enables passwordless sign-in by sending a code to the user’s phone number. To use value 1, apps must be added to an allowlist through a manual process. |
| `signup` | 0/1 | Start the authentication flow in the *Create account* page rather than the *Sign-in* page. |
| `fluent` | 0/1 | **Note: This feature is deprecated.** Enables the new *Fluent* look and feel for the sign-in flow. To use value 1, apps must be added to an allowlist through a manual process. |
| `api-version` | “”/”2.0” | When set to `2.0`, this parameter allows the clientid to specify an App ID different from the one registered by the Windows calling app, given that the specified App ID is configured to permit this. |
| `Clientid/client_id` | `app ID` | App ID for the app invoking the authentication flow. |
| `Client_uiflow` | `new_account` | Allows apps to add a new account without invoking the [AccountsSettingsPane](/uwp/api/windows.ui.applicationsettings.accountssettingspane). Requires that you also pass the ForceAuthentication prompt type. Requires that you also pass the [ForceAuthentication](/uwp/api/windows.security.authentication.web.core.webtokenrequestprompttype) prompt type. |

## MSA Authorization Token Parameters

| Parameter | Value | Notes |
| --------- | ----- | ----- |
| `scope` | String | Defines the extent of permissions requested by the client at the authorization and token endpoints. |
| `claims` | String |Specifies optional claims requested by the client application. |
| `response_type` | String | Specifies an OAuth 2.0 Response Type value that dictates the authorization process flow, including the parameters returned from the respective endpoints. |
| `phone` | String | Specifies a comma-separated list of formatted phone numbers linked to the host device. |
| `qrcode_uri` | String | In requests for QR code generation to transfer an authenticated session, this URL is embedded into the QR code. |
| `Ttv` | 1 / 2  | TBD |
| `qrcode_state` | String | In QR code creation requests, this state parameter is incorporated into the URL that is displayed within the QR code. |
| `Child_client_id` | String | The child client app ID in the double broker flow. |
| `child_redirect_uri` | String | The redirect URI of the child client app used in the double broker flow. |
| `safe_rollout` | String | A parameter used to specify a safe rollout plan applied to the request. Useful when an app owner is rolling out an app config change and wants the change applied gradually for safety deployment purposes. |
| `additional_scope` | String | Specifies extra scope so the authentication service can gather extra consent in one request. This way, the client app can avoid consent interruption when requesting a different scope in the future.|
| `x-client-info` | 1/0 | A Client_info token is returned when the value is 1.0. |
| `challenge` | String | Initially provided by the resource app, it's forwarded by the client app to the MSA server without any modifications. |
| `max_age` | Integer | Maximum Authentication Age. Specifies the allowable elapsed time in seconds since the last time the End-User was actively authenticated by MSA. |
| `mfa_max_age` | Integer | Specifies the allowable elapsed time in seconds since the last time a user passed through multifactor authentication on MSA. |
| `acr_values` | String | Requested Authentication Context Class Reference values. A space-separated string that specifies the acr values that the Authorization Server is being requested to use for processing this Authentication Request, with the values appearing in order of preference. The Authentication Context Class satisfied by the authentication performed is returned as the acr Claim Value. |
| `redirect_uri` | String | Redirection URI to which the response is sent. This URI must exactly match one of the Redirection URI values for the Client preregistered at MSA. |
| `state` | String | An opaque value used to maintain state between the request and the callback. |
| `oauth2_response` | 1 | When equal to 1, it means the ws-trust response should follow the OAuth response format. |

## See also

- [MSAL Overview](msal-overview.md)
- [Microsoft Entra ID Windows Account Manager (WAM) API Reference](reference-entra-id-wam-api.md)