---
title: Introduction to Microsoft Global Secure Access Proof of Concept Guidance
description: Learn how to deploy and test Microsoft Global Secure Access with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.
customer intent: As a Microsoft Partner, I want to deploy and test Microsoft Global Secure Access for Microsoft Entra Private Access, Microsoft Entra Internet Access, and Microsoft Traffic as a Proof of Concept in my production or test environment.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: conceptual
ms.date: 01/22/2025
ms.author: jricketts
---
# Introduction to Microsoft Global Secure Access Proof of Concept Guidance

The Proof of Concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Global Secure Access with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.

Detailed guidance continues in these articles:

- [Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)

This guide assumes that you're running a PoC in a production environment. Running a PoC in a test environment might give you more flexibility.

>[!NOTE]
>All PoC testing is dependent on traffic profile updates synchronizing to the client device. Synchronization can take up to 20 minutes to complete.

The following steps that this article describes ensure a successful PoC launch:

- Understand the products
- Identify use cases
- Scope and define success criteria
- Meet prerequisites
- Configure product for use cases
- Troubleshooting (Next steps)

## Understand the products

Understanding the products and their core concepts is the first step towards a successful PoC. Start with the resources in this section.

### Microsoft's Security Service Edge (SSE) solution

- [What is Microsoft's Security Service Edge (SSE) solution?](../global-secure-access/overview-what-is-global-secure-access.md#microsofts-security-service-edge-sse-solution)
- [Accelerate your Zero Trust journey with unified access controls](https://www.youtube.com/watch?v=_EGK57wwHfs)

### Microsoft Entra Internet Access

- [Learn about Microsoft Entra Internet Access](../global-secure-access/concept-internet-access.md)
- [Identity-centric Internet Access protections](https://www.youtube.com/watch?v=-dKzwX5tRkg)

### Microsoft Entra Private Access

- [Understand the Microsoft Entra private network connector](../global-secure-access/concept-connectors.md)
- [Replace VPNs for on-premises resources with Microsoft Entra Private Access](https://www.youtube.com/watch?v=_dw2JVqA4E8)

### Microsoft Global Secure Access

- [Global Secure Access Licensing overview](../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview)
- [Introduction to Microsoft Global Secure Access Deployment Guide](gsa-deployment-guide-intro.md)

## Identify use cases

While you design your PoC, identify relevant use cases and plan for appropriate configuration and testing.

### Microsoft Entra Private Access use cases

Consider the following questions as you map out your Microsoft Entra Private Access use cases.

- **Are you using a VPN today? The best way to start is to test the VPN replacement scenario.** This scenario gives you the ability to publish all the same resources that users access through the VPN and protect them with Microsoft Entra ID. From that point onwards, you can segment access. To define access to specific resources that only selected users should access, create Enterprise Apps. For example, only administrators should be able to remotely access servers. Review the [VPN Replacement section of the Configure Microsoft Entra Private Access article](gsa-poc-private-access.md#vpn-replacement) to understand the recommended configuration for this scenario.
- **What device types do you plan to test? Users' day-to-day work devices or separate test devices?** If you plan to use work devices, consider testing the [VPN replacement](gsa-poc-private-access.md#vpn-replacement) scenario so that you can use Microsoft Entra Private Access for all your daily work. To only publish certain resources using Microsoft Entra Private Access, you might need to switch to using your VPN to access other resources that you need during your day. If you decide to only [publish certain resources using Microsoft Entra Private Access](gsa-poc-private-access.md#provide-access-to-specific-apps), consider how users authenticate to those resources and if you require [Single Sign-On (SSO) with Active Directory](gsa-poc-private-access.md#kerberos-sso-to-ad-resources).

### Microsoft Entra Internet Access use cases

You can test several Microsoft Entra Internet Access and Microsoft Entra Internet Access for Microsoft Services scenarios in your PoC. Consider testing coexistence with other solutions as the [Learn about Security Service Edge (SSE) coexistence with Microsoft and Cisco](../global-secure-access/concept-cisco-coexistence.md) article describes.

- **Do you need to block or allow certain FQDNs or web categories from access by all users when they are using a managed device?** If you plan to block or allow most your user base's access to specific FQDNs or web categories, consider testing the [Create a baseline policy applying to all internet access traffic routed through the service](gsa-poc-internet-access.md#create-a-baseline-profile-applying-to-all-internet-access-traffic-routed-through-the-service) use case. You can create and apply the baseline policy to all users without the need to create conditional access policies. If needed, you can override it for subsets of users.
- **Do you need to block certain groups from accessing websites based on category or FQDN?** If you need to prevent specific groups of users from accessing FQDNs or web categories, consider testing both [Block a group from accessing websites based on category](gsa-poc-internet-access.md#block-a-group-from-accessing-websites-based-on-category) and [Block a group from accessing websites based on fully qualified domain name (FQDN)](gsa-poc-internet-access.md#block-a-group-from-accessing-websites-based-on-fqdn) use cases.
- **Do you need to override broad block or allow policies for certain users or specific circumstances?** If you want to allow specific users or groups to access a blocked website, consider testing the [Allow a user to access a blocked website](gsa-poc-internet-access.md#allow-a-user-to-access-a-blocked-website) use case.
- **Do you need to manage or control access to your Microsoft data?** You can use the Microsoft traffic profile to enable Global Secure Access to acquire and route SharePoint Online, Exchange Online, and other Microsoft traffic through the Global Secure Access cloud services. Test this scenario with the [Enable and manage the Microsoft traffic forwarding profile](../global-secure-access/how-to-manage-microsoft-profile.md) use case.
- **Do you need to control whether your users can use your managed devices to access Microsoft data in other tenants?** If you need to prevent users from accessing Microsoft data in other tenants (to which they have valid credentials) when using your managed devices, consider testing the [Universal Tenant Restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md) use case.

## Scope and define success criteria

Use the [PoC Kick off deck](https://download.microsoft.com/download/4/7/9/4793b9f2-35fe-4513-9c7e-31482a003bbc/GSA_POC_kickoff.pptx) to begin planning for your PoCs. Walk through the high-level requirements to identify key stakeholders to include in the project. Then decide on in-scope scenarios and agree on a timeline.

## Meet prerequisites

Ensure that you meet these prerequisites for your PoC:

- A Microsoft Entra ID test tenant.
- A user with the Global Secure Access administrator, Application Administrator, and Conditional Access Administrator roles. Refer to [Microsoft Global Secure Access built-in roles](../global-secure-access/reference-role-based-permissions.md.
- At least one Microsoft Entra ID test user account.
- At least one client device for user testing. To test remote access, this device should only have Microsoft Entra Internet Access, and not connect directly to your private network.

  - Windows 11 devices must be either Microsoft Entra ID joined or hybrid joined to your test tenant.
  - For Android and iOS devices, install the Microsoft Defender app and register it in your test tenant.

- You must have the appropriate paid or trial licenses.
  - [Global Secure Access Licensing overview](../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview)
  - [Microsoft Entra Suite trial licenses](https://aka.ms/EntraSuiteTrial)
  - [Microsoft Entra Internet Access trial licenses](https://aka.ms/InternetAccessTrial)
  - [Microsoft Entra Private Access trial licenses](https://aka.ms/PrivateAccessTrial)

To test Microsoft Entra Private Access scenarios, ensure that you meet these prerequisites:

- Deploy at least one Windows Server 2016 with your private/on-premises resources. This server must have line of sight to the resources you want to make available through Microsoft Entra Private Access. It should be able to access [Microsoft URLs](../global-secure-access/how-to-configure-connectors.md#allow-access-to-urls).
- To test VPN replacement, you need the IP ranges and fully qualified domain names (FQDN) used for full access to your corporate network.
- To test per-app Zero Trust network access using Microsoft Entra Private Access, identify one or more test applications. You need the IP addresses or FQDNS, protocols, and ports that clients use when they access each test application.

To test Microsoft traffic scenarios, you need Microsoft 365 products such as SharePoint Online or Exchange Online.

## Configure product for use cases

After you meet prerequisites, begin configuring your test environment. Follow these steps that the following sections describe:

- Enable the product in your tenant.
- Install Global Secure Access Client.
- Configure Microsoft Entra Private Access.
- Configure Microsoft Entra Internet Access.

### Enable product in your tenant

Enable each product's traffic profile for Global Secure Access to acquire and tunnel traffic for that product area. Assign users and groups to the profile so that the Global Secure Access client for that user acquires and routes traffic to Global Secure Access. Note the [roles](../global-secure-access/reference-role-based-permissions.md#role-based-permissions) required for these tasks:

- [Enable and Manage the Microsoft Profile](../global-secure-access/how-to-manage-microsoft-profile.md).
- [Manage the Private Access Profile](../global-secure-access/how-to-manage-private-access-profile.md).
- [Manage the Internet Access profile](../global-secure-access/how-to-manage-internet-access-profile.md).
- [Assign users and groups to traffic forwarding profiles](../global-secure-access/how-to-manage-users-groups-assignment.md).

### Install Global Secure Access Client

Install the Global Secure Access client on each client device that connects to Global Secure Access services. Ensure your test devices meet prerequisites. Review [Known Limitations for Global Secure Access](../global-secure-access/reference-current-known-limitations.md).

- Install the [Global Secure Access Client for Windows](../global-secure-access/how-to-install-windows-client.md).
- Install the [Global Secure Access Client for macOS](../global-secure-access/how-to-install-macos-client.md).
- Install the [Global Secure Access Client for Android](../global-secure-access/how-to-install-android-client.md).
- Install the [Global Secure Access Client for iOS (Preview)](../global-secure-access/how-to-install-ios-client.md).

To deploy the client to multiple devices, use Intune or another mobile device management solution.

## Troubleshooting

If you run into issues during your PoC, these articles can help you with troubleshooting, logging, and monitoring:

- To aid in troubleshooting, review [Global Secure Access FAQ](../global-secure-access/resource-faq.yml).
- [Troubleshoot problems installing the Microsoft Entra private network connector](../global-secure-access/troubleshoot-connectors.md).
- [Troubleshoot the Global Secure Access client: diagnostics](../global-secure-access/troubleshoot-global-secure-access-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access Client: Health check tab](../global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check.md)
- [Troubleshoot Distributed File System issue with Global Secure Access](../global-secure-access/troubleshoot-distributed-file-system.md)
- See [Global Secure Access logs and monitoring](../global-secure-access/concept-global-secure-access-logs-monitoring.md) for log locations and other details that can assist with monitoring and troubleshooting your Global Secure Access deployment.
- [How to use workbooks with Global Secure Access](../global-secure-access/how-to-use-workbooks.md).

## Next steps

- [Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)
- [Introduction to Microsoft Global Secure Access Deployment Guide](gsa-deployment-guide-intro.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Traffic](gsa-deployment-guide-microsoft-traffic.md)
