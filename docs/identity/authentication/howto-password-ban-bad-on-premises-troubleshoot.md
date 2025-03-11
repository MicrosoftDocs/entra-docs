---
title: Troubleshoot on-premises Microsoft Entra Password Protection
description: Learn how to troubleshoot Microsoft Entra Password Protection for an on-premises Active Directory Domain Services environment

ms.service: entra-id
ms.subservice: authentication
ms.topic: troubleshooting
ms.date: 03/04/2025

ms.author: justinha
author: justinha
manager: femila
ms.reviewer: jsimmons
---
# Troubleshoot: On-premises Microsoft Entra Password Protection

After the deployment of Microsoft Entra Password Protection, troubleshooting may be required. This article goes into detail to help you understand some common troubleshooting steps.

## The DC agent can't locate a proxy in the directory

The main symptom of this problem is 30,017 events in the DC agent Admin event log.

The usual cause of this issue is that a proxy hasn't been registered. If a proxy is registered, there may be some delay due to AD replication latency until a particular DC agent is able to see that proxy.

## The DC agent isn't able to communicate with a proxy

The main symptom of this problem is 30,018 events in the DC agent Admin event log. This problem may have several possible causes:

* The DC agent is located in an isolated portion of the network that doesn't allow network connectivity to the registered proxy(s). This problem may be benign as long as other DC agents can communicate with the proxy(s) in order to download password policies from Azure. Once downloaded, those policies are obtained by the isolated DC via replication of the policy files in the sysvol share.

* The proxy host machine is blocking access to the RPC endpoint mapper endpoint (port 135)

   The Microsoft Entra Password Protection Proxy installer automatically creates a Windows Firewall inbound rule that allows access to port 135. If this rule is later deleted or disabled, DC agents are unable to communicate with the Proxy service. If the builtin Windows Firewall is disabled in lieu of another firewall product, you must configure that firewall to allow access to port 135.

* The proxy host machine is blocking access to the RPC endpoint (dynamic or static) listened on by the Proxy service

   The Microsoft Entra Password Protection Proxy installer automatically creates a Windows Firewall inbound rule that allows access to any inbound ports listened to by the Microsoft Entra Password Protection Proxy service. If this rule is later deleted or disabled, DC agents are unable to communicate with the Proxy service. If the builtin Windows Firewall is disabled in lieu of another firewall product, you must configure that firewall to allow access to any inbound ports listened to by the Microsoft Entra Password Protection Proxy service. This configuration may be made more specific if the Proxy service is configured to listen on a specific static RPC port (using the `Set-AzureADPasswordProtectionProxyConfiguration` cmdlet).

* The proxy host machine isn't configured to allow domain controllers the ability to sign-in to the machine. This behavior is controlled via the "Access this computer from the network" user privilege assignment. All domain controllers in all domains in the forest must be granted this privilege. This setting is often constrained as part of a larger network hardening effort.

## Proxy service is unable to communicate with Azure

1. Ensure the proxy machine has connectivity to the endpoints listed in the [deployment requirements](howto-password-ban-bad-on-premises-deploy.md).

1. Ensure that the forest and all proxy servers are registered against the same Azure tenant.

   You can check this requirement by running the  `Get-AzureADPasswordProtectionProxy` and `Get-AzureADPasswordProtectionDCAgent` PowerShell cmdlets, then compare the `AzureTenant` property of each returned item. For correct operation, the reported tenant name must be the same across all DC agents and proxy servers.

   If an Azure tenant registration mismatch condition does exist, this problem can be fixed by running the `Register-AzureADPasswordProtectionProxy` and/or `Register-AzureADPasswordProtectionForest` PowerShell cmdlets as needed, making sure to use credentials from the same Azure tenant for all registrations.

## DC agent is unable to encrypt or decrypt password policy files

Microsoft Entra Password Protection has a critical dependency on the encryption and decryption functionality supplied by the Microsoft Key Distribution Service. Encryption or decryption failures can manifest with various symptoms and have several potential causes.

* Ensure that the KDS service is enabled and functional on all Windows Server 2012 and later domain controllers in a domain.

   By default the KDS service's service start mode is configured as Manual (Trigger Start). This configuration means that the first time a client tries to use the service, it's started on-demand. This default service start mode is acceptable for Microsoft Entra Password Protection to work.

   If the KDS service start mode is configured to Disabled, this configuration must be fixed before Microsoft Entra Password Protection can function properly.

   A simple test for this issue is to manually start the KDS service, either via the Service Management MMC console, or using other management tools (for example, run "net start kdssvc" from a command prompt console). The KDS service is expected to start successfully and stay running.

   The most common root cause for the KDS service being unable to start is that the Active Directory domain controller object is located outside of the default Domain Controllers OU. This configuration isn't supported by the KDS service and isn't a limitation imposed by Microsoft Entra Password Protection. The fix for this condition is to move the domain controller object to a location under the default Domain Controllers OU.

* Incompatible KDS encrypted buffer format change from Windows Server 2012 R2 to Windows Server 2016

   A KDS security fix was introduced in Windows Server 2016 that modifies the format of KDS encrypted buffers. These buffers sometimes fail to decrypt on Windows Server 2012 and Windows Server 2012 R2. The reverse direction is okay. Buffers that are KDS-encrypted on Windows Server 2012 and Windows Server 2012 R2 always successfully decrypt on Windows Server 2016 and later. If the domain controllers in your Active Directory domains are running a mix of these operating systems, occasional Microsoft Entra Password Protection decryption failures may be reported. It isn't possible to accurately predict the timing or symptoms of these failures given the nature of the security fix. Also, given that it's non-deterministic which Microsoft Entra Password Protection DC Agent on which domain controller encrypts data at a given time.

   There's no workaround for this issue other than to not run a mix of these incompatible operating systems in your Active Directory domain(s). In other words, you should run only Windows Server 2012 and Windows Server 2012 R2 domain controllers, OR you should only run Windows Server 2016 and above domain controllers.

## DC agent thinks the forest hasn't been registered

The symptom of this issue is 30,016 events getting logged in the DC Agent\Admin channel that says in part:

```text
The forest hasn't been registered with Azure. Password policies can't be downloaded from Azure unless this is corrected.
```

There are two possible causes for this issue.

* The forest hasn't been registered. To resolve the problem, run the Register-AzureADPasswordProtectionForest command as described in the [deployment requirements](howto-password-ban-bad-on-premises-deploy.md).
* The forest is registered, but the DC agent is unable to decrypt the forest registration data. This case has the same root cause as issue #2 listed under [DC agent is unable to encrypt or decrypt password policy files](howto-password-ban-bad-on-premises-troubleshoot.md#dc-agent-is-unable-to-encrypt-or-decrypt-password-policy-files). An easy way to confirm this theory is that you'll see this error only on DC agents running on Windows Server 2012 or Windows Server 2012R2 domain controllers, while DC agents running on Windows Server 2016 and later domain controllers are fine. The workaround is the same: upgrade all domain controllers to Windows Server 2016 or later.

## Weak passwords are being accepted but should not be

This problem may have several causes.

*  Your DC agent(s) are running a public preview software version that's expired. See [Public preview DC agent software has expired](howto-password-ban-bad-on-premises-troubleshoot.md#public-preview-dc-agent-software-has-expired).

* Your DC agent(s) can't download a policy or is unable to decrypt existing policies. Check for possible causes in the prior articles.

* The password policy Enforce mode is still set to Audit. If this configuration is in effect, reconfigure it to Enforce using the Microsoft Entra Password Protection portal. For more information, see [Modes of operation](howto-password-ban-bad-on-premises-operations.md#modes-of-operation).

* The password policy is disabled. If this configuration is in effect, reconfigure it to enabled using the Microsoft Entra Password Protection portal. For more information, see [Modes of operation](howto-password-ban-bad-on-premises-operations.md#modes-of-operation).

* You haven't installed the DC agent software on all domain controllers in the domain. In this situation, it's difficult to ensure that remote Windows clients target a particular domain controller during a password change operation. If you think you successfully targeted a particular DC where the DC agent software is installed, you can verify by double-checking the DC agent admin event log: regardless of outcome, there is at least one event to document the outcome of the password validation. If there's no event present for the user whose password is changed, then the password change was likely processed by a different domain controller.

   As an alternative test, try setting\changing passwords while logged in directly to a DC where the DC agent software is installed. This technique isn't recommended for production Active Directory domains.

   While incremental deployment of the DC agent software is supported subject to these limitations, Microsoft strongly recommends that the DC agent software is installed on all domain controllers in a domain as soon as possible.

* The password validation algorithm may actually be working as expected. See [How are passwords evaluated](concept-password-ban-bad.md#how-are-passwords-evaluated).

## Ntdsutil.exe fails to set a weak DSRM password

Active Directory always validates a new Directory Services Repair Mode password to make sure it meets the domain's password complexity requirements; this validation also calls into password filter dlls like Microsoft Entra Password Protection. If the new DSRM password is rejected, the following error message results:

```text
C:\>ntdsutil.exe
ntdsutil: set dsrm password
Reset DSRM Administrator Password: reset password on server null
Please type password for DS Restore Mode Administrator Account: ********
Please confirm new password: ********
Setting password failed.
        WIN32 Error Code: 0xa91
        Error Message: Password doesn't meet the requirements of the filter dll's
```

When Microsoft Entra Password Protection logs the password validation event log event(s) for an Active Directory DSRM password, it's expected that the event log messages won't include a user name. This behavior occurs because the DSRM account is a local account that isn't part of the actual Active Directory domain.  

## Domain controller replica promotion fails because of a weak DSRM password

During the DC promotion process, the new Directory Services Repair Mode password is submitted to an existing DC in the domain for validation. If the new DSRM password is rejected, the following error message results:

```powershell
Install-ADDSDomainController : Verification of prerequisites for Domain Controller promotion failed. The Directory Services Restore Mode password doesn't meet a requirement of the password filter(s). Supply a suitable password.
```

Just like in the previous issue, any Microsoft Entra Password Protection password validation outcome event will have empty user names for this scenario.

## Domain controller demotion fails due to a weak local Administrator password

It's supported to demote a domain controller that is still running the DC agent software. Administrators should be aware however that the DC agent software continues to enforce the current password policy during the demotion procedure. The new local Administrator account password (specified as part of the demotion operation) is validated like any other password. Microsoft recommends that secure passwords be chosen for local Administrator accounts as part of a DC demotion procedure.

Once the demotion is successful, and the domain controller is rebooted and is again running as a normal member server, the DC agent software reverts to running in a passive mode. It may then be uninstalled at any time.

## Booting into Directory Services Repair Mode

If the domain controller is booted into Directory Services Repair Mode, the DC agent password filter dll detects this condition and causes all password validation or enforcement activities to be disabled, regardless of the currently active policy configuration. The DC agent password filter dll logs a 10023 warning event to the Admin event log, for example:

```text
The password filter dll is loaded but the machine appears to be a domain controller that is booted into Directory Services Repair Mode. All password change and set requests are automatically approved. No further messages are logged until after the next reboot.
```
## Public preview DC agent software has expired

During the Microsoft Entra Password Protection public preview period, the DC agent software was hard-coded to stop processing password validation requests on the following dates:

* Version 1.2.65.0 stopped processing password validation requests on September 1 2019.
* Version 1.2.25.0 and prior stopped processing password validation requests on July 1 2019.

As the deadline approaches, all time-limited DC agent versions emit a 10021 event in the DC agent Admin event log at boot time that looks like this:

```text
The password filter dll has successfully loaded and initialized.

The allowable trial period is nearing expiration. Once the trial period has expired, the password filter dll no longer processes passwords. Please contact Microsoft for a newer supported version of the software.

Expiration date:  9/01/2019 0:00:00 AM

This message won't be repeated until the next reboot.
```

Once the deadline has passed, all time-limited DC agent versions emit a 10022 event in the DC agent Admin event log at boot time that looks like this:

```text
The password filter dll is loaded but the allowable trial period has expired. All password change and set requests are automatically approved. Please contact Microsoft for a newer supported version of the software.

No further messages are logged until after the next reboot.
```

Since the deadline is only checked on initial boot, you may not see these events until long after the calendar deadline has passed. Once the deadline is recognized, no negative effects on either the domain controller or the larger environment occur other than all passwords are automatically approved.

> [!IMPORTANT]
> Microsoft recommends that expired public preview DC agents be immediately upgraded to the latest version.

An easy way to discover DC agents in your environment that need to be upgrade is by running the `Get-AzureADPasswordProtectionDCAgent` cmdlet, for example:

```powershell
PS C:\> Get-AzureADPasswordProtectionDCAgent

ServerFQDN            : bpl1.bpl.com
SoftwareVersion       : 1.2.125.0
Domain                : bpl.com
Forest                : bpl.com
PasswordPolicyDateUTC : 8/1/2019 9:18:05 PM
HeartbeatUTC          : 8/1/2019 10:00:00 PM
AzureTenant           : bpltest.onmicrosoft.com
```

For this article, the SoftwareVersion field is obviously the key property to look at. You can also use PowerShell filtering to filter out DC agents that are already at or above the required baseline version, for example:

```powershell
PS C:\> $LatestAzureADPasswordProtectionVersion = "1.2.125.0"
PS C:\> Get-AzureADPasswordProtectionDCAgent | Where-Object {$_.SoftwareVersion -lt $LatestAzureADPasswordProtectionVersion}
```

The Microsoft Entra Password Protection Proxy software isn't time-limited in any version. Microsoft still recommends that both DC and proxy agents be upgraded to the latest versions as they're released. The `Get-AzureADPasswordProtectionProxy` cmdlet may be used to find Proxy agents that require upgrades, similar to the example above for DC agents.

Refer to [Upgrading the DC agent](howto-password-ban-bad-on-premises-deploy.md#upgrading-the-dc-agent) and [Upgrading the Proxy service](howto-password-ban-bad-on-premises-deploy.md#upgrading-the-proxy-service) for more details on specific upgrade procedures.

## Emergency remediation

If a situation occurs where the DC agent service is causing problems, the DC agent service may be immediately shut down. The DC agent password filter dll still attempts to call the non-running service and logs warning events (10012, 10013), but all incoming passwords are accepted during that time. The DC agent service may then also be configured via the Windows Service Control Manager with a startup type of “Disabled” as needed.

Another remediation measure would be to set the Enable mode to No in the Microsoft Entra Password Protection portal. Once the updated policy is downloaded, each DC agent service shifts into a quiescent mode where all passwords are accepted as-is. For more information, see [Modes of operation](howto-password-ban-bad-on-premises-operations.md#modes-of-operation).

## Removal

If you decide to uninstall the Microsoft Entra password protection software and cleanup all related state from the domain(s) and forest, this task can be accomplished using the following steps:

> [!IMPORTANT]
> It's important to perform these steps in order. If any instance of the Proxy service is left running, it periodically re-creates its serviceConnectionPoint object. If any instance of the DC agent service is left running, it periodically re-creates its serviceConnectionPoint object and the sysvol state.

1. Uninstall the Proxy software from all machines. This step does **not** require a reboot.
2. Uninstall the DC Agent software from all domain controllers. This step **requires** a reboot.
3. Manually remove all Proxy service connection points in each domain naming context. The location of these objects may be discovered with the following Active Directory PowerShell command:

   ```powershell
   $scp = "serviceConnectionPoint"
   $keywords = "{ebefb703-6113-413d-9167-9f8dd4d24468}*"
   Get-ADObject -SearchScope Subtree -Filter { objectClass -eq $scp -and keywords -like $keywords }
   ```

   Don't omit the asterisk (“*”) at the end of the $keywords variable value.

   The resulting object(s) found via the `Get-ADObject` command can then be piped to `Remove-ADObject`, or deleted manually.

4. Manually remove all DC agent connection points in each domain naming context. There may be one these objects per domain controller in the forest, depending on how widely the software was deployed. The location of that object may be discovered with the following Active Directory PowerShell command:

   ```powershell
   $scp = "serviceConnectionPoint"
   $keywords = "{2bac71e6-a293-4d5b-ba3b-50b995237946}*"
   Get-ADObject -SearchScope Subtree -Filter { objectClass -eq $scp -and keywords -like $keywords }
   ```

   The resulting object(s) found via the `Get-ADObject` command can then be piped to `Remove-ADObject`, or deleted manually.

   Don't omit the asterisk (“*”) at the end of the $keywords variable value.

5. Manually remove the forest-level configuration state. The forest configuration state is maintained in a container in the Active Directory configuration naming context. It can be discovered and deleted as follows:

   ```powershell
   $passwordProtectionConfigContainer = "CN=Azure AD Password Protection,CN=Services," + (Get-ADRootDSE).configurationNamingContext
   Remove-ADObject -Recursive $passwordProtectionConfigContainer
   ```

6. Manually remove all sysvol related state by manually deleting the following folder and all of its contents:

   `\\<domain>\sysvol\<domain fqdn>\AzureADPasswordProtection`

   If necessary, this path may also be accessed locally on a given domain controller; the default location would be something like the following path:

   `%windir%\sysvol\domain\Policies\AzureADPasswordProtection`

   This path is different if the sysvol share is configured in a non-default location.

## Health testing with PowerShell cmdlets

The AzureADPasswordProtection PowerShell module includes two health-related cmdlets that perform basic verification that the software is installed and working. It's a good idea to run these cmdlets after setting up a new deployment, periodically thereafter, and when a problem is being investigated.

Each individual health test returns a basic Passed or Failed result, plus an optional message on failure. In cases where the cause of a failure isn't clear, look for error event log messages that may explain the failure. Enabling text-log messages may also be useful. For more details, see [Monitor Microsoft Entra Password Protection](howto-password-ban-bad-on-premises-monitor.md).

## Proxy health testing

The Test-AzureADPasswordProtectionProxyHealth cmdlet supports two health tests that can be run individually. A third mode allows for the running of all tests that don't require any parameter input.

### Proxy registration verification

This test verifies that the Proxy agent is properly registered with Azure and is able to authenticate to Azure. A successful run looks like this:

```powershell
PS C:\> Test-AzureADPasswordProtectionProxyHealth -VerifyProxyRegistration

DiagnosticName          Result AdditionalInfo
--------------          ------ --------------
VerifyProxyRegistration Passed
```

If an error is detected, the test returns a Failed result and an optional error message. Here's an example of one possible failure:

```powershell
PS C:\> Test-AzureADPasswordProtectionProxyHealth -VerifyProxyRegistration

DiagnosticName          Result AdditionalInfo
--------------          ------ --------------
VerifyProxyRegistration Failed No proxy certificates were found - please run the Register-AzureADPasswordProtectionProxy cmdlet to register the proxy.
```

### Proxy verification of end-to-end Azure connectivity

This test is a superset of the -VerifyProxyRegistration test. It requires that the Proxy agent is properly registered with Azure, is able to authenticate to Azure, and finally adds a check that a message can be successfully sent to Azure thus verifying full end-to-end communication is working.

A successful run looks like this:

```powershell
PS C:\> Test-AzureADPasswordProtectionProxyHealth -VerifyAzureConnectivity

DiagnosticName          Result AdditionalInfo
--------------          ------ --------------
VerifyAzureConnectivity Passed
```

### Proxy verification of all tests

This mode allows for the bulk running of all tests supported by the cmdlet that don't require parameter input. A successful run looks like this:

```powershell
PS C:\> Test-AzureADPasswordProtectionProxyHealth -TestAll

DiagnosticName          Result AdditionalInfo
--------------          ------ --------------
VerifyTLSConfiguration  Passed
VerifyProxyRegistration Passed
VerifyAzureConnectivity Passed
```

## DC Agent health testing

The Test-AzureADPasswordProtectionDCAgentHealth cmdlet supports several health tests that can be run individually. A third mode allows for the running of all tests that don't require any parameter input.

### Basic DC agent health tests

The following tests can all be run individually and don't accept parameters. A brief description of each test is listed in the following table.

|DC agent health test|Description|
| --- | :---: |
|-VerifyPasswordFilterDll|Verifies that the password filter dll is currently loaded and is able to call the DC agent service|
|-VerifyForestRegistration|Verifies that the forest is currently registered|
|-VerifyEncryptionDecryption|Verifies that basic encryption and decryption is working using the Microsoft KDS service|
|-VerifyDomainIsUsingDFSR|Verifies that the current domain is using DFSR for sysvol replication|
|-VerifyAzureConnectivity|Verifies end-to-end communication with Azure is working using any available proxy|

What follows is an example of the -VerifyPasswordFilterDll test passing, and other successful tests look similar:

```powershell
PS C:\> Test-AzureADPasswordProtectionDCAgentHealth -VerifyPasswordFilterDll

DiagnosticName          Result AdditionalInfo
--------------          ------ --------------
VerifyPasswordFilterDll Passed
```

### DC agent verification of all tests

This mode allows for the bulk running of all tests supported by the cmdlet that don't require parameter input. A successful run looks like this:

```powershell
PS C:\> Test-AzureADPasswordProtectionDCAgentHealth -TestAll

DiagnosticName             Result AdditionalInfo
--------------             ------ --------------
VerifyPasswordFilterDll    Passed
VerifyForestRegistration   Passed
VerifyEncryptionDecryption Passed
VerifyDomainIsUsingDFSR    Passed
VerifyAzureConnectivity    Passed
```

### Connectivity testing using specific proxy servers

Many troubleshooting situations involve investigating network connectivity between DC agents and proxies. There are two health tests available to focus on such issues specifically. These tests require that a particular proxy server be specified.

#### Verifying connectivity between a DC agent and a specific proxy

This test validates connectivity over the first communication leg from the DC agent to the proxy. It verifies that the proxy receives the call, however no communication with Azure is involved. A successful run looks like this:

```powershell
PS C:\> Test-AzureADPasswordProtectionDCAgentHealth -VerifyProxyConnectivity bpl2.bpl.com

DiagnosticName          Result AdditionalInfo
--------------          ------ --------------
VerifyProxyConnectivity Passed
```

Here's an example failure condition where the proxy service running on the target server is stopped:

```powershell
PS C:\> Test-AzureADPasswordProtectionDCAgentHealth -VerifyProxyConnectivity bpl2.bpl.com

DiagnosticName          Result AdditionalInfo
--------------          ------ --------------
VerifyProxyConnectivity Failed The RPC endpoint mapper on the specified proxy returned no results; please check that the proxy service is running on that server.
```

#### Verifying connectivity between a DC agent and Azure (using a specific proxy)

This test validates full end-to-end connectivity between a DC agent and Azure using a specific proxy. A successful run looks like this:

```powershell
PS C:\> Test-AzureADPasswordProtectionDCAgentHealth -VerifyAzureConnectivityViaSpecificProxy bpl2.bpl.com

DiagnosticName                          Result AdditionalInfo
--------------                          ------ --------------
VerifyAzureConnectivityViaSpecificProxy Passed
```

## Next steps

[Frequently asked questions for Microsoft Entra Password Protection](howto-password-ban-bad-on-premises-faq.yml)

For more information on the global and custom banned password lists, see the article [Ban bad passwords](concept-password-ban-bad.md)
