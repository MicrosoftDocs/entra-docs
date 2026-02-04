---
title: Microsoft single sign-on for Linux
description: Overview of Microsoft single sign-on for Linux that enables Microsoft Entra ID integration and seamless authentication.
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.topic: overview
ms.date:     05/16/2025
ms.subservice: devices
ms.custom: linux-related-content
---

# What is Microsoft single sign-on for Linux?

Microsoft single sign-on (SSO) for Linux is powered by the Microsoft Identity Broker, a software component that integrates Linux devices with Microsoft Entra ID. This solution enables users to authenticate once with their Microsoft Entra ID credentials and access multiple applications and resources without repeated authentication prompts. The feature simplifies the sign-in process for users and reduces password management overhead for administrators. 

## Features

This feature empowers users on Linux desktop clients to register their devices with Microsoft Entra ID, enroll into Intune management, and satisfy device-based Conditional Access policies when accessing their corporate resources.

- Provides Microsoft Entra ID registration & enrollment of Linux desktops
- Provides SSO capabilities for native and web applications (for example, Azure CLI, Microsoft Edge, Teams PWA) to access Microsoft 365 and Azure protected resources
- Provides SSO for Microsoft Entra accounts across applications that use MSAL for .NET or MSAL for Python, enabling customers to use Microsoft Authentication Library (MSAL) to integrate SSO into custom apps
- Enables Conditional Access policies protecting web applications via Microsoft Edge
- Enables standard Intune compliance policies
- Enables support for Bash scripts for custom compliance policies

The Teams web application and a Progressive Web App (PWA) for Linux use Conditional Access configuration applied through Microsoft Intune to enable Linux users to access Teams using Microsoft Edge.

## Prerequisites

### Supported Operating Systems

Microsoft single sign-on for Linux is supported on the following operating systems (physical or Hyper-V machines with x86/64 CPUs):

- Ubuntu Desktop 24.04 LTS (Long Term Support)
- Ubuntu Desktop 22.04 LTS (Long Term Support) 
- Red Hat Enterprise Linux 8 (Long Term Support)
- Red Hat Enterprise Linux 9 (Long Term Support)

### System Requirements

- Internet connectivity for package installation and Microsoft Entra ID communication
- Administrative privileges for installation
- Desktop environment ([GNOME](https://www.gnome.org/), [KDE](https://kde.org/), or similar)

### Microsoft Entra ID Requirements

- Microsoft Entra ID tenant
- User accounts synchronized with or created in Microsoft Entra ID
- Appropriate licensing for conditional access policies (if applicable)

## SSO experience

The following animation shows the sign-in experience for brokered flows on Linux.

![Demo of the Linux sign-in experience](./media/sso-linux/linux-entra-login.gif)

> [!NOTE]
> microsoft-identity-broker version 2.0.1 and earlier versions doesn't currently support [FIPS compliance](https://www.nist.gov/standardsgov/compliance-faqs-federal-information-processing-standards-fips).


## Installation

Run the following commands in a command line to manually install the Microsoft single sign-on (microsoft-identity-broker) and its dependencies on your device.  

### [Ubuntu](#tab/debian-install)

1. Install Curl. 

    ```bash
    sudo apt install curl gpg
    ```

2. Install the Microsoft package signing key.  

    ```bash
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings
    rm microsoft.gpg
    ```

3. Add and update Microsoft Linux Repository to the system repository list.

    ```bash
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" >> /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-prod.list'
    sudo apt update
    ```

4. Install the Microsoft single sign-on (microsoft-identity-broker) app.

    ```bash
    sudo apt install microsoft-identity-broker
    ```

5. Reboot your device.  

### [Red Hat Enterprise Linux](#tab/redhat-install)

1. Add the Microsoft repository.  

   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo dnf install -y dnf-plugins-core
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/microsoft-rhel$(rpm -E %rhel).0-prod
   ```

1. Install the Microsoft single sign-on (microsoft-identity-broker) app.  

   ```bash
   sudo dnf install microsoft-identity-broker
   ```
   
3. Reboot your device.  

---

## Update Microsoft Identity Broker

Run the following commands to update the Microsoft Identity Broker manually.    

### [Ubuntu](#tab/debian-update)

1. Update the package repository and metadata.   

    ```bash
    sudo apt update
    ```

2. Upgrade the Microsoft Identity Broker package.  

    ```bash
    sudo apt upgrade microsoft-identity-broker
    ```

### [Red Hat Enterprise Linux](#tab/redhat-update)

Run one of the following commands to update the Microsoft Identity Broker.  

**Option 1**:  

```bash
sudo dnf update
```

**Option 2**: 
```bash
sudo dnf update microsoft-identity-broker
```
   
---

## Uninstall Microsoft Identity Broker

Run the following commands to uninstall the Microsoft Identity Broker and remove local registration data.

### [Ubuntu](#tab/debian-uninstall)

1. Remove the Microsoft Identity Broker from your system.  

    ```bash
    sudo apt remove microsoft-identity-broker
    ```
    
2. Remove the local registration data. This command removes the local configuration data that contains your device registration.     

    ```bash
    sudo apt purge intune-portal
    sudo apt purge microsoft-identity-broker
    ``` 

### [Red Hat Enterprise Linux](#tab/redhat-uninstall)

Run the following commands to uninstall the Microsoft Identity Broker and remove local registration data on Red Hat Enterprise Linux.    

1. Remove the Microsoft Identity Broker package.  

    ```bash
    sudo dnf remove microsoft-identity-broker
    ```
   
2. Remove local registration data.  

    ```bash
    sudo rm -rf /var/opt/microsoft/identity-broker
    sudo rm -rf /etc/opt/microsoft/identity-broker
    sudo rm -rf /opt/microsoft/identity-broker
    ```  

---

## Enabling Phish-Resistant MFA (PRMFA) on Linux devices (Preview)

Beginning with version `2.0.2` of the microsoft-identity-broker, Phish-Resistant MFA (PRMFA) is supported on Linux devices using:
- SmartCard
- Certificate Based Authentication (CBA)
- FIDO2 key with a PIV (Personal Identity Verification) profile (certificate on a FIDO device)

This feature is in preview and requires extra configuration steps to enable support for SmartCard/CBA on Linux devices.

> [!NOTE]
> The insiders-fast channel is only available for `microsoft-identity-broker` version `2.0.2` and greater. 

To install the insiders-fast channel of the microsoft-identity-broker:

```bash
# Enable the insiders-fast repo
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod insiders-fast main" >> /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-insiders-fast.list'

sudo apt update

# Install or upgrade microsoft-identity-broker from the enabled repo
sudo apt install microsoft-identity-broker
```

### Smart Card Authentication
Smart card authentication extends certificate-based methods by introducing a physical token that stores user certificates. When the card is inserted into a reader, the system retrieves the certificates and performs validation.

Configuring SmartCard support involves setting up the necessary libraries and modules to enable certificate-based authentication using physical tokens. There are various SmartCard solutions available, such as YubiKey, which can be integrated with various Linux distributions. For instructions on the two supported platforms, refer to the distribution documentation:
- [Ubuntu SmartCard configuration](https://documentation.ubuntu.com/server/how-to/security/smart-card-authentication/)
- [Red Hat Enterprise Linux SmartCard configuration](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_smart_card_authentication/index)
- [YubiKey SmartCard configuration](https://developers.yubico.com/pam-u2f/)
- [OpenSC SmartCard configuration](https://github.com/OpenSC/OpenSC/wiki)
- [PKCS#11 configuration reference](https://p11-glue.github.io/p11-glue/p11-kit/manual/pkcs11-conf.html)

### Example Smart Card configuration

The following steps configure a reference example of using the YubiKey/Edge bridge integration, but other smart card providers can be configured similarly.  

1. Install Smart Card drivers and YubiKey support:

    ```bash
    sudo apt install pcscd yubikey-manager
    ```

2. Install YubiKey/Edge Bridge components:

    ```bash
    sudo apt install opensc libnss3-tools openssl
    ```

3. Configure Network Security Service (NSS) database for the current user:

    ```bash
    mkdir -p $HOME/.pki/nssdb
    chmod 700 $HOME/.pki
    chmod 700 $HOME/.pki/nssdb
    modutil -force -create -dbdir sql:$HOME/.pki/nssdb
    modutil -force -dbdir sql:$HOME/.pki/nssdb -add 'SC Module' -libfile /usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so
    ```

### Certificate-Based Authentication
Certificate-based client authentication is implemented through the Secure Sockets Layer (TLS/SSL) protocol. In this process, the client signs a randomly generated data block with its private key, then transmits both the certificate and the signed data to the server. The server checks the signature and validates the certificate before granting access.

The easiest way to configure Certificate-Based Authentication (CBA) is to use a Private Key Infrastructure (PKI) solution that issues user certificates to Linux devices. These certificates can then be used for authentication against Microsoft Entra ID. To configure Linux to accept these certificates for authentication, you typically need to set up the appropriate certificate stores and ensure that the system's authentication mechanisms are configured to use these certificates. 

---


## Related Content

For more information, see the following Intune documentation:

- [What's new in Microsoft single sign-on for Linux](whats-new-linux.md).
- [Troubleshoot device registration on Linux using dsregcmd](troubleshoot-device-registration-tool-linux.md).
- [Deployment guide: Manage Linux devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-platform-linux).
- [Enrollment guide: Enroll Linux desktop devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-enrollment-linux).

