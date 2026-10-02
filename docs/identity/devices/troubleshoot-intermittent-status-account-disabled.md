---
title: Troubleshoot STATUS_ACCOUNT_DISABLED in Microsoft Entra
description: Learn how to diagnose intermittent STATUS_ACCOUNT_DISABLED errors on Microsoft Entra hybrid joined Windows devices and restore user sign-in.
ms.topic: troubleshooting
ms.date: 09/01/2026
ms.reviewer: mozmaili
ms.custom: has-adal-ref, sfi-ropc-nochange, sfi-image-nochange, msecd-doc-authoring-1018
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to diagnose intermittent STATUS_ACCOUNT_DISABLED errors on Microsoft Entra hybrid joined devices so that users can restore access and I can understand the underlying cause.
---
# Troubleshoot intermittent STATUS_ACCOUNT_DISABLED errors on Microsoft Entra hybrid joined devices

This article provides troubleshooting guidance to help you resolve potential issues with Windows devices that are Microsoft Entra hybrid joined and receive intermittent STATUS_ACCOUNT_DISABLED errors when users attempt to sign in or unlock the device.

## Symptoms

In a Microsoft Entra hybrid joined environment, you might occasionally receive the error message STATUS_ACCOUNT_DISABLED ('The user is disabled') when attempting to sign in or unlock the device.

However, the user account in question is not disabled.

The issue typically self-resolves after waiting a few minutes and trying to unlock again, or rebooting, or signing out completely and signing back in instead of trying to unlock.

In addition, you see the following events in the event log:

```text
Log:  Microsoft-Windows-AAD/Operational
Event ID 1081
Level: Error

OAuth response error: invalid_grant
Error description: AADSTS50034: The user account {user} does not exist in the
{guid} directory. To sign into this application, the account
must be added to the directory.
```

```text
Log:  Microsoft-Windows-Hello-for-Business/Operational
Event ID 7001

A user failed to sign into the device with the following information:
Username: SYSTEM  User SID: S-1-5-18
Credential Type: Software Key  Deployment Type: Cloud Trust
Software Lockout Counter: 0
Authentication Error Status: 0xC000006D  Authentication Error Substatus: 0xC0000072

 0xC000006D / 0xC0000072  = STATUS_LOGON_FAILURE / STATUS_ACCOUNT_DISABLED.
```

The issue does not occur in Entra-native deployments.

## Cause

Microsoft Entra hybrid join caches some user data locally on the Windows client. Events such as primary refresh token (PRT) expiration and VSM session key rollover can make this cache stale. Rebuilding the cache requires communication with the on-premises Active Directory domain controller. That communication can fail when:

- The computer recently resumed from hibernation.
- The computer recently resumed from a deep sleep state.
- Virtual private network (VPN) or network adapter connectivity isn't ready when the client tries to communicate with the on-premises domain controller.
- The VPN requires a user to sign in before it connects, such as when using a user VPN instead of a device VPN.

When this communication fails, the Windows client sends Microsoft Entra ID the user's Security Account Manager (SAM) account name instead of the full user principal name (UPN). Microsoft Entra ID doesn't recognize a SAM account name without the domain, so the sign-in attempt fails. The Windows client then maps Microsoft Entra error AADSTS50034 (user not found) to STATUS_ACCOUNT_DISABLED, which can cause confusion.

Although Microsoft may improve this behavior in future updates, it is currently viewed as by design. Microsoft recommends all future deployments be Entra-native, where this problem doesn't exist.

<a name='resources'></a>

## Related content

[Windows Hello for Business cloud Kerberos trust FAQ](/windows/security/identity-protection/hello-for-business/faq#do-i-need-line-of-sight-to-a-domain-controller-to-use-windows-hello-for-business-cloud-kerberos-trust)

[Troubleshoot Microsoft Entra hybrid joined devices](troubleshoot-hybrid-join-windows-current.md)

[What is a Microsoft Entra hybrid joined device?](concept-hybrid-join.md)
