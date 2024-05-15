---
title: 'Multi-organizational on-premises Exchange mailbox migration with Microsoft Entra Connect'
description: Scenario that describes how to do a multi-organizational mailbox migration with hybrid identity.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: overview
ms.date: 05/15/2024
ms.author: billmath
---

# Scenario: Multi-organizational on-premises Exchange mailbox migration with Microsoft Entra Connect using a parallel hybrid environment.

Parallel multi-organizational mailbox migration can be performed from on-premises Exchange 
Server to M365 cloud / Exchange Online using Microsoft Entra Connect. This method offers the following benefits:
 - no downtime
 - password synchronization for end-users
 - removes the need to reconfigure Outlook desktop apps on end-users’ devices post-migration

## Overview
Some companies have unique Active Directory architectures, in which they support several smaller organizations with the same forest.  An example is an on-premises Exchange Server hosting company.
 
This poses some challenges in migrating mailboxes from on-premises to cloud using Microsoft’s migration tools. These companies often need to look for third party solutions to run migrations.

This scenario provides a solution using existing Microsoft toolset to set up Hybrid configurations and subsequent mailbox migrations. 

 :::image type="content" source="media/parallel-hybrid-migration/parallel-hybrid-1.png" alt-text="Diagram of the parallel hybrid migration scenario." lightbox="media/parallel-hybrid-migration/parallel-hybrid-1.png":::

## Pre-requisites
- For each tenant you are migrating to, there needs to be one Micorosft Entra Connect server.
- You should create virtual machines for each of the Microsoft Entra Connect servers and they need to be domain joined.
- Users in your on-premises Active Directory, should be seperated in their own organizational unit (OU).
- Each Microsoft Entra Connect Server will have its synchronization rules scoped to individual OUs.
- All of the migrating tenants primary domains must be added and verified in M365
- You should be familiar with [Exchnage hybrid deployments](/exchange/exchange-hybrid)
- Make sure that you meet the [pre-requisites for the Hybrid Configuration Wizard](/exchange/hybrid-deployment-prerequisites).





## Microsoft Entra Connect

1.  On each of the virtual machines that were created, download and install Microsoft Entra Connect
2.  

## Hybrid Configuration Wizard
Once you have configured the Microsoft Entra Connect servers, use the following steps to download and configure the Exchange Hybrid Configuration Wizard.

1.  On each of the virtual machines, [download](https://aka.ms/hybridwizard) and install the [Hybrid Configuration Wizard](/exchange/hybrid-deployment/deploy-hybrid).
2.  On the installation select [Minimal Hybrid](/exchange/mailbox-migration/use-minimal-hybrid-to-quickly-migrate).

 :::image type="content" source="media/parallel-hybrid-migration/minimal-hybrid-1.png" alt-text="Screenshot of minimal hybrid." lightbox="media/parallel-hybrid-migration/minimal-hybrid-1.png":::

 Fpr additional infomation on Exchange Hybrid see [Exchange hybrid deployments](/exchange/exchange-hybrid)

## Exchange Admininstrative Center
