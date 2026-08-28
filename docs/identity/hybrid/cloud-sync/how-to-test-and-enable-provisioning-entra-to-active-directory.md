---
layout: Conceptual
title: Test Microsoft Entra provisioning (Preview)
uhfHeaderId: MSDocsHeader-Entra
breadcrumb_path: /entra/breadcrumb/toc.json
feedback_system: Standard
feedback_product_url: https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789
author: dhanyahk
ms.author: dhanyahk
ms.reviewer: marshmacy
ms.service: entra-id
manager: pmwongera
description: Test Microsoft Entra ID to Active Directory provisioning on demand, review default properties, and enable or manage the configuration.
ms.topic: how-to
ms.date: 08/26/2026
ms.subservice: hybrid-cloud-sync
ms.custom: sfi-image-nochange, msecd-doc-authoring-1023
ai-usage: ai-assisted
#customer intent: As a hybrid identity administrator, I want to test and enable provisioning so that I can validate changes before synchronizing all in-scope objects.
---

# Test and enable Microsoft Entra ID to Active Directory provisioning (preview)

After you configure scoping filters and attribute mappings, test the configuration, review default properties, and enable it. These steps are the same for all deployment options: users only, groups only, or users and groups.

## Prerequisites

Complete the steps in [Configure Microsoft Entra ID to Active Directory provisioning](how-to-configure-entra-to-active-directory.md) before you continue.

## Test with on-demand provisioning

Before you enable the configuration for all in-scope objects, apply it to a single user or group and check the outcome. On-demand provisioning reports each step separately — import, scope evaluation, match, and the action taken on the target object — so you can see exactly where an object would fail.

Groups have one extra consideration: members aren't provisioned automatically, so you select up to five members to test alongside the group.

When the test finishes, the portal shows a message with the next configuration step. Select the link in that message to continue.

For the full procedure for both users and groups, see [On-demand provisioning - Microsoft Entra ID to Active Directory](how-to-on-demand-provision-entra-to-active-directory.md).

## Default properties: accidental deletes and email notifications

The default properties section provides settings for accidental deletions and email notifications.

:::image type="content" source="media/how-to-configure/new-ux-configure-10.png" alt-text="Screenshot of the default properties option." lightbox="media/how-to-configure/new-ux-configure-10.png":::

The accidental delete feature protects you from configuration changes and on-premises directory changes that would affect many users and groups. It lets you:

- Prevent accidental deletes automatically.
- Set the number of objects (threshold) beyond which the protection takes effect.
- Set a notification email address for when a sync job is placed in quarantine for this scenario.

For more information, see [Accidental deletes](how-to-accidental-deletes.md).

Select the **pencil** next to **Basics** to change the defaults in a configuration.

:::image type="content" source="media/how-to-configure/new-ux-configure-11.png" alt-text="Screenshot of the configuration basics properties." lightbox="media/how-to-configure/new-ux-configure-11.png":::

## Enable your configuration

After you finalize and test your configuration, enable it.

On the left, select **Overview** > **Review and enable**, and then select **Enable configuration**.

:::image type="content" source="media/how-to-test-enable-provisioning-active-directory/enable-provisioning-configuration.png" alt-text="Screenshot of reviewing and enabling a provisioning configuration." lightbox="media/how-to-test-enable-provisioning-active-directory/enable-provisioning-configuration.png":::

The service runs an initial cycle for all in-scope objects, followed by delta cycles on the recurring schedule.

## Quarantines

Cloud Sync monitors the health of your configuration and places unhealthy objects in a quarantine state. If most or all calls made against the target system consistently fail because of an error, such as invalid admin credentials, the sync job is marked as in quarantine. For more information, see [Provisioning quarantined problems](how-to-troubleshoot.md#provisioning-quarantined-problems).

## Restart provisioning

If you don't want to wait for the next scheduled run, trigger the provisioning run by using **Restart sync**.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
1. Browse to **Entra ID** > **Entra Connect** > **Cloud sync**.
1. Under **Configuration**, select your configuration.
1. At the top, select **Restart sync**.

## Remove a configuration

To delete a configuration:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
1. Browse to **Entra ID** > **Entra Connect** > **Cloud sync**.
1. Under **Configuration**, select your configuration.
1. At the top of the configuration screen, select **Delete configuration**.

> [!IMPORTANT]
> There's no confirmation before a configuration is deleted. Make sure this is the action you want to take before you select **Delete**.

## Next step

> [!div class="nextstepaction"]
> [Configure AD user and group enforcement](how-to-active-directory-object-enforcement.md)

## Related content

- [Tutorial: Govern access to an on-premises app from Microsoft Entra ID](tutorial-users-groups-provisioning-walkthrough.md)
- [Configure provisioning to Active Directory](how-to-configure-entra-to-active-directory.md)
- [How provisioning to Active Directory works](how-provisioning-to-active-directory-works.md)
- [Overview of provisioning from Microsoft Entra ID to Active Directory](overview-provision-entra-id-to-active-directory.md)
- [Cloud Sync provisioning quarantines](how-to-troubleshoot.md)
- [Accidental deletes in Microsoft Entra Cloud Sync](how-to-accidental-deletes.md)
- [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md)
