---
title: Tutorial - Build a secure web app on Azure App Service
description: In this tutorial, you learn how to build a web app by using Azure App Service, sign in users to the web app, call Azure Storage, and call Microsoft Graph. 
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.custom: app-service-web, storage, microsoft-graph
ms.date: 02/07/2024
ms.reviewer: stsoneff
ms.service: azure-app-service
ms.subservice: web-apps
ms.topic: tutorial
#Customer intent: As an application developer, I want to learn how to secure access to a web app running on Azure App Service.
---

# Sign in users in App Service and access storage and Microsoft Graph

This tutorial describes a common application scenario: an internal employee dashboard web application. Your web app is hosted in Azure App Service and needs to connect to Microsoft Graph and Azure Storage in order to get data to visualize in the dashboard.  In some cases, the web app needs to get data that only the signed-in user can access.  In other cases, the web app needs to access data under the identity of the app itself, and not the signed-in user.  Access to the web application needs to be restricted to users in your organization.

The goal of this tutorial *isn't* to show how to build the dashboard itself or visualize data.  Rather, the tutorial focuses on the identity-related aspects of the described scenario.  Learn how to:  

- [Configure authentication for a web app](multi-service-web-app-authentication-app-service.md) and limit access to users in your organization​. See A in the diagram.
- [Securely access Azure Storage](multi-service-web-app-access-storage.md) from the web application using managed identities​. See B in the diagram.
- Access data in Microsoft Graph from the web application (See C in the diagram):
    - [as the signed-in user​](multi-service-web-app-access-microsoft-graph-as-user.md)
    - [as the web application](multi-service-web-app-access-microsoft-graph-as-app.md) using managed identities​
- [Clean up the resources](multi-service-web-app-clean-up-resources.md) you created for this tutorial.

:::image type="content" source="./media/multi-service-web-app-overview/web-app.svg" alt-text="Diagram that shows application scenarios in Microsoft identity platform." border="false":::

## Next steps

> [!div class="nextstepaction"]
> [Configure authentication for a web app](multi-service-web-app-authentication-app-service.md)
