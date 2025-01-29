---
title: "Quickstart: Register an app in a Microsoft Entra tenant"
description: In this quickstart, you learn how to register an application with the Microsoft identity platform.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: mode-other
ms.date: 01/29/2025
ms.service: identity-platform
ms.topic: quickstart
#Customer intent: As developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue ID and/or access tokens to client applications that request them.
---

# Quickstart: Register an application in Microsoft Entra ID

In this quickstart, you learn how to register an application in Microsoft Entra ID. This process is essential for establishing a trust relationship between your application and the Microsoft identity platform. By completing this quickstart, you enable identity and access management (IAM) for your app, allowing it to securely interact with Microsoft services and APIs.

## Prerequisites

- An Azure account that has an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- The Azure account must be at least a [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
- A workforce or external tenant. You can use your **Default Directory** for this quickstart. If you need an external tenant, complete [set up an external tenant](/entra/external-id/customers/quickstart-tenant-setup).

## Register an application

[!INCLUDE [portal updates](~/includes/portal-update.md)]

Registering your application in Microsoft Entra establishes a trust relationship between your app and the Microsoft identity platform. The trust is unidirectional. Your app trusts the Microsoft identity platform, and not the other way around. Once created, the application object can't be moved between different tenants.

Follow these steps to create the app registration:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations** and select **New registration**.
1. Enter a meaningful application display **Name** name that is displayed to users of the app, for example *identity-client-app*. You can change the display name at any time and multiple app registrations can share the same name.
1. Under **Supported account types**, specify who can use the application. We recommend you select **Accounts in this organizational directory only** for most applications. Refer to the table below for more information on each option.

   | Supported account types | Description   |
   | ----------------------- | ------------- |
   | **Accounts in this organizational directory only** | For *single-tenant* apps for use only by users (or guests) in *your* tenant. |
   | **Accounts in any organizational directory** | For *multitenant* apps and you want users in *any* Microsoft Entra tenant to be able to use your application. Ideal for software-as-a-service (SaaS) applications that you intend to provide to multiple organizations. |
   | **Accounts in any organizational directory and personal Microsoft accounts** | For *multitenant* apps that support both organizational and personal Microsoft accounts (for example, Skype, Xbox, Live, Hotmail). |
   | **Personal Microsoft accounts** | For apps used only by personal Microsoft accounts (for example, Skype, Xbox, Live, Hotmail). |

1. Select **Register** to complete the app registration.

   :::image type="content" source="./media/quickstart-register-app/portal-02-app-reg-01.png" alt-text="Screenshot of Microsoft Entra admin center in a web browser, showing the Register an application pane." lightbox="./media/quickstart-register-app/portal-02-app-reg-01.png":::

1. The application's **Overview** page is displayed. Record the **Application (client) ID**, which uniquely identifies your application and is used in your application's code as part of validating the security tokens it receives from the Microsoft identity platform.

    :::image type="content" source="./media/quickstart-register-app/portal-03-app-reg-02.png" alt-text="Screenshot of the Microsoft Entra admin center in a web browser, showing an app registration's Overview pane." lightbox="./media/quickstart-register-app/portal-03-app-reg-02.png":::

> [!IMPORTANT]
> New app registrations are hidden to users by default. When you're ready for users to see the app on their [My Apps page](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510) you can enable it. To enable the app, in the Microsoft Entra admin center navigate to **Identity** > **Applications** > **Enterprise applications** and select the app. Then on the **Properties** page, set **Visible to users?** to **Yes**.

## Grant admin consent (external tenants only)

Once you register your application, it gets assigned the **User.Read** permission. However, for external tenants, the customer users themselves can't consent to this permission. You as the admin must consent to this permission on behalf of all the users in the tenant:

1. From the **Overview** page of your app registration, under **Manage** select **API permissions**.
1. Select **Grant admin consent for < tenant name >**, then select **Yes**.
1. Select **Refresh**, then verify that **Granted for < tenant name >** appears under **Status** for the permission.

## Add a redirect URI

A *redirect URI* is the location where the Microsoft identity platform redirects a user's client and sends security tokens after authentication. Redirect URIs should be added to;

- Web applications
- Single-page applications
- Mobile applications
- Desktop applications

### Configure platform settings

Settings for each application type, including redirect URIs, are configured in **Platform configurations** in the Azure portal. Some platforms, like **Web** and **Single-page applications**, require you to manually specify a redirect URI. For other platforms, like mobile and desktop, you can select from redirect URIs generated for you when you configure their other settings.

To configure application settings based on the platform or device you're targeting, follow these steps:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Under **Manage**, select **Authentication**.
1. Under **Platform configurations**, select **Add a platform**.
1. Under **Configure platforms**, select the tile for your application type (platform) to configure its settings.

   :::image type="content" source="./media/quickstart-register-app/portal-04-app-reg-03-platform-config.png" alt-text="Screenshot of the platform configuration pane in the Azure portal." border="false":::

   | Platform  | Configuration settings | Example |
   | --------- |------------------------|---------|
   | **Web**   | Enter the **Redirect URI** for a web app that runs on a server. Front channel logout URLs can also be added | Node.js: <br>&#8226; `http://localhost:3000/auth/redirect` <br> ASP.NET Core:<br>  &#8226; `https://localhost:7274/signin-oidc` <br>  &#8226; `https://localhost:7274/signout-callback-oidc` (Front-channel logout URL) <br> Python: <br>&#8226; `http://localhost:3000/getAToken` |
   | **Single-page application** | Enter a **Redirect URI** for client-side apps using JavaScript, Angular, Vue.js, React.js, or Blazor WebAssembly. Front channel logout URLs can also be added | JavaScript, React: <br>&#8226; `http://localhost:3000` <br>Angular: <br>&#8226; `http://localhost:4200/`|
   | **iOS / macOS** | Enter the app **Bundle ID**, which generates a redirect URI for you. Find it in **Build Settings** or in Xcode in *Info.plist*. | <br>Workforce tenant: <br>&#8226; `com.<yourname>.identitysample.MSALMacOS` <br>External tenant: <br>&#8226; `com.microsoft.identitysample.ciam.MSALiOS` |
   | **Android** | Enter the app **Package name**, which generates a redirect URI for you. Find it in the *AndroidManifest.xml* file. Also generate and enter the **Signature hash**. | Kotlin: <br>&#8226; `com.azuresamples.msaldelegatedandroidkotlinsampleapp` <br>.NET MAUI: <br>&#8226; `msal{CLIENT_ID}://auth`  <br> Java: <br>&#8226; `com.azuresamples.msalandroidapp` |
   | **Mobile and desktop applications** | Select this platform for desktop apps or mobile apps not using MSAL or a broker. Select a suggested **Redirect URI**, or specify one or more **Custom redirect URIs** | Embedded browser desktop app: <br>&#8226; `https://login.microsoftonline.com/common/oauth2/nativeclient` <br> System browser desktop app:<br>&#8226; `http://localhost` |

1. Select **Configure** to complete the platform configuration.

### Redirect URI restrictions

There are some restrictions on the format of the redirect URIs you add to an app registration. For details about these restrictions, see [Redirect URI (reply URL) restrictions and limitations](./reply-url.md).

## Add credentials

After registering an app, you can add certificates, client secrets (a string), or federated identity credentials as credentials to your confidential client app registration. Credentials allow your application to authenticate as itself, requiring no interaction from a user at runtime, and are used by [confidential client applications](./msal-client-applications.md) that access a web API. 

Examples of confidential clients are web apps, other web APIs, or service-type and daemon-type applications. Public client applications, like single-page apps, mobile and desktop apps use different methods such as Authorization Code flow with PKCE to authenticate users.

:::image type="content" source="./media/quickstart-register-app/portal-05-app-reg-04-credentials.png" alt-text="Screenshot of the Microsoft Entra admin center, showing the Certificates and secrets pane in an app registration." lightbox="./media/quickstart-register-app/portal-05-app-reg-04-credentials.png":::

### [Add a certificate](#tab/certificate)

Sometimes called a *public key*, a certificate is the recommended credential type because they're considered more secure than client secrets. 

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
2. Select **Certificates & secrets** > **Certificates** > **Upload certificate**.
3. Select the file you want to upload. It must be one of the following file types: *.cer*, *.pem*, *.crt*.
4. Select **Add**.

In production, you should use a certificate signed by a well known certificate authority (CA) such as [Azure Key Vault](https://azure.microsoft.com/products/key-vault/). For more information about using a certificate as an authentication method in your application, see [Microsoft identity platform application authentication certificate credentials](./certificate-credentials.md).

### [Add a client secret](#tab/client-secret)

Sometimes called an *application password*, a client secret is a string value your app can use in place of a certificate to identify itself.

Client secrets are less secure than certificate or federated credentials and therefore should **not be used** in production environments. While they may be convenient for local app development, it is imperative to use certificate or federated credentials for any applications running in production to ensure higher security.

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
1. Add a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
    - Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months.
    - Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. *Record the secret's value* for use in your client application code. This secret value is *never displayed again* after you leave this page.

For application security recommendations, see [Microsoft identity platform best practices and recommendations](./identity-platform-integration-checklist.md#security).

If you're using an Azure DevOps service connection that automatically creates a service principal, you need to update the client secret from the Azure DevOps portal site instead of directly updating the client secret. Refer to this document on how to update the client secret from the Azure DevOps portal site:
[Troubleshoot Azure Resource Manager service connections](/azure/devops/pipelines/release/azure-rm-endpoint#service-principals-token-expired).

### [Add a federated credential](#tab/federated-credential)

Federated identity credentials are a type of credential that allows workloads, such as GitHub Actions, workloads running on Kubernetes, or workloads running in compute platforms outside of Azure access Microsoft Entra protected resources without needing to manage secrets using [workload identity federation](~/workload-id/workload-identity-federation.md).

To add a federated credential, follow these steps:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Select **Certificates & secrets** > **Federated credentials** > **Add credential**.
1. In the **Federated credential scenario** drop-down box, select one of the supported scenarios, and follow the corresponding guidance to complete the configuration.

    - **Customer managed keys** for encrypt data in your tenant using Azure Key Vault in another tenant.
    - **GitHub actions deploying Azure resources** to [configure a GitHub workflow](~/workload-id/workload-identity-federation-create-trust.md#github-actions) to get tokens for your application and deploy assets to Azure.
    - **Kubernetes accessing Azure resources** to configure a [Kubernetes service account](~/workload-id/workload-identity-federation-create-trust.md#kubernetes) to get tokens for your application and access Azure resources.
    - **Other issuer** to configure the application to [trust a managed identity](~/workload-id/workload-identity-federation-config-app-trust-managed-identity.md) or an identity managed by an external [OpenID Connect provider](~/workload-id/workload-identity-federation-create-trust.md#other-identity-providers) to get tokens for your application and access Azure resources.

For more information on how to get an access token with a federated credential, see [Microsoft identity platform and the OAuth 2.0 client credentials flow](./v2-oauth2-client-creds-grant-flow.md#third-case-access-token-request-with-a-federated-credential).

---

## Next step

### [Expose a web API](#tab/expose-a-web-api)

After registering an app, you can configure it to expose a web API. To learn how, refer to;

> [!div class="nextstepaction"]
> [Configure an application to expose a web API](quickstart-configure-app-expose-web-apis.md)

### [Explore sample code](#tab/explore-sample-code)

The Microsoft identity platform offers a variety of code samples tailored for different application types and platforms. To explore these samples, refer to;

> [!div class="nextstepaction"]
> [Microsoft identity platform code samples](./sample-v2-code.md)

---