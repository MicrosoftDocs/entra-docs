---
author: kengaderdus
ms.service: active-directory
ms.subservice: ciam
ms.topic: include
ms.date: 02/29/2024
ms.author: kengaderdus
---

Each time you call an endpoint in any of the flows, sign-in, sign-up or SSPR, the endpoint includes a *continuation token* in it's response. The continuation token is a unique identifier thats is used to maintain state between calls to different endpoints within the same flow. You must include this token in the subsequent requests in the same flow.

Each continuation token is valid for a specific period and can only be used for the subsequent requests within the same flow.
