---
title: Use Kerberos for single sign-on (SSO) with Microsoft Entra Private Access.
description: Covers how to provide single sign-on using Kerberos with Microsoft Entra Private Access.
author: kenwith
manager: dougeby
ms.service: global-secure-access
ms.subservice: entra-private-access
ms.topic: how-to
ms.date: 04/10/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
---

# Use Kerberos for single sign-on (SSO) to your resources with Microsoft Entra Private Access
Provide single sign-on for on-premises resources published through Microsoft Entra Private Access. Microsoft Entra Private Access uses Kerberos to support these resources. Optionally, use Windows Hello for Business cloud Kerberos trust to allow single sign-on for users.

## Prerequisites
Before you get started with single sign-on, make sure your environment is ready.

- An Active Directory forest. The guide uses a forest domain name that can be publicly resolved. However, a publicly resolved domain isn't a requirement.
- You enabled the Microsoft Entra Private Access forwarding profile.
- The latest version of the Microsoft Entra Private Access connector is installed on a Windows server that has access to your domain controllers.
- The latest version of the Global Secure Access client. For more information on the client, see [Global Secure Access clients](concept-clients.md).

### Publish resources for use with single sign-on
To test single sign-on, create a new enterprise application that publishes a file share. Using an enterprise application to publish your file share lets you assign a Conditional Access policy to the resource and enforce extra security controls, such as multifactor authentication.

1. Sign in to [Microsoft Entra](https://entra.microsoft.com/) as at least a [Application Administrator](reference-role-based-permissions.md#application-administrator). 
1. Browse to **Global Secure Access** > **Applications** > **Enterprise Applications**.
1. Select **New Application**. 
1. Add a new app segment with the IP of your file server using port `445/TCP` and then select **Save**. The Server Message Block (SMB) protocol uses the port.
1. Open the enterprise application you created and select **Users and Groups** to assign access to the resource.

## Microsoft Entra ID joined devices - Password-based SSO
Extra configuration beyond this guide isn't needed if users use passwords to sign in to Windows. 

Microsoft Entra ID joined devices rely on the Active Directory domain and user information synchronized by Microsoft Entra ID Connect. The Windows domain controller locator finds the domain controllers because of the synchronization. The user’s User Principal Name (UPN) and password are used to request a Kerberos Ticket Granting Ticket (TGT). For more information about this flow, see [How SSO to on-premises resources works on Microsoft Entra joined devices](../identity/devices/device-sso-to-on-premises-resources.md).

## Microsoft Entra ID joined and Microsoft Entra ID hybrid joined devices – Windows Hello for Business single sign-on
Extra configuration beyond this guide is required for Windows Hello for Business.

Deployment of Hybrid Cloud Kerberos Trust with Microsoft Entra ID is recommended. Devices using cloud Kerberos trust get a TGT ticket that is used for single sign-on. To learn more about cloud Kerberos trust, see [Enable passwordless security key sign-in to on-premises resources by using Microsoft Entra ID](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#use-sso-to-sign-in-to-on-premises-resources-by-using-fido2-keys). 

To deploy Windows Hello for Business cloud Kerberos trust with on premises Active Directory.
1. Create the Microsoft Entra ID Kerberos server object. To learn how to create the object, see [Install the AzureADHybridAuthenticationManagement module](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#install-the-azureadhybridauthenticationmanagement-module).
1. Enable WHfB Cloud Trust on your devices using Intune or Group Policies. To learn how to enable WHfB, see [Cloud Kerberos trust deployment guide](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust?tabs=intune#configure-windows-hello-for-business-policy).


## Publish domain controllers
Domain Controllers must be published for clients to obtain Kerberos tickets. The tickets are required for single sign-on to on premises resources.

At a minimum, publish all Domain Controllers that are configured in the Active Directory site where your Private Access connectors are installed. For example, if your Private Access connectors are in your Brisbane data center, publish all the Domain Controllers in the Brisbane data center.

The Domain Controller ports are required to enable SSO to on-premises resources.

|Port        |Protocol   |Purpose     |
|------------|-----------|------------|
|88          |User Datagram Protocol (UDP) / Transmission Control Protocol (TCP)  |Kerberos    |
|123         |UDP        |Network Time Protocol (NTP)  |
|135         |UDP/TCP    |Domain controller to domain controller and client to domain controller operations  |
|138         |UDP        |File replication service between domain controllers  |
|139         |TCP        |File replication service between domain controllers  |
|389         |UDP        |DC locator  |
|445         |UDP/TCP    |Replication, User and Computer Authentication, Group Policy  |
|464         |UDP/TCP    |Password Change Request  |
|636         |TCP        |LDAP SSL  |
|1024-5000   |UDP/TCP    |Ephemeral ports, includes 3268-3269 TCP used for Global catalog from client to domain controller  |
|49152-65535  |UDP/TCP    |Ephemeral ports  |


> [!NOTE]
> The guide focuses on enabling SSO to on-premises resources and excludes configuration required for Windows domain-joined clients to perform domain operations (password change, Group Policy, etc.). To learn more about Windows network port requirements, see [Service overview and network port requirements for Windows](/troubleshoot/windows-server/networking/service-overview-and-network-port-requirements)

1. Sign in to [Microsoft Entra](https://entra.microsoft.com/) as at least a [Application Administrator](reference-role-based-permissions.md#application-administrator).
1. Browse to **Global Secure Access** > **Applications** > **Enterprise Applications**.
1. Select **New Application** to create a new application to publish your Domain Controllers.
1. Select **Add application segment** and then add all of your Domain Controllers’ IPs or Fully Qualified Domain Names (FQDNs) and ports as per the table. Only the Domain Controllers in the Active Directory site where the Private Access connectors are located should be published. 

> [!NOTE]
> Make sure you don’t use wildcard FQDNs to publish your domain controllers, instead add their specific IPs or FQDNs.
 
Once the enterprise application is created, browse back to the app and select **Users and Groups**. Add all users synchronized from Active Directory.

## Publish DNS suffixes
Configure private DNS so the Global Secure Access clients can resolve private DNS names. Private DNS names are required for single sign-on. The clients use them to access published on premises resources. To learn more about Private DNS with Quick Access, see [how-to-configure-quick-access.md#add-private-dns-suffixes](how-to-configure-quick-access.md).

1. Browse to **Global Secure Access** > **Applications** > **Quick Access**.
1. Select the **Private DNS** tab and then select **Enable Private DNS**.
1. Select **Add DNS suffix**. At a minimum, add the top level suffixes of your Active Directory forests hosting users synchronized to Microsoft Entra ID.
1. Select **Save**.

## How to use Kerberos SSO to access an SMB file share

This diagram demonstrates how Microsoft Entra Private Access works when trying to access an SMB file share from a Windows device that is configured with Windows Hello for Business + Cloud Trust. In this example, the admin has configured Quick Access Private DNS and two enterprise apps - one for the Domain Controllers and one for the SMB file share.

:::image type="content" source="media/how-to-configure-kerberos-sso/private-access-kerberos-sso-to-smb.png" alt-text="Diagram of Microsoft Entra Private Access using Kerberos SSO for SMB file share." lightbox="media/how-to-configure-kerberos-sso/private-access-kerberos-sso-to-smb.png":::

|Step      |Description   |
|----------|-----------|
|A         |User attempts to access SMB file share using FQDN. The GSA Client intercepts the traffic and tunnels it to the SSE Edge. Authorization policies in Microsoft Entra ID are evaluated and enforced, such as whether the user is assigned to the application and Conditional Access. Once the user has been authorized, Microsoft Entra ID issues a token for the SMB Enterprise Application. The traffic is released to continue to the Private Access service along with the application’s access token. The Private Access service validates the access token and the connection is brokered to the Private Access backend service. The connection is then brokered to the Private Network Connector.  |
|B       |The Private Network Connector performs a DNS query to identify the IP address of the target server. The DNS service on the private network sends the response. The Private Network Connector attempts to access the target SMB file share which then requests Kerberos authentication.         |
|C       |The client generates an SRV DNS query to locate domain controllers. Phase A is repeated, intercepting the DNS query and authorizing the user for the Quick Access application. The Private Network Connector sends the SRV DNS query to the private network. The DNS service sends the DNS response to the client via the Private Network Connector.       |
|D       |The Windows device requests a partial TGT (also called Cloud TGT) from Microsoft Entra ID (if it doesn’t already have one). Microsoft Entra ID issues a partial TGT.        |
|E      |Windows initiates a DC locator connection over UDP port 389 with each domain controller listed in the DNS response from phase C. Phase A is repeated, intercepting the DC locator traffic and authorizing the user for the Enterprise application that publishes the on-premises domain controllers. The Private Network Connector sends the DC locator traffic to each domain controller. The responses are relayed back to the client. Windows selects and caches the domain controller with the fastest response. |
|F |The client exchanges the partial TGT for a full TGT. The full TGT is then used to request and receive a TGS for the SMB file share. |
|G |The client presents the TGS to the SMB file share. The SMB file share validates the TGS. Access to the file share is granted.  | 

## Troubleshoot
Microsoft Entra ID joined devices using password authentication rely on attributes being synchronized by Microsoft Entra ID Connect. Make sure the attributes `onPremisesDomainName`, `onPremisesUserPrincipalName`, and `onPremisesSamAccountName` have the right values. Use Graph Explorer and PowerShell to check the values.

If these values aren't present, check your Microsoft Entra ID Connect synchronization settings and validate these attributes are being synchronized. To learn more about attribute synchronization, see [Microsoft Entra Connect Sync: Attributes synchronized to Microsoft Entra ID](../identity/hybrid/connect/reference-connect-sync-attributes-synchronized.md).

If using Windows Hello for Business to sign in, run the commands from a nonelevated command prompt.
`dsregcmd /status`

Verify the attributes have `YES` as values.
 
`PRT` should be present. To learn more about `PRT`, see [Troubleshoot primary refresh token issues on Windows devices](../identity/devices/troubleshoot-primary-refresh-token.md).

`OnPremTgt` : *YES* indicates Entra Kerberos is correctly configured and the user has been issued a partial TGT for SSO to on premises resources. To learn more about configuring cloud Kerberos trust, see [Passwordless security key sign-in to on-premises resources](../identity/authentication/howto-authentication-passwordless-security-key-on-premises.md#install-the-azureadhybridauthenticationmanagement-module).

Run the `klist` command.

`klist cloud_debug`

Verify the `Cloud Primary (Hybrid logon) TGT available:` field has a value of 1.

Run the `nltest` command.

`nltest /dsgetdc:contoso /keylist /kdc`

Verify the DC locator returns a Domain Controller that is a participant of cloud Kerberos trust operations. The returned DC should have the `klist` flag.

### How to avoid Kerberos Negative Caching on Windows Machines
Kerberos is the preferred authentication method for services in Windows that verify user or host identities. Kerberos negative caching causes a delay in Kerberos tickets.

Kerberos negative caching occurs to Windows devices that have the Global Secure Access client installed. The GSA client tries to connect to the closest Domain Controller for the Kerberos ticket, but the request fails because the GSA client is still not connected, or the Domain Controller is not reachable in that moment. Once the request fails, the client does not try to connect to the Domain Controller again, immediately, because the default `FarKdcTimeout` time on the registry is set to **10 minutes**. Even though the GSA client may be connected before this default time of 10 minutes, the GSA client holds on to the negative cache entry and believes that the Domain Controller locate process is a failure. Once the default time of 10 minutes is completed, the GSA client queries for the Domain Controller with the Kerberos ticket and the connection is successful.  

To mitigate this issue, you can either change the default `FarKdcTimeout` time on the registry or manually instantaneously flush the Kerberos cache every time the GSA client is restarted.   

#### Option 1: Change the default FarKdcTimeout time on the registry

If you're running Windows, you can modify the Kerberos parameters to help troubleshoot Kerberos authentication issues, or to test the Kerberos protocol.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).
 
**Registry entries and values under the Parameters key**

The registry entries that are listed in this section must be added to the following registry subkey: 

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`

> [!NOTE]
> If the `Parameters` key isn't listed under Kerberos, you must create it. 

**Modify the following `FarKdcTimeout` registry entry**
- Entry: `FarKdcTimeout`
- Type: `REG_DWORD` 
- Default value: `0 (minutes)` 

It's the time-out value that's used to invalidate a domain controller from a different site in the domain controller cache. 

#### Option 2: Manual Kerberos Cache Purging 

If you choose to manually purge the Kerberos cache, this step will have to be completed every time the GSA client is restarted.  

Open a command prompt as an administrator and run the following command: `KLIST PURGE_BIND`

## Next steps
- [Global Secure Access clients](concept-clients.md)
