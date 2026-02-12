---
title: What's new in Microsoft single sign-on for Linux
description: Discusses new feature releases of Microsoft single sign-on for Linux
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.topic: whats-new
ms.date:     02/03/2026
ms.subservice: devices
ms.custom: linux-related-content
---

# What's new in Microsoft single sign-on for Linux
Microsoft periodically adds and modifies the features and functionality of the Microsoft identity platform to improve its security, usability, and standards compliance.

Unless otherwise noted, the changes described here apply only to applications registered after the stated effective date of the change.

Check this article regularly to learn about:
- Known issues and fixes
- Protocol changes
- Deprecated functionality

This article provides information about the latest updates to Microsoft single sign-on for Linux. 

### Package Repositories
Microsoft uses the following package repositories to distribute the Microsoft Identity Broker and Microsoft Identity Diagnostics for Linux. Packages are available in either `.deb` or `.rpm` format, however only Ubuntu Long-Term Support (LTS) & Red Hat Enterprise Linux (LTS) are supported.


#### [Ubuntu20.04](#tab/ubuntu2004)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/msft-identity-broker/)

#### [Ubuntu22.04](#tab/ubuntu2204)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-diagnostics/)

#### [Ubuntu24.04](#tab/ubuntu2404)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/)

#### [RedHat 8](#tab/redhat8)

- [microsoft-identity-broker](https://packages.microsoft.com/rhel/8/prod/Packages/m/)

- [microsoft-identity-diagnostics](https://packages.microsoft.com/rhel/8/prod/Packages/m/)

#### [RedHat 9](#tab/redhat9)
- [microsoft-identity-broker](https://packages.microsoft.com/rhel/9/prod/Packages/m/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/rhel/9/prod/Packages/m/)

#### [RedHat 10](#tab/redhat10)

- [microsoft-identity-broker](https://packages.microsoft.com/rhel/10/insiders-fast/Packages/m/)

- [microsoft-identity-diagnostics](https://packages.microsoft.com/rhel/10/insiders-fast/Packages/m/)

---

## Microsoft-Identity-Broker - Version Lifecycle and Support Matrix

The following table lists Identity Runtime SDK versions currently supported and receiving security fixes.

|Major Version |Primary Purpose|Latest Version| Supported| Source|
| --------|--------------| -------- |---------------------|--------------|
|stable|Production workloads|2.0.1|✅ Yes|[Ubuntu 24.04 - Noble](https://packages.microsoft.com/ubuntu/24.04/prod/dists/noble/)</br>[Ubuntu 22.04 - Jammy](https://packages.microsoft.com/ubuntu/22.04/prod/dists/jammy/)</br>[RHEL8](https://packages.microsoft.com/rhel/8.0/prod/)</br>[RHEL9](https://packages.microsoft.com/rhel/9.0/prod/)|
|insiders-fast|Testing upcoming releases|2.5.x|❌ No|[Ubuntu 24.04 - Noble](https://packages.microsoft.com/ubuntu/24.04/prod/dists/insiders-fast/)</br>[Ubuntu 22.04 - Jammy](https://packages.microsoft.com/ubuntu/22.04/prod/dists/insiders-fast/)</br>[RHEL8](https://packages.microsoft.com/rhel/8.0/insiders-fast/)</br>[RHEL9](https://packages.microsoft.com/rhel/9.0/insiders-fast/)</br>[RHEL10](https://packages.microsoft.com/rhel/10/insiders-fast/)|

> [!NOTE]
> The current production version of the `microsoft-identity-broker` is `2.0.1`. 

We introduced an "insiders-fast" channel in `packages.microsoft.com` to allow prerelease testing of packages newer than 2.0.1 (the latest production version). This channel isn't intended for production use and might contain breaking changes or incomplete features.

### Important Notes for Version 2.0.2 and Later

> [!WARNING]
> Versions 2.0.2 and later represent a major architectural change from Java-based to C++-based broker implementation. If you're upgrading from a previous version (prod: 2.0.1 or earlier, insiders-fast: 2.0.4 or earlier), users will need to re-register and re-enroll their devices after performing an upgrade of the previous version.

## Instructions to Add Package Repositories
### Adding Repositories

To add the appropriate package repository for your Linux distribution, follow the instructions below:


### [Ubuntu Production Repository](#tab/debian-install-prod)

1. Install the Microsoft production package signing key.  

    ```bash
    sudo apt install curl gpg
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings
    rm microsoft.gpg
    ```

3. Add and update Microsoft Linux Repository to the system repository list.

    ```bash
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" >> /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-prod.list'
    sudo apt update
    ```

### [Ubuntu insiders-fast Repository](#tab/debian-install-insiders-fast)

1. Install the Microsoft production package signing key.  

    ```bash
    sudo apt install curl gpg
    curl https://packages.microsoft.com/ubuntu/24.04/prod/dists/insiders-fast/Release.gpg  | gpg --dearmor > fast-insiders.gpg
    sudo install -o root -g root -m 644 fast-insiders.gpg  /usr/share/keyrings
    rm fast-insiders.gpg
    ```

3. Add and update Microsoft Linux Repository to the system repository list.

    ```bash
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" >> /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-prod.list'
    sudo apt update
    ```


### [RHEL Production Repository](#tab/redhat-install)

Add the Microsoft repository.  

   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo dnf install -y dnf-plugins-core
   # for rhel 8/9
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/microsoft-rhel$(rpm -E %rhel).0-prod

   # for rhel10:
   sudo dnf config-manager --add-repo 
   ```
   
### [RHEL insiders-fast Repository](#tab/redhat-install-insiders-fast)

Add the Microsoft repository.  

```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo dnf install -y dnf-plugins-core
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/microsoft-rhel$(rpm -E %rhel).0-insiders-fast-prod
   
   # for rhel 8 and 9
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/microsoft-rhel

   # for rhel10:
   sudo dnf config-manager --add-repo 
```

---

## Changes

> [!WARNING]
> When upgrading from version 2.0.2 or earlier to 2.5.x, users will need to re-register and re-enroll their devices after performing a clean uninstall of the previous version.

### 2.5.2 - Feb 11, 2026 - (Preview Release in fast Insiders channel)

- (Linux) Fix smartcard dialogs layout for GTK4
- (Linux) Fix a wrong callback issue if the browser is reused.

#### Assets
- Ubuntu-24.04 - [microsoft-identity-broker_2.5.2-noble_amd64.deb ](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.5.2-noble_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_2.5.2-jammy_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.5.2-jammy_amd64.deb)
- Red Hat Enterprise Linux 10 - [microsoft-identity-broker-2.5.2-1.el10.x86_64.rpm](https://packages.microsoft.com/rhel/10/insiders-fast/Packages/m/microsoft-identity-broker-2.5.2-1.el10.x86_64.rpm) 
- Red Hat Enterprise Linux 9.0 - [microsoft-identity-broker-2.5.2-1.el9.x86_64.rpm](https://packages.microsoft.com/rhel/9.0/insiders-fast/Packages/m/microsoft-identity-broker-2.5.2-1.el9.x86_64.rpm) 
- Red Hat Enterprise Linux 8.0 - [microsoft-identity-broker-2.5.2-1.el8.x86_64.rpm](https://packages.microsoft.com/rhel/8.0/insiders-fast/Packages/m/microsoft-identity-broker-2.5.2-1.el8.x86_64.rpm)

### 2.5.1 - Jan 29, 2026 - (Preview Release in fast Insiders channel)

- (Linux) Fix smartcard dialogs layout for GTK4
- (Linux) Fix a wrong callback issue if the browser is reused.
- (Linux) Add GetDeviceState support with TLS 1.3 in CPP broker
- (Linux) Handle sem_timedwait failure due to process receiving a signal in Msai::SecureStorageLock and Msoa::SystemMutex

#### Assets

- Ubuntu-24.04 - [microsoft-identity-broker_2.5.1-noble_amd64.deb ](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.5.1-noble_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_2.5.1-jammy_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.5.1-jammy_amd64.deb)
- Red Hat Enterprise Linux 10 - [microsoft-identity-broker-2.5.1-1.el10.x86_64.rpm](https://packages.microsoft.com/rhel/10/insiders-fast/Packages/m/microsoft-identity-broker-2.5.1-1.el10.x86_64.rpm) 
- Red Hat Enterprise Linux 9.0 - [microsoft-identity-broker-2.5.1-1.el9.x86_64.rpm](https://packages.microsoft.com/rhel/9.0/insiders-fast/Packages/m/microsoft-identity-broker-2.5.1-1.el9.x86_64.rpm) 
- Red Hat Enterprise Linux 8.0 - [microsoft-identity-broker-2.5.1-1.el8.x86_64.rpm](https://packages.microsoft.com/rhel/8.0/insiders-fast/Packages/m/microsoft-identity-broker-2.5.1-1.el8.x86_64.rpm)

### 2.5.0 - Jan 13, 2026 - (Preview Release in fast Insiders channel)

- (Linux) Change package file names to include target OS
- (Linux) Misc Bug Fixes
- (Linux) Include a LICENSE file and a broker-specific CHANGELOG.md in the Linux broker package.
- (Linux) Update embedded authentication window defaults (title/size) and improve centering behavior.
- (Linux) Add support for RHEL 10
- (Linux) Add dsreg command-line tool for device registration management and diagnostics
- (Linux) Update certificates/keys location used by Linux device broker
- (Linux) Include broker version in broker-produced telemetry
- (xplat) Add DUNA xplat and DUNA iOS CBA

#### Assets

- Ubuntu-24.04 - [microsoft-identity-broker_2.5.0-noble_amd64.deb ](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.5.0-noble_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_2.5.0-jammy_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.5.0-jammy_amd64.deb)


### 2.0.3 - Oct 21, 2025 - (Preview Release in fast Insiders channel)

- Added support for the microsoft-identity-broker-diagnostics package.
- Renamed a service component from `linux_broker` to `microsoft-identity-broker` for consistency.
- Renamed a service component from `linux_devicebroker` to `microsoft-identity-device-broker` for consistency.
- Update x-client-os to use distro name

#### Assets

- Ubuntu-24.04 - [microsoft-identity-broker_2.0.3_amd64.deb](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.3_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_2.0.3_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.3_amd64.deb)

---

### 2.0.2 - Sept 19, 2025 - (Preview Release in fast Insiders channel)
Preview update to use a newly rewritten C++ broker instead of the previous Java-based broker.

- Introduces support for Phish Resistant MFA (PRMFA) on Linux devices using a SmartCard, Certificate Based Authentication (CBA), or FIDO2 key with a Personal Identity Verification (PIV) profile.
- Added a header of token requests, enabling differentiation between identity broker versions.
- When a user configures single sign-on with a new Linux device, the device performs a Microsoft Entra join instead of a Microsoft Entra registration. A join results in creating a trust with the entire device, where a registration creates a trust only within the user profile. A join trust is a prerequisite step to enable platformSSO in the future.
- Renamed the device broker service to `microsoft-identity-devicebroker`.
- There no longer is a user broker service named `microsoft-identity-broker`. The user broker is now an executable that gets invoked via dbus connection
- Device certs are moved from the Keychain to `/etc/ssl/private`. In the `private` directory, the broker creates a device cert per tenant, a session transport key per tenant, and a deviceless key that is stored in that directory. All other user data such as AT/RT are stored in the KeyChain and accessed via Microsoft Authentication Library (MSAL).

#### Assets

- Ubuntu-24.04 - [microsoft-identity-broker_2.0.2_amd64.deb](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.2_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_2.0.2_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.2_amd64.deb)


### Broker Support for MSAL Python and MSAL .NET on Linux - June 13, 2025

- As of 2.0.1, the `microsoft.identity.broker` now supports using [Using MSAL Python with an Auth Broker on Linux](/entra/msal/python/advanced/linux-broker-py) and [Using MSAL.NET with broker on Linux](/entra/msal/dotnet/acquiring-tokens/desktop-mobile/linux-dotnet-sdk) to make token requests via broker.

---

### 2.0.1 - November 18, 2024 

- Releasing package support for ubuntu 24.04

#### Assets

- Ubuntu-24.04 - [microsoft-identity-broker_2.0.1_amd64.deb](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_2.0.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb)
- Ubuntu-20.04 - [microsoft-identity-broker_2.0.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb)

---

### 2.0.0 - March 21, 2024

- Bug fixes

#### Assets

- Ubuntu-22.04 - [microsoft-identity-broker_2.0.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.0_amd64.deb)
- Ubuntu-20.04 - [microsoft-identity-broker_2.0.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.0_amd64.deb)

---

### 1.7.0 - January 31, 2024

- Addressing the 1001 on registration failure
- Updating the install scripts for Red Hat Enterprise Linux Broker
- Adding license to Linux Broker Package

---

### 1.6.1 - August 17, 2023
- [PATCH] Perform safe deserialization for X509 Certificate in Linux Broker (#2483) 

#### Assets

- Ubuntu-20.04 - [microsoft-identity-broker_1.6.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.1_amd64.deb) 
- Ubuntu-22.04 - [microsoft-identity-broker_1.6.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.1_amd64.deb)

---

### 1.6.0 - June 29, 2023

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
- Ubuntu-20.04 - [microsoft-identity-broker_1.5.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.5.1_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.5.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.5.1_amd64.deb)

---

### 1.4.1 - October 22, 2022
- Resource Owner Password Credential (ROPC) test hook.
- added logging for keyring "1001" errors.

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.4.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.1_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.4.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.1_amd64.deb)

---

### 1.4.0 - October 26, 2022
- Java 17 support
- Ubuntu 22 support

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.4.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.0_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.4.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.0_amd64.deb)

---

### 1.3.0 - October 26, 2022

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.3.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.3.0_amd64.deb)

---

### 1.2.0 - October 26, 2022

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.2.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.2.0_amd64.deb)

---

## Microsoft-Identity-Diagnostics

### 2.0.3 - October 21, 2025 - (Preview Release)

- Added support for the microsoft-identity-broker-diagnostics package.
- Rename linux_broker to microsoft-identity-broker

#### Assets

- Ubuntu-24.04 - [microsoft-identity-diagnostics_2.0.3_amd64.deb](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-diagnostics/microsoft-identity-diagnostics_2.0.3_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-diagnostics_2.0.3_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-diagnostics/microsoft-identity-diagnostics_2.0.3_amd64.deb)


#### 1.01 - November 29, 2022

#### Assets
- Ubuntu 22.04 - [microsoft-identity-diagnostics_1.1.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-diagnostics/microsoft-identity-diagnostics_1.1.0_amd64.deb)

---

#### 1.0.1 - August 07, 2022

#### Assets
- Red Hat Enterprise Linux 8.0 - [microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm](https://packages.microsoft.com/rhel/8/prod/Packages/m/microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm)

## Troubleshooting Version Issues

### Version Compatibility

**Before upgrading:**
- Check current version: `dpkg -l microsoft-identity-broker`
- Review breaking changes in the target version
- Plan for potential device re-registration

### Common Migration Issues

**Java to C++ Broker Migration (2.0.1 → 2.0.2+):**
- Symptom: Authentication failures after upgrade
- Solution: Complete uninstall and clean reinstall required
- Steps: Remove all broker state, reinstall new version, re-register device

**Package Installation Issues:**
- Verify repository configuration matches your Ubuntu/RHEL version
- Check network connectivity to packages.microsoft.com
- Ensure sufficient disk space for installation

### Getting Help

For version-specific issues:
- Check the release notes for known issues
- Verify system requirements are met
- Review logs using: `journalctl --user -u microsoft-identity-broker.service`

- Consider using the microsoft-identity-diagnostics package for detailed troubleshooting