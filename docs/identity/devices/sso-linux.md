---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title: Microsoft Single Sign-on for Linux
description: Overview of Single Sign-on for Linux for Microsoft Entra ID registered devices.
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.topic: overview
ms.date:     03/18/2025
ms.subservice: devices
---

# Microsoft Single Sign-on to Linux


Microsoft Single Sign-on for Linux is powered by a component that can be installed onto a Linux device that integrates with Microsoft Entra Id to enable users to use their Microsoft Entra ID credentials to login to other apps without being prompted for credentials each time a resource is accessed. This feature provides benefits for admins by simplifying the sign-in process for users and reducing the number of passwords they need to remember. 

## Features

This feature empowers users on Linux desktop clients to register their devices with Entra Id, enroll into Intune management, and satisfy device-based conditional access policies when accessing their corporate resources.

- Azure AD registration & enrollment of Linux desktops

- Provide SSO capabilities for native & web applications (ex: Azure CLI, Edge Browser, Teams PWA, etc) to access M365/Azure protected resources

- It provides SSO for Microsoft Entra accounts across all applications that utilize MSAL.net or MSAL.python - enabling customers to leverage MSAL to integrate SSO into custom apps.

- Conditional Access policies protecting web applications via Microsoft Edge

- Standard compliance policies

- Support for Bash scripts for custom compliance policies

The Teams web application and a new PWA(Progressive Web App) for Linux will use the Conditional Access configuration, applied through Microsoft Intune Manager, to enable Linux users to access the Teams web application using Edge in a secure way. This helps organizations use an industry-leading, unified endpoint management solution for Teams from Linux endpoints with security and quality in mind.

There are several authentication methods that determine the end-user experience.

* **Password as authentication method**: Syncs the user’s Microsoft Entra ID password with the local account and enables SSO across apps that use Microsoft Entra ID for authentication.

## Requirements

The Microsoft Single Sign-On for Linux is supported with the following operating systems:  
- Ubuntu Desktop 24.04, 22.04 or 20.04 LTS (physical or Hyper-V machine with x86/64 CPUs)  
 - RedHat Enterprise Linux 8  
 - RedHat Enterprise Linux 9

## Configuration

You can find more information and instructions on how to configure in these articles:
- [Configure Platform SSO for macOS devices in Microsoft Intune](/mem/intune/configuration/platform-sso-macos)

## Deployment

### Installation

To install the Linux broker without a dependency on Intune, you can install the broker with the following:
Run the following commands in a command line to manually install the Microsoft Single Sign-On (microsoft-identity-broker) and its dependencies on your device.  

#### [ubuntu](#tab/debian-install)

1. Install Curl. 

```bash
sudo apt install curl gpg
```

2. Install the Microsoft package signing key.  

```bash
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg     sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/     rm microsoft.gpg
```

3. Add and update Microsoft Linux Repository to the system repository list.

```bash
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" >> /etc/apt/sources.list.d/microsoft-ubuntu-$(lsb_release -cs)-prod.list'
sudo apt update
```

4. Install the Microsoft Single Sign-on (microsoft-identity-broker) app.

```bash
sudo apt install Microsoft-identity-broker
```

5. Reboot your device.  

#### [redhat](#tab/redhat-install)

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

For more information, see the following in Intune documentation:

- [Deployment guide: Manage Linux devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-platform-linux)

- [Enrollment guide: Enroll Linux desktop devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-enrollment-linux).


### Update app for Ubuntu Desktop 

Run the following commands to update the app manually.    

#### [ubuntu](#tab/debian-update)

1. Update the package repo and metadata, which includes `intune-portal`, `msft-broker`, and `msft edge`.   

    ```bash
    sudo apt update
    ```

2. Upgrade the packages and clean up dependencies.  

    ```bash
    sudo apt-get dist-upgrade
    ```

#### [redhat](#tab/redhat-update)

Run one of the following commands to update the Microsoft Intune app.  

**Option 1**:  

   ```bash
   sudo dnf update
   ```

**Option 2**: 
   ```bash
   sudo dnf update microsoft-identity-broker
   ```
   
---

## Uninstall app for Ubuntu Desktop

Run the following commands to uninstall the Microsoft Intune app and remove local registration data from devices running Ubuntu Desktop.  

#### [ubuntu](#tab/debian-uninstall)

1. Remove the Intune app from your system.  

    ```bash
   sudo apt remove microsoft-identity-broker
    ```
    
2. Remove the local registration data. This command removes the local configuration data that contains your device registration.     

    ```bash
    sudo apt purge intune-portal
    ``` 

#### [redhat](#tab/redhat-uninstall)

Run the following commands to uninstall the Microsoft Intune app and remove local registration data on devices running RedHat Enterprise Linux.    

1. Remove the Intune portal package.  

   ```bash
   sudo dnf remove intune-portal
   ```
   
2. Remove local registration data.  

   ```bash
   sudo rm -rf /var/opt/microsoft/mdatp
   sudo rm -rf /etc/opt/microsoft/mdatp
   sudo rm -rf /opt/microsoft/mdatp
   ```  

---

## Troubleshooting 

If you experience issues when implementing macOS Platform SSO, refer to our documentation on [macOS Platform single sign-on known issues and troubleshooting](troubleshoot-macos-platform-single-sign-on-extension.md)
