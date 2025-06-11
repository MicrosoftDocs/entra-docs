---
title: Introduction to Microsoft Global Secure Access Proof-of-Concept Guidance
description: Learn how to deploy and test Microsoft Global Secure Access as a proof of concept with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 01/22/2025
ms.author: jricketts

#customer intent: As a Microsoft partner, I want to deploy and test Microsoft Global Secure Access as a proof of concept with Microsoft Entra Private Access, Microsoft Entra Internet Access, and the Microsoft traffic profile in my production or test environment.
---

# Introduction to Microsoft Global Secure Access proof-of-concept guidance

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Global Secure Access with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.

Detailed guidance continues in these articles:

- [Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)

This guide assumes that you're running a PoC in a production environment. Running a PoC in a test environment might give you more flexibility.

> [!NOTE]
> All PoC testing is dependent on traffic profile updates synchronizing to the client device. Synchronization can take up to 20 minutes to complete.

Follow the sections in this article to help ensure a successful PoC launch.

## Understand the products

Understanding the products and their core concepts is the first step toward running a successful PoC. Start with the resources in this section.

### Microsoft's Security Service Edge (SSE) solution

- [What is Microsoft's Security Service Edge (SSE) solution?](../global-secure-access/overview-what-is-global-secure-access.md#microsofts-security-service-edge-sse-solution)
- [Accelerate your Zero Trust journey with unified access controls](https://www.youtube.com/watch?v=_EGK57wwHfs) (video)

### Microsoft Entra Internet Access

- [Learn about Microsoft Entra Internet Access](../global-secure-access/concept-internet-access.md)
- [Identity-centric Microsoft Entra Internet Access protections](https://www.youtube.com/watch?v=-dKzwX5tRkg) (video)

### Microsoft Entra Private Access

- [Understand the Microsoft Entra private network connector](../global-secure-access/concept-connectors.md)
- [Replace VPNs for on-premises resources by using Microsoft Entra Private Access](https://www.youtube.com/watch?v=_dw2JVqA4E8) (video)

### Microsoft Global Secure Access

- [Global Secure Access licensing overview](../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview)
- [Introduction to the Microsoft Global Secure Access deployment guide](gsa-deployment-guide-intro.md)

## Identify use cases

While you design your PoC, identify relevant use cases and plan for appropriate configuration and testing.

### Microsoft Entra Private Access use cases

Consider the following questions as you map out your Microsoft Entra Private Access use cases:

- **Are you using a VPN today? The best way to start is to test the VPN replacement scenario.** This scenario gives you the ability to publish all the same resources that users access through the VPN and help protect them by using Microsoft Entra ID. From that point onward, you can segment access.

  To define access to specific resources that only selected users should access, create enterprise apps. For example, only administrators should be able to remotely access servers. To understand the recommended configuration, review the [VPN replacement](gsa-poc-private-access.md#replace-vpn) scenario.

- **What device types do you plan to test? Users' day-to-day work devices or separate test devices?** If you plan to use work devices, consider testing the [VPN replacement](gsa-poc-private-access.md#replace-vpn) scenario so that you can use Microsoft Entra Private Access for all your daily work.

  If you decide to [publish only certain resources by using Microsoft Entra Private Access](gsa-poc-private-access.md#provide-access-to-specific-apps), consider how users authenticate to those resources and if you require [single sign-on (SSO) with Active Directory](gsa-poc-private-access.md#use-kerberos-sso-to-active-directory-resources). You also might need to switch to using your VPN to access other resources that you need during your day.

### Microsoft Entra Internet Access use cases

You can test several Microsoft Entra Internet Access and Microsoft Entra Internet Access for Microsoft Services scenarios in your PoC. Consider testing coexistence with other solutions, as the [Learn about Security Service Edge (SSE) coexistence with Microsoft and Cisco](../global-secure-access/concept-cisco-coexistence.md) article describes.

- **Do you need to block or allow certain fully qualified domain names (FQDNs) or web categories from access by all users when they're using a managed device?** If you plan to block or allow most of your user base's access to specific FQDNs or web categories, consider testing the [Create a baseline policy that applies to all internet access traffic routed through the service](gsa-poc-internet-access.md#create-a-baseline-profile-that-applies-to-all-internet-traffic-routed-through-the-service) use case. You can create and apply the baseline policy to all users without needing to create Conditional Access policies. If necessary, you can override it for subsets of users.

- **Do you need to block certain groups from accessing websites based on category or FQDN?** If you need to prevent specific groups of users from accessing FQDNs or web categories, consider testing the [Block a group from accessing websites based on category](gsa-poc-internet-access.md#block-a-group-from-accessing-websites-based-on-category) and [Block a group from accessing websites based on FQDN](gsa-poc-internet-access.md#block-a-group-from-accessing-websites-based-on-fqdn) use cases.

- **Do you need to override broad block or allow policies for certain users or specific circumstances?** If you want to allow specific users or groups to access a blocked website, consider testing the [Allow a user to access a blocked website](gsa-poc-internet-access.md#allow-a-user-to-access-a-blocked-website) use case.

- **Do you need to manage or control access to your Microsoft data?** You can use the Microsoft traffic profile to enable Global Secure Access to acquire and route SharePoint Online, Exchange Online, and other Microsoft traffic through the Global Secure Access cloud services. Test this scenario with the [Enable and manage the Microsoft traffic forwarding profile](../global-secure-access/how-to-manage-microsoft-profile.md) use case.
- **Do you need to control whether your users can use your organization's managed devices to sign in to other Entra ID tenants?** Consider testing [Universal Tenant Restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md).

## Scope and define success criteria

Use the [PoC kickoff deck](https://download.microsoft.com/download/4/7/9/4793b9f2-35fe-4513-9c7e-31482a003bbc/GSA_POC_kickoff.pptx) to plan your PoC. Walk through the high-level requirements to identify key stakeholders to include in the project. Then decide on in-scope scenarios and agree on a timeline.

## Meet prerequisites

Ensure that you meet these prerequisites for your PoC:

- A Microsoft Entra ID test tenant.
- A user with the Global Secure Access Administrator, Application Administrator, and Conditional Access Administrator roles. Refer to [Microsoft Global Secure Access built-in roles](../global-secure-access/reference-role-based-permissions.md).
- At least one Microsoft Entra ID test user account.
- At least one client device for user testing. To test remote access, make sure that this device has only Microsoft Entra Internet Access and can't connect directly to your private network.

  - Windows 11 devices must be either Microsoft Entra ID joined or hybrid joined to your test tenant.
  - For Android and iOS devices, install the Microsoft Defender app and register it in your test tenant.

- The appropriate paid or trial licenses:

  - [Global Secure Access licensing overview](../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview)
  - [Microsoft Entra Suite trial licenses](https://aka.ms/EntraSuiteTrial)
  - [Microsoft Entra Internet Access trial licenses](https://aka.ms/InternetAccessTrial)
  - [Microsoft Entra Private Access trial licenses](https://aka.ms/PrivateAccessTrial)

To test Microsoft Entra Private Access scenarios, ensure that you meet these prerequisites:

- Deploy at least one Windows Server 2019 or 2022 machine with your private or on-premises resources. This server must have a line of sight to the resources that you want to make available through Microsoft Entra Private Access. It should be able to access [Microsoft URLs](../global-secure-access/how-to-configure-connectors.md#allow-access-to-urls).
- To test VPN replacement, you need the IP ranges and FQDNs that are used for full access to your corporate network.
- To test per-app Zero Trust network access by using Microsoft Entra Private Access, identify one or more test applications. You need the IP addresses or FQDNs, protocols, and ports that clients use when they access each test application.

To test Microsoft traffic scenarios, you need Microsoft 365 products such as SharePoint Online or Exchange Online.

## Configure the product for use cases

After you meet the prerequisites, use the following sections as steps to configure your test environment.

### 1. Enable the product in your tenant

Enable each product's traffic profile for Global Secure Access to acquire and tunnel traffic for that product area. Assign users and groups to the profile so that the Global Secure Access client for those users acquires and routes traffic to Global Secure Access. The following articles define the required [roles](../global-secure-access/reference-role-based-permissions.md#role-based-permissions) for those tasks:

- [Enable and manage the Microsoft profile](../global-secure-access/how-to-manage-microsoft-profile.md)
- [Manage the Private Access profile](../global-secure-access/how-to-manage-private-access-profile.md)
- [Manage the Internet Access profile](../global-secure-access/how-to-manage-internet-access-profile.md)
- [Assign users and groups to traffic forwarding profiles](../global-secure-access/how-to-manage-users-groups-assignment.md)

### 2. Install the Global Secure Access client

Install the Global Secure Access client on each client device that connects to Global Secure Access services. Ensure that your test devices meet prerequisites. Review [Known limitations for Global Secure Access](../global-secure-access/reference-current-known-limitations.md).

- Install the [Global Secure Access client for Windows](../global-secure-access/how-to-install-windows-client.md).
- Install the [Global Secure Access client for macOS](../global-secure-access/how-to-install-macos-client.md).
- Install the [Global Secure Access client for Android](../global-secure-access/how-to-install-android-client.md).
- Install the [Global Secure Access client for iOS (preview)](../global-secure-access/how-to-install-ios-client.md).

To deploy the client to multiple devices, use Intune or another mobile device management solution.

### 3. Configure Microsoft Entra Private Access

For detailed steps, see the [Configure Microsoft Entra Private Access](gsa-poc-private-access.md) article.

### 4. Configure Microsoft Entra Internet Access

For detailed steps, see the [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md) article.

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

- [Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Configure Microsoft Entra Internet Access](gsa-poc-internet-access.md)
- [Introduction to the Microsoft Global Secure Access deployment guide](gsa-deployment-guide-intro.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft traffic](gsa-deployment-guide-microsoft-traffic.md)
