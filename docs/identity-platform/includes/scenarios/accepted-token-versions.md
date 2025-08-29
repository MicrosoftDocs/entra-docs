---
title: Accepted token versions in the Microsoft identity platform
description: Describes the accepted token versions for web APIs in the Microsoft identity platform.
author: cilwerner
manager: pmwongera
ms.service: identity-platform
ms.topic: include
ms.date: 08/29/2025
ms.author: cwerner
ms.custom:
---

## Accepted token version

The Microsoft identity platform can issue v1.0 tokens and v2.0 tokens. For more information about these tokens, refer to [Access tokens](access-tokens.md).

The token version your API may accept depends on your **Supported account types** selection when you create your web API application registration in the Azure portal.

- If the value of **Supported account types** is **Accounts in any organizational directory and personal Microsoft accounts (such as Skype, Xbox, Outlook.com)**, the accepted token version must be v2.0.
- Otherwise, the accepted token version can be v1.0.

After you create the application, you can determine or change the accepted token version by following these steps:

1. In the Microsoft Entra admin center, select your app and then select **Manifest**.
1. Find the property **accessTokenAcceptedVersion** in the manifest.
1. The value specifies to Microsoft Entra which token version the web API accepts.
   - If the value is 2, the web API accepts v2.0 tokens.
   - If the value is **null**, the web API accepts v1.0 tokens.
1. If you changed the token version, select **Save**.

The web API specifies which token version it accepts. When a client requests a token for your web API from the Microsoft identity platform, the client gets a token that indicates which token version the web API accepts.