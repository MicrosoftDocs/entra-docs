---
title: Considerations for Remote Desktop Connections in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Remote desktop connection guidance to deploy passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/31/2025

ms.author: justinha
author: mepples21
manager: amycolannino
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---
# Considerations for Remote Desktop Connections in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

Organizations deploying phishing-resistant passwordless typically have a need for some of their personas to use remote desktop technology to facilitate productivity, security, or administration. The two basic use cases are:

- Initializing and authenticating a remote desktop connection session from a local client to a remote machine using phishing-resistant passwordless credentials
- Utilizing phishing-resistant passwordless credentials inside of an established remote desktop connection session

Review the specific considerations for each use case.

# [Passwordless Remote Desktop Connection Session Initiation](#tab/rdp-session-auth)

## Remote Desktop connection components

Windows remote desktop protocol involves three primary components, all of which need to properly support phishing-resistant passwordless credentials for initiating a remote desktop connection session using these credentials. If any of these components isn't able to properly function or lacks support for certain passwordless credentials, then one or both scenarios outlined won't function. This guide focuses on passkey/FIDO2 support and Cert-Based Authentication (CBA) support.

:::image type="content" border="true" source="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-session-auth.gif" alt-text="GIF showing the user experience when using Windows Hello for Business to establish a remote desktop connection session." lightbox="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-session-auth.gif":::

:::image type="content" border="true" source="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-session-establishment.png" alt-text="Swimlane diagram showing how phishing-resistant passwordless credentials are used when connecting via remote desktop connection" lightbox="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-session-establishment.png":::

Step through the following sections to determine if support for phishing-resistant passwordless is expected across all three components you're utilizing. Repeat this process if you have multiple scenarios that require evaluation.

### Client platform

There are several different commonly used operating systems for local clients that are used to instantiate remote desktop sessions. Commonly used options include:

- Windows 10+
- Windows Server
- macOS
- iOS
- Android
- Linux

Support for phishing-resistant passwordless and remote desktop connection depends on the client platform having support for passkey protocols, most notably [Client To Authenticator Protocol (CTAP)](https://fidoalliance.org/specs/fido-v2.0-ps-20190130/fido-client-to-authenticator-protocol-v2.0-ps-20190130.html) and [WebAuthn](https://fidoalliance.org/fido2-2/fido2-web-authentication-webauthn/). CTAP is a communication layer between roaming authenticators, such as FIDO2 security keys or passkeys on a mobile device, and a client platform. Most client platforms support these protocols, but there are certain platforms that don't. In some cases, such as with dedicated thin client devices running specialized OSes, you should contact the vendor to confirm support.

[Microsoft Entra certificate-based authentication (CBA)](~/identity/authentication/concept-certificate-based-authentication.md) requires configuration in Microsoft Entra ID so that users can utilize certificates from your Public Key Infrastructure (PKI) for authentication. This article does not address on-premises only certificate-based authentication implementations.

| Client Platform | FIDO Support | Microsoft Entra CBA | Notes                                                                                                                                                                                                                     |
|-----------------|--------------|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Windows 10+     | Yes          | Yes                 |                                                                                                                                                                                                                           |
| Windows Server  | Partial      | Yes                 | Windows Server isn't recommended for client computing devices.<br><br>Windows Server jump servers may impede FIDO-based phishing-resistant passwordless. If you use jump servers, then CBA is recommended instead of FIDO |
| macOS           | Yes          | Yes                 | Not all Apple web frameworks support FIDO                                                                                                                                                                                 |
| iOS             | Yes          | Yes                 | Not all Apple web frameworks support FIDO                                                                                                                                                                                 |
| Android         | Yes          | Yes                 |                                                                                                                                                                                                                           |
| Linux           | Maybe        | Yes                 | Confirm FIDO support with the Linux distro vendor                                                                                                                                                                         |

### Target platform

The target platform is critical for determining if phishing-resistant passwordless authentication is supported for establishing the remote desktop connection session itself.

| Target Platform                                                   | Remote Desktop Connection Session Initialization FIDO Support | Remote Desktop Connection Session Initialization Microsoft Entra CBA |
|-------------------------------------------------------------------|---------------------------------------------------------------|----------------------------------------------------------------------|
| Windows 10+ Microsoft Entra joined                                | Yes                                                           | Yes                                                                  |
| Windows Server Microsoft Entra joined                             | Yes<sup>1</sup>                                               | Yes                                                                  |
| Windows 10+ Microsoft Entra hybrid joined                         | Yes                                                           | Yes                                                                  |
| Windows Server Microsoft Entra hybrid joined                      | Yes<sup>1</sup>                                               | Yes                                                                  |
| Windows 10+ Microsoft Entra registered                            | No                                                            | No                                                                   |
| Windows 10+ on-premises domain joined only                        | No                                                            | No                                                                   |
| Windows Server on-premises domain joined only                     | No                                                            | No                                                                   |
| Windows 10+ Workgroup                                             | No                                                            | No                                                                   |
| Azure Arc-managed Windows Server standalone/workgroup<sup>2</sup> | Yes                                                           | Yes                                                                  |

<sup>1.	Only applies to Microsoft Entra joined or Hybrid Joined servers running Windows Server 2022 or later</sup><br>
<sup>2.	Only applies to Microsoft Entra joined servers running Windows Server 2025 or later</sup><br>

### Remote Desktop connection client

Client platform support for phishing-resistant authentication alone isn't sufficient to support phishing-resistant authentication for remote desktop connection sessions. The remote desktop connection client used must also support the necessary components for these credentials to work properly. Review many of the commonly used remote desktop connection clients and their various supported options:

| Remote Desktop Connection Client             | Remote Desktop Connection Session Initialization FIDO Support | Remote Desktop Connection Session Initialization Microsoft Entra CBA |
|----------------------------------------------|---------------------------------------------------------------|----------------------------------------------------------------------|
| MSTSC.exe for Windows Client                 | Yes                                                           | Yes                                                                  |
| MSTSC.exe for Windows Server 2022+           | Yes                                                           | Yes                                                                  |
| MSTSC.exe for Windows Server 2019 or earlier | No                                                            | No                                                                   |
| Windows App for Windows                      | Yes                                                           | Yes                                                                  |
| Windows App for macOS                        | Yes                                                           | Yes                                                                  |
| Windows App for iOS                          | Yes                                                           | Yes                                                                  |
| Windows App for Android                      | Yes                                                           | Yes                                                                  |
| Windows 365 Web App                          | No                                                            | No                                                                   |
| Third Party Remote Desktop Connection Client | Maybe                                                         | Maybe                                                                |

> [!IMPORTANT]
> Client and target devices must be Microsoft Entra joined, Microsoft Entra hybrid joined, or Microsoft Entra registered to the same tenant. Cross-tenant authentication will not work, the client device will not be able to authenticate to the target device if they are joined to different tenants.

# [In-session passwordless authentication](#tab/rdp-auth-in-session)

## Remote Desktop connection components

Windows remote desktop protocol involves three primary components, all of which need to properly support phishing-resistant passwordless credentials and redirection to the local client to support in-session usage of these credentials. If any of these components isn't able to properly function or lacks support for certain passwordless credentials, then one or both scenarios outlined won't function. This guide focuses on passkey/FIDO2 support and Cert-Based Authentication (CBA) support.

:::image type="content" border="true" source="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-in-session-auth.gif" alt-text="GIF showing the user experience when using Windows Hello for Business to authenticate inside a remote desktop connection session." lightbox="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-in-session-auth.gif":::

:::image type="content" border="true" source="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-in-session-auth.png" alt-text="Swimlane diagram showing how phishing-resistant passwordless credentials are used inside of remote desktop connection sessions" lightbox="media/how-to-plan-rdp-phishing-resistant-passwordless-authentication/rdp-in-session-auth.png":::

Step through the following sections to determine if phishing-resistant passwordless support is expected across all three components you're utilizing. Repeat this process if you have multiple scenarios that require evaluation.

### Client platform

There are several different commonly used operating systems for local clients that are used to instantiate remote desktop sessions. Commonly used options include:

- Windows 10+
- Windows Server
- macOS
- iOS
- Android
- Linux

Support for phishing-resistant passwordless and remote desktop connection depends on the client platform having support for passkey protocols, most notably [Client To Authenticator Protocol (CTAP)](https://fidoalliance.org/specs/fido-v2.0-ps-20190130/fido-client-to-authenticator-protocol-v2.0-ps-20190130.html) and [WebAuthn](https://fidoalliance.org/fido2-2/fido2-web-authentication-webauthn/). CTAP is a communication layer between roaming authenticators, such as FIDO2 security keys or passkeys on a mobile device, and a client platform. Most client platforms support these protocols, but there are certain platforms that don't. In some cases, such as with dedicated thin client devices running specialized OSes, you should contact the vendor to confirm support.

[Microsoft Entra certificate-based authentication (CBA)](~/identity/authentication/concept-certificate-based-authentication.md) requires configuration in Microsoft Entra ID so that users can utilize certificates from your Public Key Infrastructure (PKI) for authentication. This article does not address on-premises only certificate-based authentication implementations.

| Client Platform | FIDO Support | Microsoft Entra CBA | Notes                                                                                                                                                                                                                     |
|-----------------|--------------|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Windows 10+     | Yes          | Yes                 |                                                                                                                                                                                                                           |
| Windows Server  | Partial      | Yes                 | Windows Server isn't recommended for client computing devices.<br><br>Windows Server jump servers may impede FIDO-based phishing-resistant passwordless. If you use jump servers, then CBA is recommended instead of FIDO |
| macOS           | Yes          | Yes                 | Not all Apple web frameworks support FIDO                                                                                                                                                                                 |
| iOS             | Yes          | Yes                 | Not all Apple web frameworks support FIDO                                                                                                                                                                                 |
| Android         | Yes          | Yes                 |                                                                                                                                                                                                                           |
| Linux           | Maybe        | Yes                 | Confirm FIDO support with the Linux distro vendor                                                                                                                                                                         |

### Target platform

The target platform is critical for determining if phishing-resistant passwordless authentication is supported for in-session usage.

| Target Platform                               | In-Session FIDO Support | In-Session Microsoft Entra CBA |
|-----------------------------------------------|-------------------------|--------------------------------|
| Windows 10+ Microsoft Entra joined            | Yes                     | Yes                            |
| Windows Server Microsoft Entra joined         | Yes<sup>1</sup>         | Yes                            |
| Windows 10+ Microsoft Entra hybrid joined     | Yes                     | Yes                            |
| Windows Server Microsoft Entra hybrid joined  | Yes<sup>1</sup>         | Yes                            |
| Windows 10+ Microsoft Entra registered        | Yes                     | Yes                            |
| Windows 10+ on-premises domain joined         | Yes                     | Yes                            |
| Windows Server on-premises domain joined only | No                      | No                             |
| Windows 10+ Workgroup                         | Yes                     | Yes                            |
| Azure Arc-managed Windows Server<sup>2</sup>  | Yes                     | Yes                            |

<sup>1.	Only applies to Microsoft Entra joined or Hybrid Joined servers running Windows Server 2022 or later</sup><br>
<sup>2.	Only applies to Microsoft Entra joined servers running Windows Server 2025 or later</sup><br>

### Remote Desktop connection client

Client platform support for phishing-resistant authentication alone isn't sufficient to support phishing-resistant authentication for remote desktop connection sessions and within remote desktop connection sessions. The remote desktop connection client used must also support the necessary components for these credentials to work properly. Review many of the commonly used remote desktop connection clients and their various supported options:

| Remote Desktop Connection Client             | In-Session FIDO Support | In-Session Microsoft Entra CBA |
|----------------------------------------------|-------------------------|--------------------------------|
| MSTSC.exe for Windows Client                 | Yes                     | Yes                            |
| MSTSC.exe for Windows Server 2022+           | Yes                     | Yes                            |
| MSTSC.exe for Windows Server 2019 or earlier | No                      | No                             |
| Windows App for Windows                      | Yes                     | Yes                            |
| Windows App for macOS                        | No                      | Yes                            |
| Windows App for iOS                          | No                      | Yes                            |
| Windows App for Android                      | No                      | Yes                            |
| Windows 365 Web App                          | No                      | No                             |
| Third Party Remote Desktop Connection Client | Maybe                   | Maybe                          |

---

## Evaluate support for your scenarios

If any one of the three components outlined in this document don't support your scenario, then your scenario isn't expected to work. To evaluate, consider each component for remote desktop connection session auth and in-session credential usage. Repeat this process for every scenario in your environment to understand which scenarios are expected to work and which aren't.

### Example 1

For example, here's how you might evaluate if your scenario is "my Information Workers need to use their Windows devices to access Azure Virtual Desktop, need to authenticate the remote desktop connection session using a Microsoft Authenticator passkey, and use the passkey inside the remote desktop connection session in the Microsoft Edge browser":

| Scenario                                                                  | Client Platform                                            | Target Platform                              | Remote Desktop Connection Client | Supported?            |
|---------------------------------------------------------------------------|------------------------------------------------------------|----------------------------------------------|----------------------------------|-----------------------|
| Remote Desktop Connection *Session Initialization* using Auth App Passkey | Windows 11 Microsoft Entra joined/Hybrid Joined/Standalone | Azure Virtual Desktop Microsoft Entra joined | Windows App                      | Yes+Yes+Yes = **Yes** |
| Remote Desktop Connection In-Session Auth using Auth App Passkey          | Windows 11 Microsoft Entra joined/Hybrid Joined/Standalone | Azure Virtual Desktop Microsoft Entra joined | Windows App                      | Yes+Yes+Yes = **Yes** |

In this example, both the remote desktop connection session itself and in-session apps can take advantage of the user’s passkey. Phishing-resistant passwordless should work broadly.

### Example 2

Here's how you might evaluate if your scenario is "my Information Workers need to use their macOS devices to access Azure Virtual Desktop, need to authenticate the remote desktop connection session using a Microsoft Authenticator passkey, and use the passkey inside the remote desktop connection session":

| Scenario                                                                  | Client Platform | Target Platform                              | Remote Desktop Connection Client | Supported?            |
|---------------------------------------------------------------------------|-----------------|----------------------------------------------|----------------------------------|-----------------------|
| Remote Desktop Connection *Session Initialization* using Auth App Passkey | macOS 15        | Azure Virtual Desktop Microsoft Entra joined | Windows App                      | Yes+Yes+Yes = **Yes** |
| Remote Desktop Connection In-Session Auth using Auth App Passkey          | macOS 15        | Azure Virtual Desktop Microsoft Entra joined | Windows App                      | Yes+Yes+No = **No**   |

In this example, users can use their passkey to establish the remote desktop connection session, but can't use it inside of the remote desktop connection session because the Windows App on macOS doesn't support this functionality yet. You can wait for better passkey support in the remote desktop connection client or you can switch to another credential, such as certificates with CBA.

### Example 3

Here's how you might evaluate if your scenario is "my admins need to use their Windows devices to access on-premises Windows Servers, need to authenticate the remote desktop connection session using a certificate, and use the certificate inside the remote desktop connection session":

| Scenario                                                             | Client Platform | Target Platform              | Remote Desktop Connection Client | Supported?            |
|----------------------------------------------------------------------|-----------------|------------------------------|----------------------------------|-----------------------|
| Remote Desktop Connection *Session Initialization* using Certificate | Windows 11      | Domain-Joined Windows Server | MSTSC.exe                        | Yes+Yes+Yes = **Yes** |
| Remote Desktop Connection In-Session Auth using Certificate          | Windows 11      | Domain-Joined Windows Server | MSTSC.exe                        | Yes+Yes+Yes = **Yes** |

In this example, users can use their certificate to establish the remote desktop connection session and also use the certificate inside the remote desktop connection session. This scenario won't work with a passkey however, since the domain-joined Windows server can't use a passkey to set up a remote desktop connection session or inside the session.

### Example 4

Here's how you might evaluate if your scenario is "my frontline workers need to use a Linux-based thin client to access on-premises domain-joined Windows Virtual Desktop Infrastructure (VDI) clients that are NOT Microsoft Entra hybrid joined, need to authenticate the remote desktop connection session using a FIDO2 security key, and use the FIDO2 security key inside the remote desktop connection session":

| Scenario                                                                    | Client Platform       | Target Platform          | Remote Desktop Connection Client | Supported?                  |
|-----------------------------------------------------------------------------|-----------------------|--------------------------|----------------------------------|-----------------------------|
| Remote Desktop Connection *Session Initialization* using FIDO2 Security Key | Linux Embedded Distro | Domain-Joined Windows 11 | Vendor-Provided Client           | Maybe+No+No = **No**        |
| Remote Desktop Connection In-Session Auth using FIDO2 Security Key          | Linux Embedded Distro | Domain-Joined Windows 11 | Vendor-Provided Client           | Maybe+Yes+Maybe = **Maybe** |

In this example, users likely can't use their FIDO2 security keys for remote desktop connection at all because the thin client OS and remote desktop connection client don’t support FIDO2/passkeys in every scenario required. Work with your thin client vendor to understand their roadmap for support. Additionally, plan on Microsoft Entra hybrid joining or Microsoft Entra joining the Target Platform virtual machines so that passkeys can be better supported.

## Next steps

[Deploy a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication.md)
