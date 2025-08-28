---
title: Global Secure Access points of presence and IP addresses
description: Global Secure Access points of presence and IP addresses for Microsoft Entra Internet Access and Microsoft Entra Private Access.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: reference
ms.date: 02/21/2025
ms.service: global-secure-access
ms.custom: references_regions
ai-usage: ai-assisted
---
# Global Secure Access points of presence and IP addresses

Global Secure Access is available in specific points of presence, with new locations added periodically. The service routes traffic through one of the following nearby locations, so even if you're not in a listed location, you can still access the service. At this time, both Microsoft Entra Internet Access and Microsoft Entra Private Access are available in the same locations. These locations are Microsoft data centers.

## Microsoft Entra Internet Access and Microsoft Entra Private Access locations
The tables list information about deployment status.

- The locations the Global Secure Access service is deployed. 
- The locations that Remote Network connectivity gateways are active. 

### Asia Pacific (APAC)
The table lists the deployment status for the APAC region.

| Azure Region           | Physical Location           | Global Secure Access service deployed | Remote network connectivity gateways | 
| ---                    | ---                         | --- | --- | 
| New Zealand North      | Auckland, New Zealand       | ✅ |    |
| Korea South            | Busan, South Korea          | ✅ | ✅ |
| South India            | Chennai, India              | ✅ | ✅ |
| Australia Southeast    | Melbourne, Australia        | ✅ | ✅ |
| Japan West             | Osaka, Japan                | ✅ | ✅ |
| Central India          | Pune, India                 | ✅ |    |
| Korea Central          | Seoul, South Korea          | ✅ | ✅ |
| Southeast Asia         | Singapore, Singapore        | ✅ |    |
| Australia East         | Sydney, Australia           | ✅ | ✅ |
| Taiwan North           | Taipei, Taiwan              | ✅ |    |
| Japan East             | Tokyo, Japan                | ✅ | ✅ |


### Europe Middle East Africa (EMEA)
The table lists the deployment status for the EMEA region.

| Azure Region           | Physical Location            | Global Secure Access service deployed | Remote network connectivity gateways | 
| ---                    | ---                         | --- | --- |
| westeurope             | Amsterdam, Netherlands       | ✅ | ✅ |
| germanynorth           | Berlin, Germany              | ✅ |    |
| southafricanorth       | Cape Town, South Africa      | ✅ | ✅ | 
| uaenorth               | Dubai, UAE                   | ✅ | ✅ |
| northeurope            | Dublin, Ireland              | ✅ | ✅ |
| germanywestcentral     | Frankfurt, Germany           | ✅ | ✅ |
| swedencentral          | Gavle, Sweden                | ✅ | ✅ | 
| southafricawest        | Johannesburg, South Africa   | ✅ | ✅ | 
| uksouth                | London, UK                   | ✅ | ✅ |
| westeurope             | Madrid, Spain                | ✅ |    | 
| italynorth             | Milan, Italy                 | ✅ | ✅ |
| francecentral          | Marseille, France            | ✅ | ✅ |
| francecentral          | Paris, France                | ✅ | ✅ |
| israelcentral          | Tel Aviv, Israel             | ✅ | ✅ |
| polandcentral          | Warsaw, Poland               | ✅ | ✅ |
| switzerlandnorth       | Zurich, Switzerland          | ✅ | ✅ |


### Latin America (LATAM)
The table lists the deployment status for the LATAM region.

|Physical Location            | Azure Region         | Global Secure Access service deployed | Remote network connectivity gateways | 
| ---                 | ---                         | --- | --- | 
| brazilsouth         | Campinas, Brazil             | ✅ |   | 
| brazilse            | Rio de Janeiro, Brazil       | ✅ |   | 


### North America (NA)
The table lists the deployment status for the NA region.

| Azure Region             | Physical Location            | Global Secure Access service deployed | Remote network connectivity gateways | 
| ---                      | ---                         | --- | --- |
| eastus                   | Boydton, Virginia, USA       | ✅ | ✅ | 
| westcentralus            | Cheyenne, Wyoming, USA       | ✅ | ✅ | 
| northcentralus           | Chicago, Illinois, USA       | ✅ | ✅ | 
| centralus                | Des Moines, Iowa, USA        | ✅ | ✅ |
| usgovvirginia            | Manassas, Virginia, USA      | ✅ | ✅ | 
| canadacentral            | Montreal, Quebec, Canada     | ✅ | ✅ | 
| westus2                  | Phoenix, Arizona, USA        | ✅ | ✅ | 
| mexico-central           | Queretaro, Mexico            | ✅ |    | 
| westus                   | Quincy, Washington, USA      | ✅ | ✅ | 
| southcentralus           | San Antonio, Texas, USA      | ✅ | ✅ | 
| westus3                  | San Jose, California, USA    | ✅ | ✅ | 
| canadaeast               | Toronto, Ontario, Canada     | ✅ | ✅ | 


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
