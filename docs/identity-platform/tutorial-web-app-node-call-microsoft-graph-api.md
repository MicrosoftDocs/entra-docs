---
title: Tutorial - Call Microsoft Graph API from a Node/Express.js web app
description: Learn how to acquire an access token in a Node/Express.js web to read user's profile detail from Microsoft Graph API 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: identity-platform
ms.topic: tutorial
ms.date: 01/03/2025
#Customer intent: As a dev, devops, I want to learn about how to acquire an access token in a Node/Express.js web app, then use it to call Microsoft Graph API so that I can read a signed-in user's profile details
---

# Tutorial: Call Microsoft Graph API from a Node/Express.js web app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you call Microsoft Graph API from a Node/Express.js web app. Once a user signs in, the app acquires an access token to call Microsoft Graph API.

This tutorial is part 3 of the 3-part tutorial series.

In this tutorial, you'll:

> [!div class="checklist"]
>
> - Update Node/Express.js web app to acquire an access token
> - Use the access token to call Microsoft Graph API.

## Prerequisites

- Complete the steps in [ Tutorial: Add add sign-in to a Node/Express.js web app by using Microsoft identity platform](tutorial-web-app-node-sign-in-sign-out.md). 