---
title: "Include file - Add a platform and redirect URI for a web application"
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom:
ms.date: 01/18/2024
ms.reviewer:
ms.service: identity-platform

ms.topic: include
---


1. Under **Manage**, select **Authentication**.
1. On the **Platform configurations** page, select **Add a platform**, and then select **Web** option.
1. For the **Redirect URIs** enter `https://localhost:5001/signin-oidc`.
1. Under **Front-channel logout URL**, enter `https://localhost:5001/signout-callback-oidc` for signing out.
1. Select **Configure** to save your changes.