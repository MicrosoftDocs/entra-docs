---
title: How to troubleshoot sign-up errors
description: Learn how to troubleshoot sign-up errors using Microsoft Entra reports in the Microsoft Entra admin center
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: troubleshooting
ms.subservice: monitoring-health
ms.date: 10/28/2024
ms.author: sarahlipsey

# Customer intent: As an IT admin, I want to learn how to troubleshoot sign-up errors for various scenarios and using different tools so that I can resolve sign-up issues quickly.

---

# How to troubleshoot Microsoft Entra sign-up errors

Microsoft Entra sign-up logs help you troubleshoot sign-up failures for users of applications in your external tenant. This article describes how to isolate sign-up failures and understand the root causes.

### Sign-up error codes

To research information about specific sign-up error codes, you can use the following tools:

- Enter the error code into the **[Error code lookup tool](https://login.microsoftonline.com/error)** to get the error code description and remediation information.

===> UPDATE?:
- Search for an error code in the **[authentication and authorization error codes reference](../../identity-platform/reference-error-codes.md)**.

The following error codes are associated with sign-up events, but this list isn't exhaustive:

===> UPDATE THIS LIST:

- **50058**: User is authenticated but not yet signed in.
  - This error code appears for sign-in attempts when the user didn't complete the sign-in process.
  - Because the user didn't sign-in completely, the User field might display an Object ID or a globally unique identifier (GUID) instead of a username.
  - In some of these situations, the User ID shows up like "00000000-0000-0000".

- **90025**: An internal Microsoft Entra service hit its retry allowance to sign the user in.
  - This error often happens without the user noticing and is usually resolved automatically.
  - If it persists, have the user sign in again.

- **500121**: User didn't complete the MFA prompt.
  - This error often appears if the user hasn't completed setting up MFA.
  - Instruct the user to complete the setup process through to sign-in.

If all else fails, or the issue persists despite taking the recommended course of action, open a support request. For more information, see [how to get support for Microsoft Entra ID](~/fundamentals/how-to-get-support.md).

## Next steps

- [Sign-ins error codes reference](./concept-sign-ins.md)
- [Sign-ins report overview](concept-sign-ins.md)
- [How to use the Sign-in diagnostics](howto-use-sign-in-diagnostics.md)
