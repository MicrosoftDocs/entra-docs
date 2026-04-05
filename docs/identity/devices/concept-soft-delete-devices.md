---
title: Device soft delete in Microsoft Entra ID
description: Learn about device soft delete in Microsoft Entra ID, which moves deleted devices to a recoverable state instead of permanently removing them.
author: Justinha
ms.author: justinha
ms.service: entra-id
ms.topic: concept-article
ms.custom: msecd-doc-authoring-108
ms.date: 04/05/2026

#customer intent: As an IT admin, I want to understand how device soft delete works in Microsoft Entra ID so that I can recover accidentally deleted devices and preserve critical device data like BitLocker recovery keys.

---

# Device soft delete overview

Device soft delete is a recoverability feature in Microsoft Entra ID that moves deleted device objects to a suspended state instead of permanently removing them. When a device is soft deleted, the Azure Device Registration Service (ADRS) de-registers the device and moves the device object into a separate soft-deleted container in the directory. The device is removed from active device lists but remains recoverable for up to 30 days.

This feature helps prevent accidental loss of important device data, such as BitLocker recovery keys and Local Administrator Password Solution (LAPS) passwords. It also reduces the risk of hitting tenant object quotas from orphaned device objects and provides an undo option for device deletions, similar to how soft delete works for users and groups.

> [!IMPORTANT]
> Device soft delete is currently in public preview. Some features and behaviors might change before general availability.

## How device soft delete works

When an administrator or device owner deletes a device from Microsoft Entra ID, the device object isn't permanently removed. Instead, ADRS initiates a de-registration sequence that disables the device's authentication refresh tokens, then moves the device object into the soft-deleted container. The device retains its unique identifier and key material in the soft-deleted state.

While a device is in the soft-deleted state:

- The device can't authenticate or access cloud resources protected by Microsoft Entra ID.
- The device object can't be modified or updated by management tools.
- The device is hidden from the Azure portal device list, Intune, and Microsoft Graph queries. Queries for the device return an HTTP 404 Not Found error.
- The device's DeviceId remains reserved. No new device can register with the same DeviceId until the soft-deleted device is restored or permanently deleted.
- Soft-deleted devices still count toward the directory object quota, though a tombstone object counts as one-quarter of an active object.

After 30 days in the soft-deleted state, the device is automatically hard deleted (permanently removed).

## Supported device types

In the current preview, device soft delete is supported for the following device types:

- **Microsoft Entra joined devices** &mdash; Enterprise-managed devices directly joined to Microsoft Entra ID.
- **Microsoft Entra registered devices** &mdash; Personal or BYOD devices registered with a work or school account.

The following device types aren't currently supported for soft delete and are hard deleted immediately when removed:

- Microsoft Entra hybrid joined devices <!-- TODO: Confirm whether hybrid-joined device soft delete support is available at public preview. -->
- Devices without a recognized trust type, such as those created directly via Microsoft Graph API
- Certain specialty device types, including secure VMs with managed identities, non-persistent VDI instances, and printers

## Role requirements

Only specific roles can initiate, restore, or permanently delete devices:

- **Global Administrators**, **Cloud Device Administrators**, and **Intune Administrators** can soft delete any device, restore soft-deleted devices, and permanently delete soft-deleted devices.
- **Device owners** (the user who joined or registered the device) can soft delete their own device but can't restore or permanently delete it.

Custom roles with soft-delete or restore permissions aren't available at this time.

## Data preserved during soft delete

When a device is soft deleted, critical data associated with the device object is preserved in the soft-deleted container:

- **BitLocker recovery keys** &mdash; Recovery keys stored with the device remain accessible to administrators. After restoration, keys continue to be available, including for self-service BitLocker key recovery by the registered owner.
- **LAPS passwords** &mdash; Local administrator passwords managed through LAPS are retained.
- **Device identity and key material** &mdash; The device's unique identifiers and key material are maintained, which enables full restoration of the device object.

When a device is restored, the device object moves back to the active container with these properties intact.

## Compliance reset

When a device is soft deleted, Microsoft Entra ID resets several compliance-related properties to prevent the device from returning unexpected values if restored. Specifically:

- **IsCompliant** is set to **False**.
- Other compliance-related flags are set to null or false.

The MDM application ID, which identifies the management authority such as Intune, is retained and not cleared during soft delete. The device remains associated with its management authority after restoration.

After a device is restored, the IsCompliant value remains False until the device checks in with its management authority and a fresh compliance evaluation completes. This behavior is expected and typically resolves after the device syncs with Intune or another MDM provider.

## Restore a soft-deleted device

During the preview, soft-deleted devices can be restored using Microsoft Graph API or PowerShell. A portal experience for viewing and restoring soft-deleted devices is planned for general availability.

To verify whether a device is soft deleted, administrators can use:

- **Microsoft Graph API** &mdash; Query the deleted items endpoint: `GET https://graph.microsoft.com/beta/directory/deletedItems/microsoft.graph.device` to list all soft-deleted devices.
- **PowerShell** &mdash; Use the Microsoft Graph PowerShell module to list soft-deleted device objects.

When a device is restored:

- The device object moves from the soft-deleted container back to the active directory container.
- The device can authenticate and be managed again. Users might need to sign in again or reboot the device to refresh the session.
- Compliance-related properties remain in their reset state until the device checks in with its management authority.

> [!IMPORTANT]
> Only Global Administrators, Cloud Device Administrators, and Intune Administrators can restore soft-deleted devices.

## Permanent deletion

A hard delete permanently removes a device object from Microsoft Entra ID. Hard deletion occurs in these situations:

- A soft-deleted device isn't restored within 30 days.
- An administrator explicitly performs a permanent delete on a soft-deleted device.
- The device type doesn't support soft delete.

Once a device is hard deleted, all associated data, including BitLocker recovery keys and LAPS passwords, is permanently lost and can't be recovered. The device object must be fully recreated.

> [!CAUTION]
> Hard-deleted devices and their associated data can't be recovered. Verify that you no longer need a device's BitLocker recovery keys or other data before permanently deleting it.

## Microsoft Entra Connect and soft delete

In hybrid environments where Microsoft Entra Connect syncs devices between on-premises Active Directory and Microsoft Entra ID, soft delete interacts with sync operations. If a device is accidentally removed from the sync scope (for example, by moving a computer object out of a synced organizational unit), Microsoft Entra Connect can detect the soft-deleted object during the next sync cycle and restore it instead of creating a duplicate.

This auto-restore behavior helps prevent credential loss from accidental mass deletions caused by sync scope changes. When Microsoft Entra Connect attempts to recreate a device that was soft deleted (matching on the same DeviceId), the system recognizes the soft-deleted object and restores it.

## Limitations

- There's no portal experience for viewing or restoring soft-deleted devices during the preview. Restoration requires PowerShell or Microsoft Graph API.
- Custom RBAC roles for device soft-delete or restore operations aren't supported.
- DeviceId uniqueness is enforced across both active and soft-deleted containers. A new device can't register with the same DeviceId as a soft-deleted device until that device is restored or permanently deleted.
- Older Azure AD Graph APIs that don't recognize soft delete might hard delete a device instead of soft deleting it.

## Related content

- [Recover from deletions in Microsoft Entra ID](../../architecture/recover-from-deletions.md)
- [Manage device identities using the Microsoft Entra admin center](manage-device-identities.md)
- [How to manage stale devices in Microsoft Entra ID](manage-stale-devices.md)
