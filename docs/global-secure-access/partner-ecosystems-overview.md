---
title: Partner ecosystem overview
description: Learn about the Microsoft Secure Access Service Edge (SASE) partner ecosystem. Learn about partner integrations and partner coexistence.
ms.author: kenwith
author: kenwith
manager: dougeby
ms.topic: overview
ms.date: 06/09/2025
ms.service: global-secure-access
ai-usage: ai-assisted
#customer intent: As a administrator, I want to understand the Microsoft SASE partner ecosystem so that I can decide how partner solutions integrate with Microsoft.
---

# Microsoft's SASE partner ecosystem overview

Microsoft's Secure Access Service Edge (SASE) partner ecosystem is designed to provide organizations with a robust and flexible security framework. Microsoft collaborates with leading security vendors to ensure that its SASE solution can seamlessly integrate with various non-Microsoft products. This integration allows organizations to use their existing security investments while enhancing their overall security posture. In this overview, you'll explore the different types of partner integrations and coexistence offerings available, helping you to make informed decisions about how to best secure your network infrastructure.

We work with our partners to deliver the following categories:

- **Partner integration offerings**: these integrations provide a comprehensive solution that deeply and seamlessly embeds advanced partner capabilities directly inside Microsoft's SASE solution, all within the same interface.
- **Partner coexistence offerings**: these integrations aim to optimize your experience as you deploy Microsoft's SASE solution along with your existing security stacks. 
- **Partner connectivity offerings**: partners that demonstrate interoperability between their connectivity capabilities and Microsoft's Security Service Edge (SASE) solution.
- **Partner service offerings**: Partners that provide implementation services.

## Partner integration offerings (Preview)

The available partner integrations are:

- [Netskope](how-to-netskope-coexistence.md)

## Partner coexistence offerings

The following partners provide coexistence with Microsoft Entra Internet Access and Microsoft Entra Private Access. These side-by-side deployment guides allow you to configure which type of traffic you want to direct to Microsoft's Security Service Edge solution or the partner solution. 

You can choose to direct different types of traffic based on your network needs. Options include:
- Microsoft traffic
- Internet traffic
- Private network traffic

The partners that are demonstrated to provide coexistence include:
- [Cisco](concept-cisco-coexistence.md)
- [Netskope](concept-netskope-coexistence.md)
- [Palo Alto Networks](concept-palo-alto-coexistence.md)
- [Zscaler](how-to-zscaler-coexistence.md)

## Partner connectivity offerings
A core component of Microsoft’s Security Service Edge (SSE) solution, Microsoft Entra Internet Access, now integrates seamlessly with various SD-WAN and connectivity providers, enabling optimal connections between Microsoft’s identity-centric SSE and third-party network infrastructure. 
Organizations can enhance their security posture by linking their Software Defined Wide Area Network (SD-WAN) and connectivity systems to Microsoft's SSE solution for a streamlined experience.

The following partners offer automated integrations with Microsoft’s SSE solution, allowing customers to securely expand their networks with minimal effort:

| ISV         | Docs | Description    |
|----------------|-------------------|----------------|
| Aviatrix       | [Deployment guide](https://resources.aviatrix.com/home/aviatrixentra-gsa-configuration-guide-getting-started-with-aviatrix-secure-connectivity-to-entra-gsa)       | Aviatrix enables secure, instant access to Microsoft’s SASE platform for any application or workload worldwide, offering identity-based zero-trust access to Microsoft 365, the Internet, and public PaaS/SaaS endpoints. Aviatrix Secure Access supports always-on connectivity to Microsoft’s SASE for diverse environments, including containers, without needing agents or host configuration.|
| Teridion       | [Deployment guide (PDF format)](https://www.teridion.com/wp-content/uploads/2024/11/Teridion-Secure-Connect.pdf) | Teridion Secure Connect combines Teridion Connect with Microsoft’s SASE platform to deliver fast, secure internet access. This integration, designed for telecommunications companies and Global System Integrators (GSIs), simplifies operations and enhances service management, benefiting end customers.|

For organizations seeking customization according to their unique network architecture, Microsoft offers templatized integrations with the following partners:

| ISV              | Docs                                                                 | Description     |
|------------------|----------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Arista Networks  | [Deployment guide (PDF format)](https://www.arista.com/assets/data/pdf/microsoft-entra-internet-access-with-arista-cv-pathfinder.pdf) | Arista Networks integrates Microsoft Entra Internet Access with Arista CloudVision Pathfinder to deliver secure internet access to Arista Data Center, Campus, Branch, and remote locations. Arista WAN Routing Systems intelligently routes traffic to Microsoft’s SASE platform for inspection, ensuring secure internet and SaaS access. |
| Check Point      | [Deployment guide](https://support.checkpoint.com/results/sk/sk182799) | Check Point’s Quantum SD-WAN solution brings advanced security to WAN connectivity, seamlessly integrating with Microsoft’s SASE platform to optimize and secure Microsoft 365 and internet traffic for customers across distributed locations. This solution combines threat prevention, intelligent traffic management, and streamlined workflows, reducing complexity and strengthening security posture across both network and cloud environments. |
| Cisco Catalyst   | [Solution integration user guide](https://www.cisco.com/c/en/us/solutions/collateral/enterprise-networks/sd-wan/catalyst-sd-wan-ms-sse-int-ug.html) | The Cisco Catalyst SD-WAN integrations with Microsoft’s SASE platform leverage simplified network deployment and advanced threat protection capabilities to deliver comprehensive security for internet-bound traffic originating from branch offices. All internet traffic is routed to Microsoft’s SASE platform for inspection, safeguarding users, devices, and data from evolving threats while securing public internet and SaaS access.|
| Cisco Meraki     | [Configuration guide](https://documentation.meraki.com/MX/Security_Service_Edge_Integrations/Meraki_Secure_SD-WAN_Microsoft_SSE_Configuration_Guide) |The Cisco Meraki SD-WAN integrations with Microsoft’s SASE platform leverage simplified network deployment and advanced threat protection capabilities to deliver comprehensive security for internet-bound traffic originating from branch offices. All internet traffic is routed to Microsoft’s SASE platform for inspection, safeguarding users, devices, and data from evolving threats while securing public internet and SaaS access. |
| HPE Aruba        | [Solution deployment guide (PDF format)](https://www.arubanetworks.com/techdocs/sdwan-PDFs/integrations/int_Microsoft-SSE-EC-IPSec_latest.pdf) |HPE Aruba’s EdgeConnect SD-WAN solution integrates with Microsoft’s SASE platform to support a hybrid SASE architecture. This integration can direct Microsoft 365 or internet traffic to Microsoft’s SASE platform and route other traffic to HPE Aruba Networking SSE or alternative SSEs supported within EdgeConnect. Through EdgeConnect’s Business Intent Overlays, customers benefit from policy-driven traffic management, ensuring optimized connectivity across SD-WAN branch sites. |
| Juniper Networks | [Solution brief (PDF format)](https://www.juniper.net/content/dam/www/assets/solution-briefs/us/en/2024/deploying-microsoft-sse-with-juniper-ai-driven-sd-wan.pdf) | Juniper Networks’ AI Driven SD-WAN solution offers secure and resilient connectivity tailored for today’s enterprises. Leveraging AI Native insights and automation, it streamlines deployment processes and significantly improves operations. Juniper's AI Driven SD-WAN solution integrates with Microsoft’s SASE platform to provide seamless access from branch and office locations, using scalable device templates to ease the operational burden of deploying the service to many sites. |
| Versa Networks   | [Deployment guide (PDF format)](https://versa-networks.com/documents/reports/Versa-Interoperability-MSEntra_v1-1b.pdf) | Versa Secure SD-WAN, in combination with Microsoft’s SASE Platform, addresses potential vulnerabilities by building a robust and resilient security posture against a wide range of threats. Versa Secure SD-WAN complements Microsoft Entra Internet Access by providing agile, secure network connectivity with integrated network security for an improved user and optimized access experience. |

## Partner service offerings

Microsoft partners with many service partners. To learn more, see [Find a Microsoft services partner](how-to-find-microsoft-services-partners.md).
