---
title: Microsoft Entra agent permissions
description: Learn about the read and write permissions for each Microsoft Entra agent.
keywords:
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.date: 01/08/2026
ms.update-cycle: 180-days
ms.topic: overview
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
#Customer intent: As an IT administrator or security professional, I want to know what the agent has permission to read and write in my tenant so I know what it can and can't do.
---

# Microsoft Entra agent permissions

Security Copilot agents in Microsoft Entra are granted specific read and write permissions for each agent. These permissions are part of the agent and can't be edited or changed. But it's important to know what the agent can and can't see and do in your tenant so you can benefit from the agent's capabilities without worrying about permissions.

This article provides a list of all the permissions each agent uses. In many cases, the agents have the same permissions.

## Access Review Agent

The [Access Review Agent](access-review-agent.md) can get details for access reviews, read details and lifecycle workflow history for users, groups, apps, and access packages, and save access review recommendations and justifications.

## Conditional Access Optimization Agent

The [Conditional Access Optimization Agent](conditional-access-agent-optimization.md) can review policy configurations, create new policies in report-only mode, and suggest policy changes requiring approval.

`AuditLog.Read.All`
`CustomSecAttributeAssignment.Read.All`
`DeviceManagementApps.Read.All`
`DeviceManagementConfiguration.Read.All`
`GroupMember.Read.All`
`LicenseAssignment.Read.All`
`NetworkAccess.Read.All`
`Policy.Create.ConditionalAccessRO`
`Policy.Read.All`
`RoleManagement.Read.Directory`
`User.Read.All`

## Identity Risky Management Agent (Preview)

The [Identity Risk Management Agent](../id-protection/identity-risk-management-agent-get-started.md) can read Microsoft Entra ID Protection risk detections and risk history, read sign-in and audit logs, and read user information.

`Application.Read.All`
`Policy.Read.All`
`Group.ReadWrite.All` 
`GroupMember.Read.All` 
`User.Read.All` 
`Policy.ReadWrite.ConditionalAccess` 
`CustomSecAttributeAssignment.Read.All`
`IdentityRiskyUser.Read.All`
`AuditLog.Read.All`