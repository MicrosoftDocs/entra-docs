---
title: Plan your Microsoft Entra hybrid join deployment
description: Explains the steps that are required to implement Microsoft Entra hybrid joined devices in your environment.

ms.service: entra-id
ms.subservice: devices
ms.topic: article
ms.date: 06/27/2025

ms.author: owinfrey
author: owinfreyATL
manager: dougeby
ms.reviewer: sandeo
---

# Plan your Microsoft Entra hybrid join implementation

If you have an on-premises Active Directory Domain Services (AD DS) environment and you want to join your AD DS domain-joined computers to Microsoft Entra ID, you can accomplish this task by doing Microsoft Entra hybrid join.

> [!TIP]
> Single sign-on (SSO) access to on-premises resources is also available to devices that are Microsoft Entra joined. For more information, see [How SSO to on-premises resources works on Microsoft Entra joined devices](device-sso-to-on-premises-resources.md).

## Prerequisites

This article assumes that you're familiar with the [Introduction to device identity management in Microsoft Entra ID](./overview.md).

> [!NOTE]
> The minimum required domain controller (DC) version for Windows 10 or newer Microsoft Entra hybrid join is Windows Server 2008 R2.

Microsoft Entra hybrid joined devices require periodic network line of sight to your domain controllers. Without this connection, devices become unusable.

Scenarios that break without line of sight to your domain controllers include:

- Device password change
- User password change (Cached credentials)
- Trusted Platform Module (TPM) reset

## Plan your implementation

To plan your hybrid Microsoft Entra implementation, familiarize yourself with:

> [!div class="checklist"]
> - Review supported devices
> - Review things you should know
> - Review targeted deployment of Microsoft Entra hybrid join
> - Select your scenario based on your identity infrastructure
> - Review on-premises Microsoft Windows Server Active Directory user principal name (UPN) support for Microsoft Entra hybrid join

## Review supported devices

Microsoft Entra hybrid join supports a broad range of Windows devices.

- Windows 11
- Windows 10
- Windows Server 2016
  - **Note:** Azure National cloud customers require version 1803
- Windows Server 2019
- Windows Server 2022

As a best practice, Microsoft recommends you upgrade to the latest version of Windows.

## Review things you should know

### Unsupported scenarios

- Microsoft Entra hybrid join isn't supported for Windows Server running the Domain Controller (DC) role.
- Server Core OS doesn't support any type of device registration.
- User State Migration Tool (USMT) doesn't work with device registration.

### OS imaging considerations

- If you're relying on the System Preparation Tool (Sysprep) and using a **pre-Windows 10 1809** image for installation, make sure that image isn't from a device already registered with Microsoft Entra ID as Microsoft Entra hybrid joined.

- If you're relying on a Virtual Machine (VM) snapshot to create more VMs, make sure that snapshot isn't from a VM that is already registered with Microsoft Entra ID as Microsoft Entra hybrid joined.

- If you're using [Unified Write Filter](/windows/iot/iot-enterprise/customize/unified-write-filter) and similar technologies that clear changes to the disk at reboot, they must be applied after the device is Microsoft Entra hybrid joined. Enabling such technologies before completion of Microsoft Entra hybrid join results in the device getting unjoined on every reboot.

<a name='handling-devices-with-azure-ad-registered-state'></a>

### Handling devices with Microsoft Entra registered state

If your Windows 10 or newer domain joined devices are [Microsoft Entra registered](concept-device-registration.md) to your tenant, it might lead to a dual state of Microsoft Entra hybrid joined and Microsoft Entra registered device. We recommend upgrading to Windows 10 1803 (with KB4489894 applied) or newer to automatically address this scenario. In pre-1803 releases, you need to remove the Microsoft Entra registered state manually before enabling Microsoft Entra hybrid join. In 1803 and above releases, the following changes were made to avoid this dual state:

- Any existing Microsoft Entra registered state for a user would be automatically removed <i>after the device is Microsoft Entra hybrid joined and the same user logs in</i>. For example, if User A had a Microsoft Entra registered state on the device, the dual state for User A is cleaned up only when User A logs in to the device. If there are multiple users on the same device, the dual state is cleaned up individually when those users sign in. After an admin removes the Microsoft Entra registered state, Windows 10 will unenroll the device from Intune or other mobile device management (MDM), if the enrollment happened as part of the Microsoft Entra registration via autoenrollment.
- Microsoft Entra registered state on any local accounts on the device isn't affected by this change. Only applicable to domain accounts. Microsoft Entra registered state on local accounts isn't removed automatically even after user logon, since the user isn't a domain user.
- You can prevent your domain joined device from being Microsoft Entra registered by adding the following registry value to HKLM\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin: "BlockAADWorkplaceJoin"=dword:00000001.
- In Windows 10 1803, if you have Windows Hello for Business configured, the user needs to reconfigure Windows Hello for Business after the dual state cleanup. This issue is addressed with KB4512509.

> [!NOTE]
> Even though Windows 10 and Windows 11 automatically remove the Microsoft Entra registered state locally, the device object in Microsoft Entra ID isn't immediately deleted if it's managed by Intune. You can validate the removal of Microsoft Entra registered state by running `dsregcmd /status`.

<a name='hybrid-azure-ad-join-for-single-forest-multiple-azure-ad-tenants'></a>

### Microsoft Entra hybrid join for single forest, multiple Microsoft Entra tenants

To register devices as Microsoft Entra hybrid join to respective tenants, organizations need to ensure that the Service Connection Point (SCP) configuration is done on the devices and not in Microsoft Windows Server Active Directory. More details on how to accomplish this task can be found in the article [Microsoft Entra hybrid join targeted deployment](hybrid-join-control.md). It's important for organizations to understand that certain Microsoft Entra capabilities don't work in a single forest, multiple Microsoft Entra tenants configurations.

- [Device writeback](~/identity/hybrid/connect/how-to-connect-device-writeback.md) doesn't work. This configuration affects [Device based Conditional Access for on-premises apps that are federated using AD FS](/windows-server/identity/ad-fs/operations/configure-device-based-conditional-access-on-premises). This configuration also affects [Windows Hello for Business deployment when using the Hybrid Cert Trust model](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust).
- [Groups writeback](~/identity/hybrid/connect/how-to-connect-group-writeback-v2.md) doesn't work. This configuration affects writeback of Office 365 Groups to a forest with Exchange installed.
- [Seamless SSO](~/identity/hybrid/connect/how-to-connect-sso.md) doesn't work. This configuration affects SSO scenarios in organizations using browser platforms like iOS or Linux with Firefox, Safari, or Chrome without the Windows 10 extension.
- [On-premises Microsoft Entra Password Protection](~/identity/authentication/concept-password-ban-bad-on-premises.md) doesn't work. This configuration affects the ability to do password changes and password reset events against on-premises Active Directory Domain Services (AD DS) domain controllers using the same global and custom banned password lists that are stored in Microsoft Entra ID.

### Other considerations

- If your environment uses virtual desktop infrastructure (VDI), see [Device identity and desktop virtualization](./howto-device-identity-virtual-desktop-infrastructure.md).

- Microsoft Entra hybrid join is supported for Federal Information Processing Standard (FIPS)-compliant TPM 2.0 and not supported for TPM 1.2. If your devices have FIPS-compliant TPM 1.2, you must disable them before proceeding with Microsoft Entra hybrid join. Microsoft doesn't provide any tools for disabling FIPS mode for TPMs as it is dependent on the TPM manufacturer. Contact your hardware OEM for support.

- Starting from Windows 10 1903 release, TPM version 1.2 isn't used with Microsoft Entra hybrid join and devices with those TPMs are treated as if they don't have a TPM.

- UPN changes are only supported starting Windows 10 2004 update. For devices before the Windows 10 2004 update, users could have SSO and Conditional Access issues on their devices. To resolve this issue, you need to unjoin the device from Microsoft Entra ID (run "dsregcmd /leave" with elevated privileges) and rejoin (happens automatically). However, users signing in with Windows Hello for Business don't face this issue.

<a name='review-targeted-hybrid-azure-ad-join'></a>

## Review targeted Microsoft Entra hybrid join

Organizations might want to do a targeted rollout of Microsoft Entra hybrid join before enabling it for the entire organization. Review the article [Microsoft Entra hybrid join targeted deployment](hybrid-join-control.md) to understand how to accomplish it.

> [!WARNING]
> Organizations should include a sample of users from varying roles and profiles in their pilot group. A targeted rollout helps identify any issues your plan might not address before you enable for the entire organization.

## Select your scenario based on your identity infrastructure

Microsoft Entra hybrid join works with both, managed and federated environments depending on whether the UPN is routable or nonroutable. See bottom of the page for table on supported scenarios.

### Managed environment

A managed environment can be deployed either through [Password Hash Sync (PHS)](~/identity/hybrid/connect/whatis-phs.md) or [Pass Through Authentication (PTA)](~/identity/hybrid/connect/how-to-connect-pta.md) with [Seamless single sign-on](~/identity/hybrid/connect/how-to-connect-sso.md).

These scenarios don't require you to configure a federation server for authentication (AuthN).

> [!NOTE]
> [Cloud authentication using Staged rollout](~/identity/hybrid/connect/how-to-connect-staged-rollout.md) is only supported starting at the Windows 10 1903 update.

### Federated environment

A federated environment should have an identity provider that supports the following requirements. If you have a federated environment using Active Directory Federation Services (AD FS), then the below requirements are already supported.

**WS-Trust protocol:** This protocol is required to authenticate Microsoft Entra hybrid joined Windows devices with Microsoft Entra ID.
When you're using AD FS, you need to enable the following WS-Trust endpoints:

  `/adfs/services/trust/2005/windowstransport`
  `/adfs/services/trust/13/windowstransport`
  `/adfs/services/trust/2005/usernamemixed`
  `/adfs/services/trust/13/usernamemixed`
  `/adfs/services/trust/2005/certificatemixed`
  `/adfs/services/trust/13/certificatemixed`

> [!WARNING]
> Both **adfs/services/trust/2005/windowstransport** or **adfs/services/trust/13/windowstransport** should be enabled as intranet facing endpoints only and must NOT be exposed as extranet facing endpoints through the Web Application Proxy. To learn more on how to disable WS-Trust Windows endpoints, see [Disable WS-Trust Windows endpoints on the proxy](/windows-server/identity/ad-fs/deployment/best-practices-securing-ad-fs#disable-ws-trust-windows-endpoints-on-the-proxy-ie-from-extranet). You can see what endpoints are enabled through the AD FS management console under **Service** > **Endpoints**.

Beginning with version 1.1.819.0, Microsoft Entra Connect provides you with a wizard to configure Microsoft Entra hybrid join. The wizard enables you to significantly simplify the configuration process. If installing the required version of Microsoft Entra Connect isn't an option for you, see [How to manually configure device registration](hybrid-join-manual.md). If contoso.com is registered as a confirmed custom domain, users can get a PRT even if their synchronized on-premises AD DS UPN suffix is in a subdomain like test.contoso.com.

<a name='review-on-premises-ad-users-upn-support-for-hybrid-azure-ad-join'></a>

<a name='review-on-premises-ad-users-upn-support-for-microsoft-entra-hybrid-join'></a>

## Review on-premises Microsoft Windows Server Active Directory users UPN support for Microsoft Entra hybrid join

- Routable users UPN: A routable UPN has a valid verified domain that is registered with a domain registrar. For example, if contoso.com is the primary domain in Microsoft Entra ID, contoso.org is the primary domain in on-premises AD owned by Contoso and [verified in Microsoft Entra ID](~/fundamentals/add-custom-domain.md).
- Nonroutable users UPN: A nonroutable UPN doesn't have a verified domain and is applicable only within your organization's private network. For example, if contoso.com is the primary domain in Microsoft Entra ID and contoso.local is the primary domain in on-premises AD but isn't a verifiable domain in the internet and only used within Contoso's network.

> [!NOTE]
> The information in this section applies only to an on-premises users UPN. It isn't applicable to an on-premises computer domain suffix (example: computer1.contoso.local).

The following table provides details on support for these on-premises Microsoft Windows Server Active Directory UPNs in Windows 10 Microsoft Entra hybrid join:

| Type of on-premises Microsoft Windows Server Active Directory UPN | Domain type | Windows 10 version | Description |
| ----- | ----- | ----- | ----- |
| Routable | Federated | From 1703 release | Generally available |
| Nonroutable | Federated | From 1803 release | Generally available |
| Routable | Managed | From 1803 release | Generally available, Microsoft Entra SSPR on Windows lock screen isn't supported in environments where the on-premises UPN is different from the Microsoft Entra UPN. The on-premises UPN must be synced to the `onPremisesUserPrincipalName` attribute in Microsoft Entra ID |
| Nonroutable | Managed | Not supported | |

## Next steps

- [Configure Microsoft Entra hybrid join](how-to-hybrid-join.md)
