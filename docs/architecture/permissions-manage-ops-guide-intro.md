---
title: Microsoft Entra Permissions Management operationalization guide introduction
description: Learn the checks, actions, and best practices to operate Microsoft Entra Permissions Management in an enterprise environment
services: active-directory
author: jricketts
manager: martinco
tags: azuread
ms.service: active-directory
ms.topic: conceptual
ms.workload: identity
ms.date: 10/23/2023
ms.author: jricketts
---

# Microsoft Entra Permissions Management operationalization guide

## Introduction

In this operationalization guide, learn about the checks, actions, and best practices to operate Microsoft Entra Permissions Management in an enterprise environment. The guidance has three phases: 

1. **Implement the framework to manage at scale**: delegate permissions and develop processes to guide operational behavior.
2. **Right-size permissions and automate the principle of least privilege**: remediate key findings and implement just-in-time (JIT) access with Permissions On-Demand.
3. **Configure Microsoft Entra Permissions Management monitoring and alerting**: schedule recurring reports, configure alerts, and develop response strategy playbooks. 

>[!NOTE]
> The recommendations in this guide are current as of the date of publication. We recommend organizations evaluate their identity practices continuously as Microsoft products and services evolve over time. Some recommendations might not be applicable to all customer environments.

## Entry criteria

This guide assumes you completed the [Quickstart guide to Microsoft Entra Permissions Management](~/permissions-management/permissions-management-quickstart-guide.md).

## Glossary

Use the following glossary to understand terms used in this guide.

|Term|Definition|
|---|---|
|Authorization system|A system that grants access to identities. For example, an Azure subscription, an AWS account, or a GCP project.|
|Permission|An identity with the ability to perform an action on a resource.|
|Permission Creep Index (PCI)|An aggregated metric to measure the number of unused or excessive permissions across identities and resources. It's measured periodically for all identities. PCI ranges from 0 to 100. Higher scores represent greater risk.|
|Permissions On-Demand|A Microsoft Entra Permissions Management feature that enables identities to request and grant permissions on-demand for a time limited period, or as needed.|

## Customer stakeholder teams

We recommend you assign stakeholders to plan and implement key tasks. The following table outlines the stakeholder teams cited in this guide.

|Stakeholder team|Description|
|---|---|
|Identity and Access Management (IAM)|Manages day-to-day operations of the IAM system|
|Cloud Infrastructure|Architects and operations teams for Azure, AWS, and GCP|
|Information Security Architecture|Plans and designs the organization’s information security practices|
|Information Security Operations|Runs and monitors information security practices for Information Security Architecture|
|Incident Response|Identifies and resolves security incidents|
|Security Assurance and Audit|Helps ensure IT processes are secure and compliant. They conduct regular audits, assess risks, and recommend security measures to mitigate identified vulnerabilities and enhance the overall security posture.|
|Target authorization system technical owners|Own individual authorization systems: Azure subscriptions, AWS accounts, GCP projects onboarded to Microsoft Entra Permissions Management|

## Discover-remediate-monitor flow

When operationalizing the product, we recommend use of the Discover-Remediate-Monitor flow. In the following example, note the use of the proactive flow for overprovisioned active users: high-risk over-permissioned users in your environment.

1. **Discover**: Achieve visibility into your environment and prioritize findings. For example, use the Permissions Analytics Report for a list of overprovisioned active users. 
2. **Remediate**: Act on the findings from discovery. For example, use Permissions Management remediation tools to revoke unused tasks from overprovisioned active users with one click, and then create right-sized roles based on past activity.
3. **Monitor**: Create alerts to continuously monitor your environment for findings to remediate. For example, create a permissions analytics alert to notify you of overprovisioned active users.

## Next steps

* [Phase 1: Implement the framework to manage at scale](permissions-manage-ops-guide-one.md)
* [Phase 2: Right-size permissions and automate the principle of least privilege](permissions-manage-ops-guide-two.md)
* [Phase 3: Configure Microsoft Entra Permissions Management monitoring and alerting](permissions-manage-ops-guide-three.md)
* [Microsoft Entra Permissions Management alerts guide](permissions-manage-ops-guide-alerts.md)
