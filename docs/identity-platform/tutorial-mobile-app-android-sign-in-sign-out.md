---
title: Add sign-in in your Android app by using Microsoft identity platform
description: Learn how to add sign-in in your Android app with an external tenant or workforce tenant by using Microsoft identity platform. 
author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.service: identity-platform
ms.topic: tutorial
ms.date: 01/27/2025
ms.custom:

#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra External ID
---

# Tutorial: Add add sign-in to an Android app by using Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]


In this tutorial, you add sign-in and sign-out logic to your Android app. This code enables you to sign in users into your customer facing app by in an external tenant or employees in a workforce tenant.

This tutorial is part 2 of the 3-part tutorial series.

In this tutorial, you:

> [!div class="checklist"]
>
> - Add sign-in and sign-out logic


## Prerequisites

- [Tutorial: Set up an Android app to sign in users by using Microsoft identity platform](tutorial-mobile-app-android-prepare-app.md)

## Sign in and sign out users

#### [Workforce tenant configuration](#tab/android-workforce)

### Create and update required fragment

1. In **app** > **src** > **main**> **java** > **com.example(your app name)**. Create the following Android fragments:

   - *OnFragmentInteractionListener*
   - *SingleAccountModeFragment*

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

1. To manage the UI (add UI components), open *MainActivity.java* and replace the code with following code snippet:

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

### Layout

A layout is a file that defines the visual structure and appearance of a user interface, specifying the arrangement of UI components. It's written in XML. The following XML samples are provided if you would like to model your UI off this tutorial:

1. In **app** > **src** > **main**> **res** > **layout** > **activity_main.xml**. Replace the content of **activity_main.xml** with the following code snippet to display buttons and text boxes:

   ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <androidx.drawerlayout.widget.DrawerLayout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        xmlns:tools="http://schemas.android.com/tools"
        android:id="@+id/drawer_layout"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:fitsSystemWindows="true"
        tools:openDrawer="start">

        <include
            layout="@layout/app_bar_main"
            android:layout_width="match_parent"
            android:layout_height="match_parent" />

        <com.google.android.material.navigation.NavigationView
            android:id="@+id/nav_view"
            android:layout_width="wrap_content"
            android:layout_height="match_parent"
            android:layout_gravity="start"
            android:fitsSystemWindows="true"
            app:headerLayout="@layout/nav_header_main"
            app:menu="@menu/activity_main_drawer" />

    </androidx.drawerlayout.widget.DrawerLayout>
   ```

1. In **app** > **src** > **main**> **res** > **layout** > **app_bar_main.xml**. If you don't have **app_bar_main.xml** in your folder, create and add the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <androidx.coordinatorlayout.widget.CoordinatorLayout xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:app="http://schemas.android.com/apk/res-auto"
       xmlns:tools="http://schemas.android.com/tools"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       tools:context=".MainActivity">

       <com.google.android.material.appbar.AppBarLayout
           android:layout_width="match_parent"
           android:layout_height="wrap_content"
           android:theme="@style/AppTheme.AppBarOverlay">

           <androidx.appcompat.widget.Toolbar
               android:id="@+id/toolbar"
               android:layout_width="match_parent"
               android:layout_height="?attr/actionBarSize"
               android:background="?attr/colorPrimary"
               app:popupTheme="@style/AppTheme.PopupOverlay" />

       </com.google.android.material.appbar.AppBarLayout>

       <include layout="@layout/content_main" />

   </androidx.coordinatorlayout.widget.CoordinatorLayout>
   ```

1. In **app** > **src** > **main**> **res** > **layout** > **content_main.xml**. If you don't have **content_main.xml** in your folder, create and add the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
       android:id="@+id/content_main"
       xmlns:app="http://schemas.android.com/apk/res-auto"
       xmlns:tools="http://schemas.android.com/tools"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       app:layout_behavior="@string/appbar_scrolling_view_behavior"
       tools:context=".MainActivity"
       tools:showIn="@layout/app_bar_main">

   </androidx.constraintlayout.widget.ConstraintLayout>
   ```

1. In **app** > **src** > **main**> **res** > **layout** > **fragment_m_s_graph_request_wrapper.xml**. If you don't have **fragment_m_s_graph_request_wrapper.xml** in your folder, create and add the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:tools="http://schemas.android.com/tools"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       tools:context=".MSGraphRequestWrapper">

       <!-- TODO: Update blank fragment layout -->
       <TextView
           android:layout_width="match_parent"
           android:layout_height="match_parent"
           android:text="@string/hello_blank_fragment" />

   </FrameLayout>
   ```

1. In **app** > **src** > **main**> **res** > **layout** > **fragment_on_interaction_listener.xml**. If you don't have **fragment_on_interaction_listener.xml** in your folder, create and add the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:tools="http://schemas.android.com/tools"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       tools:context=".OnFragmentInteractionListener">

       <!-- TODO: Update blank fragment layout -->
       <TextView
           android:layout_width="match_parent"
           android:layout_height="match_parent"
           android:text="@string/hello_blank_fragment" />

   </FrameLayout>
   ```

1. In **app** > **src** > **main**> **res** > **layout** > **fragment_single_account_mode.xml**. If you don't have **fragment_single_account_mode.xml** in your folder, create and add the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:tools="http://schemas.android.com/tools"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       tools:context=".SingleAccountModeFragment">

       <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
           android:layout_width="match_parent"
           android:layout_height="match_parent"
           android:orientation="vertical"
           tools:context=".SingleAccountModeFragment">

           <LinearLayout
               android:id="@+id/activity_main"
               android:layout_width="match_parent"
               android:layout_height="match_parent"
               android:orientation="vertical"
               android:paddingLeft="@dimen/activity_horizontal_margin"
               android:paddingRight="@dimen/activity_horizontal_margin"
               android:paddingBottom="@dimen/activity_vertical_margin">

               <LinearLayout
                   android:layout_width="match_parent"
                   android:layout_height="wrap_content"
                   android:orientation="horizontal"
                   android:paddingTop="5dp"
                   android:paddingBottom="5dp"
                   android:weightSum="10">

                   <TextView
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="3"
                       android:layout_gravity="center_vertical"
                       android:textStyle="bold"
                       android:text="Scope" />

                   <LinearLayout
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:orientation="vertical"
                       android:layout_weight="7">

                       <EditText
                           android:id="@+id/scope"
                           android:layout_height="wrap_content"
                           android:layout_width="match_parent"
                           android:text="user.read"
                           android:textSize="12sp" />

                       <TextView
                           android:layout_height="wrap_content"
                           android:layout_width="match_parent"
                           android:paddingLeft="5dp"
                           android:text="Type in scopes delimited by space"
                           android:textSize="10sp"  />

                   </LinearLayout>
               </LinearLayout>

               <LinearLayout
                   android:layout_width="match_parent"
                   android:layout_height="wrap_content"
                   android:orientation="horizontal"
                   android:paddingTop="5dp"
                   android:paddingBottom="5dp"
                   android:weightSum="10">

                   <TextView
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="3"
                       android:layout_gravity="center_vertical"
                       android:textStyle="bold"
                       android:text="MSGraph Resource URL" />

                   <LinearLayout
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:orientation="vertical"
                       android:layout_weight="7">

                       <EditText
                           android:id="@+id/msgraph_url"
                           android:layout_height="wrap_content"
                           android:layout_width="match_parent"
                           android:textSize="12sp" />
                   </LinearLayout>
               </LinearLayout>

               <LinearLayout
                   android:layout_width="match_parent"
                   android:layout_height="wrap_content"
                   android:orientation="horizontal"
                   android:paddingTop="5dp"
                   android:paddingBottom="5dp"
                   android:weightSum="10">

                   <TextView
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="3"
                       android:textStyle="bold"
                       android:text="Signed-in user" />

                   <TextView
                       android:id="@+id/current_user"
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:paddingLeft="5dp"
                       android:layout_weight="7"
                       android:text="None" />
               </LinearLayout>

               <LinearLayout
                   android:layout_width="match_parent"
                   android:layout_height="wrap_content"
                   android:orientation="horizontal"
                   android:paddingTop="5dp"
                   android:paddingBottom="5dp"
                   android:weightSum="10">

                   <TextView
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="3"
                       android:textStyle="bold"
                       android:text="Device mode" />

                   <TextView
                       android:id="@+id/device_mode"
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:paddingLeft="5dp"
                       android:layout_weight="7"
                       android:text="None" />
               </LinearLayout>

               <LinearLayout
                   android:layout_width="match_parent"
                   android:layout_height="wrap_content"
                   android:orientation="horizontal"
                   android:paddingTop="5dp"
                   android:paddingBottom="5dp"
                   android:weightSum="10">

                   <Button
                       android:id="@+id/btn_signIn"
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="5"
                       android:gravity="center"
                       android:text="Sign In"/>

                   <Button
                       android:id="@+id/btn_removeAccount"
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="5"
                       android:gravity="center"
                       android:text="Sign Out"
                       android:enabled="false"/>
               </LinearLayout>


               <LinearLayout
                   android:layout_width="match_parent"
                   android:layout_height="wrap_content"
                   android:gravity="center"
                   android:orientation="horizontal">

                   <Button
                       android:id="@+id/btn_callGraphInteractively"
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="5"
                       android:text="Get Graph Data Interactively"
                       android:enabled="false"/>

                   <Button
                       android:id="@+id/btn_callGraphSilently"
                       android:layout_width="0dp"
                       android:layout_height="wrap_content"
                       android:layout_weight="5"
                       android:text="Get Graph Data Silently"
                       android:enabled="false"/>
               </LinearLayout>


               <TextView
                   android:id="@+id/txt_log"
                   android:layout_width="match_parent"
                   android:layout_height="0dp"
                   android:layout_marginTop="20dp"
                   android:layout_weight="0.8"
                   android:text="Output goes here..." />

           </LinearLayout>
       </LinearLayout>

   </FrameLayout>
   ```

1. In **app** > **src** > **main**> **res** > **layout** > **nav_header_main.xml**. If you don't have **nav_header_main.xml** in your folder, create and add the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:app="http://schemas.android.com/apk/res-auto"
       android:layout_width="match_parent"
       android:layout_height="@dimen/nav_header_height"
       android:background="@drawable/side_nav_bar"
       android:gravity="bottom"
       android:orientation="vertical"
       android:paddingLeft="@dimen/activity_horizontal_margin"
       android:paddingTop="@dimen/activity_vertical_margin"
       android:paddingRight="@dimen/activity_horizontal_margin"
       android:paddingBottom="@dimen/activity_vertical_margin"
       android:theme="@style/ThemeOverlay.AppCompat.Dark">

       <ImageView
           android:id="@+id/imageView"
           android:layout_width="66dp"
           android:layout_height="72dp"
           android:contentDescription="@string/nav_header_desc"
           android:paddingTop="@dimen/nav_header_vertical_spacing"
           app:srcCompat="@drawable/microsoft_logo" />

       <TextView
           android:layout_width="match_parent"
           android:layout_height="wrap_content"
           android:paddingTop="@dimen/nav_header_vertical_spacing"
           android:text="Azure Samples"
           android:textAppearance="@style/TextAppearance.AppCompat.Body1" />

       <TextView
           android:id="@+id/textView"
           android:layout_width="wrap_content"
           android:layout_height="wrap_content"
           android:text="MSAL Android" />

   </LinearLayout>

   ```

1. In **app** > **src** > **main**> **res** > **menu** > **activity_main_drawer.xml**. If you don't have **activity_main_drawer.xml** in your folder, create and add the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <menu xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:tools="http://schemas.android.com/tools"
       tools:showIn="navigation_view">
       <group android:checkableBehavior="single">
           <item
               android:id="@+id/nav_single_account"
               android:icon="@drawable/ic_single_account_24dp"
               android:title="Single Account Mode" />

       </group>
   </menu>
   ```

1. In **app** > **src** > **main**> **res** > **values** > **dimens.xml**. Replace the content of **dimens.xml** with the following code snippet:

   ```xml
   <resources>
       <dimen name="fab_margin">16dp</dimen>
       <dimen name="activity_horizontal_margin">16dp</dimen>
       <dimen name="activity_vertical_margin">16dp</dimen>
       <dimen name="nav_header_height">176dp</dimen>
       <dimen name="nav_header_vertical_spacing">8dp</dimen>
   </resources>
   ```

1. In **app** > **src** > **main**> **res** > **values** > **colors.xml**. Replace the content of **colors.xml** with the following code snippet:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <resources>
       <color name="purple_200">#FFBB86FC</color>
       <color name="purple_500">#FF6200EE</color>
       <color name="purple_700">#FF3700B3</color>
       <color name="teal_200">#FF03DAC5</color>
       <color name="teal_700">#FF018786</color>
       <color name="black">#FF000000</color>
       <color name="white">#FFFFFFFF</color>
       <color name="colorPrimary">#008577</color>
       <color name="colorPrimaryDark">#00574B</color>
       <color name="colorAccent">#D81B60</color>
   </resources>
   ```

1. In **app** > **src** > **main**> **res** > **values** > **strings.xml**. Replace the content of **strings.xml** with the following code snippet:

   ```xml
   <resources>
       <string name="app_name">MSALAndroidapp</string>
       <string name="action_settings">Settings</string>
       <!-- Strings used for fragments for navigation -->
       <string name="first_fragment_label">First Fragment</string>
       <string name="second_fragment_label">Second Fragment</string>
       <string name="nav_header_desc">Navigation header</string>
       <string name="navigation_drawer_open">Open navigation drawer</string>
       <string name="navigation_drawer_close">Close navigation drawer</string>
       <string name="next">Next</string>
       <string name="previous">Previous</string>

       <string name="hello_first_fragment">Hello first fragment</string>
       <string name="hello_second_fragment">Hello second fragment. Arg: %1$s</string>
       <!-- TODO: Remove or change this placeholder text -->
       <string name="hello_blank_fragment">Hello blank fragment</string>
   </resources>
   ```

1. In **app** > **src** > **main**> **res** > **values** > **styles.xml**. If you don't have **styles.xml** in your folder, create and add the following code snippet:

   ```xml
   <resources>

   <!-- Base application theme. -->
   <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
       <!-- Customize your theme here. -->
       <item name="colorPrimary">@color/colorPrimary</item>
       <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
       <item name="colorAccent">@color/colorAccent</item>
   </style>

   <style name="AppTheme.NoActionBar">
       <item name="windowActionBar">false</item>
       <item name="windowNoTitle">true</item>
   </style>

   <style name="AppTheme.AppBarOverlay" parent="ThemeOverlay.AppCompat.Dark.ActionBar" />

   <style name="AppTheme.PopupOverlay" parent="ThemeOverlay.AppCompat.Light" />

   </resources>
   ```

1. In **app** > **src** > **main**> **res** > **values** > **themes.xml**. Replace the content of **themes.xml** with the following code snippet:

   ```xml
   <resources xmlns:tools="http://schemas.android.com/tools">
       <!-- Base application theme. -->
       <style name="Theme.MSALAndroidapp" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
           <!-- Primary brand color. -->
           <item name="colorPrimary">@color/purple_500</item>
           <item name="colorPrimaryVariant">@color/purple_700</item>
           <item name="colorOnPrimary">@color/white</item>
           <!-- Secondary brand color. -->
           <item name="colorSecondary">@color/teal_200</item>
           <item name="colorSecondaryVariant">@color/teal_700</item>
           <item name="colorOnSecondary">@color/black</item>
           <!-- Status bar color. -->
           <item name="android:statusBarColor" tools:targetApi="21">?attr/colorPrimaryVariant</item>
           <!-- Customize your theme here. -->
       </style>

       <style name="Theme.MSALAndroidapp.NoActionBar">
           <item name="windowActionBar">false</item>
           <item name="windowNoTitle">true</item>
       </style>

       <style name="Theme.MSALAndroidapp.AppBarOverlay" parent="ThemeOverlay.AppCompat.Dark.ActionBar" />

       <style name="Theme.MSALAndroidapp.PopupOverlay" parent="ThemeOverlay.AppCompat.Light" />
   </resources>
   ```

1. In **app** > **src** > **main**> **res** > **drawable** > **ic_single_account_24dp.xml**. If you don't have **ic_single_account_24dp.xml** in your folder, create and add the following code snippet:

   ```xml
   <vector xmlns:android="http://schemas.android.com/apk/res/android"
   android:width="24dp"
   android:height="24dp"
   android:viewportWidth="24.0"
   android:viewportHeight="24.0">
   <path
       android:fillColor="#FF000000"
       android:pathData="M12,12c2.21,0 4,-1.79 4,-4s-1.79,-4 -4,-4 -4,1.79 -4,4 1.79,4 4,4zM12,14c-2.67,0 -8,1.34 -8,4v2h16v-2c0,-2.66 -5.33,-4 -8,-4z"/>
   </vector>
   ```

1. In **app** > **src** > **main**> **res** > **drawable** > **side_nav_bar.xml**. If you don't have **side_nav_bar.xml** in your folder, create and add the following code snippet:

   ```xml
   <shape xmlns:android="http://schemas.android.com/apk/res/android"
   android:shape="rectangle">
   <gradient
       android:angle="135"
       android:centerColor="#009688"
       android:endColor="#00695C"
       android:startColor="#4DB6AC"
       android:type="linear" />
   </shape>
   ```

1. In **app** > **src** > **main**> **res** > **drawable**. To the folder, add a png Microsoft logo named `microsoft_logo.png`.

Declaring your UI in XML allows you to separate the presentation of your app from the code that controls its behavior. To learn more about Android layout, see [Layouts](https://developer.android.com/develop/ui/views/layout/declaring-layout)


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


## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Call a protected web API in Android app](tutorial-mobile-app-android-call-web-api.md)

