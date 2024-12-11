---
title: What are Microsoft Entra registered devices?
description: Learn how Microsoft Entra registered devices provide your users with support for bring your own device (BYOD) or mobile device scenarios.

ms.service: entra-id
ms.subservice: devices
ms.topic: conceptual
ms.date: 02/26/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: sandeo
---

# Microsoft Entra registered devices

The goal of Microsoft Entra registered - also known as Workplace joined - devices is to provide your users with support for bring your own device (BYOD) or mobile device scenarios. In these scenarios, a user can access your organization's resources using a personal device.

| Microsoft Entra registered | Description |
| --- | --- |
| **Definition** | Registered to Microsoft Entra ID without requiring organizational account to sign in to the device |
| **Primary audience** | Applicable to all users with the following criteria: <ul><li>Bring your own device</li><li>Mobile devices</li></ul>|
| **Device ownership** | User or Organization |
| **Operating Systems** | <li>Windows 10 or newer</li><li>macOS 10.15 or newer</li><li>iOS 15 or newer<li>Android</li><li>Linux editions:<ul><li>Ubuntu 20.04/22.04 LTS</li><li>Red Hat Enterprise Linux 8/9 LTS</li></ul></li> |
| **Provisioning** | <li>Windows 10 or newer – Settings</li><li>iOS/Android – Company Portal or Microsoft Authenticator app</li><li>macOS – Company Portal</li><li>Linux - Intune Agent</li> |
| **Device sign in options** | <li>End-user local credentials</li><li>Password</li><li>Windows Hello</li><li>PIN</li><li>Biometrics or pattern for other devices</li> |
| **Device management** | <li>Mobile Device Management (example: Microsoft Intune)</li><li>Mobile Application Management</li> |
| **Key capabilities** | <li>Single sign-on (SSO) to cloud resources</li><li>Conditional Access when enrolled into Intune</li><li>Conditional Access via App protection policy</li><li>Enables Phone sign in with Microsoft Authenticator app</li> |

![Microsoft Entra registered devices](./media/concept-device-registration/azure-ad-registered-device.png)

Microsoft Entra registered devices are signed in to using a local account like a Microsoft account on a Windows 10 or newer device. These devices have a Microsoft Entra account for access to organizational resources. Access to resources in the organization can be limited based on that Microsoft Entra account and Conditional Access policies applied to the device identity.

Microsoft Entra Registration isn't the same as device enrollment. If Administrators permit users to enroll their devices, organizations can further control these Microsoft Entra registered devices by enrolling them into Mobile Device Management (MDM) tools like Microsoft Intune. MDM provides a means to enforce organization-required configurations like requiring storage to be encrypted, password complexity, and security software kept updated.

Microsoft Entra registration can be accomplished when accessing a work application for the first time or manually using the Windows 10 or Windows 11 Settings menu.

## Scenarios

A user in your organization wants to access your benefits enrollment tool from their home PC. Your organization requires that anyone accesses this tool from an Intune compliant device. The user registers their home PC with Microsoft Entra ID and Enrolls the device in Intune, then the required Intune policies are enforced giving the user access to their resources.

Another user wants to access their organizational email on their personal Android phone that is rooted. Your company requires a compliant device and has an Intune device compliance policy to block any rooted devices. The employee is stopped from accessing organizational resources on this device.

## Related content

- [Manage device identities](manage-device-identities.md)
- [Manage stale devices in Microsoft Entra ID](manage-stale-devices.md)
- [Register your personal device on your work or school network](https://support.microsoft.com/account-billing/register-your-personal-device-on-your-work-or-school-network-8803dd61-a613-45e3-ae6c-bd1ab25bf8a8)
