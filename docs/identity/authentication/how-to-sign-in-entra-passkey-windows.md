---
title: Sign in with a Microsoft Entra passkey on Windows
description: Learn how to sign in with a Microsoft Entra passkey on Windows by using Windows Hello as a FIDO2 passkey provider for phishing-resistant authentication.
ms.topic: how-to
ms.date: 07/05/2026
ms.reviewer: kimhana
ms.collection: M365-identity-device-management
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1013
# Customer intent: As a user, I want to sign in with a Microsoft Entra passkey on Windows so I can use phishing-resistant authentication on my Windows device.
---
# Sign in with a Microsoft Entra passkey on Windows (preview)

This article covers how to sign in to Microsoft Entra ID with a Microsoft Entra passkey on Windows. A Microsoft Entra passkey on Windows is a device-bound passkey stored in the local Windows Hello container. For an overview of Microsoft Entra passkey on Windows and how it compares with Windows Hello for Business, see [Microsoft Entra passkey on Windows](how-to-authentication-entra-passkeys-on-windows.md).

## Sign in with a passkey on Windows

To sign in with a passkey on Windows, follow these steps:

1. Open your browser and go to the resource you're trying to access, such as [Office](https://www.office.com).

1. You can enter your username to sign in. If you most recently used a passkey to sign in, you're automatically prompted to sign in with a passkey. Otherwise, select **Other ways to sign in**, and then select **Face, fingerprint, PIN, or security key**.

   Alternatively, select **Sign-in options** to sign in without entering a username. If you chose **Sign-in options**, select **Face, fingerprint, PIN, or security key**. Otherwise, skip to the next step.

1. Your device opens a Windows Security dialog. Verify your identity by using Windows Hello (fingerprint, facial recognition, or PIN).

After verification, you're signed in to Microsoft Entra ID.

## Related content

- [Register a Microsoft Entra passkey on Windows](how-to-register-entra-passkey-windows.md)
- [Microsoft Entra passkey on Windows](how-to-authentication-entra-passkeys-on-windows.md)
- [Enable passkeys (FIDO2) in Microsoft Entra ID](how-to-authentication-passkeys-fido2.md)
- [Support for FIDO2 authentication with Microsoft Entra ID](concept-fido2-compatibility.md)
