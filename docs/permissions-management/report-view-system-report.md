---
title: Generate and view a system report in Permissions Management
description: How to generate and view a system report in the Permissions Management.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
---

# Generate and view a system report

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article describes how to generate and view a system report in Permissions Management.

## Generate a system report

1. From the Permissions Management home page, select the **Reports** tab, and then select the **Systems Reports** subtab.
    The **Systems Reports** subtab displays the following options in the **Reports** table:

    - **Report Name**: The name of the report.
    - **Category**: The type of report: **Permission**.
    - **Authorization System**: The cloud provider included in the report: Amazon Web Services (AWS), Microsoft Azure (Azure), and Google Cloud Platform (GCP).
    - **Format**: The format in which the report is available: comma-separated values (**CSV**) format, portable document format (**PDF**), or Microsoft Excel Open XML Spreadsheet (**XLSX**) format.

1. In the **Report Name** column, find the report you want to generate.
1. From the ellipses **(...)** menu for that report, select **Generate & Download**. A new window appears where you provide more information for the report you want to generate.
1. For each **Authorization System**, select the **Authorization System Name** you want to include in the report by selecting the box next to the name. 
1. If you want to combine all Authorization Systems into one report, check the box for **Collate**.
1. For **Report Format**, check the boxes for a **Detailed** or **Summary** of the report in CSV format. You can select both. 
    > [!NOTE]
    > If you select one authorization system, the report includes a summary. If you select more than one authorization system, the report does not include a summary.
1. For **Schedule**, select the frequency for how often you want to receive the report(s). You can select **None** if you don't want to generate reports on a scheduled basis.
1. Click **Save**. Upon clicking **Save**, you receive a message **Report has been created**. The report appears on the **Custom Reports** tab.
1. To refresh the list of reports, select **Reload**.
1. On the **Custom Reports** tab, hover your mouse over the report, and click the down arrow to **Download** the report. A message appears **Successfully Started to Generate On Demand Report**. The report is sent to your email.

## Search for a system report

1. On the **Systems Reports** subtab, select **Search**.
1. In the **Search** box, enter the name of the report you want to locate. The **Systems Reports** subtab displays a list of reports that match your search criteria.
1. Select a report from the **Report Name** column.
1. To generate a report, click on the ellipses **(...)** menu for that report, then select **Generate & Download**. 
1. For each **Authorization System**, select the **Authorization System Name** you want to include in the report by selecting the box next to the name. 
1. If you want to combine all Authorization Systems into one report, check the box for **Collate**.
1. For **Report Format**, check the boxes for a **Detailed** or **Summary** of the report in CSV format. You can select both. 

    > [!NOTE]
    > If you select one authorization system, the report includes a summary. If you select more than one authorization system, the report does not include a summary.
1. For **Schedule**, select the frequency for how often you want to receive the report(s). You can select **None** if you don't want to generate reports on a scheduled basis.
1. Click **Save**. Upon clicking **Save**, you receive a message **Report has been created**. The report appears on the **Custom Reports** tab.
1. To refresh the list of reports, select **Reload**.
1. On the **Custom Reports** tab, hover your mouse over the report, and click the down arrow to **Download** the report. A message appears **Successfully Started to Generate On Demand Report**. The report is sent to your email.
 


## Next steps

- For information on how to view system reports in the **Reports** dashboard, see [View system reports in the Reports dashboard](product-reports.md).
- For a detailed overview of available system reports, see [View a list and description of system reports](all-reports.md).
- For information about how to create, view, and share a system report, see [Create, view, and share a custom report](report-view-system-report.md).
- For information about how to create and view the Permissions analytics report, see [Generate and download the Permissions analytics report](product-permissions-analytics-reports.md).
