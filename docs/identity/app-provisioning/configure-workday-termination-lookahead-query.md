---
title: Configure Workday Termination Lookahead query
description: Enable Termination Lookahead query for your Workday-to-AD/Entra ID provisioning job.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 10/17/2025
ms.author: jfields
ms.reviewer: chmutali
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to understand how to enable the Workday Termination Lookahead query so I can leverage it for Workday-to-AD/Entra ID provisioning.
---

# Configure Workday termination lookahead query

The Microsoft Entra Workday provisioning connector retrieves worker data using the Workday Integration System User (ISU) account via the `Get_Workers` SOAP API. However, the Workday ISU account always operates in the Pacific Time Zone (PT), causing delays in processing termination events for workers in time zones ahead of PT.

For example, if a Workday user in **Melbourne (UTC+10, +17 hours ahead of PDT in May)** is terminated with a last work day of **May 14, 2025, 11:59 PM Melbourne time**, the termination event won’t process until **May 14, 2025, 11:59 PM PDT**, which is **May 15, 2025, 4:59 PM Melbourne time**—a significant delay.

To mitigate this issue, the connector now includes a **24-hour termination lookahead query**. This query ensures termination-related attributes (`StatusTerminationLastDayOfWork`, `StatusTerminationDate`) appear in the connector feed when the termination day begins in PT. The exact processing time varies due to daylight saving time adjustments.

Examples of when termination details start appearing in the feed:

- **Melbourne (UTC+10, PDT+17)** → May 14, 2025, **5:00 PM Melbourne time**

For a user in Melbourne whose last working day is 14-May-2025, the connector starts including the attributes `StatusTerminationLastDayOfWork` and `StatusTerminationDate`, starting Melbourne time at 5:00pm on 14-May-2025, which corresponds to the 17-hour time difference between PDT and Melbourne time in May.

- **India (IST, UTC+5:30, PDT+13.5)** → May 14, 2025, **1:30 PM India time**

For a user in India whose last working day is 14-May-2025, the connector starts including the attributes `StatusTerminationLastDayOfWork` and `StatusTerminationDate`, starting India time 1:30pm on 14-May-2025, which corresponds to the 13.5-hour time difference between PDT and Indian Standard time in May.

- **Japan (JST, UTC+9, PDT+16)** → May 14, 2025, **4:00 PM Japan time**

For a user in Japan whose last working day is 14-May-2025, the connector starts including the attributes `StatusTerminationLastDayOfWork` and `StatusTerminationDate`, starting Japan time 4:00pm on 14-May-2025, which corresponds to the 16-hour time difference between PDT and Japan Standard time in May.

This adjustment ensures the termination data is available earlier for workers in time zones ahead of Pacific Time. By updating attribute mapping rules in Entra ID, you can then implement time-zone aware terminations.

## Prerequisites

- This feature is currently enabled only for certain customer provisioning jobs/tenants.

- In Workday, terminate a user and set the user’s termination date and last day of work to a date that is 24 hours into the future, using PST as reference.

## Job Configuration

1. Got to your [Entra portal](https://aka.ms/EnableLastDayOfWork). 
> [!IMPORTANT] 
> Do not use a production provisioning job. Perform the configurations described only with test users using  test instance of Workday and Entra ID.
> [!NOTE] 
> This link includes a feature flag in the URL (`userProvisioningWorkdayLookaheadQueryForTerminations=true`) required to configure the lookahead query setting.

1. Open your test Workday-to-AD/Entra ID provisioning job.

1. If it's in a **Running** state, select **Stop provisioning** to first pause the job.

1. Open the Provisioning blade, then click **Edit Configuration**.

1. Expand **Settings**, then check the box for **Enable Termination lookahead query**.

:::image type="content" source="media/configure-workday-termination-lookahead-query/enable-termination-lookahead-box.png" alt-text="Screenshot showing the selection of Enabling the Termination lookahead query box.":::

5. Click **Save**.

6. Expand **Mappings** and open the attribute mapping page.

### Workday-to-Entra ID Provisioning Job settings

The termination lookahead query works for a variety of potential scenarios for your Workday-to-Entra ID provisioning job and attribute mapping settings. 

- If your Workday provisioning job target is **Entra ID**, then in the attribute mappings section, update the logic associated with `accountEnabled` flag to include a check for **Last Day of Work**.

```python
Switch(\[StatusTerminationLastDayOfWork\],   
  Switch(\[Active\], "True",  
"0", "False",   
"1", IIF(DateDiff("d", DateAdd("h","9",Now()),CDate(  
    Switch(\[StatusTerminationLastDayOfWork\],\[StatusTerminationLastDayOfWork\],  
"","9999-12-31")  
    )  
  ) \<= 0, "False", "True")  
  ),  
"", Switch(\[Active\], , "1", "True", "0", "False")  
)
```

The expression checks for the presence of `StatusTerminationLastDayOfWork`, which is the attribute that is retrieved as part of the termination lookahead query.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is inactive in Workday, then the Worker account is disabled in Entra.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is still active, then the DateDiff logic is triggered, which checks if `StatusTerminationLastDayOfWork` is today. In the DateAdd parameter, use the UTC offset corresponding to your region, so your date comparison logic returns the correct value. For example, if your region is Japan, then use the value **9**.

- If the attribute `StatusTerminationLastDayOfWork` is missing, then it uses the default expression based on the **Active** flag associated with the user.

:::image type="content" source="media/configure-workday-termination-lookahead-query/edit-attribute-mapping.png" alt-text="A screenshot of the Edit Attribute fields.":::

- If your Workday provisioning job target is **Entra ID**, you can also flow the `StatusTerminationLastDayOfWork` to the `employeeLeaveDateTime` attribute and then trigger Leaver Lifecycle Workflows based on the `employeeLeaveDateTime`. The advantage of this approach is that it'll always use the UTC time zone to trigger the account to disable the task. This saves you from using UTC offsets in expression mappings.

:::image type="content" source="media/configure-workday-termination-lookahead-query/entra-id-workday-attribute-mappings.png" alt-text="A screenshot of Entra ID and Workday attribute mappings.":::

- After changing any settings, make sure to save the provisioning job.

### Workday-to-AD Provisioning Job settings

The termination lookahead query works for a variety of potential scenarios for your Workday-to-AD provisioning job and attribute mapping settings. 

- If your Workday provisioning job target is **Active Directory**, then in the attribute mappings section, update the logic associated with the `accountDisabled` flag to include a check for **Last Day of Work**.

```python
Switch(\[StatusTerminationLastDayOfWork\],   
  Switch(\[Active\], "False",  
"0", "True",   
"1", IIF(DateDiff("d", DateAdd("h","9",Now()),CDate(  
    Switch(\[StatusTerminationLastDayOfWork\],\[StatusTerminationLastDayOfWork\],  
"","9999-12-31")  
    )  
  ) \<= 0, "True", "False")  
  ),  
"", Switch(\[Active\], , "1", "False", "0", "True")  
)
```

The expression checks for the presence of `StatusTerminationLastDayOfWork`, which is the attribute that is retrieved as part of the termination lookahead query.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is inactive in Workday, then the Worker account is disabled in AD.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is still active, then the DateDiff logic is triggered, which checks if `StatusTerminationLastDayOfWork` is today. In the DateAdd parameter, use the UTC offset corresponding to your region, so your date comparison logic returns the correct value. For example, if your region is Japan, then use the value **9**.

- If the attribute `StatusTerminationLastDayOfWork` is missing, then it uses the default expression based on the **Active** flag associated with the user.

- Optionally, you can configure the `accountExpires` attribute in on-premises AD to use this date. Use the expression mapping.

`NumFromDate(\[StatusTerminationLastDayOfWork\])`

- Optionally, you can flow the last day of work to an extension attribute in on-premises AD.

- After changing any settings, make sure to save the provisioning job.

## Test the query

### Terminate a worker in Workday

Terminate a worker in Workday (who is in a time zone ahead of PST). Set termination date to a value in the future with PT as reference.

:::image type="content" source="media/configure-workday-termination-lookahead-query/workday-worker-history.png" alt-text="A screenshot of business process history of an employee.":::

For example, the previous scenario is set in the PST time zone (May 28, 2025) and the user, Aus Mike Jordan who is in the Melbourne time zone, has been terminated and the last day of work is set to May 28, 2025 Melbourne time. If this was a usual provisioning job run (without the lookahead query), we wouldn't see this termination event until the end of day PT on May 28, 2025.

### Run provision on demand for the worker

For the previous scenario, Provision on Demand for this user ran on May 28, 2025 at 6:00pm PT.

With the lookahead query, the last day of work for the user was fetched and the `accountEnabled` flag was updated to **False**.

:::image type="content" source="media/configure-workday-termination-lookahead-query/modified-attributes.png" alt-text="A screenshot showing modified attributes.":::

### Verify incremental sync performing termination lookahead

If you’ve stopped your test provisioning job, restart it.

Let it reach **steady state** before performing the incremental sync. Schedule terminations for the future. Verify if those get picked properly in your time zone.

