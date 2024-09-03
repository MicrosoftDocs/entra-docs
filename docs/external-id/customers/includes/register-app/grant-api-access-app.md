---
author: csmulligan
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 07/12/2023
ms.author: cmulligan
ms.manager: celestedg
---
For your application to access data in Microsoft Graph API, grant the registered application the relevant application permissions. The effective permissions of your application are the full level of privileges implied by the permission. For example, to create, read, update, and delete every user in your external tenant, add the User.ReadWrite.All permission.

1. Under **Manage**, select **API permissions**.

1. Under **Configured permissions**, select **Add a permission**.

1. Select the **Microsoft APIs** tab, then select **Microsoft Graph**.

1. Select **Application permissions**.

1. Expand the appropriate permission group and select the check box of the permission to grant to your management application. For example:

    * **User** > **User.ReadWrite.All**: For user migration or user management scenarios.

    * **Group** > **Group.ReadWrite.All**: For creating groups, read and update group memberships, and delete groups.

    * **AuditLog** > **AuditLog.Read.All**: For reading the directory's audit logs.

    * **Policy** > **Policy.ReadWrite.TrustFramework**: For continuous integration/continuous delivery (CI/CD) scenarios. For example, custom policy deployment with Azure Pipelines.

1. Select **Add permissions**. As directed, wait a few minutes before proceeding to the next step.

1. Select **Grant admin consent for (your tenant name)**.

1. If you are not currently signed-in, sign in with an account in your external tenant that's been assigned at least the [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) role and then select **Grant admin consent for (your tenant name)**.

1. Select **Refresh**, and then verify that "Granted for ..." appears under **Status**. It might take a few minutes for the permissions to propagate.

After you have registered your application, you need to add a client secret to your application. This client secret will be used to authenticate your application to call the Microsoft Graph API.
