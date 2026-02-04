---
title: Microsoft Entra hybrid join using Microsoft Entra Kerberos (Preview)
description: Explains prerequisites and steps to set up Microsoft Entra hybrid join by using Microsoft Entra .
#customer intent: As a hybrid identity administrator, I want to allow users to join devices to Microsoft Entra ID.
author: nbeesett
ms.author: justinha
ms.reviewer: nbeesett
ms.date: 02/02/2026
ms.topic: how-to
ms.service: entra-id
ms.subservice: devices
---

# Microsoft Entra hybrid join using Microsoft Entra Kerberos (Preview) 

You can use Microsoft Entra Kerberos to perform Microsoft Entra hybrid join for a device without requiring Active Directory Federation Services (ADFS) or Microsoft Entra Connect sync. You get the Microsoft Entra hybrid join behavior instantly without the ADFS setup.

## Use cases

The following use cases are enabled for preview:

- Deploy nonpersistent Virtual Desktop Infrastructure (VDI) with Microsoft Entra hybrid join in a managed environment.
- Deploy Microsoft Entra hybrid join for customers who have or want to use Microsoft Entra Cloud Sync.
- Improve provisioning experience for Azure Virtual Desktop and Windows 365 hybrid deployment.
- Deploy Microsoft Entra hybrid join for a disconnected forest setup where Microsoft Entra Connect Sync can't be used.

## Prerequisites

Make sure you have the following permissions and configuration set up to perform Microsoft Entra hybrid join using Microsoft Entra Kerberos. There are no license requirements.

- **Role requirements**: The user who creates and configures Entra Kerberos Trusted Domain Object must be an Active Directory user who is a member of the Domain Admins group and the Enterprise Admins group and a Microsoft Entra user with the [Hybrid Identity Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator) role. For more information, see [Create and configure Microsoft Entra Kerberos Trusted Domain Object](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow#permissions). 
- **Configure the KDC proxy server Group Policy Object (GPO)**: This prerequisite is only required if you deployed a KDC Proxy Server GPO to your client computer. The user who configures the GPO must be a Domain Admin or be delegated permissions to configure a GPO.
- **Configure Microsoft Entra Device Registration Service Principal**: Add a Kerberos entry to the Microsoft Entra device registration service principal. The user who configures the service principal must have the [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role.
- **Deploy a domain controller that runs Windows Server 2025**: Install at least one domain controller that runs Windows Server 2025 in the Active Directory domain.
- **Configure client computer for Entra Kerberos based join**: You need to deploy Windows 8D or later build on the client computer that you want to register with Entra as Entra hybrid join using Entra Kerberos.

  >[!NOTE]
  >The client computer must have unimpeded network connectivity with the domain controller that runs Windows Server 2025 during join.

- **Configure Service Connection Point (SCP):** You can use Microsoft Entra Connect or write to AD using PowerShell. You can find more details here. 

## Create and configure Microsoft Entra Kerberos Trusted Domain Object

Follow the steps in [How to set up Windows Authentication for Microsoft Entra ID with the incoming trust-based flow](/azure/azure-sql/managed-instance/winauth-azuread-setup-incoming-trust-based-flow#create-and-configure-the-microsoft-entra-kerberos-trusted-domain-object). 

## Configure the KDC proxy server GPO

Skip this section if you didn't deploy the KDC proxy server GPO on your client computers.

1. Find your [Microsoft Entra tenant ID](/azure/active-directory/fundamentals/how-to-find-tenant).
1. Deploy the following Group Policy setting to client machines using the incoming trust-based flow:
   1. Edit the **Administrative Templates\System\Kerberos\Specify KDC proxy servers for Kerberos clients** policy setting.
      - If the policy is **Not Configured**, go to step e.
      - If the policy is **Disabled**, select **Enabled**.
   1. Under **Options**, select **Show...**. This opens the **Show Contents** dialog box.
   
      :::image type="content" source="media/entra-hybrid-join-using-entra-kerberos/show-contents.png" alt-text="Screenshot of dialog box to enable Specify KDC proxy servers for Kerberos clients."lightbox="media/entra-hybrid-join-using-entra-kerberos/show-contents.png":::

   1. Define the KDC proxy servers setting by using the following mapping. Replace `your_Microsoft Entra_tenant_id` with your Microsoft Entra tenant ID. **A blank space appears after https and before the closing / in the value mapping**.

      | **Value name** | **Value** |
      |----|----|
      | KERBEROS.MICROSOFTONLINE.COM | `https login.microsoftonline.com:443:your_Microsoft Entra_tenant_id/kerberos /` |

      :::image type="content" source="media/entra-hybrid-join-using-entra-kerberos/settings.png" alt-text="Screenshot of the Define KDC proxy server settings dialog box."lightbox="media/entra-hybrid-join-using-entra-kerberos/settings.png":::

   1. Select **OK** to close the **Show Contents** dialog box.
   1. In the **Specify KDC proxy servers for Kerberos clients** dialog box, select **Apply**.

### Configure Entra Device Registration Service Principal

1. Install [Microsoft Entra PowerShell](/powershell/entra-powershell/installation).
1. Open an elevated PowerShell session by choosing **Run as administrator**.
1. Run the following PowerShell command and authenticate by using a Microsoft Entra account with the [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role.

   ```powershell
   Connect-Entra -Environment ‘Global’ -Scopes "Application.ReadWrite.All"
   ```

   >[!Note]
   >Azure for US Government and Microsoft sovereign clouds require different environment names. Run `Get-EntraEnvironment` to retrieve the list of predefined environments.

1. Run the following command to check your service principal settings:

   ```powershell
   \$drsSP = Get-EntraServicePrincipal -Filter "AppId eq '01cb2876-7ebd-4aa4-9cc9-d28bd4d359a9'"
   \$drsSP.ServicePrincipalNames
   ```

1. Check the displayed service principal names. If `adrs/enterpriseregistration.windows.net` isn't listed, run the following command to add it:

   ```powershell
   \$spns = \[System.Collections.Generic.List\[string\]\]::new(\$drsSP.ServicePrincipalNames)
   \$kerbSpn = "adrs/enterpriseregistration.windows.net"
   \$spns.Add(\$kerbSpn)
   Set-EntraServicePrincipal -ObjectId \$drsSp.ObjectId -ServicePrincipalNames \$spns
   \$drsSP.ServicePrincipalNames
   ```

   >[!Note]
   >Check the displayed service principal names again. The `adrs/enterpriseregistration.windows.net` service principal name should be listed. Azure for US Government and Microsoft sovereign clouds have different service principal names.

1. Run the following command to check the tags of the service principal:

   ```powershell
   \$drsSP.Tags
   ```

1. Check the displayed tags. If `KerberosPolicy:ExchangeForJwt` isn't listed, run the following command to add it.

   ```powershell
   \$tags = \[System.Collections.Generic.List\[string\]\]::new(\$drsSP.Tags)  
   \$tags.Add("KerberosPolicy:ExchangeForJwt")
   Set-EntraServicePrincipal -ObjectId \$drsSP.ObjectId -Tags \$tags
   ```

Or you can run the following script:

```powershell
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
```

## Deploy a domain controller that runs Windows Server 2025 

1. Sign in to a server that runs Windows Server 2025 as a local administrator. 
1. Start a Windows command session with the **Run as administrator** option.
1. Make sure the server runs 8D or later.
1. Restart the domain controller.

   >[!Note] 
   >You need to install a domain controller that runs Windows Server 2025 in every domain that you want to perform Microsoft Entra hybrid join using Microsoft Entra Kerberos. Make sure you [apply the correct servicing update](https://support.microsoft.com/topic/december-10-2024-kb5048667-os-build-26100-2605-eb529853-d3a2-4c8d-bd0b-5fc6becb629c) or later to your Windows Server 2025 domain controller.

### Configure the client computer for Microsoft Entra Kerberos join

1. Deploy the [Windows 11 24H2 Feb update](https://support.microsoft.com/topic/february-11-2025-kb5051987-os-build-26100-3194-63fb007d-3f52-4b47-85ea-28414a24be2d) or higher on a client computer that isn’t domain joined.
1. Start a Windows command session with the **Run as administrator** option.

1. To test Microsoft Entra hybrid join using Microsoft Entra Kerberos, run the following commands

   ```
   Reg add HKLM\Software\Microsoft\Windows\CurrentVersion\CDJ /f /v FallbackToFedJoin /t REG_DWORD /d 0
   Reg add HKLM\Software\Microsoft\Windows\CurrentVersion\CDJ /f /v FallbackToSyncJoin /t REG_DWORD /d 0
   ```

   >[!Note] 
   >This will force Microsoft Entra hybrid join using Microsoft Entra Kerberos. Kerberos failures prevent the client computer from performing Microsoft Entra hybrid join.

1. Restart the computer.
1. Join the client computer to the Active Directory domain and restart it.
 
## FAQ

**Question**: Can Microsoft Entra hybrid join using Entra Kerberos fail?

**Answer**: A failure can occur if network connectivity is impeded with the domain controller that runs Windows Server 2025 during join, or if other [prerequisites](#prerequisites) are incomplete.

## Troubleshooting

For help with troubleshooting errors, you can follow these articles:

- [Troubleshoot hybrid joined devices](/entra/identity/devices/troubleshoot-hybrid-join-windows-current)
- [Enable Kerberos event logging](/troubleshoot/windows-server/active-directory/enable-kerberos-event-logging)

To collect Kerberos logs, follow these steps:

1. Download and unzip the logging scripts from [https://aka.ms/authscripts](https://aka.ms/authscripts).
1. If you have multiple domain controllers that run Windows Server 2025, disable KDC services on all of them except one. Run the following command to stop the KDC service on a domain controller:

   ```
   net stop kdc
   ```

1. On the remaining domain controller that runs Windows Server 2025 with the KDC service running, open a PowerShell window with administrator privileges, run the following script:
   ```powershell
   start-auth.ps1
   ```
1. On your client computer, open a PowerShell window with administrator privileges, run run the following script:
   ```powershell
   start-auth.ps1
   ```
1. On your client computer, open a cmd window with administrator privileges, run the following command:

   ```
   dsregcmd /join
   ```

1. On your client computer, in the PowerShell window, run the following script:
   ```powershell
   stop-auth.ps1
   ```
1. On your domain controller that runs Windows Server 2025 with the KDC service running, in the PowerShell window, run the following script:
   ```powershell
   stop-auth.ps1
   ```
1. You can restart KDC services on your extra domain controllers that run Windows Server 2025. Run the following command to start the KDC service on a domain controller:

   ```
   net start kdc
   ```

## Kerberos errors

| **Error code** | **Description** | **Reason** | **Resolution** |
|---|---|---|---|
| DSREG_TOKEN_MISSING_ON_PREM_ID(0x801c0095) | The token doesn't contain an on-premises ID. | The Kerberos ticket from the on-premises Kerberos authority doesn't contain information required by Microsoft Entra ID. | On every domain controller that runs Windows Server 2025 within the Active Directory domain, run the tool EnableKerbHaadj.exe and restart. |
| SEC_E_NO_AUTHENTICATING_AUTHORITY(0x80090311) | No authority could be contacted for authentication. | No functional domain controller that runs Windows Server 2025 can be contacted. | Install at least one domain controller that runs Windows Server 2025 in the Active Directory domain. Run the tool EnableKerbHaadj.exe and restart. Make sure the KDC service is running on this domain controller, and this domain controller can be contacted by the computer trying to perform the hybrid join. Run dcdiag.exe on the domain controller and make sure it's advertising itself. |
| SEC_E_TARGET_UNKNOWN (0x80090303) error code in Kerberos event log: KDC_ERR_S_PRINCIPAL_UNKNOWN (0x7) | The specified target is unknown or unreachable. |  |  |
| SEC_E_LOGON_DENIED (0x8009030c) error code in Kerberos event log: KDC_ERR_NULL_KEY (0x9) | The logon attempt failed. Kerberos error: `No KerberosKeyInformation Keys found.` | Kerberos key for the Microsoft Entra device registration service principal isn't found. | Add the tag **KerberosPolicy:ExchangeForJwt** to the service principal. |

## Related content


