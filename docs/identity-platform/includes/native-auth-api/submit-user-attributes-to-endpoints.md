---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 04/09/2024
ms.author: kengaderdus
---

In the Microsoft Entra admin center, you can configure user attributes as required or optional. This configuration determines how Microsoft Entra responds when you make a call to its endpoints. Optional attributes are not mandatory for the sign-up flow to complete. Therefore, when all attributes are optional, they must be submitted before the username is verified. Otherwise, the sign-up completes without the optional attributes.
 
The following table summarizes when it's possible to submit user attributes to Microsoft Entra endpoints. 

| Endpoint |Required attributes | Optional attributes | Both required and optional attributes |
| ---- | --- |  --- | --- | 
| `/signup/v1.0/start` endpoint | Yes  | Yes  | Yes |
| `/signup/v1.0/continue` endpoint before username verification | Yes  | Yes  | Yes  |
| `/signup/v1.0/continue` endpoint after username verification |  Yes | No  | Yes |