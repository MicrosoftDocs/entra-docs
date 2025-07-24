---
title: Troubleshoot provisioning to a Microsoft Entra gallery app.
description: How to troubleshoot common issues faced when configuring user provisioning to an application already listed in the Microsoft Entra application gallery.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: troubleshooting
ms.date: 03/04/2025
ms.author: jenniferf-skc
ms.reviewer: asteen, arvinh
ai-usage: ai-assisted
---

# Problem configuring user provisioning to a Microsoft Entra gallery application

Troubleshoot configuration for application provisioning. For more information, see [automatic user provisioning](user-provisioning.md). 

Start by finding the setup tutorial for your application. Then follow the steps to configure both the app and Microsoft Entra ID to create the provisioning connection. For a list of tutorials, see [List of Tutorials on How to Integrate SaaS Apps with Microsoft Entra ID](~/identity/saas-apps/tutorial-list.md).

## Check if provisioning is working 

Once the service is configured, most insights into the operation of the service can be drawn from two places.

-   **Provisioning logs (preview)** – The [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context) record all operations performed by the provisioning service. The logs include querying Microsoft Entra ID for assigned users that are in scope for provisioning. Query the target app for the existence of those users, comparing the user objects between the system. Then add, update, or disable the user account in the target system based on the comparison. You access the provisioning logs in the Microsoft Entra admin center by selecting **Entra ID** > **Enterprise apps** > **Provisioning logs** in the **Activity** section.

-   **Current status –** A summary of the last provisioning run for a given app can be seen in the **Entra ID** > **Enterprise apps** > `[Application Name]` > **Provisioning** section, at the bottom of the screen under the service settings. The Current Status section shows if a provisioning cycle starts provisioning user accounts. Watch the progress of the cycle, see how many users and groups are provisioned, and how many roles are created. If there are errors, details can be found in the [Provisioning logs] (~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context).

## Provisioning service doesn't appear to start

You set the **Provisioning Status** to be **On** in the **Entra ID** > **Enterprise apps** > `[Application Name]` > **Provisioning** section of the Microsoft Entra admin center. However, no other status details are shown on the page after subsequent reloads. It's likely that the service is running but an initial cycle didn't complete. Check the **Provisioning logs** to determine what operations the service is performing, and if there are any errors.

>[!NOTE]
>An initial cycle takes between 20 minutes and several hours. The time depends on the size of the Microsoft Entra directory and the number of users in scope for provisioning. Subsequent syncs are faster, as the provisioning service stores watermarks that represent the state of both systems after the initial cycle. The watermarks improve performance of subsequent syncs.

## Can’t save configuration due to app credentials not working

Microsoft Entra ID requires valid credentials for provisioning. The credentials connect to a user management API provided by the app. If the credentials don’t work, or you don’t know what they are, review the tutorial for setting up the app.

## Provisioning logs say users are skipped and not provisioned even though they're assigned

Read the extended details in the log message to determine why a user shows up as skipped in the provisioning logs. Common reasons and resolutions include:

- **A scoping filter has been configured that is filtering the user out based on an attribute value**. For more information, see [Attribute-based application provisioning with scoping filters](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

- **The user is “not effectively entitled”.** There's a problem with the user assignment record stored in Microsoft Entra ID. To fix this issue, unassign the user (or group) from the app, and reassign it again. For more information, see [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md).

- **A required attribute is missing or not populated for a user.** Review and configure the attribute mappings and workflows that define which user (or group) properties flow from Microsoft Entra ID to the application. Check the setting `matching property` that is used to uniquely identify and match users/groups between the two systems. For more information, see [Customizing user provisioning attribute-mappings](~/identity/app-provisioning/customize-application-attributes.md).

- **Attribute mappings for groups:** Provisioning of the group name and group details, in addition to the members, if supported for some applications. You enable or disable the functionality using the **Mapping** for group objects shown in the **Provisioning** tab. If provisioning groups are enabled, review the attribute mappings to ensure an appropriate field is being used for `matching ID`. The field is the display name or email alias. The group and its members aren't provisioned if the matching property is empty or not populated for a group in Microsoft Entra ID.

## Next steps
- [Automate User Provisioning and Deprovisioning to SaaS Applications with Microsoft Entra ID](user-provisioning.md)
