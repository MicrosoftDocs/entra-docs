---
title: Partner Ecosystem Overview
description: Learn about the Microsoft Secure Access Service Edge (SASE) partner ecosystem. Learn about partner integrations and partner coexistence.
ms.author: kenwith
author: kenwith
manager: dougeby
ms.topic: overview
ms.date: 08/04/2025
ms.service: global-secure-access
ms.reviewer: abhijeetsinha
ai-usage: ai-assisted
#customer intent: As an administrator, I want to understand the Microsoft SASE partner ecosystem so that I can choose the best approach for my organization's security needs.
---

# Microsoft's SASE partner ecosystem overview

Microsoft's Secure Access Service Edge (SASE) partner ecosystem gives organizations a robust, flexible security framework. Microsoft works with leading security vendors so its SASE solution can integrate with different non-Microsoft products. This integration lets organizations use their existing security investments and strengthen their overall security. This article explains the types of partner integrations and coexistence offerings so you can make informed decisions about how to secure your network infrastructure.

Microsoft works with partners to deliver these categories:

- **Partner integration offerings**: These integrations provide a comprehensive solution that deeply and seamlessly embeds advanced partner capabilities directly inside Microsoft's SASE solution, all within the same interface.
- **Partner coexistence offerings**: These integrations aim to optimize your experience as you deploy Microsoft's SASE solution along with your existing security stacks. 
- **Partner connectivity offerings**: Partners that demonstrate interoperability between their connectivity capabilities and Microsoft's Security Service Edge (SASE) solution.
- **Partner service offerings**: Partners that provide implementation services.

## Partner integration offerings (Preview)

Available partner integrations:

- [Netskope](how-to-netskope-coexistence.md)

## Partner coexistence offerings

The following partners provide coexistence with Microsoft Entra Internet Access and Microsoft Entra Private Access. These side-by-side deployment guides allow you to configure which type of traffic you want to direct to Microsoft's Security Service Edge solution or the partner solution. 

You can choose to direct different types of traffic based on your network needs. Options include:
- Microsoft traffic
- Internet traffic
- Private network traffic

The following partners support coexistence:
- [Cisco](concept-cisco-coexistence.md)
- [Netskope](concept-netskope-coexistence.md)
- [Palo Alto Networks](concept-palo-alto-coexistence.md)
- [Zscaler](how-to-zscaler-coexistence.md)

## Partner connectivity offerings
A core component of Microsoft's Security Service Edge (SSE) solution, Microsoft Entra Internet Access, now integrates seamlessly with various SD-WAN and connectivity providers. These partner integrations enable optimal connections between Microsoft's identity-centric SSE and third-party network infrastructure.   

Organizations can enhance their security posture by linking their Software Defined Wide Area Network (SD-WAN) and connectivity systems to Microsoft's SSE solution for a streamlined experience.

### Automated integrations
The following partners offer automated integrations with Microsoft's SSE solution, allowing customers to securely expand their networks with minimal effort:

| Partner        | Partner documentation | Description    |
|----------------|-----------------------|----------------|
| Aviatrix       | [Aviatrix configuration guide](https://resources.aviatrix.com/home/aviatrixentra-gsa-configuration-guide-getting-started-with-aviatrix-secure-connectivity-to-entra-gsa)       | Aviatrix enables secure, instant access to Microsoft's SASE platform for any application or workload worldwide, offering identity-based zero-trust access to Microsoft 365, the Internet, and public PaaS/SaaS endpoints. Aviatrix Secure Access supports always-on connectivity to Microsoft's SASE for diverse environments, including containers, without needing agents or host configuration.|
|  Netskope | [Netskope One deployment guide](https://community.netskope.com/additional-discussions-9/automating-netskope-one-sd-wan-and-microsoft-entra-sse-integration-7967) | The Netskope One SD-WAN solution automatically integrates with Microsoft’s SSE solution to enable a hybrid SASE architecture. This integration intelligently routes Microsoft 365 traffic to Microsoft's SSE platform, while directing all other traffic to Netskope One SASE, powered by NewEdge—delivering comprehensive SASE services from any user or branch to any cloud, SaaS, or UCaaS application. |
| Teridion       | [Teridion user manual](https://www.teridion.com/wp-content/uploads/2024/11/Teridion-Secure-Connect.pdf) | Teridion Secure Connect combines Teridion Connect with Microsoft's SASE platform to deliver fast, secure internet access. This integration, designed for telecommunications companies and Global System Integrators (GSIs), simplifies operations and enhances service management, benefiting end customers.|

### Template-based integrations
For organizations seeking customization according to their unique network architecture, Microsoft offers templatized integrations with the following partners:

| Partner        | Partner documentation | Description    |
|----------------|-----------------------|----------------|
| Arista Networks | [Arista deployment guide](https://www.arista.com/assets/data/pdf/microsoft-entra-internet-access-with-arista-cv-pathfinder.pdf) | Arista Networks integrates Microsoft Entra Internet Access with Arista CloudVision Pathfinder to deliver secure internet access to Arista Data Center, Campus, Branch, and remote locations. Arista WAN Routing Systems intelligently routes traffic to Microsoft's SASE platform for inspection, ensuring secure internet and SaaS access. |
| Check Point     | [Check Point configuration guide](https://support.checkpoint.com/results/sk/sk182799) | Check Point's Quantum SD-WAN solution brings advanced security to WAN connectivity, seamlessly integrating with Microsoft's SASE platform to optimize and secure Microsoft 365 and internet traffic for customers across distributed locations. This solution combines threat prevention, intelligent traffic management, and streamlined workflows, reducing complexity and strengthening security posture across both network and cloud environments. |
| Cisco Catalyst  | [Cisco Catalyst user guide](https://www.cisco.com/c/en/us/solutions/collateral/enterprise-networks/sd-wan/catalyst-sd-wan-ms-sse-int-ug.html) | The Cisco Catalyst SD-WAN integrations with Microsoft's SASE platform use simplified network deployment and advanced threat protection capabilities to deliver comprehensive security for internet-bound traffic originating from branch offices. All internet traffic is routed to Microsoft's SASE platform for inspection, safeguarding users, devices, and data from evolving threats while securing public internet and SaaS access. |
| Cisco Meraki    | [Meraki configuration guide](https://documentation.meraki.com/MX/Security_Service_Edge_Integrations/Meraki_Secure_SD-WAN_Microsoft_SSE_Configuration_Guide) |The Cisco Meraki SD-WAN integrations with Microsoft's SASE platform use simplified network deployment and advanced threat protection capabilities to deliver comprehensive security for internet-bound traffic originating from branch offices. All internet traffic is routed to Microsoft's SASE platform for inspection, safeguarding users, devices, and data from evolving threats while securing public internet and SaaS access. |
| HPE Aruba       | [Aruba Networking configuration guide](https://arubanetworking.hpe.com/techdocs/sdwan-PDFs/integrations/int_Microsoft-SSE-EC-IPSec_latest.pdf) |HPE Aruba's EdgeConnect SD-WAN solution integrates with Microsoft's SASE platform to support a hybrid SASE architecture. This integration can direct Microsoft 365 or internet traffic to Microsoft's SASE platform and route other traffic to HPE Aruba Networking SSE or alternative SSEs supported within EdgeConnect. Through EdgeConnect's Business Intent Overlays, customers benefit from policy-driven traffic management, ensuring optimized connectivity across SD-WAN branch sites. |
| Juniper Networks | [Juniper deployment guide](https://www.juniper.net/content/dam/www/assets/solution-briefs/us/en/2024/deploying-microsoft-sse-with-juniper-ai-driven-sd-wan.pdf) | Juniper Networks' AI Driven SD-WAN solution offers secure and resilient connectivity tailored for today's enterprises. Juniper Networks uses AI Native insights and automation to streamline deployment processes and significantly improve operations. Juniper's AI Driven SD-WAN solution integrates with Microsoft's SASE platform to provide seamless access from branch and office locations, using scalable device templates to ease the operational burden of deploying the service to many sites. |
| Netskope | [Netskope SD-WAN configuration guide](https://community.netskope.com/discussions-37/microsoft-s-sse-netskope-sd-wan-configuration-guide-7854?tid=7854&fid=37) | Netskope One SD-WAN directs Microsoft traffic to Microsoft's SSE solution for fast, secure access. With powerful automation for Zero Touch Provisioning, this solution streamlines deployment at scale. Customers and partners can quickly onboard sites and reduce operational costs. |
| Versa Networks   | [Versa configuration guide](https://versa-networks.com/documents/reports/Versa-Interoperability-MSEntra_v1-1b.pdf) | Versa Secure SD-WAN, in combination with Microsoft's SASE Platform, addresses potential vulnerabilities by building a robust and resilient security posture against a wide range of threats. Versa Secure SD-WAN complements Microsoft Entra Internet Access by providing agile, secure network connectivity with integrated network security for an improved user and optimized access experience. |

## Partner service offerings

Microsoft works with many service partners. To learn more, see [Find a Microsoft services partner](how-to-find-microsoft-services-partners.md).
