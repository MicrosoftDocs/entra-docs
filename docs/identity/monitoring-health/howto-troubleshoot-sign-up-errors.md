---
title: How to troubleshoot sign-up errors
description: Learn how to troubleshoot sign-up errors using Microsoft Entra reports in the Microsoft Entra admin center
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: troubleshooting
ms.subservice: monitoring-health
ms.date: 06/30/2025
ms.author: sarahlipsey

# Customer intent: As an IT admin, I want to learn how to troubleshoot sign-up errors for various scenarios and using different tools so that I can resolve sign-up issues quickly.

---

# How to troubleshoot Microsoft Entra sign-up errors

[!INCLUDE [applies-to-external-only](../../includes/applies-to-external-only.md)]

Microsoft Entra sign-up logs help you troubleshoot sign-up failures for users of applications in your external tenant. This article describes how to isolate sign-up failures and understand the root causes.

### Sign-up error codes

To research information about specific sign-up error codes, you can use the following tools:

- Enter the error code into the **[Error code lookup tool](https://login.microsoftonline.com/error)** to get the error code description and remediation information.

- Search for an error code in the **[authentication and authorization error codes reference](../../identity-platform/reference-error-codes.md)**.

The following error codes are associated with sign-up events, but this list isn't exhaustive:

- **50181**: Unable to validate the OTP.
  - This error code appears when the one-time passcode the user is trying to enter can't be validated.
  - The user should request a new one-time passcode.

- **50182**: OTP is already expired.
  - This error code appears when the one-time passcode the user is trying to enter is expired.
  - The user should request a new one-time passcode.

- **1002027**: Some of the collected attributes were invalid.
  - One or more attributes entered by the user during sign-up weren't in a valid format.
  - The user should reenter the attributes.

- **399279**: User creation failed during self-service sign-up.
  - The user's account couldn't be created.
  - The user should retry the sign-up process.

The following codes are not actual errors. They indicate expected interruptions that occur due to the interactive nature of the sign-up process.

- **1002013**: User is prompted to enter Email One-Time-Passcode to verify ownership of email address.
  - This is an expected part of the signup flow, where a user is prompted to enter the one-time-passcode emailed to them to verify ownership of email address.

- **50140**: User is prompted with option to 'Keep me signed in' during the sign-in following sign-up.
  - This is an expected part of the sign-in flow, where a user is asked if they want to remain signed into this browser to make further sign-ins easier.

If an issue persists despite taking the recommended course of action, open a support request. For more information, see [how to get support for Microsoft Entra ID](~/fundamentals/how-to-get-support.md).

## Next steps

- [Sign-ins error codes reference](./concept-sign-ins.md)
- [Sign-ins report overview](concept-sign-ins.md)
- [How to use the Sign-in diagnostics](howto-use-sign-in-diagnostics.md)
