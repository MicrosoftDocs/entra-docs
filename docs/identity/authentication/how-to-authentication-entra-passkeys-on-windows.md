---
title: Enable Microsoft Entra passkeys on Windows devices (preview)
description: Explains Microsoft Entra passkeys on Windows devices and how admins can enable them for work or school accounts for phishing-resistant multifactor authentication.
#customer intent: As an administrator, I want to enable Microsoft Entra passkeys can users with work and school accouts can sign in by using phishing-resistant multifactor authentication.
author: hanki77
ms.author: justinha
ms.date: 02/18/2026
ms.topic: how-to
ms.service: entra-id
ms.subservice: authentication
ms.collection: msec-ai-copilot
---

# Microsoft Entra Passkeys on Windows (Preview)

This article describes **Microsoft Entra passkeys on Windows** in public preview. It covers how Microsoft Entra passkeys on Windows work, how they differ from Windows Hello for Business, and how to configure passkey profiles to allow Windows Hello as a passkey provider.

**Microsoft Entra passkeys on Windows** are currently in public preview and require opt‑in. You need to explicitly configure Microsoft Entra passkeys on Windows to enable the preview of passkey registration in Windows Hello.

## Overview

**Microsoft Entra passkeys on Windows** allow users to register **passkeys (FIDO2)** directly into their device's local **Windows Hello** container and use them to sign in to Microsoft Entra ID. Microsoft Entra passkeys on Windows enable phishing-resistant sign‑in by using a Windows Hello biometric or PIN without requiring the device to be Microsoft Entra joined or registered.

By using Microsoft Entra passkeys on Windows:

- Users can register **passkeys (FIDO2)** in the local Windows Hello container.
- Devices **don't need to be joined or registered to Microsoft Entra** to use a local Windows passkey.
- A single Windows PC can store **multiple passkeys** for **multiple Microsoft Entra accounts**.
- Passkeys (FIDO2) registered in Windows Hello participate in **Microsoft Entra passkey (FIDO2) policies** and **passkey profiles**.

## How Microsoft Entra passkeys on Windows work

Windows Hello acts as a **secure local credential container** on Windows devices. The container is protected by user‑presence verification such as:

- PIN
- Fingerprint
- Facial recognition

Microsoft Entra passkeys on Windows allow **passkeys (FIDO2)** to be created and stored inside this Windows Hello container and used for authentication to Microsoft Entra ID.

This behavior is also applicable when the device is governed by **Windows Hello for Business policies configured through Microsoft Intune**. However, **passkeys (FIDO2) are distinct from the Windows Hello for Business credentials** that may be automatically registered during device registration to Microsoft Entra ID.

## Supported Windows Hello passkey authenticators (AAGUIDs)

During public preview, Windows Hello passkeys are identified and controlled using the following **Authenticator Attestation GUIDs (AAGUIDs)**. These AAGUIDs must be explicitly allowed in a passkey profile to enable registration.

| Windows Hello authenticator | AAGUID |
|----|----|
| Windows Hello Hardware Authenticator | 08987058-cadc-4b81-b6e1-30de50dcbe96 |
| Windows Hello VBS Hardware Authenticator | 9ddd1817-af5a-4672-a2b9-3e3dd95000a9 |
| Windows Hello Software Authenticator | 6028b017-b1d4-4c02-b4b3-afcdafc96bb2 |

These AAGUIDs represent Windows Hello‑backed passkey providers and are used in **passkey profiles** to allow or block registration.

## How Microsoft Entra passkeys on Windows compare with Windows Hello for Business

Although both features use Windows Hello, **Microsoft Entra passkeys on Windows** and **Windows Hello for Business** have different purposes and behavior.

### Windows Hello for Business

- Windows Hello for Business credentials are **automatically provisioned** on some Microsoft Entra joined or registered devices during device registration.
- The credential is tied only to **the Microsoft Entra account used to register the device**.
- Windows Hello for Business credentials are **passkeys using a first‑party (1P) protocol**, but **not FIDO2 passkeys**.
- Windows Hello for Business enables **device sign‑in** using **facial recognition, fingerprint, or PIN** protected by Windows Hello.
- Windows Hello for Business provides **single sign‑on (SSO)** to Microsoft Entra–integrated resources after device sign‑in.
- Windows Hello for Business is primarily a **device‑bound sign‑in method** linked to device trust.
- Registration and authentication are **not** controlled by the **Entra Authentication Method's P*asskey (FIDO2) polic*y**.

### Microsoft Entra passkeys on Windows

- Entra passkeys on Windows are **FIDO2 passkeys**.
- They can be registered **without device join or registration**.
- Users can register **multiple passkeys** for **multiple Entra accounts** on the same device.
- Registration and authentication are controlled using **Entra Authentication Method's P*asskey (FIDO2) polic*y**.

In the majority of cases, if a user has Windows Hello for Business credential, Microsoft Entra prevents them from also registering a passkey (FIDO2) for the same account in the same Windows Hello container to avoid user confusion.

| Feature | Microsoft Entra passkey on Windows | Windows Hello for Business |
|---|---|---|
| Standard base | FIDO2 | First-party (1P) protocol |
| Registration | User-initiated, does not require device join or registration | Automatically provisioned on some Entra joined or registered devices during device registration |
| Device sign-in and single sign-on (SSO) | N/A | Enables device sign‑in and SSO to Microsoft Entra–integrated resources after device sign‑in |
| Passkey Type | Device-bound | Device-bound |
| Credential binding | Bound to the device and stored in the local Windows Hello container. Users can register multiple passkeys for multiple work or school accounts on the same device. | Primarily a device‑bound sign‑in method linked to device trust. The credential is tied only to the work or school account used to register the device. |
| Management | Microsoft Entra ID Authentication methods policy | Microsoft IntuneGroup Policy |

**Use cases**

**Use Windows Hello for Business when:**

- You manage **corporate owned, Entra joined or registered devices‑owned, Entra joined or registered devices**

- You want **automatic credential provisioning** during device onboarding

- You require tight coupling between **device identity and authentication**

- You rely on existing Windows Hello for Business lifecycle and policy controls

**Use Microsoft Entra passkeys on Windows when:**

- You want **passkeys (FIDO2) stored locally on Windows**

- Users sign in from **unregistered, personal, or shared devices**

- Users access **multiple Microsoft Entra accounts from a single PC**

- You want authentication governed by **passkey profiles**

- You need a **standards based**, **phishing-resistant sign-in method** without device join**‑based‑resistant**

> [!TIP]
> Many organizations use both approaches: Windows Hello for Business for managed devices, and Microsoft Entra passkeys on Windows to cover personal or unmanaged scenarios.

## Attestation support

**Attestation is not supported for Microsoft Entra passkeys on Windows during public preview.**

As a result:

- If **attestation enforcement** is enabled in a passkey profile **that allows Windows Hello AAGUIDs**, passkey registration attempts to Windows Hello **will fail**.

In the Authentication Methods Policy in the Microsoft Entra admin center, ensure that **Enforce attestation** is set to No for any passkey profile that includes Windows Hello AAGUIDs during public preview.

## How to configure passkeys on Windows

During public preview, Microsoft Entra passkeys on Windows require an Authentication Policy Administrator to **explicitly opt in**.

To enable registration, **all** of the following conditions must be met:

### Prerequisites

- Windows 10 or Windows 11

- Device must be capable of Windows Hello

### Required configuration

- You must \*\*explicitly\*\* include the Windows Hello AAGUIDs in an \*\*allow list\*\* in a **passkey profile**.

- **Attestation must not be enforced**.

- **Key restrictions must be enabled**.

:::image type="content" source="media/how-to-authentication-entra-passkeys-on-windows/passkey-profile.png" alt-text="Screenshot of the passkey profile configuration settings showing Windows Hello AAGUIDs configuration options.":::

>[!NOTE]
>During public preview, passkey registration in Windows Hello is blocked unless the Windows Hello AAGUIDs are explicitly allowed in a passkey profile. For General Availability, you won’t be required to explicitly allow Windows Hello AAGUIDs.

**FAQ**

**Question**: Do Microsoft Entra passkeys on Windows replace Windows Hello for Business?

**Answer**: No. Microsoft Entra passkeys on Windows don't replace Windows Hello for Business.

Windows Hello for Business remains the recommended solution for **corporate managed, Entra joined or registered devices**. Microsoft Entra passkeys on Windows complement Windows Hello for Business by enabling **passkeys (FIDO2)** on Windows in scenarios where devices are **not joined or registered**.**‑managed, Entra joined or registered devices**

**Question**: Is Microsoft Entra passkey synced?

**Answer**: No. Microsoft Entra passkeys on Windows are **device-bound** and stored in the local Windows Hello container. They **aren't synced** across devices. Each device requires a separate passkey registration for each work or school account.

## Related content

- [How to enable passkey (FIDO2) profiles in Microsoft Entra ID (preview)](how-to-authentication-passkey-profiles.md)
- [Microsoft Entra ID attestation for FIDO2 authenticators](concept-fido2-hardware-vendor.md)
