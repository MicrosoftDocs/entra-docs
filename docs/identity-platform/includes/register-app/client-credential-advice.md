---
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.date: 11/06/2024
ms.reviewer:
ms.service: identity-platform

ms.topic: include
---

When you create credentials for a confidential client application:

- Microsoft recommends that you use a certificate instead of a client secret before moving the application to a production environment. For more information on how to use a certificate, see instructions in [Microsoft identity platform application authentication certificate credentials](../../certificate-credentials.md).

- For testing purposes, you can create a self-signed certificate and configure your apps to authenticate with it. However, **in production**, you should purchase a certificate signed by a well-known certificate authority, then use [Azure Key Vault](/azure/key-vault/general/overview) to manage certificate access and lifetime.