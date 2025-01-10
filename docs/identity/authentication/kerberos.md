---
title: Overview of Microsoft Entra Kerberos
description: Overview of Microsoft Entra Kerberos
author: barclayn
manager: amycolannino
ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 01/10/2025
ms.author: barclayn
ms.reviewer:
---

# Microsoft Entra Kerberos overview


**Microsoft Entra Kerberos** enhances traditional Kerberos authentication by enabling Microsoft Entra ID to act as the Key Distribution Center (KDC) in the cloud. This feature enables hybrid identities from on-premises Active Directory Domain Services (AD DS) to authenticate to Azure services using Microsoft Entra Kerberos, enhancing security, and simplifying management. By using Microsoft Entra ID as the KDC, organizations can provide secure access to Azure resources while benefiting from modern authentication methods.

> [!NOTE]
> For information on Kerberos in Windows, review [Kerberos authentication overview](/windows-server/security/kerberos/kerberos-authentication-overview)

## Key Features
- **Cloud-Based KDC**: Uses Microsoft Entra ID as the Key Distribution Center, reducing the need for domain controllers in Azure.
- **Hybrid Identity Support**: Authenticates users from on-premises Active Directory, easing the move to cloud services.
- **Modern Authentication**: Supports multifactor authentication (MFA), passwordless options, and conditional access policies.
- **Simplified Infrastructure**: Reduces reliance on on-premises infrastructure, making management easier.
- **Azure Integration**: Works seamlessly with Azure services, requiring minimal configuration.
- **Scalability and Reliability**: Uses Azure's infrastructure for scalable and reliable authentication.
## Benefits
- **Seamless Access**: Authenticate to Azure services without VPN or direct on-premises connections.
- **Modern Authentication**: Includes MFA, passwordless options like FIDO2 security keys, and conditional access policies.
- **Single Sign-On (SSO)**: [Overview of Single Sign-On (SSO)](https://learn.microsoft.com/azure/active-directory/manage-apps/what-is-single-sign-on)
- **Multifactor Authentication (MFA)**: [What is Azure AD Multi-Factor Authentication?](https://learn.microsoft.com/azure/active-directory/authentication/concept-mfa-howitworks)
- **Conditional Access**: [What is Conditional Access in Azure Active Directory?](https://learn.microsoft.com/azure/active-directory/conditional-access/overview)
- **Windows Hello for Business (WHfB)**: [Windows Hello for Business Overview](https://learn.microsoft.com/windows/security/identity-protection/hello-for-business/hello-overview)
- **Enhanced Security**: Centralized authentication with advanced security features like single sign-on (SSO), MFA, conditional access, and Windows Hello for Business (WHfB) cloud trust.
- **Scalability**: Supports large-scale deployments with ease.
- **Interoperability**: Compatible with various operating systems and devices.



## How Microsoft Entra Kerberos Works


While traditional Kerberos requires network connectivity to on-premises domain controllers, **Microsoft Entra Kerberos** operates over the internet with Microsoft Entra ID.

### Authentication Workflow

1. **User authentication**:
    - The user signs into a Windows device.
    - The Local Security Authority (LSA) uses the Cloud Authentication Provider (CloudAP) to authenticate via OAuth to Microsoft Entra ID.
    - Microsoft Entra ID issues a Primary Refresh Token (PRT) containing user and device information.

2. **Cloud TGT issuance**:
    - Microsoft Entra ID functions as the KDC, issuing a Kerberos Ticket Granting Ticket (TGT) to the client.
    - The TGT is stored in the client's Kerberos ticket cache.

3. **Service ticket request**:
    - When the user accesses a service (for example, Azure Files), the client requests a service ticket from Microsoft Entra ID by presenting the TGT.
    - The client sends a Ticket Granting Service Request (TGS-REQ) to Microsoft Entra ID.

4. **Service Ticket Issuance**:
    - Microsoft Entra ID validates the TGS-REQ and issues a service ticket (TGS-REP) encrypted with the service's key.

5. **Resource Access**:
    - The client presents the service ticket to the service.
    - The service decrypts the ticket and grants access if the ticket is valid.



## Example services that use Microsoft Entra Kerberos

### Azure Files

- **Description**: A managed file share service that uses SMB protocol.
- **Usage**: Enables hybrid users to access file shares in Azure using Kerberos authentication.
- **Benefit**: Allows storage of user profiles and data accessible from cloud services without on-premises dependencies.

### Azure Virtual Desktop

- **Description**: A desktop and application virtualization service.
- **Usage**: Uses FSLogix profile containers stored in Azure Files authenticated via Microsoft Entra Kerberos.
- **Benefit**: Provides a seamless, secure virtual desktop experience.

### Azure SQL Managed Instance

- **Description**: A fully managed SQL Server instance offering.
- **Usage**: Supports Windows Authentication using Microsoft Entra Kerberos.
- **Benefit**: Enables secure database access without storing credentials in applications.

### Azure Virtual Machines (Microsoft Entra ID Join)

- **Description**: Virtual machines joined directly to a Microsoft Entra ID instance.
- **Usage**: Authenticate to services using Microsoft Entra Kerberos.
- **Benefit**: Simplifies VM management and authentication in the cloud.

## Example Use Cases

### Profile Containers with FSLogix for Azure Virtual Desktop

- **Scenario**: Hosting user profiles for virtual desktops.
- **Solution**: Store profiles in Azure Files accessed via Microsoft Entra Kerberos.
- **Benefit**: Reduces dependency on on-premises infrastructure and improves sign in times.

### Application Migration to Azure

- **Scenario**: "Lift and shift" of applications relying on Kerberos authentication.
- **Solution**: Use Microsoft Entra Kerberos to authenticate without modifying the application.
- **Benefit**: Simplifies migration while maintaining security requirements.

### Backup and Disaster Recovery

- **Scenario**: Backing up on-premises files to Azure Files.
- **Solution**: Authenticate to Azure Files using Microsoft Entra Kerberos, preserving permissions.
- **Benefit**: Ensures secure access during failover without relying on on-premises authentication.

## Limitations and Considerations

- **Hybrid Identities Only**: Currently supports only users synchronized from on-premises AD DS (hybrid users). Cloud-only Microsoft Entra ID accounts aren't supported.
- **Password Expiration**: Service principal passwords for storage accounts expire every six months and need to be rotated to maintain access.
- **Permissions Management**: Configuring NTFS permissions on Azure Files may still require connectivity to an on-premises domain controller.
- **Client Requirements**: Clients must be running supported versions of Windows with the necessary updates to utilize Microsoft Entra Kerberos.

## Getting Started with Microsoft Entra Kerberos

1. **Set Up Microsoft Entra Connect**:
    - Synchronize on-premises AD DS users to Microsoft Entra ID.

2. **Enable Microsoft Entra Kerberos**:
    - Configure Azure Files or other services to use Microsoft Entra Kerberos authentication.

3. **Client Configuration**:
    - Ensure Windows clients are up to date and configured to authenticate using Microsoft Entra Kerberos.

    > [!NOTE]
    > Clients need to be [configured to use a KDC proxy](https://learn.microsoft.com/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow?view=azuresql#configure-the-group-policy-object-gpo)

4. **Manage Service Principals**:
    - Monitor and rotate service principal passwords as required.

5. **Monitor Authentication Activity**:
    - Use Microsoft Entra ID reports and monitoring tools to keep track of authentication events.

## Conclusion

Microsoft Entra Kerberos bridges the gap between traditional on-premises authentication and modern cloud-based services. By allowing Microsoft Entra ID to act as a KDC, it simplifies authentication for hybrid users accessing Azure services, enhances security with modern authentication methods, and reduces the need for on-premises infrastructure.

Administrators benefit from streamlined management, enhanced security features, and the ability to provide users with seamless access to cloud resources. As organizations continue to adopt cloud services, Microsoft Entra Kerberos plays a crucial role in maintaining secure and efficient authentication processes.

## Learn more

-	[Create the trusted domain object](/azure/storage/files/storage-files-identity-auth-hybrid-cloud-trust?tabs=azure-portal#create-the-trusted-domain-object)
-	[Configure a client to retrieve kerberos tickets](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable?tabs=azure-portal%2Cintune#configure-the-clients-to-retrieve-kerberos-tickets)
