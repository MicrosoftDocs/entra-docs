---
title: Plan deploying Microsoft Entra for provisioning with SAP source and target systems
description: Learn the detailed steps for how to bring identities from SAP SuccessFactors and other sources into Microsoft Entra ID and provision those identities with access to SAP ECC, SAP S/4HANA, and other SAP and non-SAP applications.
author: markwahl-msft
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.topic: tutorial
ms.date: 04/10/2024
ms.author: mwahl
ms.reviewer: mwahl
---

# Plan deploying Microsoft Entra for provisioning with SAP source and target systems

SAP likely runs critical functions, such as HR and ERP, for your organization. At the same time, your organization relies on Microsoft for various Azure services or Microsoft 365. You can use Microsoft Entra to orchestrate the identities for your employees, contractors and others, and their access, across your SAP and non-SAP applications.

This article describes how you can use Microsoft Entra features to manage identities across your SAP applications, based on properties of those identities originating from SAP HR sources.

## Overview

The process is
 - Define the requirements for provisioning.
 - Ensure Microsoft Entra ID and related Microsoft Online Services meet the prerequisites for this scenario.
 - Bring the necessary users into Microsoft Entra ID and have a process to keep those users up-to-date with appropriate credentials.
 - Assign users with the necessary access rights in Microsoft Entra.
 - Provision users and their access rights to applications and enable them to sign in to those applications.
 - Monitor.

## Define the requirements for provisioning

## Ensure prerequisites are met before configuring Microsoft Entra ID

Before you begin the process of provisioning business-critical application access from Microsoft Entra ID, you should check your Microsoft Entra environment is appropriately configured.

* **Ensure your Microsoft Entra ID and Microsoft Online Services environment is ready for the [compliance requirements](~/standards/standards-overview.md) for the applications**. Compliance is a shared responsibility among Microsoft, cloud service providers (CSPs), and organizations.

* **Ensure your Microsoft Entra ID tenant is properly licensed**. To use Microsoft Entra ID to automate provisioning, your tenant must have a valid [Microsoft Entra ID P1 or P2 license](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing) with as many seats as there are workers that will be sourced from the source HR application or member (non-guest) users that will be provisioned. In addition, use of [Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md) and other Microsoft Entra ID Governance features in the provisioning process requires a [Microsoft Entra ID Governance license](~/id-governance/licensing-fundamentals.md) in your tenant:

  * **Microsoft Entra ID Governance** and its prerequisite, Microsoft Entra ID P1
  * **Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2** and its prerequisite, either Microsoft Entra ID P2 or Enterprise Mobility + Security (EMS) E5

* **Check that Microsoft Entra ID is already sending its audit log, and optionally other logs, to Azure Monitor.** Azure Monitor is optional, but useful for governing access to apps, as Microsoft Entra only stores audit events for up to 30 days in its audit log. You can keep the audit data for longer than this default retention period, outlined in [How long does Microsoft Entra ID store reporting data?](~/identity/monitoring-health/reference-reports-data-retention.md), and use Azure Monitor workbooks and custom queries and reports on historical audit data. You can check the Microsoft Entra configuration to see if it's using Azure Monitor, in **Microsoft Entra ID** in the Microsoft Entra admin center, by clicking on **Workbooks**. If this integration isn't configured, and you have an Azure subscription and are in the `Global Administrator` or `Security Administrator` roles, you can [configure Microsoft Entra ID to use Azure Monitor](~/id-governance/entitlement-management-logs-and-reporting.md).

* **Make sure only authorized users are in the highly privileged administrative roles in your Microsoft Entra tenant.** Administrators in the *Global Administrator*, *Identity Governance Administrator*, *User Administrator*, *Application Administrator*, *Cloud Application Administrator* and *Privileged Role Administrator* can make changes to users and their application role assignments. If the memberships of those roles haven't yet been recently reviewed, you need a user who is in the *Global Administrator* or *Privileged Role Administrator* to ensure that [access review of these directory roles](~/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md) are started. You should also ensure that users in Azure roles in subscriptions that hold the Azure Monitor, Logic Apps and other resources needed for the operation of your Microsoft Entra configuration have been reviewed.

* **Check your tenant has appropriate isolation.** If your organization is using Active Directory on-premises, and these AD domains are connected to Microsoft Entra ID, then you need to ensure that highly privileged administrative operations for cloud-hosted services are isolated from on-premises accounts. Check that you've [configured your systems to protect your Microsoft 365 cloud environment from on-premises compromise](~/architecture/protect-m365-from-on-premises-attacks.md).


## Bring the necessary users into Microsoft Entra ID and have a process to keep those users up-to-date with appropriate credentials

## Assign users with the necessary access rights in Microsoft Entra.

## Provision users and their access rights to applications and enable them to sign in to those applications.

## Monitor
 

## Next steps

- [Govern access by migrating an organizational role model to Microsoft Entra ID Governance](~/id-governance/identity-governance-organizational-roles.md)
- [Define organizational policies for governing access to other applications in your environment](~/id-governance/identity-governance-applications-define.md)
