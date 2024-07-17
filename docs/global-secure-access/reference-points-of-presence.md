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

## Microsoft Entra Internet Access and Microsoft Entra Private Access locations
The tables list the locations that Global Secure Access is deployed. The tables also list the locations that Virtual Private Network (VPN) and Microsoft Entra Private Access connectors are deployed.

### Asia Pacific (APAC)
|Location                    | Global Secure Access deployed | VPN deployed | Private Access connectors deployed |
| ---                        | --- | --- | --- |
|Busan, South Korea          | ✅ | ✅ | ✅ |
|Chennai, India              | ✅ | ✅ | ✅ |
|Melbourne, Australia        | ✅ | ✅ | ✅ |
|Osaka, Japan                | ✅ | ✅ | ✅ |
|Pune, India                 | ✅ |    | ✅ |
|Seoul, South Korea          | ✅ | ✅ |   |
|Singapore, Singapore        | ✅ |    | ✅ |
|Sydney, Australia           | ✅ | ✅ | ✅ |
|Taipei, Taiwan              | ✅ |    |   |
|Tokyo, Japan                | ✅ | ✅ | ✅ |

### Europe Middle East Africa (EMEA)
| Location                   | Global Secure Access deployed | VPN deployed | Private Access connectors deployed |
| ---                        | --- | --- | --- |
|Amsterdam, Netherlands      | ✅ | ✅ | ✅ |
|Berlin, Germany             | ✅ |    |     |
|Cape Town, South Africa     | ✅ | ✅ |    |
|Dubai, UAE                  | ✅ | ✅ | ✅ |
|Dublin, Ireland             | ✅ | ✅ | ✅ |
|Frankfurt, Germany          | ✅ | ✅ | ✅ |
|Gavle, Sweden               | ✅ | ✅ |    |
|Johannesburg, South Africa  | ✅ | ✅ |    |
|London, UK                  | ✅ | ✅ | ✅ |
|Madrid, Spain               | ✅ |    |     |
|Milan, Italy                | ✅ | ✅ |    |
|Marseille, France           | ✅ | ✅ |    |
|Paris, France               | ✅ | ✅ | ✅ |
|Tel Aviv, Israel            | ✅ | ✅ | ✅ |
|Warsaw, Poland              | ✅ | ✅ |    |
|Zurich, Switzerland         | ✅ | ✅ |    |

### Latin America (LATAM)
| Location                   | Global Secure Access deployed | VPN deployed | Private Access connectors deployed |
| ---                        | --- | --- | --- |
|Campinas, Brazil            | ✅ |   | ✅ |
|Rio de Janeiro, Brazil      | ✅ |   | ✅ |

### North America (NA)
| Location                   | Global Secure Access deployed | VPN deployed | Private Access connectors deployed |
| ---                        | --- | --- | --- |
|Boydton, Virginia, USA      | ✅ | ✅ |     |
|Cheyenne, Wyoming, USA      | ✅ | ✅ |     |
|Chicago, Illinois, USA      | ✅ | ✅ |     |
|Des Moines, Iowa, USA       | ✅ | ✅ | ✅ |
|Manassas, Virginia, USA     | ✅ | ✅ | ✅ |
|Montreal, Quebec, Canada    | ✅ | ✅ |     |
|Phoenix, Arizona, USA       | ✅ | ✅ |     |
|Queretaro, Mexico           | ✅ |    |     |
|Quincy, Washington, USA     | ✅ | ✅ |     |
|San Antonio, Texas, USA     | ✅ | ✅ | ✅ |
|San Jose, California, USA   | ✅ | ✅ | ✅ |
|Toronto, Ontario, Canada    | ✅ | ✅ |     |


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
