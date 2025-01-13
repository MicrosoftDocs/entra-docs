---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 06/10/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---
You can **idtyp** optional claim to help the web API to determine if a token is an app token or an app + user token. Although you can use a combination of **scp** and **roles** claims for the same purpose, using the **idtyp** claim is the easiest way to tell an app token and an app + user token apart. For example, the value of this claim is *app* when the token is an app-only token. 