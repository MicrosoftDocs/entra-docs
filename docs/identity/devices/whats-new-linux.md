---
title:       What's new in Microsoft Single Sign-on for Linux
description: Discusses new feature releases of Microsoft Single Sign-on for Linux
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.topic: whats-new
ms.date:     05/16/2025
ms.subservice: devices
---

# What's new in Microsoft Single Sign-on for Linux
This article provides information about the latest updates to Microsoft Single Sign-on for Linux. 

### Package Repositories
Microsoft uses the following package repositories to distribute the Microsoft Identity Broker and Microsoft Identity Diagnostics for Linux. Packages are available in either `.deb` or `.rpm` format, however only Ubuntu Long-Term Support (LTS) & Red Hat Enterprise Linux (LTS) are supported.


#### [Ubuntu20.04](#tab/ubuntu2004)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/msft-identity-broker/)

#### [Ubuntu22.04](#tab/ubuntu2204)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-diagnostics/)

#### [Ubuntu24.04](#tab/ubuntu2404)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/)

#### [RedHat 9](#tab/redhat9)
- [microsoft-identity-broker](https://packages.microsoft.com/rhel/9/prod/Packages/m/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/rhel/9/prod/Packages/m/)

#### [RedHat 8](#tab/redhat8)
- [microsoft-identity-broker](https://packages.microsoft.com/rhel/8/prod/Packages/m/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/rhel/8/prod/Packages/m/)

---

## Microsoft-Identity-Broker



## Version Lifecycle and Support Matrix

Details about the Long Term Support policy will be provided here in future updates.

The following table lists Identity Runtime SDK versions currently supported and receiving security fixes.

|Major Version |Primary Purpose|Latest Version| Supported| Source|
| --------|--------------| -------- |---------------------|--------------|
|stable|Production workloads|2.0.1|✅ Yes|[Ubuntu 24.04 - Noble](https://packages.microsoft.com/ubuntu/24.04/prod/dists/noble/)</br>[Ubuntu 22.04 - Jammy](https://packages.microsoft.com/ubuntu/22.04/prod/dists/jammy/)</br>[RHEL8](https://packages.microsoft.com/rhel/8.0/prod/)</br>[RHEL9](https://packages.microsoft.com/rhel/9.0/prod/)|
|insiders-fast|Test upcoming releases|2.0.3|❌ No|[Ubuntu 24.04 - Noble](https://packages.microsoft.com/ubuntu/24.04/prod/dists/insiders-fast/)</br>[Ubuntu 22.04 - Jammy](https://packages.microsoft.com/ubuntu/22.04/prod/dists/insiders-fast/)</br>[RHEL8](https://packages.microsoft.com/rhel/8.0/insiders-fast/)</br>[RHEL9](https://packages.microsoft.com/rhel/9.0/insiders-fast/)|


### Preview (insiders-fast)

- The current production version of the `microsoft-identity-broker` is `2.0.1`. Any version > than this is considered preview and will have best effort engineering support during standard business hours, and we provide no guarantee for production workloads.

- We have introduced a "fast-Insiders" channel in `packages.microsoft.com` to allow pre-release testing of packages > 2.0.1 (last production shipped version.
- We have only tested Ubuntu 22.04 and 24.04 at this time. RHEL support will come after we stabilize Ubuntu.
- Currently there is no migration script to migrate state from the 2.0.1 (javabroker) to broker2.0.2 (cpp version)>. To test the new broker (2.0.2>), you will need to remove the javabroker(<=2.0.1) and all state, and will require users to re-register your device via intune + broker2.0.2+.

-  The current documentation for production can be found: General Documentation: [Microsoft single sign-on For Linux](/entra/identity/devices/sso-linux?tabs=debian-install%2Cdebian-update%2Cdebian-uninstall)

### 2.0.3 - Oct 21, 2025 - (Preview Release)

- Added support for the microsoft-identity-broker-diagnostics package.
- Rename linux_broker to microsoft-identity-broker
- Rename linux_devicebroker to microsoft-identity-device-broker
- Update x-client-os to use distro name

#### Assets


- Ubuntu-20.04 - [microsoft-identity-broker_1.6.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.0_amd64.deb)

- Ubuntu-22.04 - [microsoft-identity-broker_1.6.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.0_amd64.deb)

- Red Hat Enterprise Linux 9.0 - [microsoft-identity-broker-1.6.0-1.x86_64.rpm](https://packages.microsoft.com/rhel/9/prod/Packages/m/microsoft-identity-broker-1.6.0-1.x86_64.rpm) 
- Red Hat Enterprise Linux 8.0 - [microsoft-identity-broker-1.6.0-1.x86_64.rpm](https://packages.microsoft.com/rhel/8/prod/Packages/m/microsoft-identity-broker-1.6.0-1.x86_64.rpm)

---

### 2.0.2 - Sept 19, 2025 - (Preview Release)

- Added Telemetry to the header of token requests so we can differentiate broker versions.
- When onboarding a new device, the device will perform an Entra Join instead of an Entra Registration. This means it is a device trust, instead of a registration within the user profile. This is a prerequisite step to enable platformSSO in the future.
- Renamed the device broker service from `microsoft-identity-device-broker` to `microsoft-identity-devicebroker`

- There no longer is a user broker service named `microsoft-identity-broker`. The user broker is now an executable that gets invoked via dbus connection
- Device certs are moved from the Keychain to `/etc/ssl/private`. In that directory, there will be a device cert per tenant, a session transport key per tenant, and a deviceless key that is stored in that directory. All other user data such as AT/RT are stored in the KeyChain and accessed via msal/OneAuth.

### Broker Support for MSAL Python and MSAL .NET on Linux - June 13, 2025

- As of 2.0.1, the `microsoft.identity.broker` now supports using [Using MSAL Python with an Auth Broker on Linux](https://learn.microsoft.com/en-us/entra/msal/python/advanced/linux-broker-py?tabs=ubuntudep) and [Using MSAL.Net with broker on Linux](https://learn.microsoft.com/en-us/entra/msal/dotnet/acquiring-tokens/desktop-mobile/linux-dotnet-sdk?tabs=ubuntudep) to make token requests via broker.

---

### 2.0.1 - Nov 18, 2024 

- Releasing package support for ubuntu 24.04

---

### 2.0.0 - Mar 21, 2024

- Bug fixes

---

### 1.7.0 - Jan 31, 2024

- Addressing the 1001 on registration failure
- Updating the install scripts for Red Hat Enterprise Linux Broker
- Adding license to Linux Broker Package

---

### 1.6.1 - Aug 17, 2023
- [PATCH] Perform safe deserialization for X509 Certificate in Linux Broker (#2483) 

#### Assets

- Ubuntu-20.04 - [microsoft-identity-broker_1.6.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.1_amd64.deb) 
- Ubuntu-22.04 - [microsoft-identity-broker_1.6.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.1_amd64.deb)

---

### 1.6.0 - Jun 29, 2023

- Added support for Red Hat Enterprise Linux 8 and 9.

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.6.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.0_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.6.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.0_amd64.deb)
- Red Hat Enterprise Linux 9.0 - [microsoft-identity-broker-1.6.0-1.x86_64.rpm](https://packages.microsoft.com/rhel/9/prod/Packages/m/microsoft-identity-broker-1.6.0-1.x86_64.rpm) 
- Red Hat Enterprise Linux 8.0 - [microsoft-identity-broker-1.6.0-1.x86_64.rpm](https://packages.microsoft.com/rhel/8/prod/Packages/m/microsoft-identity-broker-1.6.0-1.x86_64.rpm)

---

### 1.5.1 - May 09, 2023
- update serialization library
- Excluded the memory consumption change
- Secret service version upgrade - kubuntu

#### Assets
- Ubuntu-20.04 -[microsoft-identity-broker_1.5.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.5.1_amd64.deb)
- Ubuntu-22.04 -[microsoft-identity-broker_1.5.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.5.1_amd64.deb)

---

### 1.4.1 - Oct 22, 2022
- Resource Owner Password Credential (ROPC) test hook.
- added logging for keyring "1001" errors.

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.4.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.1_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.4.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.1_amd64.deb)

---

### 1.4.0 - Oct 26, 2022
- Java 17 support
- Ubuntu 22 support

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.4.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.0_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.4.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.0_amd64.deb)

---

### 1.3.0 - Oct 26, 2022

#### Assets
- Ubuntu-20.04 -[microsoft-identity-broker_1.3.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.3.0_amd64.deb)

---

### 1.2.0 - Oct 26, 2022

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.2.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.2.0_amd64.deb)

---

## Microsoft-Identity-Diagnostics

#### 1.01 - Nov 29, 2022

#### Assets
- Ubuntu 22.04 - [microsoft-identity-diagnostics_1.1.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-diagnostics/microsoft-identity-diagnostics_1.1.0_amd64.deb)

---

#### 1.0.1 - Aug 07, 2022

#### Assets
- Red Hat Enterprise Linux 9.0 - [microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm](https://packages.microsoft.com/rhel/9/prod/Packages/m/microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm)

- Red Hat Enterprise Linux 8.0 - [microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm](https://packages.microsoft.com/rhel/8/prod/Packages/m/microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm)

