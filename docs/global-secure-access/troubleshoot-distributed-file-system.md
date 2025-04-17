---
title: Learn how to solve an issue where Global Secure Access fails with a Distributed File System
description: A troubleshooting article that includes a workaround for a case where a Distributed File System (DFS) doesn't operate correctly with Global Secure Access.
author: kenwith
ms.author: kenwith
manager: femila
ms.topic: troubleshooting
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: nbeesetti
ai-usage: ai-assisted
#customer intent: As a administrator, I want to understand how to work around an issue with Global Secure Access and a Distributed File System.
---

# Troubleshoot Distributed File System issue with Global Secure Access
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

:::image type="content" source="media/troubleshoot-distributed-file-system/dfs-1.png" alt-text="Diagram showing the connection between VPN and DFS.":::
 
## Issue
IP-based network Access Control Lists (ACL) don't work with Global Secure Access as there’s no VPN in the middle. However, the employee computer should still be referred to the appropriate fileshare.

## Workaround
The proposed workaround for the above-mentioned scenario is as follows. 

As a workaround, we suggest moving this employee-to-fileshare mapping to the employee computer (as a Domain Name System (DNS) search suffix), so the traffic would be: 


:::image type="content" source="media/troubleshoot-distributed-file-system/dfs-2.png" alt-text="Diagram showing the connector.":::

The workaround is to make changes in the network-architecture in the environment: 

1. Add more `C-NAME DNS` records (aliases) on domain controllers: 
    - `shares.foo-loc1.contoso.com` **->** `foo-loc1.contoso.com` 
    - `shares.foo-loc2.contoso.com` **->** `foo-loc2.contoso.com` 
    - `shares.foo-loc3.contoso.com` **->** `foo-loc3.contoso.com` 
2. Push DNS search suffixes to the employees’ computer such that: 
    - Employees at *Location1* get suffix: `foo-loc1.contoso.com` 
    - Employees at *Location2* get suffix: `foo-loc2.contoso.com` 
    - Employees at *Location3* get suffix: `foo-loc3.contoso.com` 
3. Now a dedicated Global Secure Access application can be created for each of the following Fully Qualified Domain Names (FQDNs) (or their IPs): 
    - `foo-loc1.contoso.com`
    - `foo-loc2.contoso.com` 
    - `foo-loc3.contoso.com` 
4. Each of these applications maps to the connector (via connector group specified in the app) in the corresponding location. 

After these changes, the employees accessing the common path: `\\shares\bar` from *Location1* are directed to the website: `\\foo-loc1.contoso.com\bar`, and likewise for other locations.


## Related content
- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

