---
title: Scoping users or groups to be provisioned with scoping filters in Microsoft Entra ID
description: Learn how to use scoping filters to define attribute-based rules that determine which users or groups are provisioned in Microsoft Entra ID.

author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 01/18/2024
ms.author: kenwith
ms.reviewer: arvinh
zone_pivot_groups: app-provisioning-cross-tenant-synchronization
---

# Scoping users or groups to be provisioned with scoping filters

Learn how to use scoping filters in the Microsoft Entra provisioning service to define attribute based rules. The rules are used to determine which users or groups are provisioned.

## Scoping filter use cases

::: zone pivot="app-provisioning"
You use scoping filters to prevent objects in applications that support automated user provisioning from being provisioned if an object doesn't satisfy your business requirements. A scoping filter allows you to include or exclude any users who have an attribute that matches a specific value. For example, when provisioning users from Microsoft Entra ID to a SaaS application used by a sales team, you can specify that only users with a "Department" attribute of "Sales" should be in scope for provisioning.

Scoping filters can be used differently depending on the type of provisioning connector:

* **Outbound provisioning from Microsoft Entra ID to SaaS applications**. When Microsoft Entra ID is the source system, [user and group assignments](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) are the most common method for determining which users are in scope for provisioning. These assignments also are used for enabling single sign-on and provide a single method to manage access and provisioning. Scoping filters can be used optionally, in addition to assignments or instead of them, to filter users based on attribute values.

    >[!TIP]
    > The more users and groups in scope for provisioning, the longer the synchronization process can take. Setting the scope to sync assigned users and groups,  limiting the number of groups assigned to the app, and limiting the size of the groups will reduce the time it takes to synchronize everyone that is in scope.  

* **Inbound provisioning from HCM applications to Microsoft Entra ID and Active Directory**. When an [HCM application such as Workday](~/identity/saas-apps/workday-tutorial.md) is the source system, scoping filters are the primary method for determining which users should be provisioned from the HCM application to Active Directory or Microsoft Entra ID.

By default, Microsoft Entra provisioning connectors don't have any attribute-based scoping filters configured. 
::: zone-end

::: zone pivot="cross-tenant-synchronization"
When Microsoft Entra ID is the source system, [user and group assignments](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) are the most common method for determining which users are in scope for provisioning. Reducing the number of users in scope improves performance and synchronizing assigned users and groups instead of synchronizing all users and groups is recommended.

Scoping filters can be used optionally, in addition to scoping by assignment. A scoping filter allows the Microsoft Entra provisioning service to include or exclude any users who have an attribute that matches a specific value. For example, when provisioning users from a sales team, you can specify that only users with a "Department" attribute of "Sales" should be in scope for provisioning.
::: zone-end

## Scoping filter construction

A scoping filter consists of one or more *clauses*. Clauses determine which users are allowed to pass through the scoping filter by evaluating each user's attributes. For example, you might have one clause that requires that a user's "State" attribute equals "New York", so only New York users are provisioned into the application. 

A single clause defines a single condition for a single attribute value. If multiple clauses are created in a single scoping filter, they're evaluated together using "AND" logic. The "AND" logic means all clauses must evaluate to "true" in order for a user to be provisioned.

Finally, multiple scoping filters can be created for a single application. If multiple scoping filters are present, they're evaluated together by using "OR" logic. The "OR" logic means that if all the clauses in any of the configured scoping filters evaluate to "true", the user is provisioned.

Each user or group processed by the Microsoft Entra provisioning service is always evaluated individually against each scoping filter.

As an example, consider the following scoping filter:

![Scoping filter](./media/define-conditional-rules-for-provisioning-user-accounts/scoping-filter.PNG) 

According to this scoping filter, users must satisfy the following criteria to be provisioned:

* They must be in New York.
* They must work in the Engineering department.
* Their company employee ID must be between 1,000,000 and 2,000,000.
* Their job title must not be null or empty.

## Create scoping filters
Scoping filters are configured as part of the attribute mappings for each Microsoft Entra user provisioning connector. The following procedure assumes that you already set up automatic provisioning for [one of the supported applications](~/identity/saas-apps/tutorial-list.md) and are adding a scoping filter to it.

### Create a scoping filter

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).

::: zone pivot="app-provisioning"

2. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.

3. Select the application for which you have configured automatic provisioning: for example, "ServiceNow".

::: zone-end

::: zone pivot="cross-tenant-synchronization"

2. Browse to **Identity** > **External Identities** > **Cross-tenant Synchronization** > **Configurations**

3. Select your configuration.

::: zone-end

4. Select the **Provisioning** tab.

::: zone pivot="app-provisioning"

5. In the **Mappings** section, select the mapping that you want to configure a scoping filter for: for example, "Synchronize Microsoft Entra users to ServiceNow".

::: zone-end

::: zone pivot="cross-tenant-synchronization"

5. In the **Mappings** section, select the mapping that you want to configure a scoping filter for: for example, "Provision Microsoft Entra users".

::: zone-end

6. Select the **Source object scope** menu.
7. Select **Add scoping filter**.
8. Define a clause by selecting a source **Attribute Name**, an **Operator**, and an **Attribute Value** to match against. The following operators are supported:

   a. **&**. Clause returns "true" if the evaluated attribute exists in the input string value. 

   b. **!&**. Clause returns "true" if the evaluated attribute does not exist in the input string value. 
   
   c. **ENDS_WITH**. Clause returns "true" if the evaluated attribute ends with the input string value.

   d. **EQUALS**. Clause returns "true" if the evaluated attribute matches the input string value exactly (case sensitive).

   e. **Greater_Than.** Clause returns "true" if the evaluated attribute is greater than the value. The value specified on the scoping filter must be an integer and the attribute on the user must be an integer [0,1,2,...]. 
 
   f. **Greater_Than_OR_EQUALS.** Clause returns "true" if the evaluated attribute is greater than or equal to the value. The value specified on the scoping filter must be an integer and the attribute on the user must be an integer [0,1,2,...]. 
   
   g. **Includes.** Clause returns "true" if the evaluated attribute contains the string value (case sensitive) as described [here](/dotnet/api/system.string.contains). 

   h. **IS FALSE**. Clause returns "true" if the evaluated attribute contains a Boolean value of false.

   i. **IS NOT NULL**. Clause returns "true" if the evaluated attribute isn't empty.

   j. **IS NULL**. Clause returns "true" if the evaluated attribute is empty.

   k. **IS TRUE**. Clause returns "true" if the evaluated attribute contains a Boolean value of true.

   l. **NOT EQUALS**. Clause returns "true" if the evaluated attribute doesn't match the input string value (case sensitive).

   m. **NOT REGEX MATCH**. Clause returns "true" if the evaluated attribute doesn't match a regular expression pattern. It returns "false" if the attribute is null / empty.

   n. **REGEX MATCH**. Clause returns "true" if the evaluated attribute matches a regular expression pattern. For example: `([1-9][0-9])` matches any number between 10 and 99 (case sensitive).   

>[!IMPORTANT] 
> - The IsMemberOf filter is not supported currently.
> - The members attribute on a group is not supported currently.
> - Filtering is not supported for multi-valued attributes.
> - Scoping filters will return "false" if the value is null / empty.

9. Optionally, repeat steps 7-8 to add more scoping clauses.

10. In **Scoping Filter Title**, add a name for your scoping filter.

11. Select **OK**.

12. Select **OK** again on the **Scoping Filters** screen. Optionally, repeat steps 6-11 to add another scoping filter.

13. Select **Save** on the **Attribute Mapping** screen. 

>[!IMPORTANT] 
> Saving a new scoping filter triggers a new full sync for the application, where all users in the source system are evaluated again against the new scoping filter. If a user in the application was previously in scope for provisioning, but falls out of scope, their account is disabled or deprovisioned in the application. To override this default behavior, refer to [Skip deletion for user accounts that go out of scope](~/identity/app-provisioning/skip-out-of-scope-deletions.md).

## Common scoping filters
| Target Attribute| Operator | Value | Description|
|----|----|----|----|
|userPrincipalName|REGEX MATCH|`.*\@domain.com`|All users with `userPrincipal` that have the domain `@domain.com` are in scope for provisioning. |
|userPrincipalName|NOT REGEX MATCH|`.*\@domain.com`|All users with `userPrincipal` that has the domain `@domain.com` are out of scope for provisioning. |
|department|EQUALS|`sales`|All users from the sales department are in scope for provisioning|
|workerID|REGEX MATCH|`(1[0-9][0-9][0-9][0-9][0-9][0-9])`| All employees with `workerID` between 1000000 and 2000000 are in scope for provisioning.|

## Related articles
* [Automate user provisioning and deprovisioning to SaaS applications](~/identity/app-provisioning/user-provisioning.md)
* [Customize attribute mappings for user provisioning](~/identity/app-provisioning/customize-application-attributes.md)
* [Write expressions for attribute mappings](functions-for-customizing-application-data.md)
* [Account provisioning notifications](~/identity/app-provisioning/user-provisioning.md)
* [Use SCIM to enable automatic provisioning of users and groups from Microsoft Entra ID to applications](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md)
* [List of tutorials on how to integrate SaaS apps](~/identity/saas-apps/tutorial-list.md)
