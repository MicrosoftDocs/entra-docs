---
title: Microsoft Entra Connect Health operations
description: This article describes additional operations that can be performed after you have deployed Microsoft Entra Connect Health.

author: billmath
manager: amycolannino
ms.assetid: 86cc3840-60fb-43f9-8b2a-8598a9df5c94
ms.service: entra-id
ms.subservice: hybrid-connect
ms.tgt_pltfrm: na
ms.topic: how-to
ms.date: 11/06/2023
ms.author: billmath


---
# Microsoft Entra Connect Health operations
This topic describes the various operations you can perform by using Microsoft Entra Connect Health.

## Enable email notifications
You can configure the Microsoft Entra Connect Health service to send email notifications when alerts indicate that your identity infrastructure is not healthy. This occurs when an alert is generated, and when it is resolved.

![Screenshot of Microsoft Entra Connect Health email notification settings](./media/how-to-connect-health-operations/email_noti_discover.png)

> [!NOTE]
> Email notifications are enabled by default.
>

<a name='to-enable-azure-ad-connect-health-email-notifications'></a>

### To enable Microsoft Entra Connect Health email notifications
1. In the [Microsoft Entra admin center](https://entra.microsoft.com), search for Microsoft Entra Connect Health
2. Select **Sync errors**
3. Select **Notification Settings**.
5. At the email notification switch, select **ON**.
6. Select the check box if you want all Hybrid Identity Administrators to receive email notifications.
7. If you want to receive email notifications at any other email addresses, specify them in the **Additional Email Recipients** box. To remove an email address from this list, right-click the entry and select **Delete**.
8. To finalize the changes, click **Save**. Changes take effect only after you save.

>[!NOTE] 
> When there are issues processing synchronization requests in our backend service, this service sends a notification email with the details of the error to the administrative contact email address(es) of your tenant. We heard feedback from customers that in certain cases the volume of these messages is prohibitively large so we are changing the way we send these messages. 
>
> Instead of sending a message for every sync error every time it occurs we will send out a daily digest of all errors the backend service has returned. Sync error emails are sent once a day, based on the previous day's unresolved errors. So if the customer triggers an error, but resolves it fairly quickly, they will not get an email the following day. This enables customers to process these errors in a more efficient manner and reduces the number of duplicate error messages.

## Delete a server or service instance

>[!NOTE] 
> Microsoft Entra ID P1 or P2 license is required for the deletion steps.

In some instances, you might want to remove a server from being monitored. Here's what you need to know to remove a server from the Microsoft Entra Connect Health service.

When you're deleting a server, be aware of the following:

* This action stops collecting any further data from that server. This server is removed from the monitoring service. After this action, you are not able to view new alerts, monitoring, or usage analytics data for this server.
* This action does not uninstall the Health Agent from your server. If you have not uninstalled the Health Agent before performing this step, you might see errors related to the Health Agent on the server.
* This action does not delete the data already collected from this server. That data is deleted in accordance with the Azure data retention policy.
* After performing this action, if you want to start monitoring the same server again, you must uninstall and reinstall the Health Agent on this server.

<a name='delete-a-server-from-the-azure-ad-connect-health-service'></a>

### Delete a server from the Microsoft Entra Connect Health service

>[!NOTE] 
> Microsoft Entra ID P1 or P2 license is required for the deletion steps.

Microsoft Entra Connect Health for Active Directory Federation Services (AD FS) and Microsoft Entra Connect (Sync):

1. Open the **Server** blade from the **Server List** blade by selecting the server name to be removed.
2. On the **Server** blade, from the action bar, click **Delete**.
![Screenshot of Microsoft Entra Connect Health delete server](./media/how-to-connect-health-operations/DeleteServer2.png)
3. Confirm by typing the server name in the confirmation box.
4. Click **Delete**.

Microsoft Entra Connect Health for AD Domain Services:

1. Open the **Domain Controllers** dashboard.
2. Select the domain controller to be removed.
3. From the action bar, click **Delete Selected**.
4. Confirm the action to delete the server.
5. Click **Delete**.

<a name='delete-a-service-instance-from-azure-ad-connect-health-service'></a>

### Delete a service instance from Microsoft Entra Connect Health service
In some instances, you might want to remove a service instance. Here's what you need to know to remove a service instance from the Microsoft Entra Connect Health service.

When you're deleting a service instance, be aware of the following:

* This action removes the current service instance from the monitoring service.
* This action does not uninstall or remove the Health Agent from any of the servers that were monitored as part of this service instance. If you have not uninstalled the Health Agent before performing this step, you might see errors related to the Health Agent on the servers.
* All data from this service instance is deleted in accordance with the Azure data retention policy.
* After performing this action, if you want to start monitoring the service, uninstall and reinstall the Health Agent on all the servers. After performing this action, if you want to start monitoring the same server again, uninstall, reinstall, and register the Health Agent on that server.

<a name='to-delete-a-service-instance-from-the-azure-ad-connect-health-service'></a>

#### To delete a service instance from the Microsoft Entra Connect Health service
1. Open the **Service** blade from the **Service List** blade by selecting the service identifier (farm name) that you want to remove. 
2. On the **Service** blade, from the action bar, click **Delete**. 
![Screenshot of Microsoft Entra Connect Health delete service](./media/how-to-connect-health-operations/DeleteServer.png)
3. Confirm by typing the service name in the confirmation box (for example: sts.contoso.com).
4. Click **Delete**.
   <br><br>

[//]: # (Start of RBAC section)
## Manage access with Azure RBAC
[Azure role-based access control (Azure RBAC)](~/identity/role-based-access-control/permissions-reference.md) for Microsoft Entra Connect Health provides access to users and groups other than Hybrid Identity Administrators. Azure RBAC assigns roles to the intended users and groups, and provides a mechanism to limit the Hybrid Identity Administrators within your directory.

### Roles
Microsoft Entra Connect Health supports the following built-in roles:

| Role | Permissions |
| --- | --- |
| Owner |Owners can *manage access* (for example, assign a role to a user or group), *view all information* (for example, view alerts) from the portal, and *change settings* (for example, email notifications) within Microsoft Entra Connect Health. <br>By default, Microsoft Entra Hybrid Identity Administrators are assigned this role, and this cannot be changed. |
| Contributor |Contributors can *view all information* (for example, view alerts) from the portal, and *change settings* (for example, email notifications) within Microsoft Entra Connect Health. |
| Reader |Readers can *view all information* (for example, view alerts) from the portal within Microsoft Entra Connect Health. |

All other roles (such as User Access Administrators or DevTest Labs Users) have no impact to access within Microsoft Entra Connect Health, even if the roles are available in the portal experience.

### Access scope
Microsoft Entra Connect Health supports managing access at two levels:

* **All service instances**: This is the recommended path in most cases. It controls access for all service instances (for example, an AD FS farm) across all role types that are being monitored by Microsoft Entra Connect Health.
* **Service instance**: In some cases, you might need to segregate access based on role types or by a service instance. In this case, you can manage access at the service instance level.  

Permission is granted if an end user has access either at the directory or service instance level.

<a name='allow-users-or-groups-access-to-azure-ad-connect-health'></a>

### Allow users or groups access to Microsoft Entra Connect Health
The following steps show how to allow access.
#### Step 1: Select the appropriate access scope
To allow a user access at the *all service instances* level within Microsoft Entra Connect Health, open the main blade in Microsoft Entra Connect Health.<br>

#### Step 2: Add users and groups, and assign roles
1. From the **Configure** section, click **Users**.<br>
   ![Screenshot of Microsoft Entra Connect Health resource sidebar](./media/how-to-connect-health-operations/startRBAC.png)
2. Select **Add**.
3. In the **Select a role** pane, select a role (for example, **Owner**).<br>
   ![Screenshot of Microsoft Entra Connect Health and Azure RBAC configure menu](./media/how-to-connect-health-operations/RBAC_add.png)
4. Type the name or identifier of the targeted user or group. You can select one or more users or groups at the same time. Click **Select**.
   ![Screenshot of Microsoft Entra Connect Health and Azure role list](./media/how-to-connect-health-operations/RBAC_select_users.png)
5. Select **OK**.<br>
6. After the role assignment is complete, the users and groups appear in the list.<br>
   ![Screenshot of Microsoft Entra Connect Health and Azure RBAC and new users highlighted](./media/how-to-connect-health-operations/RBAC_user_list.png)

Now the listed users and groups have access, according to their assigned roles.

> [!NOTE]
> * Global Administrators always have full access to all the operations, but Global Administrator accounts are not present in the preceding list.
> * The Invite Users feature is not supported within Microsoft Entra Connect Health.
>
>

#### Step 3: Share the blade location with users or groups
1. After you assign permissions, a user can access Microsoft Entra Connect Health by going [here](https://aka.ms/aadconnecthealth).
2. On the blade, the user can pin the blade, or different parts of it, to the dashboard. Simply click the **Pin to dashboard** icon.<br>
   ![Screenshot of Microsoft Entra Connect Health and Azure RBAC pin blade, with pin icon highlighted](./media/how-to-connect-health-operations/RBAC_pin_blade.png)

> [!NOTE]
> A user with the Reader role assigned is not able to get Microsoft Entra Connect Health extension from the Azure Marketplace. The user cannot perform the necessary "create" operation to do so. The user can still get to the blade by going to the preceding link. For subsequent usage, the user can pin the blade to the dashboard.
>
>

### Remove users or groups
You can remove a user or a group added to Microsoft Entra Connect Health and Azure RBAC. Simply right-click the user or group, and select **Remove**.<br>
![Screenshot of Microsoft Entra Connect Health and Azure RBAC with Remove highlighted](./media/how-to-connect-health-operations/RBAC_remove.png)

[//]: # (End of RBAC section)

## Next steps
* [Microsoft Entra Connect Health](./whatis-azure-ad-connect.md)
* [Microsoft Entra Connect Health Agent installation](how-to-connect-health-agent-install.md)
* [Using Microsoft Entra Connect Health with AD FS](how-to-connect-health-adfs.md)
* [Using Microsoft Entra Connect Health for sync](how-to-connect-health-sync.md)
* [Using Microsoft Entra Connect Health with AD DS](how-to-connect-health-adds.md)
* [Microsoft Entra Connect Health FAQ](reference-connect-health-faq.yml)
* [Microsoft Entra Connect Health version history](reference-connect-health-version-history.md)
