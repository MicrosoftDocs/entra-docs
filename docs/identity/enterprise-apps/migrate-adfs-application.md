---
title: Use the AD FS application migration(preview) to move AD FS apps to Microsoft Entra ID
description: Learn how to use the AD FS application migration to migrate relying party applications from ADFS to Microsoft Entra ID. This guided experience provides one-click configuration for basic SAML URLs, claims mapping, and user assignments to integrate the application with Microsoft Entra ID.
services: active-directory
author: omondiatieno
manager: CelesteDG
ms.service: active-directory
ms.subservice: app-mgmt
ms.topic: how-to
ms.workload: identity
ms.date: 09/26/2023
ms.author: jomondi
ms.reviewer: smriti3
ms.custom: not-enterprise-apps
---

# Use the AD FS application migration(preview) to move AD FS apps to Microsoft Entra ID

In this article, you learn how to migrate your Active Directory Federation Services (AD FS) applications to Microsoft Entra ID using the AD FS application migration.

The AD FS application migration provides IT Admins guided experience to migrate relying party applications from AD FS to Microsoft Entra ID. It provides one-click configuration for basic SAML URLs, claims mapping, and user assignments to integrate the application with Microsoft Entra ID.

With the wizard, all relying party application configurations are imported from the on-premises environment. The **Ready to migrate** application tab within the wizard renders applications that are ready to migrate along with relying party application usage statics such as unique user count, successful sign-in and failed sign-ins count.

The AD FS application migration doesn't support certain configuration. You can configure unsupported ones after the application is migrated. For more information on the supported and unsupported configurations, see [migrate-adfs-app-wizard-overview](migrate-adfs-app-wizard-overview.md).

## Prerequisites

To use the AD FS application migration, you need:

Microsoft Entra Connect health should be installed on the on-premises environments, alongside Microsoft Entra Connect health AD FS health agents. The Microsoft Entra Connect health needs Microsoft Entra ID P1 or P2 license.

- [Microsoft Entra Connect Heath](https://www.microsoft.com/download/details.aspx?id=47594)
- [Microsoft Entra Connect Heath AD FS agents](https://go.microsoft.com/fwlink/?LinkID=518973)

You need one of the following roles:

- Global Administrator
- Application Administrator
- Cloud Application Administrator
- Reports Reader (Read-only report reader)
- Security Reader (Read-only report reader)

## Migrate applications from AD FS to Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](../roles/permissions-reference.md#cloud-application-administrator)
1. Browse to **Identity** > **Monitoring & health** > **Usage & insights**.
1. Select **Application Migration (Preview)**. The dashboard contains the following tabs:
   - **All applications** - List of all applications that are discovered from the on-premises environment.
   - **Ready to migrate** - List of applications that are ready to migrate. The applications are sorted based on the number of unique users, successful sign-ins, and failed sign-ins in the last 30 days.
   - **Ready to configure** - List of applications that are already migrated.
      :::image type="content" source="media/migrate-adfs-application-wizard/migration-wizard-overview.png" alt-text="Screenshot of the AD FS application migration dashboard.":::
1. Select the **Ready to migrate** tab. Locate the application you want to migrate from the list and select **Begin migration**.
1. The **Application migration** page appears and displays several tabs that you can use to configure the application for migration. On the **Summary** tab, type a name for the application and select **Next: Application Template**.
1. The **Application Template** tab appears. On this tab you have three options:
   - Select the application template that best matches the application you're migrating.
   - If the application template isn't listed, visit the Microsoft Entra Gallery to add the template.
   - If you don't find it in the Microsoft Entra gallery, you can proceed to the next tab without selecting any of the templates. If you choose this option, migration proceeds with the default custom application template that Microsoft Entra ID provides.
  Select **Next: Users & groups**.
1. The **Users & groups** tab appears. The wizard automatically maps the users and groups from the on-premises environment to Microsoft Entra ID. You can modify the user and group assignments on the Microsoft Entra application later as necessary. Select **Next: SAML configurations**.
1. The **SAML configurations** tab appears. The wizard automatically maps the SAML configurations from the on-premises environment to Microsoft Entra ID. You can modify the SAML configurations on the Microsoft Entra application later as necessary. Select **Next: Claims**.
1. The **Claims** tab appears. The wizard automatically maps the claims from the on-premises environment to Microsoft Entra ID. You can modify the claims mapping on the Microsoft Entra application later as necessary. Select **configuration results**.
1. The **Configuration results** tab appears. This tab shows other warnings that were identified. These warnings require action and attention once the application is migrated to the Microsoft Entra tenant. Review the configuration results, and then select **Next: Confirmation**.
   :::image type="content" source="media/migrate-adfs-application-wizard/configurations-results-tab.png" alt-text="Screenshot of the configuration results tab of the migration wizard.":::
1. The **Confirmation** tab appears. This tab shows the list of activities that take place in the background to migrate the given application from AD FS to Microsoft Entra ID. Review the list and select **Create**.

   >[!NOTE]
   > Don't close the browser window or navigate away from the page until the migration is complete.

After a successful migration, You should see the link to the newly migrated Application on the same confirmation page.

:::image type="content" source="media/migrate-adfs-application-wizard/confirmation-of-migration-tab.png" alt-text="Screenshot of the confirmation tab of the migration wizard.":::

You can also access the migrated application in the **Migrated applications** tab of the dashboard.