---
title: Microsoft Entra Multifactor Authentication Server and third-party VPNs
description: Step-by-step configuration guides for Microsoft Entra Multifactor Authentication Server to integrate with Cisco, Citrix, and Juniper.


ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 11/26/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: michmcla
---
# Advanced scenarios with Microsoft Entra Multifactor Authentication Server and third-party VPN solutions

Microsoft Entra Multifactor Authentication Server (formerly Microsoft Entra Multifactor Authentication Server) can be used to seamlessly connect with various third-party VPN solutions. This article focuses on Cisco&reg; ASA VPN appliance, Citrix NetScaler SSL VPN appliance, and the Juniper Networks Secure Access/Pulse Secure Connect Secure SSL VPN appliance. We created configuration guides to address these three common appliances. Microsoft Entra Multifactor Authentication Server can also integrate with most other systems that use RADIUS, LDAP, IIS, or claims-based authentication to AD FS. You can find more details in [Microsoft Entra Multifactor Authentication Server configurations](howto-mfaserver-deploy.md#next-steps).

> [!IMPORTANT]
> As of July 1, 2019, Microsoft no longer offers MFA Server for new deployments. New customers that want to require multifactor authentication during sign-in events should use cloud-based Microsoft Entra multifactor authentication.
>
> To get started with cloud-based MFA, see [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](tutorial-enable-azure-mfa.md).
>
> If you use cloud-based MFA, see [Integrate your VPN infrastructure with Microsoft Entra Multifactor Authentication](howto-mfa-nps-extension-vpn.md).
>
> Existing customers that activated MFA Server before July 1, 2019 can download the latest version, future updates, and generate activation credentials as usual.

## Cisco ASA VPN appliance and Microsoft Entra Multifactor Authentication Server
Microsoft Entra Multifactor Authentication Server integrates with your Cisco&reg; ASA VPN appliance to provide additional security for Cisco AnyConnect&reg; VPN logins and portal access.  You can use either the LDAP or RADIUS protocol.  Select one of the following to download the detailed step-by-step configuration guides.

| Configuration Guide | Description |
| --- | --- |
| [Cisco ASA with Anyconnect VPN and Microsoft Entra Multifactor Authentication Configuration for LDAP](https://download.microsoft.com/download/A/2/0/A201567C-C3DE-4227-AF89-4567A470899E/Cisco_ASA_Azure_MFA_LDAP.docx) | Integrate your Cisco ASA VPN appliance with Microsoft Entra Multifactor Authentication using LDAP |
| [Cisco ASA with Anyconnect VPN and Microsoft Entra Multifactor Authentication Configuration for RADIUS](https://download.microsoft.com/download/4/5/7/4579C1CF-35B0-4FBE-8A1A-B49CB2CC0382/Cisco_ASA_Azure_MFA_RADIUS.docx) | Integrate your Cisco ASA VPN appliance with Microsoft Entra Multifactor Authentication using RADIUS |

## Citrix NetScaler SSL VPN and Microsoft Entra Multifactor Authentication Server
Microsoft Entra Multifactor Authentication Server integrates with your Citrix NetScaler SSL VPN appliance to provide additional security for Citrix NetScaler SSL VPN logins and portal access.  You can use either the LDAP or RADIUS protocol.  Select one of the following to download the detailed step-by-step configuration guides.

| Configuration Guide | Description |
| --- | --- |
| [Citrix NetScaler SSL VPN and Microsoft Entra Multifactor Authentication Configuration for LDAP](https://download.microsoft.com/download/2/4/E/24E1E722-72DF-471F-A88A-D1338DB1AF83/Citrix_NS_Azure_MFA_LDAP.docx) | Integrate your Citrix NetScaler SSL VPN with Microsoft Entra Multifactor Authentication appliance using LDAP |
| [Citrix NetScaler SSL VPN and Microsoft Entra Multifactor Authentication Configuration for RADIUS](https://download.microsoft.com/download/1/A/4/1A482764-4A63-45C2-A5EC-2B673ACCDD12/Citrix_NS_Azure_MFA_RADIUS.docx) | Integrate your Citrix NetScaler SSL VPN appliance with Microsoft Entra Multifactor Authentication using RADIUS |

## Juniper/Pulse Secure SSL VPN appliance and Microsoft Entra Multifactor Authentication Server
Microsoft Entra Multifactor Authentication Server integrates with your Juniper/Pulse Secure SSL VPN appliance to provide additional security for Juniper/Pulse Secure SSL VPN logins and portal access.  You can use either the LDAP or RADIUS protocol.  Select one of the following to download the detailed step-by-step configuration guides.

| Configuration Guide | Description |
| --- | --- |
| [Juniper/Pulse Secure SSL VPN and Microsoft Entra Multifactor Authentication Configuration for LDAP](https://download.microsoft.com/download/6/5/8/6587B418-75B1-4FCB-84D4-984BC479309E/JuniperPulse_Azure_MFA_LDAP.docx) | Integrate your Juniper/Pulse Secure SSL VPN with Microsoft Entra Multifactor Authentication appliance using LDAP |
| [Juniper/Pulse Secure SSL VPN and Microsoft Entra Multifactor Authentication Configuration for RADIUS](https://download.microsoft.com/download/7/9/A/79AB3DAD-4799-4379-B1DA-B95ABDF231DC/JuniperPulse_Azure_MFA_RADIUS.docx) | Integrate your Juniper/Pulse Secure SSL VPN appliance with Microsoft Entra Multifactor Authentication using RADIUS |

## Next steps

- [Augment your existing authentication infrastructure with the NPS extension for Microsoft Entra Multifactor authentication](howto-mfa-nps-extension.md)

- [Configure Microsoft Entra Multifactor authentication settings](howto-mfa-mfasettings.md)
