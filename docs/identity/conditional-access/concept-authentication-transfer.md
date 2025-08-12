---
title: Authentication transfer as a condition to secure mobile users
description: Learn how authentication transfer can connect users to apps across desktop and mobile devices.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: article
ms.date: 03/05/2024
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: anjusingh, ludwignick
---
# Conditional Access: Authentication transfer (Preview)

Authentication Transfer is a new authentication flow that simplifies the cross-device sign-in from PC to mobile for Microsoft apps. Authentication transfer allows you to transfer an authentication from one device to another, like desktop to mobile. Authentication transfer increases user engagement by connecting them on more than one platform. Users can use a QR code in an authenticated app on their PC to sign-in to a mobile app.

:::image type="content" source="media/concept-authentication-transfer/authentication-transfer-in-policy-example.png" alt-text="Screenshot of an example Conditional Access policy using authentication with a block control." lightbox="media/concept-authentication-transfer/authentication-transfer-in-policy-example.png":::

## Authentication transfer and Conditional Access

During authentication transfer, all Microsoft Entra Conditional Access policies get evaluated. Authentication transfer only transfers authentication claims it doesn't transfer device related claims.

- With authentication transfer, if users perform multifactor authentication (MFA) on their PC, they aren't required to perform MFA on their mobile device.
- With authentication transfer, Conditional Access policies get evaluated before transferring the authentication. If a policy isn't met for the mobile device, the user is prompted to sign in manually.
   - Authentication Transfer bypasses 3rd party mobile device management (MDM) solutions when transferring authentication to mobile devices. 
- With authentication transfer, users must reauthenticate on their PC even if they signed in with protected session tokens, like the Primary Refresh Token. They aren't required to reauthenticate on mobile apps.

## Authentication transfer in sign-in logs

Administrators can check the sign-in logs to see if their users are using authentication transfer to sign-in. Usage of authentication transfer appears under **Authentication Details** in the Microsoft Entra Sign-in logs. Administrators see events back to back, with the first being a QR code as the authentication method.

## Manage authentication transfer for specific users and apps

Authentication transfer is enabled by default for all users. Administrators can manage authentication transfer using Conditional Access policies and the condition [authentication flows](concept-authentication-flows.md). This condition can restrict authentication transfer use to specific users, apps, or to turn off the functionality. 

Authentication transfer checks all applicable Conditional Access policies before signing the user into a mobile app. If the required conditions aren't met, the user is prompted to authenticate on the mobile app.

To create a policy that uses the authentication transfer condition, see the article [Block authentication transfer with Conditional Access policy](policy-block-authentication-flows.md#authentication-transfer-policies).

## Related content

- [Block authentication transfer with Conditional Access policy](policy-block-authentication-flows.md#authentication-transfer-policies)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
