---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 03/19/2024
ms.author: kengaderdus
---

Every time you call an endpoint in any of the flows, sign-in, sign-up, or SSPR, the endpoint includes a *continuation token* in its response. The continuation token is a unique identifier Microsoft Entra ID uses to maintain state between calls to different endpoints within the same flow. You must include this token in the subsequent requests in the same flow.

Each continuation token is valid for a specific period and can only be used for the subsequent requests within the same flow.