---
title: Azure Single Sign-On (SSO) Integration
author: MuhammadSufyan-humfoc
ms.topic: tutorial
description: Learn how to integrate Azure SSO with your application.
---

# Azure Single Sign-On (SSO) Integration

## Overview

This documentation will guide you through integrating Azure Single Sign-On (SSO) with your application. By following these steps, you will enable users to authenticate using their Azure AD credentials.

## Prerequisites

- An Azure account
- Access to Azure Active Directory (Azure AD)
- Administrative permissions for Azure AD

## Step 1: Register Your Application in Azure AD

1. **Sign in to the Azure portal**:
   - Go to the [Azure portal](https://portal.azure.com) and sign in with your Azure account.

2. **Navigate to Azure Active Directory**:
   - In the left-hand navigation pane, select **Azure Active Directory**.

3. **Register a new application**:
   - Select **App registrations** > **New registration**.
   - Enter a name for your application (e.g., "MyApp").
   - Select the supported account types.
   - Enter the Redirect URI (optional). This URI is where the token will be sent after authentication.
     - For web applications, use a URI like `https://myapp.com/auth-response`.
   - Click **Register**.

## Step 2: Configure SSO for the Application

1. **Configure the application**:
   - In the **App registrations** section, select your newly registered application.
   - Navigate to **Authentication** and set the **Redirect URIs**.
   - Add any additional URIs required by your application.

2. **Configure the API permissions**:
   - Navigate to **API permissions**.
   - Click **Add a permission** > **Microsoft Graph** > **Delegated permissions**.
   - Add the necessary permissions, such as `User.Read`.

3. **Generate a client secret**:
   - Navigate to **Certificates & secrets**.
   - Click **New client secret**.
   - Add a description and set the expiration period.
   - Click **Add** and copy the secret value. This will be used in your application for authentication.

## Step 3: Set Up the Application for SSO

1. **Add SSO configuration in your application**:
   - In your application's configuration file (e.g., `appsettings.json` for an ASP.NET app), add the following settings:

     ```json
     {
       "AzureAd": {
         "Instance": "https://login.microsoftonline.com/",
         "Domain": "yourdomain.com",
         "TenantId": "your-tenant-id",
         "ClientId": "your-client-id",
         "ClientSecret": "your-client-secret",
         "CallbackPath": "/signin-oidc"
       }
     }
     ```

2. **Install necessary packages**:
   - For ASP.NET Core applications, install the `Microsoft.Identity.Web` and `Microsoft.Identity.Web.UI` NuGet packages.

     ```sh
     dotnet add package Microsoft.Identity.Web
     dotnet add package Microsoft.Identity.Web.UI
     ```

3. **Configure the middleware**:
   - In the `Startup.cs` file, configure the authentication middleware:

     ```csharp
     public void ConfigureServices(IServiceCollection services)
     {
         services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
                 .AddMicrosoftIdentityWebApp(Configuration.GetSection("AzureAd"));

         services.AddControllersWithViews();
         services.AddRazorPages();
     }

     public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
     {
         if (env.IsDevelopment())
         {
             app.UseDeveloperExceptionPage();
         }
         else
         {
             app.UseExceptionHandler("/Home/Error");
             app.UseHsts();
         }
         
         app.UseHttpsRedirection();
         app.UseStaticFiles();
         app.UseRouting();
         app.UseAuthentication();
         app.UseAuthorization();

         app.UseEndpoints(endpoints =>
         {
             endpoints.MapControllerRoute(
                 name: "default",
                 pattern: "{controller=Home}/{action=Index}/{id?}");
             endpoints.MapRazorPages();
         });
     }
     ```

## Step 4: Test the Integration

1. **Run your application**:
   - Start your application and navigate to the login page.
   - Click the sign-in button, which should redirect you to the Azure AD login page.

2. **Authenticate using Azure AD**:
   - Enter your Azure AD credentials.
   - If the integration is successful, you should be redirected back to your application with the user's information.

## Conclusion

You have successfully integrated Azure Single Sign-On (SSO) with your application. Users can now authenticate using their Azure AD credentials, providing a seamless and secure login experience.
