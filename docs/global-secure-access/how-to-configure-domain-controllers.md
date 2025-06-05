---
title: How to Configure Microsoft Entra Private Access for Active Directory Domain Controllers
description: Learn how to configure Microsoft Entra Private Access for Active Directory Domain Controllers.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: how-to
ms.date: 06/05/2025
ms.service: global-secure-access
ms.subservice: entra-private-access
ms.reviewer: shkhalid
ai-usage: ai-assisted
---
# How to configure Microsoft Entra Private Access for Active Directory Domain Controllers

This guide describes how to configure Entra Private Access for Active Directory Domain Controllers (DCs). This capability helps strengthen secure access for on-premises users by enforcing conditional access/MFA to on-premises applications that use Kerberos authentication with the DCs.

## Prerequisites

To configure Microsoft Entra Private Access for Active Directory Domain Controllers, you must have:

- The **Global Secure Access Administrator** role in Microsoft Entra ID.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- The client machine is at least Windows 10 and is Microsoft Entra joined or hybrid joined device. The client machine must also have line of sight to the private resources and DC (user is in a corporate network and accessing on-premises resources). User identity used for joining the device and accessing these resources was created in Active Directory (AD) and synced to Entra ID using Entra Connect.  
- The latest Microsoft Entra Private network connector is installed and has a line of sight to the DC. 
- Open inbound port in the Windows Defender Firewall on the DC(s) for TCP port 1337.  
- Identify the Service Principal Names (SPNs) of the private apps that you want to protect. You will later add these to configure the policy for Private Access Sensor(s) that are installed on the DC(s) (Please note that SPNs to be used in the policy are case insensitive and should be an exact match). 
- One Private Access Sensor can be installed on a DC in your environment. To test this capability, you don’t need to install sensors on all DCs. Once sensor is installed, it is installed in an Audit (report-only) mode.   
- As a best practice, we recommend testing this functionality with the private apps first. You can enforce MFA to the DC itself by using its SPN, however, we recommend that you test that at a later stage to avoid any issues of admin lock out.  
- If you have multiple DCs in the sites/domain and would only like to test on one, recommend setting a preferred DC using klist add_bind cmd. In addition, create a FW rule on Windows Defender to block connections to all other DCs in the site except the test DC. 
- Optional: Restrict NTLM v1/v2 and use Kerberos auth in the domain.  

> [!Note]
> Setting the policy Restrict NTLM: NTLM authentication in this domain without performing an impact assessment first might cause service outage for those applications and users still using NTLM authentication.)  
>
> [Auditing and restricting NTLM usage guide | Microsoft Learn](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/jj865674(v=ws.10))
> [Using security policies to restrict NTLM traffic | Microsoft Learn](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/jj865668(v=ws.10))


## Configuration steps

Follow these steps to configure Microsoft Entra Private Access for Active Directory Domain Controllers.

### 1. Download and install the Private Network Connector

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Go to **Global Secure Access** > **Connect** > **Connectors** > **Private Network Connectors**.
1. Download the latest version of the Private Network Connector.
1. Install the connector on a Windows Server that has line of sight to your domain controller.
1. After installation, verify the connector status is **Active** in the Entra portal.

> [!TIP]
> Note the private IP address(es) of your connector(s) (for example, `10.5.0.7`). You will need these later when configuring the Private Access Sensor policy.

### 2. Create a Global Secure Access application

1. Publish the domain controller(s) using their IP addresses or FQDNs to allow the Global Secure Access client to obtain Kerberos tickets.
1. When configuring, add port **88** and select **TCP**.
1. You can configure this in either a Quick Access or Enterprise Application.

### 3. Add Service Principal Names (SPNs) to Quick Access

1. In your Quick Access application, add the SPN(s) you want to secure access to.
1. These SPNs will be delivered to the Private Access Sensor(s) installed on the domain controller(s).

### 4. Assign users and configure Conditional Access

1. In the Entra application where you configured the DCs, assign all users synchronized from Active Directory.
1. Add a Conditional Access policy with Multi-Factor Authentication (MFA) as required.

### 5. Enable the Private Access profile

1. In the Entra portal, go to **Global Secure Access** > **Connect** > **Traffic forwarding** > **Private Access Profile**.
1. Enable the Private Access profile.

### 6. Install the Global Secure Access client

1. Download the latest Global Secure Access Windows client from **Global Secure Access** > **Connect** > **Client download** > **Windows 10/11**.
1. Install the client on a Windows 10/11 device that is Entra joined or hybrid joined.
1. Ensure the client device has line of sight to the private applications and the domain controller.
1. After installation, pause (disable) the client.

### 7. Install the Private Access Sensor on the domain controller

1. Download the Private Access Sensor for DC.
1. Extract the zip file.
1. Install the sensor by running the `PrivateAccessSensorInstaller` batch file, or install the `PrivateAccessSensor` package followed by the `PrivateAccessSensorPolicyRetreiverInstaller` package.
1. During installation, sign in with an Entra ID user when prompted.
1. After installation, verify the sensor status is **Active** in **Global Secure Access** > **Connect** > **Connectors** > **Private access sensor**.

> [!NOTE]
> Installing the sensor creates two JSON policy files (`cloudpolicy` and `localpolicy`) at the sensor installation path.

### 8. Configure Private Access Sensor policy files

1. Confirm that the SPNs configured earlier are present in the `cloudpolicy` file.
1. In the `localpolicy` file, add the private connector IPs to the `SourceIPAllowList` and save.
    - Only Kerberos requests from these connector IPs will be allowed; others will be blocked.
1. Ensure the **Private Access Sensor** and **PaSensorPolicyRetreiverService** services are running.

> [!IMPORTANT]
> The Private Access Sensor is installed in Audit (report-only) mode by default. To enforce MFA, set the `AuditMode` registry key for `PrivateAccessSensor` from `1` to `0`.

#### Breakglass mode

- Private Access Sensor supports a breakglass mode to allow all traffic in emergencies.
- Enable breakglass mode by setting `"IsBreakGlass": true` in the policy file or changing the `TmpBreakglass` registry key from `0` to `1`.
- Changes may take a few minutes to propagate; restarting the sensor is not required.

### 9. Test Entra Private Access for Domain Controllers

1. Keep both the Global Secure Access client and Private Access Sensor(s) turned off.
1. Confirm that the DC FQDN(s)/IP(s) configured in the Quick Access app are present in the Global Secure Access client policy.
    - Check via the Global Secure Access system tray icon: **Advanced Diagnostics** > **Traffic Forwarding Profile**.
1. (Optional) Run `nltest` from your client machine to list domain controllers.
1. Run `klist purge` to clear all Kerberos tickets.
1. Use `klist tgt get cifs/SPN` or access the SMB share to verify access to the target resource.
1. Turn on both Private Access Sensor services (keep the Global Secure Access client off).
1. Attempt to access the SMB file share; the request should be blocked by the sensor.
1. Turn on the Global Secure Access client and access the SPN again; Kerberos tickets should be issued, and MFA may be required based on your Conditional Access policy.
1. Use Advanced Diagnostics in the Global Secure Access client to verify Kerberos traffic is tunneled through Global Secure Access.

### 10. Investigation and troubleshooting

- Use **Event Viewer** to review Private Access Sensor logs.
- To collect Private Access Sensor logs, run `PrivateAccessSensorLogsCollector` from the sensor installation path and share the generated zip file with Microsoft support.
- For Global Secure Access client logs:
    1. Right-click the Global Secure Access tray icon.
    2. Select **Advanced Diagnostics** > **Advanced log collection** > **Collect advanced logs**.
    3. Reproduce your issue, then stop log collection and submit the logs to Microsoft.

> [!TIP]
> If you encounter issues, provide screenshots, command outputs, and collected logs to Microsoft support for further assistance.


## Next steps
- [Learn about traffic profiles](concept-traffic-forwarding.md)
- [Configure per-app access](how-to-configure-per-app-access.md)