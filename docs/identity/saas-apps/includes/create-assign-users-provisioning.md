---
author: omondiatieno
ms.author: jomondi
ms.date: 02/24/2025
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: include
# Purpose:
# This is used to include the content for creating and assigning a user to application into in SaaS apps provisioning articles
---

The Microsoft Entra provisioning service allows you to scope who is provisioned based on assignment to the application, or based on attributes of the user or group. If you choose to scope who is provisioned to your app based on assignment, you can use the [steps to assign users and groups to the application](~/identity/enterprise-apps/assign-user-or-group-access-portal.md). If you choose to scope who is provisioned based solely on attributes of the user or group, you can [use a scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

- Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

- If you need extra roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.