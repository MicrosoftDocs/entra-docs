---
title: Microsoft Entra Connect Health agents for AD FS
description: This is the Microsoft Entra Connect Health page how to monitor your on-premises AD FS infrastructure.
ms.reviewer: zhiweiwangmsft
ms.assetid: dc0e53d8-403e-462a-9543-164eaa7dd8b3
ms.subservice: hybrid-connect
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 09/10/2026
ms.custom: H1Hack27Feb2017, sfi-ga-nochange, msecd-doc-authoring-1012
#customer intent: As an identity administrator, I want to install the Microsoft Entra Connect Health agent on my AD FS and Web Application Proxy servers so that I can monitor my federation infrastructure from the Microsoft Entra admin center.
---

# Microsoft Entra Connect Health agents for AD FS

In this article, you learn how to install and configure the Microsoft Entra Connect Health agents.  The following documentation is specific to installation and monitoring your AD FS infrastructure with Microsoft Entra Connect Health. For information on monitoring Microsoft Entra Connect (Sync) with Microsoft Entra Connect Health, see [Using Microsoft Entra Connect Health for Sync](how-to-connect-health-sync.md). Additionally, for information on monitoring Active Directory Domain Services with Microsoft Entra Connect Health, see [Using Microsoft Entra Connect Health with AD DS](how-to-connect-health-adds.md).

Learn how to [download the agents](how-to-connect-install-roadmap.md#download-and-install-azure-ad-connect-health-agent).

> [!NOTE]
> Microsoft Entra Connect Health is not available in the China sovereign cloud.

## Prerequisites

The following table lists requirements for using Microsoft Entra Connect Health:

| Requirement | Description |
| --- | --- |
| You have a Microsoft Entra ID P1 or P2 subscription. |Microsoft Entra Connect Health is a feature of Microsoft Entra ID P1 or P2. For more information, see [Sign up for Microsoft Entra ID P1 or P2](~/fundamentals/get-started-premium.md). <br /><br />To start a free 30-day trial, see [Start a trial](https://azure.microsoft.com/trial/get-started-active-directory/). |
| You're a Global Administrator in Microsoft Entra ID. |Currently, only Global Administrator accounts can install and configure health agents. <br /><br /> By using Azure role-based access control (Azure RBAC), you can allow other users in your organization to access Microsoft Entra Connect Health. For more information, see [Azure RBAC for Microsoft Entra Connect Health](how-to-connect-health-operations.md#manage-access-with-azure-rbac). <br /><br />**Important**: Use a work or school account to install the agents. You can't use a Microsoft account to install the agents. For more information, see [Sign up for Azure as an organization](~/fundamentals/sign-up-organization.md). |
| The Microsoft Entra Connect Health agent is installed on each targeted server. | Health agents must be installed and configured on targeted servers so that they can receive data and provide monitoring and analytics capabilities. <br /><br />For example, to get data from your Active Directory Federation Services (AD FS) infrastructure, you must install the agent on the AD FS server and on the Web Application Proxy server. Similarly, to get data from your on-premises AD Domain Services infrastructure, you must install the agent on the domain controllers. |
| The agent is installed on a supported Windows Server version. | The Microsoft Entra Connect Health agent for AD FS is supported on Windows Server 2016, 2019, 2022, and 2025. |
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

### New versions of the agent and auto upgrade

If a new version of the health agent is released, any existing, installed agents are automatically updated.

<a name="outbound-connectivity-to-the-azure-service-endpoints"></a>

### Outbound connectivity to Azure service endpoints

During installation and runtime, the agent needs connectivity to Microsoft Entra Connect Health service endpoints. If firewalls block outbound connectivity, make sure that the URLs in the following table aren't blocked by default.

Don't disable security monitoring or inspection of these URLs. Instead, allow them as you would allow other internet traffic.

These URLs allow communication with Microsoft Entra Connect Health service endpoints. Later in this article, you'll learn how to [check outbound connectivity](#test-connectivity-to-the-microsoft-entra-connect-health-service) by using `Test-AzureADConnectHealthConnectivity`.

| Domain environment | Required Azure service endpoints |
| --- | --- |
| General public | - `*.blob.core.windows.net` <br />- `*.aadconnecthealth.azure.com` <br />- `**.servicebus.windows.net` - Port: 5671 (If 5671 is blocked, the agent falls back to 443, but we recommend that you use port 5671. This endpoint isn't required in the latest version of the agent.)<br />- `*.adhybridhealth.azure.com/`<br />- `https://management.azure.com` <br />- `https://policykeyservice.dc.ad.msft.net/` <br />- `https://login.windows.net` <br />- `https://login.microsoftonline.com` <br />- `https://secure.aadcdn.microsoftonline-p.com` <br />- `https://www.office.com` (This endpoint is used only for discovery purposes during registration.)<br />- `https://aadcdn.msftauth.net` <br />- `https://aadcdn.msauth.net` <br />- `https://autoupdate.msappproxy.net` <br />- `https://www.microsoft.com` |
| Azure Government | - `*.blob.core.usgovcloudapi.net` <br />- `*.servicebus.usgovcloudapi.net` <br />- `*.aadconnecthealth.microsoftazure.us` <br />- `https://management.usgovcloudapi.net` <br />- `https://policykeyservice.aadcdi.azure.us` <br />- `https://login.microsoftonline.us` <br />- `https://secure.aadcdn.microsoftonline-p.com` <br />- `https://www.office.com` (This endpoint is used only for discovery purposes during registration.)<br />- `https://aadcdn.msftauth.net` <br />- `https://aadcdn.msauth.net` <br />- `https://autoupdate.msappproxy.us` <br />- `http://www.microsoft.com` <br />- `https://www.microsoft.com` |

## Download the agents

To download and install the Microsoft Entra Connect Health agent:

- Make sure that you satisfy the [prerequisites](how-to-connect-health-agent-install.md#prerequisites) to install Microsoft Entra Connect Health.
- Get started using Microsoft Entra Connect Health for AD FS:
  - [Download the Microsoft Entra Connect Health agent for AD FS](https://go.microsoft.com/fwlink/?LinkID=518973).
  - See the [installation instructions](#install-the-agent-for-ad-fs).
- Get started using Microsoft Entra Connect Health for sync:
  - [Download and install the latest version of Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted). The health agent for sync is installed as part of the Microsoft Entra Connect installation [version 2.5.79.0 or higher](reference-connect-version-history.md).
- Get started using Microsoft Entra Connect Health for AD Domain Services:
  - [Download the Microsoft Entra Connect Health agent for AD Domain Services](https://go.microsoft.com/fwlink/?LinkID=820540).

## Install the agent for AD FS

> [!NOTE]
> Your AD FS server should be separate from your sync server. Don't install the AD FS agent on your sync server.
>

> [!NOTE]
> The health agent for sync is installed as part of the Microsoft Entra Connect installation ([version 2.5.79.0 or higher](reference-connect-version-history.md)).  If you attempt to install an earlier version of the health agent for AD FS on the Microsoft Entra Connect server, you will get an error.  If you need to install the health agent for AD FS on the machine, you should [download the latest version](https://go.microsoft.com/fwlink/?LinkID=518973) and then uninstall the version that was installed during the Microsoft Entra Connect installation.


Before you install the agent, make sure your AD FS server host name is unique and isn't present in the AD FS service.

To start the agent installation, double-click the *.exe* file you downloaded. In the first dialog, select **Install**.

:::image type="content" source="media/how-to-connect-health-agent-install/install-1.png" alt-text="Screenshot that shows the installation window for the Microsoft Entra Connect Health AD FS agent.":::

When you're prompted, sign in by using a Microsoft Entra account that has permissions to register the agent. By default, the Hybrid Identity Administrator account has permissions.

:::image type="content" source="media/how-to-connect-health-agent-install/install3.png" alt-text="Screenshot that shows the sign-in window for Microsoft Entra Connect Health AD FS.":::

After you sign in, the installation process will complete and you can close the window.

:::image type="content" source="media/how-to-connect-health-agent-install/install2.png" alt-text="Screenshot that shows the confirmation message for the Microsoft Entra Connect Health AD FS agent installation.":::

At this point, the agent services should start to automatically allow the agent to securely upload the required data to the cloud service.

To verify that the agent was installed, look for the following services on the server. If you completed the configuration, they should already be running. Otherwise, they're stopped until the configuration is complete.

- Microsoft Entra Connect Agent Updater
- Microsoft Entra Connect Health Agent

:::image type="content" source="media/how-to-connect-health-agent-install/install5.png" alt-text="Screenshot that shows Microsoft Entra Connect Health AD FS services.":::

### Enable auditing for AD FS

> [!NOTE]
> This section applies only to AD FS servers. You don't have to complete these steps on Web Application Proxy servers.
>

The Usage Analytics feature needs to gather and analyze data, so the Microsoft Entra Connect Health agent needs the information in the AD FS audit logs. These logs aren't enabled by default. Use the following procedures to enable AD FS auditing and to locate the AD FS audit logs on your AD FS servers.

#### To enable auditing for AD FS 

 1. On the Start screen, open **Server Manager**, and then open **Local Security Policy**. Or, on the taskbar, open **Server Manager**, and then select **Tools/Local Security Policy**.
 2. Go to the *Security Settings\Local Policies\User Rights Assignment* folder. Double-click **Generate security audits**.
 3. On the **Local Security Setting** tab, verify that the AD FS service account is listed. If it's not listed, select **Add User or Group**, and add the AD FS service account to the list. Then select **OK**.
 4. To enable auditing, open a Command Prompt window as administrator, and then run the following command:
    `auditpol.exe /set /subcategory:"Application Generated" /failure:enable /success:enable`

 5. Close **Local Security Policy**.

    > [!IMPORTANT]
    > The remaining steps are required only for primary AD FS servers.

#### Enable audit properties on the AD FS server
1. Open the **AD FS Management** snap-in. (In **Server Manager**, select **Tools** > **AD FS Management**.)
2. In the **Actions** pane, select **Edit Federation Service Properties**.
3. In the **Federation Service Properties** dialog, select the **Events** tab.
4. Select the **Success audits** and **Failure audits** checkboxes, and then select **OK**. Success audits and failure audits should be enabled by default.

#### Enable audit properties on AD FS server
 
>[!IMPORTANT]
>This step is required only for primary AD FS servers.

1. Open a PowerShell window and run the following command:

   `Set-AdfsProperties -AuditLevel Verbose`

The "basic" audit level is enabled by default. For more information, see [AD FS audit enhancement in Windows Server 2016](/windows-server/identity/ad-fs/technical-reference/auditing-enhancements-to-ad-fs-in-windows-server).

#### Verify verbose logging

To verify verbose logging is enabled do the following.

1. Open a PowerShell window and run the following command:

   `Get-AdfsProperties`
 
2. Verify that the Auditlevel is set to verbose

#### Verify AD FS service account audit settings

1. Go to the *Security Settings\Local Policies\User Rights Assignment* folder. Double-click **Generate security audits**.
2. On the **Local Security Setting** tab, verify that the **AD FS service account** is listed. If it's not listed, select Add User or Group, and add the AD FS service account to the list. Then select **OK**.
3. Close **Local Security Policy**.

#### Review the AD FS audit logs

After enabling AD FS audit logs, you should be able to check the AD FS audit logs using Event viewer.

1. Open **Event Viewer**.
2. Go to **Windows Logs**, and then select **Security**.
3. In the right pane, select **Filter Current Logs**.
4. For **Event sources**, select **AD FS Auditing**.


For more information about audit logs, see [Operations questions](./reference-connect-health-faq.yml).

  :::image type="content" source="media/how-to-connect-health-agent-install/adfsaudit.png" alt-text="Screenshot that shows the Filter Current Log window, with AD FS auditing selected.":::

> [!WARNING]
> A group policy can disable AD FS auditing. If AD FS auditing is disabled, usage analytics about login activities are unavailable. Ensure that you have no group policy that disables AD FS auditing.

The following tables provide a list of common events that correspond to audit level events

##### Basic audit level events

|ID|Event Name|Event Description|
|-----|-----|-----|
|1200|AppTokenSuccessAudit|The Federation Service issued a valid token.| 
|1201|AppTokenFailureAudit|The Federation Service failed to issue a valid token.|
|1202|FreshCredentialSuccessAudit|The Federation Service validated a new credential.|
|1203|FreshCredentialFailureAudit|The Federation Service failed to validate a new credential.|



##### Verbose audit level events

|ID|Event Name|Event Description|
|-----|-----|-----|
|299|TokenIssuanceSuccessAudit|A token was successfully issued for the relying party.|
|403|RequestReceivedSuccessAudit|An HTTP request was received. See audit 510 with the same Instance ID for headers.|
|410|RequestContextHeadersSuccessAudit|Following request context headers present|
|411|SecurityTokenValidationFailureAudit|Token validation failed. See inner exception for more details.|
|412|AuthenticationSuccessAudit|A token of type '%3' for relying party '%4' was successfully authenticated. See audit 501 with the same Instance ID for caller identity.|
|500|IssuedIdentityClaims|More information for the event entry with Instance ID %1. There may be more events with the same Instance ID with more information.|
|501|CallerIdentityClaims|More information for the event entry with Instance ID %1. There may be more events with the same Instance ID with more information.|


## Test connectivity to the Microsoft Entra Connect Health service

Occasionally, the Microsoft Entra Connect Health agent loses connectivity with the Microsoft Entra Connect Health service. Causes of this connectivity loss might include network problems, permissions problems, and various other problems.

If the agent can't send data to the Microsoft Entra Connect Health service for longer than two hours, the following alert appears in the portal: **Health Service data is not up to date**.

You can find out whether the affected Microsoft Entra Connect Health agent can upload data to the Microsoft Entra Connect Health service by running the following PowerShell command:

```powershell
Test-AzureADConnectHealthConnectivity -Role ADFS
```

The `Role` parameter currently takes the following values:

- `ADFS`
- `Sync`
- `ADDS`

> [!NOTE]
> To use the connectivity tool, you must first register the agent. If you can't complete the agent registration, make sure that you meet all the [prerequisites](how-to-connect-health-agent-install.md#prerequisites) for Microsoft Entra Connect Health. Connectivity is tested by default during agent registration.

## Monitor AD FS using Microsoft Entra Connect Health

Open [Microsoft Entra Connect Health](https://aka.ms/aadconnecthealth), select **AD FS services**, and then select a service. The service page provides federation server status, alerts, performance and usage charts, and security reports.

![Connect Health AD FS service overview, with callouts for server details, Quick Start, service properties, and alerts.](media/how-to-connect-health-adfs/connect-health-active-directory-federation-services-overview.png)

## Alerts for AD FS
The **Alerts** page lists active and resolved alerts. Use the time-range control to include older resolved alerts, and use search to filter the list. Select an alert row to open the details panel, which contains alert metadata, affected servers, resolution guidance, related documentation, and a feedback option.

## Usage Analytics for AD FS
Microsoft Entra Connect Health Usage Analytics analyzes the authentication traffic of your federation servers. The service page shows application visits from the past 24 hours, including total visits, total applications, and the top applications by traffic.

> [!NOTE]
> To use Usage Analytics with AD FS, you must ensure that AD FS auditing is enabled. For more information, see [Enable Auditing for AD FS](#enable-auditing-for-ad-fs).
>
>

Select **View Usage Details** to open a detailed panel and change the displayed time range.

## Performance Monitoring for AD FS
The **Performance Monitoring** section shows token requests per second for federation servers over the past 24 hours. Select **View detailed monitoring** to open a panel where you can change the time range and select the servers to compare.

![Connect Health AD FS security reporting cards, with callouts for bad-password trends and risky IP activity.](media/how-to-connect-health-adfs/connect-health-active-directory-federation-services-security-reports.png)

## Top 50 Users with failed Username/Password logins
One of the common reasons for a failed authentication request on an AD FS server is a request with invalid credentials, that is, a wrong username or password. Usually happens to users due to complex passwords, forgotten passwords, or typos.

But there are other reasons that can result in an unexpected number of requests being handled by your AD FS servers, such as: An application that caches user credentials and the credentials expire or a malicious user attempting to sign into an account with a series of well-known passwords. These two examples are valid reasons that could lead to a surge in requests.

Microsoft Entra Connect Health for AD FS provides a report about the top 50 users with failed sign-in attempts due to invalid usernames or passwords. The report is generated by processing audit events from all AD FS servers in the farm.

Within this report you have easy access to the following pieces of information:

* Total number of failed requests with a wrong username or password in the last 30 days.
* Daily number of users that failed with a bad username/password sign-in.

On the service page, select the **Bad Password Attempts** report. The report includes a 30-day trend chart and a table of the top 50 users with the most bad-password attempts.

The graph provides the following information:

* The total number of failed sign-ins due to a bad username or password each day.
* The total number of unique users with failed sign-ins each day.
* The client IP address for the last request.

The report provides the following information:

| Report Item | Description |
| --- | --- |
| User ID |Shows the user ID that was used. This value is what the user typed, which in some cases is the wrong user ID being used. |
| Failed Attempts |Shows the total number of failed attempts for that specific user ID. The table is sorted by the number of failed attempts in descending order. |
| Last Failure |Shows the time stamp when the last failure occurred. |
| Last Failure IP |Shows the Client IP address from the latest bad request. If you see more than one IP addresses in this value, it may include forward client IP together with user's last attempt request IP.  |

> [!NOTE]
> This report is automatically updated after every 12 hours with the new information collected within that time. As a result, login attempts within the last 12 hours may not be included in the report.

## Related content
* [Microsoft Entra Connect Health](./whatis-azure-ad-connect.md)
* [Microsoft Entra Connect Health Agent Installation](how-to-connect-health-agent-install.md)
* [Risky IP report](how-to-connect-health-adfs-risky-ip.md)
