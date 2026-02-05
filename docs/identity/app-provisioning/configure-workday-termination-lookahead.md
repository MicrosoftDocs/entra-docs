---
title: Configure Workday Termination Lookahead 
description: Enable Termination Lookahead query for your Workday-to-AD/Microsoft Entra ID provisioning job.
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 10/31/2025
ms.reviewer: chmutali
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to understand how to enable the Workday Termination Lookahead query so I can leverage it for Workday-to-AD/Microsoft Entra ID provisioning.
---

# Configure Workday termination lookahead (Preview)

The Microsoft Entra Workday provisioning connector retrieves worker data using the Workday Integration System User (ISU) account via the `Get_Workers` SOAP API. However, the Workday ISU account always operates in the Pacific Time Zone (PT), causing delays in processing termination events for workers in time zones ahead of PT.

For example, let's say a Workday user in **Melbourne (UTC+10, +17 hours ahead of PDT in May)** is terminated with an effective termination date of **May 14, 2025, 11:59 PM Melbourne time**. Using the Workday ISU account, the Microsoft Entra Workday connector fetches the termination event in the provisioning cycle that runs after **May 14, 2025, 11:59 PM PDT**, which is **May 15, 2025, 4:59 PM Melbourne time**—a significant delay.

> [!NOTE]
> We make public previews available to our customers under the terms applicable to previews. These terms are outlined in the overall Microsoft product terms for [online services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

To mitigate this issue, the connector now includes a **24-hour termination lookahead query**. This query ensures termination-related attributes (`StatusTerminationLastDayOfWork`, `StatusTerminationDate`) appear in the connector feed when the termination day begins in PT. The exact processing time varies due to daylight saving time adjustments.

Examples of when termination details start appearing in the feed:

- **Melbourne (UTC+10, PDT+17)** → May 14, 2025, **5:00 PM Melbourne time**

For a user in Melbourne whose last working day is 14-May-2025, the connector starts including the attributes `StatusTerminationLastDayOfWork` and `StatusTerminationDate`, starting Melbourne time at 5:00pm on 14-May-2025, which corresponds to the 17-hour time difference between PDT and Melbourne time in May.

- **India (IST, UTC+5:30, PDT+13.5)** → May 14, 2025, **1:30 PM India time**

For a user in India whose last working day is 14-May-2025, the connector starts including the attributes `StatusTerminationLastDayOfWork` and `StatusTerminationDate`, starting India time 1:30pm on 14-May-2025, which corresponds to the 13.5-hour time difference between PDT and Indian Standard time in May.

- **Japan (JST, UTC+9, PDT+16)** → May 14, 2025, **4:00 PM Japan time**

For a user in Japan whose last working day is 14-May-2025, the connector starts including the attributes `StatusTerminationLastDayOfWork` and `StatusTerminationDate`, starting Japan time 4:00pm on 14-May-2025, which corresponds to the 16-hour time difference between PDT and Japan Standard time in May.

This adjustment ensures the termination data is available earlier for workers in time zones ahead of Pacific Time. By updating attribute mapping rules in Microsoft Entra ID, you can then implement time-zone aware terminations.

## Job configuration

1. Go to your [Microsoft Entra admin center](https://entra.microsoft.com).         
   > [!IMPORTANT] 
   > Test the configuration changes described in this document in your test environment, before enabling the configuration in your production setup.

1. Open your Workday-to-AD/Microsoft Entra ID provisioning job.

1. If it's in a **Running** state, select **Stop provisioning** to first pause the job.

1. Open the Provisioning blade, then click **Edit Configuration**.

1. Expand **Settings**, then check the box for **Enable termination lookahead query**.

   :::image type="content" source="media/configure-workday-termination-lookahead/enable-termination-lookahead-box.png" alt-text="Screenshot showing the selection of Enabling the Termination lookahead query box.":::

5. Click **Save**.    

6. Expand **Mappings** and open the attribute mapping page.
Depending on your provisioning job type, update the expression logic for the account status attribute. If your provisioning target is Microsoft Entra ID, follow steps in the next section. If your provisioning target is on-premises AD, follow steps in the section [Workday to AD job settings](#workday-to-ad-provisioning-job-settings).

### Workday-to-Microsoft Entra ID Provisioning Job settings

- If your Workday provisioning job target is **Entra ID**, then in the attribute mappings section, update the logic associated with `accountEnabled` flag to include a check for **Last Day of Work**.

```python
Switch([StatusTerminationLastDayOfWork],   
  Switch([Active\], "True",  
"0", "False",   
"1", IIF(DateDiff("d", DateAdd("h","9",Now()),CDate(  
    Switch([StatusTerminationLastDayOfWork],[StatusTerminationLastDayOfWork],  
"","9999-12-31")  
    )  
  ) <= 0, "False", "True")  
  ),  
"", Switch([Active], , "1", "True", "0", "False")  
)
```

The expression checks for the presence of `StatusTerminationLastDayOfWork`, which is the attribute that is retrieved as part of the termination lookahead query.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is inactive in Workday, then the Worker account is disabled in Microsoft Entra.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is still active, then the DateDiff logic is triggered, which checks if `StatusTerminationLastDayOfWork` is today. In the DateAdd parameter, use the UTC offset corresponding to your region, so your date comparison logic returns the correct value. For example, if your region is Japan, then use the value **9**.

- If the attribute `StatusTerminationLastDayOfWork` is missing, then it uses the default expression based on the **Active** flag associated with the user.

:::image type="content" source="media/configure-workday-termination-lookahead/edit-attribute-mapping.png" alt-text="A screenshot of the Edit Attribute fields.":::

- If your Workday provisioning job target is **Entra ID**, you can also flow the `StatusTerminationLastDayOfWork` to the `employeeLeaveDateTime` attribute and then trigger Leaver Lifecycle Workflows based on the `employeeLeaveDateTime`. The advantage of this approach is that it'll always use the UTC time zone to trigger the account to disable the task. This saves you from using UTC offsets in expression mappings.

:::image type="content" source="media/configure-workday-termination-lookahead/entra-id-workday-attribute-mappings.png" alt-text="A screenshot of Microsoft Entra ID and Workday attribute mappings." lightbox="media/configure-workday-termination-lookahead/entra-id-workday-attribute-mappings.png":::

- After changing any settings, make sure to save the provisioning job.

### Workday-to-AD Provisioning Job settings

- If your Workday provisioning job target is **Active Directory**, then in the attribute mappings section, update the logic associated with the `accountDisabled` flag to include a check for **Last Day of Work**.

```python
Switch([StatusTerminationLastDayOfWork],   
  Switch([Active], "False",  
"0", "True",   
"1", IIF(DateDiff("d", DateAdd("h","9",Now()),CDate(  
    Switch([StatusTerminationLastDayOfWork\],[StatusTerminationLastDayOfWork],  
"","9999-12-31")  
    )  
  ) <= 0, "True", "False")  
  ),  
"", Switch([Active], , "1", "False", "0", "True")  
)
```

The expression checks for the presence of `StatusTerminationLastDayOfWork`, which is the attribute that is retrieved as part of the termination lookahead query.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is inactive in Workday, then the Worker account is disabled in AD.

- If the attribute `StatusTerminationLastDayOfWork` is present and if the worker is still active, then the DateDiff logic is triggered, which checks if `StatusTerminationLastDayOfWork` is today. In the DateAdd parameter, use the UTC offset corresponding to your region, so your date comparison logic returns the correct value. For example, if your region is Japan, then use the value **9**.

- If the attribute `StatusTerminationLastDayOfWork` is missing, then it uses the default expression based on the **Active** flag associated with the user.

- Optionally, you can configure the `accountExpires` attribute in on-premises AD to use this date. Use the expression mapping.

`NumFromDate([StatusTerminationLastDayOfWork])`

- Optionally, you can flow the last day of work to an extension attribute in on-premises AD.

- After changing any settings, make sure to save the provisioning job.

## Test your configuration

### Terminate a worker in Workday

In Workday, terminate a user and set the user’s termination date and last day of work to a date that is 24 hours into the future, using Pacific Time zone as reference.

:::image type="content" source="media/configure-workday-termination-lookahead/workday-worker-history.png" alt-text="A screenshot of business process history of an employee." lightbox="media/configure-workday-termination-lookahead/workday-worker-history.png":::

For example, in the test scenario shown above, the terminated worker is in the Melbourne time zone and his last day of work is set to May 28, 2025 Melbourne time. If this was a usual provisioning job run (without the lookahead query), the connector wouldn't see this termination event until the end of day Pacific time on May 28, 2025, which corresponds to May 29, 2025 5pm Melbourne time. However, with lookahead query, you'll now see the change show up as early as May 28, 2025 5pm Melbourne time, so the connector can disable the account based on the expression mapping logic.

### Run provision on demand for the worker

With the lookahead query, the last day of work for the user was fetched and the `accountEnabled` flag was updated to **False**.

:::image type="content" source="media/configure-workday-termination-lookahead/modified-attributes.png" alt-text="A screenshot showing modified attributes.":::

### Verify incremental sync performing termination lookahead

- After confirming the configuration change works with "provisioning on demand", restart your provisioning job.  
- Allow the job to reach steady state. Once incremental sync starts, monitor the provisioning logs for future dated terminations effective over the next 24 hours. These termination events are processed as per the expression mapping logic configured in the job. 

