---
title: Rotate the Kerberos server key for Microsoft Entra Kerberos
description: Learn how to rotate the Microsoft Entra Kerberos server key to maintain security and align with best practices in hybrid identity environments.
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 04/23/2026
ms.author: vranganathan
ms.reviewer: Vimala
ms.custom: msecd-doc-authoring-1012
#customer intent: As an IT admin, I want to rotate the Microsoft Entra Kerberos server key so that I can maintain security in my hybrid identity environment.
---

# Rotate the Kerberos server key for Microsoft Entra Kerberos

In hybrid identity environments, Microsoft Entra Kerberos uses a shared Kerberos server key between on-premises Active Directory Domain Services (AD DS) and Microsoft Entra ID. This key encrypts and protects Ticket Granting Tickets (TGTs) issued by Microsoft Entra ID. This article shows you how to rotate the key to maintain security and align with Active Directory best practices.

The key is stored on a dedicated Microsoft Entra Kerberos server object in on-premises Active Directory and securely published to Microsoft Entra ID. This object is logical, not a physical server, and functions like a read-only domain controller (RODC) for Kerberos trust.

## Prerequisites

- The `AzureADHybridAuthenticationManagement` PowerShell module installed.
- Domain admin or equivalent credentials for on-premises AD DS.
- Cloud admin credentials for Microsoft Entra ID.
- A Microsoft Entra Kerberos server object already configured in on-premises Active Directory.

## Understand why key rotation matters

Regular rotation of the Kerberos server key helps:

- Limit the lifetime of cryptographic material.
- Reduce risk if a key is compromised.
- Align with standard Kerberos and Active Directory security practices.

Microsoft recommends rotating the Microsoft Entra Kerberos server key on the same schedule you use for other Active Directory Kerberos (`krbtgt`) keys.

## How key rotation works

Microsoft Entra Kerberos uses a dual-key model to avoid service disruption during rotation:

- **Primary key**: Used for all newly issued Kerberos tickets.
- **Secondary key**: Retains the previous key to validate existing tickets until they naturally expire.

When you rotate the key, the new key becomes the primary key, and the previous primary key is retained as the secondary key. Microsoft Entra ID validates Kerberos tickets by using the primary key while continuing to honor tickets protected by the secondary key. This process doesn't interrupt user access.

## Rotate the Kerberos server key

Use the `Set-AzureADKerberosServer` cmdlet to rotate the key. This command:

- Generates a new Kerberos server key.
- Stores the key on the on-premises Active Directory Kerberos server object.
- Securely publishes the key to Microsoft Entra ID.
- Updates the key version in both environments.

```powershell
Set-AzureADKerberosServer -Domain $domain -CloudCredential $cloudCred -DomainCredential $domainCred -RotateServerKey
```

> [!WARNING]
> There are other tools that could rotate the `krbtgt` keys. However, you must use the `Set-AzureADKerberosServer` cmdlet to rotate the `krbtgt` keys of your Microsoft Entra Kerberos server. This ensures that the keys are updated in both on-premises Active Directory and Microsoft Entra ID.

> [!IMPORTANT]
> To fully retire older keys, perform the rotation twice, ensuring that both the original primary and secondary keys have expired.

### Use the -Force parameter

Using `-Force` with `Set-AzureADKerberosServer` allows the command to apply or update Kerberos server configuration without confirmation prompts. This flag ensures consistent, nondisruptive execution while maintaining full security controls.

```powershell
Set-AzureADKerberosServer -Domain $domain -CloudCredential $cloudCred -DomainCredential $domainCred -RotateServerKey -Force
```

Typically, `-Force` is used when:

- Rerunning the command to repair or reconcile configuration.
- Automating Kerberos setup or key management.
- Recovering from partial or failed configuration attempts.
- Ensuring consistent state across environments without manual confirmation.

## When to rotate the key

Microsoft doesn't mandate a fixed rotation interval but recommends aligning with your existing Kerberos security practices. Common approaches include:

- Rotating on the same cadence as Active Directory `krbtgt` keys.
- Rotating as part of scheduled security maintenance windows.
- Rotating immediately after a suspected credential compromise.

## Related content

- [Introduction to Microsoft Entra Kerberos](kerberos.md)
- [Kerberos authentication overview in Windows Server](/windows-server/security/kerberos/kerberos-authentication-overview)
- [Enable Microsoft Entra Kerberos authentication for hybrid identities on Azure Files](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune)
