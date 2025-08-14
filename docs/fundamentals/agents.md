---
title: Microsoft Security Copilot agents in Microsoft Entra
description: Learn about the available Microsoft Security Copilot agents in Microsoft Entra.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 08/12/2025
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: article
---
# Microsoft Security Copilot agents in Microsoft Entra

Microsoft Entra agents work seamlessly with [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot). Microsoft Security Copilot agents automate repetitive tasks and reduce manual workloads. They enhance security and IT operations across cloud, data security and privacy, identity, and network security. These agents handle high-volume, time-consuming tasks by pairing data and code with an AI language model. They respond to user requests and system events, helping teams work more efficiently and focus on higher-impact tasks.

Agents fit naturally into existing workflows. You don't need special training or other licensing to use them. Agents utilize SCUs to operate just like other features in the product. They integrate seamlessly with Microsoft Security solutions and the broader supported partner ecosystem. Agents learn based on feedback and keep you in control on the actions it takes. They handle resource-intensive tasks like threat intelligence briefings, and Conditional Access optimization. With Microsoft Security Copilot agents, you can scale up your teams, people, and processes.

Microsoft Security Copilot agents offer significant benefits for security teams and IT operations by automating routine tasks and freeing up valuable time for teams to concentrate on strategic initiatives and complex problem-solving. This leads to improved operational efficiency, enhanced security and giving teams the ability to respond more swiftly to emerging threats. With Security Copilot agents, organizations can achieve greater scalability and resilience in their security and IT processes.

## Available agents

### Microsoft Entra Conditional Access optimization agent

The [Conditional Access optimization agent](../identity/conditional-access/agent-optimization.md) ensures all users are protected by policy. It recommends policies and changes based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. The agent evaluates policies requiring multifactor authentication (MFA), enforces device based controls (device compliance, app protection policies, and Domain Joined Devices), and blocks legacy authentication and device code flow.

| Attribute           | Description                                                                                                                                      |
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Trigger             | Runs every 24 hours or manually.                                                                                                                 |
| Permissions         | Reviews policy configuration. Creates new policies in report-only mode. Suggests policy changes that must be approved.                           |
| Identity            | Runs as the administrator who configured the agent.                                                                                              |
| Products            | [Microsoft Entra Conditional Access](/entra/identity/conditional-access/), [Security Copilot](/copilot/security/microsoft-security-copilot)      |
| Plugins             | [Microsoft Entra](/entra/fundamentals/copilot-security-entra)                                                                                    |
| Role-based access   | Requires [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) to turn on the agent. More roles can be added in Security Copilot role assignments |
