---
title: Register a web API that calls web APIs
description: Learn how to configure a web API to securely call downstream APIs by registering it as a confidential client application.
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.date: 03/21/2025
ms.reviewer: jmprieur
ms.service: identity-platform
ms.subservice: workforce
ms.topic: how-to
#customer intent: As a developer, I want to learn how to acquire tokens for web APIs so that I can enable secure API calls in my application.  
---

# A web API that calls web APIs: App registration

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

A web API that calls downstream web APIs has the same registration as a protected web API. Follow the instructions in [Protected web API: App registration](scenario-protected-web-api-app-registration.md).

Because the web app now calls web APIs, it becomes a confidential client application. That's why extra registration information is required: the app needs to share secrets (client credentials) with the Microsoft identity platform.

[!INCLUDE [Pre-requisites](./includes/scenarios/scenarios-registration-client-secrets.md)]

## API permissions

Web apps call APIs on behalf of users for whom the bearer token was received. The web apps need to request delegated permissions. For more information, see [Add permissions to access your web API](quickstart-configure-app-access-web-apis.md#add-permissions-to-access-your-web-api).

## Next steps

Move on to the next article in this scenario,
[App Code configuration](scenario-web-api-call-api-app-configuration.md).
