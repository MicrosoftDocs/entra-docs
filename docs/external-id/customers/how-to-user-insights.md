---
title: Analyze user activity in Microsoft Entra External ID
description: Learn about how to analyze user activity and engagement for your registered application in the external tenant.
 
author: csmulligan
ms.author: cmulligan
manager: CelesteDG
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: how-to
ms.date: 07/18/2024

ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about data analytics into user activity and engagement for  registered applications.
---
# Gain insights into your app users’ activity

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

The Application user activity  feature under Usage & insights provides data analytics on user activity and engagement for registered applications in your tenant. You can use this feature to view, query, and analyze user activity data in the Microsoft Entra admin center. This can help you uncover valuable insights that can aid strategic decisions and drive business growth.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=UserInsights)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Application user activity” use case.

## Supported scenarios

You can use the user insights feature for the following scenarios:
- **Tracking active users** - You want to determine the total number of active users in your tenant. This can help you assess the overall user engagement with your applications.
- **Monitoring new users added** - You want to track and identify how many users have been added to your tenant in the last month. This data is valuable for monitoring the growth of your user base.
- **Analyzing daily and monthly application sign-ins** - You want to gather data on the number of users who sign in to your applications on a daily and monthly basis. This can help you gauge user engagement over time and spot trends.
- **Assessing MFA usage success and failure** - You want to compare the multifactor authentication (MFA) usage success and failure rates for your applications. This can provide insights into the security and user experience of your authentication processes.


## Prerequisites

To access and view data from application user activity, you must have:
- A Microsoft Entra ID for [customers tenant](quickstart-tenant-setup.md).
- [Registered application(s)](how-to-register-ciam-app.md) with some sign-in and sign-up data.

<!-- Link here later how to access the application user activity reports in two ways. -->

## How to access the Application user activity dashboards

The Application user activity dashboards provide insights into how users interact with your apps. You can access them from the **Application user activity** menu.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Monitoring & health** > **Usage & insights**
1. Select **Application user activity** to view the dashboards.

    :::image type="content" source="media/how-to-user-insights/app-user-activity-dashboard.png" alt-text="Screenshot of the Application user activity dashboards under the Usage & insights menu." lightbox="media/how-to-user-insights/app-user-activity-dashboard.png":::

## Browse the available dashboards

There are three dashboards available with data centered around users, requests, and authentications. Each dashboard provides a summary of activities in applications with one or more sign-in attempts. The dashboards display activity data during the selected time range.

### Users dashboard

The **Users** dashboard gives you a summary of daily and monthly active users, and new users that have been added to your tenant. For this dataset, you'll be able to view the following trends:

- Daily active and inactive users over a period of 30 days.
- Monthly active users over a period of 12 months 
- Monthly active users comparison by application.
- New users added over a period of 12 months.
- New users breakdown by operating system.

    :::image type="content" source="media/how-to-user-insights/users-dashboard.png" alt-text="Screenshot of the Users dashboard.":::

### Requests dashboard

The **Requests** dashboard gives you a summary of monthly requests for all your applications. For this dataset, you'll be able to view the following trends:

- Monthly requests over a period of 12 months.
- Types of MFA usage with a summary of success vs failure count over a period of 12 months

    :::image type="content" source="media/how-to-user-insights/requests-dashboard.png" alt-text="Screenshot of the Requests dashboard.":::

### Authentications dashboard

The **Authentications** dashboard gives you a summary of daily and monthly authentications in your tenant. For this dataset, you'll be able to view the following trends

- Daily authentications over a period of 30 days.
- Daily authentications breakdown by operating system.
- Monthly authentications over a period of 12 months summarized by location.

    :::image type="content" source="media/how-to-user-insights/authentications-dashboard.png" alt-text="Screenshot of the Authentications dashboard.":::

<!---New content --->
## Customize your dashboards

The Application user activity dashboards provide easy-to-digest graphs and charts but have limited customization options. Microsoft Graph APIs enable you to build powerful, customized dashboards with data tailored to your specific needs and preferences. This has some advantages: 

- **Flexibility**: You can integrate with other data sources to present your data in a way that aligns more with your business objectives.
- **Enhanced visualization**: You can have richer and more interactive visual representations of your data.
- **Complex query handling**: You can apply advanced filters, aggregations, and calculations to your user insights data and get more granular and accurate results.

To build your own user insights dashboard, you need to configure API permissions for Microsoft Graph. You can then use the Microsoft Graph API to access the data and build custom reports in your preferred analytics tool. We recommend using Power BI to visualize the data, but you can choose any other analytical tool you prefer.


### Set up External ID 
To build your own user insights dashboard, you'll need to configure API permissions for Microsoft Graph.  



### Create a Power BI report 
To visualize your custom built user insights dashboard we can use Power BI to visualize the data. You can use Power BI desktop or Power BI service. Alternatively, you can choose any other analytical tool you prefer. 

https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-connect-to-data

Power BI comes with Power Query Editor that can help you clean and shape your data: 
https://learn.microsoft.com/en-us/power-bi/transform-model/desktop-query-overview






## Related content

* [Manage admin accounts](how-to-manage-admin-accounts.md)
* [Manage customer accounts](how-to-manage-customer-accounts.md)
