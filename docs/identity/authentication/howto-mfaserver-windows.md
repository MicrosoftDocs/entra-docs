---
title: Windows authentication and Microsoft Entra Multifactor Authentication Server
description: Deploy Windows Authentication and Microsoft Entra Multifactor Authentication Server.


ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 01/14/2025

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: michmcla
---
# Windows Authentication and Microsoft Entra Multifactor Authentication Server

To enable and configure Windows authentication for applications, use the Windows Authentication section of the Microsoft Entra Multifactor Authentication Server. Before you set up Windows Authentication, keep the following list in mind:

* After setup, reboot the Microsoft Entra Multifactor Authenticationfor Terminal Services to take effect.
* If 'Require Microsoft Entra Multifactor Authenticationuser match' is checked, and you aren't in the user list, you won't be able to log into the machine after reboot.
* Trusted IPs is dependent on whether the application can provide the client IP with the authentication. Currently only Terminal Services is supported.  

> [!IMPORTANT]
> As of July 1, 2019, Microsoft no longer offers MFA Server for new deployments. New customers that want to require multifactor authentication during sign-in events should use cloud-based Microsoft Entra multifactor authentication.
>
> To get started with cloud-based MFA, see [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](tutorial-enable-azure-mfa.md).
>
> Existing customers that activated MFA Server before July 1, 2019 can download the latest version, future updates, and generate activation credentials as usual.

> [!NOTE]
> This feature is not supported to secure Terminal Services on Windows Server 2012 R2.

## To secure an application with Windows Authentication, use the following procedure

1. In the Microsoft Entra Multifactor Authentication Server, select the Windows Authentication icon.
   ![Windows Authentication in MFA Server](./media/howto-mfaserver-windows/windowsauth.png)
2. Check the **Enable Windows Authentication** checkbox. By default, this box is unchecked.
3. The Applications tab allows the administrator to configure one or more applications for Windows Authentication.
4. Select a server or application – specify whether the server/application is enabled. Select **OK**.
5. Select **Add…**
6. The Trusted IPs tab allows you to skip Microsoft Entra Multifactor Authenticationfor Windows sessions originating from specific IPs. For example, if employees use the application from the office and from home, you may decide you don't want their phones ringing for Microsoft Entra Multifactor Authentication while at the office. For this purpose, you would specify the office subnet as Trusted IPs entry.
7. Select **Add…**
8. Select **Single IP** if you would like to skip a single IP address.
9. Select **IP Range** if you would like to skip an entire IP range. Example 10.63.193.1-10.63.193.100.
10. Select **Subnet** if you would like to specify a range of IPs using subnet notation. Enter the subnet's starting IP and pick the appropriate netmask from the drop-down list.
11. Select **OK**.

## Next steps

- [Configure third-party VPN appliances for Microsoft Entra Multifactor Authentication Server](howto-mfaserver-nps-vpn.md)

- [Augment your existing authentication infrastructure with the NPS extension for Microsoft Entra Multifactor Authentication](howto-mfa-nps-extension.md)
