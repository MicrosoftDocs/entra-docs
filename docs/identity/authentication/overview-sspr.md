---
title: Password management in Microsoft Entra ID
description: Comprehensive hub for password management including self-service password reset (SSPR), passwordless authentication, password protection policies, and device password management.
author: godonnell
ms.author: garrodonnell
ms.service: entra-id
ms.subservice: authentication
ms.topic: hub-page
ms.date: 02/03/2026
ai-usage: ai-assisted
---

# Password management in Microsoft Entra ID

Password management is evolving. Organizations need to balance security requirements, user experience, and operational efficiency while choosing between traditional password-based approaches, self-service capabilities, and modern passwordless authentication.

This guide helps you make informed decisions about your password strategy by organizing resources around key scenarios and decision points. Whether you're reducing help desk costs, improving security posture, or transitioning to passwordless authentication, start with the scenario that matches your goals.

## Choose your password strategy

Before implementing specific features, consider your organization's goals and constraints.

### Common scenarios

| Scenario | Recommended approach | Key benefit |
|----------|---------------------|-------------|
| Reduce help desk password reset costs | [Enable self-service password reset](#reduce-help-desk-costs-with-sspr) | Users reset their own passwords without IT support |
| Improve security beyond passwords | [Deploy passwordless authentication](#eliminate-passwords-with-passwordless-authentication) | Remove password-based attacks entirely |
| Prevent weak passwords | [Implement password protection](#strengthen-password-security) | Block common and compromised passwords |
| Manage hybrid AD environment | [Configure password synchronization](#integrate-with-on-premises-active-directory) | Unified password experience across cloud and on-premises |
| Secure local admin accounts | [Enable Windows LAPS](#manage-device-passwords) | Automatic rotation of local administrator passwords |
| Support legacy apps with MFA | [Configure app passwords](#configure-app-passwords-for-legacy-applications) | Enable MFA without breaking older applications |

### Compare authentication approaches

| Factor | Traditional passwords | Passwords with SSPR | Passwordless |
|--------|----------------------|---------------------|--------------|
| **Security** | Vulnerable to phishing, credential theft | Same vulnerabilities, but faster recovery | Phishing-resistant, no shared secrets |
| **User experience** | Must remember passwords | Self-service reset reduces friction | No passwords to remember or reset |
| **Help desk impact** | High password reset volume | Reduced by 30-50% | Minimal password-related calls |
| **Implementation complexity** | Simple | Moderate (requires registration) | Higher (requires modern devices/apps) |
| **Hybrid support** | Native | Requires writeback | Requires on-premises configuration |
| **Best for** | Small organizations, simple needs | Medium-to-large organizations | Security-focused, modern infrastructure |

### Decision guidance

**Start with SSPR if:**
- You have frequent password reset requests overwhelming IT support
- Your users are already registered for multifactor authentication
- You need quick wins to reduce operational costs
- You have a hybrid environment with on-premises Active Directory

**Move to passwordless if:**
- Security is your primary concern (compliance, high-value targets)
- You're ready to invest in modern authentication infrastructure
- Your users have compatible devices (Windows Hello, FIDO2 keys, or mobile devices)
- You want to eliminate password-based attacks entirely

**Implement password protection if:**
- Users continue to set weak or compromised passwords
- You need to meet compliance requirements for password strength
- You have on-premises Active Directory that needs enhanced security

## Reduce help desk costs with SSPR

Self-service password reset (SSPR) lets users reset their own passwords without contacting IT support. Organizations typically see 30-50% reduction in password-related help desk tickets.

### Plan and understand SSPR

Start here to understand how SSPR works, licensing requirements, and planning considerations.

| Article | Description |
|---------|-------------|
| [Self-service password reset deep dive](concept-sspr-howitworks.md) | Understand the technical components, authentication methods, and user experience for SSPR. |
| [Self-service password reset policies](concept-sspr-policy.md) | Learn how to configure SSPR policies, including authentication methods, registration requirements, and user notifications. |
| [License self-service password reset](concept-sspr-licensing.md) | Review licensing requirements for SSPR features in Microsoft Entra ID. |
| [Plan a Microsoft Entra self-service password reset deployment](concept-sspr-deploy.md) | Comprehensive planning guide covering prerequisites, configuration decisions, testing strategies, and rollout plans. |

### Implement SSPR

| Article | Description |
|---------|-------------|
| [Enable users to unlock their account or reset passwords](tutorial-enable-sspr.md) | Step-by-step tutorial to enable SSPR, configure authentication methods, and test the user experience. |
| [Enable Microsoft Entra password writeback](tutorial-enable-sspr-writeback.md) | Configure password writeback to synchronize password changes from Microsoft Entra ID back to on-premises Active Directory. |
| [Enable cloud sync self-service password reset writeback](tutorial-enable-cloud-sync-sspr-writeback.md) | Configure password writeback using Microsoft Entra Cloud Sync for lightweight hybrid scenarios. |
| [Reset a user's password](../../fundamentals/users-reset-password-azure-portal.md) | Learn how administrators can reset user passwords through the Microsoft Entra admin center. |

### User registration and authentication methods

| Article | Description |
|---------|-------------|
| [Combined registration for SSPR and MFA](concept-registration-mfa-sspr-combined.md) | Enable users to register authentication methods for both SSPR and multifactor authentication in a single experience. |

### Configure password policies

| Article | Description |
|---------|-------------|
| [Combined password policy and check for weak passwords](concept-password-ban-bad-combined-policy.md) | Understand how password protection policies work together to prevent weak passwords. |

## Eliminate passwords with passwordless authentication

Passwordless authentication removes the security risks associated with passwords entirely. Users authenticate with biometrics, hardware tokens, or device-based credentials instead of memorizing passwords.

### Choose your passwordless method

| Method | Best for | Requirements | User experience |
|--------|----------|--------------|------------------|
| **Microsoft Authenticator** | Mobile workforce | iOS/Android device | Approve notification or enter code |
| **FIDO2 security keys** | Shared workstations, high security | USB/NFC/Bluetooth keys | Insert key and verify biometric/PIN |
| **Windows Hello for Business** | Windows devices | Windows 10+ with biometric or PIN | Face recognition, fingerprint, or PIN |
| **Temporary Access Pass** | Bootstrap/recovery | Configured in tenant | Time-limited passcode |

### Plan and deploy passwordless

| Article | Description |
|---------|-------------|
| [Microsoft Entra passwordless sign-in](concept-authentication-passwordless.md) | Compare passwordless options, understand prerequisites, and plan your rollout strategy. |

### Deploy passwordless methods

### Deploy passwordless methods

| Article | Description |
|---------|-------------|
| [Enable passwordless sign-in with Microsoft Authenticator](howto-authentication-passwordless-phone.md) | Configure phone sign-in using the Microsoft Authenticator app for mobile devices. |
| [Enable passwordless security key sign-in](howto-authentication-passwordless-security-key.md) | Deploy FIDO2 security keys for passwordless authentication to cloud resources. |
| [Passwordless security key sign-in to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md) | Extend FIDO2 security key authentication to on-premises Active Directory resources. |
| [Configure Temporary Access Pass](howto-authentication-temporary-access-pass.md) | Use time-limited passcodes to bootstrap passwordless authentication method registration. |

## Strengthen password security

If your organization continues using passwords, protect against weak passwords and compromised credentials with advanced password policies.

### When to use password protection

- Users continue to set passwords like "Password123" or company name variations
- Compliance requires protection against known compromised passwords
- You need consistent password policies across cloud and on-premises environments
- You want real-time blocking of weak passwords during creation or reset

### Deploy cloud password protection

| Article | Description |
|---------|-------------|
| [Eliminate bad passwords using Microsoft Entra Password Protection](concept-password-ban-bad.md) | Understand how global and custom banned password lists protect against weak passwords. |

### On-premises password protection

| Article | Description |
|---------|-------------|
| [Deploy on-premises Microsoft Entra Password Protection](howto-password-ban-bad-on-premises-deploy.md) | Extend Azure password protection policies to on-premises Active Directory Domain Services. |
| [Monitor on-premises Password Protection](howto-password-ban-bad-on-premises-monitor.md) | Review event logs and reports for on-premises password protection activity. |
| [Troubleshoot on-premises Password Protection](howto-password-ban-bad-on-premises-troubleshoot.md) | Resolve deployment and operational issues with on-premises password protection agents. |

## Configure app passwords for legacy applications

Some older applications can't prompt for multifactor authentication. App passwords provide a workaround by generating unique passwords for these applications.

### When you need app passwords

- Desktop email clients (Outlook 2010 and earlier)
- Non-browser apps that don't support modern authentication
- Users report "incorrect password" after enabling MFA

> [!NOTE]
> Modern authentication is preferred. Use app passwords only for applications that can't be updated.

| Article | Description |
|---------|-------------|
| [Configure app passwords for Azure MFA](howto-mfa-app-passwords.md) | Create and manage app passwords for legacy applications requiring MFA. |

## Manage device passwords

Local administrator passwords on Windows devices pose security risks when shared or static. Windows LAPS addresses this by automatically rotating passwords and storing them securely in Microsoft Entra ID.

### Why use Windows LAPS

- **Security**: Unique passwords per device prevent lateral movement attacks
- **Compliance**: Automated rotation meets audit requirements
- **Recovery**: Authorized admins retrieve passwords through Microsoft Entra admin center
- **Zero-trust alignment**: Time-limited, just-in-time access to local admin accounts

| Article | Description |
|---------|-------------|
| [Manage Windows Local Administrator Passwords with Microsoft Entra ID](../devices/howto-manage-local-admin-passwords.md) | Configure Windows LAPS to automatically rotate and securely store local administrator passwords in Microsoft Entra ID. |

## Integrate with on-premises Active Directory

For hybrid environments, synchronize passwords and enable writeback to provide consistent password experiences across cloud and on-premises resources.

### Hybrid password scenarios

| Scenario | Solution | Benefit |
|----------|----------|----------|
| Users sign in to cloud apps with on-premises passwords | [Password hash synchronization](#password-hash-synchronization) | Single password works everywhere |
| Users reset password in cloud, needs to sync to on-premises AD | [Password writeback](#implement-sspr) | Password changes flow both directions |
| Choose between PHS, PTA, and federation | [Authentication method comparison](../hybrid/connect/choose-ad-authn.md) | Understand trade-offs for your environment |
| Deploy lightweight cloud agent | [Cloud Sync](#microsoft-entra-cloud-sync) | Alternative to full Entra Connect |

### Password hash synchronization

### Password hash synchronization

| Article | Description |
|---------|-------------|
| [Implement password hash synchronization with Microsoft Entra Connect Sync](../hybrid/connect/how-to-connect-password-hash-synchronization.md) | Configure password hash synchronization to enable authentication with cloud services using on-premises credentials. |
| [Authentication for Microsoft Entra hybrid identity solutions](../hybrid/connect/choose-ad-authn.md) | Compare authentication methods including password hash synchronization, pass-through authentication, and federation. |
| [Microsoft Entra Connect: User sign-in](../hybrid/connect/plan-connect-user-signin.md) | Plan your user sign-in strategy and understand how different authentication methods work. |

### Microsoft Entra Connect setup

| Article | Description |
|---------|-------------|
| [Microsoft Entra Connect and Microsoft Entra Connect Health installation roadmap](../hybrid/connect/how-to-connect-install-roadmap.md) | Review prerequisites, installation options, and post-installation tasks for Microsoft Entra Connect. |
| [Microsoft Entra Connect: When you already have Microsoft Entra ID](../hybrid/connect/how-to-connect-install-existing-tenant.md) | Install Microsoft Entra Connect in an existing Microsoft Entra tenant. |
| [Microsoft Entra Connect Sync: Understand and customize synchronization](../hybrid/connect/how-to-connect-sync-whatis.md) | Understand the synchronization architecture and how to customize synchronization rules. |
| [Microsoft Entra Connect Sync: Operational tasks and considerations](../hybrid/connect/how-to-connect-sync-staging-server.md) | Learn about staging mode, disaster recovery, and operational best practices. |
| [Microsoft Entra Connect Sync: Configure filtering](../hybrid/connect/how-to-connect-sync-configure-filtering.md) | Limit which objects synchronize to Microsoft Entra ID using domain, organizational unit, or attribute-based filtering. |
| [Microsoft Entra Connect: Configure AD DS Connector Account Permissions](../hybrid/connect/how-to-connect-configure-ad-ds-connector-account.md) | Configure the minimum required permissions for the AD DS connector account. |
| [Microsoft Entra Connect Sync service features and configuration](../hybrid/connect/how-to-connect-syncservice-features.md) | Manage synchronization service features including duplicate attribute resiliency and directory extension attribute sync. |

### Microsoft Entra Cloud Sync

| Article | Description |
|---------|-------------|
| [What is Microsoft Entra Cloud Sync?](../hybrid/cloud-sync/what-is-cloud-sync.md) | Learn about the lightweight cloud-based provisioning agent alternative to Microsoft Entra Connect. |
| [Install the Microsoft Entra provisioning agent](../hybrid/cloud-sync/how-to-install.md) | Install and configure the cloud provisioning agent for hybrid identity scenarios. |

## Monitor and report

Track password reset activity, authentication method usage, and security events.

| Article | Description |
|---------|-------------|
| [Reporting options for Microsoft Entra password management](howto-sspr-reporting.md) | Access audit logs and usage reports to monitor password reset activity and registration status. |

## Troubleshoot password management

Use these resources to diagnose and resolve issues across password management scenarios.

### SSPR troubleshooting

| Article | Description |
|---------|-------------|
| [Troubleshoot self-service password reset](troubleshoot-sspr.md) | Resolve common SSPR issues including configuration problems, user errors, and registration issues. |
| [Troubleshoot self-service password reset writeback](troubleshoot-sspr-writeback.md) | Resolve issues with password writeback including connectivity problems, event log errors, and permission issues. |

### Hybrid identity troubleshooting

| Article | Description |
|---------|-------------|
| [Troubleshoot password hash synchronization with Microsoft Entra Connect Sync](../hybrid/connect/tshoot-connect-password-hash-synchronization.md) | Diagnose and fix password hash synchronization issues using built-in troubleshooting tools. |

### Password protection troubleshooting

| Article | Description |
|---------|-------------|
| [Troubleshoot on-premises Password Protection](howto-password-ban-bad-on-premises-troubleshoot.md) | Resolve deployment and operational issues with password protection agents in Active Directory. |

### Enterprise app troubleshooting

| Article | Description |
|---------|-------------|
| [Troubleshoot password-based single sign-on](../enterprise-apps/troubleshoot-password-based-sso.md) | Resolve issues with password vaulting and single sign-on for enterprise applications. |

## Additional resources

### Frequently asked questions

| Article | Description |
|---------|-------------|
| [Password Management frequently asked questions](passwords-faq.yml) | Find answers to common questions about password reset, registration, reporting, and writeback. |

## Related content

### Authentication and identity

- [Microsoft Entra authentication methods](concept-authentication-methods.md)
- [Microsoft Entra multifactor authentication](concept-mfa-howitworks.md)
- [Single sign-on (SSO) in Microsoft Entra ID](../enterprise-apps/sso-overview.md)
- [What is Microsoft Entra ID?](../../fundamentals/whatis.md)

### Hybrid identity

- [What is hybrid identity?](../hybrid/whatis-hybrid-identity.md)
- [Choose the right authentication method](../hybrid/connect/choose-ad-authn.md)

### Security

- [Conditional Access overview](../conditional-access/overview.md)
- [Security defaults in Microsoft Entra ID](../../fundamentals/security-defaults.md)

### User management

- [Add or delete users](../../fundamentals/add-users.md)
- [Assign licenses to users](../../fundamentals/license-users-groups.md)
