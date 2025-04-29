---
title: 'Prerequisites for Microsoft Entra Cloud Sync in Microsoft Entra ID'
description: This article describes the prerequisites and hardware requirements you need for cloud sync.

author: billmath
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: billmath

---

# Prerequisites for Microsoft Entra Cloud Sync

This article provides guidance on using Microsoft Entra Cloud Sync as your identity solution.

## Cloud provisioning agent requirements

You need the following to use Microsoft Entra Cloud Sync:

- Domain Administrator or Enterprise Administrator credentials to create the Microsoft Entra Connect cloud sync gMSA (group managed service account) to run the agent service.
- A Hybrid Identity Administrator account for your Microsoft Entra tenant that isn't a guest user.
- An on-premises server for the provisioning agent with Windows 2016 or later. This server should be a tier 0 server based on the [Active Directory administrative tier model](/security/privileged-access-workstations/privileged-access-access-model). Installing the agent on a domain controller is supported.  For more information, see [Harden your Microsoft Entra provisioning agent server](#harden-your-microsoft-entra-provisioning-agent-server)

  - Required for AD Schema attribute  - msDS-ExternalDirectoryObjectId
    
- The Windows Credential Manager service (VaultSvc) cannot be disabled as that prevents the provisioning agent from installing.

- High availability refers to the Microsoft Entra Cloud Sync's ability to operate continuously without failure for a long time. By having multiple active agents installed and running, Microsoft Entra Cloud Sync can continue to function even if one agent should fail. Microsoft recommends having 3 active agents installed for high availability.
- On-premises firewall configurations.


## Harden your Microsoft Entra provisioning agent server
We recommend that you harden your Microsoft Entra provisioning agent server to decrease the security attack surface for this critical component of your IT environment. Following these recommendations helps mitigate some security risks to your organization.

- We recommend hardening the Microsoft Entra provisioning agent server as a Control Plane (formerly Tier 0) asset by following the guidance provided in [Secure Privileged Access](/security/privileged-access-workstations/overview) and [Active Directory administrative tier model](/security/privileged-access-workstations/privileged-access-access-model).
- Restrict administrative access to the Microsoft Entra provisioning agent server to only domain administrators or other tightly controlled security groups.
- Create a [dedicated account for all personnel with privileged access](/windows-server/identity/securing-privileged-access/securing-privileged-access). Administrators shouldn't be browsing the web, checking their email, and doing day-to-day productivity tasks with highly privileged accounts.
- Follow the guidance provided in [Securing privileged access](/security/privileged-access-workstations/overview). 
- Deny use of NTLM authentication with the Microsoft Entra provisioning agent server. Here are some ways to do this: [Restricting NTLM on the Microsoft Entra provisioning agent Server](/windows/security/threat-protection/security-policy-settings/network-security-restrict-ntlm-outgoing-ntlm-traffic-to-remote-servers) and [Restricting NTLM on a domain](/windows/security/threat-protection/security-policy-settings/network-security-restrict-ntlm-ntlm-authentication-in-this-domain)
- Ensure every machine has a unique local administrator password. For more information, see [Local Administrator Password Solution (Windows LAPS)](/windows-server/identity/laps/laps-overview) can configure unique random passwords on each workstation and server store them in Active Directory protected by an ACL. Only eligible authorized users can read or request the reset of these local administrator account passwords. Additional guidance for operating an environment with Windows LAPS and privileged access workstations (PAWs) can be found in [Operational standards based on clean source principle](/security/privileged-access-workstations/privileged-access-access-model#operational-standards-based-on-clean-source-principle). 
- Implement dedicated [privileged access workstations](https://4sysops.com/archives/understand-the-microsoft-privileged-access-workstation-paw-security-model/) for all personnel with privileged access to your organization's information systems. 
- Follow these [additional guidelines](/windows-server/identity/ad-ds/plan/security-best-practices/reducing-the-active-directory-attack-surface) to reduce the attack surface of your Active Directory environment.
- Follow the [Monitor changes to federation configuration](../connect/how-to-connect-monitor-federation-changes.md) to set up alerts to monitor changes to the trust established between your Idp and Microsoft Entra ID. 
- Enable multifactor authentication (MFA) for all users that have privileged access in Microsoft Entra ID or in AD. One security issue with using Microsoft Entra provisioning agent is that if an attacker can get control over the Microsoft Entra provisioning agent server they can manipulate users in Microsoft Entra ID. To prevent an attacker from using these capabilities to take over Microsoft Entra accounts, MFA offers protections. For example, even if an attacker manages to reset a user's password using the Microsoft Entra provisioning agent, they still can't bypass the second factor.


## Group Managed Service Accounts

A group Managed Service Account is a managed domain account that provides automatic password management and simplified service principal name (SPN) management. It also offers the ability to delegate the management to other administrators and extends this functionality over multiple servers. Microsoft Entra Cloud Sync supports and uses a gMSA for running the agent. You'll be prompted for administrative credentials during setup, in order to create this account. The account appears as `domain\provAgentgMSA$`. For more information on a gMSA, see [group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview).

### Prerequisites for gMSA

1. The Active Directory schema in the gMSA domain's forest needs to be updated to Windows Server 2012 or later.
2. [PowerShell RSAT modules](/windows-server/remote/remote-server-administration-tools) on a domain controller.
3. At least one domain controller in the domain must be running Windows Server 2012 or later.
4. A domain joined server where the agent is being installed needs to be either Windows Server 2016 or later.

### Custom gMSA account

If you're creating a custom gMSA account, you need to ensure that the account has the following permissions.

|Type |Name |Access |Applies To|
|-----|-----|-----|-----|
|Allow |gMSA Account |Read all properties |Descendant device objects|
|Allow |gMSA Account|Read all properties |Descendant InetOrgPerson objects|
|Allow |gMSA Account |Read all properties |Descendant Computer objects|
|Allow |gMSA Account |Read all properties |Descendant foreignSecurityPrincipal objects|
|Allow |gMSA Account |Full control |Descendant Group objects|
|Allow |gMSA Account |Read all properties |Descendant User objects|
|Allow |gMSA Account |Read all properties |Descendant Contact objects|
|Allow |gMSA Account |Create/delete User objects|This object and all descendant objects|

For steps on how to upgrade an existing agent to use a gMSA account see [group Managed Service Accounts](how-to-install.md#group-managed-service-accounts).

For more information on how to prepare your Active Directory for group Managed Service Account, see [group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview) and [Group managed service accounts with cloud sync](gmsa-cloud-sync.md).

## In the Microsoft Entra admin center

1. Create a cloud-only Hybrid Identity Administrator account on your Microsoft Entra tenant. This way, you can manage the configuration of your tenant if your on-premises services fail or become unavailable. Learn about how to [add a cloud-only Hybrid Identity Administrator account](~/fundamentals/add-users.md). Finishing this step is critical to ensure that you don't get locked out of your tenant.
1. Add one or more [custom domain names](~/fundamentals/add-custom-domain.yml) to your Microsoft Entra tenant. Your users can sign in with one of these domain names.

## In your directory in Active Directory

Run the [IdFix tool](/microsoft-365/enterprise/set-up-directory-synchronization) to prepare the directory attributes for synchronization.

## In your on-premises environment

1. Identify a domain-joined host server running Windows Server 2016 or greater with a minimum of 4-GB RAM and .NET 4.7.1+ runtime.
2. The PowerShell execution policy on the local server must be set to Undefined or RemoteSigned.
3. If there's a firewall between your servers and Microsoft Entra ID, see [Firewall and proxy requirements](#firewall-and-proxy-requirements).

> [!NOTE]
> Installing the cloud provisioning agent on Windows Server Core isn't supported.

[!INCLUDE [pre-requisites](../includes/gpad-prereqs.md)]

## More requirements

- Minimum [Microsoft .NET Framework 4.7.1](https://dotnet.microsoft.com/download/dotnet-framework/net471)

### TLS requirements

> [!NOTE]
> Transport Layer Security (TLS) is a protocol that provides for secure communications. Changing the TLS settings affects the entire forest. For more information, see [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/help/3140245/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-wi).

The Windows server that hosts the Microsoft Entra Connect cloud provisioning agent must have TLS 1.2 enabled before you install it.

To enable TLS 1.2, follow these steps.

1. Set the following registry keys by copying the content into a *.reg* file and then run the file (right select and choose **Merge**):

   ```dos
   Windows Registry Editor Version 5.00

   [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]
   [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]
   "DisabledByDefault"=dword:00000000
   "Enabled"=dword:00000001
   [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server]
   "DisabledByDefault"=dword:00000000
   "Enabled"=dword:00000001
   [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319]
   "SchUseStrongCrypto"=dword:00000001
   ```

1. Restart the server.

## Firewall and Proxy requirements

If there's a firewall between your servers and Microsoft Entra ID, configure the following items:

- Ensure that agents can make *outbound* requests to Microsoft Entra ID over the following ports:

   | Port number | Description |
   | --- | --- |
   | **80** | Downloads the certificate revocation lists (CRLs) while validating the TLS/SSL certificate. |
   | **443** | Handles all outbound communication with the service. |
   | **8080** (optional) | Agents report their status every 10 minutes over port 8080, if port 443 is unavailable. This status is displayed in the Microsoft Entra admin center. |

- If your firewall enforces rules according to the originating users, open these ports for traffic from Windows services that run as a network service.
- Ensure that your proxy supports at least HTTP 1.1 protocol and chunked encoding is enabled.
- If your firewall or proxy allows you to specify safe suffixes, add connections:

#### [Public Cloud](#tab/public-cloud)


  | URL | Description |
  |-----|-----|
  |`*.msappproxy.net`</br>`*.servicebus.windows.net`|The agent uses these URLs to communicate with the Microsoft Entra cloud service. |
  |`*.microsoftonline.com`</br>`*.microsoft.com`</br>`*.msappproxy.com`</br>`*.windowsazure.com`|The agent uses these URLs to communicate with the Microsoft Entra cloud service. |
   |`mscrl.microsoft.com:80` </br>`crl.microsoft.com:80` </br>`ocsp.msocsp.com:80` </br>`www.microsoft.com:80`| The agent uses these URLs to verify certificates.|
   |`login.windows.net`|The agent uses these URLs during the registration process.



#### [U.S. Government Cloud](#tab/us-government-cloud)

 | URL | Description |
 |-----|-----|
 |`*.msappproxy.us`</br>`*.servicebus.usgovcloudapi.net`|The agent uses these URLs to communicate with the Microsoft Entra cloud service. |
 |`mscrl.microsoft.us:80` </br>`crl.microsoft.us:80` </br>`ocsp.msocsp.us:80` </br>`www.microsoft.us:80`| The agent uses these URLs to verify certificates.|
 |`login.windows.us` </br>`secure.aadcdn.microsoftonline-p.com` </br>`*.microsoftonline.us` </br>`*.microsoftonline-p.us` </br>`*.msauth.net` </br>`*.msauthimages.net` </br>`*.msecnd.net`</br>`*.msftauth.net` </br>`*.msftauthimages.net`</br>`*.phonefactor.net` </br>`enterpriseregistration.windows.net`</br>`management.azure.com` </br>`policykeyservice.dc.ad.msft.net`</br>`ctldl.windowsupdate.us:80` </br>`aadcdn.msftauthimages.us` </br>`*.microsoft.us` </br>`msauthimages.us` </br>`mfstauthimages.us`| The agent uses these URLs during the registration process.




- If you're unable to add connections, allow access to the [Azure datacenter IP ranges](https://www.microsoft.com/download/details.aspx?id=41653), which are updated weekly.

---

## NTLM requirement

You shouldn't enable NTLM on the Windows Server that is running the Microsoft Entra provisioning agent and if it is enabled you should make sure you disable it.

## Known limitations

The following are known limitations:

### Delta Synchronization

- Group scope filtering for delta sync doesn't support more than 50,000 members.
- When you delete a group that's used as part of a group scoping filter, users who are members of the group, don't get deleted.
- When you rename the OU or group that's in scope, delta sync doesn't remove the users.

### Provisioning Logs

- Provisioning logs don't clearly differentiate between create and update operations. You could see a create operation for an update and an update operation for a create.

### Group renaming or OU renaming

- If you rename a group or OU in AD that's in scope for a given configuration, the cloud sync job isn't able to recognize the name change in AD. The job doesn't go into quarantine and remains healthy.

### Scoping filter

When using OU scoping filter

- The scoping configuration has a limitation of 4 MB in character length. In a standard tested environment, this translates to approximately 50 separate Organizational Units (OUs) or Security Groups, including its required metadata, for a given configuration.

- Nested OUs are supported (that is, you **can** sync an OU that has 130 nested OUs, but you **can't** sync 60 separate OUs in the same configuration).

### Password Hash Sync

- Using password hash sync with InetOrgPerson isn't supported.

## Next steps

- [What is provisioning?](../what-is-provisioning.md)
- [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md)
