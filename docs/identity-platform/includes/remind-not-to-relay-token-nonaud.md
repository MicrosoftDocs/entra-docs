---
title: Don't send your middle-tier OBO token to any non-audience party
description: Include file warning that access tokens acquired by the middle-tier shouldn't be sent to any party except that which is identified by the audience claim.

author: iambmelt
manager: CelesteDG

ms.service: identity-platform


ms.topic: include
ms.date: 12/7/2021
ms.author: brianmel
ms.reviewer: 
ms.custom: 
---

> [!WARNING]
> **DO NOT** send access tokens that were issued to the middle tier to anywhere except the intended audience for the token. Access tokens issued to the middle tier are intended for use *only* by that middle tier to communicate with the intended audience endpoint.
>
> Security risks of relaying access tokens from a middle-tier resource to a client (instead of the client getting the access tokens themselves) include:
>
> - Increased risk of token interception over compromised SSL/TLS channels.
> - Inability to satisfy token binding and Conditional Access scenarios requiring claim step-up (for example, MFA, Sign-in Frequency).
> - Incompatibility with admin-configured device-based policies (for example, MDM, location-based policies).
