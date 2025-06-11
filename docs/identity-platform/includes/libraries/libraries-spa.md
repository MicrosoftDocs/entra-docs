---
author: henrymbuguakiarie
ms.service: identity-platform
ms.topic: include
ms.date: 09/25/2023
ms.author: henrymbugua
manager: CelesteDG 
---

| Language / framework | Project on<br/>GitHub  | Package | Getting<br/>started    | Sign in users | Access web APIs |
| -------------------- | ---------------------- | ------- | :--------------------: | :-----------: | :-------------: |
| React | [MSAL React](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-react)<sup>2</sup> | [msal-react](https://www.npmjs.com/package/@azure/msal-react) | [Quickstart](../../quickstart-register-app.md) | ![Library can request ID tokens for user sign-in.][y] | ![Library can request access tokens for protected web APIs.][y] |
| JavaScript | [MSAL.js](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-browser)<sup>2</sup> | [msal-browser](https://www.npmjs.com/package/@azure/msal-browser) | [Quickstart](../../quickstart-register-app.md) | ![Library can request ID tokens for user sign-in.][y] | ![Library can request access tokens for protected web APIs.][y] |
| Angular | [MSAL Angular](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-angular)<sup>2</sup> | [msal-angular](https://www.npmjs.com/package/@azure/msal-angular) | [Quickstart](../../quickstart-register-app.md) | ![Library can request ID tokens for user sign-in.][y] | ![Library can request access tokens for protected web APIs.][y] |

<!--Image references-->

[y]: ~/identity-platform/media/common/yes.png
[n]: ~/identity-platform/media/common/no.png

<!--Reference-style links -->

[aad-app-model-v2-overview]: v2-overview.md
[microsoft-sdl]: https://www.microsoft.com/securityengineering/sdl/
[preview-tos]: https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all
[auth-code-flow]: ../../v2-oauth2-auth-code-flow.md
[implicit-flow]: ../../v2-oauth2-implicit-grant-flow.md
