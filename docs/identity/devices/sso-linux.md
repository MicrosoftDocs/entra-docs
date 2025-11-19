---
title: Microsoft Single Sign-On for Linux
description: Overview of Single Sign-On for Linux that enables Microsoft Entra ID integration and seamless authentication.
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.topic: overview
ms.date:     05/16/2025
ms.subservice: devices
---

# What is Microsoft Single Sign-On for Linux?

Microsoft Single Sign-On (SSO) for Linux is powered by the Microsoft Identity Broker, a software component that integrates Linux devices with Microsoft Entra ID. This solution enables users to authenticate once with their Microsoft Entra ID credentials and access multiple applications and resources without repeated authentication prompts. The feature simplifies the sign-in process for users and reduces password management overhead for administrators. 

## Features

This feature empowers users on Linux desktop clients to register their devices with Microsoft Entra ID, enroll into Intune management, and satisfy device-based Conditional Access policies when accessing their corporate resources.

- Provides Microsoft Entra ID registration & enrollment of Linux desktops
- Provides SSO capabilities for native & web applications (ex: Azure CLI, Microsoft Edge Browser, Teams PWA, etc.) to access M365/Azure protected resources
- Provides SSO for Microsoft Entra accounts across all applications that utilize MSAL.NET or MSAL.python - enabling customers to use Microsoft Authentication Library (MSAL) to integrate SSO into custom apps.
- Enables Conditional Access policies protecting web applications via Microsoft Edge
- Enables Standard compliance policies
- Enables support for Bash scripts for custom compliance policies

The Teams web application and a new PWA (Progressive Web App) for Linux uses the Conditional Access configuration, applied through Microsoft Intune Manager, to enable Linux users to access the Teams web application using Microsoft Edge in a secure way. This capability helps organizations use an industry-leading, unified endpoint management solution for Teams from Linux endpoints with security and quality in mind.

## Prerequisites

### Supported Operating Systems

Microsoft Single Sign-On for Linux is supported on the following operating systems (physical or Hyper-V machines with x86/64 CPUs):

- Ubuntu Desktop 24.04 LTS
- Ubuntu Desktop 22.04 LTS  
- Red Hat Enterprise Linux 8
- Red Hat Enterprise Linux 9

### System Requirements

- Internet connectivity for package installation and Microsoft Entra ID communication
- Administrative privileges for installation
- Desktop environment (GNOME, KDE, or similar)

### Microsoft Entra ID Requirements

- Microsoft Entra ID tenant
- User accounts synchronized with or created in Microsoft Entra ID
- Appropriate licensing for conditional access policies (if applicable)



## SSO experience

This video demonstrates the sign-in experience on brokered flows on Linux

![Demo of the Linux Login component component](./media/sso-linux/linux-entra-login.gif)

> [!NOTE]
> The microsoft.identity.broker version 2.0.1 and earlier versions do not currently support [FIPS compliance](https://www.nist.gov/standardsgov/compliance-faqs-federal-information-processing-standards-fips).

## Deployment

### Installation

Run the following commands in a command line to manually install the Microsoft single sign-on (microsoft-identity-broker) and its dependencies on your device.  

#### [Ubuntu](#tab/debian-install)

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

4. Install the Microsoft Single Sign-on (microsoft-identity-broker) app.

    ```bash
    sudo apt install microsoft-identity-broker
    ```

5. Reboot your device.  

#### [Red Hat Enterprise Linux](#tab/redhat-install)

1. Add the Microsoft repository.  

   ```bash
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/microsoft-rhel9.0-prod
   ```

1. Install the Microsoft Single Sign-on (microsoft-identity-broker) app.  

   ```bash
   sudo dnf install microsoft-identity-broker
   ```
   
3. Reboot your device.  

---

### Update Microsoft Identity Broker

Run the following commands to update the Microsoft Identity Broker manually.    

#### [Ubuntu](#tab/debian-update)

1. Update the package repository and metadata.   

    ```bash
    sudo apt update
    ```

2. Upgrade the Microsoft Identity Broker package.  

    ```bash
    sudo apt upgrade microsoft-identity-broker
    ```

#### [Red Hat Enterprise Linux](#tab/redhat-update)

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

### Uninstall Microsoft Identity Broker

Run the following commands to uninstall the Microsoft Identity Broker and remove local registration data.

#### [Ubuntu](#tab/debian-uninstall)

1. Remove the Microsoft Identity Broker from your system.  

    ```bash
    sudo apt remove microsoft-identity-broker
    ```
    
2. Remove the local registration data. This command removes the local configuration data that contains your device registration.     

    ```bash
    sudo apt purge intune-portal
  sudo apt purge microsoft-identity-broker
    ``` 

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

### Enabling Phish-Resistant MFA (PRMFA) on Linux devices (Preview)

Starting with version `2.0.2` of the microsoft-identity-broker, Phish-Resistant MFA (PRMFA) is supported on Linux devices using:
- SmartCard
- Certificate Based Authentication (CBA)
- FIDO2 key with a PIV profile (certificate on a FIDO device)

This feature is in private preview and requires additional configuration steps to enable support for SmartCard/CBA on Linux devices.

> [!NOTE]
> The insiders-fast channel is only available for `microsoft-identity-broker` version `2.0.2` and above. 

To install the insiders-fast channel of the microsoft-identity-broker:

```bash
# Install the insiders-fast package
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod insiders-fast main" >> /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-insiders-fast.list'
```


#### SmartCard Configuration

To configure SmartCard services, create a PKCS#11 configuration file:

1. Create the PKCS#11 configuration directory:
   ```bash
   sudo mkdir -p /etc/pkcs11/modules
   ```

2. Create the YubiKey module configuration:
   ```bash
   sudo tee /etc/pkcs11/modules/ykcs11.module > /dev/null <<EOF
   # YubiKey PKCS#11 module
   # Reference: https://p11-glue.github.io/p11-glue/p11-kit/manual/pkcs11-conf.html
   module: /usr/lib/x86_64-linux-gnu/libykcs11.so
   EOF
   ```

#### YubiKey Configuration

The following steps configure YubiKey/Edge bridge integration:

1. Install Smart Card drivers and YubiKey support:
   ```bash
   sudo apt install pcscd yubikey-manager
   ```

2. Install YubiKey/Edge Bridge components:
   ```bash
   sudo apt install opensc libnss3-tools openssl
   ```

3. Configure NSS database for the current user:
   ```bash
   mkdir -p $HOME/.pki/nssdb
   chmod 700 $HOME/.pki
   chmod 700 $HOME/.pki/nssdb
   modutil -force -create -dbdir sql:$HOME/.pki/nssdb
   modutil -force -dbdir sql:$HOME/.pki/nssdb -add 'SC Module' -libfile /usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so
   ```

## Troubleshooting & Reporting Issues

### Common Issues

**Authentication failures:**
- Verify network connectivity to Microsoft Entra ID endpoints
- Check system time synchronization
- Ensure the device is properly registered

**Service not starting:**
- Check service status: `systemctl --user status microsoft-identity-broker.service`
- Restart the service: `systemctl --user restart microsoft-identity-broker.service`
- Review system logs for error messages

### Logging

| Item           | Command|
| -------------- | --------------- |
| **All Logs**   | `journalctl --since "10 minutes ago" > logs_last_10_min.txt`                                                                               |
| **Identity Broker** | `journalctl --user -f -u microsoft-identity-broker.service`                                    |
| **JavaBroker** | `journalctl --user -f -u microsoft-identity-broker.service`  <br>`sudo journalctl --system -f -u microsoft-identity-device-broker.service` |
| **New Broker** | `journalctl --user -f -u microsoft-identity-broker.service`                                                                                |
| **DBUS Logs**  | `busctl --user monitor com.microsoft.identity.broker1`                                                                                     |

## Services

| Services:                    | Command                                                          |
| ---------------------------- | ---------------------------------------------------------------- |
| List all running services:   | `systemctl --type=service --state=running`                      |
| Restart Identity Broker:     | `sudo systemctl --user restart microsoft-identity-broker.service` |
| Get Identity Broker status:  | `systemctl --user status microsoft-identity-broker.service`     |


# List installed versions

To list the package versions currently installed, run: ([Reference](https://stackoverflow.microsoft.com/questions/289246))

```
apt list -a intune-portal microsoft-edge-dev microsoft-identity-broker azure-cli
#or
sudo dpkg -l microsoft-identity-broker intune-portal microsoft-edge-stable
```

### Configuration Verification

To verify your installation and configuration:

1. Check if the identity broker is running:
   ```bash
   systemctl --user is-active microsoft-identity-broker.service
   ```

2. Test authentication with Azure CLI (requires Azure CLI to be installed)  (note you could use any other brokered application)
   ```bash
   az login
   ```

3. Verify device registration status:
   ```bash
   /opt/microsoft/identity-broker/bin/identity-broker status
   ```

### Debug Mode

To run the identity broker with debug logging:

```bash
cd /opt/microsoft/identity-broker/bin
DEBUG=1 ./identity-broker
```

## Related Content

For more information, see the following Intune documentation:

- [Deployment guide: Manage Linux devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-platform-linux)

- [Enrollment guide: Enroll Linux desktop devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-enrollment-linux).
