---
title: Users aren't being provisioned in my application
description: Troubleshoot common issues faced when a user isn't appearing in a Microsoft Entra Gallery Application configured for user provisioning with Microsoft Entra ID.
#customer intent: As an IT admin, I want to troubleshoot why users aren't being provisioned in a Microsoft Entra Gallery Application so that I can resolve the issue and ensure proper user access.  
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 04/15/2025
ms.author: kenwith
ms.reviewer: arvinh
ai-usage: ai-assisted
---

# No users are being provisioned 
After automatic provisioning is configured for an application (including verifying that the app credentials provided to Microsoft Entra ID to connect to the app are valid), then users and/or groups are provisioned to the app. Provisioning is determined by the following things:

-   Which users and groups have been **assigned** to the application. Provisioning nested groups isn't supported. For more information on assignment, see [Assign a user or group to an enterprise app in Microsoft Entra ID](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).
-   Whether or not **attribute mappings** are enabled, and configured to sync valid attributes from Microsoft Entra ID to the app. For more information on attribute mappings, see [Customizing User Provisioning Attribute Mappings for SaaS Applications in Microsoft Entra ID](customize-application-attributes.md).
-   Whether or not there's a **scoping filter** present that is filtering users based on specific attribute values. For more information on scoping filters, see [Attribute-based application provisioning with scoping filters](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

If you observe that users aren't being provisioned, consult the [Provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context) in Microsoft Entra ID. Search for log entries for a specific user.

You can access the provisioning logs in the Microsoft Entra admin center by browsing to **Entra ID** > **Enterprise apps** > **Provisioning logs**. You can also select a specific application and then select **Provisioning logs** in the **Activity** section. You can search the provisioning data based on the name of the user or the identifier in either the source system or the target system. For details, see [Provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context). 

The provisioning logs record all the operations performed by the provisioning service, including querying Microsoft Entra ID for assigned users that are in scope for provisioning, querying the target app for the existence of those users, comparing the user objects between the system. Then add, update, or disable the user account in the target system based on the comparison.

## Provisioning service doesn't appear to start
If you set the **Provisioning Status** to be **On** in the **Enterprise applications &gt; \[Application Name\] &gt;Provisioning** section of the Microsoft Entra admin center. However no other status details are shown on that page after subsequent reloads, it's likely that the service is running but hasn't completed an initial cycle yet. Check the **Provisioning logs** to determine what operations the service is performing, and if there are any errors.

>[!NOTE]
>An initial cycle can take anywhere from 20 minutes to several hours, depending on the size of the Microsoft Entra directory and the number of users in scope for provisioning. Subsequent syncs after the initial cycle are faster, as the provisioning service stores watermarks that represent the state of both systems after the initial cycle. The initial cycle improves performance of subsequent syncs.
>


## Provisioning logs say users are skipped and not provisioned even though they're assigned

When a user shows up as “skipped” in the provisioning logs, it's important to review the **Steps** tab of the log to determine the reason. Common reasons and resolutions:

- **A scoping filter has been configured** **that is filtering the user out based on an attribute value**. For more information on scoping filters, see [scoping filters](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
- **The user is “not effectively entitled”.** If you see this specific error message, it's because there's a problem with the user assignment record stored in Microsoft Entra ID. To fix this issue, unassign the user (or group) from the app, and reassign it again. For more information on assignment, see [Assign user or group access](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).
- **A required attribute is missing or not populated for a user.** An important thing to consider when setting up provisioning is to review and configure the attribute mappings and workflows that define which user (or group) properties flow from Microsoft Entra ID to the application. This configuration includes setting the “matching property” that is used to uniquely identify and match users/groups between the two systems. For more information on this important process, see [Customizing User Provisioning Attribute Mappings for SaaS Applications in Microsoft Entra ID](customize-application-attributes.md).
- **Attribute mappings for groups:** Provisioning of the group name and group details, in addition to the members, if supported for some applications. You can enable or disable this functionality by enabling or disabling the **Mapping** for group objects shown in the **Provisioning** tab. If provisioning groups is enabled, be sure to review the attribute mappings to ensure an appropriate field is being used for the “matching ID”. The matching ID can be the display name or email alias. The group and its members aren't provisioned if the matching property is empty or not populated for a group in Microsoft Entra ID.
## Provisioning users assigned to the default access role
The default role on an application from the gallery is called the "default access" role. Historically, users assigned to this role aren't provisioned and are marked as skipped in the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) due to being "not effectively entitled." 


## Next steps
- [Microsoft Entra Connect Sync: Understanding Declarative Provisioning](~/identity/hybrid/connect/concept-azure-ad-connect-sync-declarative-provisioning.md)
