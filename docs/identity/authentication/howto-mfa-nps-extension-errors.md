---
title: Troubleshooting Microsoft Entra multifactor authentication NPS extension
description: Get help resolving issues with the NPS extension for Microsoft Entra multifactor authentication


ms.service: entra-id
ms.subservice: authentication
ms.topic: troubleshooting
ms.date: 01/02/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: jupetter
ms.custom: 
---
# Resolve error messages from the NPS extension for Microsoft Entra multifactor authentication

If you encounter errors with the NPS extension for Microsoft Entra multifactor authentication, use this article to reach a resolution faster. NPS extension logs are found in Event Viewer under **Applications and Services Logs** > **Microsoft** > **AzureMfa** > **AuthN** > **AuthZ** on the server where the NPS Extension is installed.

## Troubleshooting steps for common errors

| Error code | Troubleshooting steps |
| ---------- | --------------------- |
| **CONTACT_SUPPORT** | [Contact support](#contact-microsoft-support), and mention the list of steps for collecting logs. Provide as much information as you can about what happened before the error, including tenant ID, and user principal name (UPN). |
| **CLIENT_CERT_INSTALL_ERROR** | There may be an issue with how the client certificate was installed or associated with your tenant. Follow the instructions in [Troubleshooting the MFA NPS extension](howto-mfa-nps-extension.md#troubleshooting) to investigate client cert problems. |
| **ESTS_TOKEN_ERROR** | Follow the instructions in [Troubleshooting the MFA NPS extension](howto-mfa-nps-extension.md#troubleshooting) to investigate client cert and security token problems. |
| **HTTPS_COMMUNICATION_ERROR** | The NPS server is unable to receive responses from Microsoft Entra multifactor authentication. Verify that your firewalls are open bidirectionally for traffic to and from `https://adnotifications.windowsazure.com` and that TLS 1.2 is enabled (default). If TLS 1.2 is disabled, user authentication fails and event ID 36871 with source SChannel is entered in the System log in Event Viewer. To verify TLS 1.2 is enabled, see [TLS registry settings](/windows-server/security/tls/tls-registry-settings#tls-dtls-and-ssl-protocol-version-settings). |
| **HTTP_CONNECT_ERROR** | On the server that runs the NPS extension, verify that you can reach `https://adnotifications.windowsazure.com` and `https://login.microsoftonline.com/`. If those sites don't load, troubleshoot connectivity on that server. |
| **NPS Extension for Microsoft Entra multifactor authentication (AccessReject):** <br> NPS Extension for Microsoft Entra multifactor authentication only performs Secondary Auth for Radius requests in AccessAccept State. Request received for User username with response state AccessReject, ignoring request. | This error usually reflects an authentication failure in AD or that the NPS server is unable to receive responses from Microsoft Entra ID. Verify that your firewalls are open bidirectionally for traffic to and from `https://adnotifications.windowsazure.com` and `https://login.microsoftonline.com` using ports 80 and 443. It's also important to check that on the DIAL-IN tab of Network Access Permissions, the setting is set to "control access through NPS Network Policy". This error can also trigger if the user isn't assigned a license. |
| **NPS Extension for Microsoft Entra multifactor authentication (AccessChallenge):** <br> NPS Extension for Microsoft Entra multifactor authentication only performs Secondary Auth for Radius requests in AccessAccept State. Request received for User username with response state AccessChallenge, ignoring request. | This response is used when additional information is required from the user to complete the authentication or authorization process. The NPS server sends a challenge to the user, requesting further credentials or information. It usually precedes an Access-Accept or Access-Reject response. |
| **REGISTRY_CONFIG_ERROR** | A key is missing in the registry for the application, which may be because the [PowerShell script](howto-mfa-nps-extension.md#install-the-nps-extension) wasn't run after installation. The error message should include the missing key. Make sure you have the key under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AzureMfa. |
| **REQUEST_FORMAT_ERROR** <br> Radius Request missing mandatory Radius userName\Identifier attribute. Verify that NPS is receiving RADIUS requests | This error usually reflects an installation issue. The NPS extension must be installed in NPS servers that can receive RADIUS requests. NPS servers that are installed as dependencies for services like RDG and RRAS don't receive radius requests. NPS Extension doesn't work when installed over such installations and errors out since it can't read the details from the authentication request. |
| **REQUEST_MISSING_CODE** | Make sure that the password encryption protocol between the NPS and NAS servers supports the secondary authentication method that you're using. **PAP** supports all the authentication methods of Microsoft Entra multifactor authentication in the cloud: phone call, one-way text message, mobile app notification, and mobile app verification code. **CHAPV2** and **EAP** support phone call and mobile app notification. |
| **USERNAME_CANONICALIZATION_ERROR** | Verify that the user is present in your on-premises Active Directory instance, and that the NPS Service has permissions to access the directory. If you use forest trusts, [contact support](#contact-microsoft-support) for further help. |
| **Challenge requested in Authentication Ext for User** | Organizations using a RADIUS protocol other than PAP see user VPN authorization failing with these events appearing in the AuthZOptCh event log of the NPS Extension server. You can configure the NPS Server to support PAP. If PAP isn't an option, you can set OVERRIDE_NUMBER_MATCHING_WITH_OTP = FALSE to fall back to Approve/Deny push notifications. For further help, please check [Number matching using NPS Extension](how-to-mfa-number-match.md#nps-extension). |

### Alternate login ID errors

| Error code | Error message | Troubleshooting steps |
| ---------- | ------------- | --------------------- |
| **ALTERNATE_LOGIN_ID_ERROR** | Error: userObjectSid lookup failed | Verify that the user exists in your on-premises Active Directory instance. If you use forest trusts, [contact support](#contact-microsoft-support) for further help. |
| **ALTERNATE_LOGIN_ID_ERROR** | Error: Alternate LoginId lookup failed | Verify that LDAP_ALTERNATE_LOGINID_ATTRIBUTE is set to a [valid active directory attribute](/windows/win32/adschema/attributes-all). <br><br> If LDAP_FORCE_GLOBAL_CATALOG is set to True, or LDAP_LOOKUP_FORESTS is configured with a non-empty value, verify that you have configured a Global Catalog and that the AlternateLoginId attribute is added to it. <br><br> If LDAP_LOOKUP_FORESTS is configured with a non-empty value, verify that the value is correct. If there is more than one forest name, the names must be separated with semi-colons, not spaces. <br><br> If these steps don't fix the problem, [contact support](#contact-microsoft-support) for more help. |
| **ALTERNATE_LOGIN_ID_ERROR** | Error: Alternate LoginId value is empty | Verify that the AlternateLoginId attribute is configured for the user. |

## Errors your users may encounter

| Error code | Error message | Troubleshooting steps |
| ---------- | ------------- | --------------------- |
| **AccessDenied** | Caller tenant doesn't have access permissions to do authentication for the user | Check whether the tenant domain and the domain of the user principal name (UPN) are the same. For example, make sure that user@contoso.com is trying to authenticate to the Contoso tenant. The UPN represents a valid user for the tenant in Azure. |
| **AuthenticationMethodNotConfigured** | The specified authentication method was not configured for the user | Have the user add or verify their verification methods according to the instructions in [Manage your settings for two-step verification](https://support.microsoft.com/account-billing/change-your-two-step-verification-method-and-settings-c801d5ad-e0fc-4711-94d5-33ad5d4630f7). |
| **AuthenticationMethodNotSupported** | Specified authentication method isn't supported. | Collect all your logs that include this error, and [contact support](#contact-microsoft-support). When you contact support, provide the username and the secondary verification method that triggered the error. |
| **BecAccessDenied** | MSODS Bec call returned access denied, probably the username isn't defined in the tenant | The user is present in Active Directory on-premises but isn't synced into Microsoft Entra ID by AD Connect. Or, the user is missing for the tenant. Add the user to Microsoft Entra ID and have them add their verification methods according to the instructions in [Manage your settings for two-step verification](https://support.microsoft.com/account-billing/change-your-two-step-verification-method-and-settings-c801d5ad-e0fc-4711-94d5-33ad5d4630f7). |
| **InvalidFormat** or **StrongAuthenticationServiceInvalidParameter** | The phone number is in an unrecognizable format | Have the user correct their verification phone numbers. |
| **InvalidSession** | The specified session is invalid or may have expired | The session has taken more than three minutes to complete. Verify that the user is entering the verification code, or responding to the app notification, within three minutes of initiating the authentication request. If that doesn't fix the problem, check that there are no network latencies between client, NAS Server, NPS Server, and the Microsoft Entra multifactor authentication endpoint.  |
| **NoDefaultAuthenticationMethodIsConfigured** | No default authentication method was configured for the user | Have the user add or verify their verification methods according to the instructions in [Manage your settings for two-step verification](https://support.microsoft.com/account-billing/change-your-two-step-verification-method-and-settings-c801d5ad-e0fc-4711-94d5-33ad5d4630f7). Verify that the user has chosen a default authentication method, and configured that method for their account. |
| **OathCodePinIncorrect** | Wrong code and pin entered. | This error isn't expected in the NPS extension. If your user encounters this, [contact support](#contact-microsoft-support) for troubleshooting help. |
| **ProofDataNotFound** | Proof data was not configured for the specified authentication method. | Have the user try a different verification method, or add a new verification method according to the instructions in [Manage your settings for two-step verification](https://support.microsoft.com/account-billing/change-your-two-step-verification-method-and-settings-c801d5ad-e0fc-4711-94d5-33ad5d4630f7). If the user continues to see this error after you confirmed that their verification method is set up correctly, [contact support](#contact-microsoft-support). |
| **SMSAuthFailedWrongCodePinEntered** | Wrong code and pin entered. (OneWaySMS) | This error isn't expected in the NPS extension. If your user encounters this, [contact support](#contact-microsoft-support) for troubleshooting help. |
| **TenantIsBlocked** | Tenant is blocked | [Contact support](#contact-microsoft-support) with the *Tenant ID* from the Microsoft Entra properties page in the Microsoft Entra admin center. |
| **UserNotFound** | The specified user was not found | The tenant is no longer visible as active in Microsoft Entra ID. Check that your subscription is active and you have the required first party apps. Also make sure the tenant in the certificate subject is as expected and the cert is still valid and registered under the service principal. |

## Messages your users may encounter that aren't errors

Sometimes, your users may get messages from multifactor authentication because their authentication request failed. These aren't errors in the product of configuration, but are intentional warnings explaining why an authentication request was denied.

| Error code | Error message | Recommended steps |
| ---------- | ------------- | ----------------- |
| **OathCodeIncorrect** | Wrong code entered\OATH Code Incorrect | The user entered the wrong code. Have them try again by requesting a new code or signing in again. |
| **SMSAuthFailedMaxAllowedCodeRetryReached** | Maximum allowed code retry reached | The user failed the verification challenge too many times. Depending on your settings, they may need to be unblocked by an admin now.  |
| **SMSAuthFailedWrongCodeEntered** | Wrong code entered/Text Message OTP Incorrect | The user entered the wrong code. Have them try again by requesting a new code or signing in again. |
| **AuthenticationThrottled** | Too many attempts by user in a short period of time. Throttling. | Microsoft may limit repeated authentication attempts that are performed by the same user in a short period of time. This limitation doesn't apply to the Microsoft Authenticator or verification code. If you have hit these limits, you can use the Authenticator App, verification code or try to sign in again in a few minutes. |
| **AuthenticationMethodLimitReached** | Authentication Method Limit Reached. Throttling. | Microsoft may limit repeated authentication attempts that are performed by the same user using the same authentication method type in a short period of time, specifically Voice call or SMS. This limitation doesn't apply to the Microsoft Authenticator or verification code. If you have hit these limits, you can use the Authenticator App, verification code or try to sign in again in a few minutes.|

## Errors that require support

If you encounter one of these errors, we recommend that you [contact support](#contact-microsoft-support) for diagnostic help. There's no standard set of steps that can address these errors. When you do contact support, be sure to include as much information as possible about the steps that led to an error, and your tenant information.

| Error code | Error message |
| ---------- | ------------- |
| **InvalidParameter** | Request must not be null |
| **InvalidParameter** | ObjectId must not be null or empty for ReplicationScope:{0} |
| **InvalidParameter** | The length of CompanyName \{0}\ is longer than the maximum allowed length {1} |
| **InvalidParameter** | UserPrincipalName must not be null or empty |
| **InvalidParameter** | The provided TenantId isn't in correct format |
| **InvalidParameter** | SessionId must not be null or empty |
| **InvalidParameter** | Could not resolve any ProofData from request or Msods. The ProofData is unKnown |
| **InternalError** |  |
| **OathCodePinIncorrect** |  |
| **VersionNotSupported** |  |
| **MFAPinNotSetup** |  |

## Next steps

### Troubleshoot user accounts

If your users are [Having trouble with two-step verification](https://support.microsoft.com/account-billing/common-problems-with-two-step-verification-for-a-work-or-school-account-63acbb9b-16a1-47b9-8619-6a865e8071a5), help them self-diagnose problems.

### Health check script

The [Microsoft Entra multifactor authentication NPS Extension health check script](https://github.com/Azure-Samples/azure-mfa-nps-extension-health-check) performs several basic health checks when troubleshooting the NPS extension. Here's a quick summary about each available option when the script is run:
- Option **1** - to isolate the cause of the issue: if it's an NPS or MFA issue (Export MFA RegKeys, Restart NPS, Test, Import RegKeys, Restart NPS)
- Option **2** - to check a full set of tests, when not all users can use the MFA NPS Extension (Testing Access to Azure/Create HTML Report)
- Option **3** - to check a specific set of tests, when a specific user can't use the MFA NPS Extension (Test MFA for specific UPN)
- Option **4** - to collect logs to contact Microsoft support (Enable Logging/Restart NPS/Gather Logs)

### Contact Microsoft support

If you need additional help, contact a support professional through [MFA support](https://support.microsoft.com/oas/default.aspx?prid=14947). When contacting us, it's helpful if you can include as much information about your issue as possible. Information you can supply includes the page where you saw the error, the specific error code, the specific session ID, the ID of the user who saw the error, and debug logs.

To collect debug logs for support diagnostics, run the [Microsoft Entra multifactor authentication NPS Extension health check script](https://github.com/Azure-Samples/azure-mfa-nps-extension-health-check) on the NPS server and choose option **4** to collect the logs to provide them to Microsoft support.

At the end, upload the zip output file generated on the C:\NPS folder and attach it to the support case.
