---
title: Overview of Microsoft Entra Kerberos
description: Overview of Microsoft Entra Kerberos
author: barclayn
manager: amycolannino
ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 12/12/2024
ms.author: barclayn
ms.reviewer:
---

# Microsoft Entra Kerberos overview

Kerberos is a network authentication protocol designed to provide strong authentication for client-server applications by using secret-key cryptography. Developed by MIT, Kerberos works by assigning a unique key, known as a Ticket Granting Ticket (TGT), to each user. This TGT is used to request access to various services within a network without repeatedly transmitting the user's password. The protocol ensures secure communication by encrypting the tickets and authenticating both the user and the service, thereby preventing eavesdropping and replay attacks.

**Microsoft Entra Kerberos** enhances traditional Kerberos authentication by enabling Microsoft Entra ID to act as the Key Distribution Center (KDC) in the cloud. This allows hybrid identities—users synchronized from on-premises Active Directory Domain Services (AD DS)—to seamlessly authenticate to Azure services without the need for on-premises domain controllers. By using Microsoft Entra ID as the KDC, organizations can provide secure access to Azure resources while benefiting from modern authentication methods like multifactor authentication (MFA), passwordless authentication, and conditional access policies.

> [!NOTE]
> For information on Kerberos in Windows, review [Kerberos authentication overview](/windows-server/security/kerberos/kerberos-authentication-overview)

## Features of Microsoft Entra Kerberos

Microsoft Entra Kerberos provides several key functionalities that enhance traditional authentication methods:

- **Cloud-Based KDC**: By using Microsoft Entra ID as the Key Distribution Center, Microsoft Entra Kerberos eliminates the need for domain controllers to handle authentication requests in Azure.
- **Hybrid Identity Support**: Enables authentication for users synchronized from on-premises Active Directory, facilitating a smooth transition to cloud services.
- **Modern Authentication Methods**: Supports multifactor authentication (MFA), passwordless options, and conditional access policies to improve security.
- **Reduced Infrastructure Complexity**: Minimizes the reliance on on-premises infrastructure, simplifying management and deployment in cloud settings.
- **Compatibility with Azure Services**: Integrates with various Azure services, allowing secure access without extensive configuration changes.
- **Scalability and Reliability**: Uses Azure's infrastructure to provide scalable and reliable authentication services for organizations of all sizes.

## Traditional Kerberos Authentication

### Key Components

1. **Client**: The user or service requesting access.
2. **Key Distribution Center (KDC)**: Trusted authority (typically an on-premises domain controller) that issues Kerberos tickets.
3. **Service**: The network resource the client wants to access.

### Authentication Process

1. **User Logon**: The client authenticates with the KDC using credentials (password, smart card, etc.).
2. **Ticket Granting Ticket (TGT) Issuance**: Upon successful authentication, the KDC issues a TGT to the client.
3. **Service Ticket Request**: The client presents the TGT to the KDC to request a service ticket for a specific resource.
4. **Service Ticket Issuance**: The KDC issues a service ticket encrypted with the service's secret key.
5. **Resource Access**: The client presents the service ticket to the resource server, which decrypts it and grants access if valid.

This process relies on the client’s ability to communicate with the on-premises KDC, which can be limiting in cloud scenarios.

## Differences Between Traditional Kerberos and Microsoft Entra Kerberos

### Authentication Source

- **Traditional Kerberos**: Relies on on-premises AD DS domain controllers as the KDC.
- **Microsoft Entra Kerberos**: Uses Microsoft Entra ID as the KDC, eliminating the need for on-premises domain controllers for cloud service authentication.

### Capabilities

- **Traditional Kerberos**: Limited to password-based authentication and lacks support for modern security features.
- **Microsoft Entra Kerberos**: Supports modern authentication methods, including multifactor authentication (MFA), passwordless authentication (for example, FIDO2 security keys), and conditional access policies.

### Infrastructure Requirements

- **Traditional Kerberos**: Requires network connectivity to on-premises domain controllers.
- **Microsoft Entra Kerberos**: Operates over the internet with Microsoft Entra ID, reducing infrastructure complexity and dependencies.

## How Microsoft Entra Kerberos Works

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

### Benefits of this approach

- **Seamless Access**: Users can authenticate to Azure services without VPN or direct connections to on-premises infrastructure.
- **Modern Authentication**: Supports MFA, passwordless, and conditional access.
- **Simplified Management**: Reduces the need for managing on-premises authentication servers for cloud resources.

## Services that use Microsoft Entra Kerberos

### Azure Files

- **Description**: A managed file share service that uses SMB protocol.
- **Usage**: Enables access to file shares in Azure using Kerberos authentication.
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

## Benefits to Administrators

- **Enhanced Security**: Uses Microsoft Entra ID's security features, including conditional access and MFA.
- **Reduced Infrastructure**: Eliminates the need for maintaining on-premises domain controllers for cloud resource authentication.
- **Simplified User Experience**: Users have seamless access to resources without other prompts or VPN requirements.
- **Modern Authentication Support**: Facilitates the adoption of passwordless and multifactor authentication methods.

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
    > Clients will need to be [configured to use a KDC proxy](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow?view=azuresql#configure-the-group-policy-object-gpo)

4. **Manage Service Principals**:
    - Monitor and rotate service principal passwords as required.

5. **Monitor Authentication Activity**:
    - Use Microsoft Entra ID reports and monitoring tools to keep track of authentication events.

## Conclusion

Microsoft Entra Kerberos bridges the gap between traditional on-premises authentication and modern cloud-based services. By allowing Microsoft Entra ID to act as a KDC, it simplifies authentication for hybrid users accessing Azure services, enhances security with modern authentication methods, and reduces the need for on-premises infrastructure.

Administrators benefit from streamlined management, enhanced security features, and the ability to provide users with seamless access to cloud resources. As organizations continue to adopt cloud services, Microsoft Entra Kerberos plays a crucial role in maintaining secure and efficient authentication processes.

## Learn more


