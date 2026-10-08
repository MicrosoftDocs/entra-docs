---
title: Register a Microsoft Entra passkey on Windows
description: Learn how to register a Microsoft Entra passkey on Windows by using Windows Hello as a FIDO2 passkey provider for phishing-resistant sign-in.
ms.topic: how-to
ms.date: 07/05/2026
ms.reviewer: kimhana
ms.collection: M365-identity-device-management
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1013
# Customer intent: As a user, I want to register a Microsoft Entra passkey on Windows so I can use phishing-resistant authentication on my Windows device.
---
# Register a Microsoft Entra passkey on Windows

This article shows how to register a Microsoft Entra passkey on Windows. A Microsoft Entra passkey on Windows is a device-bound passkey stored in the local Windows Hello container. Unlike synced passkeys, a passkey on Windows doesn't sync across devices — each device requires a separate passkey registration. This approach enables phishing-resistant sign-in with a Windows Hello biometric or PIN, without requiring the device to be Microsoft Entra joined or registered.

For an overview of Microsoft Entra passkey on Windows and how it compares with Windows Hello for Business, see [Microsoft Entra passkey on Windows](how-to-authentication-entra-passkeys-on-windows.md).

## Prerequisites

Confirm these requirements before you register:

- Your administrator enabled passkeys (FIDO2) and created a passkey profile that allows Windows Hello AAGUIDs. For configuration steps, see [Configure a profile for Microsoft Entra passkey on Windows](how-to-authentication-entra-passkeys-on-windows.md#configure-a-profile-for-microsoft-entra-passkey-on-windows).
- The device runs a supported version of Windows.
- Attestation must not be enforced in the passkey profile.

For the list of supported Windows Hello passkey AAGUIDs, see [Supported Windows Hello passkey AAGUIDs](how-to-authentication-entra-passkeys-on-windows.md#supported-windows-hello-passkey-aaguids).

## Register a passkey on Windows

To register a passkey on your Windows device, follow these steps:

1. Open a web browser and sign in to [Security info](https://mysignins.microsoft.com/security-info).
1. Sign in with multifactor authentication (MFA).
1. Tap **Add sign-in method** > **Choose a method** > **Passkey**.
1. Tap **Next**.

1. Select where you want to save your passkey (FIDO2). 

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys (FIDO2), you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey. 

   :::image type="content" border="true" source="media/how-to-register-passkey-with-security-key/choose-where-store-passkey.png" alt-text="Screenshot of the dialog where to save your passkey (FIDO2) in My Security info.":::

After verification, Windows creates the passkey and stores it in the local Windows Hello container. You can now use this passkey to sign in to Microsoft Entra ID.

> [!NOTE]
> If a Windows Hello for Business credential already exists for the same account, passkey registration might fail. For more information, see [Microsoft Entra passkey on Windows](how-to-authentication-entra-passkeys-on-windows.md#faq).

## Related content

- [Sign in with a Microsoft Entra passkey on Windows](how-to-sign-in-entra-passkey-windows.md)
- [Microsoft Entra passkey on Windows](how-to-authentication-entra-passkeys-on-windows.md)
- [Enable passkeys (FIDO2) in Microsoft Entra ID](how-to-authentication-passkeys-fido2.md)
- [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md)
