---
author: cilwerner
ms.author: cwerner
ms.service: identity-platform
ms.subservice: external
ms.topic: include
ms.date: 11/13/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1030
#customer intent: As an application developer, I want to identify the V1 reference scope so that I can choose API or SDK guidance for an existing integration.
---

This V1 API reference describes raw HTTP requests for maintained integrations. For an existing library integration, see the [SDK library references](../../reference-native-authentication-api-v1.md#sdk-references).

Journey responses carry the information needed for the next operation. Token responses can include an [ID token](../../id-tokens.md) for user identification and an [access token](../../access-tokens.md) for a protected API, according to the request and endpoint contract.