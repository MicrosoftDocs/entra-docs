---
title: What is Transport Layer Security Inspection? (Preview)
description: "This article provides an overview of the Transport Layer Security (TLS) inspection process and how it increases security between two communicating parties."
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 05/28/2025

#customer intent: As a Global Secure Access administrator, I want to learn about the Transport Layer Security (TLS) protocol to support the creation of TLS inspection policies.   

---
# What is Transport Layer Security inspection?
The Transport Layer Security (TLS) protocol uses certificates at the transport layer to ensure the privacy, integrity, and authenticity of data exchanged between two communicating parties. While TLS secures legitimate traffic, malicious traffic like malware and data leakage attacks can still hide behind encryption. The Microsoft Entra Internet Access TLS inspection capability provides visibility into encrypted traffic by making content available for enhanced protection, such as malware detection, data loss prevention, prompt inspection, and other advanced security controls. This article gives an overview of the TLS inspection process.

## The TLS inspection process
When you enable TLS inspection, Global Secure Access decrypts HTTPS requests at the service edge and applies security controls like full URL enhanced web content filtering policies. If no security control blocks the request, Global Secure Access encrypts and forwards the request to the destination.

To enable TLS inspection, follow these steps:
1. Generate a certificate signing request (CSR) in the Global Secure Access portal and sign the CSR using your organization's root or intermediate certificate authority.
1. Upload the signed certificate to the portal.    
 
Global Secure Access uses this certificate as an intermediate certificate authority for TLS inspection. During traffic interception, Global Secure Access dynamically generates short lived leaf certificates using the intermediate certificate. TLS inspection establishes two separate TLS connections:
- One from the client browser to a Global Secure Access service edge
- One from Global Secure Access to the destination server   

Global Secure Access uses leaf certificates during TLS handshakes between client devices and the service. To ensure successful handshakes, install your root certificate authority, and intermediate certificate authority if used for signing the CSR, in the trusted certificate store on all client devices.

<!-- Art Library Source# ConceptArt-0-000-047 -->
:::image type="content" source="media/concept-transport-layer-security/inspection-process-diagram.png" alt-text="Diagram that shows the Transport Layer Security (TLS) inspection process." lightbox="media/concept-transport-layer-security/inspection-process-diagram-expanded.png":::

Traffic logs include four TLS-related metadata fields that help you understand how TLS policies are applied:
- _TlsAction_: Bypassed or Intercepted
- _TlsPolicyId_: The unique identifier of the applied TLS policy
- _TlsPolicyName_: The readable name of the TLS policy for easier reference
- _TlsStatus_: Success or Failure 

To get started with TLS inspection, see [Configure Transport Layer Security](how-to-transport-layer-security.md). 

## Supported Cyphers
|List of supported cyphers  |
|-------------------|
|ECDHE-ECDSA-AES128-GCM-SHA256|
|ECDHE-ECDSA-CHACHA20-POLY1305| 
|ECDHE-RSA-AES128-GCM-SHA256|
|ECDHE-RSA-CHACHA20-POLY1305| 
|ECDHE-ECDSA-AES128-SHA| 
|ECDHE-RSA-AES128-SHA| 
|AES128-GCM-SHA256| 
|AES128-SHA|
|ECDHE-ECDSA-AES256-GCM-SHA384|
|ECDHE-RSA-AES256-GCM-SHA384 |
|ECDHE-ECDSA-AES256-SHA |
|ECDHE-RSA-AES256-SHA |
|AES256-GCM-SHA384| 
|AES256-SHA |
## Known limitations
TLS inspection has the following known limitations:
- TLS inspection supports up to 100 policies, 1000 rules, and 8000 destinations.
- Make sure each certificate signing request (CSR) you generate has a unique certificate name and isn't reused. The signed certificate must stay valid for at least 6 months.
- You can use only one active certificate at a time.
- TLS inspection doesn't support HTTP/2 negotiation. Most sites automatically fall back to HTTP/1.1 and continue to work, but sites that require HTTP/2 won't load if TLS inspection is enabled. Add a custom TLS bypass rule to allow access to HTTP/2 only sites.
- TLS inspection doesn't follow Authority Information Access (AIA) and Online Certificate Status Protocol (OCSP) links when validating destination certificates.
## Mobile platform
- Many mobile applications implement certificate pinning, which prevents successful TLS inspection, resulting in handshake failures or loss of functionality. To reduce risk, enable TLS inspection in a test environment first and validate that critical applications are compatible. For apps that rely on certificate pinning, configure TLS inspection custom rules to bypass these destinations using domain-based or category-based rules.

## Related content

* [Configure Transport Layer Security Policies](how-to-transport-layer-security.md)

* [Configure Transport Layer Security Settings](how-to-transport-layer-security-settings.md)

* [Frequently asked questions for Transport Layer Security inspection](faq-transport-layer-security.yml)
