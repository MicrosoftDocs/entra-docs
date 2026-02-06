---
title: Learn about Global Secure Access External User Access (Preview)
description: Learn how Global Secure Access enables secure External User access for partners through the Global Secure Access client and Azure Virtual Desktop.
author: HULKsmashGithub
ms.author: jayrusso
manager: dougeby
ms.topic: concept-article
ms.date: 12/02/2025
ms.service: global-secure-access
ms.reviewer: cagautham
ai-usage: ai-assisted
ms.custom: sfi-image-nochange

# Customer intent: As a Global Secure Access administrator, I want to understand how to enable External User access for partners using the Global Secure Access client and Azure Virtual Desktop with enhanced security controls.

---

# Overview of External User Access with Global Secure Access (preview)
Organizations often collaborate with external partners such as vendors and contractors. Traditional solutions for granting access to internal resources for external users typically lack visibility and granular security controls. Global Secure Access, built into Microsoft Entra, solves these challenges by using existing external user identities and providing advanced security features like Conditional Access, Continuous Access Evaluation, and cross-tenant trust. This approach enables secure, efficient management of external user access without duplicating accounts or requiring complex federation.

The External User access feature in Global Secure Access allows partners to use their own devices and identities to access company resources securely. It supports bring your own device (BYOD) scenarios, enforces per-app multifactor authentication, and offers seamless multitenant switching for partner users. Administrators benefit from single-pane management for identity, access, and network policies, reducing operational overhead while improving governance. Integrated logging and telemetry across identity and network layers provide full visibility into external user activity, ensuring a secure and streamlined experience for external collaboration.

> [!IMPORTANT]
> The external User access feature is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before its release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Enable external user access with the Global Secure Access client
Partners can enable the external user access feature with the Global Secure Access client, signed in to their home organization's Microsoft Entra ID account. The Global Secure Access client automatically discovers partner tenants where the user is a external user(guest or member) and offers the option to switch into the customer's tenant context. external users can access only assigned resources and only if they're included in the resource tenant's Private Access traffic forwarding profile. The client routes only traffic for the customer's private applications through the customer's Global Secure Access service.

:::image type="content" source="media/concept-b2b-guest-access/client-agent.png" alt-text="Diagram of external user access with Global Secure Access." lightbox="media/concept-b2b-guest-access/client-agent.png":::

### Prerequisites
To enable external user access with the Global Secure Access client, you must have:
- External users(guest or member) configured in the resource tenant. For more information, see the following articles:
    - [Quickstart: Add a external user and send an invitation](../external-id/b2b-quickstart-add-guest-users-portal.md)
    - [Understand and manage the properties of external user users](../external-id/user-properties.md)
- The Global Secure Access client installed and running on the device connected to the home tenant. To install the Global Secure Access client, see [Install the Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md).   
    > [!TIP]
    > The home tenant doesn't need to have a Global Secure Access license.
- Global Secure Access Private Access enabled on the resource tenant. Configure the Private Access traffic forwarding profile on the resource tenant and assign the profile to external user accounts.
- At least one private application configured and assigned to external user accounts.
- The external user access feature enabled on the client by setting the following registry key:   
`Computer\HKEY_LOCAL_MACHINE\Software\Microsoft\Global Secure Access Client`

    |Value  |Type  |Data  |Description  |
    |---------|---------|---------|---------|
    |GuestAccessEnabled     |REG_DWORD         |0x1         |External user access is enabled on this device.         |
    |GuestAccessEnabled     |REG_DWORD         |0x0         |External user access is disabled on this device.         |

Administrators can use a Mobile Device Management (MDM) solution, such as [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) or Group Policy, to set the registry values.

### Connect to the resource tenant
To enable external user access with the Global Secure Access client, follow these steps:

1. Launch the Global Secure Access client.
1. Switch the client to the resource tenant:
    1. Select the Global Secure Access client icon in the system tray.
    1. Select the User menu (profile picture) and select the resource tenant from the list.   
        > [!TIP]
        > The home tenant doesn't need to have Global Secure Access configured for this step to work.
    1. Verify that you're connected to the resource tenant. When true, the Global Secure Access **Organization** displays the name of the resource tenant.   
    :::image type="content" source="media/concept-b2b-guest-access/organization-resource-tenant.png" alt-text="Screen shot of the Global Secure Access Status pane showing that the Organization is connected to the resource tenant.":::

All the Global Secure Access tunnels to the home tenant (such as Private Access, Internet Access, or Microsoft 365 tunnels) disconnect and a new Private Access tunnel is created to the resource tenant. You should be able to access private applications configured on the resource tenant.

### Switch back to the home tenant

1. Select the Global Secure Access client icon in the system tray.
1. Select the User menu (profile picture).
1. To switch back, select the home tenant from the list. 

Switching back disconnects the Private Access tunnel from the resource tenant and connects the configured tunnels to the home tenant.

## Frequently asked questions (FAQ)
**Q: Are cross tenant signals like MFA and device compliance supported?**   
A: Yes, cross tenant signals work with the Global Secure Access external user access feature.

**Q: What is the license requirement for the home tenant?**   
A: The home tenant doesn't need a Global Secure Access license. The feature requires at least a Microsoft Entra free tenant.

**Q: Are both user types, Guest and Member, supported?**   
A: Yes. Cross Tenant Sync creates guest users as userType = Member by default, and this user type is supported.

**Q: Does the device need to be registered to the resource tenant?**   
A: No, device registration isn't required on the resource tenant for external user access to work.

**Q: Can I configure MFA on the resource tenant?**   
A: Yes, you can configure MFA on the user and on the applications.

**Q: How does a external user access an on-premises resource in the resource tenant when the resource uses AD DS and Kerberos (such as a file share or a Kerberos-integrated application)?**  
A: This scenario isn't supported. Microsoft Entra B2B colloboration doesn't provide Kerberos tickets, and Global Secure Access Private Access doesn't proxy Kerberos or support Kerberos Constrained Delegation (KCD). As a result, external users can't directly access on-premises resources requiring Kerberos (for example, SMB file shares or applications using Integrated Windows Authentication).  
For web applications, the only supported method for B2B users to access Kerberos-backed on-premises apps is by publishing the app through **Application Proxy with KCD**. For more information, see [Configure single sign-on with Kerberos constrained delegation](../identity/app-proxy/how-to-configure-sso-with-kcd.md).

## Known limitations
- External user access doesn't support keeping the Internet Access, Microsoft 365, and Microsoft Entra tunnels to the home tenant.
- Switching an account to the resource tenant fails when the resource tenant is configured for required MFA in the cross-tenant configuration and the home tenant is configured with passwordless sign-in (PSI) on the authenticator app.
- When Access Control is allowed on cross tenant settings for Global Secure Access, access isn't allowed because Global Secure Access controls these applications.
- When a user switches tenants, existing active application connections like Remote Desktop Protocol (RDP) remain connected to the previous tenant.
- External user access in the resource tenant will fail if compliant network policies are enforced for private applications. External users must be excluded from these policies.

## Enable external user access for Azure Virtual Desktop and Windows 365
You can enable Global Secure Access on Windows 365 and Azure Virtual Desktop instances that support external identities to provide external user access. With this capability, external users—such as guests, partners, and contractors—from other organizations can securely access resources in your tenant (the resource tenant). As a resource tenant administrator, you can configure Private Access, Internet Access, and Microsoft 365 traffic policies for these third-party users, helping ensure secure and controlled access to your organization's resources.

:::image type="content" source="media/concept-b2b-guest-access/guest-access-overview.png" alt-text="Diagram showing an overview of external user access in Global Secure Access." lightbox="media/concept-b2b-guest-access/guest-access-overview.png":::


To enable external user access for Windows 365 or Azure Virtual Desktop (AVD) virtual machines (VM) with Global Secure Access, follow these steps:

1. Configure your Windows 365 or Azure Virtual Desktop VM instance to use external ID linking. For more information, see [Configure external ID linking](/azure/virtual-desktop/authentication#external-identity-preview).

1. Onboard your organization to Global Secure Access. For more information, see [onboarding instructions](/entra/global-secure-access/overview-what-is-global-secure-access#licensing-overview).

1. Set up one or more Global Secure Access traffic forwarding profiles and assign them to users with external IDs. For more information, see [Configure traffic forwarding profiles](/entra/global-secure-access/quickstart-access-admin-center) and [Assign users to profiles](/entra/external-id/what-is-b2b).

1. Install and configure the Global Secure Access client on the virtual machines. For more information, see [Installation guide for the Global Secure Access client](/entra/global-secure-access/how-to-install-windows-client).

Once configured, the Global Secure Access client automatically connects to the tenant associated with the VM instance by using the external ID.

## Related content

- [Global Secure Access client for Windows](how-to-install-windows-client.md)
- [Global Secure Access client for Android](how-to-install-android-client.md)
- [Global Secure Access client for macOS](how-to-install-macos-client.md)
- [Global Secure Access client for iOS](how-to-install-ios-client.md)
- [Client for Windows version release notes](reference-windows-client-release-history.md)
- [Known limitations](/entra/global-secure-access/reference-current-known-limitations#b2b-guest-access-limitations)
