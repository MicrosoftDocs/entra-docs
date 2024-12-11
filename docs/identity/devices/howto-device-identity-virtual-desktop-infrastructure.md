---
title: Device identity and desktop virtualization
description: Learn how VDI and Microsoft Entra device identities can be used together

ms.service: entra-id
ms.subservice: devices
ms.topic: conceptual
ms.date: 11/25/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: sandeo
---
# Device identity and desktop virtualization

Administrators commonly deploy virtual desktop infrastructure (VDI) platforms hosting Windows operating systems in their organizations. Administrators deploy VDI to:

- Streamline management.
- Reduce costs through consolidation and centralization of resources.
- Deliver end-users mobility and the freedom to access virtual desktops anytime, from anywhere, on any device.

There are two primary types of virtual desktops:

- Persistent
- Non-persistent

Persistent versions use a unique desktop image for each user or a pool of users. These unique desktops can be customized and saved for future use.

Non-persistent versions use a collection of desktops that users can access on an as needed basis. These non-persistent desktops are reverted to their original state when a virtual machine goes through a shutdown/restart/OS reset process.

It's important to ensure organizations manage stale devices that are created because frequent device registration without having a proper strategy for device lifecycle management.

> [!IMPORTANT]
> Failure to manage stale devices can lead to pressure increase on your tenant quota usage consumption and potential risk of service interruption, if you run out of tenant quota. Use the following guidance when deploying non persistent VDI environments to avoid this situation.

For successful execution of some scenarios, it's important to have unique device names in the directory. This can be achieved by proper management of stale devices, or you can guarantee device name uniqueness by using some pattern in device naming.

This article covers Microsoft's guidance to administrators on support for device identity and VDI. For more information about device identity, see the article [What is a device identity](overview.md).

## Supported scenarios

Before configuring device identities in Microsoft Entra ID for your VDI environment, familiarize yourself with the supported scenarios. The following table illustrates which provisioning scenarios are supported. Provisioning in this context implies that an administrator can configure device identities at scale without requiring any end-user interaction. 

**Windows current** devices represent Windows 10 or newer, Windows Server 2016 v1803 or higher, and Windows Server 2019 or higher.

| Device identity type | Identity infrastructure | Windows devices | VDI platform version | Supported |
| --- | --- | --- | --- | --- |
| Microsoft Entra hybrid joined | Federated<sup>3</sup> | Windows current | Persistent | Yes |
|   |   | Windows current | Non-persistent | Yes<sup>5</sup> |
|   | Managed<sup>4</sup> | Windows current | Persistent | Yes |
|   |   | Windows current | Non-persistent | Limited<sup>6</sup> |
| Microsoft Entra joined | Federated | Windows current | Persistent | Limited<sup>8</sup> |
|   |   |   | Non-persistent | No |
|   | Managed | Windows current | Persistent | Limited<sup>8</sup> |
|   |   |   | Non-persistent | No |
| Microsoft Entra registered | Federated/Managed | Windows current | Persistent/Non-persistent | Not Applicable |

<sup>3</sup> A **Federated** identity infrastructure environment represents an environment with an identity provider (IdP) such as AD FS or other non-Microsoft IdP. In a federated identity infrastructure environment, computers follow the [managed device registration flow](device-registration-how-it-works.md#hybrid-azure-ad-joined-in-managed-environments) based on the [Microsoft Windows Server Active Directory Service Connection Point (SCP) settings](hybrid-join-manual.md#configure-a-service-connection-point).

<sup>4</sup> A **Managed** identity infrastructure environment represents an environment with Microsoft Entra ID as the identity provider deployed with either [password hash sync (PHS)](~/identity/hybrid/connect/whatis-phs.md) or [pass-through authentication (PTA)](~/identity/hybrid/connect/how-to-connect-pta.md) with [seamless single sign-on](~/identity/hybrid/connect/how-to-connect-sso.md).

<sup>5</sup> **Non-Persistence support for Windows current** requires other consideration as documented in the guidance section. This scenario requires Windows 10 1803 or newer, Windows Server 2019, or Windows Server (Semi-annual channel) starting version 1803

<sup>6</sup> **Non-Persistence support for Windows current** in a Managed identity infrastructure environment is only available with Citrix [on-premises customer managed](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/machine-identities/hybrid-azure-active-directory-joined) and [Cloud service managed](https://docs.citrix.com/en-us/citrix-daas/install-configure/machine-identities/hybrid-azure-active-directory-joined). For any support related queries, contact [Citrix support](https://www.citrix.com/support/) directly.

<sup>8</sup> **Microsoft Entra join support** is available with [Azure Virtual Desktop](/azure/virtual-desktop/), [Windows 365](https://www.microsoft.com/windows-365), and [Amazon WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/launch-workspaces-tutorials.html#launch-entra-id). For any support related queries with Amazon WorkSpaces and Microsoft Entra integration, contact [Amazon support](https://aws.amazon.com/contact-us/) directly.

## Microsoft's guidance

Administrators should reference the following articles, based on their identity infrastructure, to learn how to configure Microsoft Entra hybrid join.

- [Configure Microsoft Entra hybrid join for federated environment](./how-to-hybrid-join.md)
- [Configure Microsoft Entra hybrid join for managed environment](./how-to-hybrid-join.md)

### Non-persistent VDI

When administrators deploy non-persistent VDI, Microsoft recommends you implement the following guidance. Failure to do so results in your directory having lots of stale Microsoft Entra hybrid joined devices that were registered from your non-persistent VDI platform. These stale devices result in increased pressure on your tenant quota and risk of service interruption because of running out of tenant quota.

- If you're relying on the System Preparation Tool (sysprep.exe) and if you're using a pre-Windows 10 1809 image for installation, make sure that image isn't from a device that is already registered with Microsoft Entra ID as Microsoft Entra hybrid joined.
- If you're relying on a Virtual Machine (VM) snapshot to create more VMs, make sure that snapshot isn't from a VM that is already registered with Microsoft Entra ID as Microsoft Entra hybrid join.
- Active Directory Federation Services (AD FS) supports instant join for non-persistent VDI and Microsoft Entra hybrid join.
- Create and use a prefix for the display name (for example, NPVDI-) of the computer that indicates the desktop as non-persistent VDI-based.
- For Windows devices in a Federated environment (for example, AD FS):
   - Implement **dsregcmd /join** as part of VM boot sequence/order and before user signs in.
   - **DO NOT** execute dsregcmd /leave as part of VM shutdown/restart process.
- Define and implement process for [managing stale devices](manage-stale-devices.md).
   - Once you have a strategy to identify your non-persistent Microsoft Entra hybrid joined devices (such as using computer display name prefix), you should be more aggressive on the cleanup of these devices to ensure your directory doesn't get consumed with lots of stale devices.
   - For non-persistent VDI deployments, you should delete devices that have **ApproximateLastLogonTimestamp** of older than 15 days.

> [!NOTE]
> When using non-persistent VDI, if you want to prevent adding a work or school account ensure the following registry key is set:
> `HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin: "BlockAADWorkplaceJoin"=dword:00000001`
>
> Ensure you're running Windows 10, version 1803 or higher.

Roaming any data under the path `%localappdata%` is not supported. If you choose to move content under `%localappdata%`, make sure that the content of the following folders and registry keys **never** leaves the device under any condition. For example, profile migration tools must skip the following folders and keys:

- `%localappdata%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
- `%localappdata%\Packages\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`
- `%localappdata%\Packages\<any app package>\AC\TokenBroker`
- `%localappdata%\Microsoft\TokenBroker`
- `%localappdata%\Microsoft\OneAuth`
- `%localappdata%\Microsoft\IdentityCache`
- `HKEY_CURRENT_USER\SOFTWARE\Microsoft\IdentityCRL`
- `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AAD`
- `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WorkplaceJoin`

Roaming of the work account's device certificate is not supported. The certificate, issued by "MS-Organization-Access", is stored in the Personal (MY) certificate store of the current user and on the local machine.

### Persistent VDI

When administrators deploy persistent VDI, Microsoft recommends you implement the following guidance. Failure to do so results in deployment and authentication issues.

- If you're relying on the System Preparation Tool (sysprep.exe) and if you're using a pre-Windows 10 1809 image for installation, make sure that image isn't from a device that is already registered with Microsoft Entra ID as Microsoft Entra hybrid joined.
- If you're relying on a Virtual Machine (VM) snapshot to create more VMs, make sure that snapshot isn't from a VM that is already registered with Microsoft Entra ID as Microsoft Entra hybrid join.

We recommend you to implement process for [managing stale devices](manage-stale-devices.md). This process ensures your directory doesn't get consumed with lots of stale devices if you periodically reset your VMs.

## Next steps

[Configuring Microsoft Entra hybrid join for federated environment](./how-to-hybrid-join.md)
