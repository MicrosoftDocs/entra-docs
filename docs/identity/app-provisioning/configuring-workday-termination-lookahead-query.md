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

# Introduction

The Microsoft Entra Workday provisioning connector retrieves worker data using the Workday ISU account via the ```Get_Workers``` SOAP API. However, the Workday ISU account **always operates in the Pacific Time Zone (PT)**, causing delays in processing termination events for workers in time zones ahead of PT.

For example, if a Workday worker in **Melbourne (UTC+10, +17 hours ahead of PDT in May)** is terminated with a last working day of **May 14, 2025, 11:59 PM Melbourne time**, the termination event won’t be processed until **May 14, 2025, 11:59 PM PDT**, which is **May 15, 2025, 4:59 PM Melbourne time**—a significant delay.

To mitigate this issue, the connector now includes **a 24-hour termination lookahead**. This ensures termination-related attributes (StatusTerminationLastDayOfWork, StatusTerminationDate) appear in the connector feed when the termination day begins in PT. The exact processing time varies due to daylight saving time adjustments.

Examples of when termination details will start appearing in the feed:

- **Melbourne (UTC+10, PDT+17)** → May 14, 2025, **5:00 PM Melbourne time**

> For a user in Melbourne whose last working day is 14-May-2025, the connector will start including the attributes StatusTerminationLastDayOfWork and StatusTerminationDate, starting Melbourne time 5pm on 14-May-2025, which corresponds to the 17-hour time difference between PDT and Melbourne time in May.

- **India (IST, UTC+5:30, PDT+13.5)** → May 14, 2025, **1:30 PM India time**

> For a user in India whose last working day is 14-May-2025, the connector will start including the attributes StatusTerminationLastDayOfWork and StatusTerminationDate, starting India time 1.30pm on 14-May-2025, which corresponds to the 13.5-hour time difference between PDT and Indian Standard time in May.

- **Japan (JST, UTC+9, PDT+16)** → May 14, 2025, **4:00 PM Japan time**

> For a user in Japan whose last working day is 14-May-2025, the connector will start including the attributes StatusTerminationLastDayOfWork and StatusTerminationDate, starting Japan time 4:00 pm on 14-May-2025, which corresponds to the 16-hour time difference between PDT and Japan Standard time in May.

This adjustment ensures termination data is available earlier for workers in time zones ahead of Pacific Time, so you can accordingly implement time zone aware terminations by updating the attribute mapping rules in Entra.

# Pre-requisites

- This feature is currently enabled only for certain customer provisioning jobs/tenants.

- In Workday, terminate a user and set the user’s termination date and last day of work to a date that is 24 hours into the future, using PST as reference.

# Job Configuration

- Use the following link to access your Entra portal - <https://aka.ms/EnableLastDayOfWork>, where you want to test this feature. **DO NOT use production provisioning job.** Perform the configurations described next only with test users using test instance of Workday and Entra ID.

- This link includes a feature flag in the URL (userProvisioningWorkdayLookaheadQueryForTerminations=true) required to configure lookahead query setting.

- Open your test Workday to AD/Entra ID provisioning job.

- If it is in “Running” state, click on “Stop provisioning” to first pause the job.

- Open the Provisioning blade and click “Edit Configuration”

- Check the box “Enable Termination lookahead query”.

:::image type="content" source="media/configuring-workday-termination-lookahead-query/image1.png" alt-text="A screenshot of a computer AI-generated content may be incorrect.":::

- Save the settings.

- Expand “Mappings” and open the attribute mapping page.

## Workday to Entra ID Provisioning Job settings

- **If your Workday provisioning job target is “Entra ID”,** then in the attribute mappings section, update the logic associated with “accountEnabled” flag to include a check for “Last Day of Work” as shown below.

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

The above expression checks for the presence of “StatusTerminationLastDayOfWork”, which is the attribute that gets retrieved as part of the termination lookahead query.

- If the attribute StatusTerminationLastDayOfWork is present and if the worker is inactive in Workday, then the Worker account is disabled in Entra.

- If the attribute StatusTerminationLastDayOfWork is present and if the worker is still active, then, the DateDiff logic is triggered, which checks if StatusTerminationLastDayOfWork is today. In the DateAdd parameter use the UTC offset corresponding to your region, so your date comparison logic returns the correct value. For e.g., if your region is Japan, then use the value 9.

- If the attribute StatusTerminationLastDayOfWork is missing, then it uses the default expression based on the “Active” flag associated with the user.

:::image type="content" source="media/configuring-workday-termination-lookahead-query/image2.png" alt-text="A screenshot of a computer AI-generated content may be incorrect.":::

**If your Workday provisioning job target is “Entra ID”,** you can also flow the StatusTerminationLastDayOfWork to the employeeLeaveDateTime attribute and then trigger Leaver Lifecycle Workflows based on the employeeLeaveDateTime. The advantage of this approach is that it will always use UTC time zone to trigger the account disable task and you don’t have to bother about using UTC offsets in expression mappings.

:::image type="content" source="media/configuring-workday-termination-lookahead-query/image3.png" alt-text="A screenshot of a computer AI-generated content may be incorrect.":::

- Save the provisioning job

## Workday to AD Provisioning Job settings

- **If your Workday provisioning job target is “Active Directory”,** then in the attribute mappings section, update the logic associated with “accountDisabled” flag to include a check for “Last Day of Work” as shown below.

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

The above expression checks for the presence of “StatusTerminationLastDayOfWork”, which is the attribute that gets retrieved as part of the termination lookahead query.

- If the attribute StatusTerminationLastDayOfWork is present and if the worker is inactive in Workday, then the Worker account is disabled in AD.

- If the attribute StatusTerminationLastDayOfWork is present and if the worker is still active, then, the DateDiff logic is triggered, which checks if StatusTerminationLastDayOfWork is today. In the DateAdd parameter use the UTC offset corresponding to your region, so your date comparison logic returns the correct value. For e.g., if your region is Japan, then use the value 9.

- If the attribute StatusTerminationLastDayOfWork is missing, then it uses the default expression based on the “Active” flag associated with the user.

<!-- -->

- **Optionally,** you can configure the accountExpires attribute in on-premises AD to use this date. Use the expression mapping.

NumFromDate(\[StatusTerminationLastDayOfWork\])

- **Optionally,** you can flow the last day of work to an extension attribute in on-premises AD.

- Save the provisioning job.

# Testing

## Terminate a worker in Workday

Terminate a worker in Workday (who is in a time zone ahead of PST). Set termination date to a value in future with PT as reference.

:::image type="content" source="media/configuring-workday-termination-lookahead-query/image4.png" alt-text="A screenshot of a computer AI-generated content may be incorrect.":::

Example in the scenario above, I’m in the PST time zone (5/28/2025) and I have terminated the user Aus Mike Jordan who is the Melbourne time zone, having set the last day of work to (5/28/2025 Melbourne time). If this was a usual provisioning job run (without lookahead query), I would not see this termination event till end of day PT 5/28.

## Run provision on demand for the worker

Example: For the above scenario, I ran Provision on Demand for this user on 5/28/2025 at 6pm PT.

:::image type="content" source="media/configuring-workday-termination-lookahead-query/image5.png" alt-text="A screenshot of a computer AI-generated content may be incorrect.":::

With lookahead query, the last day of work for the user was fetched and the accountEnabled flag was updated to false as shown below.

:::image type="content" source="media/configuring-workday-termination-lookahead-query/image6.png" alt-text="A screenshot of a computer AI-generated content may be incorrect.":::

## Verify incremental sync performing termination lookahead

If you’ve stopped your test provisioning job, restart it.

Let it reach “steady state” performing incremental sync. Schedule terminations for future. Verify if those get picked properly in your time zone.
