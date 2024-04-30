---
title: Understand how Application Provisioning in Microsoft Entra ID
description: Understand how Application Provisioning works in Microsoft Entra ID.

author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: conceptual
ms.date: 09/15/2023
ms.author: kenwith
ms.reviewer: arvinh
---

# How Application Provisioning works in Microsoft Entra ID

Automatic provisioning refers to creating user identities and roles in the cloud applications that users need to access. In addition to creating user identities, automatic provisioning includes the maintenance and removal of user identities as status or roles change. Before you start a deployment, you can review this article to learn how Microsoft Entra provisioning works and get configuration recommendations. 

The **Microsoft Entra provisioning service** provisions users to SaaS apps and other systems by connecting to a System for Cross-Domain Identity Management (SCIM) 2.0 user management API endpoint provided by the application vendor or an on-premises provisioning agent. This SCIM endpoint allows Microsoft Entra ID to programmatically create, update, and remove users. For selected applications, the provisioning service can also create, update, and remove extra identity-related objects, such as groups. The channel used for provisioning between Microsoft Entra ID and the application is encrypted using HTTPS TLS 1.2 encryption.


![Microsoft Entra provisioning service](./media/how-provisioning-works/provisioning0.PNG)
*Figure 1: The Microsoft Entra provisioning service*

![Outbound user provisioning workflow](./media/how-provisioning-works/provisioning1.PNG)
*Figure 2: "Outbound" user provisioning workflow from Microsoft Entra ID to popular SaaS applications*

![Inbound user provisioning workflow](./media/how-provisioning-works/provisioning2.PNG)
*Figure 3: "Inbound" user provisioning workflow from popular Human Capital Management (HCM) applications to Microsoft Entra ID and Windows Server Active Directory*

## Provisioning using SCIM 2.0

The Microsoft Entra provisioning service uses the [SCIM 2.0 protocol](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/provisioning-with-scim-getting-started/ba-p/880010) for automatic provisioning. The service connects to the SCIM endpoint for the application, and uses SCIM user object schema and REST APIs to automate the provisioning and deprovisioning of users and groups. A SCIM-based provisioning connector is provided for most applications in the Microsoft Entra gallery. Developers use the SCIM 2.0 user management API in Microsoft Entra ID to build endpoints for their apps that integrate with the provisioning service. For details, see [Build a SCIM endpoint and configure user provisioning](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md). The on-premises provisioning agent also translates Microsoft Entra SCIM operations to [LDAP](./on-premises-ldap-connector-configure.md), [SQL](./tutorial-ecma-sql-connector.md), [REST or SOAP](./on-premises-web-services-connector.md), [PowerShell](./on-premises-powershell-connector.md), calls to a [custom ECMA connector](./on-premises-custom-connector.md), or [connectors and gateways built by partners](./partner-driven-integrations.md).

To request an automatic Microsoft Entra provisioning connector for an app that doesn't currently have one, see [Microsoft Entra Application Request](~/identity/enterprise-apps/v2-howto-app-gallery-listing.md).

## Authorization

Credentials are required for Microsoft Entra ID to connect to the application's user management API. While you're configuring automatic user provisioning for an application, you need to enter valid credentials. For gallery applications, you can find credential types and requirements for the application by referring to the app tutorial. For non-gallery applications, you can refer to the [SCIM](./use-scim-to-provision-users-and-groups.md#authorization-to-provisioning-connectors-in-the-application-gallery) documentation to understand the credential types and requirements. In the Microsoft Entra admin center, you're able to test the credentials by having Microsoft Entra ID attempt to connect to the app's provisioning app using the supplied credentials.

## Mapping attributes

When you enable user provisioning for a third-party SaaS application, the Microsoft Entra admin center controls its attribute values through attribute mappings. Mappings determine the user attributes that flow between Microsoft Entra ID and the target application when user accounts are provisioned or updated.

There's a preconfigured set of attributes and attribute mappings between Microsoft Entra user objects and each SaaS app’s user objects. Some apps manage other types of objects along with Users, such as Groups.

When setting up provisioning, it's important to review and configure the attribute mappings and workflows that define which user (or group) properties flow from Microsoft Entra ID to the application. Review and configure the matching property (**Match objects using this attribute**) that is used to uniquely identify and match users/groups between the two systems.

You can customize the default attribute-mappings according to your business needs. So, you can change or delete existing attribute-mappings, or create new attribute-mappings. For details, see [Customizing user provisioning attribute-mappings for SaaS applications](./customize-application-attributes.md).

When you configure provisioning to a SaaS application, one of the types of attribute mappings that you can specify is an expression mapping. For these mappings, you must write a script-like expression that allows you to transform your users’ data into formats that are more acceptable for the SaaS application. For details, see [Writing expressions for attribute mappings](functions-for-customizing-application-data.md).

## Scoping 
### Assignment-based scoping

For outbound provisioning from Microsoft Entra ID to a SaaS application, relying on [user or group assignments](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) is the most common way to determine which users are in scope for provisioning. Because user assignments are also used for enabling single sign-on, the same method can be used for managing both access and provisioning. Assignment-based scoping doesn't apply to inbound provisioning scenarios such as Workday and Successfactors.

* **Groups.** With a Microsoft Entra ID P1 or P2 license plan, you can use groups to assign access to a SaaS application. Then, when the provisioning scope is set to **Sync only assigned users and groups**, the Microsoft Entra provisioning service provisions or deprovisions users based on whether they're members of a group that's assigned to the application. The group object itself isn't provisioned unless the application supports group objects. Ensure that groups assigned to your application have the property "SecurityEnabled" set to "True".

* **Dynamic groups.** The Microsoft Entra user provisioning service can read and provision users in [dynamic groups](~/identity/users/groups-create-rule.md). Keep these caveats and recommendations in mind:

  * Dynamic groups can impact the performance of end-to-end provisioning from Microsoft Entra ID to SaaS applications.

  * How fast a user in a dynamic group is provisioned or deprovisioned in a SaaS application depends on how fast the dynamic group can evaluate membership changes. For information about how to check the processing status of a dynamic group, see [Check processing status for a membership rule](~/identity/users/groups-create-rule.md).

  * When a user loses membership in the dynamic group, it's considered a deprovisioning event. Consider this scenario when creating rules for dynamic groups.

* **Nested groups.** The Microsoft Entra user provisioning service can't read or provision users in nested groups. The service can only read and provision users that are immediate members of an explicitly assigned group. This limitation of "group-based assignments to applications" also affects single sign-on (see [Using a group to manage access to SaaS applications](~/identity/users/groups-saasapps.md)). Instead, directly assign or otherwise [scope in](define-conditional-rules-for-provisioning-user-accounts.md) the groups that contain the users who need to be provisioned.

### Attribute-based scoping 

You can use scoping filters to define attribute-based rules that determine which users are provisioned to an application. This method is commonly used for inbound provisioning from HCM applications to Microsoft Entra ID and Active Directory. Scoping filters are configured as part of the attribute mappings for each Microsoft Entra user provisioning connector. For details about configuring attribute-based scoping filters, see [Attribute-based application provisioning with scoping filters](define-conditional-rules-for-provisioning-user-accounts.md).

### B2B (guest) users

It's possible to use the Microsoft Entra user provisioning service to provision B2B (guest) users in Microsoft Entra ID to SaaS applications. However, for B2B users to sign in to the SaaS application using Microsoft Entra ID, you must manually configure the SaaS application to use Microsoft Entra ID as a Security Assertion Markup Language (SAML) identity provider. 

Follow these general guidelines when configuring SaaS apps for B2B (guest) users:  
- For most of the apps, user setup needs to happen manually. Users must be created manually in the app as well.
- For apps that support automatic setup, such as Dropbox, separate invitations are created from the apps. Users must be sure to accept each invitation.
- In the user attributes, to mitigate any issues with mangled user profile disk (UPD) in guest users, always set the user identifier to **user.mail**.

> [!NOTE]
> The userPrincipalName for a [B2B collaboration user](~/external-id/user-properties.md) represents the external user's email address alias@theirdomain as "alias_theirdomain#EXT#@yourdomain". When the userPrincipalName attribute is included in your attribute mappings as a source attribute, and a B2B user is being provisioned, the #EXT# and your domain is stripped from the userPrincipalName, so only their original alias@theirdomain is used for matching or provisioning. If you require the full user principal name including #EXT# and your domain to be present, replace userPrincipalName with originalUserPrincipalName as the source attribute. <br />
userPrincipalName = alias@theirdomain<br />
originalUserPrincipalName = alias_theirdomain#EXT#@yourdomain

## Provisioning cycles: Initial and incremental

When Microsoft Entra ID is the source system, the provisioning service uses the [delta query to track changes in Microsoft Graph data](/graph/delta-query-overview) to monitor users and groups. The provisioning service runs an initial cycle against the source system and target system, followed by periodic incremental cycles.

### Initial cycle

When the provisioning service is started, the first cycle will:

1. Query all users and groups from the source system, retrieving all attributes defined in the [attribute mappings](customize-application-attributes.md).

2. Filter the users and groups returned, using any configured [assignments](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) or [attribute-based scoping filters](define-conditional-rules-for-provisioning-user-accounts.md).

3. When a user is assigned or in scope for provisioning, the service queries the target system for a matching user using the specified [matching attributes](customize-application-attributes.md#understanding-attribute-mapping-properties). Example: If the userPrincipal name in the source system is the matching attribute and maps to userName in the target system, then the provisioning service queries the target system for userNames that match the userPrincipal name values in the source system.

4. If a matching user isn't found in the target system, it's created using the attributes returned from the source system. After the user account is created, the provisioning service detects and caches the target system's ID for the new user. This ID is used to run all future operations on that user.

5. If a matching user is found, it's updated using the attributes provided by the source system. After the user account is matched, the provisioning service detects and caches the target system's ID for the new user. This ID is used to run all future operations on that user.

6. If the attribute mappings contain "reference" attributes, the service does more updates on the target system to create and link the referenced objects. For example, a user may have a "Manager" attribute in the target system, which is linked to another user created in the target system.

7. Persist a watermark at the end of the initial cycle, which provides the starting point for the later incremental cycles.

Some applications such as ServiceNow, G Suite, and Box support not only provisioning users, but also provisioning groups and their members. In those cases, if group provisioning is enabled in the [mappings](customize-application-attributes.md), the provisioning service synchronizes the users and the groups, and then later synchronizes the group memberships.

### Incremental cycles

After the initial cycle, all other cycles will:

1. Query the source system for any users and groups that were updated since the last watermark was stored.

2. Filter the users and groups returned, using any configured [assignments](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) or [attribute-based scoping filters](define-conditional-rules-for-provisioning-user-accounts.md).

3. When a user is assigned or in scope for provisioning, the service queries the target system for a matching user using the specified [matching attributes](customize-application-attributes.md#understanding-attribute-mapping-properties).

4. If a matching user isn't found in the target system, it's created using the attributes returned from the source system. After the user account is created, the provisioning service detects and caches the target system's ID for the new user. This ID is used to run all future operations on that user.

5. If a matching user is found, it's updated using the attributes provided by the source system. If it's a newly assigned account that is matched, the provisioning service detects and caches the target system's ID for the new user. This ID is used to run all future operations on that user.

6. If the attribute mappings contain "reference" attributes, the service does more updates on the target system to create and link the referenced objects. For example, a user may have a "Manager" attribute in the target system, which is linked to another user created in the target system.

7. If a user that was previously in scope for provisioning is removed from scope, including being unassigned, the service disables the user in the target system via an update.

8. If a user that was previously in scope for provisioning is disabled or soft-deleted in the source system, the service disables the user in the target system via an update.

9. If a user that was previously in scope for provisioning is hard-deleted in the source system, the service deletes the user in the target system. In Microsoft Entra ID, users are hard-deleted 30 days after they're soft-deleted.

10. Persist a new watermark at the end of the incremental cycle, which provides the starting point for the later incremental cycles.

> [!NOTE]
> You can optionally disable the **Create**, **Update**, or **Delete** operations by using the **Target object actions** check boxes in the [Mappings](customize-application-attributes.md) section. The logic to disable a user during an update is also controlled via an attribute mapping from a field such as *accountEnabled*.

The provisioning service continues running back-to-back incremental cycles indefinitely, at intervals defined in the [tutorial specific to each application](~/identity/saas-apps/tutorial-list.md). Incremental cycles continue until one of the events occurs:

- The service is manually stopped using the Microsoft Entra admin center, or using the appropriate Microsoft Graph API command.
- A new initial cycle is triggered using the **Restart provisioning** option in the Microsoft Entra admin center, or using the appropriate Microsoft Graph API command. The action clears any stored watermark and causes all source objects to be evaluated again. Also, the action doesn't break the links between source and target objects. To break the links, use [Restart synchronizationJob](/graph/api/synchronization-synchronizationjob-restart?view=graph-rest-beta&tabs=http&preserve-view=true) with the request: 

<!-- {
  "blockType": "request",
  "name": "synchronizationjob_restart"
}-->
```http
POST https://graph.microsoft.com/beta/servicePrincipals/{id}/synchronization/jobs/{jobId}/restart
Authorization: Bearer <token>
Content-type: application/json
{
   "criteria": {
       "resetScope": "Full"
   }
}
```
- A new initial cycle is triggered because of a change in attribute mappings or scoping filters. This action also clears any stored watermark and causes all source objects to be evaluated again.
- The provisioning process goes into quarantine (see example) because of a high error rate, and stays in quarantine for more than four weeks. In this event, the service is automatically disabled.

### Errors and retries

If an error in the target system prevents an individual user from being added, updated, or deleted in the target system, the operation is retried in the next sync cycle. The errors are continually retried, gradually scaling back the frequency of retries. To resolve the failure, administrators must check the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context) to determine the root cause and take the appropriate action. Common failures can include:

- Users not having an attribute populated in the source system that is required in the target system
- Users having an attribute value in the source system for which there's a unique constraint in the target system, and the same value is present in another user record

Resolve these failures by adjusting the attribute values for the affected user in the source system, or by adjusting the attribute mappings so they don't cause conflicts.

### Quarantine

If most or all of the calls that are made against the target system consistently fail because of an error (for example invalid admin credentials) the provisioning job goes into a "quarantine" state. This state is indicated in the [provisioning summary report](./check-status-user-account-provisioning.md) and via email if email notifications were configured in the Microsoft Entra admin center.

When in quarantine, the frequency of incremental cycles is gradually reduced to once per day.

The provisioning job exits quarantine after all of the offending errors are fixed and the next sync cycle starts. If the provisioning job stays in quarantine for more than four weeks, the provisioning job is disabled. Learn more here about quarantine status [here](./application-provisioning-quarantine-status.md).

### How long provisioning takes

Performance depends on whether your provisioning job is running an initial provisioning cycle or an incremental cycle. For details about how long provisioning takes and how to monitor the status of the provisioning service, see [Check the status of user provisioning](application-provisioning-when-will-provisioning-finish-specific-user.md).

### How to tell if users are being provisioned properly

All operations run by the user provisioning service are recorded in the Microsoft Entra [Provisioning logs (preview)](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context). The logs include all read and write operations made to the source and target systems, and the user data that was read or written during each operation. For information on how to read the provisioning logs in the Microsoft Entra admin center, see the [provisioning reporting guide](./check-status-user-account-provisioning.md).

## Deprovisioning
The Microsoft Entra provisioning service keeps source and target systems in sync by deprovisioning accounts when user access is removed.

The provisioning service supports both deleting and disabling (sometimes referred to as soft-deleting) users. The exact definition of disable and delete varies based on the target app's implementation, but generally a disable indicates that the user can't sign in. A delete indicates that the user has been removed completely from the application. For SCIM applications, a disable is a request to set the *active* property to false on a user. 

**Configure your application to disable a user**

Confirm the checkbox for updates is selected.

Confirm the mapping for *active* for your application. If you're using an application from the app gallery, the mapping may be slightly different. In this case, use the default mapping for gallery applications.

:::image type="content" source="./media/how-provisioning-works/disable-user.png" alt-text="Disable a user" lightbox="./media/how-provisioning-works/disable-user.png":::


**Configure your application to delete a user**

The scenario triggers a disable or a delete: 
* A user is soft-deleted in Microsoft Entra ID (sent to the recycle bin / AccountEnabled property set to false). Thirty days after a user is deleted in Microsoft Entra ID, they're permanently deleted from the tenant. At this point, the provisioning service sends a DELETE request to permanently delete the user in the application. At any time during the 30-day window, you can [manually delete a user permanently](~/fundamentals/users-restore.yml), which sends a delete request to the application.
* A user is permanently deleted / removed from the recycle bin in Microsoft Entra ID.
* A user is unassigned from an app.
* A user goes from in scope to out of scope (doesn't pass a scoping filter anymore).

:::image type="content" source="./media/how-provisioning-works/delete-user.png" alt-text="Delete a user" lightbox="./media/how-provisioning-works/delete-user.png":::

By default, the Microsoft Entra provisioning service soft-deletes or disables users that go out of scope. If you want to override this default behavior, you can set a flag to [skip out-of-scope deletions.](skip-out-of-scope-deletions.md)

When one of the four events occurs and the target application doesn't support soft-deletes, the provisioning service sends a DELETE request to permanently delete the user from the app.

If you see `IsSoftDeleted` in your attribute mappings, it's used to determine the state of the user and whether to send an update request with `active = false` to soft-delete the user.

**Deprovisioning events**

The table describes how you can configure deprovisioning actions with the Microsoft Entra provisioning service. These rules are written with the non-gallery / custom application in mind, but generally apply to applications in the gallery. However, the behavior for gallery applications can differ as they've been optimized to meet the needs of the application. For example, if the target application doesn't support soft-deleting then the Microsoft Entra provisioning service might send a hard-delete request to delete users rather than send a soft-delete.

|Scenario|How to configure in Microsoft Entra ID|
|--|--|
|A user is unassigned from an app, soft-deleted in Microsoft Entra ID, or blocked from sign-in. You don't want anything to be done.|Remove `isSoftDeleted` from the attribute mappings and / or set the [skip out of scope deletions](skip-out-of-scope-deletions.md) property to true.|
|A user is unassigned from an app, soft-deleted in Microsoft Entra ID, or blocked from sign-in. You want to set a specific attribute to `true` or `false`.|Map `isSoftDeleted` to the attribute that you would like to set to false.|
|A user is disabled in Microsoft Entra ID, unassigned from an app, soft-deleted in Microsoft Entra ID, or blocked from sign-in. You want to send a DELETE request to the target application.|This is currently supported for a limited set of gallery applications where the functionality is required. It's not configurable by customers.|
|A user is deleted in Microsoft Entra ID. You don't want anything done in the target application.|Ensure that "Delete" isn't selected as one of the target object actions in the [attribute configuration experience](skip-out-of-scope-deletions.md).|
|A user is deleted in Microsoft Entra ID. You want to set the value of an attribute in the target application.|Not supported.|
|A user is deleted in Microsoft Entra ID. You want to delete the user in the target application|Ensure that Delete is selected as one of the target object actions in the [attribute configuration experience](skip-out-of-scope-deletions.md).|

**Known limitations**

* When a user or group is unassigned from an app and no longer managed with the provisioning service, a disable request is sent. At that point, the service doesn't manage the user and a delete request isn't sent when the user is deleted from the directory.
* Provisioning a user that is disabled in Microsoft Entra ID isn't supported. They must be active in Microsoft Entra ID before they're provisioned.
* When a user goes from soft-deleted to active, the Microsoft Entra provisioning service activates the user in the target app, but doesn't automatically restore the group memberships. The target application should maintain the group memberships for the user in inactive state. If the target application doesn't support maintaining the inactive state, you can restart provisioning to update the group memberships. 

**Recommendation**

When developing an application, always support both soft-deletes and hard-deletes. It allows customers to recover when a user is accidentally disabled.


## Next Steps

[Plan an automatic user provisioning deployment](~/identity/app-provisioning/plan-auto-user-provisioning.md)

[Configure provisioning for a gallery app](./configure-automatic-user-provisioning-portal.md)

[Build a SCIM endpoint and configure provisioning when creating your own app](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md)

[Troubleshoot problems with configuring and provisioning users to an application](./application-provisioning-config-problem.md).
