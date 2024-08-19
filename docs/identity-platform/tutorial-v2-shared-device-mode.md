---
title: "Tutorial: Implement shared-device mode with the Microsoft Authentication Library (MSAL) for Android"
description: In this tutorial, you learn how to set up an Android application to run in shared device mode.
manager: CelesteDG
author: henrymbuguakiarie
ms.author: henrymbugua
ms.date: 08/19/2024
ms.reviewer: negoe, dmwendia, akgoel
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an Android developer, I want to learn how to enable shared-device mode for an Android app, so that I can configure Android devices to be shared by multiple employees and provide Microsoft Identity backed management of the device.
---

# Tutorial: Implement shared-device mode in your Android application

In this tutorial, Android developers learn how to implement shared-device mode in an Android application using the Microsoft Authentication Library (MSAL) for Android.
 
In this tutorial:

> [!div class="checklist"]
>
> - Create or modify an existing Android application project.
> - Enable and detect shared-device mode
> - Detect single or multiple account mode
> - Detect a user switch
> - Enable global sign-in and sign-out

## Prerequisites

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

### Create or modify an existing Android application project.

To complete the rest of the tutorial, you need to create or modify an existing Android application project. If you haven't already, see the [MSAL Android tutorial](./tutorial-v2-android.md) for guidance on how to integrate MSAL with your Android app, sign in a user, call Microsoft graph, and sign out a user.  If you prefer using a completed code sample for learning and testing, clone the [sample application](https://github.com/Azure-Samples/ms-identity-android-java/) from GitHub. The sample has the capability to work in [single or multi account mode](./single-multi-account.md).

### Add the MSAL SDK to your local Maven repository

If you're not using the sample app, add the MSAL library as a dependency in your build.gradle file, like so:

```gradle
dependencies{
  implementation 'com.microsoft.identity.client.msal:4.9.+'
}
```

### Configure your app to use shared-device mode

Refer to the [configuration documentation](./msal-configuration.md) for more information on setting up your config file.

Set `"shared_device_mode_supported"` to `true` in your MSAL configuration file.

You may not be planning to support multiple-account mode. That could be if you're not using a shared device, and the user can sign into the app with more than one account at the same time. If so, set `"account_mode"` to `"SINGLE"`. This guarantees that your app will always get `ISingleAccountPublicClientApplication`, and significantly simplifies your MSAL integration. The default value of `"account_mode"` is `"MULTIPLE"`, so it's important to change this value in the config file if you're using `"single account"` mode.

Here's an example of the auth_config.json file included in the **app**>**main**>**res**>**raw** directory of the sample app:

```json
{
  "client_id": "Client ID after app registration at https://aka.ms/MobileAppReg",
  "authorization_user_agent": "DEFAULT",
  "redirect_uri": "Redirect URI after app registration at https://aka.ms/MobileAppReg",
  "account_mode": "SINGLE",
  "broker_redirect_uri_registered": true,
  "shared_device_mode_supported": true,
  "authorities": [
    {
      "type": "AAD",
      "audience": {
        "type": "AzureADandPersonalMicrosoftAccount",
        "tenant_id": "common"
      }
    }
  ]
}
```

### Detect shared-device mode

Shared-device mode allows you to configure Android devices to be shared by multiple employees, while providing Microsoft Identity backed management of the device. Employees can sign in to their devices and access customer information quickly. When they're finished with their shift or task, they'll be able to sign-out of all apps on the shared device with a single click and the device will be immediately ready for the next employee to use.

Use `isSharedDevice()` to determine if an app is running on a device that is in shared-device mode. Your app could use this flag to determine if it should modify UX accordingly.

Here's a code snippet that shows how you could use `isSharedDevice()`. It's from the `SingleAccountModeFragment` class in the sample app:

```Java
deviceModeTextView.setText(mSingleAccountApp.isSharedDevice() ? "Shared" : "Non-Shared");
```

### Initialize the PublicClientApplication object

If you set `"account_mode":"SINGLE"` in the MSAL config file, you can safely cast the returned application object as an `ISingleAccountPublicCLientApplication`.

```java
private ISingleAccountPublicClientApplication mSingleAccountApp;

/*Configure your sample app and save state for this activity*/
PublicClientApplication.create(this.getApplicationCOntext(),
  R.raw.auth_config,
  new PublicClientApplication.ApplicationCreatedListener(){
  @Override
  public void onCreated(IPublicClientApplication application){
  mSingleAccountApp = (ISingleAccountPublicClientApplication)application;
  loadAccount();
  }
  @Override
  public void onError(MsalException exception){
  /*Fail to initialize PublicClientApplication */
  }
});
```

### Detect single vs. multiple account mode

If you're writing an app that will only be used for frontline workers on a shared device, we recommend you write your app to only support single-account mode. This includes most applications that are task focused such as medical records apps, invoice apps, and most line-of-business apps. This will simplify your development as many features of the SDK won't need to be accommodated.

If your app supports multiple accounts and shared device mode, you must perform a type check and cast to the appropriate interface as shown below.

```java
private IPublicClientApplication mApplication;

        if (mApplication instanceOf IMultipleAccountPublicClientApplication) {
          IMultipleAccountPublicClientApplication multipleAccountApplication = (IMultipleAccountPublicClientApplication) mApplication;
          ...
        } else if (mApplication instanceOf    ISingleAccountPublicClientApplication) {
           ISingleAccountPublicClientApplication singleAccountApplication = (ISingleAccountPublicClientApplication) mApplication;
            ...
        }
```

### Get the signed in user and determine if a user has changed on the device

The `loadAccount` method retrieves the account of the signed in user. The `onAccountChanged` method determines if the signed-in user has changed, and if so, clean up:

```java
private void loadAccount()
{
  mSingleAccountApp.getCurrentAccountAsync(new ISingleAccountPublicClientApplication.CurrentAccountCallback())
  {
    @Override
    public void onAccountLoaded(@Nullable IAccount activeAccount)
    {
      if (activeAccount != null)
      {
        signedInUser = activeAccount;
        mSingleAccountApp.acquireTokenSilentAsync(SCOPES,"http://login.microsoftonline.com/common",getAuthSilentCallback());
      }
    }
    @Override
    public void onAccountChanged(@Nullable IAccount priorAccount, @Nullable Iaccount currentAccount)
    {
      if (currentAccount == null)
      {
        //Perform a cleanup task as the signed-in account changed.
        updateSingedOutUI();
      }
    }
    @Override
    public void onError(@NonNull Exception exception)
    {
    }
  }
}
```

### Globally sign in a user

The following signs in a user across the device to other apps that use MSAL with the Authenticator App:

```java
private void onSignInClicked()
{
  mSingleAccountApp.signIn(getActivity(), SCOPES, null, getAuthInteractiveCallback());
}
```

### Globally sign out a user

The following removes the signed-in account and clears cached tokens from not only the app but also from the device that is in shared device mode:

```java
private void onSignOutClicked()
{
  mSingleAccountApp.signOut(new ISingleAccountPublicClientApplication.SignOutCallback()
  {
    @Override
    public void onSignOut()
    {
      updateSignedOutUI();
    }
    @Override
    public void onError(@NonNull MsalException exception)
    {
      /*failed to remove account with an exception*/
    }
  });
}
```

### Receive broadcast to detect global sign out initiated from other applications

To receive the account change broadcast, you need to register a broadcast receiver.  It’s recommended to register your broadcast receiver via the [Context-registered receivers](https://developer.android.com/guide/components/broadcasts#context-registered-receivers).

When an account change broadcast is received, immediately [get the signed in user and determine if a user has changed on the device](#get-the-signed-in-user-and-determine-if-a-user-has-changed-on-the-device). If a change is detected, initiate data cleanup for previously signed-in account. It's recommended to properly stop any operations and do data cleanup.

The following code snippet shows how you could register a broadcast receiver.

```java
private static final String CURRENT_ACCOUNT_CHANGED_BROADCAST_IDENTIFIER = "com.microsoft.identity.client.sharedmode.CURRENT_ACCOUNT_CHANGED";
private BroadcastReceiver mAccountChangedBroadcastReceiver;
private void registerAccountChangeBroadcastReceiver(){
    mAccountChangedBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            //INVOKE YOUR PRIOR ACCOUNT CLEAN UP LOGIC HERE
        }
    };
    IntentFilter filter = new

    IntentFilter(CURRENT_ACCOUNT_CHANGED_BROADCAST_IDENTIFIER);
    this.registerReceiver(mAccountChangedBroadcastReceiver, filter);
}
```

## Next steps

Set up an Android device to run apps in shared device mode and test your app.

> [!div class="nextstepaction"] 
> [Shared device mode for Android devices](tutorial-mobile-android-device-shared-mode.md)