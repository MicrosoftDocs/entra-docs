---
author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: include
ms.date: 03/19/2024
ms.author: kengaderdus
---

Whenever you call a sign-in, sign-up, or SSPR endpoint, the response includes a *continuation token*. This token uniquely identifies the current flow and lets Microsoft Entra ID maintain state across its endpoints. Include the token in every subsequent request in that flow. It's valid only for a limited time and can only be used for the subsequent requests within the same flow.
