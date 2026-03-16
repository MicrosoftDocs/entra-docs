---
title: Migrate from DirectAccess to Microsoft Entra Private Access
description: Learn how to migrate client devices from DirectAccess to Microsoft Entra Private Access with a phased approach that avoids tunnel conflicts and connectivity failures.
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to
ms.date: 03/16/2026
ms.reviewer: buzaher

#customer intent: As a security administrator, I want to migrate from DirectAccess to Microsoft Entra Private Access so that I can provide secure, identity-aware access to private resources without the limitations of legacy VPN solutions.

---

# Migrate from DirectAccess to Microsoft Entra Private Access

DirectAccess provides remote connectivity to internal resources but relies on IPv6 transition technologies, requires domain-joined Windows Enterprise clients, and grants full network-level access once connected. However, these architectural constraints don't meet the needs of modern hybrid and cloud-first environments.

Microsoft Entra Private Access is a cloud-based, Zero Trust Network Access (ZTNA) solution that replaces legacy VPN and DirectAccess infrastructure. It uses the [Global Secure Access client](/entra/global-secure-access/concept-clients) and [private network connectors](/entra/global-secure-access/how-to-configure-connectors), to deliver conditional, per-app access to private resources without exposing your network to inbound connections. Migrating to Microsoft Entra Private Access reduces infrastructure complexity, strengthens your Zero Trust posture, and extends secure access to any managed or unmanaged device.

### Technical incompatibilities between DirectAccess and Private Access

DirectAccess and Microsoft Entra Private Access can't coexist on the same device. When both are active, you might experience the following problems:

- **Device tunnel conflict**: DirectAccess establishes a device tunnel at boot that takes precedence and prevents Private Access traffic from flowing.
- **NRPT rule conflicts**: Both solutions use Name Resolution Policy Table (NRPT) rules. Conflicting entries cause unpredictable DNS resolution behavior.
- **IPv6 transition technology interference**: The IP-HTTPS tunnel adapter that DirectAccess creates can interfere with Private Access network routing.

> [!IMPORTANT]
> To ensure a successful migration, you must **fully remove** DirectAccess from each device before you enable Private Access traffic forwarding.

## Prerequisites

Before you begin the migration, ensure the following requirements are met:

- Microsoft Entra Private Access is enabled in your tenant. Descope the pilot user from Private Access [user assignment](/entra/global-secure-access/how-to-manage-users-groups-assignment) for the initial setup.
- Private Access connectivity is configured by using [Quick Access](/entra/global-secure-access/how-to-configure-quick-access) or [per-app access](/entra/global-secure-access/how-to-configure-per-app-access).
- [Private DNS](/entra/global-secure-access/concept-private-name-resolution) and name resolution for internal resources is configured as required.

## Migration strategy

To avoid tunnel conflicts and partial connectivity failures, break the migration into four phases:

1. [Deploy the Global Secure Access client](#phase-1-deploy-the-global-secure-access-client) (no impact)
1. [Remove DirectAccess from pilot devices](#phase-2-remove-directaccess-from-pilot-devices)
1. [Enable Private Access traffic forwarding for pilot users](#phase-3-enable-private-access-traffic-forwarding)
1. [Expand migration in controlled waves](#phase-4-expand-migration-in-controlled-waves)

## Phase 1: Deploy the Global Secure Access client

You can [deploy the Global Secure Access client](/entra/global-secure-access/how-to-install-windows-client) to your pilot device before removing DirectAccess.

- Deploy the Global Secure Access client by using a Mobile Device Management (MDM) solution, such as [Microsoft Intune](/mem/intune/apps/apps-win32-app-management).
- Don't assign the Private Access traffic forwarding profile yet. Instead, follow the steps in [How to assign users and groups to traffic forwarding profiles](/entra/global-secure-access/how-to-manage-users-groups-assignment#change-existing-user-and-group-assignments) to change the default **Assign to all users** setting to a new group.

### Expected behavior

| Indicator | Expected state |
|---|---|
| Global Secure Access client status | **Disabled by your organization** |
| DirectAccess | Continues to function normally |
| Private Access traffic | No traffic is forwarded |

> [!NOTE]
> Phase 1 doesn't affect existing DirectAccess connectivity.

## Phase 2: Remove DirectAccess from pilot devices

Before you enable Private Access, you must **fully remove** DirectAccess. Partial removal leaves the DirectAccess device tunnel active and blocks Private Access traffic.

### Verify DirectAccess is active

Before you begin removal, verify that DirectAccess is currently active on the device. To verify, check the following indicators:

#### Network & internet status 
Go to **Settings** > **Network & internet** > **DirectAccess**. The status shows **Workplace Connection: Connected**.

:::image type="content" source="media/how-to-migrate-direct-access-to-private-access/direct-access-connection-status.png" alt-text="Screenshot that shows Windows Settings with the DirectAccess page displaying Workplace Connection status as Connected." lightbox="media/how-to-migrate-direct-access-to-private-access/direct-access-connection-status.png":::

#### IP-HTTPS tunnel adapter
In Command Prompt, run `ipconfig`. A **Tunnel adapter Microsoft IP-HTTPS Platform Interface** entry confirms that the DirectAccess IPv6 transition tunnel is active.

:::image type="content" source="media/how-to-migrate-direct-access-to-private-access/tunnel-adapter.png" alt-text="Screenshot that shows the command prompt with activity in the IP-HTTPS tunnel adapter." lightbox="media/how-to-migrate-direct-access-to-private-access/tunnel-adapter.png":::

#### NRPT policies
Open PowerShell and run `Get-DnsClientNrptPolicy`. DirectAccess-related NRPT entries, such as `DirectAccess-NLS.*` namespaces, confirm that DirectAccess DNS policies are in place.

:::image type="content" source="media/how-to-migrate-direct-access-to-private-access/get-client-policy.png" alt-text="Screenshot that shows the PowerShell output of Get-DnsClientNrptPolicy with DirectAccess-related entries." lightbox="media/how-to-migrate-direct-access-to-private-access/get-client-policy.png":::

### Remove DirectAccess from pilot devices

Complete the following steps on pilot devices only:

1. Remove the computer account from the DirectAccess security group.
    1. Open **Group Policy Management**. 
    1. Locate the **DirectAccess Client Settings** Group Policy Object (GPO). 
    1. Remove the pilot computer from the security filtering group (for example, `DirectAccess Computers`).

   :::image type="content" source="media/how-to-migrate-direct-access-to-private-access/client-settings.png" alt-text="Screenshot that shows the Group Policy Management console with the DirectAccess Client Settings GPO and its security filtering configuration." lightbox="media/how-to-migrate-direct-access-to-private-access/client-settings.png":::

1. Ensure group membership changes replicate to all domain controllers.

1. On the client device, open PowerShell and run:

   ```powershell
   gpupdate /force
   shutdown /r /t 0
   ```

1. To fully clear the DirectAccess state, restart the client device twice.

### Validate DirectAccess removal

> [!IMPORTANT]
> Validate DirectAccess removal from the client **before** you proceed to Phase 3.

After the second reboot, confirm the following conditions:

- No DirectAccess NRPT entries exist.
    - Run the following command and verify no DirectAccess-related entries are returned:
    
      ```powershell
      Get-DnsClientNrptPolicy
      ```

- No IP-HTTPS adapter exists. 
    - Run `ipconfig` and verify that the **Tunnel adapter Microsoft IP-HTTPS Platform Interface** entry is gone.

- No DirectAccess UI state. 
    - Go to **Settings** > **Network & internet** and verify that the **DirectAccess** option no longer appears.

## Phase 3: Enable Private Access traffic forwarding

When you remove DirectAccess, enable Private Access for the pilot user.

1. Add your pilot user to the group that you assigned to the **Private Access traffic forwarding profile**. The Global Secure Access client can take 10-15 minutes to establish the Private Access tunnel.

1. Verify the Global Secure Access client shows **Connected** status in the system tray.

   :::image type="content" source="media/how-to-migrate-direct-access-to-private-access/taskbar-client.png" alt-text="Screenshot that shows the Global Secure Access client icon in the Windows system tray indicating a connected status." lightbox="media/how-to-migrate-direct-access-to-private-access/taskbar-client.png":::

### Expected behavior

| Indicator | Expected state |
|---|---|
| Private resources | Reachable |
| Global Secure Access client status | **Connected** |
| Private Access diagnostics | Traffic appears in logs |
| DirectAccess | No longer involved in connectivity |

## Phase 4: Expand migration in controlled waves

Repeat **Phase 2** and **Phase 3** for more user and device groups.

- Don't remove DirectAccess globally until all devices are migrated.
- Validate each group before expanding to the next. This approach minimizes risk and prevents remote access outages.

> [!CAUTION]
> Don't decommission DirectAccess server infrastructure until you confirm that all users can access required resources through Microsoft Entra Private Access.

## Related content

- [Learn about Microsoft Entra Private Access](/entra/global-secure-access/concept-private-access)
- [Configure private network connectors](/entra/global-secure-access/how-to-configure-connectors)
- [Configure Quick Access for Global Secure Access](/entra/global-secure-access/how-to-configure-quick-access)
- [Install the Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client)
- [Manage user and group assignments for Global Secure Access](/entra/global-secure-access/how-to-manage-users-groups-assignment)
