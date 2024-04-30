---
title: Users are not being provisioned in my application
description: How to troubleshoot common issues faced when you don't see users appearing in a Microsoft Entra Gallery Application you have configured for user provisioning with Microsoft Entra ID

author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 09/15/2023
ms.author: kenwith
ms.reviewer: arvinh
---

# No users are being provisioned 
>[!NOTE]
>Starting 04/16/2020 we have changed the behavior for users assigned the default access role. Please see the section below for details. 
>
After automatic provisioning has been configured for an application (including verifying that the app credentials provided to Microsoft Entra ID to connect to the app are valid), then users and/or groups are provisioned to the app. Provisioning is determined by the following things:

-   Which users and groups have been **assigned** to the application. Note that provisioning nested groups are not supported. For more information on assignment, see [Assign a user or group to an enterprise app in Microsoft Entra ID](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).
-   Whether or not **attribute mappings** are enabled, and configured to sync valid attributes from Microsoft Entra ID to the app. For more information on attribute mappings, see [Customizing User Provisioning Attribute Mappings for SaaS Applications in Microsoft Entra ID](customize-application-attributes.md).
-   Whether or not there is a **scoping filter** present that is filtering users based on specific attribute values. For more information on scoping filters, see [Attribute-based application provisioning with scoping filters](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

If you observe that users are not being provisioned, consult the [Provisioning logs (preview)](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context) in Microsoft Entra ID. Search for log entries for a specific user.

You can access the provisioning logs in the Microsoft Entra admin center by browsing to **Identity** > **Applications** > **Enterprise applications** > **Provisioning logs**. You can also select a specific application and then select **Provisioning logs** in the **Activity** section. You can search the provisioning data based on the name of the user or the identifier in either the source system or the target system. For details, see [Provisioning logs (preview)](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context). 

The provisioning logs record all the operations performed by the provisioning service, including querying Microsoft Entra ID for assigned users that are in scope for provisioning, querying the target app for the existence of those users, comparing the user objects between the system. Then add, update, or disable the user account in the target system based on the comparison.

## General Problem Areas with Provisioning to consider
Below is a list of the general problem areas that you can drill into if you have an idea of where to start.

- [Provisioning service does not appear to start](#provisioning-service-does-not-appear-to-start)
- [Provisioning logs say users are skipped and not provisioned, even though they are assigned](#provisioning-logs-say-users-are-skipped-and-not-provisioned-even-though-they-are-assigned)

## Provisioning service does not appear to start
If you set the **Provisioning Status** to be **On** in the **Enterprise applications &gt; \[Application Name\] &gt;Provisioning** section of the Microsoft Entra admin center. However no other status details are shown on that page after subsequent reloads, it is likely that the service is running but has not completed an initial cycle yet. Check the **Provisioning logs (preview)** described above to determine what operations the service is performing, and if there are any errors.

>[!NOTE]
>An initial cycle can take anywhere from 20 minutes to several hours, depending on the size of the Microsoft Entra directory and the number of users in scope for provisioning. Subsequent syncs after the initial cycle are faster, as the provisioning service stores watermarks that represent the state of both systems after the initial cycle. The initial cycle improves performance of subsequent syncs.
>


## Provisioning logs say users are skipped and not provisioned even though they are assigned

When a user shows up as “skipped” in the provisioning logs, it is important to review the **Steps** tab of the log to determine the reason. Below are common reasons and resolutions:

- **A scoping filter has been configured** **that is filtering the user out based on an attribute value**. For more information on scoping filters, see [scoping filters](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
- **The user is “not effectively entitled”.** If you see this specific error message, it is because there is a problem with the user assignment record stored in Microsoft Entra ID. To fix this issue, unassign the user (or group) from the app, and reassign it again. For more information on assignment, see [Assign user or group access](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).
- **A required attribute is missing or not populated for a user.** An important thing to consider when setting up provisioning is to review and configure the attribute mappings and workflows that define which user (or group) properties flow from Microsoft Entra ID to the application. This configuration includes setting the “matching property” that is used to uniquely identify and match users/groups between the two systems. For more information on this important process, see [Customizing User Provisioning Attribute Mappings for SaaS Applications in Microsoft Entra ID](customize-application-attributes.md).
- **Attribute mappings for groups:** Provisioning of the group name and group details, in addition to the members, if supported for some applications. You can enable or disable this functionality by enabling or disabling the **Mapping** for group objects shown in the **Provisioning** tab. If provisioning groups is enabled, be sure to review the attribute mappings to ensure an appropriate field is being used for the “matching ID”. The matching ID can be the display name or email alias. The group and its members are not provisioned if the matching property is empty or not populated for a group in Microsoft Entra ID.
## Provisioning users assigned to the default access role
The default role on an application from the gallery is called the "default access" role. Historically, users assigned to this role are not provisioned and are marked as skipped in the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) due to being "not effectively entitled." 

**Behavior for provisioning configurations created after 04/16/2020:**
Users assigned to the default access role will be evaluated the same as all other roles. A user that is assigned the default access will not be skipped as "not effectively entitled." 

**Behavior for provisioning configurations created before 04/16/2020:**
For the next 3 months, the behavior will continue as it is today. Users with the default access role will be skipped as not effectively entitled. After July 2020, the behavior will be uniform for all applications. We will not skip provisioning users with the default access role due to being "not effectively entitled." This change will be made by Microsoft, with no customer action required. If you would like to ensure that these users continue to be skipped, even after this change, please apply the appropriate scoping filters or unassign the user from the application to ensure they are out of scope.  

For questions about these changes, please reach out to provisioningfeedback@microsoft.com
## Next steps

[Microsoft Entra Connect Sync: Understanding Declarative Provisioning](~/identity/hybrid/connect/concept-azure-ad-connect-sync-declarative-provisioning.md)
