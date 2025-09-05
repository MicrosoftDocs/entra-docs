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

In practice, Microsoft Entra Kerberos turns Microsoft Entra ID into a cloud-based Key Distribution Center (KDC) for Kerberos authentication. This capability allows Microsoft Entra ID to issue Kerberos tickets for users, extending traditional Kerberos authentication beyond on-premises Active Directory. Microsoft Entra Kerberos was introduced in 2021 to help bridge the gap between legacy, on-premises authentication protocols, and modern cloud identity.

In a hybrid scenario, where accounts exist on-premises Active Directory Domain Services (AD DS) and those users are synchronized to Microsoft Entra ID, Microsoft Entra Kerberos plays a crucial role. It enables these hybrid users to authenticate to cloud and on-premises resources using Kerberos without needing direct line of sight to domain controllers. For example, if a Microsoft Entra ID–joined Windows client accesses a file share or application over the internet, Microsoft Entra ID can issue the necessary Kerberos tickets on behalf of the on-premises Active Directory environment.


> [!NOTE]
> For more information about Kerberos in Windows, see [Kerberos authentication overview](/windows-server/security/kerberos/kerberos-authentication-overview).

## Hybrid Identity 

A hybrid identity refers to a user identity that exists both in an on-premises Active Directory (AD DS) and in Microsoft Entra ID. These identities are synchronized using tools like Microsoft Entra Connect, allowing users to access both cloud-based and on-premises resources with a single set of credentials. This setup enables seamless authentication and single sign-on (SSO) experiences across environments. It is ideal for organizations transitioning to the cloud while maintaining legacy infrastructure. 

>[!IMPORTANT]
> Currently, Microsoft Entra Kerberos only works with hybrid identities.

## Key Features and Benefits

**Seamless Hybrid Authentication**: Microsoft Entra Kerberos allows users whose accounts reside in on-premises Active Directory Domain Services (AD DS) and are synchronized to Microsoft Entra ID to authenticate across cloud and on-premises resources. It reduces and in some cases eliminates the need for direct connectivity to domain controllers. For example, when a Microsoft Entra ID-joined Windows client accesses a file share or application over the internet, Entra ID can issue the necessary Kerberos tickets as a KDC associated with the resource.

**Enhanced Security with Modern Credentials Support**: Users can sign in using passwordless methods such as Windows Hello for Business or FIDO2 security keys yet still access on-premises resources protected by Kerberos. Enables multifactor and password-less authentication, reducing risks associated with password theft and phishing attacks.

**Simplified Hybrid Join** Microsoft Entra Kerberos supports hybrid join scenarios without requiring ADFS or Microsoft Entra Connect sync. This is ideal for non-persistent virtual desktop infrastructure (VDI), disconnected forests, and Azure Virtual Desktop 

**Secure Ticket Exchange**: Microsoft Entra Kerberos uses a secure Ticket Granting Ticket (TGT) exchange model.  

**Scalable Group Memberships**: Addresses traditional Kerberos limitations with large or dynamic group memberships, improving reliability and user experience. In scenarios involving large groups of users, performance is optimized through automatic load distribution across all domain controllers (DCs) within a site. For deployments in Azure Virtual Desktop (AVD) environments, we recommend ensuring that sufficient DCs are available and geographically close to the environment to maintain responsiveness.


## How Microsoft Entra Kerberos Works

**Microsoft Entra Kerberos** allows your Microsoft Entra ID tenant to operate as a dedicated Kerberos realm alongside your existing on-premises Active Directory realm. When a user signs in to a Windows device that is either Microsoft Entra ID‑joined or hybrid joined, the device authenticates with Microsoft Entra ID and receives a [Primary Refresh Token](../devices/concept-primary-refresh-token.md).

In addition to the PRT, Entra ID can issue a partial Ticket Granting Ticket (TGT). This TGT enables the user to exchange it for a fully formed on‑premises TGT when needed, and it can also issue a Cloud Ticket Granting Ticket (Cloud TGT) which enables the user to request Kerberos service tickets for accessing cloud‑based resources. In this model, Microsoft Entra ID acts as the Key Distribution Center (KDC), facilitating secure and seamless authentication.

## Authentication flow

### User Authentication:
- The user signs into a Windows device (Windows 10 2004+ or Windows 11).
- The Local Security Authority (LSA) uses the Cloud Authentication Provider (CloudAP) to authenticate via OAuth to Microsoft Entra ID.
- Microsoft Entra ID issues a Primary Refresh Token (PRT) containing user and device information.
- The TGT is for the realm KERBEROS.MICROSOFTONLINE.COM, which acts as a cloud-based Kerberos Distribution Center (KDC).

### Cloud TGT Issuance:
- If the user signs in with a passwordless method (such as FIDO2 or Windows Hello for Business), Microsoft Entra ID issues a Partial Ticket Granting Ticket (Partial TGT) for the user's on-premises Active Directory (AD) domain. This Partial TGT contains the user's Security Identifier (SID) but no authorization data.

- A Kerberos server object exists in the on-premises AD, created and synchronized via Microsoft Entra Connect. This object allows Microsoft Entra ID to generate these partial TGTs for use by on-premises domain controllers to facilitate on-premises resource access.

- The Partial TGT issued by Entra ID is exchanged with an on-premises Active Directory domain controller to obtain a full TGT that includes group memberships and other access control data. The Partial TGT must be exchanged with a domain controller to gain full authorization information.

- Microsoft Entra ID also acts as a Key Distribution Center (KDC) for cloud resources, issuing a Cloud Ticket Granting Ticket (Cloud TGT) to the client when appropriate. The Cloud TGT is stored in the client's Kerberos ticket cache, and the client recognizes the Microsoft Entra ID tenant as a separate Kerberos realm for cloud resources.

### Entra Kerberos TGT and Active Directory Access Control
Possessing an Entra Kerberos Ticket Granting Ticket (TGT) for a user's on-premises Active Directory (AD) domain does not automatically grant access to a full AD TGT. To complete the exchange, the user must be listed in the reveal credentials allow list on the Azure AD Read-Only Domain Controller (RODC) object and not in the deny list. As a best practice, the default configuration should be set to Deny, with explicit Allow permissions granted only to groups authorized to use Entra Kerberos.

    :::image type="content" source="media/kerberos/kerberos-account.png" alt-text="Microsoft Entra Kerberos architecture diagram" lightbox="media/kerberos/kerberos-account.png":::
    
During the exchange process, where a partial Microsoft Entra Kerberos TGT is converted into a full AD TGT these lists are evaluated to determine access eligibility. If a user is blocked or not explicitly allowed, the request is denied and results in an error.

    
>[!IMPORTANT]
> The TGT is only recognized by on-premises Active Directory. Therefore, having access to a partial TGT doesn't provide access to other resources outside of AD.

### Cloud TGT for cloud resources:
- Microsoft Entra ID acts as a Key Distribution Center (KDC under the realm KERBEROS.MICROSOFTONLINE.COM issuing a Cloud Kerberos Ticket Granting Ticket (TGT) to the client.
- The client recognizes the Microsoft Entra ID tenant as a separate Kerberos realm for cloud resources and the TGT is stored in the client's Kerberos ticket cache.
- The cloud TGT contains authorization data only specific to cloud services and is sufficient for accessing resources integrated with Microsoft Entra Kerberos, such as Azure Files and Azure SQL.

>[!NOTE]
> The Cloud TGT isn't a replacement for the on-premises TGT. It's another ticket that allows access to cloud resources. The on-premises TGT is still required for accessing on-premises resources.



### Realm Mapping and Azure Tenant Info:
- Windows LSASS manages the Kerberos Cloud TGT, realm mapping, and Entra ID tenant information. The Kerberos stack maintains the Cloud TGT and realm mapping, using a KDC Proxy to route Kerberos traffic to Microsoft Entra ID.
- For Azure Virtual Desktop, the user receives both a PRT and Cloud TGT. Azure Virtual Desktop uses FSLogix to load the user profile from Azure Files.


### Service Ticket Request and Issuance:

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

### Windows Authentication access to Azure SQL Managed Instance using Microsoft Entra Kerberos
Kerberos authentication for Microsoft Entra ID enables Windows Authentication access to Azure SQL Managed Instance. Windows Authentication for managed instances empowers customers to move existing services to the cloud while maintaining a seamless user experience and provides the basis for infrastructure modernization.
Detailed information at [Windows Authentication access to Azure SQL Managed Instance using Microsoft Entra Kerberos](/azure/azure-sql/managed-instance/winauth-azuread-overview) 

### Use SSO to sign in to on-premises resources by using FIDO2 keys
Microsoft Entra Kerberos users can sign in to Windows with modern credentials, such as FIDO2 security keys, and then access traditional Active Directory-based resources.  
Detailed information at [Passwordless security key sign-in to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md)

### Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources in Platform SSO

Along with PSSO PRT, Microsoft Entra also issues both on-premises and cloud-based Kerberos Ticket Granting Tickets (TGTs) which are then shared with the native Kerberos stack in macOS via TGT mapping in PSSO.  
Detailed information at: [Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos Resources in Platform SSO](~/identity/devices/device-join-macos-platform-single-sign-on-kerberos-configuration.md)

### Profile Containers with FSLogix for Azure Virtual Desktop
For hosting user profiles for virtual desktops, customers can store profiles in Azure Files accessed via Microsoft Entra Kerberos.
Microsoft Entra Kerberos enables Microsoft Entra ID to issue the necessary Kerberos tickets to access the file share with the industry-standard SMB protocol.
Detailed information at: [Store FSLogix profile containers on Azure Files using Microsoft Entra ID in a hybrid scenario - FSLogix](/fslogix/how-to-configure-profile-container-entra-id-hybrid)
    
### Enable Microsoft Entra Kerberos authentication for hybrid identities on Azure Files
Microsoft Entra Kerberos authentication hybrid users to access Azure file shares using Kerberos authentication, using Microsoft Entra ID to issue the necessary Kerberos tickets to access the file share with the SMB protocol.  
Detailed information at: [Microsoft Entra Kerberos for hybrid identities on Azure Files](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune)


## Limitations and Considerations

### Support Limited to Hybrid User Identities: 
- Microsoft Entra Kerberos only supports hybrid user identities created in on-premises AD and synchronized to Microsoft Entra ID via Microsoft Entra Connect.
- Cloud-only user accounts managed solely in Microsoft Entra ID aren't supported for Kerberos authentication.
### Operating System and Device Restrictions
- Microsoft Entra Kerberos is supported on Microsoft Entra joined or hybrid joined Windows 10 (2004+) and Windows 11 devices.
- Some features depend on specific Windows versions and patches.
### Network Connectivity Requirements for ACL Configuration
- While users can access Azure file shares over the internet without direct domain controller connectivity, configuring Windows ACLs or file-level permissions requires unimpeded network access to on-premises domain controllers.
### No Cross-Tenant or Guest User Support
- B2B guest users or users from other Microsoft Entra tenants can't currently authenticate using Microsoft Entra Kerberos.
### Password Expiration
- Service principal passwords for storage accounts expire every six months and need to be rotated to maintain access.
### Group Membership Limits
- Kerberos tickets have a size constraint that limits the number of group SIDs (Security Identifiers) that can be included. The default cap is 1,010 groups per ticket. If exceeded, only the first 1010 are included, which can cause access failures for users in large organizations.
### MFA Incompatibility for Azure Files Auth
- Microsoft Entra Kerberos authentication for Azure file shares doesn't support multifactor authentication (MFA).
- Conditional Access policies enforcing MFA must exclude the storage account application or users experience authentication failures.
- Exclude Azure Files from Conditional Access policies that require MFA. This can be done by scoping the policy to exclude the storage account or the specific application accessing Azure Files.
### Attribute Synchronization Requirements
- Proper synchronization of key on-premises AD user attributes is essential for Microsoft Entra Kerberos to work, including onPremisesDomainName, onPremisesUserPrincipalName, and onPremisesSamAccountName.
### Single AD Method per Azure Storage Account
- For Azure Files identity-based authentication, only one AD method (Microsoft Entra Kerberos, on-premises AD DS, or Microsoft Entra Domain Services) can be enabled per storage account at a time.
- Switching between methods requires disabling the current method first.
### Kerberos Encryption Settings
- Kerberos ticket encryption with Microsoft Entra Kerberos uses AES-256 exclusively. SMB channel encryption can be configured separately based on requirements.


## Getting Started with Microsoft Entra Kerberos

1. **Set Up Microsoft Entra Connect**:
    - Synchronize on-premises AD DS users to Microsoft Entra ID. For details, see the [Microsoft Entra Connect installation guide](../hybrid/connect/how-to-connect-install-prerequisites.md).

2. **Enable Microsoft Entra Kerberos**:
    - Configure Azure Files or other services to use Microsoft Entra Kerberos authentication. For instructions, see [Enable Microsoft Entra Kerberos for Azure Files](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust?tabs=azure-portal).

3. **Client Configuration**:
    - Ensure Windows clients are up to date and [configured for Microsoft Entra Kerberos](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow#configure-the-group-policy-object-gpo).

4. **Manage Service Principals**:
    - Monitor and rotate service principal passwords as required.

5. **Monitor Authentication Activity**:
    - Use [Microsoft Entra ID reports and monitoring tools](../monitoring-health/overview-monitoring-health.md) to keep track of authentication events.


## Learn more

-   [Create the trusted domain object](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust?tabs=azure-portal&preserve-view=true#create-the-trusted-domain-object)
-   [Configure clients to retrieve Kerberos tickets](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune&preserve-view=true#configure-the-clients-to-retrieve-kerberos-tickets)
-   [Configure the Group Policy Object (GPO) for Azure SQL managed instance](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow?view=azuresql&preserve-view=true#configure-the-group-policy-object-gpo)

