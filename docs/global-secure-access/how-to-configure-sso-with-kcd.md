---
title: Use Kerberos for single sign-on (SSO) with Microsoft Entra Private Access.
description: Covers how to provide single sign-on using Microsoft Entra Private Access.
author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.subservice: entra-private-access
ms.topic: how-to
ms.date: 03/04/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Use Kerberos constrained delegation for single sign-on (SSO) to your apps with Microsoft Entra Private Access

Provide single sign-on for on-premises resources published through Microsoft Entra Private Access. Microsoft Entra Private Access uses Kerberos Constrained Delegation (KCD) to support these resources. Optionally, use Windows Hello for Business cloud Kerberos trust to allow single sign-on for users.

## Prerequisites
Before you get started with single sign-on, make sure your environment is ready with the following settings and configurations.

- An Active Directory forest. The guide uses a forest domain name that can be publicly resolved. However, a publicly resolved domain isn't a requirement.
- Your Microsoft Entra ID tenant is set up with the private Domain Name System (DNS) feature of Microsoft Entra Private Access.
- You enabled the Microsoft Entra Private Access forwarding profile.
- The latest version of the Microsoft Entra private access connector is installed on a Windows server that has access to your domain controllers.
- The latest version of the Global Secure Access client. For more information on the client, see [Global Secure Access clients](concept-clients.md).

## Publish domain controllers
Domain Controllers must be published for clients to obtain Kerberos tickets. The tickets are required for single sign-on to on premises resources.

At a minimum, publish all Domain Controllers that are configured in the Active Directory site where your Private Access connectors are installed. For example, if your Private Access connectors are in your Brisbane data center, you should publish all the Domain Controllers in the Brisbane data center.

The Domain Controller ports are required to enable SSO to on-premises resources.

|Port      |Protocol   |Purpose     |
|----------|-----------|------------|
|88        |User Datagram Protocol (UDP) / Transmission Control Protocol (TCP)  |Kerberos    |
|389       |UDP        |DC locator  |

> [!NOTE]
> The guide focuses on enabling SSO to on-premises resources and excludes configuration required for Windows domain-joined clients to perform domain operations (password change, Group Policy, etc.).

1. Select **Global Secure Access (Preview)** > **Applications** > **Enterprise Applications** and then select **New Application** to create a new application to publish your Domain Controllers.
1. Select **Add application segment** and then add all of your Domain Controllers’ IPs or FQDNs (not both) and ports as per the table. Only the Domain Controllers in the Active Directory site where the private access connectors are located should be published.

> [!NOTE]
> Make sure you don’t use wildcard FQDNs to publish your domain controllers, instead add their specific IPs or FQDNs.
 
Once the enterprise application is created, browse back to the app and select **Users and Groups**. Add all users synchronized from Active Directory.

## Publish DNS suffixes
Configure Private DNS so the Global Secure Access clients can resolve private DNS names. Private DNS names are required for single sign-on. The clients use them to access published on premises resources.

1. Browse to **Global Secure Access** > **Quick Access**.
1. Select **Enable Name Private DNS** and select **Add DNS suffix**. At a minimum, add the top level suffixes of your Active Directory forests hosting users synchronized to Microsoft Entra ID.
1. Select **Save**.

## Publish resources
To test single sign-on, create a new enterprise application that publishes a file share. Using an enterprise application to publish your file share allows you to assign a Conditional Access policy to this resource and enforce extra security controls, such as multifactor authentication.

1. In the Microsoft Entra admin center, select **Global Secure Access (Preview)** > **Applications** > **Enterprise Applications**.
1. Select **New Application**. 
1. Add a new app segment with the IP of your file server using port `445/TCP` and then select **Save**. The port is the port used by Server Message Block (SMB) protocol.
1. Open the enterprise application you created and select **Users and Groups** to assign access to the resource.

## Microsoft Entra ID joined devices - Password-based SSO
No more configuration is needed if users use passwords to sign in to Windows. 

Microsoft Entra ID joined devices rely on AD domain and user information synchronized by Microsoft Entra ID Connect. The Windows domain controller locator finds the domain controllers because of the synchronization. The user’s User Principal Name (UPN) and password are used to request a Kerberos Ticket Granting Ticket (TGT). For more information about this flow, see [How SSO to on-premises resources works on Microsoft Entra joined devices](../identity/devices/device-sso-to-on-premises-resources.md).

## Microsoft Entra ID joined and Microsoft Entra ID hybrid joined devices – Windows Hello for Business single sign-on
Extra configuration for Windows Hello for Business is required.

Deployment of Hybrid Cloud Kerberos Trust with Microsoft Entra ID is recommended. Devices using cloud Kerberos trust get a TGT ticket that is used for single sign-on. To learn more about cloud Kerberos trust, see [Enable passwordless security key sign-in to on-premises resources by using Microsoft Entra ID](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#use-sso-to-sign-in-to-on-premises-resources-by-using-fido2-keys). 

To deploy Windows Hello for Business cloud Kerberos trust with on premises Active Directory.
1. Create the Microsoft Entra ID Kerberos server object. To learn how to create the object, see [Install the AzureADHybridAuthenticationManagement module](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#install-the-azureadhybridauthenticationmanagement-module).
1. Enable WHfB Cloud Trust on your devices using Intune or Group Policies. To learn how to enable WHfB, see [Cloud Kerberos trust deployment guide](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust?tabs=intune#configure-windows-hello-for-business-policy).


## Test the configuration
Test the configuration using a file share resource.

### Test file share access
Right select on the Global Secure Access icon in your system tray and select Advanced Diagnostics. Confirm that the client received the Private Access segments configured as part of the Global Secure Access policy. Verify that the rules displayed in the client match the network segments you configured.

Open `\\YourFileServer.yourdomain.com` by using either the Start/Run menu, directly from an explorer window or via command line with the command.

`net view \\YourFileServer.yourdomain.com`

Your file share should open without being prompted for credentials. Alternatively, `net view` should enumerate the available file shares correctly.

Successfully browse to the file share. View results with the `user>klist` command. The command displays several Kerberos tickets issued by your domain controllers.

Traffic capture in the Global Secure Access client displays.
- DNS resolution (53/TCP)
- SMB connection (445/TCP)
- DC Locator (389/UDP)
- Kerberos negotiation (88/TCP)

### Test DNS resolution
Validate Global Secure Access is intercepting the requests.
1. Right-click on the Global Secure Access icon in your system tray.
1. Select **Advanced Diagnostics** > **Traffic** and then select **Start Collecting**.
1.	To test DNS resolution, run the PowerShell command.
    - `Resolve-DnsName yourDomainController.yourdomain.com`
    - `Resolve-DnsName yourFileServer.yourdomain.com`
    - `Resolve-DnsName -Type SRV _kerberos._tcp.yourdomain.com`
1.	The Global Secure Access client should intercept the requests and route them to one of your Private Access connectors. The requests aren't sent to the default DNS server your network connection provided to your device. DNS `A records` might resolve to an IP address `6.0.0.x` if you use FQDNs on your network segments.
1.	Try to resolve names again and see the results on the Traffic window. The lines indicate that Global Secure Access is intercepting the DNS queries.

### Test DC locator
Run this command to see if your device is correctly discovering Domain Controllers. This uses DNS (53/UDP) and Lightweight Directory Access Protocol (LDAP) (389/UDP).
`nltest /dsgetdc:yourdomain.com /force /kdc`


### Test credential prompts
Receiving a credential prompt when trying to access your file share can be the result of multiple issues, here are some checks that might help getting to the root cause.

## Troubleshoot
Microsoft Entra ID joined devices using password authentication rely on attributes being synchronized by Microsoft Entra ID Connect. Make sure the attributes `onPremisesDomainName`, `onPremisesUserPrincipalName`, and `onPremisesSamAccountName` have the right values. Use Graph Explorer and PowerShell to check the values.

If these values aren't present, check your Microsoft Entra ID Connect synchronization settings and validate these attributes are being synchronized. To learn more about attribute synchronization, see [Microsoft Entra Connect Sync: Attributes synchronized to Microsoft Entra ID](../identity/hybrid/connect/reference-connect-sync-attributes-synchronized.md).

If using Windows Hello for Business to sign in, run the commands from a nonelevated command prompt.
`dsregcmd /status`

Verify the attributes have `YES` as values.
 
`PRT` should be present. To learn more about `PRT`, see [Troubleshoot primary refresh token issues on Windows devices](../identity/devices/troubleshoot-primary-refresh-token.md).

`CloudTGT` is present if you configured cloud Kerberos trust correctly. To learn more about configuring cloud Kerberos trust, see[Passwordless security key sign-in to on-premises resources](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#install-the-azureadhybridauthenticationmanagement-module).

Run the `klist` command.

`klist cloud_debug`

Verify the `Cloud Primary (Hybrid logon) TGT available:` field has a value of 1.

Run the `nltest` command.

`nltest /dsgetdc:contoso /keylist /kdc`

Verify the DC locator returns a Domain Controller that is a participant of cloud Kerberos trust operations. The returned DC should have the `klist` flag.

## Next steps
- [Global Secure Access clients](concept-clients.md)
