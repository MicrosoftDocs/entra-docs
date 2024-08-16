---
title: View privileged role assignments in Microsoft Entra Insights
description: How to view current privileged role assignments in the Microsoft Entra Insights tab.
author: jenniferf-skc
manager: amycolannino
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 05/13/2024
ms.author: jfields
---

# View privileged role assignments in your organization

The **Microsoft Entra Insights** tab shows you who is assigned to [privileged roles](/entra/identity/role-based-access-control/permissions-reference) in your organization. You can review a list of identities assigned to a privileged role and learn more about each identity.

> [!NOTE] 
> Keep role assignments permanent if a user has an additional Microsoft account (for example, an account they use to sign in to Microsoft services like Skype or Outlook.com). If you require multi-factor authentication to activate a role assignment, a user with an additional Microsoft account will be locked out.  

[!INCLUDE [emergency-access-accounts](../includes/definitions/emergency-access-accounts.md)]

## Prerequisite
To view information on the Microsoft Entra Insights tab, you must have [Permissions Management Administrator](/entra/identity/role-based-access-control/permissions-reference#permissions-management-administrator) role permissions.

<a name='view-information-in-the-azure-ad-insights-tab'></a>

## View information in the Microsoft Entra Insights tab

1. From the Permissions Management home page, select the **Microsoft Entra Insights** tab.
2. Select **Review Global Administrators** to review the list of Global Administrator role assignments.
3. Select **Review highly privileged roles** or **Review service principals** to review information on principal role assignments for the following roles: *Application Administrator*, *Cloud Application Administrator*, *Exchange Administrator*, *Intune Administrator*, *Privileged Role Administrator*, *SharePoint Administrator*, *Security Administrator*, *User Administrator*. 


## Next steps

- For information about managing roles, policies and permissions requests in your organization, see [View roles/policies and requests for permission in the Remediation dashboard](ui-remediation.md).
