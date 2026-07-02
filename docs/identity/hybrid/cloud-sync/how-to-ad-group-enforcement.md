---
title: Configure AD group enforcement in Microsoft Entra Cloud Sync (preview)
description: Configure the AD group enforcement preview so that synced Active Directory groups can only be modified by the Microsoft Entra Cloud Sync provisioning service.
author: omondiatieno
ms.author: jomondi
manager: mwongerapk
ms.service: entra-id
ms.subservice: hybrid-cloud-sync
ms.topic: how-to
ms.custom: msecd-doc-authoring-1013
ms.date: 06/09/2026
ai-usage: ai-assisted

#customer intent: As a hybrid identity administrator, I want to restrict modifications of synced Active Directory groups to the Microsoft Entra Cloud Sync provisioning service so that on-premises changes can't bypass Microsoft Entra governance.

---

# Configure AD group enforcement in Microsoft Entra Cloud Sync (preview)

Microsoft Entra Cloud Sync can provision cloud groups to on-premises Active Directory (AD). AD group enforcement lets you designate specific synced groups so that modifications can only be performed through the Microsoft Entra provisioning service. This alignment between Microsoft Entra ID and AD groups removes the need for a separate reconciliation process and helps ensure that all access is granted through Microsoft Entra.

> [!IMPORTANT]
> AD group enforcement is currently in PREVIEW. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

## Prerequisites

| Prerequisite | Details |
|---|---|
| Domain controller operating system | Windows Server 2022 or Windows Server 2025. |
| Domain controller role | The policy must be installed on the PDCe role domain controller. |
| Windows update on the domain controllers | Update your domain controllers to a cumulative Windows Server update that contains the AD group enforcement code. The minimum version of `C:\Windows\System32\ntdsai.dll` is **10.0.20348.5257** for Windows Server 2022 and **10.0.26100.32995** for Windows Server 2025. The code ships in the update but is disabled by default. To verify the installed version, run `(Get-Item C:\Windows\System32\ntdsai.dll).VersionInfo.FileVersion` on the domain controller. For test environments, you can instead use a [Windows Server Insider Preview](https://www.microsoft.com/software-download/windowsinsiderpreviewserver) build, which has the feature already enabled. |
| Group Policy MSI to enable the feature | If you're not using a Windows Server Insider Preview build, install the matching Group Policy MSI on each domain controller to enable the enforcement code that's already in the OS update: [Windows Server 2022 MSI](https://aka.ms/ADEnforcementGPMSI2022), [Windows Server 2025 MSI](https://aka.ms/ADEnforcementGPMSI2025). |
| Provisioning agent host | Install the provisioning agent on a Windows Server 2019 or Windows Server 2022 machine that's joined to your AD domain. Use a test environment for this preview. |
| Microsoft Entra license | A Microsoft Entra tenant with Microsoft Entra ID P1 licenses for configuring group provisioning to AD. |
| Role | Domain Admin (required to run the PowerShell script that installs the policy). |
| PowerShell script | The `Set-CloudSyncSOAPolicy.ps1` script for configuring the enforcement policy, downloaded from the [AzureAD/EntraIDGovernance repo on GitHub](https://github.com/AzureAD/EntraIDGovernance/blob/main/Set-CloudSyncSOAPolicy.ps1). |

For the full list of provisioning agent prerequisites, see [Prerequisites for Microsoft Entra Cloud Sync](how-to-prerequisites.md).

## Understand how AD group enforcement works

After you install the AD group enforcement Windows update on your PDCe role domain controller, a new policy container called `SOA-Policies` is created under `CN=System,DC=<your domain>`. The policy serves two purposes:

- It stores the security identifiers (SIDs) that are authorized to make changes to AD objects marked as enforced. If no SIDs are in the policy, the policy is effectively off. Any user with permission to update the group can update it as if the policy weren't present.
- It stores the current state of the policy: **Enforced** or **Audit**.

| Mode | Behavior |
|---|---|
| **Enforced** | Only SIDs that are allowed as part of the policy can make changes to groups enabled for the functionality. The policy prevents LDAP modify operations and restores of objects from the Recycle Bin. The policy permits LDAP Add operations, even if the add contains the `msDS-ObjectSoa` attribute. |
| **Audit** | Changes to the group are allowed per the existing AD role-based access control (RBAC) model. The policy emits a log to Event Viewer when an object is updated by a user who isn't authorized by the policy. To see the event, set the Security Diagnostics logging level to minimal. For more information, see [AD and LDS diagnostic event logging](/troubleshoot/windows-server/active-directory/configure-ad-and-lds-event-logging). |

The AD attribute [`msDS-ObjectSoa`](/openspecs/windows_protocols/ms-ada2/426118f6-06ea-4ea0-adbe-03556bb58c9c) denotes which objects are enabled for the enforcement functionality. The policy applies only to objects that have this attribute set.

AD group enforcement is additive to your existing AD RBAC model. It places an additional restriction on top of your existing RBAC model, without granting any additional access.

## Install the SOA-Policies container on the PDCe

Enable AD group enforcement on the primary domain controller emulator (PDCe) role domain controller and confirm that the `SOA-Policies` container is created. AD group enforcement can be enabled by either of the following paths:

- **Existing Windows Server 2022 or 2025 PDCe:** Install the latest cumulative Windows Server update, then install the matching Group Policy MSI to turn the feature on.
- **Test environment with a Windows Server Insider Preview build:** Install the latest [Windows Server Insider Preview](https://www.microsoft.com/software-download/windowsinsiderpreviewserver) build, which has the feature already enabled. The Group Policy MSI step isn't required.

1. Set up a Windows Server 2022 or Windows Server 2025 server and promote it to a domain controller. Skip this step if you already have a PDCe.
1. Install the latest cumulative Windows Server update on the PDCe. Skip this step if you're using a Windows Server Insider Preview build.
1. Restart the PDCe if the Windows update prompts you to.
1. Install the matching Group Policy MSI on the PDCe to enable the enforcement code that's already in the OS update. The MSI uses a Known Issue Rollback (KIR) style enablement model. Skip this step if you're using a Windows Server Insider Preview build:
   - Windows Server 2022: [aka.ms/ADEnforcementGPMSI2022](https://aka.ms/ADEnforcementGPMSI2022)
   - Windows Server 2025: [aka.ms/ADEnforcementGPMSI2025](https://aka.ms/ADEnforcementGPMSI2025)
1. Restart the domain controller.
1. Confirm that `SOA-Policies` exists under `CN=System,DC=<your domain>` (substitute your actual domain name). The container can take 5 to 10 minutes to appear.

   :::image type="content" source="media/how-to-ad-group-enforcement/soa-policies-container.png" alt-text="Screenshot of ADSI Edit showing the CN=SOA-Policies container under CN=System." lightbox="media/how-to-ad-group-enforcement/soa-policies-container.png":::

For full enforcement across the domain, repeat the OS update and Group Policy MSI install on every domain controller that should enforce the policy.

## Install the policy in Enforced or Audit mode

After the `SOA-Policies` container is in place, install the Cloud Sync provisioning agent and run the PowerShell script that configures the policy mode:

1. Install the Microsoft Entra Cloud Sync provisioning agent. For installation instructions, see [Install the Microsoft Entra Cloud Sync provisioning agent](how-to-install.md).
1. Download the [`Set-CloudSyncSOAPolicy.ps1`](https://github.com/AzureAD/EntraIDGovernance/blob/main/Set-CloudSyncSOAPolicy.ps1) PowerShell script from the AzureAD/EntraIDGovernance repo on GitHub.
1. Open PowerShell as an administrator.
1. Change directory to the folder that contains the script.
1. Run the script. When prompted, specify `Enforced` as the mode:

   ```powershell
   .\Set-CloudSyncSOAPolicy.ps1 -EnforcementMode Enforced -Credential (Get-Credential -Message "Enter Domain Admin credentials (format: DOMAIN\Username)")
   ```

1. Confirm that the `SOAPolicy` is configured with the keyword **Enforced**.

To configure the policy in "what-if" mode instead, run the script with `-EnforcementMode Audit`.

## Mark a group for enforcement

Mark a group for enforcement by setting the `msDS-ObjectSoa` attribute to `Cloud` through the Cloud Sync attribute mapping.

1. In your Cloud Sync group provisioning to AD configuration, edit the attribute mappings.
1. Add `msDS-ObjectSoa` as a target attribute with the value `Cloud`. You can either:
   - Configure it as a constant mapping, which sets the property for all groups in scope, or
   - Configure an expression that limits the groups for which the property is set.
1. Assign the groups you want to test to the provisioning scope.
1. Provision the group on demand or by starting the sync cycle.

For details on configuring group provisioning to AD, see [Configure provisioning Microsoft Entra ID to Active Directory](how-to-configure-entra-to-active-directory.md).

## Verify the attribute is set on the group

Use ADSI Edit on a domain controller to confirm that the policy is applied to the on-premises group:

1. Open **ADSI Edit**.
1. Select **View** > **Advanced Features**.
1. Navigate to the group, then open **Properties**.
1. Confirm that the `msDS-ObjectSoa` property is set on the group.

   :::image type="content" source="media/how-to-ad-group-enforcement/verify-msds-objectsoa-attribute.png" alt-text="Screenshot of an Active Directory group's Attribute Editor tab in ADSI Edit, showing the msDS-ObjectSoa attribute set." lightbox="media/how-to-ad-group-enforcement/verify-msds-objectsoa-attribute.png":::

## Switch between Enforced and Audit modes

To change the mode, run `Set-CloudSyncSOAPolicy.ps1` again with the new value for `-EnforcementMode`:

```powershell
.\Set-CloudSyncSOAPolicy.ps1 -EnforcementMode Audit -Credential (Get-Credential -Message "Enter Domain Admin credentials (format: DOMAIN\Username)")
```

## Add a break-glass account

You can add the SID of an additional authorized user to the policy so that the user can make changes to enforced groups on-premises.

1. Open **ADSI Edit**.
1. Navigate to **CN=SOA-Policies** > **CN=CloudSyncSOAPolicy**.
1. Open the **Attribute Editor**.
1. Edit the `msDS-Settings` attribute and add the SID of the break-glass account.

   :::image type="content" source="media/how-to-ad-group-enforcement/add-break-glass-sid.png" alt-text="Screenshot of ADSI Edit showing the msDS-Settings attribute under CN=SOA-Policies being edited in the Multi-valued String Editor with a SID value." lightbox="media/how-to-ad-group-enforcement/add-break-glass-sid.png":::

## View enforcement events in the event log

To see audit events for unauthorized changes:

1. Set the Security Diagnostics value to `1` in the registry. For more information, see [AD and LDS diagnostic event logging](/troubleshoot/windows-server/active-directory/configure-ad-and-lds-event-logging).
1. Open Event Viewer and view the **Directory Services** event log.

## Troubleshoot the enforcement policy

If AD group enforcement doesn't behave as expected (for example, on-premises changes that should be blocked are still processed), use the `Check-CloudSyncSOAPolicy.ps1` script to confirm that AD group enforcement is enabled on the domain controller.

1. Download the [`Check-CloudSyncSOAPolicy.ps1`](https://github.com/AzureAD/EntraIDGovernance/blob/main/Check-CloudSyncSOAPolicy.ps1) script from the AzureAD/EntraIDGovernance repo on GitHub.
1. Sign in to the domain controller you want to validate.
1. Open PowerShell as an administrator.
1. Change directory to the folder that contains the script.
1. Run the script. It reports whether the AD group enforcement policy is enabled on that domain controller.

If the script reports the policy isn't enabled, verify that:

- The latest cumulative Windows Server update is installed on the domain controller, or that you're running a Windows Server Insider Preview build.
- The matching Group Policy MSI is installed on the domain controller and the machine was restarted afterward.
- The `SOA-Policies` container exists under `CN=System,DC=<your domain>`.

## Test the policy

Use these example test cases to validate the configuration:

- Update the membership of an enforced group locally on-premises with an unauthorized account. The change should be blocked.
- Switch the policy to **Audit** and repeat the test. The change is allowed, and an event appears in the Directory Services event log.
- Add a SID to `SOA-Policies` as a break-glass account, and attempt to make an update with the break-glass account.
- Try to identify a way to circumvent or break the policy and update a group on-premises.

## Known behavior and limitations in this preview

- Only group objects are supported in this preview. While the AD enforcement functionality can be applied to both groups and users, user provisioning to AD through the provisioning agent isn't yet supported.
- Converting the source of authority of a group in Microsoft Entra doesn't automatically lock down the group in AD. You must complete the configuration in this article to mark a group as locked down through group provisioning to AD.
- Currently, Enforcement doesn't prevent deletions.
- Existing limitations of group provisioning to AD continue to apply during this preview.
- A change made on a locked-down object is processed if it occurs on a domain controller where AD group enforcement isn't enabled. For full lockdown, enable the feature on every domain controller by using either the cumulative Windows Server update plus the Group Policy MSI, or a Windows Server Insider Preview build.

## Related content

- [Tutorial: Provision groups to Active Directory](tutorial-group-provisioning.md)
- [Provisioning to Active Directory with Microsoft Entra Cloud Sync FAQ](reference-provision-to-active-directory-faq.yml)
- [Microsoft Entra Cloud Sync provisioning agent: version release history](reference-version-history.md)
