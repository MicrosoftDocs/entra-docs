---
title: Using Microsoft Entra Connect Health with AD DS
description: This is the Microsoft Entra Connect Health page that will discuss how to monitor AD DS.
ms.assetid: 19e3cf15-f150-46a3-a10c-2990702cd700
ms.subservice: hybrid-connect
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 09/10/2026
---
# Using Microsoft Entra Connect Health with AD DS
The following documentation is specific to monitoring Active Directory Domain Services with Microsoft Entra Connect Health. The supported versions of AD DS are Windows Server 2016, 2019, 2022, and 2025.

For more information on monitoring AD FS with Microsoft Entra Connect Health, see [Using Microsoft Entra Connect Health with AD FS](how-to-connect-health-adfs.md). Additionally, for information on monitoring Microsoft Entra Connect (Sync) with Microsoft Entra Connect Health see [Using Microsoft Entra Connect Health for Sync](how-to-connect-health-sync.md).

Open [Microsoft Entra Connect Health](https://aka.ms/aadconnecthealth), select **AD DS services**, and then select a service. The service page provides:

* An **Essentials** section with forest and monitoring information.
* Summary cards for domain controllers, replication status, and alerts.
* Performance charts for LDAP successful binds, NTLM authentications, and Kerberos authentications.

:::image type="content" source="media/how-to-connect-health-adds/connect-health-adds-overview.png" alt-text="Screenshot of the Connect Health AD DS service overview with callouts for forest details, the domain controller list, and replication status." lightbox="media/how-to-connect-health-adds/connect-health-adds-overview.png":::

<a name='alerts-for-azure-ad-connect-health-for-ad-ds'></a>

## Alerts for Microsoft Entra Connect Health for AD DS
The **Alerts** page lists active and resolved alerts related to your domain controllers. Select an alert row to open the details panel, which contains alert metadata, affected servers, resolution guidance, related documentation, and a feedback option.

Use the command bar to refresh the list, change the time range to include older resolved alerts, or open notification settings. You can also search the alert list.

## Domain Controllers Dashboard
On the service page, select **View all domain controllers** to open the domain controllers list. The list shows operational metrics and the health status of monitored domain controllers.

Use **Group by domain** or **Group by site** to understand the environment topology. You can search by domain controller name, domain, site, role, or status; include or exclude monitored and not-monitored domain controllers; and use **Choose columns** to customize the table.

## Replication Status Dashboard
On the service page, select **View replication details** to view the replication status and topology of monitored domain controllers. The page shows the status of the most recent replication attempt and can be grouped by domain or site. Use search to find a domain controller, and expand groups to review source and destination domain controllers, naming context, status, and the last attempted replication.

Select a replication error to open the **Replication Error Details** panel. The panel includes the source and target domain controllers, naming context, site, domain, last attempted and successful synchronization times, recommended fix, and related troubleshooting link when available.

## Monitoring
The service page shows 24-hour graphical trends for three default performance counters: LDAP successful binds, NTLM authentications, and Kerberos authentications. Compare the charts to identify authentication-volume changes, and then select **View detailed monitoring** for a metric to open a larger view and change the time range.

:::image type="content" source="media/how-to-connect-health-adds/connect-health-adds-performance-monitoring.png" alt-text="Screenshot of Connect Health AD DS monitoring with callouts for comparing LDAP, NTLM, and Kerberos trends and opening detailed monitoring." lightbox="media/how-to-connect-health-adds/connect-health-adds-performance-monitoring.png":::

Select **View all Performance Metrics** to open the full collection. Use **Manage counters** to select the metrics you want to display, drag charts to reorder them, and select a chart to compare data for monitored domain controllers over the available time ranges.

## Related links
* [Microsoft Entra Connect Health](./whatis-azure-ad-connect.md)
* [Microsoft Entra Connect Health Agent Installation](how-to-connect-health-agent-install.md)
* [Microsoft Entra Connect Health Operations](how-to-connect-health-operations.md)
* [Using Microsoft Entra Connect Health with AD FS](how-to-connect-health-adfs.md)
* [Using Microsoft Entra Connect Health for sync](how-to-connect-health-sync.md)
* [Microsoft Entra Connect Health FAQ](reference-connect-health-faq.yml)
* [Microsoft Entra Connect Health Version History](reference-connect-health-version-history.md)
