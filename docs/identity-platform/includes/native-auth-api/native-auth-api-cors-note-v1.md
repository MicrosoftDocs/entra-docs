---
author: cilwerner
ms.author: cwerner
ms.service: identity-platform
ms.subservice: external
ms.topic: include
ms.date: 11/13/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1030
#customer intent: As an application developer, I want to identify the V1 browser proxy requirement so that I can maintain an existing integration.
---

> [!NOTE]
> The Native Authentication API V1 endpoints don't support direct cross-origin browser access through [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS). Existing browser integrations need a proxy. Android and iOS apps using native HTTP transports don't need CORS or a CORS proxy.
>
> Configure the proxy for the V1 endpoint paths used by your client.