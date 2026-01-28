---
title: Microsoft Entra hybrid join using Microsoft Entra Kerberos
description: Explains prerequisites and steps to set up Microsoft Entra hybrid join by using Microsoft Entra .
#customer intent: As a hybrid identity administrator, I want to allow users to join devices to Microsoft Entra ID.
author: nbeesett
ms.author: justinha
ms.reviewer: justinha
ms.date: 01/28/2026
ms.topic: how-to
ms.service: entra-id
ms.subservice: devices
---

# Entra hybrid join using Entra Kerberos Public Preview 

We are excited to announce the Entra hybrid join using Entra Kerberos Public Preview!

With this capability customers will have the ability to do Entra hybrid join without requiring ADFS or Entra Connect sync for devices. This will enable our customers to get the instant Entra hybrid join behavior they have experienced previously when using ADFS setup.

## Use cases

These are the primary use cases we aim to enable during this public preview.

- Deploying non persistent VDI with Entra hybrid join in a managed environment.
- Deploy Entra hybrid join for customers who have or want to use Entra Cloud Sync.
- Improving provisioning experience for Azure Virtual Desktop and Windows 365 hybrid deployment.
- Deploy Entra hybrid join for disconnected forest setup where Entra Connect Sync cannot be used.

## Prerequisites

| Requirements | [Create and configure Microsoft Entra Kerberos Trusted Domain Object](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow?view=azuresql#permissions). The user who creates and configures Entra Kerberos Trusted Domain Object must be an Active Directory user who is a member of the Domain Admins group for a domain and a member of the Enterprise Admins group for a forest and a Microsoft Entra user with the Hybrid Identity Administrators role.<br>**Configure GPO:** Only if you have deployed KDC Proxy Server GPO to your client computer. In terms of permissions, the user configuring GPO is a domain administrator/enterprise administrator/a user who has been delegated permissions to configure GPO.<br>**Configure Entra Device Registration Service Principal**: Add Kerberos entry to Entra device registration service principal. In terms of permissions, the Microsoft Entra user with Application Administrator role.<br>**Deploy Windows Server 2025 DC**: This should be at least one instance for every domain that the client is joined to<br>**Configure client computer for Entra Kerberos based join:** You need to deploy Windows 8D or later build on the client computer that you want to register with Entra as Entra hybrid join using Entra Kerberos.<br> **Note**: The client computer must have line of sight during join with the DC 2025 that supports Kerberos based join.<br>**Configure Service Connection Point (SCP):** You can use Microsoft Entra Connect or write to AD using PowerShell. You can find more details here. |
|---|---|
| Licensing | There are **NO** additional licensing requirements for using this feature. |

## FAQ

- **How many devices are you looking for/expecting the customer to test this on?**

  - Ideally, we would like customers to test the above use cases on at least 5-10 devices and preferably on both Windows 11 and WS 2025 as client computers doing Entra hybrid join.

- **What is Microsoft looking for in terms of feedback?**

  - Validation the use cases mentioned in this doc.

  - Completion of the private preview feedback survey. 

- **Can Entra hybrid join using Entra Kerberos fail?**

  - This is possible if the device does not have line of sight to WS 2025 domain controller during Entra hybrid join. It is also possible if you do not satisfy any of the requirements mentioned in this doc.

- **How do we troubleshoot errors during Entra hybrid join?**

  - You can follow these articles:

> <https://learn.microsoft.com/en-us/entra/identity/devices/troubleshoot-hybrid-join-windows-current>
>
> <https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-kerberos-event-logging>

- To collect Kerberos logs, follow these steps

1.  Download and unzip the logging scripts from <https://aka.ms/authscripts>

2.  If you have multiple 2025 DCs, disable KDC services on all of them except one.

3.  Run “net stop kdc” to stop the KDC service on a DC.

4.  On the remaining 2025 DC with KDC service running, open a PowerShell window with administrator privileges, run start-auth.ps1

5.  On your client computer, open a PowerShell window with administrator privileges, run start-auth.ps1

6.  On your client computer, open a cmd window with administrator privileges, run dsregcmd /join

7.  On your client computer, in the PowerShell window, run stop-auth.ps1

8.  On your 2025 DC, in the PowerShell window, run stop-auth.ps1

9.  You can restart KDC services on your extra 2025 DCs. Run net start kdc in a cmd window

10. Zip and share your log files

> Kerberos errors

| **Error code** | **Description** | **Reason** | **Resolution** |
|---|---|---|---|
| DSREG_TOKEN_MISSING_ON_PREM_ID(0x801c0095) | The token does not contain on-premises ID. | The Kerberos ticket from the on-premises Kerberos authority does not contain information required by Microsoft Entra ID. | On every domain controller running Windows Server 2025 within the AD domain, run the tool EnableKerbHaadj.exe and reboot. |
| SEC_E_NO_AUTHENTICATING_AUTHORITY(0x80090311) | No authority could be contacted for authentication. | No functional Windows Server 2025 DC can be contacted. | Install at least one Windows Server 2025 DC in the AD domain. Run the tool EnableKerbHaadj.exe and reboot.Make sure the KDC service is running on this DC, and this DC can be contacted by the computer trying to hybrid Entra ID join.Run dcdiag.exe on the Windows Server 2025 DC and make sure the DC is advertising itself. |
| SEC_E_TARGET_UNKNOWN (0x80090303)Error code in Kerberos event log: KDC_ERR_S_PRINCIPAL_UNKNOWN (0x7) | The specified target is unknown or unreachable. |  |  |
| SEC_E_LOGON_DENIED (0x8009030c)Error code in Kerberos event log: KDC_ERR_NULL_KEY (0x9) | The logon attempt failed.Kerberos error: No KerberosKeyInformation Keys found. | Kerberos key for the Entra device registration service principal is not found. | Add tag **KerberosPolicy:ExchangeForJwt** to the service principal. |

### Estimated Timing

- **Complexity/time commitment**: 8-10 hours for setup, coordinating with few users, testing and providing feedback. 

## Public Preview Instructions

Follow the steps below to test this capability.

### Create and configure Microsoft Entra Kerberos Trusted Domain Object

1.  Follow this article - [How to set up Windows Authentication for Microsoft Entra ID with the incoming trust-based flow](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow?view=azuresql#create-and-configure-the-microsoft-entra-kerberos-trusted-domain-object)

### Configure GPO

1.  <span class="mark">Skip this section if</span> <span class="mark">you have not deployed</span> <span class="mark">KDC proxy server GPO on your client computers.</span>

2.  Identify your [Microsoft Entra tenant ID](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/how-to-find-tenant).

3.  Deploy the following Group Policy setting to client machines using the incoming trust-based flow:

    1.  Edit the **Administrative Templates\System\Kerberos\Specify KDC proxy servers for Kerberos clients** policy setting.

    2.  <span class="mark">If “Not Configured” is selected, go to step g.</span>

    3.  If “Disabled” is selected, select **Enabled**.

    4.  Under **Options**, select **Show...**. This opens the Show Contents dialog box.

> :::image type="content" source="media/entra-hybird-join-using-entra-kerberos/image1.png" alt-text="Screenshot of dialog box to enable &#39;Specify KDC proxy servers for Kerberos clients&#39;. The &#39;Show Contents&#39; dialog allows input of a value name and the related value.":::

5.  Define the KDC proxy servers settings using mappings as follows. Substitute your Microsoft Entra tenant ID for the your_Azure_AD_tenant_id placeholder. **Note the space following https and before the closing / in the value mapping**.

| **Value name** | **Value** |
|----|----|
| KERBEROS.MICROSOFTONLINE.COM | \<https login.microsoftonline.com:443:your_Azure_AD_tenant_id/kerberos /\> |

> :::image type="content" source="media/entra-hybird-join-using-entra-kerberos/image2.png" alt-text="Screenshot of the &#39;Define KDC proxy server settings&#39; dialog box. A table allows input of multiple rows. Each row consists of a value name and a value.":::

6.  Select **OK** to close the 'Show Contents' dialog box.

7.  Select **Apply** on the 'Specify KDC proxy servers for Kerberos clients' dialog box.

### Configure Entra Device Registration Service Principal

1.  Install [Microsoft Entra PowerShell](https://learn.microsoft.com/en-us/powershell/entra-powershell/installation?view=entra-powershell&tabs=powershell%2Cv1&pivots=windows).

2.  Start a Windows PowerShell session with **Run as administrator** option.

3.  Run the following PowerShell command and authenticate using an Entra account with tenant administrator privileges

Connect-Entra -Environment ‘Global’ -Scopes "Application.ReadWrite.All"

<span class="mark">Note: Entra sovereign clouds require different environment names. Run Get-EntraEnvironment to retrieve the list of predefined environments.</span>

4.  Run the following command to check your service principal settings

\$drsSP = Get-EntraServicePrincipal -Filter "AppId eq '01cb2876-7ebd-4aa4-9cc9-d28bd4d359a9'"

\$drsSP.ServicePrincipalNames

5.  Check the displayed service principal names. If adrs/enterpriseregistration.windows.net is not listed, run the following command to add it.

\$spns = \[System.Collections.Generic.List\[string\]\]::new(\$drsSP.ServicePrincipalNames)

\$kerbSpn = "adrs/enterpriseregistration.windows.net"

\$spns.Add(\$kerbSpn)

Set-EntraServicePrincipal -ObjectId \$drsSp.ObjectId -ServicePrincipalNames \$spns

\$drsSP.ServicePrincipalNames

<span class="mark">Note: Check the displayed service principal names again. This time, adrs/enterpriseregistration.windows.net should be listed.</span>  Entra sovereign clouds could have different service principal names.

6.  Run the following command to check the tags of the service principal

\$drsSP.Tags

7.  Check the displayed tags. If KerberosPolicy:ExchangeForJwt is not listed, run the following command to add it.

\$tags = \[System.Collections.Generic.List\[string\]\]::new(\$drsSP.Tags)  
\$tags.Add("KerberosPolicy:ExchangeForJwt")

Set-EntraServicePrincipal -ObjectId \$drsSP.ObjectId -Tags \$tags

Or you can run the following script

\# Use specific environment for your sovereign cloud

\# Run Get-EntraEnvironment to retrieve the list of predefined environments

Connect-Entra -Environment 'Global' -Scopes "Application.ReadWrite.All"

\# Get the service principal

\$drsSP = Get-EntraServicePrincipal -Filter "AppId eq '01cb2876-7ebd-4aa4-9cc9-d28bd4d359a9'"

\# Prepare both updates

\$needsUpdate = \$false

\$spns = \[System.Collections.Generic.List\[string\]\]::new(\$drsSP.ServicePrincipalNames)

\$tags = \[System.Collections.Generic.List\[string\]\]::new(\$drsSP.Tags)

\# Configure Kerberos SPN

\$kerbSpn = "adrs/enterpriseregistration.windows.net"

if (\$drsSP.ServicePrincipalNames -notcontains \$kerbSpn) {

Write-Host "Kerberos SPN needs to be added"

\$spns.Add(\$kerbSpn)

\$needsUpdate = \$true

}

\# Configure Kerberos policy tag

\$kerberosTag = "KerberosPolicy:ExchangeForJwt"

if (\$drsSP.Tags -notcontains \$kerberosTag) {

Write-Host "Kerberos policy tag needs to be added"

\$tags.Add(\$kerberosTag)

\$needsUpdate = \$true

}

\# Single update operation

if (\$needsUpdate) {

Write-Host "Updating service principal configuration..."

Set-EntraServicePrincipal -ObjectId \$drsSP.Id -ServicePrincipalNames \$spns -Tags \$tags

Write-Host "Service principal configuration updated successfully"

} else {

Write-Host "Service principal already configured correctly"

}

\# Display final configuration

\$drsSP = Get-EntraServicePrincipal -Filter "AppId eq '01cb2876-7ebd-4aa4-9cc9-d28bd4d359a9'"

Write-Host "\`nFinal Configuration:"

Write-Host "SPNs:"

\$drsSP.ServicePrincipalNames \| ForEach-Object { Write-Host " \$\_" }

Write-Host "Tags:"

\$drsSP.Tags \| ForEach-Object { Write-Host " \$\_" }

### Deploy Windows Server 2025 as DC

1.  Start a Windows command session with the **Run as administrator** option.

2.  Ensure the DC is running 8D or later

3.  Reboot the DC.

> <span class="mark">Note: You need to install Windows Server 2025 as a DC for every domain that your client computer is joined to trying to register with Entra as Entra hybrid join. Also note you have the correct servicing update applied (</span><https://support.microsoft.com/en-us/topic/december-10-2024-kb5048667-os-build-26100-2605-eb529853-d3a2-4c8d-bd0b-5fc6becb629c> or higher) <span class="mark">to your Windows Server 2025 DC.</span>

### Configure client computer for Entra Kerberos join

1.  Deploy Windows 11 24H2 Feb update ([February 11, 2025—KB5051987 (OS Build 26100.3194) - Microsoft Support](https://support.microsoft.com/en-us/topic/february-11-2025-kb5051987-os-build-26100-3194-63fb007d-3f52-4b47-85ea-28414a24be2d)) or higher on a client computer that isn’t domain joined.

2.  Start a Windows command session with the **Run as administrator** option.

3.  Run the following command to enable Instant Hybrid Entra ID join:

EnableKerbHaadj.exe (this will be shared with you)

4.  To test Microsoft Entra hybrid join using Entra Kerberos, run the following commands

Reg add HKLM\Software\Microsoft\Windows\CurrentVersion\CDJ /f /v FallbackToFedJoin /t REG_DWORD /d 0

Reg add HKLM\Software\Microsoft\Windows\CurrentVersion\CDJ /f /v FallbackToSyncJoin /t REG_DWORD /d 0

<span class="mark">Note: This will force Microsoft Entra hybrid join via Kerberos. Kerberos failures will prevent the client computer from performing Microsoft Entra hybrid join.</span>

5.  Reboot the computer.

6.  Join the client computer to the Active Directory domain and reboot.

> <span class="mark">Note: If you see Entra hybrid join not being successful, use troubleshooting instructions from the FAQ section to diagnose issues.</span>

## Discussions and reporting issues

As part of the Public Preview, you can ask any queries or report any issues via email to Emily Edwards \<emilyedwards@microsoft.com\> and Navi Beesetti \<nbeesetti@microsoft.com\> and we will respond to you as quickly as we can.

 

## Share your feedback about the preview

After participating in this public preview, please share your feedback [HERE](https://forms.office.com/r/eeHx1w5BJa)!
