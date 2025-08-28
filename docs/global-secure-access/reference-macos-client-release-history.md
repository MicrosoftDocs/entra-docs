---
title: Global Secure Access Client for macOS Release Notes
description: This article tracks the changes in each released version of the Global Secure Access client for macOS.
ms.service: global-secure-access
ms.topic: reference
ms.date: 08/19/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: lirazbarak


---
# Global Secure Access client for macOS release notes
This article lists the released versions of the Global Secure Access client for macOS and describes the changes in each version.   

## Download the latest version
The current version of the Global Secure Access client is available to download from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select the **macOS** tab.
1. Select **Download Client**.
:::image type="content" source="media/reference-macos-client-release-history/macos-client-download-screen.png" alt-text="Screenshot of the Client download screen with the Download Client button highlighted.":::

## Version 1.1.25070402
Released for download on August 19, 2025.
### Other changes
- Bug fix: Fixes a compatibility issue with macOS 26.
> [!IMPORTANT]
> To maintain functionality, deploy version **1.1.25070402** of the client *before* upgrading to macOS 26.
- The installer now includes a stapled notarization ticket, so macOS can verify its integrity and avoid security warnings during offline installation.

## Version 1.1.25070401
Released for download on July 29, 2025.
### Functional changes
- First version in general availability.
- Bug fix: Provides better support for large forwarding profiles.
- Supports log collection with a script.
- Increases client's log file size to allow for more comprehensive logging.
### Other changes
- Bug fix: Implements a workaround for Dynamic Host Configuration Protocol (DHCP) failures seen in macOS 15.4 and above because of a change in macOS.
- Bug fix: Avoids repeated, unnecessary certificate signing requests.
- Enhanced telemetry for better supportability and monitoring.
- Miscellaneous bug fixes and improvements.
### Known issues
- Client version **1.1.25070401** has a known compatibility issue with macOS 26 that causes the device to lose connectivity. To maintain compatibility with macOS 26, upgrade to and deploy client version **1.1.25070402** before upgrading to macOS 26. 

## Version 1.1.25060400
Released for download on June 24, 2025.
### Important changes for deployment with Mobile Device Management (MDM)
- The distribution profile identifiers changed:
    - Previous: `com.microsoft.naas.globalsecure-df` → New: `com.microsoft.globalsecureaccess`
    - Previous: `com.microsoft.naas.globalsecure.tunnel-df` → New: `com.microsoft.globalsecureaccess.tunnel`
- Special upgrade instructions apply when moving from version **1.1.584.1** (or older) to version **1.1.25060400** (or newer):
    1. Exclude macOS devices you want to upgrade from MDM policies that distribute previous client versions to avoid side-by-side installations, which can break client behavior.
    1. Deploy MDM policies to automatically [allow system extensions](how-to-install-macos-client.md#allow-system-extensions-through-mobile-device-management-mdm) and [allow transparent app proxy](how-to-install-macos-client.md#allow-transparent-application-proxy-through-mdm).
    1. Follow the updated instructions for the new identifiers:
        - `com.microsoft.globalsecureaccess`
        - `com.microsoft.globalsecureaccess.tunnel`
    1. Create a new policy to install the new client version.
    1. Remove any old policies that allow system extensions and filtering app proxy with deprecated identifiers.
- Future versions keep the new distribution profile identifiers unless otherwise noted.
- You don't need the special upgrade procedure when upgrading from a version newer than **1.1.584.1** because those versions already use the new identifiers.
### Functional changes
- Support for mutual Transport Layer Security (mTLS) connections to Global Secure Access. 
> [!NOTE]
> The mTLS connection rolls out gradually to customers through the cloud service. Customers continue to use the Transport Layer Security (TLS) connection until they get mTLS.
- Telemetry collection is enabled.
- The new UI includes a link to Microsoft's privacy policy to comply with the telemetry collection policy.
- An uninstaller application is added for easy removal of the Global Secure Access client as an alternative to the uninstall script.
- Option to disable Private Access, letting users access private applications directly through the corporate network.
- Client disable-state doesn't persist after a restart; the client automatically re-enables after a restart.
- Support for Continuous Access Evaluation (CAE) in Global Secure Access client authentication.
- Accessibility improvements for the Advanced Diagnostics tool and main window.
- Bug fix: Canonical name (CNAME) records now resolve correctly (previously resolved as A records).
- Bug fix: Resolved connectivity issues when resuming from sleep.
### Other changes
- The client version format is now based on the build date. Older versions might have higher numerical values than newer ones, but future versions increment numerically.
- Bug fix: Logging network trace is now disabled by default to optimize performance.
- Improvements and bug fixes for Advanced diagnostics.
- Miscellaneous bug fixes and improvements.

## Version 1.1.584
Released for download on November 18, 2024.

### Functional changes
- First public preview version.

## Related content
- [Global Secure Access client for macOS](how-to-install-macos-client.md)