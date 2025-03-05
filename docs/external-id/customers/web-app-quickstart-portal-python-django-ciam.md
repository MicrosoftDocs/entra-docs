---
title: "Quickstart: Add sign in to a Python Django web app"
description: Learn how to run a sample Python Django web app to sign in users
 
author: SHERMANOUKO
manager: mwongerapk
ms.author: shermanouko
ms.service: entra-external-id
 
ms.custom: devx-track-python
ROBOTS: NOINDEX
ms.subservice: external
ms.topic: concept-article
ms.date: 04/24/2024
---

# Portal quickstart for Python Django web app

> In this quickstart, you download and run a code sample that demonstrates how a Python Django web app can sign in users with Microsoft Entra External ID.
>
> [!div renderon="portal" id="display-on-portal" class="sxs-lookup"]
> 1. Make sure you've installed [Python 3+](https://www.python.org/).
>
> 1. Unzip the sample app
>
> 1. In your terminal, navigate to the project directory of the app then run the following command to install dependencies:
>
>     ```console
>     pip install -r requirements.txt
>     ```
> 1. In your terminal, run the following command to start the app:
>
>     ```console
>     python manage.py migrate
>     python manage.py runserver localhost:5000
>     ```
>
> 1. Open your browser, visit `http://localhost:5000`, select **Sign-in**, then follow the prompts.
>