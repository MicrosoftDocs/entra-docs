---
title: Global Secure Access points of presence and IP addresses
description: Global Secure Access points of presence and IP addresses for Microsoft Entra Internet Access and Microsoft Entra Private Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: reference
ms.date: 04/15/2024
ms.service: global-secure-access
ms.custom: references_regions
---
# Global Secure Access (preview) points of presence and IP addresses

During the preview, Global Secure Access (preview) is available in limited points of presence, with new locations added periodically. The service routes traffic through one of the following nearby locations, so even if you're not in a listed location, you can still access the service. At this time, both Microsoft Entra Internet Access and Microsoft Entra Private Access are available in the same locations.

## Microsoft Entra Internet Access and Microsoft Entra Private Access

| Europe Middle East Africa (EMEA) | Asia Pacific (APAC)    | Latin America (LATAM)   | North America (NA) |
|         ---                      |      ---               |         ---             |       ---          |
| Amsterdam, Netherlands           | Busan, South Korea     | Rio de Janeiro, Brazil  | Boydton, Virginia, USA |
| Berlin, Germany                  | Chennai, India         |                         | Cheyenne, Wyoming, USA |
| Cape Town, South Africa          | Melbourne, Australia   |                         | Chicago, Illinois, USA |
| Dubai, UAE                       | Osaka, Japan           |                         | Des Moines, Iowa, USA |
| Dublin, Ireland                  | Pune, India            |                         | Manassas, Virginia, USA |
| Frankfurt, Germany               | Seoul, South Korea     |                         | Montreal, Quebec, Canada |
| Gavle, Sweden                    | Singapore, Singapore   |                         | Phoenix, Arizona, USA |
| Johannesburg, South Africa       | Sydney, Australia      |                         | Queretaro, Mexico |
| London, UK                       | Taipei, Taiwan         |                         | Quincy, Washington, USA |
| Milan, Italy                     | Tokyo, Japan           |                         | San Antonio, Texas, USA |
| Paris, France                    |                        |                         | San Jose, California, USA |
| Tel Aviv, Israel                 |                        |                         | Toronto, Ontario, Canada |
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
 
### IP addresses where the Global Secure Access service sends traffic from
Network traffic leaves the Global Secure Access service for Microsoft Entra Internet Access (including Microsoft 365) towards the internet and Software as a Service (SaaS) endpoints. The traffic carries a unique `Src IP` signature. Use the signature to set up location-based access controls for your applications and resources.
 
The Global Secure Access service sends traffic on these IP addresses:
- `128.94.0.0/19`
- `151.206.0.0/16`
