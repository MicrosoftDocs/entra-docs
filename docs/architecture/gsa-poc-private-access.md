---
title: Microsoft Global Secure Access Proof-of-Concept Guidance - Configure Microsoft Entra Private Access
description: Learn how to deploy and test Microsoft Global Secure Access as a proof of concept with Microsoft Entra Private Access.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 01/22/2025
ms.author: jricketts

#customer intent: As a Microsoft partner, I want to deploy and test Microsoft Global Secure Access for Microsoft Entra Private Access as a proof of concept in my production or test environment.
---

# Microsoft Global Secure Access proof-of-concept guidance: Configure Microsoft Entra Private Access

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Global Secure Access with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.

Detailed guidance begins with [Introduction to Microsoft Global Secure Access proof-of-concept guidance](gsa-poc-guidance-intro.md) and continues after this article with [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md).

This article helps you to test Microsoft Entra Private Access and configure at least one private network connector. For detailed guidance, see [How to configure connectors for Microsoft Entra Private Access](../global-secure-access/how-to-configure-connectors.md).

## Install the Microsoft Entra private network connector

[Install and configure](../global-secure-access/how-to-configure-connectors.md#install-and-register-a-connector) the [latest version](../global-secure-access/reference-version-history.md) of the Microsoft Entra private network connector from the Microsoft Entra admin center.

## Configure use cases

Configure and test your Microsoft Entra Private Access use cases. The following sections provide example use cases with specific guidance.

### Replace VPN

You can use VPN replacement to open Microsoft Entra Private Access for traffic destined to all private network locations for all users. Follow these steps to seamlessly transition from full network access to Zero Trust network access:

1. [Configure Quick Access for Global Secure Access](../global-secure-access/how-to-configure-quick-access.md).
1. [Add private Domain Name System (DNS) suffixes](../global-secure-access/how-to-configure-quick-access.md#add-private-dns-suffixes).
1. [Manage user and group assignment to an application](../identity/enterprise-apps/assign-user-or-group-access-portal.md).
1. [Apply Conditional Access policies to Microsoft Entra Private Access apps](../global-secure-access/how-to-target-resource-private-access-apps.md).

### Provide access to specific apps

If your goal is to move to a Zero Trust posture, configure per-app access to all your apps. This scenario can be a daunting undertaking because many companies don't have a full inventory of all IP addresses and fully qualified domain names (FQDNs) that users access on the private network.

To move to per-app access, configure Global Secure Access applications with app segments that limit access to specific IP addresses, IP ranges, FQDNs, protocols, and ports. You can create these configurations manually or by using tools such as PowerShell and App Discovery. Ensure that your Global Secure Access application includes in its app segments all IPs, ports, and protocols that the application uses.

> [!NOTE]
> Any Global Secure Access applications with app segments that overlap with Quick Access take precedence. In other words, Global Secure Access doesn't route any traffic to those destinations over Quick Access. To avoid service disruption, assign users correctly to your Global Secure Access applications. If you need a slower onboarding to a Zero Trust posture, consider moving subsets of IP ranges and ports rather than entire enterprise applications at one time.

These articles provide detailed guidance:

- [Configure per-app access by using Global Secure Access applications](../global-secure-access/how-to-configure-per-app-access.md)
- [Application discovery (preview) for Global Secure Access](../global-secure-access/how-to-application-discovery.md)

### Use Kerberos SSO to Active Directory resources

Microsoft Entra Private Access uses Kerberos to provide single sign-on (SSO) for on-premises resources. You can use cloud Kerberos trust in Windows Hello for Business to allow SSO for users. To enable this scenario, you must publish your domain controllers and DNS suffixes in Microsoft Entra Private Access. For detailed guidance, see [Use Kerberos for single sign-on (SSO) with Microsoft Entra Private Access](../global-secure-access/how-to-configure-kerberos-sso.md).

### Protect privileged access with PIM

You can use [Microsoft Entra Privileged Identity Management (PIM)](../id-governance/privileged-identity-management/pim-configure.md) to control access to specific critical resources. This feature adds an extra layer of security to enforce just-in-time (JIT) privileged access on top of private access.

To configure Microsoft Entra Private Access to use PIM, configure and assign groups, activate privileged access, and follow compliance guidance. For details, refer to [Secure private application access with Privileged Identity Management (PIM) and Global Secure Access](../global-secure-access/how-to-configure-global-access-with-pim.md).

### Use PowerShell to manage Microsoft Entra Private Access

Several Global Secure Access commands are available in the Microsoft Entra PowerShell module. For detailed guidance, refer to [Install the Microsoft Entra PowerShell module](/powershell/entra-powershell/installation).

### Protect on-premises resources

To help protect on-premises resources like domain controllers by enabling multifactor authentication (MFA), see [Microsoft Entra Private Access for on-premises users](https://techcommunity.microsoft.com/blog/identity/microsoft-entra-private-access-for-on-prem-users/3905450).

### Coexist with a partner

When customers deploy the 3P solution, they might want to use the Environmental Protection Agency (EPA) while using other solutions for internet access. For guidance, see [Partner ecosystem overview](../global-secure-access/partner-ecosystems-overview.md).

## Troubleshoot

If you have problems with your PoC, these articles can help you with troubleshooting, logging, and monitoring:

- [Global Secure Access FAQ](../global-secure-access/resource-faq.yml)
- [Troubleshoot problems installing the Microsoft Entra private network connector](../global-secure-access/troubleshoot-connectors.md)
- [Troubleshoot the Global Secure Access client: Diagnostics](../global-secure-access/troubleshoot-global-secure-access-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access client: Health check tab](../global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check.md)
- [Troubleshoot a Distributed File System issue with Global Secure Access](../global-secure-access/troubleshoot-distributed-file-system.md)
- [Global Secure Access logs and monitoring](../global-secure-access/concept-global-secure-access-logs-monitoring.md)
- [How to use workbooks with Global Secure Access](../global-secure-access/how-to-use-workbooks.md)

## Related content

- [Introduction to Microsoft Global Secure Access proof-of-concept guidance](gsa-poc-guidance-intro.md)
- [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)
- [Introduction to the Microsoft Global Secure Access deployment guide](gsa-deployment-guide-intro.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft traffic](gsa-deployment-guide-microsoft-traffic.md)
