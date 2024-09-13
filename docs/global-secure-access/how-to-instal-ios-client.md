---
title: The Global Secure Access client for iOS
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the iOS client app.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 09/12/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: dhruvinrshah


# Customer intent: As an iPhone user, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for iOS

This topic describes how to install, configure, update, and use Global Secure Access client on iOS 
devices.

> [!CAUTION]
> Running other third-party endpoint protection products alongside Defender for Endpoint on iOS is likely to cause performance problems and unpredictable system errors.
> [!NOTE]
> - Global Secure Access clients is deployed via Microsoft Defender for Endpoint on iOS.
> - Global Secure Access client on iOS would use a VPN. This VPN is not a regular VPN. Instead, it's a local/self-looping VPN.

## Prerequisites
• To use the Global Secure Access iOS client, be sure to congigure your iOS end-point device as a Microsoft Entra registered device.
• The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
• Onboard the tenant to Global Secure Access and configure one or more traffic forwarding profiles. For more information, see [Access the Global Secure Access area of the Microsoft Entra admin center](quickstart-access-admin-center.md)

## Requirements
### Network Requirements
• For Microsoft Defender for Endpoint on IOS to function when connected to a network the 
firewall/proxy will need to be configured to enable access to Microsoft Defender for 
Endpoint service URLs.
### System Requirements
• Mobile phones and tablets running iOS 15.0and above. iPads are also Supported.
• Microsoft Authenticator or Intune Company Portal app is required to be installed on the 
device.
• Microsoft Defender for Endpoint on iOS is available in the Apple App Store.
• Device enrollment is required for Intune device compliance policies to be enforced.
Note
Microsoft Defender for Endpoint on IOS isn't supported on userless or shared 
devices.
Supported Modes
Global Secure Access client on IOS supports installation on both modes of enrolled devices –
supervised and unsupervised devices.
Known Limitations
• Tunneling QUIC (Quick UDP Internet Connections) traffic (except for EXO) is not 
supported.
• Side by Side with Intune VPN tunnel is not currently supported.
• Compliant n/w CA policy for all cloud apps is not currently supported.
Installation Steps
Deploy on Device Administrator enrolled devices with Microsoft Intune
1. In the Microsoft Intune admin center, go to Apps > iOS/iPadOS > Add > iOS store app and 
click Select.
2. On the Add app page, click on Search the App Store and type Microsoft Defender in the 
search bar. In the search results section, click on Microsoft Defender and click Select.
3. Select iOS 15.0 as the Minimum operating system. Review the rest of information about the 
app and click Next.
4. In the Assignments section, go to the Required section and select Add group. You can 
then choose the user group(s) that you would like to target Defender for Endpoint on iOS 
app. Click Select and then Next.
Note
The selected user group should consist of Microsoft Intune enrolled users.
5. In the Review + Create section, verify that all the information entered is correct and then 
select Create. In a few moments, the Defender for Endpoint app should be created 
successfully, and a notification should show up at the top-right corner of the page.
6. In the app information page that is displayed, in the Monitor section, select Device install 
status to verify that the device installation has completed successfully.
Setup VPN profile and GSA Config for Microsoft Defender for Endpoint
1. In the Microsoft Intune admin center, go to Devices > Configuration Profiles > Create 
Profile.
2. Choose Platform as iOS/iPadOS, Profile type as Templates and Template name as VPN. 
Select Create.
3. Type a name for the profile and select Next.
4. Select Custom VPN for Connection Type and in the Base VPN section, enter the following:
o Connection Name = Microsoft Defender for Endpoint
o VPN server address = 127.0.0.1
o Auth method = "Username and password"
o Split Tunneling = Disable
o VPN identifier = com.microsoft.scmx
o In the key-value pairs, 
1. Add the key SilentOnboard and set the value to True.
2. Add EnableGSA Key and set appropriate value as below
EnableGSA No Value – GSA in not enabled and 
Tile is not visible
0 – GSA in not enabled and Tile is 
not visible
1 - Tile is visible and Defaults to 
false(i.e. disabled state) – User can 
enable/disable GSA using toggle 
from app.
2 - Tile is visible and Defaults to 
true(i.e.enabled state) – User can 
override - User can enable/disable 
GSA using toggle from app.
3 - Tile is visible and Defaults to 
true(i.e.enabled state) – User 
cannot disable GSA.
3. Add other key’s if required (optional)
EnableGSAPrivateChannel No Value – Enabled by default. User 
can enable/disable.
0 – GSA in not enabled and Toggle is 
not visible to user.
1 - Toggle is visible and Defaults to 
false(i.e. disabled state). User can 
enable/disable.
2 - Tile is visible and Defaults to 
true(i.e.enabled state). User can 
enable/disable.
3 - Toggle is visible and greyed out 
and Defaults to true(i.e.enabled 
state). – User cannot disable.
EnableGSAInternetChannel No Value – GSA in not enabled and 
Toggle is not visible to user.
0 – GSA in not enabled and Toggle is 
not visible to user.
1 - Toggle is visible and Defaults to 
false(i.e. disabled state). User can 
enable/disable.
2 - Tile is visible and Defaults to 
true(i.e.enabled state). User can 
enable/disable.
3 - Toggle is visible and greyed out 
and Defaults to true(i.e.enabled 
state). – User cannot disable.
o Type of Automatic VPN = On-demand VPN
o Select Add for On Demand Rules and select I want to do the following = Connect 
VPN, I want to restrict to = All domains.
o To mandate that VPN can't be disabled in users device, Admins can select Yes from 
Block users from disabling automatic VPN. By default, it's not configured and 
users can disable VPN only in the Settings.
o To allow Users to Change the VPN toggle from within the app, add 
EnableVPNToggleInApp = TRUE, in the key-value pairs. By default, users can't 
change the toggle from within the app.
5. Select Next and assign the profile to targeted users.
6. In the Review + Create section, verify that all the information entered is correct and then 
select Create.
Once the above configuration is done and synced with the device, the following actions take place 
on the targeted iOS device(s):
• Microsoft Defender for Endpoint will be deployed and silently onboarded and the device will 
be seen in the Defender for Endpoint portal.
• A provisional notification will be sent to the user device.
• Global Secure Access and other features will be activated.
Throubleshooting:
• GSA Tile does not appear in Defender app after onboarding tenant:
o Force Stop Defender app and re-launch it.
• Access to Private Access application shows connection time out error after successful
interactive sign-in
o Reloading the application (web browser refresh) should fix the issue.
Reference
• Microsoft Defender for Endpoint on IOS | Microsoft Learn
• Deploy Microsoft Defender for Endpoint on IOS with Microsoft Intun