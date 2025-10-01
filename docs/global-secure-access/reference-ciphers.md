---
title: Ciphers for Microsoft Entra Private Access  
description: Learn about the supported cryptographic algorithms, or ciphers, used for Microsoft Entra Private Access.
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.topic: reference
ms.date: 02/18/2025
ms.service: global-secure-access
ms.reviewer: sumeetmittal


---

# Ciphers for Microsoft Entra Private Access
Microsoft Entra private network connector supports Transport Layer Security (TLS) 1.2, TLS 1.3, and higher, according to the TLS version the customer chooses to enforce. 

## Cipher suites
A cipher suite is a set of cryptographic algorithms used to create a secure connection. TLS 1.2 and TLS 1.3 use the default Windows ciphers. 

The following tables list the supported cipher suites for TLS 1.3 and TLS 1.2.    

|# TLS 1.3 (suites in server-preferred order)   |:::no-loc text="":::   |:::no-loc text="":::   |:::no-loc text="":::   |
|---------|---------|---------|---------|
|TLS_AES_256_GCM_SHA384 (0x1302)   |ECDH secp384r1 (eq. 7680 bits RSA)   |FS   |   |
|TLS_AES_128_GCM_SHA256 (0x1301)   |ECDH secp256r1 (eq. 3072 bits RSA)   |FS   |   | 

|# TLS 1.2 (suites in server-preferred order)   |:::no-loc text="":::   |:::no-loc text="":::   |:::no-loc text="":::   |
|---------|---------|---------|---------|
|TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (0xc030)   |ECDH secp384r1 (eq. 7680 bits RSA)   |FS   |   |
|TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (0xc02f)   |ECDH secp256r1 (eq. 3072 bits RSA)   |FS   |   |  
|TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384 (0xc028)   |ECDH secp384r1 (eq. 7680 bits RSA)   |FS   |**WEAK**   |
|TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256 (0xc027)   |ECDH secp256r1 (eq. 3072 bits RSA)   |FS   |**WEAK**   |
|TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (0xc014)   |ECDH secp384r1 (eq. 7680 bits RSA)   |FS   |**WEAK**   |
|TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (0xc013)   |ECDH secp256r1 (eq. 3072 bits RSA)   |FS   |**WEAK**   |
|TLS_RSA_WITH_AES_256_GCM_SHA384 (0x9d)   |   |   |**WEAK**   |
|TLS_RSA_WITH_AES_128_GCM_SHA256 (0x9c)   |   |   |**WEAK**   |
|TLS_RSA_WITH_AES_256_CBC_SHA256 (0x3d)   |   |   |**WEAK**   |
|TLS_RSA_WITH_AES_128_CBC_SHA256 (0x3c)   |   |   |**WEAK**   |
|TLS_RSA_WITH_AES_256_CBC_SHA (0x35)   |   |   |**WEAK**   |
|TLS_RSA_WITH_AES_128_CBC_SHA (0x2f)   |   |   |**WEAK**   |

## Filter ciphers
To determine which of the default TLS 1.2 and TLS 1.3 ciphers to use and which to filter out, consider factors such as:
- The connector operating system.
- The TLS library.
- The application configuration.

To view the list of ciphers:
1. Use a protocol analyzer such as Wireshark to view specific requests to the connector. 
1. Expand the **Client Hello** message.

## Related content
[Understand the Microsoft Entra private network connector](concept-connectors.md)
