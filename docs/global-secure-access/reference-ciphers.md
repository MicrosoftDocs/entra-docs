---
title: Ciphers used for Microsoft Entra Private Access  
description: Learn about the Ciphers used for Microsoft Entra Private Access
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.topic: reference
ms.date: 02/05/2025
ms.service: global-secure-access
ms.reviewer: 


---

# Ciphers used for Microsoft Entra Private Access
Microsoft Entra private network connector supports Transport Layer Security (TLS) 1.2, TLS 1.3, and higher, according to the TLS version the customer chooses to enforce. 

## Cipher suites
A cipher suite is a set of cryptographic algorithms. Based on the TLS version that the customer chooses to enforce, the proxy chooses a given set of cipher suites. TLS 1.2 and TLS 1.3 use the default Windows ciphers.

For a full list of supported ciphers, see the [SSL Server Test (Powered by Qualys SSL Labs)](https://www.ssllabs.com/ssltest/analyze.html?d=testtls13-hipcanary.msappproxy.net).   
:::image type="content" source="media/reference-ciphers/cipher-suites.png" alt-text="Screenshot of the list of cipher suites as part of the SSL report.":::   

## Filter ciphers
The connector operating system (OS) determines which ciphers to use and which to filter out of the default list of ciphers for TLS 1.2 and TLS 1.3.  

To filter by OS and see the list of ciphers, you can use a protocol analyzer such as Wireshark to view specific requests to the connector. 

## Related content
[Understand the Microsoft Entra private network connector](concept-connectors.md)







