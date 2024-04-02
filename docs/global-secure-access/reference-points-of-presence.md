---
title: Global Secure Access points of presence and service addresses
description: Global Secure Access points of presence and service addresses for Microsoft Entra Internet and Microsoft Entra Private Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: reference
ms.date: 11/27/2023
ms.service: global-secure-access
ms.custom: references_regions
---
# Global Secure Access (preview) points of presence and service addresses

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


## Service addresses
The Global Secure Access service is accessed from the Global Secure Access client and is used for Internet Access and Private Access traffic. 

For the best performance and reliability, other Security Service Edge (SSE) clients should exclude the Global Secure Access service destinations.

The destinations include: 
- `*.globalsecureaccess.microsoft.com`
- `150.171.19.0/24`
- `150.171.20.0/24`
- `13.107.232.0/24`
- `13.107.233.0/24`
- `150.171.15.0/24`
- `150.171.18.0/24`
- `151.206.0.0/16`
