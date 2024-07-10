---
title: Global Secure Access points of presence and IP addresses
description: Global Secure Access points of presence and IP addresses for Microsoft Entra Internet Access and Microsoft Entra Private Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: reference
ms.date: 05/23/2024
ms.service: global-secure-access
ms.custom: references_regions
---
# Global Secure Access points of presence and IP addresses

Global Secure Access is available in specific points of presence, with new locations added periodically. The service routes traffic through one of the following nearby locations, so even if you're not in a listed location, you can still access the service. At this time, both Microsoft Entra Internet Access and Microsoft Entra Private Access are available in the same locations. These locations are Microsoft data centers.

## Microsoft Entra Internet Access and Microsoft Entra Private Access

| Europe Middle East Africa (EMEA) | Asia Pacific (APAC)    | Latin America (LATAM)   | North America (NA) |
|         ---                      |      ---               |         ---             |       ---          |
| Amsterdam, Netherlands           | Busan, South Korea     | Campinas, Brazil        | Boydton, Virginia, USA |
| Berlin, Germany                  | Chennai, India         | Rio de Janeiro, Brazil  | Cheyenne, Wyoming, USA |
| Cape Town, South Africa          | Melbourne, Australia   |                         | Chicago, Illinois, USA |
| Dubai, UAE                       | Osaka, Japan           |                         | Des Moines, Iowa, USA |
| Dublin, Ireland                  | Pune, India            |                         | Manassas, Virginia, USA |
| Frankfurt, Germany               | Seoul, South Korea     |                         | Montreal, Quebec, Canada |
| Gavle, Sweden                    | Singapore, Singapore   |                         | Phoenix, Arizona, USA |
| Johannesburg, South Africa       | Sydney, Australia      |                         | Queretaro, Mexico |
| London, UK                       | Taipei, Taiwan         |                         | Quincy, Washington, USA |
| Madrid, Spain                    | Tokyo, Japan           |                         | San Antonio, Texas, USA |
| Milan, Italy                     |                        |                         | San Jose, California, USA |
| Marseille, France                |                        |                         | Toronto, Ontario, Canada |
| Paris, France                    |                        |                         |                          |
| Tel Aviv, Israel                 |                        |                         |                          |
| Warsaw, Poland                   |                        |                         |                          |
| Zurich, Switzerland              |                        |                         |                          |

## IP addresses and Fully Qualified Domain Names (FQDNs) for Global Secure Access service
The Global Secure Access service is accessed from the Global Secure Access client and is used for Microsoft Entra Internet Access (including Microsoft 365) and Microsoft Entra Private Access traffic. The Internet Protocol (IP) addresses are listed.

### FQDN and IP addresses where the Global Secure Access service receives traffic
Add Anycast IP ranges for accessing the Global Secure Access service edge to your enterprise Access Control Lists (ACLs) and firewalls. When operating in a side-by-side model with other Security Service Edge (SSE) clients, add the Anycast IP ranges to these other clients.
 
The Global Secure Access service receives traffic on these FQDNs and IP addresses:
- `*.globalsecureaccess.microsoft.com`
- `150.171.19.0/24`
- `150.171.20.0/24`
- `13.107.232.0/24`
- `13.107.233.0/24`
- `150.171.15.0/24`
- `150.171.18.0/24`
- `151.206.0.0/16`
 
### Global Secure Access egress IP ranges
Outbound Internet traffic that is acquired by Global Secure Access, including traffic to Microsoft services, will egress from Global Secure Access instances. If the target service uses IP restrictions and access controls, you may need to configure the target service to allow IP connections from Global Secure Access subnets:

- `128.94.0.0/19`
- `151.206.0.0/16`
