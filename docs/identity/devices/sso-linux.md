---
title: Microsoft single sign-on for Linux
description: Overview of Microsoft single sign-on for Linux that enables Microsoft Entra ID integration and seamless authentication.
ai-usage: ai-assisted
author: ploegert
ms.author: jploegert
ms.topic: overview
ms.date: 03/31/2026
ms.custom: linux-related-content
---

# What is Microsoft single sign-on for Linux?

Microsoft single sign-on (SSO) for Linux is powered by the Microsoft Identity Broker, a software component that integrates Linux devices with Microsoft Entra ID. This solution enables users to authenticate once with their Microsoft Entra ID credentials and access multiple applications and resources without repeated authentication prompts. The feature simplifies the sign-in process for users and reduces password management overhead for administrators. 

## Features

This feature empowers users on Linux desktop clients to register their devices with Microsoft Entra ID, enroll into Intune management, and satisfy device-based Conditional Access policies when accessing their corporate resources.

- Registers Linux desktops with Microsoft Entra ID and enrolls them in Microsoft Intune.
- Enables SSO for native and web applications (for example, Azure CLI, Microsoft Edge, and Teams PWA).
- Enables SSO for apps that use MSAL for .NET or MSAL for Python.
- Supports Conditional Access policies for web apps through Microsoft Edge.
- Supports standard Microsoft Intune compliance policies.
- Supports Bash scripts for custom compliance policies.

The Teams web application and a Progressive Web App (PWA) for Linux use Conditional Access configuration applied through Microsoft Intune to enable Linux users to access Teams using Microsoft Edge.

## Prerequisites

### Supported operating systems

Microsoft single sign-on for Linux is supported on the following operating systems (physical or Hyper-V machines with x86/64 CPUs):

- Ubuntu Desktop 24.04 LTS
- Ubuntu Desktop 22.04 LTS
- Red Hat Enterprise Linux 8
- Red Hat Enterprise Linux 9

### System requirements

- Internet connectivity for package installation and Microsoft Entra ID communication
- Administrative privileges for installation
- Desktop environment ([GNOME](https://www.gnome.org/), [KDE](https://kde.org/), or similar)

### Microsoft Entra ID requirements

- Microsoft Entra ID tenant
- User accounts synchronized with or created in Microsoft Entra ID
- Appropriate licensing for conditional access policies (if applicable)

## SSO experience

The following animation shows the sign-in experience for brokered flows on Linux.

### [Password authentication](#tab/password-auth)
This animation shows password authentication on Linux.

![Animation showing the Linux sign-in experience using password authentication.](./media/sso-linux/ubuntu-auth-prmfa.gif)

### [Phish-resistant MFA](#tab/prmfa-auth)
This animation shows phish-resistant MFA (PRMFA) by using a smart card on Linux.

![Animation showing the Linux sign-in experience using phish-resistant MFA (PRMFA).](./media/sso-linux/linux-entra-login.gif)

---

> [!NOTE]
> `microsoft-identity-broker` doesn't currently support [FIPS compliance](https://www.nist.gov/standardsgov/compliance-faqs-federal-information-processing-standards-fips).


## Installation

Run the following commands in a terminal to manually install `microsoft-identity-broker` and its dependencies on your device.

### [Ubuntu](#tab/debian-install)

1. Install `curl` and `gpg`.

    ```bash
    sudo apt install curl gpg
    ```

1. Install the Microsoft package signing key.

    ```bash
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings
    rm microsoft.gpg
    ```

1. Add the Microsoft package repository and update package metadata.

    ```bash
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" >> /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-prod.list'
    sudo apt update
    ```

1. Install `microsoft-identity-broker`.

    ```bash
    sudo apt install microsoft-identity-broker
    ```

1. Restart your device.

### [RHEL 8/9 Prod](#tab/redhat89-install-prod)

1. Update your system packages.

     ```bash
    # This fixes gpg key issues
    sudo dnf update redhat-release
    
    # Update to the latest release
    sudo dnf upgrade -y
    
    ```

1. Add the Microsoft repository.

   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo dnf install -y dnf-plugins-core
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/microsoft-rhel$(rpm -E %rhel).0-prod
   ```

1. Install `microsoft-identity-broker`.

   ```bash
    sudo dnf install -y microsoft-identity-broker
   ```

1. Restart your device.



### [RHEL 10 Prod](#tab/redhat10-install-prod)

1. Update your system packages.

     ```bash
    # This fixes any gpg key issues
    sudo dnf update redhat-release
    
    # Update to the latest release
    sudo dnf upgrade -y
    
    # RHEL 10 does not ship `webkitgtk6.0` in its default repos. You must enable EPEL first:
    sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm
    ```

1. Install the Microsoft package signing keys. RHEL 10 packages are signed with a newer Microsoft GPG key (RSA-4096), different from the `microsoft.asc` key used for RHEL 8 and RHEL 9. For more information, see [Microsoft GPG Repository Signing Keys](/windows-server/identity/ad-fs/operations/gpg-signing-keys). Import both keys.
    
    ```bash
    # Legacy key (needed for Edge)
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    
    # New key for RHEL 10 packages
    sudo rpm --import https://packages.microsoft.com/rhel/10/prod/repodata/repomd.xml.key
    ```
  
1. Add the repository by creating a new repo file under `/etc/yum.repos.d/` with the following content:

    ```bash
    sudo tee /etc/yum.repos.d/microsoft-prod.repo > /dev/null <<EOF
    [microsoft-prod]
    name=Microsoft prod - RHEL 10
    baseurl=https://packages.microsoft.com/rhel/10/prod
    enabled=1
    gpgcheck=1
    gpgkey=https://packages.microsoft.com/rhel/10/prod/repodata/repomd.xml.key
    EOF
    ```

---

## Update Microsoft Identity Broker

Run the following commands to update the Microsoft Identity Broker manually.    

### [Ubuntu](#tab/debian-update)

1. Update the package repository and metadata.

    ```bash
    sudo apt update
    ```

1. Upgrade the Microsoft Identity Broker package.

    ```bash
    sudo apt upgrade microsoft-identity-broker
    ```

### [Red Hat Enterprise Linux](#tab/redhat-update)

Run one of the following commands to update the Microsoft Identity Broker.  

1. Update to the latest release, which includes the latest Microsoft Identity Broker package.
    
    ```bash
    sudo dnf update
    ```

1. Upgrade only the Microsoft Identity Broker package.
    ```bash
    sudo dnf update microsoft-identity-broker
    ```
   
---

## Uninstall Microsoft Identity Broker

Run the following commands to uninstall the Microsoft Identity Broker.

### [Ubuntu](#tab/debian-uninstall)

1. Remove the Microsoft Identity Broker from your system.

    ```bash
    sudo apt purge intune-portal microsoft-identity-broker
    ``` 

### [Red Hat Enterprise Linux](#tab/redhat-uninstall)

Run the following commands to uninstall the Microsoft Identity Broker and remove local registration data on Red Hat Enterprise Linux.    

1. Remove the Microsoft Identity Broker package.

    ```bash
    sudo dnf remove -y microsoft-identity-broker
    ```
   
1. Remove local registration data.  

    ```bash
    sudo rm -rf /var/opt/microsoft/identity-broker
    sudo rm -rf /etc/opt/microsoft/identity-broker
    sudo rm -rf /opt/microsoft/identity-broker
    ```  

---

> [!WARNING]
> Uninstalling the Microsoft Identity Broker doesn't automatically unregister your device from Microsoft Entra ID or unenroll it from Microsoft Intune. To remove the device registration, use the [`dsreg` tool](troubleshoot-device-registration-tool-linux.md) or remove the device from the Microsoft Entra admin center.

---

## Unregister a device by using dsreg

In version 2.5.x of `microsoft-identity-broker`, Microsoft introduced a utility called `dsreg` that lets you manage a device registration in Microsoft Entra ID.

To unregister your device from Microsoft Entra ID using the `dsreg` tool, run the following command in your terminal, replacing `<tenant-guid>` with your Microsoft Entra ID tenant GUID:

```bash
sudo dsreg --tenant-id <tenant-guid> --unregister
```

If your system is in a bad state and you want to clean local registration data and key material, use the `--cleanup` option with `dsreg`. This is useful when you want to remove local traces of the Microsoft Identity Broker from the device, such as when you troubleshoot or prepare the device for a new user.

To unregister and remove key material by using `dsreg`, run the following command in your terminal:

```bash
# Clean broker state including certificates (requires sudo)
sudo dsreg --cleanup
```
> [!WARNING]
> The `--cleanup` option is irreversible and removes all key material from the device. Use it with caution.

## Enable phish-resistant MFA (PRMFA) on Linux devices (preview)

Starting in version `2.0.2` of `microsoft-identity-broker`, phish-resistant MFA (PRMFA) is supported on Linux devices by using:
- SmartCard
- Certificate Based Authentication (CBA)
- USB tokens containing a PIV/Smartcard applet

Smart card integration is supported only on the following distributions:
- Ubuntu Desktop 24.04 LTS (Long Term Support)
- Ubuntu Desktop 22.04 LTS (Long Term Support)
- Red Hat Enterprise Linux 10 (Long Term Support)

For certificate-based authentication (CBA), use a public key infrastructure (PKI) solution that issues user certificates to Linux devices. You then configure your distribution to trust and use those certificates for authentication.

### Smart Card Authentication

Smart card authentication extends certificate-based methods by introducing a physical token that stores user certificates. When the card is inserted into a reader, the system retrieves the certificates and performs validation.

To configure smart card support, set up the libraries and modules your distribution requires. For more information, see your distribution documentation:
- [Ubuntu SmartCard configuration](https://documentation.ubuntu.com/server/how-to/security/smart-card-authentication/)
- [Red Hat Enterprise Linux SmartCard configuration](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_smart_card_authentication/index)
- [YubiKey SmartCard configuration](https://developers.yubico.com/pam-u2f/)
- [OpenSC SmartCard configuration](https://github.com/OpenSC/OpenSC/wiki)
- [PKCS#11 configuration reference](https://p11-glue.github.io/p11-glue/p11-kit/manual/pkcs11-conf.html)

### Example smart card configuration

The following steps show an example configuration by using the YubiKey/Edge bridge integration. Your configuration might vary based on your smart card provider. For provider-specific steps, see your provider documentation.

### [Ubuntu](#tab/debian-sc-example)

1. Install smart card drivers and YubiKey support:

    ```bash
    sudo apt install pcscd yubikey-manager
    ```

1. Install YubiKey/Edge bridge components:

    ```bash
    sudo apt install opensc libnss3-tools openssl
    ```

1. Configure a Network Security Service (NSS) database for the current user:

    ```bash
    mkdir -p $HOME/.pki/nssdb
    chmod 700 $HOME/.pki
    chmod 700 $HOME/.pki/nssdb
    modutil -force -create -dbdir sql:$HOME/.pki/nssdb
    modutil -force -dbdir sql:$HOME/.pki/nssdb -add 'SC Module' -libfile /usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so
    ```

### [RHEL 10](#tab/rhel-sc-example)

1. Install smart card driver support. Most of these packages are likely already installed as dependencies of `microsoft-identity-broker`. If they aren't installed, run the following command:

    ```bash
    sudo dnf install -y pcsc-lite pcsc-lite-libs opensc nss-tools p11-kit p11-kit-devel
    ```

1. Enable the `pcscd` service to read smart cards from the reader, and initialize an NSS database for the current user:

    ```bash
    sudo systemctl enable --now pcscd
    
    mkdir -p $HOME/.pki/nssdb
    certutil -d sql:$HOME/.pki/nssdb -N --empty-password
    ```

---


## Related content

For more information, see the following Intune documentation:

- [What's new in Microsoft single sign-on for Linux](whats-new-linux.md).
- [Troubleshoot device registration on Linux using dsreg](troubleshoot-device-registration-tool-linux.md).
- [Deployment guide: Manage Linux devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-platform-linux).
- [Enrollment guide: Enroll Linux desktop devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-enrollment-linux).

