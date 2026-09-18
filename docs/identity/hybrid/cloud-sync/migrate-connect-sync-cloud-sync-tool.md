---
title: Migrate to Microsoft Entra Cloud Sync with the Migration Tool
description: Learn how to migrate from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync and validate synchronization after activation.
author: srutto
ms.author: sharonrutto
ms.service: entra-id
ms.subservice: hybrid-cloud-sync
ms.topic: how-to
ms.custom: msecd-doc-authoring-1028
ms.date: 09/16/2026
ai-usage: ai-generated

#customer intent: As a hybrid identity administrator, I want to migrate from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync so that I can validate synchronization after Cloud Sync becomes active.
---

# Migrate to Microsoft Entra Cloud Sync with the migration tool

Use the guided migration tool to move supported synchronization settings from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync. The tool assesses your environment, creates the required Cloud Sync configurations, and performs a preactivation Provision on Demand check. It then places Connect Sync in staging mode, activates Cloud Sync, and guides you through postactivation validation. Before you begin, review the prerequisites and supported migration scenarios.

## Prerequisites

- An account with the [**Hybrid Identity Administrator**](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role to connect to Microsoft Entra and create and manage Cloud Sync configurations.
- Domain Admin credentials for every selected Active Directory forest. The wizard validates these credentials and uses them to configure the group managed service account (gMSA) for the provisioning agent.
- A supported version of Microsoft Entra Connect Sync. The migration option appears only for organizations and Connect Sync installations that are eligible for the current migration wave.
- An environment that meets the current migration-tool limits:
    - One Active Directory forest with no more than 2,000 in-scope objects.
    - Additive organizational unit (OU) inclusion scoping with no more than 30 included containers in each domain.
    - No migration-blocking features, such as custom synchronization rules, group filtering, a custom user principal name (UPN), directory extensions, device synchronization, or unsupported writeback scenarios.
- A review of the [supported scenarios and feature comparison](connect-to-cloud-sync-decision-guide.md#comparison-between-microsoft-entra-connect-and-cloud-sync) for other differences between Connect Sync and Cloud Sync.
- Access to the active Microsoft Entra Connect Sync server. You can't run the migration tool from a server in staging mode.
- A two-week validation period after migration. Keep Microsoft Entra Connect Sync installed during this period.

The migration tool supports transferring the following synchronization scenarios:

- User synchronization.
- Group synchronization.
- Password hash synchronization (PHS).
- Password writeback.
- Exchange hybrid writeback.
- Supported domain and organizational unit scoping.

## Launch the migration tool

Start the guided migration from the active Microsoft Entra Connect Sync server. The wizard shows an overview of the migration stages before it changes your environment.

1. Open the Microsoft Entra Connect Sync wizard on the active server.
1. Select **Configure**.
1. Select **Transition to Cloud Sync**.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/launch-migration-tool.png" alt-text="Screenshot of the Transition to Cloud Sync task in the Microsoft Entra Connect Sync wizard." lightbox="media/migrate-connect-sync-cloud-sync-tool/launch-migration-tool.png":::

1. Review the migration overview.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/migration-overview.png" alt-text="Screenshot of the migration overview and its five migration stages." lightbox="media/migrate-connect-sync-cloud-sync-tool/migration-overview.png":::

## Connect to Microsoft Entra and Active Directory

Connect the tool to Microsoft Entra and your on-premises Active Directory so that it can assess the current synchronization setup.

1. When prompted, sign in to Microsoft Entra with an account that has the **Hybrid Identity Administrator** role.
1. For each selected forest, enter Domain Admin credentials when prompted.

The tool verifies access to the current Microsoft Entra Connect Sync configuration and checks for conditions that might require attention before migration.

## Review environment readiness

The readiness review can include domains, scope, enabled features, authentication-related settings, writeback settings, object limits, existing Cloud Sync agents or configurations, and unsupported synchronization rules. The wizard also displays the Connect Sync accidental-deletion protection setting and deletion threshold. These settings must be readable and valid before migration can continue.

1. Review each result and any blocking conditions.
1. Review the accidental-deletion protection setting and deletion threshold.
1. Enter the email address that should receive quarantine notifications.
1. Download the readiness report.
1. Select the transition consent checkbox, and then select **Start Transition**.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/environment-readiness-review.png" alt-text="Screenshot of a successful environment readiness review with the report download and transition consent options." lightbox="media/migrate-connect-sync-cloud-sync-tool/environment-readiness-review.png":::

> [!IMPORTANT]
> If the review blocks migration, don't try to bypass the result. Remediate the identified condition, or wait for the required capability.

## Transfer the configuration

The migration tool transfers supported settings automatically. It installs and registers the Cloud Sync provisioning agent, creates a Cloud Sync configuration for each selected, in-scope Active Directory domain, and creates the synchronization jobs required for the supported features detected in your environment.

1. Wait while the migration tool transfers the configuration.
1. Monitor the transfer progress until it completes.
1. Confirm in the wizard that the transfer completed.
1. In the Microsoft Entra admin center, verify the created Cloud Sync configurations and synchronization jobs.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/transfer-progress.png" alt-text="Screenshot of the configuration transfer progress and completed migration tasks." lightbox="media/migrate-connect-sync-cloud-sync-tool/transfer-progress.png":::

> [!NOTE]
> The newly created Cloud Sync configurations remain disabled during the transfer. Connect Sync remains the active exporter until activation.

:::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/disabled-cloud-sync-configuration.png" alt-text="Screenshot of a transferred Cloud Sync configuration in a disabled state." lightbox="media/migrate-connect-sync-cloud-sync-tool/disabled-cloud-sync-configuration.png":::

## Verify the configuration with Provision on Demand

Use Provision on Demand to test a representative object in each migrated domain configuration before you activate Cloud Sync. A successful result confirms that the agent can read the selected Active Directory object and that the Cloud Sync configuration can process it.

1. In the migration wizard, select **Open Entra Portal**, and then open the newly created Cloud Sync configuration in the Microsoft Entra admin center.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/verify-activate-cloud-sync.png" alt-text="Screenshot of the Cloud Sync verification page before Provision on Demand is confirmed." lightbox="media/migrate-connect-sync-cloud-sync-tool/verify-activate-cloud-sync.png":::

1. For each migrated domain configuration, complete these actions:
    1. Select **Provision on demand**.
    1. Enter the distinguished name of a representative test user or group that your organization has approved for migration testing.
    1. Select **Provision**.
    1. Review the detailed result. Don't rely only on the final success indicator.
1. If password writeback is enabled, verify that tenant-level self-service password reset (SSPR) writeback is enabled, and then select the password-writeback confirmation checkbox.
1. Return to the migration wizard.
1. Confirm that Provision on Demand completed successfully for each migrated domain configuration.
1. Select **Complete transfer to Cloud Sync**.

## Activate Cloud Sync

Activation changes the active synchronization path. The migration tool enables the transferred Cloud Sync configuration and jobs, places Connect Sync in staging mode, and starts the initial Cloud Sync synchronization. Connect Sync continues import and synchronization processing locally but no longer performs normal exports to Microsoft Entra ID.

1. After you select **Complete transfer to Cloud Sync**, wait while the migration tool activates Cloud Sync.
1. Confirm that activation completes and the initial Cloud Sync synchronization starts.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/cloud-sync-activated.png" alt-text="Screenshot of the activation confirmation showing that Cloud Sync is active and Connect Sync is in staging mode." lightbox="media/migrate-connect-sync-cloud-sync-tool/cloud-sync-activated.png":::

> [!CAUTION]
> Don't uninstall Connect Sync during initial validation.

## Validate synchronization results

Use the validation page to compare the Connect Sync staging result with the active Cloud Sync result. The wizard automatically compares one aggregate **Total Objects** count, checks required Cloud Sync job health, and confirms that Connect Sync is in staging mode. It doesn't automatically validate individual users, groups, memberships, or writeback operations.

1. Compare the aggregate **Total Objects** counts and confirm that the expected counts reconcile.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/validate-object-counts.png" alt-text="Screenshot of the Validate Migration page showing matching object counts and passed synchronization checks." lightbox="media/migrate-connect-sync-cloud-sync-tool/validate-object-counts.png":::

1. Review Cloud Sync job health, last synchronization information, and provisioning errors.

    :::image type="content" source="media/migrate-connect-sync-cloud-sync-tool/transferred-cloud-sync-jobs.png" alt-text="Screenshot of a healthy Cloud Sync configuration with enabled agents and synchronization status details." lightbox="media/migrate-connect-sync-cloud-sync-tool/transferred-cloud-sync-jobs.png":::

1. Manually validate representative users, groups, memberships, and enabled writeback scenarios.
1. Investigate any persistent object-level differences.
1. After all required checks pass, select the validation consent checkbox, and then select **Complete Migration**.
1. Keep Connect Sync installed for the approved two-week validation period before you uninstall it.

If you need to wait for the next Connect Sync staging cycle, close the wizard so that it releases the Connect Sync configuration mutex. The wizard preserves the transition state. To resume validation, reopen Microsoft Entra Connect Sync, select **Transition to Microsoft Entra Cloud Sync**, review the overview, and sign in to Microsoft Entra again if prompted. Continue to the validation page and refresh the results.

## Request more time to migrate

Microsoft notifies eligible organizations through in-product experiences and email. The notification identifies your organization's migration window or deadline and directs you to the migration guidance.

If a confirmed technical or business blocker prevents you from completing the migration by the deadline in your notification, open a Microsoft Support request for a temporary Cloud Sync migration exception. Exceptions are reviewed individually, aren't guaranteed, and don't remove the requirement to migrate.

Include the following information in your support request:

- Your Microsoft Entra tenant ID and organization name.
- The requested exception end date and why you need more time.
- The readiness report, a description of the confirmed blocking condition, and relevant error evidence.
- The expected customer or business impact if enforcement proceeds.
- The mitigations that you tried and why they didn't resolve the blocker.
- A migration plan with milestones and a target completion date.

Submit evidence only through the secure Microsoft Support channel. Before you upload reports, logs, or screenshots, remove credentials, secrets, tokens, certificate material, personal data, internal hostnames, distinguished names, and unrelated tenant identifiers that Microsoft Support doesn't need for the investigation. Keep requested tenant and correlation identifiers so Support can investigate the issue.

## Troubleshoot common issues

Use the troubleshooting table to investigate migration issues and collect evidence for Microsoft Support.

| Issue | What to check | Support evidence to collect |
| --- | --- | --- |
| Readiness review blocks migration | Review the blocking feature, scope, object limit, accidental-deletion protection setting, or configuration conflict. | Readiness report and a redacted screenshot of the blocking result. |
| Transfer fails | Review Connect Sync trace logs for credential validation, agent installation, registration, Microsoft Graph operations, or job creation failures. | Trace log excerpt, timestamp, wizard step, error text, and correlation identifier, if shown. |
| Activation fails | Follow the recovery instructions in the wizard. Don't delete, disable, or retag migration-owned Cloud Sync resources because manual changes can interfere with recovery. | Diagnostic ID, exported wizard logs, timestamp, wizard step, and error text. |
| Provision on Demand fails | Confirm agent health, directory connectivity, permissions, the object distinguished name, and the detailed provisioning result. | Provision on Demand result details and provisioning logs. |
| Validation counts differ | Close the wizard while you wait for the next Connect Sync staging cycle. Reopen the wizard, return to validation, refresh the aggregate count comparison, and investigate persistent object-level differences. | Validation screenshot, last-sync times, job health, and relevant provisioning errors. |
| Existing Cloud Sync configuration is detected | Determine whether the existing configuration is a compatible writeback configuration or a conflicting Active Directory-to-Microsoft Entra configuration. | Configuration names, directions, scopes, and status, with tenant identifiers redacted. |

## Related content

- [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md)
- [Microsoft Entra Cloud Sync technical overview](concept-how-it-works.md)
- [Migrate from Microsoft Entra Connect to Cloud Sync: Decision guide](connect-to-cloud-sync-decision-guide.md)