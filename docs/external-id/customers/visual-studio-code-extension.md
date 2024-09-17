---
title: Visual Studio Code extension for External ID
description: Learn how to use the Microsoft Entra External ID extension for Visual Studio Code. Use the application samples provided to set up a customized, branded sign-in experience for external users of your application without leaving the development environment.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
ms.subservice: customers
ms.topic: quickstart
ms.date: 09/16/2024
ms.author: mimart
ms.custom: it-pro

# Customer intent: As a dev, devops, or it admin, I want to create an external tenant and configure a customized, branded sign-in experience for my apps from within Visual Studio Code.
---

# Quickstart: Get started with the Microsoft Entra External ID extension for Visual Studio Code

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Integrating authentication into your consumer and business customer applications is essential for securing resources and customer data. The Microsoft Entra External ID extension for Visual Studio Code lets you quickly create external tenants, configure sign-in experiences for external users, and set up an External ID sample, all directly within Visual Studio Code. Using the extension walkthrough, you can learn how to set up a customized, branded sign-in experience for external users of your application and bootstrap your projects with preconfigured sample applications.

:::image type="content" source="media/visual-studio-code-extension/extension-overview.png" alt-text="Screenshot showing an overview of the extension.":::

This extension provides a basic setup that automatically creates a tenant for applications and prepares it for users. It also streamlines your workflow by automatically populating values such as application IDs into your configuration file for a smoother setup process.

External ID is a service that can be added to an Azure subscription. If you already have one, you can easily include External ID. Otherwise, set up a [free trial of Microsoft Entra External ID](quickstart-trial-setup.md) within Visual Studio Code and start by configuring a sample app.

## Install the extension

The Microsoft Entra External ID extension is available in the Visual Studio Code Marketplace.

1. If you don’t already have Visual Studio Code installed, [download Visual Studio Code](https://code.visualstudio.com/Download) and complete the installation steps.
1. Install the Microsoft Entra External ID Extension for Visual Studio Code from [https://aka.ms/vscodequickstart/marketplace](https://aka.ms/vscodequickstart/marketplace).

After the extension is installed, you can access it using the icon on the activity bar.

:::image type="content" source="media/visual-studio-code-extension/open-extension-walkthrough.png" alt-text="Screenshot showing the open extension walkthrough options.":::

You can also open the extension from Visual Studio Code **Welcome** page: Select **Help** > **Welcome**, and then under **Walkthroughs**, select **Get started with Microsoft Entra External ID**. You might need to select **More…** to expand the list of extensions.

## Get started with your External ID setup

The Microsoft Entra External ID extension creates a tenant in an external configuration, which contains your app and directory of external users. You can add this new tenant to your existing Azure subscription. Or if you don’t have an Azure subscription, create a trial tenant that doesn't require one ([learn more](quickstart-trial-setup.md)).

- On the Get Started with Microsoft Entra External ID welcome page, choose an option:

  - If you don't already have an Azure Account, select **Set up a free trial**.
  - If you already have an Azure account, select **Use my subscription**.

   :::image type="content" source="media/visual-studio-code-extension/get-started-step.png" alt-text="Screenshot of the get started options.":::

### Set up a free trial (preview)

1. Select **Set up a free trial**.
1. In the sign-in confirmation message, select **Allow**.
1. A new browser window opens. Sign in using your personal account, Microsoft account (MSA), or GitHub account. Once you’re signed in, close the browser window.
1. Return to Visual Studio Code. In the **Where should the tenant be located?** menu, select a location for your tenant data. This selection can't be changed later.
1. Enter a unique name for the tenant.

   :::image type="content" source="media/visual-studio-code-extension/name-tenant.png" alt-text="Screenshot of the tenant name field.":::

1. The extension creates your trial tenant. You can view the progress by opening the **View** > **Output** window. When the process is complete, **The tenant is created** appears.

### Use your subscription

1. Select **Use my subscription**.
1. If there are multiple tenants associated with your account, the **Choose a directory** menu appears. Select the directory (tenant) associated with the subscription you want to use.

   :::image type="content" source="media/visual-studio-code-extension/choose-directory.png" alt-text="Screenshot of the directory field.":::
  
   > [!NOTE]
   > If the message **No subscriptions available** appears, you can set up a free trial instead.

1. A browser page opens where you can sign in to your account. After you sign in, return to Visual Studio Code.
1. In the **Add a subscription** menu, select your subscription.
1. In the **Select a resource group** menu, choose a resource group.  
1. In the **Where should the tenant be located?** menu, select a location for your tenant data. This selection can't be changed later.
1. Enter a name for the tenant, and then select **Enter** to create the tenant.

   :::image type="content" source="media/visual-studio-code-extension/name-tenant.png" alt-text="Screenshot of the trial tenant name field.":::

   > [!NOTE]
   > The tenant creation process can take up to 30 minutes. Once the tenant is created, you can access it in both the Microsoft Entra admin center and the Azure portal.

## Set up sign-in for your users

You can configure your app to allow users to sign in with their email and a password or a one-time passcode. You can also design the look and feel of the user experience by adding your company logo, changing the background color, or adjusting the sign-in layout. These  changes apply to the look and feel of all your apps in this new tenant.

1. Under **Set up sign-in for your users**, select **Set up sign-in and branding**.

   :::image type="content" source="media/visual-studio-code-extension/set-up-sign-in-step.png" alt-text="Screenshot showing the set up sign-in and branding step.":::

1. You’re prompted to sign in to the new tenant. Select **Allow**, and in the browser window that opens, choose the account you’re currently using and sign in. Return to Visual Studio Code.

1. In the **How would you like your users to sign in?** menu at the top, choose the sign-in method you want to make available to your users: **Email and password** or **Email and one-time passcode**.

   :::image type="content" source="media/visual-studio-code-extension/select-sign-in-method.png" alt-text="Screenshot showing sign-in methods.":::

1. Select **OK**.

1. Choose where you want the sign-in page to appear in the browser window, either **Center-aligned** or **Right-aligned**.

   :::image type="content" source="media/visual-studio-code-extension/select-alignment.png" alt-text="Screenshot showing the sign-in layout selections.":::

1. Select a background color for your sign-up page.

   :::image type="content" source="media/visual-studio-code-extension/select-background.png" alt-text="Screenshot showing background colors.":::

1. Next, a File Explorer window opens so you can add your company logo. Browse to your company logo file, and then select **Upload**.

   > [!NOTE]
   > Image requirements are as follows:
   > - Image size 245 x 36 px
   > - Maximum file size 50 KB
   > - File type: Transparent PNG or JPEG

1. The message **Configuring sign-in flow** appears. You can view the progress in the Output window. When configuration is finished, the message **User flow setup is complete** appears.  

## Try out your sign-in experience

The **Try out your sign-in experience** step in the walkthrough allows you to preview the sign-in experience you configured.

   :::image type="content" source="media/visual-studio-code-extension/try-out.png" alt-text="Screenshot of option to try out your sign-in experience.":::


1. Select the **Run it now** button. A new browser tab opens with the sign-up page for your tenant that can be used to create and sign in users.

1. Select **No account? Create one** to create a new user in the tenant.

1. Add your new user's email address and select **Next**. Don't use the same email you used to create your trial.

1. Complete the sign-up steps on the screen. Typically, once the user signs in, they're redirected back to your app. However, since you haven’t set up an app at this step, you're redirected to JWT.ms instead, where you can view the contents of the token issued during the sign-in process.

To find the user you created during this step, you can go to the [Microsoft Entra admin center](https://entra.microsoft.com/) and look for the user in the users list.

## Set up and run a sample app

The extension contains several code samples that demonstrate how authentication is implemented in different application types and development languages. Samples are included for single page apps (JavaScript, React, Angular) and web apps [Node.js (Express), ASP.NET Core, Python Django, Python Flask, Java Servlet]. Choose a sample from within the extension, and the extension automatically configures the application with your sign-in experience.

1. Under select **Set up and run a sample app**, select the **Set up sample app button**.

   :::image type="content" source="media/visual-studio-code-extension/set-up-sample-app.png" alt-text="Screenshot of the Set up and run a sample app step.":::

1. In the menu, select the type of app you want to download. If you're prompted to select your account again, choose the same account you’ve been using.

   :::image type="content" source="media/visual-studio-code-extension/select-app-type.png" alt-text="Screenshot of the app selection.":::	

1. A File Explorer window opens so you can choose where you want to save the sample repository. Select a folder, and then select **Download repository here**.
1. When the download completes, a new Visual Studio Code project workspace opens with the downloaded app folder displayed in the Explorer.
1. Open a new terminal in the Visual Studio Code window.
1. In the top menu, select **Run** > **Run without debugging**. The Debug Console shows the launch script progress. There's a short delay while the project is set up and the build script runs.

When the extension downloads the application, it automatically updates the Microsoft Authentication Library (MSAL) configuration to connect to your new tenant and to use the experience you set up. No further configuration is needed; you can run the application as soon as the project is built. For example in the authConfig file, the **clientId** is set to your application ID and the **authority** is set to the subdomain for your new tenant.

:::image type="content" source="media/visual-studio-code-extension/auth-config-file.png" alt-text="Screenshot of an auth-config file.":::

## Run the experience

After setup is complete, try out the sign-in experience by entering the local host redirect URI for the application in a browser. The redirect URL is available in the application’s README.md file.

## Use the Explorer view

The Explorer view displays **Manage resources**, **Getting started** and **Help and Feedback** sections. To open the Explorer view, select the extension icon visible in the activity bar of Visual Studio Code.

## Manage resources

In the **Manage resources** section, you can view and manage your external tenants, registered applications, user flows, and company branding. To view project resources, expand the nodes in the left panel under **Manage Resources**.

:::image type="content" source="media/visual-studio-code-extension/explorer-manage-resources.png" alt-text="Screenshot of the explorer view.":::

In the **Manage resources** section, you can select a resource and go directly to the Microsoft Entra admin center to manage or configure it. For example, right-click an application and select **Open in admin center**. You’re prompted to sign in, and then the Microsoft Entra admin center opens directly to the app registration page for that application.

:::image type="content" source="media/visual-studio-code-extension/explorer-open-admin-center.png" alt-text="Screenshot of the open in admin center option.":::

## Getting Started actions

In the Getting Started section, you can access documentation for the free trial, or go directly to the sign-in experience configuration or sample app download pages without opening the extension walkthrough.

:::image type="content" source="media/visual-studio-code-extension/left-menu-configure-sign-in.png" alt-text="Screenshot of the left menu option for starting the walkthrough.":::

## Next steps

- To further customize your tenant and explore the full range of configuration options, visit the [Microsoft Entra admin center](https://entra.microsoft.com/).
- For the latest developer content and resources, check the [External ID developer center](https://aka.ms/ciam/dev).
- To configure your own app for authentication, see the **tutorial** links. These tutorials assist you in building and integrating your own apps with Microsoft Entra External ID. You can also add [custom authentication extensions](concept-custom-extensions.md) at specific points within the authentication flow.
