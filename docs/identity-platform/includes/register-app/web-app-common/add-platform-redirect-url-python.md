---
author: Dickson-Mwendia
ms.service: identity-platform
ms.topic: include
ms.date: 02/28/2024
ms.author: dmwendia
ms.manager: celested
---

To specify your app type to your app registration, follow these steps:

1. Under **Manage**, select **Authentication**.
1. On the **Platform configurations** page, select **Add a platform**, and then select **Web** option.
1. For the **Redirect URIs** enter `https://localhost:7274/signin-oidc`.
1. Under **Front-channel logout URL**, enter `https://localhost:7274/signout-callback-oidc` for signing out.
1. Select **Configure** to save your changes.
