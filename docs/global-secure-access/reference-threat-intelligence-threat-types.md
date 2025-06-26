---
title: Global Secure Access Threat intelligence threat types
description: Global Secure Access Threat intelligence threat types
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: reference
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-internet-access
ai-usage: ai-assisted
---
# Global Secure Access Threat intelligence threat types

When you set up threat intelligence rules blocking access to high severity threat sites, Microsoft assigns each transaction a threat type. This article provides a list of categories along with explanations.

> [!NOTE]
> You can check a destination's threat type using the Threat Type column in Global Secure Access [Traffic Logs](how-to-view-traffic-logs.md). If you would like to report a false positive, in addition to adding a new rule, you can make a request via email using [this template](mailto:GSAThreatIntel@microsoft.com?subject=%5BCustomer%20Dispute%5D%20%3CDestination%3E%20is%20a%20false%20positive&body=Dispute%20Type%3A%20Threat%20intelligence%20false%20positive%0AURL%20OR%20FQDN%20OR%20IP%20%3A%20%3C%3E%0AThreat%20Type%20%3A%20%3C%3E%0AJustification%3A%20%3C%3E).

## Threat types

|Threat Type |Description |
|---------|---------|
|Botnet|Indicator is detailing a botnet node/member.|
|BruteForce|Indicator is detailing a Brute Force attack. It can be either victim or attacker.|
|C2|Indicator is detailing a C2 (Command & Control) node of a botnet.|
|CryptoMining|Traffic involving this network address / URL is an indication of Crypto Mining / Resource abuse.|
|Darknet|Indicator is that of a Darknet node/network.|
|DDoS|Indicators relating to an active or upcoming DDoS (distributed denial of service) campaign.|
|MaliciousUrl|URL that is serving malware.|
|Malware|Indicator describing a malicious file or files.|
|Phishing|Indicators relating to a phishing campaign.|
|Proxy|Indicator is that of a proxy service.|
|PUA|PUA (Potentially Unwanted Application).|
|WatchList or Suspicious|This is the generic bucket into which indicators are placed when it cannot be determined exactly what the threat is or will require manual interpretation. |
