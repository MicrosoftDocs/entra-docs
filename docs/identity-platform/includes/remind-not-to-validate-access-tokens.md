---
title: Don't validate access tokens for Microsoft Graph
description: Include file warning that access tokens for Microsoft Graph should be considered opaque and should never be validated by customer code. Only Microsoft Graph validates Microsoft Graph access tokens.

author: OwenRichards1
manager: CelesteDG

ms.service: identity-platform


ms.topic: include
ms.date: 06/25/2021
ms.author: owenrichards
ms.reviewer: ludwignick
ms.custom: 
---

> [!WARNING]
> Don't attempt to validate or read tokens for any API you don't own, including the tokens in this example, in your code. Tokens for Microsoft services can use a special format that will not validate as a JWT, and may also be encrypted for consumer (Microsoft account) users. While reading tokens is a useful debugging and learning tool, do not take dependencies on this in your code or assume specifics about tokens that aren't for an API you control.
