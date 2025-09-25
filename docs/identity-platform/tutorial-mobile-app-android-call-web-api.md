---
title: Call a protected web API in an Android app using the Microsoft identity platform
description: The tutorials provide a step-by-step guide on how to call a protected web API in Android app for authentication. 
author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.service: identity-platform
ms.topic: tutorial
ms.date: 01/27/2025
ms.custom:

#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra External ID
---

# Tutorial: Call a protected web API in Android app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This is the third tutorial in the tutorial series that guides you on calling a protected web API using Microsoft Entra External ID.

In this tutorial, you:

> [!div class="checklist"]
>
> - Call a protected web API

## Prerequisites

#### [Workforce tenant configuration](#tab/android-workforce)

- [Tutorial: Add add sign-in to an Android app by using Microsoft identity platform](tutorial-mobile-app-android-sign-in-sign-out.md)

#### [External tenant configuration](#tab/android-external)

- [Tutorial: Add add sign-in to an Android app by using Microsoft identity platform](tutorial-mobile-app-android-sign-in-sign-out.md)
- An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample Android mobile app](quickstart-native-authentication-android-call-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

    - Register a web API application
    - Configure API scopes
    - Configure app roles
    - Configure optional claims
    - Clone or download sample web API
    - Configure and run sample web API

---

## Call a protected web API


#### [Workforce tenant configuration](#tab/android-workforce)

1. In **app** > **src** > **main**> **java** > **com.example(your app name)**. Create the following Android fragments:

   - *MSGraphRequestWrapper*

1. Open *MSGraphRequestWrapper.java* and replace the code with following code snippet to call the Microsoft Graph API using the token provided by MSAL:

   ```java
    package com.azuresamples.msalandroidapp;

    import android.content.Context;
    import android.util.Log;

    import androidx.annotation.NonNull;

    import com.android.volley.DefaultRetryPolicy;
    import com.android.volley.Request;
    import com.android.volley.RequestQueue;
    import com.android.volley.Response;
    import com.android.volley.toolbox.JsonObjectRequest;
    import com.android.volley.toolbox.Volley;

    import org.json.JSONObject;

    import java.util.HashMap;
    import java.util.Map;

    public class MSGraphRequestWrapper {
        private static final String TAG = MSGraphRequestWrapper.class.getSimpleName();

        // See: https://docs.microsoft.com/en-us/graph/deployments#microsoft-graph-and-graph-explorer-service-root-endpoints
        public static final String MS_GRAPH_ROOT_ENDPOINT = "https://graph.microsoft.com/";

        /**
         * Use Volley to make an HTTP request with
         * 1) a given MSGraph resource URL
         * 2) an access token
         * to obtain MSGraph data.
         **/
        public static void callGraphAPIUsingVolley(@NonNull final Context context,
                                                   @NonNull final String graphResourceUrl,
                                                   @NonNull final String accessToken,
                                                   @NonNull final Response.Listener<JSONObject> responseListener,
                                                   @NonNull final Response.ErrorListener errorListener) {
            Log.d(TAG, "Starting volley request to graph");

            /* Make sure we have a token to send to graph */
            if (accessToken == null || accessToken.length() == 0) {
                return;
            }

            RequestQueue queue = Volley.newRequestQueue(context);
            JSONObject parameters = new JSONObject();

            try {
                parameters.put("key", "value");
            } catch (Exception e) {
                Log.d(TAG, "Failed to put parameters: " + e.toString());
            }

            JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET, graphResourceUrl,
                    parameters, responseListener, errorListener) {
                @Override
                public Map<String, String> getHeaders() {
                    Map<String, String> headers = new HashMap<>();
                    headers.put("Authorization", "Bearer " + accessToken);
                    return headers;
                }
            };

            Log.d(TAG, "Adding HTTP GET to Queue, Request: " + request.toString());

            request.setRetryPolicy(new DefaultRetryPolicy(
                    3000,
                    DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                    DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
            queue.add(request);
        }
    }
   ```

#### [External tenant configuration](#tab/android-external)

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

---


## Test your app

Build and deploy the app to a test device or emulator. You should be able to sign in and get tokens for Microsoft Entra ID.

## Related content

- [Scenario: Mobile application that calls web APIs](scenario-mobile-app-configuration.md)
- [Code sample for complex scenarios](https://github.com/Azure-Samples/ms-identity-android-java/)
