---
title: Security guidance - AI
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to secure AI agents and workloads.

ms.topic: concept-article
ms.date: 05/18/2026

ms.author: sarahlipsey
author: shlipsey3
manager: pmwongera
ms.reviewer: ramical
ai-usage: ai-assisted
#Customer Intent: As an IT admin, I want to understand how to secure AI agents and workloads so that I can prevent unauthorized access and enforce governance over autonomous identities.
---

# Configure Microsoft Entra for Zero Trust: AI

AI agents acquire access tokens for organizational resources on every interaction — mail, files, line-of-business APIs, and downstream agents — without an interactive user session and without the device, location, or MFA signals that classic Conditional Access uses for human users. Securing the AI control plane is essential to your Zero Trust journey.

The recommendations and Zero Trust checks that are part of this pillar help reduce the risk of unauthorized AI access. Themes include enforcing Entra authentication on agent endpoints, applying Conditional Access policies to agent identities, assigning lifecycle governance controls, and ensuring AI administrative roles have accountable principals.


## Zero Trust security recommendations

### Require users to use Microsoft Entra ID auth to interact with agents
[!INCLUDE [61011](../includes/secure-recommendations/61011.md)]

### Conditional Access policies cover both agent identities and agent users
[!INCLUDE [61009](../includes/secure-recommendations/61009.md)]

### Risk-based Conditional Access blocks risky agent identities
[!INCLUDE [61012](../includes/secure-recommendations/61012.md)]

### Agent identity lifecycle tagging (customSecurityAttributes present)
[!INCLUDE [61008](../includes/secure-recommendations/61008.md)]

### Identity governance for agents — sponsors assigned, entitlement-management channel exists, and lifecycle automation in place
[!INCLUDE [61013](../includes/secure-recommendations/61013.md)]

### Agent identities and blueprint principals have assigned technical owners and no disabled agents remain in the directory
[!INCLUDE [61014](../includes/secure-recommendations/61014.md)]

### AI administrative roles have assigned principals
[!INCLUDE [61006](../includes/secure-recommendations/61006.md)]
