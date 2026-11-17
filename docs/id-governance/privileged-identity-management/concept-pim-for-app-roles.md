---
title: Privileged Identity Management for app roles (preview)
description: Learn how Microsoft Entra Privileged Identity Management (PIM) for app roles provides eligible assignments and just-in-time activation.
ms.topic: concept-article
ms.date: 11/16/2026
ms.custom: pim, msecd-doc-authoring-1031
ai-usage: ai-generated
#Customer Intent: As an application administrator, I want to understand PIM for app roles so that I can provide just-in-time access to application-defined roles.
---
# Privileged Identity Management (PIM) for app roles (preview)

Microsoft Entra Privileged Identity Management (PIM) for app roles lets you manage eligible and active assignments to application-defined roles. PIM for app roles is in preview.

## Overview

App roles let an application owner define roles that an application uses to make authorization decisions. With PIM for app roles, administrators can create eligible app role assignments instead of active assignments. Assignees activate an eligible assignment when they need to use the role and deactivate it when they finish.

With PIM for app roles, you can use policies similar to those in PIM for Microsoft Entra roles and PIM for Azure resources. You can require approval for app role activation, enforce multifactor authentication (MFA), require justification, and limit maximum activation time.

PIM for app roles (preview) requires E7 licenses.

> [!NOTE]
> Agents and agent identities can receive eligible app role assignments in preview. Each agent or agent identity requires an E7 license. Existing assignment-management permissions remain unchanged.

## What is PIM for app roles?

PIM for app roles is part of Microsoft Entra Privileged Identity Management, alongside PIM for Microsoft Entra roles, PIM for Azure resources, and PIM for Groups. It applies PIM assignment and activation policies to the roles defined by an application.

With PIM for app roles, you can use policies similar to the ones you use in the other PIM providers: require approval for activation, require authentication, require justification, and limit maximum activation time. You can also configure assignment duration and notifications for each app role.

PIM manages access to existing app roles. The application continues to define what each role allows an assignee to do.

For information about defining roles, see [Add app roles to your application and receive them in the token](~/identity-platform/howto-add-app-roles-in-apps.md).

## Eligible and active app role assignments

The assignment type determines whether an assignee needs to activate an app role before using it:

- **Eligible**: A role assignment that requires an assignee to perform one or more actions to use the role. If an assignee is eligible for a role, they can activate the role when they need it.
- **Active**: A role assignment that doesn't require an assignee to activate the role through PIM before using it.

An eligible assignee activates the app role for a limited duration, subject to the role settings. Depending on those settings, activation can require authentication, a business justification, ticket information, or approval from a designated approver.

The assignment settings control whether eligible and active assignments can be permanent or must expire. Extending or renewing an assignment changes the period of the assignment; activating a role lets an eligible assignee use it.

During preview, users, groups, agents, and agent identities can receive eligible app role assignments.

Users, groups, and workload identities can receive active app role assignments through PIM.

When a group has an eligible app role assignment, each eligible group member activates the app role for themselves. Activation applies to the requesting user, not to the group as a whole or its other members.



## App roles and role claims

App roles are defined on an application registration representing a service, app, or API. Applications can use the `roles` claim in a token to make authorization decisions.

Depending on the scenario, app roles appear in different tokens issued for the application. For an application that signs in users, role claims are included in the ID token. When an application calls an API, role claims are included in the access token for that API.

PIM provides the assignment and activation lifecycle. The application uses role claims to authorize access to its functionality.

After activation completes, the application must obtain a new token to receive the activated app role. Whether you need to sign in again depends on the application.

Deactivation or expiration doesn't automatically invalidate already-issued tokens or existing application sessions. Application access can persist according to token lifetime and the application's session and authorization behavior.

## Manage the app role lifecycle

Use the app-role task guides to manage each part of the lifecycle:

- [Assign app roles in PIM (preview)](app-roles-assign.md).
- [Activate and deactivate app roles in PIM (preview)](app-roles-activate.md).
- [Approve or deny app role requests in PIM (preview)](app-roles-approval-workflow.md).
- [Extend or renew app role assignments in PIM (preview)](app-roles-renew-extend.md).
- [Configure app role settings in PIM (preview)](app-roles-settings.md).
- [View app role audit history in PIM (preview)](app-roles-audit.md).

## Next steps

- [Start using Privileged Identity Management](pim-getting-started.md).
- [Learn about PIM license requirements](~/id-governance/licensing-fundamentals.md).
