---
title: Introduction to Microsoft Entra Kerberos
description: Get an overview of the Microsoft Entra Kerberos protocol.
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 09/05/2025
ms.author: barclayn
ms.reviewer: Vimala
---


# Introduction to Microsoft Entra Kerberos

Microsoft Entra Kerberos is a cloud-native authentication protocol that bridges hybrid identity scenarios by enabling secure access to both cloud and on-premises resources. It extends traditional Kerberos capabilities into the Microsoft Entra ecosystem, so that organizations can modernize their identity infrastructure without sacrificing compatibility with legacy systems. It also enables seamless single sign-on (SSO) to on-premises resources for users authenticated with modern credentials like Windows Hello for Business or FIDO2 security keys.

Microsoft Entra Kerberos was introduced in 2021 to help bridge the gap between legacy on-premises authentication protocols and modern cloud identity. In practice, Microsoft Entra Kerberos turns Microsoft Entra ID into a cloud-based Key Distribution Center (KDC) for Kerberos authentication. This capability allows Microsoft Entra ID to issue Kerberos tickets for users, extending traditional Kerberos authentication beyond on-premises Active Directory.

In a hybrid scenario, where accounts exist in on-premises Active Directory Domain Services (AD DS) and those users are synchronized to Microsoft Entra ID, Microsoft Entra Kerberos plays a crucial role. It enables these hybrid users to authenticate to cloud and on-premises resources by using Kerberos without needing a direct line of sight to domain controllers. For example, if a Microsoft Entra ID-joined Windows client accesses a file share or application over the internet, Microsoft Entra ID can issue the necessary Kerberos tickets on behalf of the on-premises Active Directory environment.

For more information about Kerberos in Windows, see [Kerberos authentication overview in Windows Server](/windows-server/security/kerberos/kerberos-authentication-overview).

## Hybrid identity

Currently, Microsoft Entra Kerberos works only with hybrid identities.

A hybrid identity refers to a user identity that exists both in on-premises AD DS and in Microsoft Entra ID. These identities are synchronized through tools like Microsoft Entra Connect, so users can access both cloud-based and on-premises resources by using a single set of credentials.

This setup enables seamless authentication and SSO experiences across environments. It's ideal for organizations that want to transition to the cloud while maintaining legacy infrastructure.

## Key features and benefits

**Seamless hybrid authentication**: Microsoft Entra Kerberos allows users whose accounts reside in on-premises AD DS and are synchronized to Microsoft Entra ID to authenticate across cloud and on-premises resources. It reduces (and in some cases, eliminates) the need for direct connectivity to domain controllers.

For example, when a Microsoft Entra ID-joined Windows client accesses a file share or application over the internet, Microsoft Entra ID can issue the necessary Kerberos tickets as a KDC associated with the resource.

**Enhanced security with modern credentials support**: Users can sign in by using passwordless methods such as Windows Hello for Business or FIDO2 security keys, yet still access on-premises resources that have Kerberos protections. This ability enables multifactor authentication (MFA) and passwordless authentication to reduce the risks associated with password theft and phishing attacks.

**Simplified hybrid join**: Microsoft Entra Kerberos supports hybrid join scenarios without requiring Active Directory Federation Services (AD FS) or Microsoft Entra Connect Sync. This support is ideal for nonpersistent virtual desktop infrastructure, disconnected forests, and Azure Virtual Desktop.

**Secure ticket exchange**: Microsoft Entra Kerberos uses a Ticket Granting Ticket (TGT) exchange model for enhanced security.

**Scalable group memberships**: Microsoft Entra Kerberos addresses traditional Kerberos limitations with large or dynamic group memberships to improve reliability and user experience. In scenarios that involve large groups of users, performance is optimized through automatic load distribution across all domain controllers (DCs) within a site. For deployments in Azure Virtual Desktop environments, we recommend ensuring that sufficient DCs are available and geographically close to the environment, to maintain responsiveness.

## How Microsoft Entra Kerberos works

Microsoft Entra Kerberos allows your Microsoft Entra ID tenant to operate as a dedicated Kerberos realm alongside your existing on-premises Active Directory realm. When a user signs in to a Windows device that's either Microsoft Entra ID joined or hybrid joined, the device authenticates with Microsoft Entra ID and receives a [Primary Refresh Token (PRT)](../devices/concept-primary-refresh-token.md).

In addition to the PRT, Microsoft Entra ID issues a Cloud TGT for the realm `KERBEROS.MICROSOFTONLINE.COM`. This is a partial TGT to access on-premises resources. In this model, Microsoft Entra ID acts as the KDC to facilitate seamless authentication.

## Authentication flow

### 1. User authentication

The user signs in to a Windows 10 (2004 or later) or Windows 11 device that's either Microsoft Entra joined or hybrid joined.

The Local Security Authority (LSA) uses the Cloud Authentication Provider (CloudAP) to authenticate via OAuth to Microsoft Entra ID.

### 2. Token issuance

Upon successful authentication, Microsoft Entra ID issues a PRT that contains user and device information. Alongside the PRT, Microsoft Entra ID issues a Cloud TGT for the realm `KERBEROS.MICROSOFTONLINE.COM`.

Microsoft Entra ID also issues a partial TGT that contains the user's security identifier (SID) but no group claims. This partial TGT is not sufficient for direct access to on-premises resources.

#### Cloud TGT issuance

Microsoft Entra ID acts as a KDC for cloud resources by issuing a Cloud TGT to the client when appropriate. The client recognizes the Microsoft Entra ID tenant as a separate Kerberos realm for cloud resources, and the TGT is stored in the client's Kerberos ticket cache.

The Cloud TGT that Microsoft Entra ID issues:

- Is for the realm `KERBEROS.MICROSOFTONLINE.COM`.
- Enables access to cloud-based resources such as Azure Files, Azure SQL, and other services that are integrated with Microsoft Entra Kerberos.
- Contains authorization data that's specific to cloud services and is used directly to request Kerberos service tickets for cloud resources.
- Is always issued when a user signs in to a Windows device by using supported credentials (for example, Windows Hello for Business or FIDO2).
- Has no dependency on on-premises domain controllers.

> [!NOTE]
> The Cloud TGT isn't a replacement for the on-premises TGT. It's another ticket that allows access to cloud resources. The on-premises TGT is still required for accessing on-premises resources.

#### Partial TGT issuance for on-premises access

These prerequisites apply:

- Users must be synchronized from on-premises Active Directory to Microsoft Entra ID via Microsoft Entra Connect.
- A Kerberos server object must exist in on-premises Active Directory and be synchronized to Microsoft Entra ID. This object allows Microsoft Entra ID to issue partial TGTs that on-premises domain controllers can redeem.
- Devices must be running Windows 10 (2004 or later) or Windows 11.
- Devices should be Microsoft Entra joined or hybrid joined.
- We recommend Windows Hello for Business or FIDO2 authentication methods for optimal integration.
- On-premises domain controllers must be patched to support Kerberos Cloud Trust.
- Ensure line of sight between client devices and domain controllers for ticket exchange.

If the user signs in by using a passwordless method (such as FIDO2 or Windows Hello for Business) on devices with Windows 10 (2004 or later) or Windows 11, Microsoft Entra ID issues a partial TGT for the user's on-premises Active Directory domain. This partial TGT contains the user's SID but no authorization data.

The partial TGT that Microsoft Entra ID issues:

- Enables access to on-premises resources by acting as a bridge between Microsoft Entra ID and Active Directory.
- Contains limited data (for example, the user's SID) and no group claims. It's not sufficient on its own to access on-premises resources.
- Is issued only if the environment is configured to support it. For example, you have a hybrid identity setup and a Microsoft Entra Kerberos server object in Active Directory.
- Must be exchanged with an on-premises Active Directory domain controller for a full TGT that includes group memberships and other access control data. The partial TGT must be exchanged with a domain controller to gain full authorization information. This information is then used to access resources like Server Message Block (SMB) shares or SQL servers.

#### Microsoft Entra Kerberos TGT and Active Directory access control

Possessing a Microsoft Entra Kerberos TGT for a user's on-premises Active Directory domain does not automatically grant access to a full Active Directory TGT.

Microsoft Entra Kerberos uses the Read-Only Domain Controller (RODC) object's allow list and block list to control which users can receive partial TGTs from Microsoft Entra ID for on-premises resource access. This mechanism is critical for limiting exposure and enforcing security boundaries. This mechanism is especially critical in hybrid environments where Microsoft Entra ID issues partial TGTs that must be redeemed with on-premises Active Directory domain controllers for a full TGT.

To complete the exchange, the user must be listed in the allow list on the RODC object and not in the block list.

:::image type="content" source="media/kerberos/kerberos-account.png" alt-text="Screenshot of user account properties in Active Directory." lightbox="media/kerberos/kerberos-account.png":::

During the exchange process, a partial Microsoft Entra Kerberos TGT is converted into a full Active Directory TGT. Microsoft Entra ID evaluates the lists to determine access eligibility. If the user is in the allow list, Microsoft Entra ID issues the full TGT. If the user is in the block list, Microsoft Entra ID rejects the request and authentication fails.

As a best practice, set the default configuration to **Deny**. Grant explicit **Allow** permissions only to groups that are authorized to use Microsoft Entra Kerberos.

> [!IMPORTANT]
> Only on-premises Active Directory recognizes the partial TGT. Having access to a partial TGT doesn't provide access to resources outside Active Directory.

#### Realm mapping

Realm mapping is the mechanism that allows Windows clients to determine which Kerberos realm to contact when a user is accessing a resource. This mechanism is especially important when an organization uses both on-premises Active Directory and Microsoft Entra ID in the same environment.

Windows uses the namespace of the service (for example, `*.file.core.windows.net`) to decide whether to contact Active Directory or Microsoft Entra ID for a Kerberos ticket. Because both cloud and on-premises services might share the same namespace, Windows can't distinguish them automatically.

To resolve this situation, admins configure mappings of host name to Kerberos realm via:

- Group Policy: **Computer Configuration** > **Administrative Templates** > **System** > **Kerberos** > **Define host name-to-Kerberos realm mappings**
- Intune Policy configuration service provider (CSP): **Kerberos/HostToRealm**

An example mapping for contoso.com is `.file.core.windows.net` to `KERBEROS.MICROSOFTONLINE.COM`. This mapping tells Windows to use Microsoft Entra Kerberos for specific Azure Files instances, while defaulting others to on-premises Active Directory.

#### Azure tenant information in Microsoft Entra Kerberos

Microsoft Entra ID acts as a KDC for cloud resources. It maintains tenant-specific configurations that guide how Kerberos tickets are issued and validated:

- **Cloud TGT**: Microsoft Entra ID issues this TGT for the realm `KERBEROS.MICROSOFTONLINE.COM`. It's stored in the client's Kerberos ticket cache and used for cloud resource access.
- **KDC Proxy**: This protocol routes Kerberos traffic securely over the internet to Microsoft Entra ID. This routing enables clients to obtain tickets without direct connectivity to domain controllers.
- **Azure tenant recognition**: The Kerberos stack uses realm mapping and the tenant ID to validate the Cloud TGT and issue service tickets.

### 3. Service ticket request and issuance

For client access to on-premises resources:

1. Microsoft Entra ID issues a partial TGT.
1. The client contacts an on-premises Active Directory domain controller to exchange the partial TGT for a full TGT.
1. The full TGT is used to access on-premises resources like SMB shares or SQL servers.

The client uses the Cloud TGT to request service tickets for cloud resources. No interaction with on-premises Active Directory is needed. For client access to cloud resources:

1. When the user accesses a service (for example, Azure Files), the client requests a service ticket from Microsoft Entra ID by presenting the TGT.
1. The client sends a Ticket Granting Service Request (TGS-REQ) to Microsoft Entra ID.
1. Kerberos identifies the service (for example, `cifs/mystuff.file.core.windows.net`) and maps the domain to `KERBEROS.MICROSOFTONLINE.COM`. The KDC Proxy protocol enables Kerberos communication over the internet.
1. Microsoft Entra ID verifies the Cloud TGT and the user's identity. It also looks up the requested service principal name (SPN) for the Azure Files resource registered in Microsoft Entra ID.
1. Microsoft Entra ID generates a service ticket and encrypts it by using the service principal's key. Microsoft Entra ID returns the ticket to the client in a Ticket Granting Service Reply (TGS-REP).
1. The Kerberos stack processes the TGS-REP, extracts the ticket, and generates an Application Request (AP-REQ).
1. The AP-REQ is provided to SMB, which includes it in the request to Azure Files.
1. Azure Files decrypts the ticket and grants access. FSLogix can now read the user profile from Azure Files and load the Azure Virtual Desktop session.

### Summary

| Feature | Cloud TGT | On-premises TGT |
|---|---|---|
| Issuer | Microsoft Entra ID | On-premises Active Directory (via exchange) |
| Realm | `KERBEROS.MICROSOFTONLINE.COM` | On-premises Active Directory domain |
| Authorization data | Cloud specific | Full Active Directory group memberships |
| Exchange required | No | Yes (partial TGT to full TGT) |
| Use case | Azure Files, Azure SQL | SMB shares, legacy apps |
| Verification tool (macOS) | `tgt_cloud` | `tgt_ad` |
| Verification tool (Windows) | `klist cloud_debug` | `klist get krbtgt` |

## Scenarios

### Use Microsoft Entra Kerberos for Windows authentication access to Azure SQL Managed Instance

Kerberos authentication for Microsoft Entra ID enables Windows authentication access to Azure SQL Managed Instance. Windows authentication for managed instances empowers customers to move existing services to the cloud while maintaining a seamless user experience. This ability provides the basis for infrastructure modernization.

For detailed information, see [What is Windows Authentication for Microsoft Entra principals on Azure SQL Managed Instance?](/azure/azure-sql/managed-instance/winauth-azuread-overview).

### Use SSO to sign in to on-premises resources by using FIDO2 keys

Microsoft Entra Kerberos users can sign in to Windows by using modern credentials, such as FIDO2 security keys, and then access traditional Active Directory-based resources.  

For detailed information, see [Enable passwordless security key sign-in to on-premises resources by using Microsoft Entra ID](howto-authentication-passwordless-security-key-on-premises.md).

### Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources in Platform SSO

Along with the Platform SSO PRT, Microsoft Entra issues both on-premises and cloud-based Kerberos TGTs. These TGTs are then shared with the native Kerberos stack in macOS via TGT mapping in Platform SSO.  

For detailed information, see [Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources in Platform SSO](~/identity/devices/device-join-macos-platform-single-sign-on-kerberos-configuration.md).

### Store profile containers with FSLogix for Azure Virtual Desktop

To host user profiles for virtual desktops, you can store profiles in an Azure file share accessed via Microsoft Entra Kerberos. Microsoft Entra Kerberos enables Microsoft Entra ID to issue the necessary Kerberos tickets to access the file share through the industry-standard SMB protocol.

For detailed information, see [Store FSLogix profile containers on Azure Files using Microsoft Entra ID in a hybrid scenario](/fslogix/how-to-configure-profile-container-entra-id-hybrid).

### Enable Microsoft Entra Kerberos authentication for hybrid identities on Azure Files

Microsoft Entra Kerberos authentication enables hybrid users to access Azure file shares by using Kerberos authentication. This scenario uses Microsoft Entra ID to issue the necessary Kerberos tickets to access the file share through the SMB protocol.  

For detailed information, see [Enable Microsoft Entra Kerberos authentication for hybrid identities on Azure Files](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune).

## Security considerations

- Microsoft Entra Kerberos doesn't issue partial TGTs to identities that aren't synced to Microsoft Entra ID.
- Microsoft Entra Kerberos uses a secure TGT exchange model via KDC Proxy. This model minimizes exposure to domain controllers and reduces the attack surface.
- Admins can configure group resolution policies to limit which groups are included in Kerberos tickets. These controls are essential for managing ticket size and reducing exposure to unnecessary group data.
- We advise you to maintain clear separation between cloud and on-premises environments. We discourage synchronizing sensitive accounts like `krbtgt_AzureAD` to on-premises Active Directory due to privilege escalation risks.
- Use the RODC object's allow list and block list to control which users can receive partial TGTs from Microsoft Entra ID for on-premises resource access.

## Limitations and other considerations

### Support limited to hybrid user identities

Microsoft Entra Kerberos supports only hybrid user identities that are created in on-premises Active Directory and synchronized to Microsoft Entra ID via Microsoft Entra Connect.

Cloud-only user accounts managed solely in Microsoft Entra ID aren't supported for Kerberos authentication.

### Operating system and device restrictions

Microsoft Entra Kerberos is supported on Microsoft Entra-joined or hybrid-joined Windows 10 (2004 or later) and Windows 11 devices. Some features depend on specific Windows versions and patches.

### Network connectivity requirements for ACL configuration

Users can access Azure file shares over the internet without direct connectivity to domain controllers. However, configuring Windows access control lists (ACLs) or file-level permissions requires unimpeded network access to on-premises domain controllers.

### No cross-tenant or guest user support

Business-to-business guest users or users from other Microsoft Entra tenants can't currently authenticate via Microsoft Entra Kerberos.

### Password expiration

Service principal passwords for storage accounts expire every six months and need to be rotated to maintain access.

### Group membership limits

Kerberos tickets have a size constraint that limits the number of group SIDs that you can include. The default cap is 1,010 groups per ticket. If you exceed that cap, only the first 1,010 are included. The exclusion of the remainder can cause access failures for users in large organizations.

### MFA incompatibility for Azure Files authentication

Microsoft Entra Kerberos authentication for Azure file shares doesn't support MFA. Microsoft Entra Conditional Access policies that enforce MFA must exclude the storage account application, or users experience authentication failures.

Exclude Azure Files from Conditional Access policies that require MFA. You can accomplish this task by scoping the policy to exclude the storage account or the specific application that accesses Azure Files.

### Attribute synchronization requirements

Proper synchronization of key on-premises Active Directory user attributes is essential for Microsoft Entra Kerberos to work. These attributes include `onPremisesDomainName`, `onPremisesUserPrincipalName`, and `onPremisesSamAccountName`.

### Single Active Directory method per Azure Storage account

For Azure Files identity-based authentication, you can enable only one Active Directory method at a time per storage account. These methods include Microsoft Entra Kerberos, on-premises AD DS, and Microsoft Entra Domain Services. Switching between methods requires disabling the current method first.

### Kerberos encryption settings

Kerberos ticket encryption with Microsoft Entra Kerberos uses AES-256 exclusively. You can configure SMB channel encryption separately, based on your requirements.

## Getting started with Microsoft Entra Kerberos

1. Set up Microsoft Entra Connect to synchronize on-premises AD DS users to Microsoft Entra ID. For details, see the [Microsoft Entra Connect installation guide](../hybrid/connect/how-to-connect-install-prerequisites.md).

2. Configure Azure Files or other services to use Microsoft Entra Kerberos authentication. For instructions, see [Enable Microsoft Entra Kerberos authentication](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust#enable-microsoft-entra-kerberos-authentication?tabs=azure-portal).

3. Ensure that Windows clients are up to date and [configured for Microsoft Entra Kerberos](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow#configure-the-group-policy-object-gpo).

4. Monitor and rotate service principal passwords as required.

5. Use [Microsoft Entra ID reports and monitoring tools](../monitoring-health/overview-monitoring-health.md) to keep track of authentication events.

## Related content

- [Create the trusted domain object](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust?tabs=azure-portal&preserve-view=true#create-the-trusted-domain-object)
- [Configure clients to retrieve Kerberos tickets](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune&preserve-view=true#configure-the-clients-to-retrieve-kerberos-tickets)
- [Configure the Group Policy Object (GPO) for Azure SQL Managed Instance](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow?view=azuresql&preserve-view=true#configure-the-group-policy-object-gpo)
