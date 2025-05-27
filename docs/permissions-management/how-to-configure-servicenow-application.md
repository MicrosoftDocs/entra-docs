---
title: Configure the ServiceNow application with Permissions Management
description: How to configure ServiceNow with Microsoft Entra Permissions Management.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management
ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
ms.custom: sfi-image-nochange
---

# Configure the ServiceNow app for Microsoft Entra Permissions Management

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

Manage your multicloud permissions by integrating ServiceNow with Microsoft Entra Permissions Management. 

Permissions Management integrates with ServiceNow to simplify Permissions on Demand (POD) requests by automating the request-for-permissions workflow. Users can request, approve, revoke, and audit their permissions using automated ServiceNow workflows. Users can also view current permissions requests in a single dashboard. With this app, users can streamline Permissions Management and improve security and compliance in their organization.

## Key features

The ServiceNow app for Microsoft Entra Permissions Management offers the following capabilities:

- Request, approve, and reject permissions on demand: You can request permissions for yourself or workload identities using a simple form in ServiceNow. You can also approve or reject requests from team members using ServiceNow notifications and approvals.

:::image type="content" source="media/configure-servicenow-application/servicenow-permissions-management-dashboard.png" alt-text="Screenshot of ServiceNow Microsoft Entra Permissions Management dashboard." lightbox="media/configure-servicenow-application/servicenow-permissions-management-dashboard.png":::

- Audit permissions requests and limit access to users/groups: You can view and track your permissions and access requests in a dashboard in ServiceNow and generate reports and audit logs to monitor and verify your permissions and compliance. 

:::image type="content" source="media/configure-servicenow-application/servicenow-portal.png" alt-text="Screenshot of ServiceNow Microsoft Entra Permissions Management portal." lightbox="media/configure-servicenow-application/servicenow-portal.png":::

- Configure Manage users and groups by assigning them access only to specific authorization systems, policies, and roles.

- Notify users when their privileges are assigned or revoked: You can send notifications to users when they have new permissions assignments, or if current permissions are modified.


## How to configure ServiceNow with Microsoft Entra Permissions Management

To proceed with these steps, make sure these permissions are available and configured in your environment for the configuration process.

### Prerequisites

- Access to Microsoft Entra Permissions Management as a Permissions Management Administrator
- Microsoft Entra admin who can create Applications
- ServiceNow admin

To integration the ServiceNow app with Microsoft Entra Permissions Management:

1.	Register the ServiceNow Application on Microsoft Entra ID for authentication of API calls. 
2.	Assign the permissions Viewer and Approver for all in Microsoft Entra Permissions Management to the service principal, under **User Management**. 
3.	Get the [ServiceNow app for Microsoft Entra Permissions Management](https://store.servicenow.com/sn_appstore_store.do#!/store/application/24073ae31bfca9100e564082b24bcb56/1.1.0) from the ServiceNow store.
4.	Select the app, then click **Install**. 
The installation process begins and the application is installed in your instance.
5. Configure the app by following the instructions.
:::image type="content" source="media/configure-servicenow-application/servicenow_microsoft-entra-permissions-management-installation.png" alt-text="Screenshot of ServiceNow Microsoft Entra Permissions Management installation." lightbox="media/configure-servicenow-application/servicenow_microsoft-entra-permissions-management-installation.png":::


## Next steps

- For information on creating users, understanding use cases, and troubleshooting, see [Microsoft Entra Permissions Management ServiceNow Integration and Configuration Guide](https://store.servicenow.com/appStoreAttachments.do?sys_id=2f17e5841bbd3d50e0190d48624bcb2c).
