---
title: Microsoft Entra operations reference guide
description: This operations reference guide describes the checks and actions you should take to secure and maintain identity and access management, authentication, governance, and operations
author: martincoetzer
manager: travisgr
ms.service: entra
ms.topic: conceptual
ms.subservice: architecture
ms.date: 08/17/2022
ms.author: martinco
---

# Microsoft Entra operations reference guide

This operations reference guide describes the checks and actions you should take to secure and maintain the following areas:

- **[Identity and access management](ops-guide-iam.md)** - ability to manage the lifecycle of identities and their entitlements.
- **[Authentication management](ops-guide-auth.md)** - ability to manage credentials, define authentication experience, delegate assignment, measure usage, and define access policies based on enterprise security posture.
- **[Governance](ops-guide-govern.md)** - ability to assess and attest the access granted nonprivileged and privileged identities, audit, and control changes to the environment.
- **[Operations](ops-guide-ops.md)** - optimize the operations Microsoft Entra ID.

Some recommendations here might not be applicable to all customers' environment, for example, AD FS best practices might not apply if your organization uses password hash sync.

> [!NOTE]
> These recommendations are current as of the date of publishing but can change over time. Organizations should continuously evaluate their identity practices as Microsoft products and services evolve over time. Recommendations can change when organizations subscribe to a different Microsoft Entra ID P1 or P2 license.

## Stakeholders

Each section in this reference guide recommends assigning stakeholders to plan and implement key tasks successfully. The following table outlines the list of all the stakeholders in this guide:

| Stakeholder | Description |
| :- | :- |
| IAM Operations Team | This team handles managing the day to day operations of the Identity and Access Management system |
| Productivity Team | This team owns and manages the productivity applications such as email, file sharing and collaboration, instant messaging, and conferencing. |
| Application Owner | This team owns the specific application from a business and usually a technical perspective in an organization. |
| InfoSec Architecture Team | This team plans and designs the Information Security practices of an organization. |
| InfoSec Operations Team | This team runs and monitors the implemented Information Security practices of the InfoSec Architecture team. |

## Next steps

Get started with the [Identity and access management checks and actions](ops-guide-iam.md).
