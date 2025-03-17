---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 03/13/2025
ms.author: kengaderdus
ms.manager: mwongerapk
---
You can add the **idtyp** optional claim to help the web API to determine whether a token is an **app** token or an **app + user** token. Although you can use a combination of **scp** and **roles** claims for the same purpose, using the **idtyp** claim is the easiest way to tell an app token and an app + user token apart. For example, the value of this claim is *app* when the token is an app-only token. 