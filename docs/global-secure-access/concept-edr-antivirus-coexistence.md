---
title: EDR and antivirus coexistence with Global Secure Access client
description: Learn about endpoint detection and response and antivirus solution coexistence with Global Secure Access client.
author: jricketts
manager: martinco
ms.author: jricketts
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 03/28/2025

#CustomerIntent: As an administrator, I want to configure endpoint detection and response and antivirus solution coexistence with Global Secure Access client so that I can improve system performance.
---
# Configure endpoint detection and response and antivirus solution coexistence with Global Secure Access client

Running antivirus solutions such as Microsoft Defender for Endpoint side by side with the Global Secure Access client can affect system performance. If your system experiences [high CPU usage or performance issues](/defender-endpoint/troubleshoot-performance-issues), exclude Global Secure Access client processes from your antivirus solution.

## Configuration overview

In your antivirus solution, configure exclusions and bypasses for all Global Secure Access client processes:

- `C:\Program Files\Global Secure Access Client\GlobalSecureAccessClientManagerService.exe`
- `C:\Program Files\Global Secure Access Client\GlobalSecureAccessEngineService.exe`
- `C:\Program Files\Global Secure Access Client\GlobalSecureAccessETLController.exe`
- `C:\Program Files\Global Secure Access Client\GlobalSecureAccessTunnelingService.exe`
- `C:\Program Files\Global Secure Access Client\TrayApp\GlobalSecureAccessClient.exe`
- `C:\Program Files\Global Secure Access Client\PolicyService\GlobalSecureAccessPolicyRetrieverService.exe`
- `C:\Program Files\Global Secure Access Client\LogsCollector\LogsCollector.exe`
- `C:\Program Files\Global Secure Access Client\AuthenticationRunner\GlobalSecureAccessAuthenticationRunner.exe`
- `C:\Program Files\Global Secure Access Client\AdvancedDiagnostics\GlobalSecureAccessClientAdvancedDiagnostics.exe`

To exclude these processes from Microsoft Defender for Endpoint, see [Configure custom exclusions for Microsoft Defender Antivirus](/defender-endpoint/configure-exclusions-microsoft-defender-antivirus).

## Next steps

-   Install the Windows client: [The Global Secure Access Client for Windows - Global Secure Access \| Microsoft Learn](how-to-install-windows-client.md)
-   Install the macOS client: [The Global Secure Access Client for macOS - Global Secure Access \| Microsoft Learn](how-to-install-macos-client.md)
-   Install the Android client: [The Global Secure Access Client for Android - Global Secure Access \| Microsoft Learn](how-to-install-android-client.md)
-   Install the iOS client: [The Global Secure Access Client for iOS (Preview) - Global Secure Access \| Microsoft Learn](how-to-install-ios-client.md)
