---
title: Transport Layer Security Inspection Overview
description: "This article provides an overview of the Transport Layer Security (TLS) inspection process and how it increases security between two communicating parties."
author: HULKsmashGithub
ms.author: jayrusso
manager: femila
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 03/10/2025

#customer intent: As a Global Secure Access administrator, I want to learn about the Transport Layer Security (TLS) protocol to support the creation of TLS inspection policies.   

---
# Transport Layer Security inspection overview
The Transport Layer Security (TLS) protocol uses certificates at the transport layer to ensure the privacy, integrity, and authenticity of data exchanged between two communicating parties. This article provides an overview of the TLS inspection process, highlighting how it enhances security by enabling visibility into encrypted traffic. With TLS inspection, Global Secure Access administrators can effectively create and manage TLS inspection policies to detect and mitigate threats hidden within encrypted communications.

## The TLS inspection process
TLS secures application-layer protocols, like HTTP, by encrypting transmitted data. While TLS secures legitimate traffic, malicious traffic, such as malware and data leakage attacks, can still be hidden behind encryption.

The Microsoft Entra TLS inspection process brings visibility into encrypted traffic by making content available for malware detection, data loss prevention, prompt inspection, and other advanced security controls for enhanced protection.

When you create a TLS inspection policy to inspect traffic, the Global Secure Access service terminates HTTPS requests at the service edge first and then applies security controls. If no security controls block it, Global Secure Access forwards the request to the destination. The process establishes two separate TLS connections: 
- One from the client browser to Global Secure Access.
- The other from Global Secure Access to the destination server.

The Global Secure Access service creates an intermediate certificate signed by your trusted Certificate Authority (CA) to generate short-lived leaf certificates. These leaf certificates are used in TLS handshakes between client devices and Global Secure Access. Client devices must have the trusted CA in their trusted certificate store. The browser validates the certificate chain in the browser’s certificate store.
<!-- Art Library Source# ConceptArt-0-000-047 -->
:::image type="content" source="media/concept-transport-layer-security/inspection-process-diagram.svg" alt-text="Diagram that illustrates the Transport Layer Security (TLS) inspection process.":::

To get started with TLS inspection, see [Configure Transport Layer Security](how-to-transport-layer-security.md). 

## Supported TLS Cipher Suites
Microsoft Entra supports TLS 1.2 and TLS 1.3. TLS 1.2 is the default. 

TLS supports the following ciphers:
- [ECDHE-ECDSA-AES128-GCM-SHA256|ECDHE-ECDSA-CHACHA20-POLY1305]   
- [ECDHE-RSA-AES128-GCM-SHA256|ECDHE-RSA-CHACHA20-POLY1305]   
- [ECDHE-ECDSA-AES256-GCM-SHA384]

## Related content

- [Configure Transport Layer Security](how-to-transport-layer-security.md)
- [Transport Layer Security Inspection Frequently asked questions](<resource-faq.yml>)
- [Ciphers for Microsoft Entra Private Access](reference-ciphers.md)
