---
title: What is Transport Layer Security Inspection? (Preview)
description: "This article provides an overview of the Transport Layer Security (TLS) inspection process and how it increases security between two communicating parties."
author: HULKsmashGithub
ms.author: jayrusso
manager: femila
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 05/27/2025

#customer intent: As a Global Secure Access administrator, I want to learn about the Transport Layer Security (TLS) protocol to support the creation of TLS inspection policies.   

---
# What is Transport Layer Security inspection? (Preview)
The Transport Layer Security (TLS) protocol uses certificates at the transport layer to ensure the privacy, integrity, and authenticity of data exchanged between two communicating parties. While TLS secures legitimate traffic, malicious traffic like malware and data leakage attacks can still hide behind encryption. The Microsoft Entra Internet Access TLS inspection capability provides visibility into encrypted traffic by making content available for enhanced protection, such as malware detection, data loss prevention, prompt inspection, and other advanced security controls.

> [!IMPORTANT]
> The Transport Layer Security inspection feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.   

This article provides an overview of the TLS inspection process.

## The TLS inspection process
When you create a TLS inspection policy to inspect traffic, the Global Secure Access service first decrypts HTTPS requests at the service edge, then applies security controls. If no security controls block the request, Global Secure Access forwards it to the destination. This process establishes two separate TLS connections:   
- One from the client browser to Global Secure Access.   
- Another from Global Secure Access to the destination server.   

The Global Secure Access service creates an intermediate certificate signed by a customer certificate authority. Global Secure Access uses this intermediate certificate to generate short-lived leaf certificates. TLS uses these leaf certificates in handshakes between client devices and Global Secure Access. Client devices need to install the customer's root certificate authority in their trusted certificate store. The browser validates the certificate chain in the browser's certificate store.
<!-- Art Library Source# ConceptArt-0-000-047 -->
:::image type="content" source="media/concept-transport-layer-security/inspection-process-diagram.png" alt-text="Diagram that shows the Transport Layer Security (TLS) inspection process." lightbox="media/concept-transport-layer-security/inspection-process-diagram-expanded.png":::

To get started with TLS inspection, see [Configure Transport Layer Security](how-to-transport-layer-security.md). 

## Supported TLS cipher suites
Microsoft Entra TLS inspection enables TLS 1.2 and TLS 1.3 by default. However, Microsoft Entra doesn't support TLS 1.3 with Encrypted Client Hello (ECH).

TLS supports the following ciphers:
- [ECDHE-ECDSA-AES128-GCM-SHA256|ECDHE-ECDSA-CHACHA20-POLY1305]   
- [ECDHE-RSA-AES128-GCM-SHA256|ECDHE-RSA-CHACHA20-POLY1305]   
- [ECDHE-ECDSA-AES256-GCM-SHA384]

## Related content

* [Configure Transport Layer Security](how-to-transport-layer-security.md)
* [Frequently asked questions for Transport Layer Security inspection](<resource-faq.yml>)
* [Ciphers for Microsoft Entra Private Access](reference-ciphers.md)
