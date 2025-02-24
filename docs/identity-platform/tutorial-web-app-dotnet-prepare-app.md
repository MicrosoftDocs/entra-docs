---
title: "Tutorial: Prepare a web application for authentication"
description: Learn how to create and prepare an ASP.NET Core application for authentication with the Microsoft identity platform, and secure it with a self-signed certificate.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 01/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to use an IDE to set up an ASP.NET Core project, set up and upload a self signed certificate to the Microsoft Entra admin center and configure the application for authentication.
---

# Tutorial: Prepare an application for authentication

In the [previous tutorial](tutorial-web-app-dotnet-register-app.md), you registered a web application in the Microsoft Entra admin center. This tutorial demonstrates how to create an ASP.NET Core web app using an IDE. You'll also create and upload a self-signed certificate to the Microsoft Entra admin center to secure your application. Finally, you'll configure the application for authentication.

In this tutorial:

> [!div class="checklist"]
>
> * Create an ASP.NET Core web app
> * Create a self-signed certificate
> * Configure the settings for the application
> * Define platform settings and URLs

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Register an application with the Microsoft identity platform](tutorial-web-app-dotnet-register-app.md).
* You can download an IDE used in this tutorial [here](https://visualstudio.microsoft.com/downloads).
  * Visual Studio 2022
  * Visual Studio Code
  * Visual Studio 2022 for Mac
* A minimum requirement of [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet).

## Create an ASP.NET Core project

Use the following tabs to create an ASP.NET Core project within an IDE.

### [Visual Studio](#tab/visual-studio)

1. Open Visual Studio, and then select **Create a new project**.
1. Search for and choose the **ASP.NET Core Web App** template, and then select **Next**.
1. Enter a name for the project, such as *NewWebAppLocal*.
1. Choose a location for the project or accept the default option, and then select **Next**.
1. Accept the default for the **Framework**, **Authentication type**, and **Configure for HTTPS**. **Authentication type** can be set to **None** as this tutorial covers the process.
1. Select **Create**.

### [Visual Studio Code](#tab/visual-studio-code)

1. Open Visual Studio Code, select **File > Open Folder...**. Navigate to and select the location in which to create your project.
1. Create a new folder using the **New Folder...** icon in the **Explorer** pane. Provide a name similar to the one registered previously, for example, *NewWebAppLocal*.
1. Open a new terminal by selecting **Terminal > New Terminal**.
1. To create an ASP.NET Core web app template, run the following commands in the terminal to change into the directory and create the project:

    ```powershell
    cd NewWebAppLocal
    dotnet new webapp
    ```

---

## Create and upload a self-signed certificate

The use of certificates is a suggested way of securing communication between client and server. For the purpose of this tutorial, a self-signed certificate will be created in the project directory. Learn more about self-signed certificates [here](howto-create-self-signed-certificate.md).

### [Visual Studio](#tab/visual-studio)

1. Select **Tools > Command Line > Developer Command Prompt**.

1. Enter the following command to create a new self-signed certificate:

    ```powershell
    dotnet dev-certs https -ep ./certificate.crt --trust
    ```

### [Visual Studio Code](#tab/visual-studio-code)

1. In the **Terminal**, enter the following command to create a new self-signed certificate:

    ```powershell
    dotnet dev-certs https -ep ./certificate.crt --trust
    ```

---

### Upload certificate to the Microsoft Entra admin center

To make the certificate available to the application, it must be uploaded into the tenant.

1. Starting from the **Overview** page of the app created earlier, under **Manage**, select **Certificates & secrets** and select the **Certificates (0)** tab.
1. Select **Upload certificate**.

    :::image type="content" source="./media/web-app-tutorial-02-prepare-application/upload-certificate.png" alt-text="Screenshot of uploading a certificate into a Microsoft Entra tenant." lightbox="./media/web-app-tutorial-02-prepare-application/upload-certificate.png":::

1. Select the **folder** icon, then browse for and select the certificate that was previously created.
1. Enter a description for the certificate and select **Add**.
1. Record the **Thumbprint** value, which will be used in the next step.

    :::image type="content" source="./media/web-app-tutorial-02-prepare-application/copy-certificate-thumbprint.png" alt-text="Screenshot showing copying the certificate thumbprint.":::

## Configure the application for authentication and API reference

The values recorded earlier will be used to configure the application for authentication. The configuration file, *appsettings.json*, is used to store application settings used during run-time. As the application will also call into a web API, it must also contain a reference to it. 

1. In your IDE, open *appsettings.json* and replace the file contents with the following snippet. Replace the text in quotes with the values that were recorded earlier.
  
   :::code language="json" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/appsettings.json":::

    * `Instance` - The authentication endpoint. Check with the different available endpoints in [National clouds](authentication-national-cloud.md#azure-ad-authentication-endpoints).
    * `TenantId` - The identifier of the tenant where the application is registered. Replace the text in quotes with the **Directory (tenant) ID** value that was recorded earlier from the overview page of the registered application.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier from the overview page of the registered application.
    * `ClientCertificates` - A self-signed certificate is used for authentication in the application. Replace the text of the `CertificateThumbprint` with the thumbprint of the certificate that was previously recorded.
    * `CallbackPath` - Is an identifier to help the server redirect a response to the appropriate application.
    * `DownstreamApi` - Is an identifier that defines an endpoint for accessing Microsoft Graph. The application URI is combined with the specified scope. To define the configuration for an application owned by the organization, the value of the `Scopes` attribute is slightly different.
1. Save changes to the file.
1. In the **Properties** folder, open the *launchSettings.json* file.
1. Find and record the `https` value `applicationURI` within *launchSettings.json*, for example `https://localhost:{port}`. This URL will be used when defining the **Redirect URI**. Do not use the `http` value. 

## Add a platform redirect URI

1. In the Microsoft Entra admin center, under **Manage**, select **App registrations**, and then select the application that was previously created.
1. In the left menu, under **Manage**, select **Authentication**.
1. In **Platform configurations**, select **Add a platform**, and then select **Web**.

    :::image type="content" source="./media/web-app-tutorial-02-prepare-application/select-platform.png" alt-text="Screenshot on how to select the platform for the application." lightbox="./media/web-app-tutorial-02-prepare-application/select-platform.png":::

1. Under **Redirect URIs**, enter the `applicationURL` and the `CallbackPath`, `/signin-oidc`, in the form of `https://localhost:{port}/signin-oidc`.
1. Under **Front-channel logout URL**, enter the following URL for signing out, `https://localhost:{port}/signout-oidc`.
1. Select **Configure**.

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Add sign-in to an application](tutorial-web-app-dotnet-sign-in-users.md)
