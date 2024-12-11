---
author: henrymbuguakiarie
ms.service: identity-platform
ms.topic: include
ms.date: 09/25/2023
ms.author: henrymbugua
manager: CelesteDG 
---

| Language / framework | Project on<br/>GitHub                                                                                           | Package                                                                                                    | Getting<br/>started                                                                                | Sign in users                                                        | Access web APIs                                                                | Generally available (GA) *or*<br/>Public preview<sup>1</sup> |
|----------------------|-----------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------:|:------------------------------------------------------------------------------:|:------------------------------------------------------------:|
| .NET                 | [MSAL.NET](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet)                              | [Microsoft.Identity.Client](https://www.nuget.org/packages/Microsoft.Identity.Client)                      | —                                                                                                  | ![Library cannot request ID tokens for user sign-in.][n]             | ![Library can request access tokens for protected web APIs.][y]                | GA                                                           |
| .NET                 | [Microsoft.IdentityModel](https://github.com/AzureAD/azure-activedirectory-identitymodel-extensions-for-dotnet) | [Microsoft.IdentityModel](https://www.nuget.org/packages?q=Microsoft.IdentityModel)                        | —                                                                                                  | ![Library cannot request ID tokens for user sign-in.][n]<sup>2</sup> | ![Library cannot request access tokens for protected web APIs.][n]<sup>2</sup> | GA                                                           |                                                         |
| ASP.NET Core         | [Microsoft.Identity.Web](https://github.com/AzureAD/microsoft-identity-web)                                     | [Microsoft.Identity.Web](https://www.nuget.org/packages/Microsoft.Identity.Web)                            | [Quickstart](../../quickstart-web-app-dotnet-core-sign-in.md) | ![Library can request ID tokens for user sign-in.][y]                | ![Library can request access tokens for protected web APIs.][y]                | GA                                                           |
| Java                 | [MSAL4J](https://github.com/AzureAD/microsoft-authentication-library-for-java)                                  | [msal4j](https://search.maven.org/artifact/com.microsoft.azure/msal4j)                                     | [Quickstart](../../quickstart-web-app-java-sign-in.md)                    | ![Library can request ID tokens for user sign-in.][y]                | ![Library can request access tokens for protected web APIs.][y]                | GA                                                           |
| Spring | [spring-cloud-azure-starter-active-directory](https://github.com/Azure/azure-sdk-for-java/tree/spring-cloud-azure-autoconfigure_4.3.0/sdk/spring/spring-cloud-azure-starter-active-directory) | [spring-cloud-azure-starter-active-directory](https://search.maven.org/artifact/com.azure.spring/spring-cloud-azure-starter-active-directory) |  [Tutorial](/azure/developer/java/spring-framework/configure-spring-boot-starter-java-app-with-azure-active-directory) | ![Library can request ID tokens for user sign-in.][y] | ![Library can request access tokens for protected web APIs.][y] | GA  |
| Node.js              | [MSAL Node](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node)          | [msal-node](https://www.npmjs.com/package/@azure/msal-node)                                                | [Quickstart](../../quickstart-web-app-nodejs-sign-in.md)             | ![Library can request ID tokens for user sign-in.][y]                | ![Library can request access tokens for protected web APIs.][y]                | GA                                                              |
| Python               | [MSAL Python](https://github.com/AzureAD/microsoft-authentication-library-for-python)                           | [msal](https://pypi.org/project/msal)                                                                      |                   | ![Library can request ID tokens for user sign-in.][y]                | ![Library can request access tokens for protected web APIs.][y]                | GA                                                           |
| Python               | [identity](https://github.com/rayluo/identity)                           | [identity](https://pypi.org/project/identity/)                                                                      | [Quickstart](../../quickstart-web-app-python-flask.md)                  | ![Library can request ID tokens for user sign-in.][y]                | ![Library can request access tokens for protected web APIs.][y]                | --                                                           |
<!--
| Java | [ScribeJava](https://github.com/scribejava/scribejava) | [ScribeJava 3.2.0](https://github.com/scribejava/scribejava/releases/tag/scribejava-3.2.0) | ![X indicating no.][n] | ![X indicating no.][n] | ![Green check mark.][y] | -- |
| Java | [Gluu oxAuth](https://github.com/GluuFederation/oxAuth) | [oxAuth 3.0.2](https://github.com/GluuFederation/oxAuth/releases/tag/3.0.2) | ![X indicating no.][n] | ![Green check mark.][y] | ![Green check mark.][y] | -- |
| Node.js | [openid-client](https://github.com/panva/node-openid-client/) | [openid-client 2.4.5](https://github.com/panva/node-openid-client/releases/tag/v2.4.5) | ![X indicating no.][n] | ![Green check mark.][y] | ![Green check mark.][y] | -- |
| PHP | [PHP League oauth2-client](https://github.com/thephpleague/oauth2-client) | [oauth2-client 1.4.2](https://github.com/thephpleague/oauth2-client/releases/tag/1.4.2) | ![X indicating no.][n] | ![X indicating no.][n] | ![Green check mark.][y] | -- |
| Ruby | [OmniAuth](https://github.com/omniauth/omniauth) | [omniauth 1.3.1](https://github.com/omniauth/omniauth/releases/tag/v1.3.1)<br/>[omniauth-oauth2 1.4.0](https://github.com/intridea/omniauth-oauth2) | ![X indicating no.][n] | ![X indicating no.][n] | ![Green check mark.][y] | -- |
-->

<sup>(1)</sup> [Universal License Terms for Online Services][preview-tos] apply to libraries in *Public preview*.

<sup>(2)</sup> The [Microsoft.IdentityModel](https://github.com/AzureAD/azure-activedirectory-identitymodel-extensions-for-dotnet) library only *validates* tokens - it can't request ID or access tokens.

<!--Image references-->

[y]: ~/identity-platform/media/common/yes.png
[n]: ~/identity-platform/media/common/no.png

<!--Reference-style links -->

[preview-tos]: https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all
