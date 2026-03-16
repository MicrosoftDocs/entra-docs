---
title: Troubleshoot Microsoft Entra Backup and Recovery
description: Diagnose and resolve common issues when using Microsoft Entra Backup and Recovery, including backup access, difference report jobs, and recovery jobs.
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: troubleshooting
ai-usage: ai-assisted
---

# Troubleshoot Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

This article helps you diagnose and resolve common issues when using Microsoft Entra Backup and Recovery, including backup access, difference report jobs, and recovery jobs.

## Before you begin

Verify these prerequisites before troubleshooting:

- Your tenant is a **workforce tenant** (External ID and B2C tenants aren't supported).
- Your tenant has **Microsoft Entra ID P1 or P2** licenses.
- You're signed in with an account that has the appropriate **Microsoft Entra Backup role**:
  - **Microsoft Entra Backup Reader**
  - **Microsoft Entra Backup Administrator**

The **Global Administrator** role also has the required permissions.

If these prerequisites aren't met, operations might fail with authorization errors or empty results.

## Issue: No backups are listed

### Symptoms

- Fewer than five days of backups are visible, instead of the expected five days.
- Two or more backups appear to have the same timestamp in the snapshot list.

### Possible causes

The oldest snapshot might age out earlier during service initialization, tenant onboarding, or transient backend conditions, temporarily resulting in fewer than five visible days of backups. This condition doesn't indicate data loss or a backup failure.

### Resolution

No action is required. The service continues to create new snapshots automatically.

## Issue: Can't start a difference report or recovery job

### Symptoms

- Difference report or recovery job fails to start.
- An error indicates a conflict or authorization failure.
- The object type you want to use doesn't appear in the scoping filter drop-down.

### Possible causes

- Another difference report or recovery job is already running.
- The signed-in user doesn't have the required Microsoft Entra Backup role.
- The selected object type isn't supported for backup and recovery in the current release.

### Resolution

1. Check whether another difference report or recovery job is running. Only one job can run at a time.
1. Verify that your account has the appropriate role: **Microsoft Entra Backup Reader** for difference reports or **Microsoft Entra Backup Administrator** for recovery.
1. Confirm that the object type and object attributes you're trying to scope are supported. Only supported object types and attributes appear in the scoping filter.

## Issue: Difference report problems

This section helps troubleshoot common issues related to difference reports, including missing changes, long-running jobs, failed jobs, canceled jobs, and missing reports.

### Symptoms

- The difference report didn't include the changes for the object you were looking for.
- The difference report has been running for several hours, and you don't know when it finishes.
- The difference report state is "Failed."
- You can't find the difference report that you generated earlier.
- You selected **Cancel**, but the difference report still appears to be running.

### Possible causes

- The object or property isn't supported for preview in the current release.
- The object didn't change between the snapshot state and the current state.
- The difference report is processing a large number of objects or changes.
- Only one difference report or recovery job can run at a time.
- The report was canceled or failed before completion.
- Difference reports aren't retained indefinitely.

### Resolution

**If expected changes are missing:**

1. Confirm that the object type and properties are supported for the current release.
1. Verify that the object changed after the snapshot was taken.
1. Hard-deleted objects and unsupported properties aren't included.

**If the difference report is running for a long time:**

No estimated completion time is available for a running difference report. Large tenants or large change sets might take longer to process.

- Allow the report to continue running unless cancellation is required.

**If the difference report failed:**

1. Review the job status and error message shown in the report details.
1. Retry the difference report using a narrower scope, such as a specific object type or object ID.
1. Ensure no other difference report or recovery job is running at the same time.

**If you can't find a previous difference report:**

Difference reports are tied to the backup they were created from.

1. Browse to the backup and check the list of difference report jobs associated with it.
1. If the report isn't listed, the backup that the difference report was based on might no longer be available.

**If the difference report continues running after cancellation:**

1. Cancellation is best-effort. Some processing might continue briefly after you select **Cancel**.
1. If the job remains in a running state, wait for the state to update before starting a new report.

## Issue: Recovery job issues

### Symptoms

- The recovery job didn't recover an object that appeared in the difference report.
- The recovery job has been running for several hours, and you don't know when it finishes.
- The recovery job state is "Completed with warnings."
- You canceled the recovery job, but the job still appears to be running.

### Possible causes

- The object or property shown in the difference report (for example, on-premises synced properties) isn't supported for recovery.
- The recovery job includes a large number of objects or changes.
- Only one difference report or recovery job can run at a time.
- The recovery job was canceled or interrupted while changes were still being processed.
- Some recovery actions might partially succeed before a failure or cancellation occurs.

### Resolution

1. Review the failed changes list from the recovery job details.
1. Retry recovery with a narrower scope, focusing on supported cloud-only objects.

## Issue: Can't find a recovery job, or not all links were recovered

### Symptoms

- You can't find the recovery job that you ran yesterday.
- The recovery job shows that only some links or properties were recovered (for example, 1 out of 5), and others weren't.

### Possible causes

- The service automatically removes recovery job reports when the associated backup expires.
- Some links aren't supported for recovery in the current release.
- Certain links depend on other objects or states that no longer exist.
- The recovery job completed with warnings, indicating partial success.

### Resolution

**If you can't find a recovery job you ran earlier:**

1. Browse to the **difference report** that was used for the recovery.
1. View the list of **recovery jobs associated with that difference report**.
1. If the job is no longer listed, the backup that the recovery job used might have expired.

**If not all links were recovered:**

1. Review the recovery job details for **warnings or failed link changes**.
1. Confirm that the links you expected to recover are supported in the current release.
1. Some links might not be recovered if:
   - The related object no longer exists.
   - The link type isn't supported.
1. Manually re-create any unsupported or failed links if necessary.

## Error conditions and messages

| Condition | Error code and message |
|---|---|
| Difference report queried with an invalid snapshot ID | **404 Not Found**: This isn't a valid timestamp for recovery. The provided timestamp should be in the list of available snapshots. |
| Job is queried with an invalid job ID | **404 Not Found** |
| A job is started while another difference report or recovery job is still running | **409 Conflict**: A recovery job is currently in progress. Wait for it to complete before initiating a new job. |
| Get changes while difference report hasn't finished | **400 Bad Request**: Job with identifier `{key}` must have completed successfully prior to enumerating changes. |
| Insufficient admin role | **403 Forbidden**: Authorization has been denied for this request. Check your credentials. |

## Known limitations

### Partial property coverage

Backup and recovery **don't** cover all properties of supported objects. This limitation includes read-only properties, system-generated properties, and properties that rely on specialized business logic. See the [supported properties list](scope-supported-objects-limitations.md) for details. Microsoft is expanding support for more properties over time.

### Tenant support scope

Microsoft Entra Backup and Recovery is supported for workforce tenants only. External ID and B2C tenants aren't supported.

### Hard-deleted objects

Hard-deleted objects **can't** be recovered. These objects aren't included in the difference report and can't be recreated or restored through a recovery job. To reduce the risk of hard deletion, consider configuring [protected actions](/entra/identity/role-based-access-control/protected-actions-overview).

### On-premises synced objects

Users and groups synchronized from on-premises Active Directory can't be recovered with Microsoft Entra Backup and Recovery. These objects must be recovered directly in the on-premises Active Directory environment.

### Link recovery limitations

Only static group membership links are supported for recovery. Group owner links, user manager relationships, and sponsor links aren't supported.
