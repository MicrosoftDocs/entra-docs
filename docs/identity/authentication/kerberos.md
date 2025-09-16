---
title: Introduction to Microsoft Entra Kerberos
description: Overview of Microsoft Entra Kerberos
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

**Microsoft Entra Kerberos** is a cloud-native authentication protocol designed to bridge hybrid identity scenarios, enabling secure access to both cloud and on-premises resources. It extends traditional Kerberos capabilities into the Microsoft Entra ecosystem, allowing organizations to modernize their identity infrastructure without sacrificing compatibility with legacy systems. It also enables seamless single sign-on (SSO) to on-premises resources for users authenticated with modern credentials like Windows Hello for Business or FIDO2 security keys.

Microsoft Entra Kerberos was introduced in 2021 to help bridge the gap between legacy, on-premises authentication protocols, and modern cloud identity.
In practice, Microsoft Entra Kerberos turns Microsoft Entra ID into a cloud-based Key Distribution Center (KDC) for Kerberos authentication. This capability allows Microsoft Entra ID to issue Kerberos tickets for users, extending traditional Kerberos authentication beyond on-premises Active Directory. 

In a hybrid scenario, where accounts exist on-premises Active Directory Domain Services (AD DS) and those users are synchronized to Microsoft Entra ID, Microsoft Entra Kerberos plays a crucial role. It enables these hybrid users to authenticate to cloud and on-premises resources using Kerberos without needing direct line of sight to domain controllers. For example, if a Microsoft Entra ID–joined Windows client accesses a file share or application over the internet, Microsoft Entra ID can issue the necessary Kerberos tickets on behalf of the on-premises Active Directory environment.


> [!NOTE]
> For more information about Kerberos in Windows, see [Kerberos authentication overview](/windows-server/security/kerberos/kerberos-authentication-overview).

## Hybrid Identity 

A hybrid identity refers to a user identity that exists both in an on-premises Active Directory (AD DS) and in Microsoft Entra ID. These identities are synchronized using tools like Microsoft Entra Connect, allowing users to access both cloud-based and on-premises resources with a single set of credentials. This setup enables seamless authentication and single sign-on (SSO) experiences across environments. It is ideal for organizations transitioning to the cloud while maintaining legacy infrastructure. 

>[!IMPORTANT]
> Currently, Microsoft Entra Kerberos only works with hybrid identities.

## Key features and benefits

**Seamless Hybrid authentication**: Microsoft Entra Kerberos allows users whose accounts reside in on-premises Active Directory Domain Services (AD DS) and are synchronized to Microsoft Entra ID to authenticate across cloud and on-premises resources. It reduces and in some cases eliminates the need for direct connectivity to domain controllers. For example, when a Microsoft Entra ID-joined Windows client accesses a file share or application over the internet, Entra ID can issue the necessary Kerberos tickets as a KDC associated with the resource.

**Enhanced security with modern credentials support**: Users can sign in using passwordless methods such as Windows Hello for Business or FIDO2 security keys yet still access on-premises resources protected by Kerberos. Enables multifactor and password-less authentication, reducing risks associated with password theft and phishing attacks.

**Simplified Hybrid join**: Microsoft Entra Kerberos supports hybrid join scenarios without requiring ADFS or Microsoft Entra Connect sync. This is ideal for non-persistent virtual desktop infrastructure (VDI), disconnected forests, and Azure Virtual Desktop.

**Secure ticket exchange**: Microsoft Entra Kerberos uses a secure Ticket Granting Ticket (TGT) exchange model.

**Scalable group memberships**: Addresses traditional Kerberos limitations with large or dynamic group memberships, improving reliability and user experience. In scenarios involving large groups of users, performance is optimized through automatic load distribution across all domain controllers (DCs) within a site. For deployments in Azure Virtual Desktop (AVD) environments, we recommend ensuring that sufficient DCs are available and geographically close to the environment to maintain responsiveness.


## How Microsoft Entra Kerberos works

**Microsoft Entra Kerberos** allows your Microsoft Entra ID tenant to operate as a dedicated Kerberos realm alongside your existing on-premises Active Directory realm. When a user signs in to a Windows device that is either Microsoft Entra ID‑joined or hybrid joined, the device authenticates with Microsoft Entra ID and receives a [Primary Refresh Token](../devices/concept-primary-refresh-token.md). In addition to the PRT, Entra ID issues a Cloud Ticket Granting Ticket (TGT) for the realm KERBEROS.MICROSOFTONLINE.COM, a partial TGT to access on-premises resources. In this model, Microsoft Entra ID acts as the Key Distribution Center (KDC), facilitating secure and seamless authentication.

## Authentication flow

### 1. User authentication:
- The user signs into a Windows 10 (2004+) or Windows 11 device that is either Microsoft Entra joined or hybrid joined.
- The Local Security Authority (LSA) uses the Cloud Authentication Provider (CloudAP) to authenticate via OAuth to Microsoft Entra ID.

### 2. Token Issuance
- Upon successful authentication, Microsoft Entra ID issues a Primary Refresh Token (PRT) containing user and device information.
- Alongside the PRT, a Cloud Ticket Granting Ticket (Cloud TGT) is issued for the realm KERBEROS.MICROSOFTONLINE.COM, which acts as a cloud-based Kerberos Distribution Center (KDC).
- Entra ID also issues a Partial TGT containing the user’s SID (Security Identifier) but no group claims. This Partial TGT is not sufficient for direct access to on-prem resources.

#### Cloud TGT issuance:

Microsoft Entra ID acts as a Key Distribution Center (KDC) for cloud resources, issuing a Cloud Ticket Granting Ticket (Cloud TGT) to the client when appropriate. The client recognizes the Microsoft Entra ID tenant as a separate Kerberos realm for cloud resources and the TGT is stored in the client's Kerberos ticket cache.

Cloud TGT issued by Microsoft Entra ID
- is for the realm KERBEROS.MICROSOFTONLINE.COM. 
- enables access to cloud-based resources such as Azure Files, Azure SQL, and other services integrated with Entra Kerberos. - 
- contains authorization data specific to cloud services and used directly to request Kerberos service tickets for cloud resources. 
- always issued when a user signs into a Windows device with supported credentials (e.g., WHfB, FIDO2).
- No dependency on on-premises domain controllers.

>[!NOTE]
> The Cloud TGT isn't a replacement for the on-premises TGT. It's another ticket that allows access to cloud resources. The on-premises TGT is still required for accessing on-premises resources.

#### Partial TGT Issuance for On-Prem Access

**Prerequisites** 
- Users must be synchronized from on-premises Active Directory to Microsoft Entra ID using Entra Connect.
- A Kerberos Server Object must exist in the on-prem AD and be synchronized to Entra ID. This object allows Entra ID to issue Partial TGTs that can be redeemed by on-prem domain controllers.
- Devices must be running Windows 10 (2004+) or Windows 11.
- Devices should be Entra joined or hybrid joined.
- Windows Hello for Business (WHfB) or FIDO2 authentication methods are recommended for optimal integration.
- On-premises domain controllers must be patched to support Kerberos Cloud Trust.
- Ensure line-of-sight between client devices and domain controllers for ticket exchange.

If the user signs in with a password-less method (such as FIDO2 or Windows Hello for Business) on devices with Windows 10 (2004+) or Windows 11, Microsoft Entra ID issues a Partial Ticket Granting Ticket (Partial TGT) for the user's on-premises Active Directory (AD) domain. This Partial TGT contains the user's Security Identifier (SID) but no authorization data.

Partial TGT issued by Microsoft Entra ID
- enables access to on-premises resources by acting as a bridge between Entra ID and Active Directory.
- contains limited data (e.g., user SID) and no group claims and is not sufficient on its own to access on-prem resources.
- only issued if the environment is configured to support it (e.g., hybrid identity setup, Entra Kerberos server object in AD).
- must be exchanged with an on-premises AD domain controller for a full TGT that includes group memberships and other access control data. The Partial TGT must be exchanged with a domain controller to gain full authorization information which is then used to access resources like SMB shares or SQL servers.

#### Microsoft Entra Kerberos TGT and Active Directory access control
Possessing an Microsoft Entra Kerberos Ticket Granting Ticket (TGT) for a user's on-premises Active Directory (AD) domain does not automatically grant access to a full AD TGT. In Microsoft Entra Kerberos, the Azure AD Read-Only Domain Controller object’s allow and deny lists are used to control which users are permitted to receive Partial TGTs from Entra ID for on-premises resource access. This mechanism is critical for limiting exposure and enforcing security boundaries, especially in hybrid environments where Entra ID issues Partial TGTs that must be redeemed with on-prem AD domain controllers for a full TGT.

To complete the exchange, the user must be listed in the reveal credentials allowlist on the Azure AD Read-Only Domain Controller (RODC) object and not in the blocklist. 

:::image type="content" source="media/kerberos/kerberos-account.png" alt-text="Screenshot of a user account properties in Active Directory." lightbox="media/kerberos/kerberos-account.png":::
    
During the exchange process, where a partial Microsoft Entra Kerberos TGT is converted into a full AD TGT these lists are evaluated to determine access eligibility. If the user is on the allow list, the full TGT is issued. If the user is on the deny list, the request is rejected, and authentication fails.

As a best practice, the default configuration should be set to Deny, with explicit Allow permissions granted only to groups authorized to use Microsoft Entra Kerberos.
    
>[!IMPORTANT]
> The partial TGT is only recognized by on-premises Active Directory. Therefore, having access to a partial TGT doesn't provide access to other resources outside of AD.


#### Realm mapping and Entra tenant info

**Realm mapping**

Realm mapping is the mechanism that allows Windows clients to determine which Kerberos realm to contact when accessing a resource, especially important when both on-premises Active Directory and Microsoft Entra ID are used in the same environment.

Windows uses the namespace of the service (e.g., *.file.core.windows.net) to decide whether to contact Active Directory or Entra ID for a Kerberos ticket. Since both cloud and on-prem services may share the same namespace, Windows cannot distinguish them automatically. 

To resolve this, admins configure host name-to-Kerberos realm mappings via:
- Group Policy: Computer Configuration > Administrative Templates > System > Kerberos > Define host name-to-Kerberos realm mappings
- Intune Policy CSP: Kerberos/HostToRealm

Example mapping: contoso.com (.file.core.windows.net → KERBEROS.MICROSOFTONLINE.COM)

This tells Windows to use Entra Kerberos for specific Azure Files instances, while defaulting others to on-premises AD.

**Azure Tenant Information in Entra Kerberos**
Microsoft Entra ID acts as a Kerberos Distribution Center (KDC) for cloud resources. It maintains tenant-specific configurations that guide how Kerberos tickets are issued and validated.

- Cloud TGT (Ticket Granting Ticket): Issued by Entra ID for the realm KERBEROS.MICROSOFTONLINE.COM. Stored in the client’s Kerberos ticket cache and used for cloud resource access.
- KDC Proxy: Routes Kerberos traffic securely over the internet to Entra ID. This enables clients to obtain tickets without direct connectivity to domain controllers.
- Azure Tenant Recognition: The Kerberos stack uses realm mapping and tenant ID to validate the Cloud TGT and issue service tickets. 
 

### 4. Service ticket request and issuance:

**Access on-premises resources**:
- Entra ID issues a partial TGT.
- The client contacts an on-premises AD domain controller to exchange it for a full TGT.
- This full TGT is then used to access on-premises resources like SMB shares or SQL servers.

**Access cloud resources**:
The client uses cloud TGT to request service tickets for cloud resources. No interaction with on-premises AD is needed.
- When the user accesses a service (for example, Azure Files), the client requests a service ticket from Microsoft Entra ID by presenting the TGT.
- The client sends a Ticket Granting Service Request (TGS-REQ) to Microsoft Entra ID.
- Kerberos identifies the service (for example, cifs/mystuff.file.core.windows.net) and maps the domain to KERBEROS.MICROSOFTONLINE.COM. The KDC Proxy protocol enables Kerberos communication over the internet.
- Microsoft Entra ID verifies the Cloud TGT and the user's identity and looks up the requested Service Principal Name (SPN) for the Azure Files resource registered in Microsoft Entra ID.
- Generates a service ticket and encrypts it using the service principal's key and returns the ticket to the client in a TGS-REP.
- The Kerberos stack processes the TGS-REP, extracts the ticket, and generates an Application Request (AP-REQ).
- The AP-REQ is provided to SMB, which includes it in the request to Azure Files.
- Azure Files decrypts the ticket and grants access. FSLogix can now read the user profile from Azure Files and load the Azure Virtual Desktop session.

### Summary

| Feature | Cloud TGT | On-premises TGT |
|---|---|---|
| Issuer | Entra ID | On-premises AD (via exchange) |
| Realm | KERBEROS.MICROSOFTONLINE.COM | On-premises AD domain |
| Authorization data | Cloud-specific | Full AD group memberships |
| Exchange required | No | Yes (partial → full TGT) |
| Use case | Azure Files, Azure SQL | SMB shares, legacy apps |
| Verification tool (macOS) | tgt_cloud | tgt_ad |
| Verification tool (Windows) | klist cloud_debug | klist get krbtgt |

## Scenarios

### Windows authentication access to Azure SQL managed instance using Microsoft Entra Kerberos
Kerberos authentication for Microsoft Entra ID enables Windows Authentication access to Azure SQL Managed Instance. Windows Authentication for managed instances empowers customers to move existing services to the cloud while maintaining a seamless user experience and provides the basis for infrastructure modernization.
Detailed information at [Windows Authentication access to Azure SQL Managed Instance using Microsoft Entra Kerberos](/azure/azure-sql/managed-instance/winauth-azuread-overview) 

### Use SSO to sign in to on-premises resources by using FIDO2 keys
Microsoft Entra Kerberos users can sign in to Windows with modern credentials, such as FIDO2 security keys, and then access traditional Active Directory-based resources.  
Detailed information at [Passwordless security key sign-in to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md)

### Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources in platform SSO
Along with PSSO PRT, Microsoft Entra also issues both on-premises and cloud-based Kerberos Ticket Granting Tickets (TGTs) which are then shared with the native Kerberos stack in macOS via TGT mapping in PSSO.  
Detailed information at: [Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos Resources in Platform SSO](~/identity/devices/device-join-macos-platform-single-sign-on-kerberos-configuration.md)

### Profile containers with FSLogix for Azure Virtual Desktop
For hosting user profiles for virtual desktops, customers can store profiles in Azure Files accessed via Microsoft Entra Kerberos.
Microsoft Entra Kerberos enables Microsoft Entra ID to issue the necessary Kerberos tickets to access the file share with the industry-standard SMB protocol.
Detailed information at: [Store FSLogix profile containers on Azure Files using Microsoft Entra ID in a hybrid scenario - FSLogix](/fslogix/how-to-configure-profile-container-entra-id-hybrid)
    
### Enable Microsoft Entra Kerberos authentication for hybrid identities on Azure Files
Microsoft Entra Kerberos authentication hybrid users to access Azure file shares using Kerberos authentication, using Microsoft Entra ID to issue the necessary Kerberos tickets to access the file share with the SMB protocol.  
Detailed information at: [Microsoft Entra Kerberos for hybrid identities on Azure Files](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune)

## Security considerations
- Microsoft Entra Kerberos does not issue Partial TGTs to identities not synced to Entra ID.
- Entra Kerberos uses a secure TGT exchange model via KDC Proxy, minimizing exposure to domain controllers and reducing attack surface.
- Admins can configure group resolution policies to limit which groups are included in Kerberos tickets. These controls are essential for managing ticket size and reducing exposure to unnecessary group data.
- Customers are advised to maintain clear separation between cloud and on-prem environments. Synchronizing sensitive accounts like krbtgt_AzureAD to on-prem AD is discouraged due to privilege escalation risks.
- Use Azure AD Read-Only Domain Controller (RODC) object’s allow and deny lists are used to control which users are permitted to receive Partial TGTs from Entra ID for on-premises resource access.

## Limitations and considerations

### Support limited to Hybrid user identities: 
- Microsoft Entra Kerberos only supports hybrid user identities created in on-premises AD and synchronized to Microsoft Entra ID via Microsoft Entra Connect.
- Cloud-only user accounts managed solely in Microsoft Entra ID aren't supported for Kerberos authentication.
### Operating system and device restrictions
- Microsoft Entra Kerberos is supported on Microsoft Entra joined or hybrid joined Windows 10 (2004+) and Windows 11 devices.
- Some features depend on specific Windows versions and patches.
### Network connectivity requirements for ACL configuration
- While users can access Azure file shares over the internet without direct domain controller connectivity, configuring Windows ACLs or file-level permissions requires unimpeded network access to on-premises domain controllers.
### No Cross-Tenant or Guest user support
- B2B guest users or users from other Microsoft Entra tenants can't currently authenticate using Microsoft Entra Kerberos.
### Password expiration
- Service principal passwords for storage accounts expire every six months and need to be rotated to maintain access.
### Group membership limits
- Kerberos tickets have a size constraint that limits the number of group SIDs (Security Identifiers) that can be included. The default cap is 1,010 groups per ticket. If exceeded, only the first 1010 are included, which can cause access failures for users in large organizations.
### MFA incompatibility for Azure files authentication
- Microsoft Entra Kerberos authentication for Azure file shares doesn't support multifactor authentication (MFA).
- Conditional Access policies enforcing MFA must exclude the storage account application or users experience authentication failures.
- Exclude Azure Files from Conditional Access policies that require MFA. This can be done by scoping the policy to exclude the storage account or the specific application accessing Azure Files.
### Attribute synchronization requirements
- Proper synchronization of key on-premises AD user attributes is essential for Microsoft Entra Kerberos to work, including onPremisesDomainName, onPremisesUserPrincipalName, and onPremisesSamAccountName.
### Single AD method per Azure Storage account
- For Azure Files identity-based authentication, only one AD method (Microsoft Entra Kerberos, on-premises AD DS, or Microsoft Entra Domain Services) can be enabled per storage account at a time.
- Switching between methods requires disabling the current method first.
### Kerberos encryption settings
- Kerberos ticket encryption with Microsoft Entra Kerberos uses AES-256 exclusively. SMB channel encryption can be configured separately based on requirements.


## Getting started with Microsoft Entra Kerberos

1. **Set Up Microsoft Entra Connect**:
    - Synchronize on-premises AD DS users to Microsoft Entra ID. For details, see the [Microsoft Entra Connect installation guide](../hybrid/connect/how-to-connect-install-prerequisites.md).

2. **Enable Microsoft Entra Kerberos**:
    - Configure Azure Files or other services to use Microsoft Entra Kerberos authentication. For instructions, see [Enable Microsoft Entra Kerberos for Azure Files](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust?tabs=azure-portal).

3. **Client Configuration**:
    - Ensure Windows clients are up to date and [configured for Microsoft Entra Kerberos](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow#configure-the-group-policy-object-gpo).

4. **Manage service principals**:
    - Monitor and rotate service principal passwords as required.

5. **Monitor authentication activity**:
    - Use [Microsoft Entra ID reports and monitoring tools](../monitoring-health/overview-monitoring-health.md) to keep track of authentication events.


## Learn more

-   [Create the trusted domain object](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust?tabs=azure-portal&preserve-view=true#create-the-trusted-domain-object)
-   [Configure clients to retrieve Kerberos tickets](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune&preserve-view=true#configure-the-clients-to-retrieve-kerberos-tickets)
-   [Configure the Group Policy Object (GPO) for Azure SQL managed instance](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow?view=azuresql&preserve-view=true#configure-the-group-policy-object-gpo)

