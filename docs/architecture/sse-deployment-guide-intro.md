---
title: Microsoft Security Service Edge Solution Deployment Guide Introduction
description: Introduction to Microsoft Entra Private Access and Microsoft Entra Internet Access for M365 deployments
services: active-directory
author: jricketts
manager: martinco
ms.service: network-access
ms.topic: conceptual
ms.date: 12/5/2023
ms.author: jricketts
---


# Introduction to Microsoft Security Service Edge Solution Deployment Guide for Proof of Concept

This Proof of Concept (PoC) Deployment Guide helps you to deploy Microsoft's Security Service Edge (SSE) solution that features [Microsoft Entra Internet Access for M365](../global-secure-access/how-to-manage-microsoft-365-profile.md) and Microsoft Entra Private Access. 

## Overview

[Microsoft's identity-centric Security Service Edge solution](../global-secure-access/overview-what-is-global-secure-access.md) converges network, identity, and endpoint access controls so that you can secure access to any app or resource, from any location, device, or identity. It enables and orchestrates access policy management for employees, business partners, and digital workloads. You can continuously monitor and adjust user access in real time if permissions or risk level changes to your private apps, SaaS apps, and Microsoft 365 endpoints.

### Business value

With the ongoing rise of a hybrid and modern workforce, it's important to recognize and adopt new ways of implementing security. Strained and challenged traditional corporate networks result in higher security risks and poor user experience. Legacy approaches present key challenges:​

- Inconsistent and inefficient security controls​
- Security gaps from siloed solutions and policies​
- Higher operational complexities and cost​
- Limited resources and technical skills​

Microsoft's Security Service Edge solution helps to protect all stages of digital communication. It leverages Microsoft's vast global network to minimize latency and boost employee productivity with fast and seamless access to apps and resources.​

Built on Zero Trust principles, this easy-to-deploy SSE solution protects against threats with comprehensive, cloud-delivered security services: Zero Trust Network Access (ZTNA), secure web gateway (SWG), cloud access security broker (CASB), and deep integrations across the Microsoft security ecosystem. Unified identity and network access controls help you to easily manage granular access policies in one place to eliminate gaps in defenses and reduce operational complexity.

The unified Zero Trust architecture and policy engine simplifies access control and technology management for directory, single sign-on (SSO), federation, role-based access control (RBAC), proxy. To enforce access to your data, consistently apply a centralized policy across corporate resources such as identity, data, network plus infrastructure, and apps across cloud, on-premises, Internet of Things (IoT), and operational technology (OT).

- **Enforce unified adaptive access controls.** Eliminate gaps in your defenses and protect access end-to-end by extending [Microsoft Entra Conditional Access](../identity/conditional-access/overview.md) and [continuous access evaluation](../identity/conditional-access/concept-continuous-access-evaluation.md) (CAE) to any application, resource, or other network destination. ​
- **Simplify network access security​.** Minimize risk from threats and escape the complexity and cost of traditional stand-alone network security tools with comprehensive, simple to deploy, cloud-delivered security services.
- **Deliver a great user experience anywhere and boost hybrid work productivity.** Provide fast and seamless access through a globally distributed secure network edge with Points of Presence (PoP) closest to the user. Eliminate extra hops to optimize traffic routing to apps and resources on-premises, across clouds, and anywhere in between.
- **Integrated fabric**. Converged identity and network access controls secure access to all apps and resources. ​

### Microsoft Security Service Edge solution features

**Microsoft Entra Internet Access** helps you to secure access to all internet, SaaS, and Microsoft 365 apps and resources while protecting your organization against internet threats, malicious network traffic, and unsafe or noncompliant content. Microsoft Entra Internet Access unifies access controls in a single policy to close security gaps and minimize cyberthreat risk. It simplifies and modernizes traditional network security to protect users, apps, and resources. Advanced capabilities include universal access controls, universal tenant restriction, token protection, web content filtering, cloud firewall, threat protection, and Transport Layer Security (TLS) inspection.

​**Microsoft Entra Internet Access for ​Microsoft 365** features adaptive access, robust data exfiltration controls, and token theft protection. Resiliency through redundant tunnels provides best-in-class security and granular visibility for Microsoft 365, the world's most widely adopted productivity app. ​Choose what works best for your organization with flexible deployment options: a complete SSE solution by Microsoft or a side-by-side deployment with other SSE solutions. For example, you can deploy Microsoft Entra Internet Access for Microsoft 365 to gain unique security, visibility, and optimized access for Microsoft 365 apps while keeping your existing SSE solution for other resources. Microsoft Entra Internet Access for M365 offers scenarios that enhance security and improve your Zero Trust architecture and end user experience.

- Protect against data exfiltration by deploying tenant restrictions v2 and enforcing compliant network location with Conditional Access (see Sample PoC scenario: protect against data exfiltration).
- Restore source IP address from original egress IP to enhance security logs, maintain compatibility with configured named locations in Conditional Access, and retain identity protection location-related risk detections (see Sample PoC scenario: source IP address restoration).

**Microsoft Entra Private Access** helps you to secure access to private apps and resources for users anywhere with ZTN1. ​Built on Zero Trust principles, Microsoft Entra Private Access removes the risk and operational complexity of legacy virtual private networks (VPN) while boosting user productivity. Replace legacy VPNs with ZTNA to minimize the risk of implicit trust and lateral movement. Quickly and securely connect remote users from any device and any network to private apps: on-premises, across clouds, and in between. Eliminate excessive access and stop lateral threat movement with automatic app discovery, easy onboarding, adaptive per-app access control, granular app segmentation, and intelligent local access.

## Prepare for your Proof of Concept project

Technology project success depends on managing expectations, outcomes, and responsibilities. Follow the guidance in this section to ensure the best results from your Proof of Concept (PoC) project.

### Identify stakeholders

When beginning your deployment plans, include your key stakeholders. Identify and document stakeholders, roles, responsibilities. Titles and roles can differ from one organization to another; however, the ownership areas are similar.

|Role|Responsibility|
| - | - |
|Sponsor|An enterprise senior leader with authority to approve and/or assign budget and resources. Connection between managers and the executive team. Technical decision maker for product and feature implementation.|
|End user|The people for whom you have implemented the service. Users can participate in a pilot program.|
|IT support manager|Provides input on proposed change supportability.|
|Identity architect or Azure global administrator|Defines how the change aligns with identity management infrastructure. Understands the current environment.|
|Application business owner|Owns the affected applications that might include access management. Provides input on the user experience.|
|Security owner|Confirms that the change plan meets security requirements.|
|Compliance manager|Ensures compliance with corporate, industry, and governmental requirements.|
|Technical program manager|Oversees the project, manages requirements, coordinates work streams, and ensures adherence to schedule and budget. Facilitates communication plan and reporting.|
|Tenant administrator|IT owners and technical resources responsible for Microsoft Entra ID tenant changes during all phases.|

### Create a RACI chart

The RACI acronym refers to the key responsibilities: Responsible, Accountable, Consulted, Informed. For your project and cross-functional or departmental projects and processes, define and clarify roles and responsibilities in a RACI chart.

### Plan communications

Proactively and regularly communicate with your users about pending and current changes. Inform them about how and when the experience changes. Provide them with a support contact. Manage internal communications and expectations within your team and leadership according to your RACI chart.

### Establish timelines

Set realistic expectations and make contingency plans to meet key milestones:

- Proof of Concept (PoC)
- Pilot date
- Launch date
- Dates that affect delivery
- Dependencies

For the Proof of Concept in this guide, you need about six hours. Plan across these stages that link to corresponding sections for detail:

- Configure prerequisites: 1 hour
- Configure initial product: 20 minutes
- Configure remote network: 1 to 2 hours
- Deploy and test Microsoft Entra Internet Access for M365: 1 hour
- Deploy and test Microsoft Entra Private Access: 1 hour
- Close PoC: 30 minutes
- Share your feedback with Microsoft: 30 minutes

### Obtain permissions

Administrators who interact with [Global Secure Access](../global-secure-access/overview-what-is-global-secure-access.md)  preview features require the Global Secure Access Administrator and Application Administrator [roles](~/identity/role-based-access-control/permissions-reference.md).

Universal tenant restrictions require the Conditional Access Administrator or Security Administrator role to create and interact with Conditional Access policies and named locations. Some features may also require other roles. 

## Configure prerequisites

To successfully deploy and test Microsoft Security Service Edge, configure the following prerequisites:

1. Microsoft Entra ID tenant with Microsoft Entra ID Premium P1 license. You can [purchase licenses or obtain trial licenses](https://www.microsoft.com/en-us/security/business/microsoft-entra-pricing).
   1. One user with at least the Global Secure Access Administrator and Application Administrator roles to configure Microsoft Security Service Edge features.
   1. At least one user or group that functions as the client test user in your tenant.
   1. One test user in a foreign tenant to test tenant restrictions.
1. One Windows client device with the following configuration:
   1. Windows 10/11 64-bit version.
   1. Microsoft Entra ID joined or hybrid joined.
   1. Internet connected and no corpnet access or VPN.
1. Download and install the Global Secure Access Client on the client device. [The Global Secure Access Client for Windows](../global-secure-access/how-to-install-windows-client.md) article helps in understanding prerequisites and installation.
1. To test Microsoft Entra Private Access, one Windows server that functions as the application server with the following configuration:
   1. Windows Server 2012 R2 or later.
   1. One test application that the application server hosts. This guide uses remote desktop protocol (RDP) and access to a file share as examples.
1. To test Microsoft Entra Private Access, one Windows server that functions as the connector server with the following configuration:
   1. Windows Server 2012 R2 or later.
   1. Network connectivity to Microsoft Entra ID Service.
   1. Ports 80 and 443 [open to outbound traffic](../global-secure-access/how-to-configure-connectors.md#open-ports).
   1. Allow access to [required URLs](../global-secure-access/how-to-configure-connectors.md#allow-access-to-urls).
1. Establish connectivity between the connector server and the application server. Confirm that you can access your test application on the application server (for example, successful RDP connection and file share access).

The following diagram illustrates the minimum architecture requirements to deploy and test Microsoft Entra Private Access.

:::image type="complex" source="media/sse-deployment-guide-intro/diagram-private-access-architecture-inline.png" alt-text="Diagram that shows minimum required architecture components for Entra ID tenant." lightbox="media/sse-deployment-guide-intro/diagram-private-access-architecture-expanded.png"::: 

## Configure initial product

Follow the steps in this section to configure SSE through the Microsoft Entra admin center and install the Global Secure Access Client on your Windows 10/11 client device.

### Configure Microsoft SSE through the Microsoft Entra admin center

Activate Microsoft SSE through the Microsoft Entra admin center and make initial configurations that are requirements for this PoC.

1. Open the [Microsoft Entra admin center](https://entra.microsoft.com) using an identity assigned Global Administrator role.
1. Go to **Global Secure Access (preview)** > **Get started** > **Activate Global Secure Access in your tenant**. Select **Activate** to enable SSE features in your tenant.

   :::image type="complex" source="media/sse-deployment-guide-intro/global-secure-access-main-inline.png" alt-text="Diagram that shows initial activation page for Microsoft Security Service Edge Solution." lightbox="media/sse-deployment-guide-intro/global-secure-access-main-expanded.png"::: 
1. Go to **Global Secure Access (preview)** > **Connect** > **Traffic forwarding**. Turn on **Microsoft 365 profile** and **Private access profile**.

   :::image type="complex" source="media/sse-deployment-guide-intro/traffic-forwarding-profiles-inline.png" alt-text="Diagram that shows how to enable Microsoft 365 and Private access profiles." lightbox="media/sse-deployment-guide-intro/traffic-forwarding-profiles-expanded.png"::: 

Traffic forwarding enables you to configure the type of network traffic to tunnel through the Microsoft Entra Private Access and Microsoft Entra Internet Access for M365 services. You set up [traffic forwarding profiles](../global-secure-access/concept-traffic-forwarding.md) to manage types of traffic. The **Microsoft 365 profile** is for Microsoft Entra Private Access for M365. The **Private access profile** is for Microsoft Entra Private Access. Microsoft Security Service Edge solution only captures traffic on client devices that have Global Secure Access Client installed.
1. To enable source IP restoration, go to **Global Secure Access (preview)** > **Connect** > **Global settings** > **Session management** > **Adaptive Access** and turn on **Enable Global Secure Access signaling in Conditional Access**. Source IP restoration is required to for Conditional Access policies that you will configure as part of this proof of concept.

   :::image type="complex" source="media/sse-deployment-guide-intro/session-management-adaptive-access-inline.png" alt-text="Diagram that shows how to enable conditional access policies for Microsoft Security Service Edge Solution." lightbox="media/sse-deployment-guide-intro/session-management-adaptive-access-expanded.png":::

### Install Global Secure Access Client on your Windows 10/11 client device

Microsoft Entra Internet Access for M365 and Microsoft Entra Private Access use the Global Secure Access Client on Windows devices. This client acquires and forwards network traffic to Microsoft Security Service Edge Solution.

1. Make sure your Windows device is Microsoft Entra joined or hybrid joined.
1. Sign in to the Windows device with a Microsoft Entra user role that has local admin privileges.
1. Open the [Microsoft Entra admin center](https://entra.microsoft.com) using an identity assigned Global Administrator role.
1. Go to **Global Secure Access (preview)** > **Connect** > **Client Download**. Select **Download client** and complete the installation.

   :::image type="complex" source="media/sse-deployment-guide-intro/global-secure-access-clients-inline.png" alt-text="Diagram that shows where to download the Global Secure Access client software." lightbox="media/sse-deployment-guide-intro/global-secure-access-clients-expanded.png":::

1. In the Window taskbar, the Global Secure Access Client first appears as disconnected. After few seconds, you'll be prompted for credentials. Enter your test user's credentials.

1. In the Window taskbar, hover over the Global Secure Access Client icon and verify **Connected** status.

   :::image type="content" source="media/sse-deployment-guide-intro/global-secure-access-client-connected.png" alt-text="Screenshot of the Global Secure Access Client icon showing Connected status indicator.":::
1. In the Window taskbar, right-click the Global Secure Access Client.

   :::image type="content" source="media/sse-deployment-guide-intro/global-secure-access-client-options.png" alt-text="Screenshot of the Global Secure Access Client options menu.":::
1. Select **Connection Diagnostics** to view **Global Secure Access Client Connection Diagnostics**. Click **Services** and verify that all services show green (running) status.

   :::image type="content" source="media/sse-deployment-guide-intro/global-secure-access-client-connection-diagnostics-services.png" alt-text="Screenshot of the Global Secure Access Client Connection Diagnostics window showing Services tab.":::
1. Click **Channels** and verify **M365** and **Private** show green (correct operation) status.

   :::image type="content" source="media/sse-deployment-guide-intro/global-secure-access-client-connection-diagnostics-channels.png" alt-text="Screenshot of the Global Secure Access Client Connection Diagnostics window showing Channels tab.":::
1. If desired, use the **Client Checker** tool to confirm network connection and traffic routing status.

## Next steps
[Deploy and verify Microsoft Entra Internet Access for M365](sse-deployment-guide-m365.md)

