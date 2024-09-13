---
title: Sign in with MFA to a Linux virtual machine in Azure by using Microsoft Entra ID
description: Learn how to sign in to an Azure VM that's running Linux by using Microsoft Entra ID and MFA authentication.

ms.service: entra-id
ms.subservice: devices
ms.topic: how-to
ms.date: 05/09/2024

ms.author: dmulder
author: dmulder
ms.custom: references_regions, devx-track-azurecli, subject-rbac-steps, devx-track-linux
---

# Sign in to a Linux virtual machine in Azure by using MFA with Microsoft Entra ID

To improve the security of Linux virtual machines (VMs) in Azure, you can integrate with Microsoft Entra ID authentication.

This article shows you how to configure a Linux VM and log in with Microsoft Entra ID.

## Required Prerequisites

Before you proceed with configuring a Linux virtual machine, ensure that the following prerequisites are met:

### Supported Linux Distribution

The following Linux distributions are currently supported for Entra ID authentication:

| Distribution | Version |
| --- | --- |
| openSUSE | openSUSE Tumbleweed |

The following Linux distributions have experimental packages available, but are not currently supported:

| Distribution | Version |
| --- | --- |
| openSUSE | [openSUSE Leap 15.4+](https://software.opensuse.org/package/himmelblau) |
| SUSE Linux Enterprise | [15 SP4+](https://software.opensuse.org/package/himmelblau) |

### Azure Entra ID Himmelblau Connector for Linux

Install the Himmelblau package on your Linux host. This package provides the necessary tools and utilities to enable authentication with Azure Entra ID. Ensure that you have the latest version of Himmelblau installed to benefit from the latest features and security enhancements.You can install the Himmelblau package using your distribution's package manager.

On openSUSE Tumbleweed, refresh the repos and install himmelblau:

```shell
sudo zypper ref && sudo zypper in himmelblau nss-himmelblau pam-himmelblau
```

On openSUSE Leap and SUSE Linux Enterprise, add the experimental repo and install himmelblau:

```shell
# For Leap 15.6 or SUSE Linux Enterprise 15 SP6:
sudo zypper ar https://download.opensuse.org/repositories/network:/idm/15.6/network:idm.repo
# For Leap 15.5 or SUSE Linux Enterprise 15 SP5:
sudo zypper ar https://download.opensuse.org/repositories/network:/idm/15.5/network:idm.repo
# For Leap 15.4 or SUSE Linux Enterprise 15 SP4:
sudo zypper ar https://download.opensuse.org/repositories/network:/idm/15.4/network:idm.repo
```

Then refresh the repos and install himmelblau:

```shell
sudo zypper ref && sudo zypper in himmelblau nss-himmelblau pam-himmelblau
```

## Configure Azure Entra ID Himmelblau Connector for Linux

To enable authentication, it is imperative to configure the `domains` and `pam_allow_groups` options in the `/etc/himmelblau/himmelblau.conf` file. These settings determine which domains and users or groups are granted access to the host.

```ini
[global]
domains = contoso.onmicrosoft.com
pam_allow_groups = tux@contoso.onmicrosoft.com,admin@contoso.onmicrosoft.com
```

If you enter Azure groups in this list, you must specify them using the Object ID of the group, rather than the upn.

```ini
[global]
pam_allow_groups = fe0da60a-d037-42df-b0ba-ff6844461756
```

If the host is public facing, such as exposing the SSH port to the web, it is **highly recommended** that Windows Hello enrollment be disabled also. To disable Windows Hello, set the `/etc/himmelblau/himmelblau.conf` option `enable_hello` to `false`.

```ini
[global]
enable_hello = false
```

> [!WARNING]
> Leaving Hello enrollment enabled on a public facing host could permit the possiblity of a brute force attack against a user's Hello PIN. Alternatively, you could configure the `pam_tally2.so` PAM module to mitigate the risk of a brute force attack.

Enable and start the `himmelblaud` and `himmelblaud-tasks` daemons. The `himmelblaud` daemon communicates with Entra ID and facilitates device enrollment. The `himmelblaud-tasks` daemon is responsible for authenticated tasks, such as creating the users home directory.

```bash
systemctl enable himmelblaud himmelblaud-tasks
systemctl start himmelblaud himmelblaud-tasks
```

It is recommended that the Name Service Cache daemon (`nscd`) be disabled.

The nscd daemon caches name service lookups, including user and group information obtained from sources like `/etc/passwd` and `/etc/group`. When integrating with Azure Entra ID, it's important to ensure that the most up-to-date user and group information is consistently retrieved from the directory. Disabling nscd helps avoid potential inconsistencies that may arise from cached data not reflecting changes made in Azure Entra ID.

```bash
systemctl stop nscd
systemctl disable nscd
systemctl mask nscd
```

Configuring NSS (Name Service Switch) is essential in the context of integrating Linux hosts with Azure Entra ID using Himmelblau. By configuring NSS to include `himmelblau` alongside traditional sources like `compat`, `systemd`, etc., the Linux system knows to query Azure Entra ID for user and group information. This ensures that user authentication and authorization requests are directed to Azure Entra ID, allowing users to log in with their Azure Entra ID credentials and access resources based on their assigned permissions.

The NSS configuration file is found at `/etc/nsswitch.conf`. The `himmelblau` NSS module name should be appened to the `passwd`, `group` and `shadow` entries.

```conf
passwd:     compat systemd himmelblau
group:      compat systemd himmelblau
shadow:     compat systemd himmelblau
```

Configuring PAM (Pluggable Authentication Modules) for Himmelblau is crucial in the integration of Linux hosts with Azure Entra ID.

PAM enables flexible authentication mechanisms by allowing administrators to define authentication policies through modular components. Configuring PAM for Azure Entra ID integration ensures that users can authenticate using their Azure Entra ID credentials. By configuring PAM to include the Himmelblau module, authentication requests are directed to Azure Entra ID, providing a centralized authentication mechanism.

To configure Himmelblau for PAM on openSUSE Tumbleweed, simply use pam-config:

```bash
pam-config --add --himmelblau
```

Check the pam files afterward to ensure the configuration was successful.

Otherwise configure pam manually:

In `/etc/pam.d/common-auth`, ensure that the `pam_himmelblau.so` module is placed after other authentication methods (such as `pam_unix.so`). Ensure that other authentication modules are not set to `required`, as this could cause authentication to fail prior to PAM communicating with Entra ID. Include the `ignore_unknown_user` option for Himmelblau. Ensure `pam_deny.so` is placed after all modules, so that unknown users are not implicitly allowed.

```pam
auth        required      pam_env.so
auth        [default=1 ignore=ignore success=ok] pam_localuser.so
auth        sufficient    pam_unix.so nullok try_first_pass
auth        sufficient    pam_himmelblau.so ignore_unknown_user
auth        required      pam_deny.so
```

Configure `/etc/pam.d/common-account` in a similar manner.

```pam
account    [default=1 ignore=ignore success=ok] pam_localuser.so
account    sufficient    pam_unix.so
account    sufficient    pam_himmelblau.so ignore_unknown_user
account    required      pam_deny.so
```

In `/etc/pam.d/common-session`, set `pam_himmelblau.so` as an optional module.

```pam
session optional    pam_systemd.so
session required    pam_limits.so
session optional    pam_unix.so try_first_pass
session optional    pam_umask.so
session optional    pam_himmelblau.so
session optional    pam_env.so
```

## Conclusion

In conclusion, you have successfully configured Himmelblau on a Linux host for authentication via Azure Entra ID. With this configuration, users who are authorized via the `pam_allow_groups` option can now securely access the host using multi-factor authentication (MFA), enhancing the security and control over access to your Linux environment.
