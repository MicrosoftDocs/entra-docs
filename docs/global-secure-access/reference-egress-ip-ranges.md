---
title: Global Secure Access egress IP ranges
description: Reference list of the egress IP ranges that Global Secure Access uses for outbound internet traffic, so you can allowlist them on target services.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: reference
ms.date: 08/28/2025
ms.service: global-secure-access
ms.custom: references_regions
ai-usage: ai-assisted
---
# Global Secure Access egress IP ranges

Outbound Internet traffic that is acquired by Global Secure Access, including traffic to Microsoft services, will egress from Global Secure Access instances. If the target service uses IP restrictions and access controls, you may need to configure the target service to allow IP connections from Global Secure Access subnets:

- `128.94.0.0/19`
- `151.206.0.0/16`

## Related content

- [Global Secure Access points of presence and IP addresses](reference-points-of-presence.md)
