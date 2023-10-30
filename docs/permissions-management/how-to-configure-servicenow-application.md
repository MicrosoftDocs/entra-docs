---
title: Configure the ServiceNow application with Permissions Management
description: How to configure ServiceNow with Microsoft Entra Permissions Management.
services: active-directory
author: jenniferf-skc
manager: amycolannino
ms.service: active-directory 
ms.subservice: ciem
ms.workload: identity
ms.topic: how-to
ms.date: 10/30/2023
ms.author: jfields
---

# Configure the ServiceNow app for Microsoft Entra Permissions Management (Preview)

Manage your multicloud permissions by integrating ServiceNow with Microsoft Entra Permissions Management. 

Permissions Management integrates with ServiceNow to simplify Permissions on Demand (POD) requests by automating the request-for-permissions workflow. Users can request, approve, revoke, and audit their permissions using automated ServiceNow workflows. Users can also view current permissions requests in a single dashboard. With this app, users can streamline Permissions Management and improve security and compliance in their organization.

## Key features

The ServiceNow app for Microsoft Entra Permissions Management offers the following capabilities:

- Request, approve, and reject permissions on demand: You can request permissions for yourself or workload identities using a simple form in ServiceNow. You can also approve or reject requests from team members using ServiceNow notifications and approvals.

:::image type="content" source="media/configure-servicenow-application/servicenow-permissions-management-dashboard.png" alt-text="ServiceNow Microsoft Entra Permissions Management dashboard." lightbox="media/configure-servicenow-application/servicenow-permissions-management-dashboard.png":::

- Audit permissions requests and limit access to users/groups: You can view and track your permissions and access requests in a dashboard in ServiceNow and generate reports and audit logs to monitor and verify your permissions and compliance. Configure Manage users and groups by assigning them access only to specific authorization systems, policies, and roles.

:::image type="content" source="media/configure-servicenow-application/servicenow-portal.png" alt-text="ServiceNow Microsoft Entra Permissions Management portal." lightbox="media/configure-servicenow-application/servicenow-portal.png":::

- Notify users when their privileges are assigned or revoked: You can send notifications to users when they have new permissions that are assigned, or if current permissions are modified. [Do they get notified by email or text, both?]


## How to configure ServiceNow with Microsoft Entra Permissions Management

To proceed with these steps, make sure that the these permissions are available and configured in your environment for the configuration process.

### Prerequisites

- Access to Microsoft Entra Permissions Management
- Microsoft Entra ID admin who can create Applications
- ServiceNow admin 
- Permissions Management admin

To integration the ServiceNow app with Microsoft Entra Permissions Management:

1.	Register the ServiceNow Application on Entra ID for authentication of API calls. 
2.	Assign the permissions Viewer and Approver for all in Microsoft Entra Permissions Management to the service principal. 
3.	[Install](https://store.servicenow.com/sn_appstore_store.do#!/store/application/24073ae31bfca9100e564082b24bcb56/1.0.1?referer=%2Fstore%2Fsearch%3Flistingtype%3Dancillary_app%25253Bcertified_apps%25253Bcontent%25253Bindustry_solution%25253Boem%25253Btemplate%25253Bgenerative_ai%25253Bsnow_solution%26q%3Dmicrosoft%26searchDetail%26pagetype%3Dapps_and_solution&sl=sh) the ServiceNow app for Microsoft Entra Permissions Management.
4.	Locate **Microsoft Entra Permissions Management**, select it, then click Install. 
The installation process begins and the application is installed in your instance.
:::image type="content" source="media/configure-servicenow-application/servicenow_microsoft-entra-permissions-management-installation.png" alt-text="ServiceNow Microsoft Entra Permissions Management installation." lightbox="media/configure-servicenow-application/servicenow_microsoft-entra-permissions-management-installation.png":::

## Next steps

- For information on roles and permissions see [Microsoft Entra Permissions Management roles and permissions](product-roles-permissions.md).
