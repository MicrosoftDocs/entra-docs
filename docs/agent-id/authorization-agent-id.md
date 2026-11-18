---
title: Authorization in Microsoft Entra Agent ID
description: Learn about how authorization in Microsoft Entra Agent ID works for AI agents.
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.topic: concept-article
#customer intent: As a developer or IT administrator, I want to understand authorization controls for agent IDs so that I can properly configure roles and permissions while maintaining security boundaries for AI agents in my organization.
---

# Authorization in Microsoft Entra Agent ID

Authorize an agent according to the resource it needs to access: Azure roles govern Azure resources, Microsoft Entra roles govern directory administration, and API permissions govern calls to Microsoft Graph and other APIs. Microsoft Entra Agent ID restricts high-privilege assignments to limit what an autonomous agent can do.

This article explains those downstream permission controls. Permissions to call a downstream API don't determine who can invoke the agent itself; for that separate boundary, see [Control access to agents with app roles](control-user-access-agents.md).

## Why agent identity authorization is important

AI agents can execute tasks quickly and at scale. Many high-privilege capabilities in Microsoft Entra ID (for example, the ability to manage users or roles) assume a human administrator with careful intent. An unrestrained agent with high privileges could perform unexpected administrative tasks with far reaching impact (such as deleting users or changing security settings).

For this reason, Microsoft Entra ID limits what agent identities can do. For example, Microsoft Entra blocks agents from being granted many high privilege roles or permissions. Users and administrators aren't allowed to consent to those powerful permissions for an agent. This design recognizes that agents should operate with least privilege. By preventing agents from receiving sensitive privileges, the system minimizes the risk that an AI agent could escalate access. The list of allowed roles and permissions will evolve over time.

## Microsoft Entra role assignments for agent identities

From an authorization standpoint, an agent identity behaves somewhat like an application or a user with extra safeguards. Each agent identity has a service principal or a user in Microsoft Entra ID, and it can be assigned certain Microsoft Entra roles.

For example, an agent's identity can be assigned a Microsoft Entra role to give it administrator privileges, but many highly privileged directory roles are blocked for agents. Roles such as Global Administrator, Privileged Role Administrator, or User Administrator can't be assigned to agent identities. Only lower privileged roles (such as a reader role) can be assigned to an agent. Agent identities can't be members of role-assignable groups.

Microsoft has created the Agent ID Administrator and Agent ID Developer roles for managing and creating agents themselves.

## Microsoft Entra roles allowed for agents

The following is the list of [Microsoft Entra roles](../identity/role-based-access-control/permissions-reference.md) that can be assigned to agent identities:

- AI Administrator
- Attack Payload Author
- Attack Simulation Administrator
- Attribute Assignment Reader
- Attribute Definition Reader
- Attribute Log Administrator
- Attribute Log Reader
- Azure DevOps Administrator
- Azure Information Protection Administrator
- B2C IEF Policy Administrator
- Billing Administrator
- Cloud App Security Administrator
- Compliance Administrator
- Compliance Data Administrator
- Customer LockBox Access Approver
- Desktop Analytics Administrator
- Directory Readers
- Directory Synchronization Accounts
- Dynamics 365 Administrator
- Dynamics 365 Business Central Administrator
- Edge Administrator
- Exchange Administrator
- Exchange Recipient Administrator
- Extended Directory User Administrator
- External ID User Flow Administrator
- External ID User Flow Attribute Administrator
- Fabric Administrator
- Global Reader
- Global Secure Access Log Reader
- Insights Administrator
- Insights Analyst
- Insights Business Leader
- IoT Device Administrator
- Kaizala Administrator
- Knowledge Administrator
- Knowledge Manager
- License Administrator
- Message Center Privacy Reader
- Message Center Reader
- Microsoft 365 Backup Administrator
- Microsoft 365 Migration Administrator
- Microsoft Entra Joined Device Local Administrator
- Microsoft Graph Data Connect Administrator
- Microsoft Hardware Warranty Administrator
- Microsoft Hardware Warranty Specialist
- Network Administrator
- Office Apps Administrator
- Organizational Branding Administrator
- Organizational Data Source Administrator
- Organizational Messages Approver
- Organizational Messages Writer
- People Administrator
- Places Administrator
- Power Platform Administrator
- Printer Administrator
- Printer Technician
- Purview Workload Content Administrator
- Purview Workload Content Reader
- Purview Workload Content Writer
- Reports Reader
- Search Administrator
- Search Editor
- Security Reader
- Service Support Administrator
- SharePoint Administrator
- SharePoint Embedded Administrator
- Skype for Business Administrator
- Teams Administrator
- Teams Communications Administrator
- Teams Communications Support Engineer
- Teams Communications Support Specialist
- Teams Devices Administrator
- Teams Reader
- Teams Telephony Administrator
- Tenant Creator
- Usage Summary Reports Reader
- User Experience Success Manager
- Virtual Visits Administrator
- Viva Glint Tenant Administrator
- Viva Goals Administrator
- Viva Pulse Administrator
- Windows 365 Administrator
- Windows Update Deployment Administrator
- Yammer Administrator

Custom roles can be assigned to agents.

## Microsoft Graph permissions for agent IDs

For OAuth2 permissions, agent IDs (specifically, agent identity blueprints and agent identity blueprint principals) can use the same Microsoft Graph permission model as other apps. Agents can request delegated permissions (acting on behalf of a user via consent) or application permissions (app-only privileges granted by an administrator).

However, a set of high-risk Microsoft Graph API permissions are explicitly blocked for agents. For example, an agent can't be granted the following permissions:

| Blocked permission | Notes |
| --- | --- |
| `Application.ReadWrite.All` | Allows managing all applications. |
| `RoleManagement.ReadWrite.All` | Includes full control over users, groups, roles, directory settings, and other critical operations. |
| `User.ReadWrite.All` | Grants full control of all user accounts. |
| `Directory.AccessAsUser.All` | Grants access to information in the directory as the signed-in user. Ensures that an agent can't circumvent security by asking for sweeping Microsoft Graph access – even an administrator can't consent to give an agent those permissions. |

Agent IDs can still be granted lower-privilege permissions as appropriate. For example, if an agent needs to read a user's mailbox or OneDrive file on that user's behalf, it can request a delegated permission like `Mail.Read` or `Files.Read` and the user (or administrator) can consent. Those aren't considered high-privilege in the tenant-wide sense; they're bounded to that user's data.

What's blocked are the tenant-scoped privileges that go beyond a single user or involve administrative control. Agents operate under a principle of limited scope. Agents can only do what a regular user could consent to, or what an administrator explicitly grants in a controlled, scoped manner.

## When to Use Azure roles, Microsoft Entra roles, or Microsoft Graph permissions

Depending on what an agent needs to do, administrators can grant access in different ways to keep the scope appropriate. This includes assigning Azure roles, Microsoft Entra roles, OAuth permission grants including Graph permissions, application role assignments, [access package assignments](agent-access-packages.md), and group memberships.

### Azure roles

**If an agent needs to access Azure resources**: Assign Azure roles for those specific resources. For example, **Key Vault Reader** allows reading vault metadata, not secret values. Reading secret values requires a data-plane role such as **Key Vault Secrets User** on a vault configured for Azure RBAC. Assign the role at the narrowest required scope. For more information, see [Azure built-in roles for Key Vault](/azure/role-based-access-control/built-in-roles/security#key-vault-secrets-user) and [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

### Microsoft Entra roles

**If an agent needs to perform directory-level actions**: Use Microsoft Entra roles only if a suitable lower privileged role exists. For example, if an agent just needs to read basic directory info, you might use a Directory Reader-type role. If you need to grant an agent write access, review the implications and select the least privileged role. There might not be an appropriate built-in role that isn't blocked. In those cases, you might choose to rely on Microsoft Graph permissions instead (with the understanding of their limits). For more information, see [Assign Microsoft Entra roles](../identity/role-based-access-control/manage-roles-portal.md).

### Delegated Microsoft Graph permissions

**If an agent acts on behalf of a user (user-centric scenarios)**: Use delegated Microsoft Graph permissions. These require user or administrator consent, and the agent can't exceed the user's access. For example, an agent scheduling meetings for Alice uses delegated calendar API permissions. A hosted agent's OBO flow can't display an interactive consent prompt; configure consent before the downstream call. For supported consent paths, see [Grant delegated permissions to an agent identity](grant-agent-access-microsoft-365.md).

### Microsoft Graph application permissions

**If an agent runs autonomously across the tenant (service scenarios)**: Use Microsoft Graph application permissions sparingly. Grant only the specific app permissions needed, and only if they aren't high-privilege. For example, an agent that generates organizational org-charts might need User.Read.All app permission to read all profiles – that could be acceptable (and isn't on the blocked list), whereas User.ReadWrite.All would be rejected.

Always review the permission's scope: tenant-wide read access might be fine for certain data, but tenant-wide write or control isn't allowed for agents. Administrators must explicitly consent to any app permission an agent gets, so there's an opportunity to review these requests carefully. For more information, see [Overview of permissions and consent in the Microsoft identity platform](../identity-platform/permissions-consent-overview.md).

## Inheritable permissions for agent identities

Multi-instance agent identity blueprints support inheritable permissions, which let administrators configure eligible blueprint grants for use by child agent identities. This capability reduces repeated consent setup across a fleet. A single-instance blueprint has no blueprint principal; grant permissions directly to its agent identity instead.

For more information about how inheritable permissions, required resource access, and direct grants work together, see [Inheritable permissions](concept-inheritable-permissions.md).