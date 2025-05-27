---
title: Tutorial - Using the Microsoft Entra Wallet Library demo application
description: In this tutorial, you learn how to build and use the Microsoft Entra Wallet Library demo app on Android and iOS.
ms.service: entra-verified-id
author: barclayn
manager: femila
ms.author: barclayn
ms.topic: tutorial
ms.date: 12/16/2024
ms.custom: sfi-image-nochange
# Customer intent: As a developer, I want to build a custom wallet using Microsoft Entra Verified ID Wallet Library.
---

# Using the Microsoft Entra Wallet Library with Verified ID

In this tutorial, you learn how a mobile app can use the Microsoft Entra Wallet Library with Verified ID to issue and present verifiable credentials.

## Prerequisites

- [Android Studio](https://developer.android.com/studio) installed on Mac/Windows and an Android test device. You need to enable [developer mode](https://developer.android.com/studio/debug/dev-options) on your Android test device.
- An [Apple developer account](https://developer.apple.com/), Mac with [Xcode](https://developer.apple.com/xcode/) and an iOS test device with [developer mode](https://developer.apple.com/documentation/xcode/enabling-developer-mode-on-a-device) enabled. The iOS version needs to be at least IOs 16.
- Install the [QR Code Reader](https://apps.apple.com/us/app/qr-code-reader/id1200318119) app on your test device. The WalletLibraryDemo app doesn't come with the ability to scan QR codes, so you need the QR Code Reader app to scan the QR codes with.

You don't need to be a mobile developer to follow this tutorial and get the demo app up and running. The tools and a test device and the courage to try is all you need. You also don't need a Microsoft Entra Verified ID tenant onboarded as you can test the demo app with our public end to end demo website.

> [!NOTE]
> Use the latest Wallet Library available to get support for NIST compliant P-256 curve used by Verified ID since February 2024.

## What is the Microsoft Entra Wallet Library?

The Microsoft Entra Wallet Library for iOS and Android gives your mobile app the ability to begin using the Microsoft Entra Verified ID platform. Using the Wallet Library, The mobile app uses the Wallet Library to issue and present verifiable credentials in accordance with industry standards.

## When should I use the Microsoft Entra Wallet Library?

Microsoft Authenticator has all the functionality to act as the wallet for Microsoft Entra Verified ID. But in cases where you can’t use the Microsoft Authenticator, the Wallet Library is your alternative. An example could be when you already have a mobile app that your users are familiar with and where it makes more sense to include verifiable credentials technology into this app.

You can use Microsoft Authenticator and a mobile app using the Wallet Library side-by-side on the same mobile device. Authenticator, if installed, is the app that registers the protocol handler for openid://, so your app needs to make sure that the issuance and presentation requests find your app. Use of embedded deep links in HTML-pages that rely on the openid:// protocol launches Microsoft Authenticator.

## Does Microsoft use the Microsoft Entra Wallet Library?

Yes, the Wallet Library is used by the Microsoft Authenticator. Some features may appear in the Authenticator first, but it is our ambition to make them available in the Wallet Library.

## What is the effort of adding the Microsoft Entra Wallet Library to my app?

You add the Wallet Library to your mobile app project via adding a maven dependency for Android and adding a cocoapod dependency for iOS.

### [iOS](#tab/ios)

For iOS, add the WalletLibrary pod to your Podfile.

```Swift
target "YourApp" do
  use_frameworks!
  pod "WalletLibrary", "~> 1.0.1"
end
```

### [Android](#tab/android)
For Android, add to your app's build.gradle to add Wallet Library as a dependency.

```kotlin
dependencies {
    implementation 'com.microsoft.entra.verifiedid:walletlibrary:1.0.0'
}
```

---

Then you need to add some code to process the requests. For details, see the WalletLibraryDemo sample code.

### [iOS](#tab/ios)

```swift
/// Create a verifiedIdClient.
let verifiedIdClient = VerifiedIdClientBuilder().build()

/// Create a VerifiedIdRequestInput using a OpenId Request Uri.
let input = VerifiedIdRequestURL(url: URL(string: "openid-vc://...")!)
let result = await verifiedIdClient.createRequest(from: input)

/// Every external method's return value is wrapped in a Result object to ensure proper error handling.
switch (result) {
case .success(let request):
    /// A request created from the method above could be an issuance or a presentation request. 
    /// In this example, it is a presentation request, so we can cast it to a VerifiedIdPresentationRequest.
    let presentationRequest = request as? VerifiedIdPresentationRequest
case .failure(let error):
    /// If an error occurs, its value can be accessed here.
    print(error)
}
```

### [Android](#tab/android)

```kotlin
// Create a verifiedIdClient
val verifiedIdClient = VerifiedIdClientBuilder(context).build()

// Create a VerifiedIdRequestInput using a OpenId Request Uri.
val verifiedIdRequestUrl = VerifiedIdRequestURL(Uri.parse("openid-vc://..."))
val verifiedIdRequestResult: Result<VerifiedIdRequest<*>> = verifiedIdClient.createRequest(verifiedIdRequestUrl)

// Every external method's return value is wrapped in a Result object to ensure proper error handling.
if (verifiedIdRequestResult.isSuccess) {
    val verifiedIdRequest = verifiedIdRequestResult.getOrNull()
    val presentationRequest = verifiedIdRequest?.let {
        verifiedIdRequest as VerifiedIdPresentationRequest
    }
} else {
    // If an exception occurs, its value can be accessed here.
    val exception = verifiedIdRequestResult.exceptionOrNull()
}
```

---

Then, you have to handle the following major tasks in your app.

- Getting the request URLs. The Wallet Library doesn't come with any functionality to scan a QR code or similar. If you would like to provide support for any other options not built into the app, you need to add those features yourself.
- Storing the credentials. The Wallet Library creates the private and public key used for signing responses and stores them on the device, but it doesn't come with any functionality for storing credentials. You have to manage credential storage for your mobile app.
- User Interface. You must implement any visual representation of stored credentials and any UI elements meant to drive the issuance and presentation process.

## Wallet Library Demo app

The Wallet Library comes with a demo app in the GitHub repo that is ready to use without any modifications. You just have to build and deploy it. The demo app is a lightweight and simple implementation that illustrates issuance and presentation at its minimum. To quickly get going, you can use the QR Code Reader app to scan the QR code, and then copy and paste it into the demo app.

In order to test the demo app, you need a webapp that issues credentials and makes presentation requests for credentials. The [Woodgrove public demo webapp](https://aka.ms/vcdemo) is used for this purpose in this tutorial.

## Building the Android sample

On your developer machine with Android Studio, take the following steps:

1. Download or clone the Android Wallet Library [GitHub repo](https://github.com/microsoft/entra-verifiedid-wallet-library-android/tree/dev). You don’t need the wallet library folder and you can delete it if you like.
1. Start Android Studio and open the parent folder of walletlibrarydemo

    :::image type="content" source="media/using-wallet-library/androidstudio-screenshot.png" alt-text="Screenshot of Android Studio.":::

1. Select **Build** menu and then **Make Project**. This step takes some time.
1. Connect your Android test device via USB cable to your laptop
1. Select your test device in Android Studio and select **run** button (green triangle)

## Issuing credentials using the Android sample

1. Start the WalletLibraryDemo app

    :::image type="content" source="media/using-wallet-library/android-create-request.png" alt-text="Screenshot of Create Request on Android.":::

1. On your laptop, launch the public demo website [https://aka.ms/vcdemo](https://aka.ms/vcdemo) and do the following
    1. Enter your First Name and Last Name and press **Next**
    1. Select **Verify with True Identity**
    1. Select **Take a selfie** and **Upload government issued ID**. The demo uses simulated data and you don't need to provide a real selfie or an ID.
    1. Select **Next** and **OK**

1. Scan the QR code with your QR Code Reader app on your test device, then copy the full URL displayed in the QR Code Reader app. Remember the pin code.
1. Switch back to WalletLibraryDemo app and paste in the URL from the clipboard
1. Press **CREATE REQUEST** button
1. When the app downloads the request, it shows a screen like the example provided. Select on the white rectangle, which is a textbox, and enter the pin code that is displayed in the browser page. Then select the **COMPLETE** button.

    :::image type="content" source="media/using-wallet-library/android-enter-pincode.png" alt-text="Screenshot of Enter Pin Code on Android.":::

1. Once issuance completes, the demo app displays the claims in the credential

    :::image type="content" source="media/using-wallet-library/android-issuance-complete.png" alt-text="Screenshot of Issuance Complete on Android.":::

## Presenting credentials using the Android sample

The sample app holds the issued credential in memory, so after issuance, you can use it for presentation.

1. If you successfully issued a credential, the WalletLibraryDemo app should display some credential details on the home screen.

    :::image type="content" source="media/using-wallet-library/android-have-credential.png" alt-text="Screenshot of app with credential on Android.":::

1. In the Woodgrove demo in the browser, select **Return to Woodgrove** if you haven’t done so already and continue with step 3 **Access personalized portal**.
1. Scan the QR code with the QR Code Reader app on your test device, then copy the full URL to the clipboard.
1. Switch back to the WalletLibraryDemo app and paste in the URL and select **CREATE REQUEST** button
1. The app retrieves the presentation request and display the matching credentials you have in memory. In this case, you only have one. **Click on it** so that the little check mark appears, then select the **COMPLETE** button to submit the presentation response

    :::image type="content" source="media/using-wallet-library/android-present-credential.png" alt-text="Screenshot of presenting credential on Android.":::
 
## Building the iOS sample

On your Mac developer machine with Xcode, take the following steps:
1. Download or clone the iOS Wallet Library [GitHub repo](https://github.com/microsoft/entra-verifiedid-wallet-library-ios/tree/dev). 
1. Start Xcode and open the top level folder for the WalletLibrary
1. Set focus on WalletLibraryDemo project

    :::image type="content" source="media/using-wallet-library/xcode-screenshot.png" alt-text="Screenshot of Xcode.":::  

1. Change the Team ID to your [Apple Developer Team ID](https://developer.apple.com/help/account/manage-your-team/locate-your-team-id).
1. Select Product menu and then **Build**. This step takes some time. 
1. Connect your iOS test device via USB cable to your laptop
1. Select your test device in Xcode
1. Select Product menu and then **Run** or select on run triangle
 
## Issuing credentials using the iOS sample

1. Start the WalletLibraryDemo app

    :::image type="content" source="media/using-wallet-library/ios-create-request.png" alt-text="Screenshot of Create Request on iOS.":::
 
1. On your laptop, launch the public demo website [https://aka.ms/vcdemo](https://aka.ms/vcdemo) and do the following
    1. Enter your First Name and Last Name and press **Next**
    1. Select **Verify with True Identity**
    1. Select **Take a selfie** and **Upload government issued ID**. The demo uses simulated data and you don't need to provide a real selfie or an ID. 
    1. Select **Next** and **OK**

1. Scan the QR code with your QR Code Reader app on your test device, then copy the full URL displayed in the QR Code Reader app. Remember the pin code.
1. Switch back to WalletLibraryDemo app and paste in the URL from the clipboard
1. Press **Create Request** button
1. When the app completes downloading the request, it shows a screen like our example. Select on the **Add Pin** text to go to a screen where you can input the pin code, then select **Add** button to get back and finally select the **Complete** button.

    :::image type="content" source="media/using-wallet-library/ios-enter-pincode.png" alt-text="Screenshot of Enter Pin Code on iOS.":::
   
1. Once issuance completes, the demo app displays the claims in the credential.

    :::image type="content" source="media/using-wallet-library/ios-issuance-complete.png" alt-text="Screenshot of Issuance Complete on iOS.":::

## Presenting credentials using the iOS sample

The sample app holds the issued credential in memory, so after issuance, you can use it for presentation.

1. If you successfully issued a credential, the WalletLibraryDemo app displays the credential type name on the home screen.

    :::image type="content" source="media/using-wallet-library/ios-have-credential.png" alt-text="Screenshot of app with credential on iOS.":::
 
1. In the Woodgrove demo in the browser, select **Return to Woodgrove** if you haven’t done so already and continue with step 3 **Access personalized portal**.
1. Scan the QR code with the QR Code Reader app on your test device, then copy the full URL to the clipboard.
1. Switch back to the WalletLibraryDemo app, ***clear the previous request*** from the textbox, paste in the URL and select **Create Request** button
1. The app retrieves the presentation request and display the matching credentials you have in memory. In this case you only have one. **Click on it** so that the little check mark switches from blue to green, then select the **Complete** button to submit the presentation response

    :::image type="content" source="media/using-wallet-library/ios-present-credential.png" alt-text="Screenshot of presenting credential on iOS.":::
 
## Next steps

Learn how to [configure your tenant for Microsoft Entra Verified ID](verifiable-credentials-configure-tenant.md).
