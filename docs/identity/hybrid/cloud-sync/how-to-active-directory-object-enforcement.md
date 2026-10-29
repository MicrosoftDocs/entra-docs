---
title: Microsoft Entra AD object enforcement
description: Configure the AD enforcement preview so that synced Active Directory objects can only be modified by the Microsoft Entra Cloud Sync provisioning service.
author: dhanyahk
ms.author: dhanyahk
manager: mwongerapk
ms.service: entra-id
ms.subservice: hybrid-cloud-sync
ms.topic: how-to
ms.custom: msecd-doc-authoring-1023
ms.date: 10/29/2026
ai-usage: ai-assisted

#customer intent: As a hybrid identity administrator, I want to restrict modifications of provisioned Active Directory users and groups to the Microsoft Entra Cloud Sync provisioning service so that on-premises changes can't bypass Microsoft Entra governance.

---

# Configure AD user and group enforcement in Microsoft Entra Cloud Sync

Microsoft Entra Cloud Sync can provision cloud users and groups to on-premises Active Directory (AD). AD object enforcement lets you protect specific provisioned users and groups so that modifications can only be performed through the Microsoft Entra provisioning service. This article explains how to enable the enforcement engine, configure its shared policy, and mark users and groups for enforcement.

Before you begin, make sure your domain controllers, provisioning agent, AD schema, and administrative access meet the prerequisites.

<a name='before-you-begin'></a>

## Prerequisites

Make sure the following prerequisites are already in place before you start the configuration steps.

| Prerequisite | Details |
| --- | --- |
| Microsoft Entra license | A Microsoft Entra tenant with the licenses required for provisioning users and groups to AD. See [License requirements](overview-provision-entra-id-to-active-directory.md#license-requirements). |
| AD role | Domain Admin, to run the PowerShell commands that create and maintain the policy object. Use this privilege only while installing or changing the policy. Remove or deactivate the privileged access when you're finished, following your organization's just-in-time privileged-access process. |
| Supported domain controller OS and update level on every writable DC | All writable domain controllers must be updated before you enable enforcement: **Windows Server 2022** requires October 13, 2026 — **KB5126655** (**OS Build 20348.5761**) or later; **Windows Server 2025** requires October 13, 2026 — **KB5126646** (**OS Build 26100.33650**) or later. |
| Provisioning agent host | A domain-joined server that meets the [Cloud Sync agent requirements](how-to-prerequisites.md#cloud-provisioning-agent-requirements). We recommend Windows Server 2025 or Windows Server 2022. The agent doesn't have to run on a domain controller. |
| ADSyncTools PowerShell module | Install and import **ADSyncTools** version **2.6.0** or later on the machine where you run the policy cmdlets. |
| No domain functional level requirement | Enforcement doesn't require raising the domain or forest functional level. It's an operational requirement to enable every writable domain controller, not a functional-level setting. |
| Schema | Uses the existing `msDS-ObjectSoa` attribute, present since the Windows Server 2016 schema. No schema extension is required. |
| Domain controller inventory | Maintain an inventory of all writable domain controllers in the domain. For guidance, see [View the list of domain controllers](/powershell/module/activedirectory/get-addomaincontroller). |
| Provisioning to AD configured | A Microsoft Entra ID to AD configuration that provisions the users or groups you want to enforce. See [Tutorial: Govern access to an on-premises app from Microsoft Entra ID](tutorial-users-groups-provisioning-walkthrough.md). |

> [!WARNING]
> If any writable domain controller can't be brought to a supported OS and update level, it can't participate, and enforcement can't be configured for the domain.

For the full list of provisioning agent prerequisites, see [Prerequisites for provisioning from Microsoft Entra ID to Active Directory](how-to-prerequisites-provision-entra-to-active-directory.md).

<a name='how-ad-group-enforcement-works'></a> <a name='how-ad-user-enforcement-works'></a>

## How AD object enforcement works

Enforcement is evaluated by Active Directory **at the point of a Lightweight Directory Access Protocol (LDAP) write, on whichever domain controller processes that write**. When a change targets a user or group that's marked for enforcement, the domain controller checks whether the calling identity is authorized by the policy. If it isn't, the change is blocked (Enforced mode) or logged (Audit mode) before any *drift* between the object's state in Microsoft Entra and its state in AD can occur.

Two pieces work together:

* A domain-wide **source of authority (SOA) policy** that lists the security identifiers (SIDs) authorized to change enforced objects, and the current mode (Enforced or Audit). The policy is stored in a `SOA-Policies` container created under `CN=System,DC=<your domain>`.
* A per-object marker, the [`msDS-ObjectSoa`](/openspecs/windows_protocols/ms-ada2/426118f6-06ea-4ea0-adbe-03556bb58c9c) attribute, that you set through Cloud Sync. The policy applies only to objects that have this attribute set.

| Mode         | Behavior                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Enforced** | Only SIDs allowed by the policy can change enforced users and groups. The policy blocks LDAP modify and modify DN operations, restores from the Recycle Bin, and blocks delete operations. The policy still permits LDAP Add operations, even when the add contains the `msDS-ObjectSoa` attribute.                                                                                                                          |
| **Audit**    | Changes are allowed per your existing AD role-based access control (RBAC). The policy writes an event to the **Directory Service** log when an unauthorized identity changes an enforced object. Use Audit mode to discover out-of-band changes before you switch to Enforced. To see the events, enable Security Diagnostics logging (see [View enforcement events in the event log](#view-enforcement-events-in-the-event-log)). |

AD object enforcement is **additive** to your existing AD RBAC model. It places an additional restriction on top of your current access control without granting any additional access.

> [!WARNING]
> **Enforcement applies only to users and groups you mark, and protection for a marked object is complete only when every writable domain controller is enabled.** Enforcement isn't a single domain-wide switch: it takes effect only for objects that have the `msDS-ObjectSoa` attribute set. For each marked object, the policy is honored only on domain controllers that run a supported operating system and update level with enforcement enabled. If even one writable domain controller isn't enabled, an unauthorized change directed at that domain controller succeeds and bypasses the control for that object. Enable enforcement on **all** writable domain controllers before you rely on it. On each writable domain controller, installing the required cumulative update level and rebooting is the required action to enable enforcement.

## Plan your rollout

The high-level configuration is:

1. Install the required cumulative update level on every writable domain controller, reboot, and verify enforcement is enabled.
2. Install ADSyncTools v2.6 or later, then create or update the policy in Enforced or Audit mode.
3. Mark the users and groups you want to protect.

<a name='step-1-update-and-enable-every-writable-domain-controller'></a>

## Update and enable every writable domain controller

Bring the enforcement engine online across the domain. Repeat on **every writable domain controller**.

1. Enumerate writable domain controllers in the domain:

   ```powershell
   Get-ADDomainController -Filter * | Where-Object { -not $_.IsReadOnly }
   ```

2. Install the latest cumulative Windows Server update on each writable domain controller.
3. Restart each domain controller if prompted.
4. Verify update level:
   * Windows Server 2022: **KB5126655 / OS Build 20348.5761** or later
   * Windows Server 2025: **KB5126646 / OS Build 26100.33650** or later
5. Verify the enforcement binary version:

   ```powershell
   (Get-Item C:\Windows\System32\ntdsai.dll).VersionInfo.FileVersion
   ```

   Expected version (or later):

   * Windows Server 2022: `10.0.20348.5139 (WinBuild.160101.0800)`
   * Windows Server 2025: `10.0.26100.33648 (WinBuild.160101.0800)`

After the primary domain controller emulator (PDCe) is updated and enabled, it automatically creates the `SOA-Policies` container under `CN=System,DC=<your domain>`, which then replicates to all domain controllers. Confirm that the container exists (substitute your actual domain name). It can take a few minutes to appear and replicate.

<a name='step-2-install-the-policy-in-enforced-or-audit-mode'></a>

## Install the policy in Enforced or Audit mode

Use ADSyncTools cmdlets to create or update the `Cloud` policy object inside the `SOA-Policies` container and add the provisioning agent's group managed service account (GMSA) SID to the policy allow list.

### Install and import ADSyncTools (minimum version 2.6.0)

```powershell
Install-Module ADSyncTools -MinimumVersion 2.6.0 -Scope CurrentUser
Import-Module ADSyncTools -MinimumVersion 2.6.0 -Force
```

To confirm that the policy cmdlets are available:

```powershell
Get-Command -Module ADSyncTools -Name *CloudSyncSOAPolicy*
```

Expected output:

```text
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Add-ADSyncToolsCloudSyncSOAPolicyAccount           2.6.0      ADSyncTools
Function        Get-ADSyncToolsCloudSyncSOAPolicy                  2.6.0      ADSyncTools
Function        Remove-ADSyncToolsCloudSyncSOAPolicyAccount        2.6.0      ADSyncTools
Function        Set-ADSyncToolsCloudSyncSOAPolicy                  2.6.0      ADSyncTools
Function        Test-ADSyncToolsCloudSyncSOAPolicy                 2.6.0      ADSyncTools
```

### Configure the policy

Before you configure the policy, identify the Cloud Sync provisioning service gMSA account.

1. If you configure the policy on a machine that doesn't have the Cloud Sync agent, pass the gMSA explicitly with `-CloudSyncGmsa` by following these steps.
2. On the server where the Cloud Sync provisioning agent is installed, run:
   ```powershell
   Get-CimInstance Win32_Service -Filter "Name='AADConnectProvisioningAgent'" |
     Select-Object Name, StartName, State
   ```
3. Note the `StartName` value (for example, `CONTOSO\provAgentgMSA$`). This is the gMSA account whose SID must be present in the `Cloud` SOA policy.

The cmdlets can use the current signed-in account (if it has the required rights), or an explicit Domain Admin credential.

If you plan to use `-Credential`, capture it once and reuse `$cred` in the examples that follow:

```powershell
$cred = Get-Credential -Message "Enter Domain Admin credentials (format: DOMAIN\Username)"
```

* Without `-Credential` when running from a server with Cloud Sync installed (uses current logged-on credentials):

  ```powershell
  Set-ADSyncToolsCloudSyncSOAPolicy -EnforcementMode Enforced
  ```
* With explicit credentials when running from a server with Cloud Sync installed:

  ```powershell
  Set-ADSyncToolsCloudSyncSOAPolicy -EnforcementMode Enforced -Credential $cred
  ```

* With explicit gMSA (for example, when running from a DC without Cloud Sync agent installed):

  ```powershell
  Set-ADSyncToolsCloudSyncSOAPolicy -EnforcementMode Enforced -Credential $cred -CloudSyncGmsa "CONTOSO\provAgentgMSA$"
  ```

To switch to Audit mode:

```powershell
Set-ADSyncToolsCloudSyncSOAPolicy -EnforcementMode Audit -Credential $cred
```

Confirm policy state via PowerShell or ADSI Edit:

```powershell
Get-ADSyncToolsCloudSyncSOAPolicy
```

:::image type="content" source="media/how-to-ad-group-enforcement/soa-policies-container.png" alt-text="Screenshot of ADSI Edit showing the CN=Cloud policy object under the CN=SOA-Policies container." lightbox="media/how-to-ad-group-enforcement/soa-policies-container.png":::

<a name='step-3-mark-a-group-for-enforcement'></a>

## Mark users and groups for enforcement

The attribute mapping differs for groups and users. Configure the applicable mapping for each object type that you want to protect.

### Mark groups for enforcement

Mark groups for enforcement by setting the `msDS-ObjectSoa` attribute to `Cloud` through the Cloud Sync attribute mapping.

1. In your group provisioning to AD configuration, edit the attribute mappings.
2. Add `msDS-ObjectSoa` as a target attribute with the value `Cloud`. Choose one of the following:
   * **Constant mapping** (recommended for most customers): sets the property for all groups in scope of the provisioning job.
   * **Expression mapping**: limits the groups for which the property is set, based on conditional logic.
3. Assign the groups you want to protect to the provisioning scope.
4. Provision the group on demand or by starting the sync cycle.

For details on configuring group provisioning to AD, see [Configure Microsoft Entra ID to Active Directory provisioning](how-to-configure-entra-to-active-directory.md).

<a name='step-3-mark-a-user-for-enforcement'></a>

### Mark users for enforcement

Mark users for enforcement by setting the `msDS-ObjectSoa` attribute to `Cloud` through the Cloud Sync attribute mapping. In a Microsoft Entra ID to AD configuration, the default user attribute mappings already include `msDS-ObjectSoa` mapped to the constant `Cloud`, so users provisioned by that configuration are marked automatically.

To confirm or configure the mapping:

1. In your Microsoft Entra ID to AD configuration, edit the **user** attribute mappings.
2. Confirm `msDS-ObjectSoa` is present as a target attribute with the value `Cloud`. If you need to limit which users are marked, use an **Expression** mapping instead of a **Constant** mapping.
3. Assign the users you want to protect to the provisioning scope.
4. Provision the users on demand or by starting the sync cycle. See [Configure provisioning to Active Directory](how-to-configure-entra-to-active-directory.md).

For details on user attribute mappings, see [Configure provisioning to Active Directory](how-to-configure-entra-to-active-directory.md#user-attribute-mappings).

<a name='verify-the-attribute-is-set-on-the-group'></a>
<a name='verify-the-attribute-is-set-on-the-user'></a>

## Verify or set the `msDS-ObjectSoa` attribute

You can verify with Active Directory Users and Computers (ADUC) console or PowerShell.

### Use ADUC on a domain controller to confirm that the policy applies to each on-premises user or group that you marked:

1. Open **Active Directory Users and Computers**.
1. Select **View** > **Advanced Features**.
1. Navigate to the user or group, then open **Properties**.
1. Go to **Attribute Editor** tab
1. Confirm that the `msDS-ObjectSoa` property is set to `Cloud`.

### Get current value using PowerShell

```powershell
# Group
Get-ADGroup -Identity "CN=HR-Admins,OU=Groups,DC=contoso,DC=com" -Properties msDS-ObjectSoa |
  Select-Object Name,'msDS-ObjectSoa'

# User
Get-ADUser -Identity "CN=Adele Vance,OU=Users,DC=contoso,DC=com" -Properties msDS-ObjectSoa |
  Select-Object Name,'msDS-ObjectSoa'
```

### Set or clear value using PowerShell

```powershell
# Set to Cloud
Set-ADGroup -Identity "CN=HR-Admins,OU=Groups,DC=contoso,DC=com" -Replace @{ 'msDS-ObjectSoa' = 'Cloud' }
Set-ADUser  -Identity "CN=Adele Vance,OU=Users,DC=contoso,DC=com" -Replace @{ 'msDS-ObjectSoa' = 'Cloud' }

# Clear the attribute
Set-ADGroup -Identity "CN=HR-Admins,OU=Groups,DC=contoso,DC=com" -Clear msDS-ObjectSoa
Set-ADUser  -Identity "CN=Adele Vance,OU=Users,DC=contoso,DC=com" -Clear msDS-ObjectSoa
```

The following screenshot shows the attribute set on a group:

:::image type="content" source="media/how-to-ad-group-enforcement/verify-msds-objectsoa-attribute.png" alt-text="Screenshot of an Active Directory group's Attribute Editor tab in ADSI Edit, showing the msDS-ObjectSoa attribute set." lightbox="media/how-to-ad-group-enforcement/verify-msds-objectsoa-attribute.png":::

## What administrators see when a change is blocked

In **Enforced** mode, an unauthorized attempt to modify an enforced user or group is blocked at the LDAP write layer and returns a specific error indicating that the object is managed by a cloud SOA policy. The change is never committed, so there's no drift to reconcile. The error is distinct from a generic "Access Denied," so administrators can tell that the change was intentionally blocked and that the object must be managed through Microsoft Entra. The exact wording varies by tool (Active Directory Users and Computers, PowerShell, or an LDAP client), but the meaning is the same.

In **Audit** mode, the same change is allowed and an event is written to the **Directory Service** log indicating that the change would have been blocked.

## Switch between Enforced and Audit modes

To change the mode, run the policy cmdlet again with the new `-EnforcementMode` value:

```powershell
Set-ADSyncToolsCloudSyncSOAPolicy -EnforcementMode Audit -Credential $cred
```

## Break-glass accounts

You can authorize additional identities to change enforced users and groups on-premises, for example an emergency administrator account to use when cloud provisioning is unavailable. You do this by adding the account SID to the policy.

```powershell
Add-ADSyncToolsCloudSyncSOAPolicyAccount -Account "CONTOSO\breakglass-admin" -Credential $cred
```

To remove an account from the policy:

```powershell
Remove-ADSyncToolsCloudSyncSOAPolicyAccount -Account "CONTOSO\breakglass-admin" -Credential $cred
```

> [!IMPORTANT]
> If a group is marked with `msDS-ObjectSoa=Cloud`, standard on-premises admin writes to that group are blocked in Enforced mode. That includes attempts to clear the object's `msDS-ObjectSoa`. Keep at least one break-glass account in the policy so you retain a recovery path to manage or unprotect the object when required.

Keep the following limits and behaviors in mind:

* **Keep the allow list as small as possible.** For the strongest governance posture, allow only the provisioning agent SID and avoid adding break-glass accounts unless you have a specific operational need. The policy supports a maximum of **64 SIDs**.
* **SIDs are validated when the policy loads.** A single invalid or stale SID causes the **entire policy to fail to load**, which leaves no identities authorized. Watch the **Directory Service** log for a policy-load error and correct the SID.
* **Account changes are an operational risk.** If an authorized account is removed or recreated and its SID changes, update `msDS-Settings` accordingly. Document this in your operational runbooks.

## View enforcement events in the event log

To see audit events for unauthorized changes:

1. Set the Security Diagnostics value to `1` in the registry. For more information, see [AD and LDS diagnostic event logging](/troubleshoot/windows-server/active-directory/configure-ad-and-lds-event-logging).
2. Open Event Viewer and view the **Directory Service** event log.

With Security Diagnostics at the default value of `0`, only policy-load events are logged; individual block and audit events aren't recorded.

## Troubleshoot the enforcement policy

If AD object enforcement doesn't behave as expected (for example, on-premises changes that should be blocked are still processed), use `Test-ADSyncToolsCloudSyncSOAPolicy` to validate policy state and domain controller diagnostics.

1. Sign in to the domain controller you want to validate.
2. Open PowerShell as an administrator.
3. Import ADSyncTools, then run the check cmdlet:

   ```powershell
   Import-Module ADSyncTools -MinimumVersion 2.6.0 -Force
   Test-ADSyncToolsCloudSyncSOAPolicy
   ```

4. If you run the check from a machine without the Cloud Sync agent service, provide the Cloud Sync gMSA explicitly:

   ```powershell
   Test-ADSyncToolsCloudSyncSOAPolicy -Credential $cred -CloudSyncGmsa "CONTOSO\provAgentgMSA$"
   ```

If a change that should be blocked still succeeds, check the following:

* The change was written to a domain controller that **isn't** updated and enabled. Confirm that **every writable domain controller** has the required update level and was restarted afterward. To find which domain controller a client uses, run `nltest /dsgetdc:<your domain>`.
* The policy is in **Audit** mode rather than **Enforced**.
* The `SOA-Policies` container exists under `CN=System,DC=<your domain>`.
* The `msDS-ObjectSoa` attribute is set on the target user or group. If it isn't, confirm the applicable user or group attribute mapping and run a provisioning cycle.

If an authorized change is unexpectedly blocked, confirm that the acting account SID is present in the policy's `msDS-Settings` attribute and that the change replicated to the domain controller processing the write.

## Test the policy

Use these example test cases to validate the configuration:

* Update the membership of an enforced group on-premises with an unauthorized account. The change should be blocked.
* Update an attribute of an enforced user on-premises with an unauthorized account. The change should be blocked.
* Switch the policy to **Audit** and repeat the test. The change is allowed, and an event appears in the **Directory Service** event log.
* Add a SID to the policy as a break-glass account and make an update with that account. The change should succeed.
* Attempt the same unauthorized change against each writable domain controller to confirm enforcement is consistent across the domain.

## Known behavior and limitations

* Converting the source of authority of a user or group in Microsoft Entra doesn't automatically lock down the object in AD. Complete the steps in this article to mark the object as enforced through provisioning to AD.
* Enforcement protects each marked object's attributes and, for groups, membership. Nesting an enforced group into an unenforced group isn't restricted.
* Existing limitations of user and group provisioning to AD still apply.
* Enforcement is only in effect on domain controllers where it's enabled. Enable the feature on every writable domain controller; otherwise a change written to a domain controller that isn't enabled is processed.

## Related content

* [Provision users and groups from Microsoft Entra ID to Active Directory](how-to-configure-entra-to-active-directory.md)
* [Overview of provisioning from Microsoft Entra ID to Active Directory](overview-provision-entra-id-to-active-directory.md)
* [Tutorial: Govern access to an on-premises app from Microsoft Entra ID](tutorial-users-groups-provisioning-walkthrough.md)
* [Provisioning to Active Directory with Microsoft Entra Cloud Sync FAQ](reference-provision-to-active-directory-faq.yml)
* [Microsoft Entra Cloud Sync provisioning agent: version release history](reference-version-history.md)
