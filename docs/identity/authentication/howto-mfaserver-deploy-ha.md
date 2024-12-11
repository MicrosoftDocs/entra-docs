---
title: High availability for Microsoft Entra Multifactor Authentication Server
description: Deploy multiple instances of Microsoft Entra Multifactor Authentication Server in configurations that provide high availability.


ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 11/25/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: michmcla
---
# Configure Microsoft Entra Multifactor Authentication Server for high availability

To achieve high-availability with your Azure Server MFA deployment, you need to deploy multiple MFA servers. This section provides information on a load-balanced design to achieve your high availability targets in your Azure MFS Server deployment.

> [!IMPORTANT]
> In September 2022, Microsoft announced deprecation of Azure Multi-Factor Authentication Server. Beginning September 30, 2024, Azure Multi-Factor Authentication Server deployments will no longer service multifactor authentication requests, which could cause authentications to fail for your organization. To ensure uninterrupted authentication services and to remain in a supported state, organizations should [migrate their users’ authentication data](how-to-migrate-mfa-server-to-mfa-user-authentication.md) to the cloud-based Microsoft Entra Multifactor Authentication service by using the latest Migration Utility included in the most recent [Microsoft Entra Multifactor Authentication Server update](https://www.microsoft.com/download/details.aspx?id=55849). For more information, see [Microsoft Entra Multifactor Authentication Server Migration](how-to-migrate-mfa-server-to-azure-mfa.md).
>
> To get started with cloud-based MFA, see [Tutorial: Secure user sign-in events with Microsoft Entra Multifactor Authentication](tutorial-enable-azure-mfa.md).
>

## MFA Server overview

The Microsoft Entra Multifactor Authentication Server service architecture comprises several components as shown in the following diagram:

 ![MFA Server Architecture components](./media/howto-mfaserver-deploy-ha/mfa-ha-architecture.png)

An MFA Server is a Windows Server that has the Microsoft Entra Multifactor Authentication authentication software installed. The MFA Server instance must be activated by the MFA Service in Azure to function. More than one MFA Server can be installed on-premises.

The first MFA Server that is installed is the primary MFA Server upon activation by the Microsoft Entra Multifactor Authentication Service by default. The primary MFA server has a writeable copy of the PhoneFactor.pfdata database. Subsequent installations of instances of MFA Server are known as subordinates. The MFA subordinates have a replicated read-only copy of the PhoneFactor.pfdata database. MFA servers replicate information using Remote Procedure Call (RPC). All MFA Severs must collectively either be domain joined or standalone to replicate information.

Both MFA primary and subordinate MFA Servers communicate with the MFA Service when two-factor authentication is required. For example, when a user attempts to gain access to an application that requires two-factor authentication, the user will first be authenticated by an identity provider, such as Active Directory (AD).

After successful authentication with AD, the MFA Server will communicate with the MFA Service. The MFA Server waits for notification from the MFA Service to allow or deny the user access to the application.

If the MFA primary server goes offline, authentications can still be processed, but operations that require changes to the MFA database can't be processed. (Examples include: the addition of users, self-service PIN changes, changing user information, or access to the user portal)

## Deployment

Consider the following important points for load balancing Microsoft Entra Multifactor Authentication Server and its related components.

* **Using RADIUS standard to achieve high availability**. If you are using Microsoft Entra Multifactor Authentication Servers as RADIUS servers, you can potentially configure one MFA Server as a primary RADIUS authentication target and other Microsoft Entra Multifactor Authentication Servers as secondary authentication targets. However, this method to achieve high availability may not be practical because you must wait for a time-out period to occur when authentication fails on the primary authentication target before you can be authenticated against the secondary authentication target. It is more efficient to load balance the RADIUS traffic between the RADIUS client and the RADIUS Servers (in this case, the Microsoft Entra Multifactor Authentication Servers acting as RADIUS servers) so that you can configure the RADIUS clients with a single URL that they can point to.
* **Need to manually promote MFA subordinates**. If the primary Microsoft Entra Multifactor Authentication server goes offline, the secondary Microsoft Entra Multifactor Authentication Servers continue to process MFA requests. However, until a primary MFA server is available, admins can't add users or modify MFA settings, and users can't make changes using the user portal. Promoting an MFA subordinate to the primary role is always a manual process.
* **Separability of components**. The Microsoft Entra Multifactor Authentication Server comprises several components that can be installed on the same Windows Server instance or on different instances. These components include the User Portal, Mobile App Web Service, and the ADFS adapter (agent). This separability makes it possible to use the Web Application Proxy to publish the User Portal and Mobile App Web Server from the perimeter network. Such a configuration adds to the overall security of your design, as shown in the following diagram. The MFA User Portal and Mobile App Web Server may also be deployed in HA load-balanced configurations.

   ![MFA Server with a Perimeter Network](./media/howto-mfaserver-deploy-ha/mfasecurity.png)

* **One-time password (OTP) over SMS (also known as one-way SMS) requires the use of sticky sessions if traffic is load-balanced**. One-way SMS is an authentication option that causes the MFA Server to send the users a text message containing an OTP. The user enters the OTP in a prompt window to complete the MFA challenge. If you load balance Microsoft Entra Multifactor Authentication Servers, the same server that served the initial authentication request must be the server that receives the OTP message from the user; if another MFA Server receives the OTP reply, the authentication challenge fails. For more information, see [One Time Password over SMS Added to Microsoft Entra Multifactor Authentication Server](https://blogs.technet.microsoft.com/enterprisemobility/2015/03/02/one-time-password-over-sms-added-to-azure-mfa-server).
* **Load-Balanced deployments of the User Portal and Mobile App Web Service require sticky sessions**. If you are load-balancing the MFA User Portal and the Mobile App Web Service, each session needs to stay on the same server.

## High-availability deployment

The following diagram shows a complete HA load-balanced implementation of Microsoft Entra Multifactor Authentication and its components, along with ADFS for reference.

 ![Microsoft Entra Multifactor Authentication Server HA implementation](./media/howto-mfaserver-deploy-ha/mfa-ha-deployment.png)

Note the following items for the correspondingly numbered area of the preceding diagram.

1. The two Microsoft Entra Multifactor Authentication Servers (MFA1 and MFA2) are load balanced (mfaapp.contoso.com) and are configured to use a static port (4443) to replicate the PhoneFactor.pfdata database. The Web Service SDK is installed on each of the MFA Server to enable communication over TCP port 443 with the ADFS servers. The MFA servers are deployed in a stateless load-balanced configuration. However, if you wanted to use OTP over SMS, you must use stateful load balancing.
   ![Microsoft Entra Multifactor Authentication Server - App server HA](./media/howto-mfaserver-deploy-ha/mfaapp.png)

   > [!NOTE]
   > Because RPC uses dynamic ports, it isn't recommended to open firewalls up to the range of dynamic ports that RPC can potentially use. If you have a firewall **between** your MFA application servers, you should configure the MFA Server to communicate on a static port for the replication traffic between subordinate and primary servers and open that port on your firewall. You can force the static port by creating a DWORD registry value at ```HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Positive Networks\PhoneFactor``` called ```Pfsvc_ncan_ip_tcp_port``` and setting the value to an available static port. Connections are always initiated by the subordinate MFA Servers to the primary, the static port is only required on the primary, but since you can promote a subordinate to be the primary at any time, you should set the static port on all MFA Servers.

2. The two User Portal/MFA Mobile App servers (MFA-UP-MAS1 and MFA-UP-MAS2) are load balanced in a **stateful** configuration (mfa.contoso.com). Recall that sticky sessions are a requirement for load balancing the MFA User Portal and Mobile App Service.
   ![Microsoft Entra Multifactor Authentication Server - User Portal and Mobile App Service HA](./media/howto-mfaserver-deploy-ha/mfaportal.png)
3. The ADFS Server farm is load balanced and published to the Internet through load-balanced ADFS proxies in the perimeter network. Each ADFS Server uses the ADFS agent to communicate with the Microsoft Entra Multifactor Authentication Servers using a single load-balanced URL (mfaapp.contoso.com) over TCP port 443.

## Next steps

* [Install and configure Microsoft Entra Multifactor Authentication Server](howto-mfaserver-deploy.md)
