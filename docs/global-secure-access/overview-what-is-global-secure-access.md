---
title: What is Global Secure Access?
description: Learn how Microsoft's Security Service Edge (SSE) solution, Global Secure Access, provides network access control and visibility to users and devices inside and outside a traditional office.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: overview
ms.date: 04/30/2025
ms.service: global-secure-access
ms.custom: references_regions
ai-usage: ai-assisted

# Customer intent: As a customer, I want to learn how Microsoft's Security Service Edge (SSE) solution, Global Secure Access, provides network access control and visibility to users and devices inside and outside a traditional office.
---

# What is Global Secure Access?

The way people work changed. Instead of working in traditional offices, people now work from nearly anywhere. As applications and data move to the cloud, the modern workforce needs an identity-aware, cloud-delivered network perimeter. This new network security category is called Security Service Edge (SSE).

Microsoft Entra Internet Access and Microsoft Entra Private Access comprise Microsoft's Security Service Edge (SSE) solution. Global Secure Access is the unifying term used for both Microsoft Entra Internet Access and Microsoft Entra Private Access. Global Secure Access is the unified location in the Microsoft Entra admin center. Global Secure Access is built upon the core principles of Zero Trust to use least privilege, verify explicitly, and assume breach.

![Diagram of the Global Secure Access solution, illustrating how identities and remote networks can connect to Microsoft, private, and public resources through the service.](media/overview-what-is-global-secure-access/global-secure-access-diagram.png)

## Microsoft's Security Service Edge (SSE) solution

Microsoft Entra Internet Access and Microsoft Entra Private Access - coupled with Microsoft Defender for Cloud Apps, our SaaS-security focused Cloud Access Security Broker (CASB) - are uniquely built as a solution that converges network, identity, and endpoint access controls so you can secure access to any app or resource, from anywhere. With the addition of these Global Secure Access products, Microsoft Entra ID simplifies access policy management and enables access orchestration for employees, business partners, and digital workloads. You can continuously monitor and adjust user access in real time if permissions or risk level changes.

The Global Secure Access features streamline the roll-out and management of the access control capabilities with a unified portal. These features are delivered from Microsoft's Wide Area Network, spanning 140+ regions and 190+ network edge locations. This private network, which is one of the largest in the world, enables organizations to optimally connect users and devices to public and private resources seamlessly and securely. For a list of the current points of presence, see [Global Secure Access points of presence article](reference-points-of-presence.md).

## Microsoft Entra Internet Access

Microsoft Entra Internet Access protects access to internet and SaaS apps with an identity-based Secure Web Gateway (SWG), blocking threats, unsafe content, and malicious traffic.

### Key features

- Acquire network traffic using the user aware internet traffic forwarding profile, either from the desktop client or from a remote network, such as a branch location. 
- Detailed network traffic logs for internet traffic (including enforced policy details). Dashboards such as relationship maps between users, devices and endpoints, cross tenant access, and top network destination in use.
- Use rich context awareness (user, device, location, risk, and compliance policy) while applying network security policies through integration with Conditional Access. Protect user access to the public internet while using Microsoft's cloud-delivered, identity-aware SWG solution.
- Enable web content filtering to regulate access to internet destinations based on their web-content categories and/or FQDN-domain names.
- Apply universal Conditional Access policies for all internet destinations, even if not federated with Microsoft Entra ID, through integration with Conditional Access session controls.

## Microsoft Entra Internet Access for Microsoft Services
Microsoft Entra Internet Access for Microsoft services enhances Microsoft Entra ID capabilities with direct connectivity to supported Microsoft services, improving security, performance, and resilience.

### Key Features 

- Connect to Microsoft services directly using the prepopulated Microsoft traffic forwarding profile, either from the desktop client or from a remote network, such as a branch location.
- Simplify Conditional Access policy configurations by requiring Compliant Network check for any Microsoft Entra ID integrated application with Microsoft Entra ID Conditional Access. 
- Apply Universal Tenant Restrictions to reduce the risk of data exfiltration to unauthorized foreign tenants or personal accounts.
- Increase the accuracy of threat detections with source IP restoration for the Microsoft Entra ID sign in logs.
- Detailed network traffic logs for Microsoft traffic (including enforced policy details). Dashboards such as relationship maps between users, devices and endpoints, cross tenant access, and top network destination in use.

## Microsoft Entra Private Access

Microsoft Entra Private Access provides your users - whether in an office or working remotely - secured access to your private, corporate resources. Microsoft Entra Private Access builds on the capabilities of Microsoft Entra application proxy and extends access to any private resource, port, and protocol.

Remote users connect to private apps across hybrid and multicloud environments, private networks, and data centers from any device and network without requiring a VPN. The service offers per-app adaptive access based on Conditional Access policies, for more granular security than a VPN.

### Key features

- Zero Trust-based access to a range of IP addresses and/or Fully Qualified Domain Names (FQDNs) without requiring a legacy VPN. This feature is known as Quick Access.
- Per-app access for Transmission Control Protocol (TCP) and User Datagram Protocol (UDP) applications.
- Modernize legacy app authentication with deep Conditional Access integration.
- Provide a seamless end-user experience by acquiring network traffic from the desktop client and deploying side-by-side with your existing non-Microsoft SSE solutions.

## Licensing overview
Microsoft Entra Internet Access, Microsoft Entra Internet Access for Microsoft services, and Microsoft Entra Private Access are now generally available. 

- Microsoft Entra Internet Access capabilities are included in the Microsoft Entra Suite license and standalone. Microsoft Entra Internet Access helps you secure access to all internet and SaaS applications. 
- Microsoft Entra Private Access capabilities are included in the Microsoft Entra Suite license and standalone. Microsoft Entra Private Access elevates network security with a Zero Trust Network Access (ZTNA) solution. 
- Microsoft Entra Internet Access for Microsoft services capabilities are included in a Microsoft Entra ID P1 or Microsoft Entra ID P2 license. Microsoft Entra Internet Access for Microsoft services enhances Microsoft Entra ID capabilities with direct connectivity to supported Microsoft services, improving security, performance, and resilience.

Prerequisite to use Microsoft Entra Private Access and Microsoft Entra Internet Access is Microsoft Entra ID P1 or Microsoft Entra ID P2.

To learn more about licensing costs and the Microsoft Entra Suite, see [Microsoft Entra Plans & Pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing). To learn more about purchasing individual license, see the Microsoft Entra Suite standalone products tab of the licensing page.

> [!IMPORTANT]
> Licensing enforcement for Microsoft Entra Private Access and Microsoft Entra Internet Access will begin to roll out on October 1, 2024. Enforcement follows a 90-day trial period that began with General Availability on July 1, 2024.


### Feature comparison table

| Feature                          | Entra P1/P2 License - Microsoft traffic profile | Internet Access License* - Internet Access profile | Private Access License* - Private Access profile |
|----------------------------------|:----------------------------------------------:|:-------------------------------------------------:|:-----------------------------------------------:|
| Windows client                   | ✅                                              | ✅                                               | ✅                                              |
| macOS client                     | ✅                                              | ✅                                               | ✅                                              |
| Mobile client (iOS, Android)     | ✅                                              | ✅                                               | ✅                                              |
| Traffic logs                     | ✅                                              | ✅                                               | ✅                                              |
| Remote network (branch connectivity) | ✅                                          | ✅                                               |                                                  |
| Universal Tenant Restrictions    | ✅                                              |                                                   |                                                  |
| Compliant network check          | ✅                                              |                                                   |                                                  |
| Source IP restoration            | ✅                                              |                                                   |                                                  |
| Microsoft 365 Enriched logs      | ✅                                              |                                                   |                                                  |
| Universal Conditional Access (CA)| ✅                                              | ✅                                               |                                                  |
| Context-aware network security   |                                                  | ✅                                               |                                                  |
| Web category filtering           |                                                  | ✅                                               |                                                  |
| Fully qualified domain name (FQDN) filtering |                                      | ✅                                               |                                                  |
| Universal Continuous Access Evaluation (CAE) | ✅                                   | ✅                                               | ✅                                              |
| VPN replacement with an identity-centric ZTNA |                                     |                                                   | ✅                                              |
| Quick Access                     |                                                  |                                                   | ✅                                              |
| App Discovery                    |                                                  |                                                   | ✅                                              |
| Private Domain Name System (DNS) |                                                  |                                                   | ✅                                              |
| Single sign-on across all private apps |                                            |                                                   | ✅                                              |
| Marketplace availability         |                                                  |                                                   | ✅                                              |
| Private network connector multicloud support |                                     |                                                   | ✅                                              |

*Included in Microsoft Entra Suite

**Remote Network licensing**

The remote network (branch connectivity) feature is included in both the Microsoft Entra ID P1 license for Microsoft traffic, and the Microsoft Entra Internet Access license for Internet Traffic (coming soon). You must have a combined total of at least 50 licenses from Microsoft Entra ID P1 and Microsoft Entra Internet Access to enable  remote network connectivity. For details on how much bandwidth is allocated, see [Understand remote network connectivity](concept-remote-network-connectivity.md#how-much-bandwidth-will-be-allocated-per-tenant). To learn more about remote networks, see [How to create a remote network with Global Secure Access](how-to-create-remote-networks.md).


## Related content

- [Video: 425 Show "Is Global Secure Access Right for You?"](https://youtu.be/2OSbu7d8IOU)
- [Get started with Global Secure Access](how-to-get-started-with-global-secure-access.md)
- [Stay in the loop with the latest Microsoft Entra ID updates](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/bg-p/Identity)
