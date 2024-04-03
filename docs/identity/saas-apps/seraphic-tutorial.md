---
title: Microsoft Entra SSO integration with Seraphic Security
description: Learn how to configure single sign-on between Microsoft Entra ID and Seraphic Security.

author: MariaSeraphic
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
---

# Integrating Microsoft Entra SSO (Azure AD) with Seraphic

This document outlines the integration process of Microsoft Entra ID with Seraphic, providing instructions on setting up a Seraphic SSO app within Entra and managing Seraphic console access through Entra ID.

You can configure integrations of Entra SSO to use for the following:
1. Seraphic console
2. Seraphic Applications Portal 
3. Browser
Each integration must be configured separately.

## Prerequisites

* The individual creating the app must be assigned one of the following roles: Global Administrator, Cloud Application Administrator, or Application Administrator.

## Configuration of Entra SSO application 
 A new Entra SSO application must be created for every SSO use mentioned above.

1. Sign in to [Entra.](https://entra.microsoft.com) 
2. Under **Identity**, select **Applications** > **App registrations** > **New registration**.  
3. Define the following parameters:  
    * **Name**: *Desired name*. 
    * **Supported account types**: Select **Accounts in this organizational directory only ({tenant name} only – single tenant).** 
    * **Redirect URI**: Under **Select a platform**, select **Single-page application (SPA)**. Depending on the target system, enter the following:     
    Console: `https://auth.seraphicsecurity.com/login/sso/azure-callback`       
    Browser: `https://auth.seraphicsecurity.com/login/sso/azure-callback`     
    Application Portal: `https://auth.seraphicsecurity.com/login/sso/azure-callback`     
4. Select **Register.** 
5. Copy the **Application (client) ID** and the **Directory (tenant) ID**, and save for your records. 
6. Restrict enterprise application to grant access only to specific users groups:    
    i. In the navigation menu, click **Identity** > **Enterprise applications** > select the **Seraphic SSO application** > **Properties.**    
    ii. **Assignment required** toggle to **Yes**.    
    iii. Go to **Users and groups** and select who can access the application.    
7. Go to **Enterprise applications** > select the created Seraphic application. 
8. Under the **Security** > select **Permissions**. 
9. Click **Grant admin consent for Seraphic**. (This grants permission for the application to access information from Microsoft Graph.) 

## Configuration in Seraphic  
1. Sign in to the [Seraphic Web Console.](https://console.seraphicsecurity.com/) 
2. In the navigation menu, click **Settings** > **Third-Party Integration** > **Add Integration** > Under **SSO** > **Entra** > **Next.** An **Duo SSO** popup appears.
3. In the Entra SSO Integration popup enter the following parameters:  
    * **Integration Name:** *Desired name*.  It is recommended to distinguish whether it is for the console, the browser, or for the Application Portal.
    * **Client ID**:* Enter previously saved value for *Application (client) ID*. 
    * **Tenant ID**: Enter previously saved value for *Directory (tenant) ID*. 
    * **Target System**: Select **Console**, **Application Portal**, or **Browser**.    
**Note**: To enforce browser login via SSO, configuration of the Enforce Login rule (General category) is required, or alternatively, use Seraphic Workspace. 
4. Click **Save**.    
Entra appears in the list of integrations, and you can edit or remove the data.    
    * If the integration was created for the console: In the next login to Seraphic Web Console, an Entra icon appears on the bottom of the Seraphic login. Selecting it redirects and signs you in using your Entra credentials instead of your Seraphic credentials. 
    * If the integration was created for the Application Portal Login: The Entra icon will appear in the Application Portal Login.
    * If the integration was created for the browser: When accessing a browser thorough the Seraphic Workspace, use your Entra credentials to authenticate.     
**Note**: Make sure you use the Microsoft username and tenant with which you want to log into Entra SSO. 