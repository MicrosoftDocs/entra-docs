---
title: Microsoft Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Private Access
description: Learn how to deploy and test Microsoft Global Secure Access as a Proof of Concept with Microsoft Entra Private Access.
customer intent: As a Microsoft Partner, I want to deploy and test Microsoft Global Secure Access for Microsoft Entra Private Access as a Proof of Concept in my production or test environment.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: conceptual
ms.date: 01/22/2025
ms.author: jricketts
---
# Microsoft Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Private Access

The Proof of Concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Global Secure Access with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.

Detailed guidance begins with [Introduction to Global Secure Access Proof of Concept Guidance](gsa-poc-guidance-intro.md) and continues after this article with [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md).

This article helps you to test Microsoft Entra Private Access and configure at least one private network connector. For detailed guidance, reference [How to configure connectors for Microsoft Entra Private Access](../global-secure-access/how-to-configure-connectors.md).

## Install Microsoft Entra private network connector

[Install and configure](../global-secure-access/how-to-configure-connectors.md#install-and-register-a-connector) the [latest version](../global-secure-access/reference-version-history.md) of Microsoft Entra private network connector from the Microsoft Entra admin center.

## Configure Microsoft Entra Private Access use cases

Configure and test your use cases. Here are example use cases with specific guidance:

- [VPN replacement](#vpn-replacement)
- [Provide access to specific apps](#provide-access-to-specific-apps)
- [Kerberos single sign-on (SSO) to Active Directory (AD) resources](#kerberos-sso-to-ad-resources)
- [Protect privileged access with Privileged Identity Management (PIM)](#protect-privileged-access-with-pim)
- [Use PowerShell to manage Microsoft Entra Private Access](#use-powershell-to-manage-microsoft-entra-private-access)
- [Protect on-premises resources such as domain controller (DC) by enabling multifactor authentication (MFA)](#protect-on-premises-resources)
- [Coexistence with a partner](#coexistence-with-a-partner)

### VPN replacement

VPN replacement enables you to open Microsoft Entra Private Access for traffic destined to all private network locations for all users. Follow these steps to seamlessly transition from full network access to Zero Trust network access:

1. [Configure Quick Access for Global Secure Access](../global-secure-access/how-to-configure-quick-access.md).
1. [Configure private domain name server (DNS)](../global-secure-access/how-to-configure-quick-access.md#add-private-dns-suffixes).
1. [Manage users and groups assignment to an application](../identity/enterprise-apps/assign-user-or-group-access-portal.md).
1. [Apply Conditional Access Policies to Microsoft Entra Private Access apps](../global-secure-access/how-to-target-resource-private-access-apps.md).

### Provide access to specific apps

If your goal is to move to Zero Trust posture, configure per-app access to all your apps. This scenario can be a daunting undertaking because many companies don't have a full inventory of all IPs and fully qualified domain names (FQDN) that users access on the private network.

To move to per-app access, configure Global Secure Access applications with app segments that limit access to specific IP addresses, IP ranges, FQDNs, protocols, and ports. You can create these configurations manually or by using tools such as PowerShell and App Discovery. Ensure that your Global Secure Access application includes in its app segments all IPs, ports, and protocols that the application uses.

>[!NOTE]
>Any Global Secure Access applications with app segments that overlap with Quick Access take precedence. In other words, Global Secure Access doesn't route any traffic to those destinations over Quick Access. Assign users correctly to your Global Secure Access applications to avoid service disruption. If you need a slower onboarding to Zero Trust posture, consider moving subsets of IP ranges and ports rather than entire enterprise applications at one time.

These articles provide detailed guidance:

- [How to Configure Per-app Access Using Global Secure Access Applications](../global-secure-access/how-to-configure-per-app-access.md)
- [Using PowerShell to manage Microsoft Entra Private Access](#use-powershell-to-manage-microsoft-entra-private-access)
- [Application Discovery (Preview) for Global Secure Access](../global-secure-access/how-to-application-discovery.md)

### Kerberos SSO to AD resources

Microsoft Entra Private Access uses Kerberos to provide SSO for on-premises resources. You can use Windows Hello for Business cloud Kerberos trust to allow SSO for users. You must publish your domain controllers and DNS suffixes in Microsoft Entra Private Access to enable this scenario. For detailed guidance, reference [Use Kerberos for single sign-on (SSO) with Microsoft Entra Private Access.](../global-secure-access/how-to-configure-kerberos-sso.md).

### Protect privileged access with PIM

[Privileged Identity Management](../id-governance/privileged-identity-management/pim-configure.md) (PIM) allows you to control access to specific critical resources. This feature adds an extra layer of security to enforce just-in-time (JIT) privileged access on top of already secured private access.

To configure Microsoft Entra Private Access to use PIM, configure and assign groups, activate privileged access, and follow compliance guidance. For details, refer to [Secure private application access with Privileged Identity Management (PIM) and Global Secure Access](../global-secure-access/how-to-configure-global-access-with-pim.md).

### Use PowerShell to manage Microsoft Entra Private Access

Several Global Secure Access commands are available in the Microsoft Entra PowerShell module. For detailed guidance, refer to [Install Microsoft Entra PowerShell](/powershell/entra-powershell/installation).

### Protect on-premises resources

To protect on-premises resources such as DC by enabling MFA, reference [Microsoft Entra Private Access for on-premises users](https://techcommunity.microsoft.com/blog/identity/microsoft-entra-private-access-for-on-prem-users/3905450).

### Coexistence with a partner

When customers deploy the 3P solution, they might want to use Environmental Protection Agency (EPA) while using other solutions for internet access. For guidance, reference [Partner ecosystem overview](../global-secure-access/partner-ecosystems-overview.md).

## Troubleshooting

If you run into issues during your PoC, these articles can help you with troubleshooting, logging, and monitoring:

- To aid in troubleshooting, review [Global Secure Access FAQ](../global-secure-access/resource-faq.yml)
- [Troubleshoot problems installing the Microsoft Entra private network connector](../global-secure-access/troubleshoot-connectors.md)
- [Troubleshoot the Global Secure Access client: diagnostics](../global-secure-access/troubleshoot-global-secure-access-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access Client: Health check tab](../global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check.md)
- [Troubleshoot Distributed File System issue with Global Secure Access](../global-secure-access/troubleshoot-distributed-file-system.md)
- See [Global Secure Access logs and monitoring](../global-secure-access/concept-global-secure-access-logs-monitoring.md) for log locations and other details that can assist with monitoring and troubleshooting your Global Secure Access deployment
- [How to use workbooks with Global Secure Access](../global-secure-access/how-to-use-workbooks.md).

## Next steps

- [Introduction to Global Secure Access Proof of Concept Guidance](gsa-poc-guidance-intro.md)](gsa-poc-guidance-intro.md)
- [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)
- [Introduction to Microsoft Global Secure Access Deployment Guide](gsa-deployment-guide-intro.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Traffic](gsa-deployment-guide-microsoft-traffic.md)
