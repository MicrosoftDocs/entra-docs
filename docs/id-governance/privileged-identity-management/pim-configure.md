---
title: What is Privileged Identity Management?
description: Provides an overview of Microsoft Entra Privileged Identity Management (PIM).
ms.topic: overview
ms.date: 11/17/2026
ms.reviewer: ilyal
ms.custom: pim, azuread-video-2020, content-engagement, sfi-ga-nochange, sfi-image-nochange, msecd-doc-authoring-1032
ai-usage: ai-assisted
#Customer Intent: As an IT administrator, I want to understand what Privileged Identity Management is and how it can help secure my organization's privileged access to critical resources.
---
# What is Microsoft Entra Privileged Identity Management?

## Overview

 Privileged Identity Management (PIM) is a service in Microsoft Entra ID that enables you to manage, control, and monitor access to important resources in your organization. These resources include resources in Microsoft Entra ID, Azure, and other Microsoft Online Services such as Microsoft 365 or Microsoft Intune. The following video explains important PIM concepts and features.
<br><br>

> [!VIDEO https://www.youtube.com/embed/f-0K7mRUPpQ]

PIM also supports eligible and active assignments for application-defined roles through [PIM for app roles (preview)](concept-pim-for-app-roles.md). Users can activate eligible app roles when they need them and deactivate them when they finish.

## Reasons to use

Organizations want to minimize the number of people who have access to secure information or resources, because that reduces the chance of

- a malicious actor getting access
- an authorized user inadvertently impacting a sensitive resource

However, users still need to carry out privileged operations in Microsoft Entra ID, Azure, Microsoft 365, or SaaS apps. Organizations can give users just-in-time privileged access to Azure and Microsoft Entra resources and can oversee what those users are doing with their privileged access.

## License requirements

[!INCLUDE [entra-id-license-pim.md](~/includes/entra-id-license-pim.md)]

PIM for app roles (preview) requires Microsoft Entra ID Governance licenses. Microsoft Entra ID P2 alone isn't sufficient.

License coverage is required for users with eligible or time-bound app role assignments and for request approvers.

## What does it do?

Privileged Identity Management provides time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused access permissions on resources that you care about. Here are some of the key features of Privileged Identity Management:

- Provide **just-in-time** privileged access to Microsoft Entra ID and Azure resources
- Assign **time-bound** access to resources using start and end dates
- Require **approval** to activate privileged roles
- Enforce **multifactor authentication** to activate any role
- Use **justification** to understand why users activate
- Get **notifications** when privileged roles are activated
- Conduct **access reviews** to ensure users still need roles
- Download **audit history** for internal or external audit
- Prevent removal of the **last active Global Administrator** and **Privileged Role Administrator** role assignments

The available capabilities depend on the PIM provider. For the app roles preview's workflows, see [PIM for app roles (preview)](concept-pim-for-app-roles.md).

## Privileged access capabilities in preview

PIM also includes preview capabilities for role activation, agent access, and privileged sessions. Licensing and setup requirements vary by feature; see the linked guides for prerequisites.

- **Activate roles in My Access.** Activate eligible Microsoft Entra roles, Azure resource roles, and group membership or ownership from one portal. See [Role activation in My Access (preview)](../my-access-portal-overview.md#activate-eligible-role-assignments).
- **Govern Azure resource access for agents.** Assign eligible Azure resource roles to agents and agent identities so they can activate access when needed. See [Eligible assignments for agents (preview)](pim-resource-roles-assign-roles.md#eligible-assignments-for-agents-preview) and [Agent identity activation (preview)](pim-resource-roles-activate-your-roles.md?pivots=api#activate-an-agent-identity-with-azure-resource-manager-api-preview).
- **Connect to virtual machines.** Use My Access to activate existing eligible access and connect to Azure virtual machines or supported Azure Arc-enabled Linux servers through available connection paths, including Azure Bastion. See [Virtual machine connections in My Access (preview)](pim-connect-virtual-machine-my-access.md).
- **Review session activity and recordings.** Session analytics show PIM role lifecycle and Azure Bastion connection activity, not commands run inside a virtual machine. With Azure Bastion Premium and recording configured, you can review recordings of supported connections. See [Session analytics (preview)](azure-pim-resource-rbac.md#review-session-activity-preview) and [Azure Bastion session recordings (preview)](azure-pim-resource-rbac.md#review-azure-bastion-session-recordings).
- **Manage active sessions.** Find and disconnect selected Azure Bastion RDP or SSH sessions without deactivating the user's role assignments. See [Session management in PIM (preview)](pim-manage-bastion-sessions.md).
- **Activate a lower-privileged role.** When the eligible role's policy allows it, select an available lower-privileged Azure resource role. You can optionally request a Microsoft Security Copilot recommendation based on your justification when the Copilot prerequisites are met. See [Least-privilege role activation (preview)](pim-resource-roles-configure-role-settings.md#allow-least-privilege-role-activation) and [Role recommendations with Microsoft Security Copilot](pim-resource-roles-activate-your-roles.md?pivots=my-access#get-a-role-recommendation-with-microsoft-security-copilot).
- **Reduce standing access.** Convert selected active Azure resource role assignments to eligible assignments that require activation before use. See [Active-to-eligible assignment conversion (preview)](pim-resource-roles-assign-roles.md?pivots=portal#convert-active-role-assignments-to-eligible-role-assignments).

## What can I do with it?

Once you set up Privileged Identity Management, you'll see **Tasks**, **Manage**, and **Activity** options in the left navigation menu. As an administrator, you can choose between options such as managing **Microsoft Entra roles**, managing **Azure resource** roles, or PIM for Groups. When you choose what you want to manage, you see the appropriate set of options for that option.

For app role assignments, select **App Roles (Preview)**, and then select an application. From the application, you can manage assignments and role settings, activate your eligible roles, and review requests.

:::image type="content" source="./media/pim-configure/pim-quickstart.png" alt-text="Screenshot of Privileged Identity Management in the Azure portal.":::

## Who can do what?

For Microsoft Entra roles in Privileged Identity Management, only a user who is in the Privileged Role Administrator or Global Administrator role can manage assignments for other administrators. Global Administrators, Security Administrators, Global Readers, and Security Readers can also view assignments to Microsoft Entra roles in Privileged Identity Management.

For Azure resource roles in Privileged Identity Management, only a subscription administrator, a resource Owner, or a resource User Access Administrator can manage assignments for other administrators. Users who are Privileged Role Administrators, Security Administrators, or Security Readers don't by default have access to view assignments to Azure resource roles in Privileged Identity Management.

For app role assignments, owners of the target service principal and users with a supported administrative role can create, update, and remove assignments. For the supported roles, see [Permissions for app role assignments (preview)](app-roles-assign.md#permissions).

<!-- TODO: Confirm permissions for viewing app role assignments without managing them. Don't assume that read-only visibility requires assignment-management permissions. -->

## Terminology

To better understand Privileged Identity Management and its documentation, you should review the following terms.

| Term or concept | Role assignment category | Description |
| --- | --- | --- |
| eligible | Type | A role assignment that requires a user to perform one or more actions to use the role. If a user is eligible for a role, they can activate the role when they need to perform privileged tasks. There's no difference in the access given to someone with a permanent versus an eligible role assignment. The only difference is that some people don't need that access all the time. |
| active | Type | A role assignment that doesn't require a user to perform any action to use the role. Users assigned as active have the privileges assigned to the role. |
| activate |  | The process of performing one or more actions to use a role that a user is eligible for. Actions might include performing a multifactor authentication (MFA) check, providing a business justification, or requesting approval from designated approvers. |
| assigned | State | A user that has an active role assignment. |
| activated | State | A user that has an eligible role assignment, performed the actions to activate the role, and is now active. Once activated, the user can use the role for a preconfigured period of time before they need to activate again. |
| permanent eligible | Duration | A role assignment where a user is always eligible to activate the role. |
| permanent active | Duration | A role assignment where a user can always use the role without performing any actions. |
| time-bound eligible | Duration | A role assignment where a user is eligible to activate the role only within start and end dates. |
| time-bound active | Duration | A role assignment where a user can use the role only within start and end dates. |
| just-in-time (JIT) access |  | A model in which users receive temporary permissions to perform privileged tasks, which prevents malicious or unauthorized users from gaining access after the permissions expire. Access is granted only when users need it. |
| principle of least privilege access |  | A recommended security practice in which every user is provided with only the minimum privileges needed to accomplish the tasks they're authorized to perform. This practice minimizes the number of Global Administrators and instead uses specific administrator roles for certain scenarios. |

## Role assignment overview

The PIM role assignments give you a secure way to grant access to resources in your organization. This section describes the assignment process. It includes assigning roles to members, activating assignments, approving or denying requests, and extending and renewing assignments.

PIM keeps you informed by sending you and other participants [email notifications](pim-email-notifications.md). These emails might also include links to relevant tasks, such as activating, approving, or denying a request.

The following screenshot shows an email message sent by PIM. The email informs Patti that Alex updated a role assignment for Emily.

:::image type="content" source="./media/pim-configure/pim-email.png" alt-text="Screenshot shows an email message sent by Privileged Identity Management.":::

### Assign

The assignment process starts by assigning roles to members. To grant access to a resource, the administrator assigns roles to users, groups, service principals, or managed identities. The supported assignment subjects depend on the PIM provider. The assignment includes the following data:

- The members or owners to assign the role.
- The scope of the assignment. The scope limits the assigned role to a particular set of resources.
- The type of the assignment.
  - **Eligible** assignments require the member of the role to perform an action to use the role. Actions might include activation, or requesting approval from designated approvers.
  - **Active** assignments don't require the member to perform any action to use the role. Members assigned as active have the privileges assigned to the role.
- The duration of the assignment, using start and end dates or permanent. For eligible assignments, the members can activate or request approval during the start and end dates. For active assignments, the members can use the assigned role during this period of time.

The following screenshot shows how administrator assigns a role to members.

:::image type="content" source="./media/pim-configure/role-assignment.png" alt-text="Screenshot of Privileged Identity Management role assignment.":::


For more information, check out the following articles: [Assign Microsoft Entra roles](pim-how-to-add-role-to-user.md), [Assign Azure resource roles](pim-resource-roles-assign-roles.md), [Assign eligibility for a PIM for Groups](groups-assign-member-owner.md), and [Assign app roles (preview)](app-roles-assign.md).

### Activate

If users are eligible for a role, then they must activate the role assignment before using the role. To activate the role, users select specific activation duration within the maximum (configured by administrators), and the reason for the activation request.

The following screenshot shows how members activate their role to a limited time.

:::image type="content" source="./media/pim-configure/role-activation.png" alt-text="Screenshot of Privileged Identity Management role activation.":::

If the role requires [approval](pim-resource-roles-approval-workflow.md) to activate, a notification appears in the upper right corner of the user's browser informing them the request is pending approval. If an approval isn't required, the member can start using the role.

For app roles (preview), don't assume that completing PIM activation immediately changes application access. See the [app role activation considerations](app-roles-activate.md#overview).

For more information, check out the following articles: [Activate Microsoft Entra roles](pim-how-to-activate-role.md), [Activate my Azure resource roles](pim-resource-roles-activate-your-roles.md), [Activate my PIM for Groups roles](groups-activate-roles.md), and [Activate app roles (preview)](app-roles-activate.md).

### Approve or deny

Delegated approvers receive email notifications when a role request is pending their approval. Approvers can view, approve, or deny these pending requests in PIM. After the request is approved, the member can start using the role. For example, if a user or a group was assigned with Contribution role to a resource group, they can manage that particular resource group.

For app roles (preview), approval alone doesn't confirm that the application has started granting access. See the [app role activation considerations](app-roles-activate.md#overview).

For more information, check out the following articles: [Approve or deny requests for Microsoft Entra roles](./pim-approval-workflow.md), [Approve or deny requests for Azure resource roles](pim-resource-roles-approval-workflow.md), [Approve activation requests for PIM for Groups](groups-approval-workflow.md), and [Approve or deny app role requests (preview)](app-roles-approval-workflow.md).

### Extend and renew assignments

After administrators set up time-bound owner or member assignments, the first question you might ask is what happens if an assignment expires? In this new version, we provide two options for this scenario:

- **Extend** – When a role assignment nears expiration, the user can use Privileged Identity Management to request an extension for the role assignment
- **Renew** – When a role assignment expires, the user can use Privileged Identity Management to request a renewal for the role assignment

For Microsoft Entra role assignments, both user-initiated actions require an approval from a Global Administrator or Privileged Role Administrator. Admins don't need to be in the business of managing assignment expirations. You can just wait for the extension or renewal requests to arrive for simple approval or denial.

For more information, check out the following articles: [Extend or renew Microsoft Entra role assignments](pim-how-to-renew-extend.md), [Extend or renew Azure resource role assignments](pim-resource-roles-renew-extend.md), [Extend or renew PIM for Groups assignments](groups-renew-extend.md), and [Extend or renew app role assignments (preview)](app-roles-renew-extend.md).

## Scenarios

Privileged Identity Management supports the following scenarios:

### Privileged Role Administrator permissions

- Enable approval for specific roles
- Specify approver users or groups to approve requests
- View request and approval history for all privileged roles

### Approver permissions

- View pending approvals (requests)
- Approve or reject requests for role elevation (single and bulk)
- Provide justification for my approval or rejection

### Eligible role user permissions

- Request activation of a role that requires approval
- View the status of your request to activate
- Complete your task in Microsoft Entra ID if activation was approved

## Microsoft Graph APIs

You can use Privileged Identity Management programmatically through the following Microsoft Graph APIs:
- [PIM for Microsoft Entra roles APIs](/graph/api/resources/privilegedidentitymanagementv3-overview)
- [PIM for groups APIs](/graph/api/resources/privilegedidentitymanagement-for-groups-api-overview)

## Next steps

- [License requirements to use Privileged Identity Management](~/id-governance/licensing-fundamentals.md)
- [Securing privileged access for hybrid and cloud deployments in Microsoft Entra ID](~/identity/role-based-access-control/security-planning.md?toc=/azure/active-directory/privileged-identity-management/toc.json)
- [Deploy Privileged Identity Management](pim-deployment-plan.md)
