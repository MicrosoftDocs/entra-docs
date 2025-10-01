---
title: Supported Device Authentication for Users Transferred Using Source of Authority (SOA) 
description: This article lists authentication methods  for users using Microsoft Entra joined-devices, and information on if it supports users transferred using Source of Authority.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: 08/19/2025
ms.reviewer: dhanyak

#CustomerIntent: As an IT administrator, I want to learn about what authentication methods are supported for SOA transferred users so that I am informed about options when transferring user's source of authority.
---

# Device Authentication for Users Transferred Using Source of Authority (SOA) 

Device authentication is a critical component for organizations managing hybrid and cloud environments. This article provides an overview of supported authentication methods for users in Microsoft Entra joined and hybrid joined devices who have transferred their Source of Authority (SOA). It outlines the compatibility of password-based and passwordless sign-in methods, such as Windows Hello for Business and FIDO2 keys, across various trust configurations. If you have requirements to access on-premises resources tied to Active Directory, we recommend that you switch to cloud authentication first (PTA, PHS, native cloud authentication like certificates, passkeys, or password hashes) or go passwordless. 

## Hybrid Joined Devices

The following sections contain information that shows the currently supported authentication methods for SOA transferred users authenticating through [Hybrid Joined Devices](../../identity/devices/concept-hybrid-join.md).

### [Hybrid Joined Devices Password based sign-in](#tab/Hybrid)

Using Hybrid Joined Devices, no password-based sign-ins are supported for SOA transferred users.

#### Hybrid Joined Windows Hello for Business and FIDO2 Sign-in

Support for passwordless authentication methods like Windows Hello for Business, or FIDO2 keys, using Hybrid Joined Devices are as follows:

#### [Hybrid Joined Certificate or Key Trust Certificates](#tab/Certificate)

Not Supported.

---

#### Hybrid Joined Cloud Trust or no Trust Type

##### [Hybrid Joined Legacy Kerberos Legacy-Kerberos](#tab/HybridJoinedLegacyKerberos)

- **Apps with App Proxy**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory.
- **Apps with Entra Private Access**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory.

##### [Hybrid Joined Microsoft Entra Kerberos Entra-Kerberos](#tab/HybridJoinedEntraKerberos)

- **Azure Files**: Supported.
- **On-premises SSO**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory.
- **Apps with App Proxy**: Not Supported.
- **Apps with Entra Private Access**: Not Supported.

---

## Microsoft Entra Joined Devices

The following sections contain information that shows the currently supported authentication methods for SOA transferred users authenticating through [Microsoft Entra Joined Devices](../../identity/devices/concept-directory-join.md).

### [Microsoft Entra Joined Devices Password based sign-in](#tab/MicrosoftEntraJoinedDevicesPasswordbasedsignin)

Using Entra Joined Devices, no password-based sign-ins are supported for SOA transferred users.


#### Microsoft Entra Joined Devices Windows Hello for Business and FIDO2 Sign-in

Support for passwordless authentication methods like Windows Hello for Business, or FIDO2 keys, using Microsoft Entra Joined Devices are as follows:

#### [Microsoft Entra Joined Devices Certificate or Key Trust Certificates](#tab/MicrosoftEntraJoinedDevicesCertificateorKeyTrust)

Not Supported.

---

#### Microsoft Entra Joined Devices Cloud Trust or no Trust Type

##### [Microsoft Entra Joined Devices Legacy Kerberos Legacy-Kerberos](#tab/MicrosoftEntraJoinedDevicesLegacyKerberosLegacy-Kerberos)

- **Apps with App Proxy**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory
- **Apps with Entra Private Access**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory

##### [Microsoft Entra Joined Devices Microsoft Entra Kerberos Entra-Kerberos](#tab/MicrosoftEntraJoinedDevicesMicrosoftEntraKerberosEntraKerberos)

- **Azure Files**: Supported
- **On-premises SSO**: Supported as long as authentication user attributes are synced between Microsoft Entra ID and Active Directory
- **Apps with App Proxy**: Not Supported.
- **Apps with Entra Private Access**: Not Supported.

---

## Related content

- [Prepare Your environment for User SOA](prepare-user-source-of-authority-environment.md)
