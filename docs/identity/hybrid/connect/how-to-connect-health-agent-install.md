---
title: Install the Microsoft Entra Connect Health agents in Microsoft Entra ID
description: Learn how to install the Microsoft Entra Connect Health agents for Active Directory Federation Services (AD FS) and for sync.
author: billmath
manager: femila
ms.service: entra-id
ms.subservice: hybrid-connect
ms.tgt_pltfrm: na
ms.date: 04/09/2025
ms.topic: how-to
ms.author: billmath
ms.custom: sfi-ga-nochange
---
# Install the Microsoft Entra Connect Health agents

In this article, you learn how to install and configure the Microsoft Entra Connect Health agents.

Learn how to [download the agents](how-to-connect-install-roadmap.md#download-and-install-azure-ad-connect-health-agent).

> [!NOTE]
> Microsoft Entra Connect Health is not available in the China sovereign cloud.

## Requirements

The following table lists requirements for using Microsoft Entra Connect Health:

| Requirement | Description |
| --- | --- |
| You have a Microsoft Entra ID P1 or P2 subscription. |Microsoft Entra Connect Health is a feature of Microsoft Entra ID P1 or P2. For more information, see [Sign up for Microsoft Entra ID P1 or P2](~/fundamentals/get-started-premium.md). <br /><br />To start a free 30-day trial, see [Start a trial](https://azure.microsoft.com/trial/get-started-active-directory/). |
| You're a Global Administrator in Microsoft Entra ID. |Currently, only Global Administrator accounts can install and configure health agents. For more information, see [Administering your Microsoft Entra directory](~/fundamentals/whatis.md). <br /><br /> By using Azure role-based access control (Azure RBAC), you can allow other users in your organization to access Microsoft Entra Connect Health. For more information, see [Azure RBAC for Microsoft Entra Connect Health](how-to-connect-health-operations.md#manage-access-with-azure-rbac). <br /><br />**Important**: Use a work or school account to install the agents. You can't use a Microsoft account to install the agents. For more information, see [Sign up for Azure as an organization](~/fundamentals/sign-up-organization.md). |
| The Microsoft Entra Connect Health agent is installed on each targeted server. | Health agents must be installed and configured on targeted servers so that they can receive data and provide monitoring and analytics capabilities. <br /><br />For example, to get data from your Active Directory Federation Services (AD FS) infrastructure, you must install the agent on the AD FS server and on the Web Application Proxy server. Similarly, to get data from your on-premises AD Domain Services infrastructure, you must install the agent on the domain controllers. |
| The Azure service endpoints have outbound connectivity. | During installation and runtime, the agent requires connectivity to Microsoft Entra Connect Health service endpoints. If firewalls block outbound connectivity, add the [outbound connectivity endpoints](how-to-connect-health-agent-install.md#outbound-connectivity-to-azure-service-endpoints) to an allowlist. |
|Outbound connectivity is based on IP addresses. | For information about firewall filtering based on IP addresses, see [Azure IP ranges](https://www.microsoft.com/download/details.aspx?id=56519).|
| TLS inspection for outbound traffic is filtered or disabled. | The agent registration step or data upload operations might fail if there's TLS inspection or termination for outbound traffic at the network layer. For more information, see [Set up TLS inspection](/previous-versions/tn-archive/ee796230(v=technet.10)). |
| Firewall ports on the server are running the agent. |The agent requires the following firewall ports to be open so that it can communicate with the Microsoft Entra Connect Health service endpoints: <br />- TCP port 443 <br />- TCP port 5671 <br /><br />The latest version of the agent doesn't require port 5671. Upgrade to the latest version so that only port 443 is required. For more information, see [Hybrid identity required ports and protocols](./reference-connect-ports.md). |
| If Internet Explorer enhanced security is enabled, allow specified websites. |If Internet Explorer enhanced security is enabled, allow the following websites on the server where you install the agent:<br />- `https://login.microsoftonline.com` <br />- `https://secure.aadcdn.microsoftonline-p.com` <br />- `https://login.windows.net` <br />- `https://aadcdn.msftauth.net` <br />- The federation server for your organization that's trusted by Microsoft Entra ID (for example, `https://sts.contoso.com`). <br /><br />For more information, see [How to configure Internet Explorer](https://support.microsoft.com/help/815141/internet-explorer-enhanced-security-configuration-changes-the-browsing). If you have a proxy in your network, see the note that appears at the end of this table.|
| PowerShell version 5.0 or later is installed. | Windows Server 2016 includes PowerShell version 5.0. |

> [!IMPORTANT]
> Windows Server Core doesn't support installing the Microsoft Entra Connect Health agent.

> [!NOTE]
> If you have a highly locked-down and restricted environment, you need to add more URLs than the URLs the table lists for Internet Explorer enhanced security. Also add URLs that are listed in the table in the next section.

>[!IMPORTANT]
>Microsoft Entra Connect Health now supports installation using the Hybrid Identity Administrator role. If you installed Microsoft Entra Connect Sync using an account with the role, the Entra Connect Health agent will automatically be in active state and you will not need to do a re-install using a Global Administrator account.

### New versions of the agent and auto upgrade

If a new version of the health agent is released, any existing, installed agents are automatically updated.

<a name="outbound-connectivity-to-the-azure-service-endpoints"></a>

### Outbound connectivity to Azure service endpoints

During installation and runtime, the agent needs connectivity to Microsoft Entra Connect Health service endpoints. If firewalls block outbound connectivity, make sure that the URLs in the following table aren't blocked by default.

Don't disable security monitoring or inspection of these URLs. Instead, allow them as you would allow other internet traffic.

These URLs allow communication with Microsoft Entra Connect Health service endpoints. Later in this article, you'll learn how to [check outbound connectivity](#test-connectivity-to-the-azure-ad-connect-health-service) by using `Test-MicrosoftEntraConnectHealthConnectivity`.

| Domain environment | Required Azure service endpoints |
| --- | --- |
| General public | - `*.blob.core.windows.net` <br />- `*.aadconnecthealth.azure.com` <br />- `**.servicebus.windows.net` - Port: 5671 (If 5671 is blocked, the agent falls back to 443, but we recommend that you use port 5671. This endpoint isn't required in the latest version of the agent.)<br />- `*.adhybridhealth.azure.com/`<br />- `https://management.azure.com` <br />- `https://policykeyservice.dc.ad.msft.net/` <br />- `https://login.windows.net` <br />- `https://login.microsoftonline.com` <br />- `https://secure.aadcdn.microsoftonline-p.com` <br />- `https://www.office.com` (This endpoint is used only for discovery purposes during registration.)<br />- `https://aadcdn.msftauth.net` <br />- `https://aadcdn.msauth.net` <br />- `https://autoupdate.msappproxy.net` <br />- `http://www.microsoft.com` <br />- `https://www.microsoft.com` |
| Azure Government | - `*.blob.core.usgovcloudapi.net` <br />- `*.servicebus.usgovcloudapi.net` <br />- `*.aadconnecthealth.microsoftazure.us` <br />- `https://management.usgovcloudapi.net` <br />- `https://policykeyservice.aadcdi.azure.us` <br />- `https://login.microsoftonline.us` <br />- `https://secure.aadcdn.microsoftonline-p.com` <br />- `https://www.office.com` (This endpoint is used only for discovery purposes during registration.)<br />- `https://aadcdn.msftauth.net` <br />- `https://aadcdn.msauth.net` <br />- `https://autoupdate.msappproxy.us` <br />- `http://www.microsoft.com` <br />- `https://www.microsoft.com` |

## Download the agents

To download and install the Microsoft Entra Connect Health agent:

- Make sure that you satisfy the [requirements](how-to-connect-health-agent-install.md#requirements) to install Microsoft Entra Connect Health.
- Get started using Microsoft Entra Connect Health for AD FS:
  - [Download the Microsoft Entra Connect Health agent for AD FS](https://download.microsoft.com/download/07e33770-970b-424b-95a2-e99dfe5f5e8d/MicrosoftEntraConnectHealthAgentSetup.exe).
  - See the [installation instructions](#install-the-agent-for-ad-fs).
- Get started using Microsoft Entra Connect Health for sync:
  - [Download and install the latest version of Microsoft Entra Connect](https://go.microsoft.com/fwlink/?linkid=615771). The health agent for sync is installed as part of the Microsoft Entra Connect installation (version 1.0.9125.0 or later).
- Get started using Microsoft Entra Connect Health for AD Domain Services:
  - [Download the Microsoft Entra Connect Health agent for AD Domain Services](https://download.microsoft.com/download/07e33770-970b-424b-95a2-e99dfe5f5e8d/MicrosoftEntraConnectHealthAgentSetup.exe).
  - See the [installation instructions](#install-the-agent-for-azure-ad-ds).

## Install the agent for AD FS
For information on installing and monitoring AD FS with the Microsoft Entra Connect Health agent, see [Microsoft Entra Connect Health agents for AD FS](how-to-connect-health-adfs.md).

## Install the agent for sync

The Microsoft Entra Connect Health agent for sync is installed automatically in the latest version of Microsoft Entra Connect. To use Microsoft Entra Connect for sync, [download the latest version of Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594) and install it.

To verify that the agent has been installed, look for the following services on the server. If you completed the configuration, the services should already be running. Otherwise, the services are stopped until the configuration is complete.

- Microsoft Entra Connect Agent Updater
- Microsoft Entra Connect Health Agent

:::image type="content" source="media/how-to-connect-health-agent-install/install5.png" alt-text="Screenshot that shows the running Microsoft Entra Connect Health for sync services on the server.":::

> [!NOTE]
> Remember that you must have Microsoft Entra ID P1 or P2 to use Microsoft Entra Connect Health. If you don't have Microsoft Entra ID P1 or P2, you can't complete the configuration in the [Microsoft Entra admin center](https://entra.microsoft.com). For more information, see the [requirements](how-to-connect-health-agent-install.md#requirements).

<a name='manually-register-azure-ad-connect-health-for-sync'></a>

## Manually register Microsoft Entra Connect Health for sync

If the Microsoft Entra Connect Health for sync agent registration fails after you successfully install Microsoft Entra Connect, you can use a PowerShell command to manually register the agent.

> [!IMPORTANT]
> Use this PowerShell command only if the agent registration fails after you install Microsoft Entra Connect.

Manually register the Microsoft Entra Connect Health agent for sync by using the following PowerShell command. The Microsoft Entra Connect Health services will start after the agent has been successfully registered.

`Register-MicrosoftEntraConnectHealthAgent -AttributeFiltering $true -StagingMode (Get-ADSyncScheduler).StagingModeEnabled`

The command takes following parameters:

- `AttributeFiltering`: `$true` (default) if Microsoft Entra Connect isn't syncing the default attribute set and has been customized to use a filtered attribute set. Otherwise, use `$false`.
- `StagingMode`: `$false` (default) if the Microsoft Entra Connect server is *not* in staging mode. If the server is configured to be in staging mode, use `$true`. You can determine if the server is in staging mode with `(Get-ADSyncScheduler).StagingModeEnabled`.

When you're prompted for authentication, use the same Global Administrator account (such as `admin@domain.onmicrosoft.com`) that you used to configure Microsoft Entra Connect.

<a name='install-the-agent-for-azure-ad-ds'></a>

<a name='install-the-agent-for-microsoft-entra-ds'></a>

## Install the agent for AD Domain Services

To start the agent installation, double-click the *.exe* file that you downloaded. In the first window, select **Install**.

:::image type="content" source="media/how-to-connect-health-agent-install/aadconnect-health-adds-agent-install1.png" alt-text="Screenshot that shows the Microsoft Entra Connect Health agent for AD DS installation window.":::

When you're prompted, sign in by using a Microsoft Entra account that has permissions to register the agent. By default, the Hybrid Identity Administrator account has permissions.

:::image type="content" source="media/how-to-connect-health-agent-install/install3.png" alt-text="Screenshot that shows the sign-in window for Microsoft Entra Connect Health AD DS.":::

After you sign in, the installation process will complete and you can close the window.

:::image type="content" source="media/how-to-connect-health-agent-install/install2.png" alt-text="Screenshot that shows the confirmation message for the Microsoft Entra Connect Health AD DS agent installation.":::

At this point, the agent services should start to automatically allow the agent to securely upload the required data to the cloud service.

To verify that the agent was installed, look for the following services on the server. If you completed the configuration, they should already be running. Otherwise, they're stopped until the configuration is complete.

- Microsoft Entra Connect Agent Updater
- Microsoft Entra Connect Health Agent

:::image type="content" source="media/how-to-connect-health-agent-install/install5.png" alt-text="Screenshot that shows Microsoft Entra Connect Health AD DS services.":::

### Quickly install the agent on multiple servers

1. Create a user account in Microsoft Entra ID. Secure the account by using a password.
1. [Assign the Owner role](how-to-connect-health-operations.md#manage-access-with-azure-rbac) for this local Microsoft Entra account in Microsoft Entra Connect Health by using the portal. Assign the role to all service instances.
1. Download the *.exe* MSI file in the local domain controller for the installation.
1. Run the following script. Replace the parameters with your new user account and its password.

    ```powershell
    AdHealthAddsAgentSetup.exe /quiet AddsMonitoringEnabled=1 SkipRegistration=1
    Start-Sleep 30
    $userName = "NEWUSER@DOMAIN"
    $secpasswd = ConvertTo-SecureString "PASSWORD" -AsPlainText -Force
    $myCreds = New-Object System.Management.Automation.PSCredential ($userName, $secpasswd)
    Import-Module "C:\Program Files\Microsoft Azure AD Connect Health Agent\Modules\AdHealthConfiguration"
     
    Register-MicrosoftEntraConnectHealthAgent -Credential $myCreds
    ```

When you finish, you can remove access for the local account by completing one or more of the following tasks:

- Remove the role assignment for the local account for Microsoft Entra Connect Health.
- Rotate the password for the local account.
- Disable the Microsoft Entra local account.
- Delete the Microsoft Entra local account.

## Register the agent by using PowerShell

After you install the relevant agent *setup.exe* file, you can register the agent by using the following PowerShell commands, depending on the role. Open PowerShell as administrator and run the relevant command:

```powershell
Register-MicrosoftEntraConnectHealthAgent
```

> [!NOTE]
> To register against sovereign clouds, use the following command lines:
>
> ```powershell
> Register-MicrosoftEntraConnectHealthAgent -UserPrincipalName upn-of-the-user
> ```

These commands accept `Credential` as a parameter to complete the registration non-interactively or to complete the registration on a computer that runs Server Core. Keep these factors in mind:

- You can capture `Credential` in a PowerShell variable that's passed as a parameter.
- You can provide any Microsoft Entra identity that has permissions to register the agents, and which does *not* have multifactor authentication enabled.
- By default, Global Administrators have permissions to register the agents. You can also allow less-privileged identities to do this step. For more information, see [Azure RBAC](how-to-connect-health-operations.md#manage-access-with-azure-rbac).

```powershell
    $cred = Get-Credential
    Register-MicrosoftEntraConnectHealthAgent -Credential $cred

```

<a name='configure-azure-ad-connect-health-agents-to-use-http-proxy'></a>

## Configure Microsoft Entra Connect Health agents to use HTTP proxy

You can configure Microsoft Entra Connect Health agents to work with an HTTP proxy.

> [!NOTE]
>
> - `Netsh WinHttp set ProxyServerAddress` isn't supported. The agent uses System.Net instead of Windows HTTP Services to make web requests.
> - The configured HTTP proxy address is used to pass through encrypted HTTPS messages.
> - Authenticated proxies (using HTTPBasic) aren't supported.

### Change the agent proxy configuration

To configure the Microsoft Entra Connect Health agent to use an HTTP proxy, you can:

- Import existing proxy settings.
- Specify proxy addresses manually.
- Clear the existing proxy configuration.

> [!NOTE]
> To update the proxy settings, you must restart all Microsoft Entra Connect Health agent services. To restart all the agents, run the following command:
>
> `Restart-Service AzureADConnectHealthAgent*`

#### Import existing proxy settings

You can import Internet Explorer HTTP proxy settings so that Microsoft Entra Connect Health agents can use the settings. On each of the servers that run the health agent, run the following PowerShell command:

```powershell
Set-MicrosoftEntraConnectHealthProxySettings -ImportFromInternetSettings
```

You can import WinHTTP proxy settings so that the Microsoft Entra Connect Health agents can use them. On each of the servers that run the health agent, run the following PowerShell command:

```powershell
Set-MicrosoftEntraConnectHealthProxySettings -ImportFromWinHttp
```

#### Specify proxy addresses manually

You can manually specify a proxy server. On each of the servers that run the health agent, run the following PowerShell command:

```powershell
Set-MicrosoftEntraConnectHealthProxySettings -HttpsProxyAddress address:port
```

Here's an example:

`Set-MicrosoftEntraConnectHealthProxySettings -HttpsProxyAddress myproxyserver:443`

In this example:

- The `address` setting can be a DNS-resolvable server name or an IPv4 address.
- You can omit `port`. If you do, 443 is the default port.

#### Clear the existing proxy configuration

You can clear the existing proxy configuration by running the following command:

```powershell
Set-MicrosoftEntraConnectHealthProxySettings -NoProxy
```

### Read current proxy settings

You can read the current proxy settings by running the following command:

```powershell
Get-MicrosoftEntraConnectHealthProxySettings
```
<a name="test-connectivity-to-azure-ad-connect-health-service"></a>

<a name='test-connectivity-to-the-azure-ad-connect-health-service'></a>

## Test connectivity to the Microsoft Entra Connect Health service

Occasionally, the Microsoft Entra Connect Health agent loses connectivity with the Microsoft Entra Connect Health service. Causes of this connectivity loss might include network problems, permissions problems, and various other problems.

If the agent can't send data to the Microsoft Entra Connect Health service for longer than two hours, the following alert appears in the portal: **Health Service data is not up to date**.

You can find out whether the affected Microsoft Entra Connect Health agent can upload data to the Microsoft Entra Connect Health service by running the following PowerShell command:

```powershell
Test-MicrosoftEntraConnectHealthConnectivity -Role ADFS
```

The `Role` parameter currently takes the following values:

- `ADFS`
- `Sync`
- `ADDS`

> [!NOTE]
> To use the connectivity tool, you must first register the agent. If you can't complete the agent registration, make sure that you meet all the [requirements](how-to-connect-health-agent-install.md#requirements) for Microsoft Entra Connect Health. Connectivity is tested by default during agent registration.

## Next steps

Check out the following related articles:

- [Microsoft Entra Connect Health](./whatis-azure-ad-connect.md)
- [Microsoft Entra Connect Health operations](how-to-connect-health-operations.md)
- [Using Microsoft Entra Connect Health with AD FS](how-to-connect-health-adfs.md)
- [Using Microsoft Entra Connect Health for sync](how-to-connect-health-sync.md)
- [Using Microsoft Entra Connect Health with AD Domain Services](how-to-connect-health-adds.md)
- [Microsoft Entra Connect Health FAQ](reference-connect-health-faq.yml)
- [Microsoft Entra Connect Health version history](reference-connect-health-version-history.md)
