---
title: Microsoft Entra certificate-based authentication on Android devices
description: Learn about Microsoft Entra certificate-based authentication on Android devices

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025

ms.author: justinha
author: vimrang
manager: femila
ms.reviewer: vimrang
ms.custom: has-adal-ref
---
# Microsoft Entra certificate-based authentication on Android devices

Microsoft Entra Certificate-based authentication is supported with certificates provisioned on the device and with external security keys like YubiKeys. 

## Prerequisites

- Android version must be Android 5.0 (Lollipop) or later.
- Microsoft first-party apps with latest MSAL libraries or Microsoft Authenticator can do CBA.
- Third party applications using latest MSAL libraries or integrated with Microsoft Authenticator can do CBA.

## CBA with on-device certificates

Customers can use their choice of Mobile Device Management (MDM) to provision the certificates on the device. End users must first register their devices with MDM and get the certificate provisioned on the device. Once the certificate is provisioned on the device, users can authenticate using CBA.

Steps to test YubiKey on Microsoft apps on Android: 

1. Open Outlook. 
1. Select **Add account** and enter your user principal name (UPN).
1. Click **Continue**.  
1. Select **Use Certificate or smart card**. 
1. Select **Certificate on the device** in the dialog**.**
1. The certificate picker appears. 
1. Select the certificate associated with the user’s account. Click **Continue**. 
1. User is allowed to access the Outlook resource if the authentication is successful.

## CBA with certificates on hardware security key

Certificates can be provisioned in external devices like hardware security keys along with a PIN to protect private key access. Microsoft Entra ID supports CBA with YubiKey.  

### Advantages of certificates on hardware security key 

Security keys with certificates:  

- Have the roaming nature of a security key, which allows users to use the same certificate on different devices.
- Are hardware-secured with a PIN, which makes them phishing-resistant.
- Provide multifactor authentication with a PIN as second factor to access the private key of the certificate.
- Satisfy the industry requirement to have MFA on separate device.
- Help in future proofing where multiple credentials can be stored including Fast Identity Online 2 (FIDO2) keys. 

### Microsoft Entra CBA on Android mobile with YubiKey 

Android needs a middleware application to be able to support smartcard or security keys with certificates. To support YubiKeys with Microsoft Entra CBA, YubiKey Android SDK has been integrated into the Microsoft broker code which can be leveraged through the latest Microsoft Authentication Library (MSAL). 

Because Microsoft Entra CBA with YubiKey on Android mobile is enabled by using the latest MSAL, YubiKey Authenticator app isn't required for Android support. 

Steps to test YubiKey on Microsoft apps on Android: 

1. Install Microsoft Authenticator.
1. If your YubiKey has USB-C, open Outlook and plug in your YubiKey. 
1. Select **Add account** and enter your user principal name (UPN).
1. Click **Continue**, and when asked for permission to access your YubiKey, click **OK**. 
1. Select **Use Certificate or smart card**.
1. If you're using an NFC-enabled Yubikey, hold the Yubikey to the back of the device.
1. A custom certificate picker appears.
1. Select the certificate associated with the user’s account, and click **Continue**. 
1. Enter the PIN to access YubiKey and select **Unlock**.
1. If you're using a Yubikey with NFC, hold the Yubikey to the back of the phone again to validate the PIN.
1. After authentication succeeds, you can access Outlook.

>[!NOTE]
>For a smooth CBA flow, plug in YubiKey as soon as the application is opened and accept the consent dialog from YubiKey before selecting the link **Use Certificate or smart card**. If you want to experience only a single connection, consider having users plug in the YubiKey by using USB instead of NFC, which only needs to be done once at the beginning of login.

## Support for Exchange ActiveSync clients

Certain Exchange ActiveSync applications on Android 5.0 (Lollipop) or later are supported. To determine if your email application supports Microsoft Entra CBA, contact your application developer.

## Supported Microsoft Entra use cases

### Microsoft mobile application support

| Applications | Support | 
|:---------|:------------:|
|Azure Information Protection app|  &#x2705; |
|Company Portal	 |  &#x2705; |
|Microsoft Teams |  &#x2705; |
|Office (mobile) |  &#x2705; |
|OneNote |  &#x2705; |
|OneDrive |  &#x2705; |
|Outlook |  &#x2705; |
|Power BI |  &#x2705; |
|Skype for Business	 |  &#x2705; |
|Word / Excel / PowerPoint	 |  &#x2705; |
|Yammer	 |  &#x2705; |
|Edge browser with profile login	 |  &#x2705; |
|Managed Home Screen	 |  &#x2705; |

### Browsers

|Operating system | Chrome certificate on-device | Chrome smart card/security key | Safari certificate on-device | Safari smart card/security key | Edge certificate on-device | Edge smart card/security key |
|:----------------|:---------------------------------:|:---------------------:|:---------------------------------:|:---------------------:|:---------------------------------:|:---------------------:|
| Android             |  &#x2705;                          | &#10060;|N/A                          | N/A |  &#x2705;                          | &#10060;|

>[!NOTE]
>Although Edge as a browser isn't supported, Edge as a profile (for account login) is an MSAL app that supports CBA on Android.


### Operating systems

|Operating system | Certificate on-device/Derived PIV |    Smart cards/Security keys |
|:----------------|:---------------------------------:|:---------------------:|
| Android         | &#x2705;                          | Supported vendors only|

### Security key providers

|Provider            |                  Android           |
|:-------------------|:------------------------------:|
| YubiKey            |              &#x2705;          | 

### Troubleshoot certificates on hardware security key

#### What will happen if the user has certificates both on the Android device and YubiKey? 

- If the user has certificates both on the android device and YubiKey, then if the YubiKey is plugged in before user clicks **Use Certificate or smart card**, the user will be shown the certificates in the YubiKey.  
- If the YubiKey isn't plugged in before user clicks **Use Certificate or smart card**, the user will be asked to select between certificates on device or physical smart card. If the user chooses **Certificate on device**, the user will be shown the certificates on the device. If the user chooses **Certificates on physical smart card**, plug in or hold the YubiKey to the back, and the user will be shown the certificates in the YubiKey. 

#### My YubiKey is locked after incorrectly typing PIN three times. How do I fix it? 

- Users should see a dialog informing you that too many PIN attempts have been made. This dialog also pops up during subsequent attempts to select **Use Certificate or smart card**.
- Users should contact the admin to reset a YubiKey PIN. 

#### I have installed Microsoft authenticator but still don't see an option to do Certificate based authentication with YubiKey.

Before installing Microsoft Authenticator, uninstall Company Portal and install it after Microsoft Authenticator installation. 

#### Does Microsoft Entra CBA support YubiKey via NFC? 

Microsoft Entra CBA supports using YubiKey with USB and NFC.

#### Once CBA fails, clicking on the CBA option again in the ‘Other ways to sign in’ link on the error page fails. 

This issue happens because of certificate caching. As a workaround, clicking cancel and restarting the login flow will let the user choose a new certificate and successfully login. 

#### Microsoft Entra CBA with YubiKey is failing. What information would help debug the issue? 

1. Open Microsoft Authenticator app, click the three dots icon in the top right corner and select **Send Feedback**.
1. Click **Having Trouble?**.
1. For **Select an option**, select **Add or sign into an account**. 
1. Describe any details you want to add. 
1. Click the send arrow in the top right corner. Note the code provided in the dialog that appears. 


## Next steps

- [Overview of Microsoft Entra CBA](concept-certificate-based-authentication.md)
- [Technical deep dive for Microsoft Entra CBA](concept-certificate-based-authentication-technical-deep-dive.md)
- [How to configure Microsoft Entra CBA](how-to-certificate-based-authentication.md)
- [Microsoft Entra CBA on iOS devices](concept-certificate-based-authentication-mobile-ios.md)
- [Windows SmartCard logon using Microsoft Entra CBA](concept-certificate-based-authentication-smartcard.md)
- [Certificate user IDs](concept-certificate-based-authentication-certificateuserids.md)
- [How to migrate federated users](concept-certificate-based-authentication-migration.md)
- [FAQ](certificate-based-authentication-faq.yml)
