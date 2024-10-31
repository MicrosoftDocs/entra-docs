---
title: Call a protected web API in Android (Kotlin) app
description: The tutorials provide a step-by-step guide on how to Call a protected web API in Android (Kotlin) app for authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 05/10/2024
ms.custom: developer
#Customer intent: As a developer, I want to learn how to Call a protected web API in Android (Kotlin) app for authentication using Microsoft Entra External ID.
---

# Tutorial: Call a protected web API in Android (Kotlin) app

This is the fourth tutorial in the tutorial series that guides you on calling a protected web API using Microsoft Entra External ID.

In this tutorial, you'll:

> [!div class="checklist"]
>
> - Call a protected web API

## Prerequisites

- [Tutorial: Sign in users in Android (Kotlin) mobile app](tutorial-mobile-app-android-kotlin-sign-in.md)
- An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample Android mobile app](sample-native-authentication-android-sample-app-call-web-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

    - Register a web API application
    - Configure API scopes
    - Configure app roles
    - Configure optional claims
    - Clone or download sample web API
    - Configure and run sample web API

## Call an API

1. To call a web API from an Android application to access external data or services, begin by creating a companion object in your `MainActivity` class. The companion object should include the following code:

    ```kotlin
    companion object {
        private const val WEB_API_BASE_URL = "" // Developers should set the respective URL of their web API here
        private const val scopes = "" // Developers should append the respective scopes of their web API.
    }
    ```
    
    The companion object defines two private constants: `WEB_API_BASE_URL`, where developers set their web API's URL, and `scopes`, where developers append the respective `scopes` of their web API.

1. To handle the process of accessing a web API, use the following code:

    ```kotlin
    private fun accessWebApi() {
        CoroutineScope(Dispatchers.Main).launch {
            binding.txtLog.text = ""
            try {
                if (WEB_API_BASE_URL.isBlank()) {
                    Toast.makeText(this@MainActivity, getString(R.string.message_web_base_url), Toast.LENGTH_LONG).show()
                    return@launch
                }
                val apiResponse = withContext(Dispatchers.IO) {
                    ApiClient.performGetApiRequest(WEB_API_BASE_URL, accessToken)
                }
                binding.txtLog.text = getString(R.string.log_web_api_response)  + apiResponse.toString()
            } catch (exception: Exception) {
                Log.d(TAG, "Exception while accessing web API: $exception")
    
                binding.txtLog.text = getString(R.string.exception_web_api) + exception
            }
        }
    }
    ```
    
    The code launches a coroutine in the main dispatcher. It begins by clearing the text log. Then, it checks if the web API base URL is blank; if so, it displays a toast message and returns. Next, it performs a GET request to the web API using the provided access token in a background thread. 
    
    After receiving the API response, it updates the text log with the response content. If any exception occurs during this process, it logs the exception and updates the text log with the corresponding error message.
    
    In the code, where we specify our callback, we use a function called `performGetApiRequest()`. The function  should have the following code:
    
    ```kotlin
    object ApiClient {
        private val client = OkHttpClient()
    
        fun performGetApiRequest(WEB_API_BASE_URL: String, accessToken: String?): Response {
            val fullUrl = "$WEB_API_BASE_URL/api/todolist"
    
            val requestBuilder = Request.Builder()
                    .url(fullUrl)
                    .addHeader("Authorization", "Bearer $accessToken")
                    .get()
    
            val request = requestBuilder.build()
    
            client.newCall(request).execute().use { response -> return response }
        }
    }
    ```
    
    The code facilitates making `GET` requests to a web API. The main method is `performGetApiRequest()`, which takes the web API base URL and an access token as parameters. Inside this method, it constructs a full URL by appending `/api/todolist` to the base URL. Then, it builds an HTTP request with the appropriate headers, including the authorization header with the access token. 
    
    Finally, it executes the request synchronously using OkHttp's `newCall()` method and returns the response. The `ApiClient` object maintains an instance of `OkHttpClient` to handle HTTP requests. 
    To use `OkHttpClient`, you need to add the dependency `implementation 'com.squareup.okhttp3:okhttp:4.9.0'` to your Android Gradle file.
    
    Make sure you include the import statements. Android Studio should include the import statements for you automatically.
    
## Related content

- [Sign in users and call a protected web API in sample Android (Kotlin) app](sample-mobile-app-android-kotlin-sign-in-call-api.md)
- [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md)
- [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md)
