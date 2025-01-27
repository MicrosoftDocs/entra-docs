---
title: Sign in users in an Android app by using Microsoft identity platform
description: Set up an Android app project that signs in users into customer facing app by in an external tenant or employees in a workforce tenant

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 01/27/2025
ms.custom: developer

#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra External ID
---

# Tutorial: Set up an Android app to sign in users by using Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]


This is the second tutorial in the tutorial series that demonstrates how to add Microsoft Authentication Library (MSAL) for Android to your Android app. MSAL enables Android applications to authenticate users with Microsoft Entra.

In this tutorial you'll;

> [!div class="checklist"]
>
> - Add MSAL dependency
> - Add configuration
> - Use custom URL domain (Optional)
> - Create MSAL SDK instance

## Prerequisites

- [Quickstart: Sign in users in a sample mobile app](quickstart-mobile-app-sign-in.md?pivots=external&tabs=java-external).
- An Android project. If you don't have an Android project, create it.

## Add MSAL dependency and relevant libraries to your project

To add MSAL dependencies in your Android project, follow these steps:

1. Open your project in Android Studio or create a new project.
1. Open your application's `build.gradle` and add the following dependencies:

    ```gradle
    allprojects {
    repositories {
        //Needed for com.microsoft.device.display:display-mask library
        maven {
            url 'https://pkgs.dev.azure.com/MicrosoftDeviceSDK/DuoSDK-Public/_packaging/Duo-SDK-Feed/maven/v1'
            name 'Duo-SDK-Feed'
        }
        mavenCentral()
        google()
        }
    }
    //...
    
    dependencies { 
        implementation 'com.microsoft.identity.client:msal:5.+'
        //...
    }
    ```
   
    
    In the `build.gradle` configuration, repositories are defined for project dependencies. It includes a Maven repository URL for the `com.microsoft.device.display:display-mask` library from Azure DevOps. Additionally, it utilizes Maven Central and Google repositories. The dependencies section specifies the implementation of the MSAL version 5 and potentially other dependencies. 

1. In Android Studio, select **File** > **Sync Project with Gradle Files**.


## Add configuration

#### [Android workforce tenant configuration](#tab/android-workforce)

Workforce tenant configuration is similar to external tenant configuration. The only difference is the tenant ID.

#### [Android external tenenat configuration](#tab/android-external)

External tenant configuration is similar to workforce tenant configuration. The only difference is the tenant ID.

---