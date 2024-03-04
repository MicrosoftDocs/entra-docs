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

Provide single sign-on for on-premises resources published through Microsoft Entra Private Access. Microsoft Entra Private Access uses Kerberos Constrained Delegation (KCD) to support these resources.

## Prerequisites
Before you get started with single sign-on, make sure your environment is ready with the following settings and configurations.

- An Active Directory forest. The guide uses a forest domain name that can be publicly resolved, however this is not a requirement.
- Your Entra ID tenant is setup with the private DNS feature of Microsoft Entra Private Access.
- You have enabled the Microsoft Entra Private Access forwarding profile.
- The latest version of the Microsoft Entra private access connector is installed on a Windows server that has access to your domain controllers.
- The latest version of the Global Secure Access client. For more information on the client, see [Global Secure Access clients](concept-clients.md).
- Optionally, you can use Windows Hello for Business cloud Kerberos trust to allow single sign-on for users.

## Publish domain controllers
To achieve SSO to on-premises resources, your Domain Controllers must be published to allow clients obtain Kerberos tickets.

At a minimum, publish all Domain Controllers that are configured in the Active Directory site where your Private Access connectors are installed. For example, if your Private Access connectors are in your Brisbane data center, you should publish all the Domain Controllers in the Brisbane data center.

The Domain Controller ports are required to enable SSO to on-premises resources:
```
Port	Protocol	Purpose
88	UDP / TCP	Kerberos
389	UDP	DC Locator
```

> [!NOTE]
> The guide focuses on enabling SSO to on-premises resources and excludes configuration required for Windows domain-joined clients to perform domain operations (password change, Group Policy, etc.).

Click Global Secure Access (Preview), Applications, Enterprise Applications and then click “New Application” to create a new application to publish your Domain Controllers.
 
Click “Add application segment” and then add all of your Domain Controllers’ IPs or FQDNs (not both) and ports as per the table above. Only the Domain Controllers in the Active Directory site where the Private Access connectors are located need to be published.

> [!NOTE]
> Make sure you don’t use wildcard FQDNs to publish your domain controllers, instead add their specific IPs or FQDNs.
 
Once the Enterprise App has been created, browse back to the app, click Users and Groups and add all users synchronized from Active Directory.

## Publish DNS suffixes
You need to configure Private DNS  so that your Global Secure Access clients can resolve private DNS names that are required for SSO and to enable them to access other published on-premises resource.

Browse to Global Secure Access, Quick Access.
Click ‘Enable Name Private DNS’ and click Add DNS suffix to add your internal DNS suffixes as required. Click Save.
At a minimum, you should add the top-level suffixes of your Active Directory forests hosting users synchronized to Microsoft Entra ID.

## Publish resources
To test single sign-on, create a new enterprise application that publishes a file share.

In the Entra Portal, click Global Secure Access (Preview), Applications, Enterprise Applications and then click “New Application”. Using a new Enterprise App to publish your file share allows you to assign a Conditional Access policy to this resource and enforce additional security controls, such as multi-factor authentication.

Add a new app segment with the IP of your file server using port `445/TCP` and then click **Save**. This is the port used by SMB protocol.
 
Open the enterprise application you just created and click **Users and Groups** to assign access to the resource.

## Microsoft Entra ID joined devices - Password-based SSO
No additional configuration is needed if users use passwords to sign in to Windows. 

Microsoft Entra ID joined devices rely on AD domain and user information synchronized by Entra ID Connect. The Windows domain controller locator finds the domain controllers because of the synchronization. The user’s UPN and password are used to request a Kerberos TGT. For more information about this flow, see [How SSO to on-premises resources works on Microsoft Entra joined devices](../identity/devices/device-sso-to-on-premises-resources.md).

## Entra ID-Joined and Entra ID Hybrid-Joined devices – Windows Hello for Business SSO
Additional configuration for Windows Hello for Business is required.

Deployment of Hybrid Cloud Kerberos Trust with Entra ID is recommended. Devices using cloud Kerberos trust get a TGT ticket that is used for single sign-on. To learn more about cloud Kerberos trust, see [Enable passwordless security key sign-in to on-premises resources by using Microsoft Entra ID](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#use-sso-to-sign-in-to-on-premises-resources-by-using-fido2-keys). 

To deploy Windows Hello for Business cloud Kerberos trust on your on premises Active Director.
1. Create the Entra ID Kerberos Server Object. To learn how to create the object, see [Install the AzureADHybridAuthenticationManagement module](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#install-the-azureadhybridauthenticationmanagement-module).
1. Enable WHfB Cloud Trust on your devices using Intune or Group Policies. To learn how to enable WHfB, see [](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust?tabs=intune#configure-windows-hello-for-business-policy).


## Test the configuration

### Test file share access
Right click on the Global Secure Access icon in your system tray and select Advanced Diagnostics. Confirm  that your client has received the Private Access segments you configured above as part of the GSA policy. Verify that the rules displayed in your client match the network segments you configured above.

Open `\\YourFileServer.yourdomain.com` by using either the Start/Run menu, directly from an explorer window or via command line with the command.

`net view \\YourFileServer.yourdomain.com`

Your file share should open without being prompted for credentials, alternatively `net view` should enumerate the available file shares correctly.

After you have successfully browsed your file share, the `user>klist` command displays several Kerberos tickets issued by your domain controllers.

Traffic capture in the Global Secure Access client displays:
- DNS resolution (53/TCP)
- SMB connection (445/TCP)
- DC Locator (389/UDP)
- Kerberos negotiation (88/TCP)


### Test DNS resolution
1.	To validate the requests are being intercepted by Global Secure Access, right click on the Global Secure Access icon in your system tray, click Advanced Diagnostics, Traffic and then click Start Collecting.
2.	Run the following PowerShell command to test DNS resolution:
a.	Resolve-DnsName yourDomainController.yourdomain.com
b.	Resolve-DnsName yourFileServer.yourdomain.com
c.	Resolve-DnsName -Type SRV _kerberos._tcp.yourdomain.com
1.	These DNS resolution requests should be intercepted by the Global Secure Access client and be routed to one of your Private Access connectors. They won’t be sent to the default DNS server your network connection has provided to your device. DNS A records may resolve to an IP address 6.0.0.x if you have used FQDNs on your network segments.
3.	Try to resolve names again and see the results on the Traffic window. You should see the following lines indicating the DNS queries are being intercepted by Global Secure Access.

### Test DC locator
Run this command to see if your device is correctly discovering Domain Controllers. This uses DNS (53/UDP) and LDAP (389/UDP).
`nltest /dsgetdc:yourdomain.com /force /kdc`


### Test credential prompts
Receiving a credential prompt when trying to access your file share can be the result of multiple issues, here are some checks that might help getting to the root cause.

## Troubleshoot
Entra ID joined devices using password authentication rely on attributes being synchronized by Entra ID Connect. Make sure the attributes `onPremisesDomainName`, `onPremisesUserPrincipalName` and `onPremisesSamAccountName` have the right values. This can be checked using Graph Explorer and PowerShell.

If these values are not present, check your Entra ID Connect synchronization settings and validate these atrributes are being synchronized. To learn more about attribute synchronization, see [Microsoft Entra Connect Sync: Attributes synchronized to Microsoft Entra ID](../identity/hybrid/connect/reference-connect-sync-attributes-synchronized.md).

If using Windows Hello for Business to sign in, run the commands from a non-elevated command prompt.
`dsregcmd /status`

Verify the attributes have `YES` as values.
 
`PRT` should be present. To learn more about `PRT`, see [Troubleshoot primary refresh token issues on Windows devices](../identity/devices/troubleshoot-primary-refresh-token.md).

`CloudTGT` should be present if you have configured cloud Kerberos trust correctly. To learn more about about configuring cloud Kerberos trust, see[Passwordless security key sign-in to on-premises resources](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#install-the-azureadhybridauthenticationmanagement-module).

Run the `klist` command.

`klist cloud_debug`

Verify the `Cloud Primary (Hybrid logon) TGT available:` field has a value of 1.

Run the `nltest` command.

`nltest /dsgetdc:contoso /keylist /kdc`

Verify DCLocator can return a Domain Controller that is able to participate of Cloud Trust operations. The returned DC should have the `klist` flag.

## Next steps
- [Global Secure Access clients](concept-clients.md)
