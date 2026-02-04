---
title: Troubleshoot Device Registration Command Tool on Linux
description: This article covers how to use the output from the Device Registration command tool on Linux to understand the state of devices in Microsoft Entra ID.
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.subservice: devices
ms.topic: troubleshooting
ms.date:     01/07/2026
ms.custom: linux-related-content
---

# Device Registration Command Tool for Linux

A Linux command-line tool similar to Windows `dsregcmd` that queries device registration status, PRT (Primary Refresh Token) information, and broker configuration from the Microsoft Identity Broker.

## Overview

`dsreg` provides administrators and developers with detailed information about device registration state on Linux systems. It queries the Microsoft Identity Broker to retrieve:

- Device registration status
- Device ID and tenant information
- PRT (Primary Refresh Token) status and refresh times
- Certificate information
- Session key details
- Broker version and configuration

## Installation

The tool is included in the Microsoft Identity Broker packages and installed to `/usr/bin/dsreg` when the broker is installed.

### Supported Linux Distributions

- **Ubuntu/Debian** - DEB package (`microsoft-identity-broker_*.deb`)
- **RHEL/Rocky Linux/AlmaLinux** - RPM package (`microsoft-identity-broker-*.rpm`)

#### [Ubuntu](#tab/debian-dsreginstall)

```bash
# Ubuntu/Debian
sudo apt install microsoft-identity-broker
```

#### [RHEL/Rocky Linux/AlmaLinux](#tab/redhat-dsreginstall)

```bash
# RHEL/Rocky Linux/AlmaLinux
sudo dnf install microsoft-identity-broker
# or
sudo yum install microsoft-identity-broker
```

---

> [!NOTE]
>  Once you install the `microsoft-identity-broker`, the dsregcmd tool is available system-wide.

```bash
dsreg --help
```

## Usage

```bash
# Display device registration status
dsreg
dsreg --status

# Display help
dsreg --help

# Query specific tenant
dsreg --tenant-id <tenant-guid>

# Get DRS access token
dsreg --getdrstoken

# Unregister device (requires sudo)
sudo dsreg --tenant-id <tenant-guid> --unregister

# Clean broker state (prompts for confirmation)
dsreg --cleanup

# Clean broker state including certificates (requires sudo)
sudo dsreg --cleanup
```

## Command Options

| Option | Description |
| --- | --- |
| `--status` | Display comprehensive device registration and PRT status (default) |
| `--help` | Display help information |
| `--tenant-id <id>` | Query device registration for a specific tenant GUID |
| `--getdrstoken` | Acquire DRS (Device Registration Service) access token for device operations |
| `--unregister` | Unregister device from Entra ID tenant (**requires sudo** and DRS token) |
| `--cleanup` | Clean all local broker state with confirmation prompt.<br><br>**Phase 1 (always)**: Clears user-level cache (accounts, tokens, credentials)<br>**Phase 2 (root only)**: Removes device private keys and certificates (drs_* and stk_* files from /etc/microsoft/identity-broker/private and /etc/microsoft/identity-broker/certs)<br>**Note**: Does NOT unregister device from Entra ID (use `--unregister` separately) |

## Output Information

### Device State

| Field | Description |
| --- | --- |
| **Device registration status** | (Registered/Not Registered) |
| **Device ID** | The unique ID of the device in the Microsoft Entra tenant. |
| **Tenant ID** | Tenant details that are displayed when a device is joined to Microsoft Entra ID. |
| **Tenant name/domain** | Tenant details that are displayed when a device is joined to Microsoft Entra ID. |
| **Certificate thumbprint** | The thumbprint of the device certificate. |

### Primary Refresh Token (PRT)

| Field | Description |
| --- | --- |
| **PRT present** | (Yes\|No) *YES* if a Primary Refresh Token (PRT) is present on the device for the logged-in user. |
| **PRT cached time** | The time, in UTC, when the PRT was last cached on the device. |
| **PRT expiration time** | The time, in UTC, when the PRT is going to expire if it isn't renewed. |
| **Last PRT refresh time** | The time, in UTC, when the Enterprise PRT was last updated. |
| **Age of PRT (hours)** |  |
| **Session key protocol version** | The protocol version used for the session key associated with the PRT. |

### Broker Information

| Field | Description |
| --- | --- |
| **Broker version** | The version of the current `microsoft-identity-broker` installed on the device. |
| **Broker service name** | The name of the systemd service for the broker. |
| **Broker binary path and installation timestamp** | The file path and installation timestamp of the broker binary. |
| **Device mode** | (Exclusive/Shared) |

## Example Output

```
Device State
-----------------------------------------------------------------
Device Registration Status   : Registered
Device ID                    : a1b2c3d4-e5f6-g7h8-i9j0-k1l2m3n4o5p6
Tenant ID                    : 12345678-90ab-cdef-1234-567890abcdef
Tenant Name                  : contoso.com

Primary Refresh Token
-----------------------------------------------------------------
PRT Present                  : YES
PRT Cached At                : 2025-12-11 08:30:15 UTC
PRT Expires On               : 2025-12-25 08:30:15 UTC
PRT Age                      : 4.25 hours
Session Key Protocol         : 3.1

Broker Information
-----------------------------------------------------------------
Broker Version               : 2.0.123.456
Broker Service Name          : microsoft-identity-device-broker.service
Broker Binary Path           : /opt/microsoft/identity-broker/bin/microsoft-identity-broker
Broker Binary Timestamp      : 2025-12-19 14:30:22 UTC
```

## Cleanup Operation

The `--cleanup` command performs a safe. Two-phase cleanup with user confirmation:

### Confirmation Prompt
Before proceeding, dsreg displays:

```bash
WARNING: This operation will permanently remove all local accounts, credentials, and cached tokens.
         Running as root will also remove device certificates and private keys from:
           - /etc/microsoft/identity-broker/certs (certificates)
           - /etc/microsoft/identity-broker/private (private keys)

This is an irreversible operation.
Do you want to continue? (Y/N):
```

You must enter **Y** or **y** to proceed. Any other input cancels the operation.

### Phase 1: User-Level Cleanup (Always Runs)
- Clears all cached accounts
- Removes all authentication tokens
- Deletes stored credentials
- Clears PRT cache
- Removes user cache directories:
  - `~/.cache/intune-portal`
  - `~/.cache/Microsoft`
  - `~/.cache/microsoft-edge`
  - `~/.config/intune`
  - `~/.config/microsoft-identity-broker`
  - `~/.local/share/intune-portal`

### Phase 2: Device Keys and Certificates Cleanup (Root Only)
If running as root (`sudo dsreg --cleanup`), also removes:
- Stops the `microsoft-identity-device-broker` service
- Device private keys from `/etc/microsoft/identity-broker/private/`
- Device certificates from `/etc/microsoft/identity-broker/certs/`
- System-level broker data from `/var/lib/microsoft-identity-device-broker`
- Only touches files prefixed with `drs_*` or `stk_*` in certificate directories
- Safe: doesn't modify other keys or certificates

### Important Notes
- **Cleanup does NOT unregister the device from Entra ID**
- To fully remove device, run `sudo dsreg --tenant-id <id> --unregister` separately
- After cleanup, users must sign in again to restore PRT
- Running without sudo only clears user cache, not certificates

## Troubleshooting

### "Failed to get broker instance"
**Cause:** Broker isn't running or not installed
**Solution:**
```bash
# Check if broker is running
systemctl status microsoft-identity-device-broker

# Start broker if needed
systemctl start microsoft-identity-device-broker
```

### "Device Registration Status: Not Registered"
**Cause:** Device hasn't been registered with Entra ID
**Solution:**
1. Check network connectivity to Entra ID
2. Ensure device meets registration requirements
3. Run registration process for your organization

### "PRT Present: NO"
**Cause:** No user signed in or PRT has expired
**Solution:**
1. Sign in with Entra ID account
2. Verify network connectivity for PRT refresh
3. Check time synchronization (PRT requires accurate time)

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success (even if not registered or no PRT) |
| 1 | Invalid command-line arguments |
| 2 | Failed to initialize (broker not available) |
| 3 | Query failed with error |
| 4 | Insufficient permissions (sudo required) |
| 5 | DRS token required for operation |
| 6 | Device unregistration failed |
| 7 | Cleanup operation failed |
| 8 | User canceled cleanup operation |
## Security Architecture

### Privilege Separation
The tool implements security through proper separation of concerns:

- **Business Logic Layer** (`DeviceBrokerImpl`): No privilege checks, testable logic only
- **IPC Boundary** (`DBusDispatcher`): Security enforcement via `callerUid` validation
- **Operations requiring root**: Enforced at D-Bus boundary, not in business logic

### Cleanup Safety
Certificate cleanup is designed to be safe:
- Only removes files with `drs_*` or `stk_*` prefixes in `/etc/microsoft/identity-broker/private`
- Never touches system or user certificates
- Provides confirmation prompt before any destructive operation

## Architecture

The tool uses existing broker components:
- **DeviceBroker** - For device registration queries and privileged operations
- **BrokerCore** - For PRT and authentication state
- **DeviceInfoAccessor** - For device information retrieval
- **CacheManager** - For reading cached credentials
- **D-Bus IPC** - For secure communication with broker services

It shares the same components as the broker, ensuring consistent results.

## Comparison with Windows dsregcmd

| Feature | Windows dsregcmd | Linux dsreg |
|---------|------------------|-------------|
| Device join status | ✓ | ✓ |
| Device ID | ✓ | ✓ |
| Tenant ID | ✓ | ✓ |
| PRT status | ✓ | ✓ |
| PRT timestamps | ✓ | ✓ |
| Certificate thumbprint | ✓ | ✓ |
| Color-coded output | ✗ | ✓ |


## Related Content

For more information, see the following Intune documentation:

- [What's new in Microsoft single sign-on for Linux](whats-new-linux.md)
- [Microsoft Identity Broker for Linux overview](sso-linux.md)
- [Deployment guide: Manage Linux devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-platform-linux)
- [Enrollment guide: Enroll Linux desktop devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-enrollment-linux).
