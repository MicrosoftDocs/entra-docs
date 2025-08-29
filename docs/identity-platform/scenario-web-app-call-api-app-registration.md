---
title: Register a web app that calls web APIs
description: 'Learn how to register a web app that calls web APIs. Configure client secrets and delegated permissions with the Microsoft identity platform.  '
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.date: 03/21/2025
ms.reviewer: jmprieur
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As an application developer, I want to know how to write a web app that calls web APIs by using the Microsoft identity platform.
---

# A web app that calls web APIs: App registration

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

A web app that calls web APIs has the same registration as a web app that signs users in. So, follow the instructions in [A web app that signs in users: App registration](scenario-web-app-sign-user-app-configuration.md).

However, because the web app now also calls web APIs, it becomes a confidential client application. That's why some extra registration is required. The app must share client credentials, or *secrets*, with the Microsoft identity platform.

[!INCLUDE [Registration of client secrets](./includes/scenarios/scenarios-registration-client-secrets.md)]

## API permissions

Web apps call APIs on behalf of the signed-in user. To do that, they must request *delegated permissions*. For details, see [Add permissions to access your web API](quickstart-configure-app-access-web-apis.md#add-permissions-to-access-your-web-api).

## Next steps

Move on to the next article in this scenario,
[Code configuration](scenario-web-app-call-api-app-configuration.md).
