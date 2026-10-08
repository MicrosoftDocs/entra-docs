---
title: Migrate Microsoft Entra Enterprise State Roaming
description: Learn how to migrate Enterprise State Roaming management from Microsoft Entra ID to Windows settings backup and restore policies.
ms.topic: how-to
ms.date: 09/14/2026
ms.reviewer: sempofu, micrider
ms.custom: references_regions, sfi-ga-blocked, msecd-doc-authoring-1028
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to migrate Enterprise State Roaming management so that users can continue to sync supported Windows settings across devices.
---
# Migrate Enterprise State Roaming from Microsoft Entra ID

Enterprise State Roaming (ESR) lets users sync supported Windows settings across devices associated with their Microsoft Entra ID account. ESR management moved from the Microsoft Entra admin center to Windows settings backup and restore in July 2026. IT administrators now configure backup policies by using Microsoft Intune, another mobile device management (MDM) provider, or Group Policy.

The set of ESR settings remains unchanged. Only the management experience has changed. For the current list of supported settings, see the [Enterprise State Roaming settings catalog](/windows/configuration/windows-backup/catalog-esr).

ESR is separate from [consumer settings sync](https://go.microsoft.com/fwlink/?linkid=2015135), which uses a personal Microsoft account. Before July 2026, a [Global Administrator](../role-based-access-control/permissions-reference.md#global-administrator) could configure ESR through [device settings](./manage-device-identities.md) in the [Microsoft Entra admin center](https://entra.microsoft.com). That portal management option is no longer available.

> [!IMPORTANT]
> You can no longer manage ESR through the Microsoft Entra admin center. Configure Windows settings backup and restore policies to continue roaming supported settings. If you take no action, Windows honors existing ESR and Group Policy or MDM roaming controls for one year and prioritizes Group Policy or MDM. After that period, ESR no longer works until you configure Windows settings backup and restore policies.

<a name='to-enable-enterprise-state-roaming'></a>

## Migrate Enterprise State Roaming management

To migrate ESR management, follow these steps:

1. Review your current use of ESR and identify the users and devices that need settings backup and roaming.
1. Confirm that your devices meet the backup requirements and that users have an eligible license. For current requirements and licensing information, see [Windows settings backup and restore](/windows/configuration/windows-backup/), the [Enterprise State Roaming settings catalog](/windows/configuration/windows-backup/catalog-esr), and the [Microsoft Entra product page](https://azure.microsoft.com/services/active-directory).
1. Configure the **Enable Windows Backup** policy by using Microsoft Intune, the Policy configuration service provider (CSP), or Group Policy.
1. Assign the policy to the users or devices that need settings backup and roaming.
1. Verify that the policy applies successfully.

> [!NOTE]
> Configure Windows settings backup and restore by using either Group Policy or CSP. Don't combine both policy sources because conflicting settings can cause unexpected results.

For information about the legacy controls that limit which settings sync, see [Group Policy and MDM settings for settings sync](enterprise-state-roaming-group-policy-settings.md).

Backup is supported for eligible Microsoft Entra joined and [Microsoft Entra hybrid joined](./hybrid-join-plan.md) devices. For current operating system versions and build requirements, see [Windows settings backup and restore system requirements](/windows/configuration/windows-backup/#system-requirements).

Microsoft Edge sync is managed separately from ESR. For more information, see [Microsoft Edge Sync](/deployedge/microsoft-edge-enterprise-sync). For legacy ESR diagnostics, see [Troubleshoot Enterprise State Roaming](enterprise-state-roaming-troubleshooting.md).

## Data storage and retention

Windows settings backup and restore treats user-specific settings as personal data and stores the data in the tenant's region. In the public cloud, the country or region selected when the tenant is created maps to a geographic location in Exchange Online.

By default, data is retained while it's associated with an active account and device. For current information about storage, encryption, compliance, and retention, see the [Windows settings backup and restore FAQ](/windows/configuration/windows-backup/faq#data-storage-and-retention). For legacy ESR-specific questions, see the [Settings and data roaming FAQ](enterprise-state-roaming-faqs.yml). For general information about cloud locations, see [Azure regions](https://azure.microsoft.com/regions/). If you need help determining a data location, review [Azure support options](https://azure.microsoft.com/support/options/) or contact [Azure support](https://azure.microsoft.com/support/).

## Related content

* [Configure Windows settings backup and restore](/windows/configuration/windows-backup/)
* [Windows settings backup and restore policy settings](/windows/configuration/windows-backup/policy-settings)
* [Enterprise State Roaming settings catalog](/windows/configuration/windows-backup/catalog-esr)
