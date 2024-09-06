---
title: "Tutorial: Add shared-device mode support to your Android application"
description: In this tutorial, you learn how to set up an Android application to run in shared device mode.
manager: CelesteDG
author: henrymbuguakiarie
ms.author: henrymbugua
ms.date: 08/19/2024
ms.reviewer: amgusain, dmwendia, akgoel
ms.service: msal
ms.subservice: msal-android
ms.topic: tutorial

#Customer intent: As an Android developer, I want to learn how to enable shared-device mode for an Android app, so that I can configure Android devices to be shared by multiple employees and provide Microsoft Identity backed management of the device.
---

# Tutorial: Add shared-device mode support to your Android application

In this tutorial, Android developers learn how to add shared device mode support in an Android application using the Microsoft Authentication Library (MSAL) for Android.
 
In this tutorial:

> [!div class="checklist"]
>
> - Create or modify an existing Android application project.
> - Enable and detect shared-device mode
> - Detect single or multiple account mode
> - Detect a user switch
> - Enable global sign-in and sign-out


### Create or modify an existing Android application

To complete the rest of the tutorial, you need to create a new or modify an existing Android application. If you haven't already, see the [MSAL Android tutorial](./tutorial-v2-android.md) for guidance on how to integrate MSAL with your Android app, sign in a user, call Microsoft graph, and sign out a user.  If you prefer using a completed code sample for learning and testing, clone the [sample application](https://github.com/Azure-Samples/ms-identity-android-java/) from GitHub. The sample has the capability to work in [single or multi account mode](./single-multi-account.md).

### Add the MSAL SDK to your local Maven repository

If you're not using the sample app, add the MSAL library as a dependency in your build.gradle file, like so:

```gradle
dependencies{
  implementation 'com.microsoft.identity.client.msal:4.9.+'
}
```

### Add support for single account mode 

Applications written using the Microsoft Authentication Library (MSAL) SDK can manage a single account or multiple accounts. For details, see [single-account mode or multiple-account mode](single-multi-account.md).

The Microsoft identity platform features available to your app vary depending on whether the application is running in single-account mode or multiple-account mode.

**Shared device mode apps only work in single-account mode**.

> [!IMPORTANT]
> Applications that only support multiple-account mode can't run on a shared device. If an employee loads an app that doesn't support single-account mode, it won't run on the shared device.
>
> Apps written before the MSAL SDK was released run in multiple-account mode and must be updated to support single-account mode before they can run on a shared mode device.
**Supporting both single-account and multiple-accounts**

Your app can be built to support running on both personal devices and shared devices. If your app currently supports multiple accounts and you want to support shared device mode, add support for single account mode.

You may also want your app to change its behavior depending on the type of device it's running on. Use `ISingleAccountPublicClientApplication.isSharedDevice()` to determine when to run in single-account mode.

There are two different interfaces that represent the type of device your application is on. When you request an application instance from MSAL's application factory, the correct application object is provided automatically.

The following object model illustrates the type of object you may receive and what it means in the context of a shared device:

:::image type="content" source="media/v2-shared-device-mode/ipublic-client-app-inheritance.png" alt-text="Diagram of the public client application inheritance model.":::

You need to do a type check and cast to the appropriate interface when you get your `PublicClientApplication` object. The following code checks for multiple account modes or single account modes, and casts the application object appropriately:

```java
private IPublicClientApplication mApplication;

        // Running in personal-device mode?
        if (mApplication instanceOf IMultipleAccountPublicClientApplication) {
          IMultipleAccountPublicClientApplication multipleAccountApplication = (IMultipleAccountPublicClientApplication) mApplication;
          ...
        // Running in shared-device mode?
        } else if (mApplication instanceOf ISingleAccountPublicClientApplication) {
           ISingleAccountPublicClientApplication singleAccountApplication = (ISingleAccountPublicClientApplication) mApplication;
            ...
        }
```

The following differences apply depending on whether your app is running on a shared or personal device:

|                             | Shared mode device | Personal device                                                                                     |
| --------------------------- | ------------------ | --------------------------------------------------------------------------------------------------- |
| **Accounts**                | Single account     | Multiple accounts                                                                                   |
| **Sign-in**                 | Global             | Global                                                                                              |
| **Sign-out**                | Global             | Each application can control if the sign-out is local to the app. |
| **Supported account types** | Work accounts only | Personal and work accounts supported                                                                |

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

Shared-device mode allows you to configure Android devices to be shared by multiple employees, while providing Microsoft Identity backed management of the device. Employees can sign in to their devices and access customer information quickly. When they're finished with their shift or task, they'll be able to sign out of all apps on the shared device with a single click and the device will be immediately ready for the next employee to use.

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
### Register the application and set up your tenant for testing

Before you can set up your application and put your device into shared-device mode, you need to register the application within your organizational tenant. You then provide these values in *auth_config.json* for your application to run correctly.

For information on how to do this, refer to [Register your application](./tutorial-v2-android.md).

> [!NOTE]
> When you register your app, please use the quickstart guide on the left-hand side and then select **Android**. This will lead you to a page where you'll be asked to provide the **Package Name** and **Signature Hash** for your app. These are very important to ensure your app configuration will work. You'll then receive a configuration object that you can use for your app that you'll cut and paste into your auth_config.json file.

:::image type="content" source="media/tutorial-v2-shared-device-mode/register-app.png" alt-text="Configure your Android app page":::

You should select **Make this change for me** and then provide the values the quickstart asks for. When done, Microsoft Entra ID generates all the configuration files you need.

:::image type="content" source="media/tutorial-v2-shared-device-mode/config-info.png" alt-text="Configure your project page":::

For testing purposes, set up the following roles in your tenant - at least two employees and a Cloud Device Administrator. To set the Cloud Device Administrator, you need to modify Organizational Roles. From the Microsoft Entra admin center, go to your Organizational Roles by selecting **Identity** > **Roles & admins** > **Roles & admins** > **All roles**, and then select **Cloud Device Administrator**. Add the users that can put a device into shared mode.

## Running the sample app

The Sample Application is a simple app that will call the Graph API of your organization. On first run, you'll be prompted to consent as the application is new to your employee account.

:::image type="content" source="media/tutorial-v2-shared-device-mode/run-app-permissions-requested.png" alt-text="Application configuration info screen":::

## Next steps

Set up an Android device to run apps in shared device mode and test your app.

> [!div class="nextstepaction"] 
> [Shared device mode for Android devices](tutorial-mobile-android-device-shared-mode.md)