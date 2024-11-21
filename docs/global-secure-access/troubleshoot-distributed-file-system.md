---
title: Learn how to solve an issue where Global Secure Access fails with a distributed file system.
description: A troubleshooting article that includes a workaround for a case where a Distributed File System (DFS) doesn't operate correctly with Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: troubleshooting
ms.date: 11/21/2024
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: nbeesetti
ai-usage: ai-assisted
#customer intent: As a administrator, I want to understand how to work around an issue with Global Secure Access and a Distributed File System.
---

# Overview
This document presents a case where a Distributed File System (DFS) doesn't operate correctly with Global Secure Access and offers a temporary workaround. 

The scenario involves accessing a file-share location. For instance, consider a DFS path: `\\foo.internal\share\bar`. The `bar` folder is set up as shown in the table: 

| Referral Status | Site       | Path                        |
|-----------------|------------|-----------------------------|
| Enabled         | Location1  | \\foo-loc1.contoso.com\bar  |
| Enabled         | Location2  | \\foo-loc2.contoso.com\bar  |
| Enabled         | Location3  | \\foo-loc3.contoso.com\bar  | 

 
Furthermore, site-locations are configured as: 

- Location1: `10.0.0.1 – 10.0.0.10`
- Location2: `10.0.0.11 – 10.0.0.20`
- Location3: `10.0.0.21 – 10.0.0.30`

If a user tries to access the common DFS path and appears to be coming from the IP address `10.0.0.3`, then the user should get directed to the path: `\\foo-loc1.contoso.com\bar`. The IPs are usually the addresses of VPN locations, and don't correspond to the clients original IP.

:::image type="content" source="media/troubleshoot-distributed-file-system/dfs1.png" alt-text="Diagram showing the connection between VPN and DFS.":::
 
## Integration overview
The docum

The general steps

## Monitoring
You use Global 

## Related content
- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

