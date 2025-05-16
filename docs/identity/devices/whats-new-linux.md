---
# Required metadata
# For more information, see https://learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata
# For valid values of ms.service, ms.prod, and ms.topic, see https://learn.microsoft.com/en-us/help/platform/metadata-taxonomies

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     05/09/2025
---

# What's new in Microsoft Single Sign-on for Linux
This article provides information about the latest updates to Microsoft Single Sign-on for Linux. 

### Package Repositories
Microsoft uses the following package repositories to distribute the Microsoft Identity Broker and Microsoft Identity Diagnostics for Linux. Packages are avilable in either .deb or .rpm format, however only Ubuntu LTS & Red Hat Enterprise Linux are supported today.


#### [Ubuntu20.04](#tab/ubuntu2004)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/msft-identity-broker/)

---

#### [Ubuntu22.04](#tab/ubuntu2204)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-diagnostics/)

---

#### [Ubuntu24.04](tab/ubuntu2404)
- [microsoft-identity-broker](https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker)

---

#### [RedHat 9](#tab/redhat9)
- [microsoft-identity-broker](https://packages.microsoft.com/rhel/9/prod/Packages/m/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/rhel/9/prod/Packages/m/)

---

#### [RedHat 8](#tab/redhat8)
- [microsoft-identity-broker](https://packages.microsoft.com/rhel/8/prod/Packages/m/)
- [microsoft-identity-diagnostics](https://packages.microsoft.com/rhel/8/prod/Packages/m/)

---

## Microsoft-Identity-Broker

### 2.0.1 - 18-Nov-2024 
- Releasing package support for ubuntu 24.04

### 2.0.1 - 21-Mar-2024
- Bug fixes

### 1.7.0 - 31-Jan-2024
- Addressing the 1001 on registration failure
- Updating the install scripts for RHEL Linux Broker
- Adding license to Linux Broker Package


### 1.6.1 - 17-Aug-2023
- [PATCH] Perform safe deserialization for X509 Certificate in Linux Broker (#2483) 

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.6.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.1_amd64.deb) 
- Ubuntu-22.04 - [microsoft-identity-broker_1.6.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.1_amd64.deb)

---

### 1.6.0 - 29-Jun-2023
- RHEL 8 and RHEL 9 release

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.6.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.0_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.6.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.6.0_amd64.deb)
- Red Hat Enterprise Linux 9.0 - [microsoft-identity-broker-1.6.0-1.x86_64.rpm](https://packages.microsoft.com/rhel/9/prod/Packages/m/microsoft-identity-broker-1.6.0-1.x86_64.rpm) 
- Red Hat Enterprise Linux 8.0 - [microsoft-identity-broker-1.6.0-1.x86_64.rpm](https://packages.microsoft.com/rhel/8/prod/Packages/m/microsoft-identity-broker-1.6.0-1.x86_64.rpm)

---

### 1.5.1 - 09-May-2023
- update serialization library
- Excluded the memory consumption change
- Secret service version upgrade - kubuntu

#### Assets
- Ubuntu-20.04 -[microsoft-identity-broker_1.5.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.5.1_amd64.deb)
- Ubuntu-22.04 -[microsoft-identity-broker_1.5.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.5.1_amd64.deb)

---

### 1.4.1 - 27-Oct-2022
- ROPC test hook
- Keyring 1001 telemetry

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.4.1_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.1_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.4.1_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.1_amd64.deb)

---

### 1.4.0 - 26-Oct-2022
- Java 17 support
- Ubuntu 22 support

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.4.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.0_amd64.deb)
- Ubuntu-22.04 - [microsoft-identity-broker_1.4.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.4.0_amd64.deb)

---

### 1.3.0 - 26-Oct-2022

#### Assets
- Ubuntu-20.04 -[microsoft-identity-broker_1.3.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.3.0_amd64.deb)

---

### 1.2.0 - 26-Oct-2022

#### Assets
- Ubuntu-20.04 - [microsoft-identity-broker_1.2.0_amd64.deb](https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_1.2.0_amd64.deb)

---

## Microsoft-Identity-Diagnostics

#### 1.01 - 29-Nov-2022

#### Assets
- Ubuntu 22.04 - [microsoft-identity-diagnostics_1.1.0_amd64.deb](https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-diagnostics/microsoft-identity-diagnostics_1.1.0_amd64.deb)

---

#### 1.0.1 - 07-Aug-2023

#### Assets
- Red Hat Enterprise Linux 9.0 - [microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm](https://packages.microsoft.com/rhel/9/prod/Packages/m/microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm)

- Red Hat Enterprise Linux 8.0 - [microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm](https://packages.microsoft.com/rhel/8/prod/Packages/m/microsoft-identity-diagnostics-1.0.1-1.x86_64.rpm)

