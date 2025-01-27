---
title: Add sign-in in your Android app by using Microsoft identity platform
description: Learn how to add sign-in in your Android app with an external tenant or workforce tenant by using Microsoft identity platform. 

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

# Tutorial: Add add sign-in to an Android app by using Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]


In this tutorial, you add sign-in and sign-out logic to your Android app. This code enables you to sign in users into your customer facing app by in an external tenant or employees in a workforce tenant.

This tutorial is part 2 of the 3-part tutorial series.

In this tutorial, you'll:

> [!div class="checklist"]
>
> - Add sign-in and sign-out logic


## Prerequisites

- [Tutorial: Set up an Android app to sign in users by using Microsoft identity platform](tutorial-mobile-app-android-prepare-app.md)

## Sign and sign out users

#### [Workforce tenant configuration](#tab/android-workforce)

### Create and update required fragment

1. In **app** > **src** > **main**> **java** > **com.example(your app name)**. Create the following Android fragments:

   - *MSGraphRequestWrapper*
   - *OnFragmentInteractionListener*
   - *SingleAccountModeFragment*

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

1. Open *OnFragmentInteractionListener.java* and replace the code with following code snippet to allow communication between different fragments:

   ```java
    package com.azuresamples.msalandroidapp;

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
    }
   ```

1. Open *SingleAccountModeFragment.java* and replace the code with following code snippet to initialize a single-account application, loads a user account, and gets a token to call the Microsoft Graph API:

   ```java
    package com.azuresamples.msalandroidapp;

    import android.os.Bundle;

    import androidx.annotation.NonNull;
    import androidx.annotation.Nullable;
    import androidx.fragment.app.Fragment;

    import android.util.Log;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.ViewGroup;
    import android.widget.Button;
    import android.widget.TextView;
    import android.widget.Toast;

    import com.android.volley.Response;
    import com.android.volley.VolleyError;
    import com.microsoft.identity.client.AuthenticationCallback;
    import com.microsoft.identity.client.IAccount;
    import com.microsoft.identity.client.IAuthenticationResult;
    import com.microsoft.identity.client.IPublicClientApplication;
    import com.microsoft.identity.client.ISingleAccountPublicClientApplication;
    import com.microsoft.identity.client.PublicClientApplication;
    import com.microsoft.identity.client.SilentAuthenticationCallback;
    import com.microsoft.identity.client.exception.MsalClientException;
    import com.microsoft.identity.client.exception.MsalException;
    import com.microsoft.identity.client.exception.MsalServiceException;
    import com.microsoft.identity.client.exception.MsalUiRequiredException;

    import org.json.JSONObject;

    /**
     * Implementation sample for 'Single account' mode.
     * <p>
     * If your app only supports one account being signed-in at a time, this is for you.
     * This requires "account_mode" to be set as "SINGLE" in the configuration file.
     * (Please see res/raw/auth_config_single_account.json for more info).
     * <p>
     * Please note that switching mode (between 'single' and 'multiple' might cause a loss of data.
     */
    public class SingleAccountModeFragment extends Fragment {
        private static final String TAG = SingleAccountModeFragment.class.getSimpleName();

        /* UI & Debugging Variables */
        Button signInButton;
        Button signOutButton;
        Button callGraphApiInteractiveButton;
        Button callGraphApiSilentButton;
        TextView scopeTextView;
        TextView graphResourceTextView;
        TextView logTextView;
        TextView currentUserTextView;
        TextView deviceModeTextView;

        /* Azure AD Variables */
        private ISingleAccountPublicClientApplication mSingleAccountApp;
        private IAccount mAccount;

        @Override
        public View onCreateView(LayoutInflater inflater,
                                 ViewGroup container,
                                 Bundle savedInstanceState) {
            // Inflate the layout for this fragment
            final View view = inflater.inflate(R.layout.fragment_single_account_mode, container, false);
            initializeUI(view);

            // Creates a PublicClientApplication object with res/raw/auth_config_single_account.json
            PublicClientApplication.createSingleAccountPublicClientApplication(getContext(),
                    R.raw.auth_config_single_account,
                    new IPublicClientApplication.ISingleAccountApplicationCreatedListener() {
                        @Override
                        public void onCreated(ISingleAccountPublicClientApplication application) {
                            /**
                             * This test app assumes that the app is only going to support one account.
                             * This requires "account_mode" : "SINGLE" in the config json file.
                             **/
                            mSingleAccountApp = application;
                            loadAccount();
                        }

                        @Override
                        public void onError(MsalException exception) {
                            displayError(exception);
                        }
                    });

            return view;
        }

        /**
         * Initializes UI variables and callbacks.
         */
        private void initializeUI(@NonNull final View view) {
            signInButton = view.findViewById(R.id.btn_signIn);
            signOutButton = view.findViewById(R.id.btn_removeAccount);
            callGraphApiInteractiveButton = view.findViewById(R.id.btn_callGraphInteractively);
            callGraphApiSilentButton = view.findViewById(R.id.btn_callGraphSilently);
            scopeTextView = view.findViewById(R.id.scope);
            graphResourceTextView = view.findViewById(R.id.msgraph_url);
            logTextView = view.findViewById(R.id.txt_log);
            currentUserTextView = view.findViewById(R.id.current_user);
            deviceModeTextView = view.findViewById(R.id.device_mode);

            final String defaultGraphResourceUrl = MSGraphRequestWrapper.MS_GRAPH_ROOT_ENDPOINT + "v1.0/me";
            graphResourceTextView.setText(defaultGraphResourceUrl);

            signInButton.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (mSingleAccountApp == null) {
                        return;
                    }

                    mSingleAccountApp.signIn(getActivity(), null, getScopes(), getAuthInteractiveCallback());
                }
            });

            signOutButton.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (mSingleAccountApp == null) {
                        return;
                    }

                    /**
                     * Removes the signed-in account and cached tokens from this app (or device, if the device is in shared mode).
                     */
                    mSingleAccountApp.signOut(new ISingleAccountPublicClientApplication.SignOutCallback() {
                        @Override
                        public void onSignOut() {
                            mAccount = null;
                            updateUI();
                            showToastOnSignOut();
                        }

                        @Override
                        public void onError(@NonNull MsalException exception) {
                            displayError(exception);
                        }
                    });
                }
            });

            callGraphApiInteractiveButton.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (mSingleAccountApp == null) {
                        return;
                    }

                    /**
                     * If acquireTokenSilent() returns an error that requires an interaction (MsalUiRequiredException),
                     * invoke acquireToken() to have the user resolve the interrupt interactively.
                     *
                     * Some example scenarios are
                     *  - password change
                     *  - the resource you're acquiring a token for has a stricter set of requirement than your Single Sign-On refresh token.
                     *  - you're introducing a new scope which the user has never consented for.
                     */
                    mSingleAccountApp.acquireToken(getActivity(), getScopes(), getAuthInteractiveCallback());
                }
            });

            callGraphApiSilentButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (mSingleAccountApp == null) {
                        return;
                    }

                    /**
                     * Once you've signed the user in,
                     * you can perform acquireTokenSilent to obtain resources without interrupting the user.
                     */
                    mSingleAccountApp.acquireTokenSilentAsync(getScopes(), mAccount.getAuthority(), getAuthSilentCallback());
                }
            });

        }

        @Override
        public void onResume() {
            super.onResume();

            /**
             * The account may have been removed from the device (if broker is in use).
             *
             * In shared device mode, the account might be signed in/out by other apps while this app is not in focus.
             * Therefore, we want to update the account state by invoking loadAccount() here.
             */
            loadAccount();
        }

        /**
         * Extracts a scope array from a text field,
         * i.e. from "User.Read User.ReadWrite" to ["user.read", "user.readwrite"]
         */
        private String[] getScopes() {
            return scopeTextView.getText().toString().toLowerCase().split(" ");
        }

        /**
         * Load the currently signed-in account, if there's any.
         */
        private void loadAccount() {
            if (mSingleAccountApp == null) {
                return;
            }

            mSingleAccountApp.getCurrentAccountAsync(new ISingleAccountPublicClientApplication.CurrentAccountCallback() {
                @Override
                public void onAccountLoaded(@Nullable IAccount activeAccount) {
                    // You can use the account data to update your UI or your app database.
                    mAccount = activeAccount;
                    updateUI();
                }

                @Override
                public void onAccountChanged(@Nullable IAccount priorAccount, @Nullable IAccount currentAccount) {
                    if (currentAccount == null) {
                        // Perform a cleanup task as the signed-in account changed.
                        showToastOnSignOut();
                    }
                }

                @Override
                public void onError(@NonNull MsalException exception) {
                    displayError(exception);
                }
            });
        }

        /**
         * Callback used in for silent acquireToken calls.
         */
        private SilentAuthenticationCallback getAuthSilentCallback() {
            return new SilentAuthenticationCallback() {

                @Override
                public void onSuccess(IAuthenticationResult authenticationResult) {
                    Log.d(TAG, "Successfully authenticated");

                    /* Successfully got a token, use it to call a protected resource - MSGraph */
                    callGraphAPI(authenticationResult);
                }

                @Override
                public void onError(MsalException exception) {
                    /* Failed to acquireToken */
                    Log.d(TAG, "Authentication failed: " + exception.toString());
                    displayError(exception);

                    if (exception instanceof MsalClientException) {
                        /* Exception inside MSAL, more info inside MsalError.java */
                    } else if (exception instanceof MsalServiceException) {
                        /* Exception when communicating with the STS, likely config issue */
                    } else if (exception instanceof MsalUiRequiredException) {
                        /* Tokens expired or no session, retry with interactive */
                    }
                }
            };
        }

        /**
         * Callback used for interactive request.
         * If succeeds we use the access token to call the Microsoft Graph.
         * Does not check cache.
         */
        private AuthenticationCallback getAuthInteractiveCallback() {
            return new AuthenticationCallback() {

                @Override
                public void onSuccess(IAuthenticationResult authenticationResult) {
                    /* Successfully got a token, use it to call a protected resource - MSGraph */
                    Log.d(TAG, "Successfully authenticated");
                    Log.d(TAG, "ID Token: " + authenticationResult.getAccount().getClaims().get("id_token"));

                    /* Update account */
                    mAccount = authenticationResult.getAccount();
                    updateUI();

                    /* call graph */
                    callGraphAPI(authenticationResult);
                }

                @Override
                public void onError(MsalException exception) {
                    /* Failed to acquireToken */
                    Log.d(TAG, "Authentication failed: " + exception.toString());
                    displayError(exception);

                    if (exception instanceof MsalClientException) {
                        /* Exception inside MSAL, more info inside MsalError.java */
                    } else if (exception instanceof MsalServiceException) {
                        /* Exception when communicating with the STS, likely config issue */
                    }
                }

                @Override
                public void onCancel() {
                    /* User canceled the authentication */
                    Log.d(TAG, "User cancelled login.");
                }
            };
        }

        /**
         * Make an HTTP request to obtain MSGraph data
         */
        private void callGraphAPI(final IAuthenticationResult authenticationResult) {
            MSGraphRequestWrapper.callGraphAPIUsingVolley(
                    getContext(),
                    graphResourceTextView.getText().toString(),
                    authenticationResult.getAccessToken(),
                    new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            /* Successfully called graph, process data and send to UI */
                            Log.d(TAG, "Response: " + response.toString());
                            displayGraphResult(response);
                        }
                    },
                    new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            Log.d(TAG, "Error: " + error.toString());
                            displayError(error);
                        }
                    });
        }

        //
        // Helper methods manage UI updates
        // ================================
        // displayGraphResult() - Display the graph response
        // displayError() - Display the graph response
        // updateSignedInUI() - Updates UI when the user is signed in
        // updateSignedOutUI() - Updates UI when app sign out succeeds
        //

        /**
         * Display the graph response
         */
        private void displayGraphResult(@NonNull final JSONObject graphResponse) {
            logTextView.setText(graphResponse.toString());
        }

        /**
         * Display the error message
         */
        private void displayError(@NonNull final Exception exception) {
            logTextView.setText(exception.toString());
        }

        /**
         * Updates UI based on the current account.
         */
        private void updateUI() {
            if (mAccount != null) {
                signInButton.setEnabled(false);
                signOutButton.setEnabled(true);
                callGraphApiInteractiveButton.setEnabled(true);
                callGraphApiSilentButton.setEnabled(true);
                currentUserTextView.setText(mAccount.getUsername());
            } else {
                signInButton.setEnabled(true);
                signOutButton.setEnabled(false);
                callGraphApiInteractiveButton.setEnabled(false);
                callGraphApiSilentButton.setEnabled(false);
                currentUserTextView.setText("None");
            }

            deviceModeTextView.setText(mSingleAccountApp.isSharedDevice() ? "Shared" : "Non-shared");
        }

        /**
         * Updates UI when app sign out succeeds
         */
        private void showToastOnSignOut() {
            final String signOutText = "Signed Out.";
            currentUserTextView.setText("");
            Toast.makeText(getContext(), signOutText, Toast.LENGTH_SHORT)
                    .show();
        }
    }
   ```

1. Open *MainActivity.java* and replace the code with following code snippet to manage the UI.

   ```java
    package com.azuresamples.msalandroidapp;

    import android.os.Bundle;

    import androidx.annotation.NonNull;
    import androidx.appcompat.app.ActionBarDrawerToggle;
    import androidx.appcompat.app.AppCompatActivity;
    import androidx.appcompat.widget.Toolbar;
    import androidx.constraintlayout.widget.ConstraintLayout;
    import androidx.core.view.GravityCompat;

    import android.view.MenuItem;
    import android.view.View;

    import androidx.drawerlayout.widget.DrawerLayout;
    import androidx.fragment.app.Fragment;
    import androidx.fragment.app.FragmentTransaction;


    import com.google.android.material.navigation.NavigationView;

    public class MainActivity extends AppCompatActivity
            implements NavigationView.OnNavigationItemSelectedListener,
            OnFragmentInteractionListener{

        enum AppFragment {
            SingleAccount
        }

        private AppFragment mCurrentFragment;

        private ConstraintLayout mContentMain;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            mContentMain = findViewById(R.id.content_main);

            Toolbar toolbar = findViewById(R.id.toolbar);
            setSupportActionBar(toolbar);
            DrawerLayout drawer = findViewById(R.id.drawer_layout);
            NavigationView navigationView = findViewById(R.id.nav_view);
            ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                    this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
            drawer.addDrawerListener(toggle);
            toggle.syncState();
            navigationView.setNavigationItemSelectedListener(this);

            //Set default fragment
            navigationView.setCheckedItem(R.id.nav_single_account);
            setCurrentFragment(AppFragment.SingleAccount);
        }

        @Override
        public boolean onNavigationItemSelected(final MenuItem item) {
            final DrawerLayout drawer = findViewById(R.id.drawer_layout);
            drawer.addDrawerListener(new DrawerLayout.DrawerListener() {
                @Override
                public void onDrawerSlide(@NonNull View drawerView, float slideOffset) { }

                @Override
                public void onDrawerOpened(@NonNull View drawerView) { }

                @Override
                public void onDrawerClosed(@NonNull View drawerView) {
                    // Handle navigation view item clicks here.
                    int id = item.getItemId();

                    if (id == R.id.nav_single_account) {
                        setCurrentFragment(AppFragment.SingleAccount);
                    }


                    drawer.removeDrawerListener(this);
                }

                @Override
                public void onDrawerStateChanged(int newState) { }
            });

            drawer.closeDrawer(GravityCompat.START);
            return true;
        }

        private void setCurrentFragment(final AppFragment newFragment){
            if (newFragment == mCurrentFragment) {
                return;
            }

            mCurrentFragment = newFragment;
            setHeaderString(mCurrentFragment);
            displayFragment(mCurrentFragment);
        }

        private void setHeaderString(final AppFragment fragment){
            switch (fragment) {
                case SingleAccount:
                    getSupportActionBar().setTitle("Single Account Mode");
                    return;

            }
        }

        private void displayFragment(final AppFragment fragment){
            switch (fragment) {
                case SingleAccount:
                    attachFragment(new com.azuresamples.msalandroidapp.SingleAccountModeFragment());
                    return;

            }
        }

        private void attachFragment(final Fragment fragment) {
            getSupportFragmentManager()
                    .beginTransaction()
                    .setTransitionStyle(FragmentTransaction.TRANSIT_FRAGMENT_FADE)
                    .replace(mContentMain.getId(),fragment)
                    .commit();
        }
    }
   ```

> [!NOTE]
> Ensure that you update the package name to match your Android project package name.

#### [External tenant configuration](#tab/android-external)

## Sign in user

You have two main options for signing in users using Microsoft Authentication Library (MSAL) for Android: acquiring tokens interactively or silently.

1. To sign in user interactively, use the following code:

    ```kotlin
        private fun acquireTokenInteractively() {
        binding.txtLog.text = ""

        if (account != null) {
            Toast.makeText(this, "An account is already signed in.", Toast.LENGTH_SHORT).show()
            return
        }

        /* Extracts a scope array from text, i.e. from "User.Read User.ReadWrite" to ["user.read", "user.readwrite"] */
        val scopes = scopes.lowercase().split(" ")
        val parameters = AcquireTokenParameters.Builder()
            .startAuthorizationFromActivity(this@MainActivity)
            .withScopes(scopes)
            .withCallback(getAuthInteractiveCallback())
            .build()

        authClient.acquireToken(parameters)
    }
    ```
    
    The code initiates the process of acquiring a token interactively using MSAL for Android. It first clears the text log field. Then, it checks if there's already a signed-in account, if so, it displays a toast message indicating that an account is already signed in and returns. 

    Next, it extracts scopes from text input and converts them to lowercase before splitting them into an array. Using these scopes, it builds parameters for acquiring a token, including starting the authorization process from the current activity and specifying a callback. Finally, it calls `acquireToken()` on the authentication client with the constructed parameters to initiate the token acquisition process.

    
    In the code, where we specify our callback, we use a function called `getAuthInteractiveCallback()`. The function should have the following code:

    ```kotlin
    private fun getAuthInteractiveCallback(): AuthenticationCallback {
        return object : AuthenticationCallback {

            override fun onSuccess(authenticationResult: IAuthenticationResult) {
                /* Successfully got a token, use it to call a protected resource - Web API */
                Log.d(TAG, "Successfully authenticated")
                Log.d(TAG, "ID Token: " + authenticationResult.account.claims?.get("id_token"))
                Log.d(TAG, "Claims: " + authenticationResult.account.claims

                /* Reload account asynchronously to get the up-to-date list. */
                CoroutineScope(Dispatchers.Main).launch {
                    accessToken = authenticationResult.accessToken
                    getAccount()

                    binding.txtLog.text = getString(R.string.log_token_interactive) +  accessToken
                }
            }

            override fun onError(exception: MsalException) {
                /* Failed to acquireToken */
                Log.d(TAG, "Authentication failed: $exception")

                accessToken = null
                binding.txtLog.text = getString(R.string.exception_authentication) + exception

                if (exception is MsalClientException) {
                    /* Exception inside MSAL, more info inside MsalError.java */
                } else if (exception is MsalServiceException) {
                    /* Exception when communicating with the STS, likely config issue */
                }
            }

            override fun onCancel() {
                /* User canceled the authentication */
                Log.d(TAG, "User cancelled login.");
            }
        }
    }
    ```
    
    The code snippet defines a function, `getAuthInteractiveCallback`, which returns an instance of `AuthenticationCallback`. Within this function, an anonymous class implementing the `AuthenticationCallback` interface is created.

    When authentication succeeds (`onSuccess`), it logs the successful authentication, retrieves the ID token and claims, updates the access token asynchronously using `CoroutineScope`, and updates the UI with the new access token. The code retrieves the ID token from the `authenticationResult` and logs it. Claims in the token contain information about the user, such as their name, email, or other profile information. You can retrieve the claims associated with the current account by accessing `authenticationResult.account.claims`.

    If there's an authentication error (`onError`), it logs the error, clears the access token, updates the UI with the error message, and provides more specific handling for `MsalClientException` and `MsalServiceException`. If the user cancels the authentication (`onCancel`), it logs the cancellation.

    Make sure you include the import statements. Android Studio should include the import statements for you automatically.

1. To sign in user silently, use the following code:

    ```kotlin
        private fun acquireTokenSilently() {
        binding.txtLog.text = ""

        if (account == null) {
            Toast.makeText(this, "No account available", Toast.LENGTH_SHORT).show()
            return
        }

        /* Extracts a scope array from text, i.e. from "User.Read User.ReadWrite" to ["user.read", "user.readwrite"] */
        val scopes = scopes.lowercase().split(" ")
        val parameters = AcquireTokenSilentParameters.Builder()
            .forAccount(account)
            .fromAuthority(account!!.authority)
            .withScopes(scopes)
            .forceRefresh(false)
            .withCallback(getAuthSilentCallback())
            .build()

        authClient.acquireTokenSilentAsync(parameters)
    }
    ```

    The code initiates the process of acquiring a token silently. It first clears the text log. Then, it checks if there's an available account; if not, it displays a toast message indicating this and exits. Next, it extracts scopes from text input, converts them to lowercase, and splits them into an array. 

    Using these scopes, it constructs parameters for acquiring a token silently, specifying the account, authority, scopes, and callback. Finally, it asynchronously triggers `acquireTokenSilentAsync()` on the authentication client with the constructed parameters, starting the silent token acquisition process.

    In the code, where we specify our callback, we use a function called `getAuthSilentCallback()`. The function should have the following code:

    ```kotlin
    private fun getAuthSilentCallback(): SilentAuthenticationCallback {
        return object : SilentAuthenticationCallback {
            override fun onSuccess(authenticationResult: IAuthenticationResult?) {
                Log.d(TAG, "Successfully authenticated")

                /* Display Access Token */
                accessToken = authenticationResult?.accessToken
                binding.txtLog.text = getString(R.string.log_token_silent) + accessToken
            }

            override fun onError(exception: MsalException?) {
                /* Failed to acquireToken */
                Log.d(TAG, "Authentication failed: $exception")

                accessToken = null
                binding.txtLog.text = getString(R.string.exception_authentication) + exception

                when (exception) {
                    is MsalClientException -> {
                        /* Exception inside MSAL, more info inside MsalError.java */
                    }
                    is MsalServiceException -> {
                        /* Exception when communicating with the STS, likely config issue */
                    }
                    is MsalUiRequiredException -> {
                        /* Tokens expired or no session, retry with interactive */
                    }
                }
            }

        }
    }
    ```
    
    The code defines a callback for silent authentication. It implements the `SilentAuthenticationCallback` interface, overriding two methods. In the `onSuccess` method, it logs successful authentication and displays the access token. 

    In the `onError` method, it logs authentication failure, handles different types of exceptions, such as `MsalClientException` and `MsalServiceException`, and suggests retrying with interactive authentication if needed.

    Make sure you include the import statements. Android Studio should include the import statements for you automatically.

## Sign out

To sign out a user from your Android (Kotlin) app using MSAL for Android, use the following code:

```kotlin
private fun removeAccount() {
    binding.userName.text = ""
    binding.txtLog.text = ""

    authClient.signOut(signOutCallback())
}
```

The code removes an account from the application. It clears the displayed user name and text log. Then, it triggers the sign out process using the authentication client, specifying a sign out callback to handle the completion of the sign out operation.

In the code, where we specify our callback, we use a function called `signOutCallback()`. The function should have the following code:

```kotlin
private fun signOutCallback(): ISingleAccountPublicClientApplication.SignOutCallback {
    return object : ISingleAccountPublicClientApplication.SignOutCallback {
        override fun onSignOut() {
            account = null
            updateUI(account)
        }

        override fun onError(exception: MsalException) {
            binding.txtLog.text = getString(R.string.exception_remove_account) + exception
        }
    }
}
```

The code defines a sign out callback for a single account in the public client application. It implements the `ISingleAccountPublicClientApplication.SignOutCallback` interface, overriding two methods. 

In the `onSignOut` method, it nullifies the current account and updates the user interface accordingly. In the `onError` method, it logs any errors that occur during the sign out process and updates the text log with the corresponding exception message.

Make sure you include the import statements. Android Studio should include the import statements for you automatically.


---