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
Some companies have unique Active Directory architectures, in which they support several smaller organizations with the same forest.  An example of this might be an on-premises Exchange Server hosting companies.
 
This poses some challenges in migrating mailboxes from on-premises to cloud using Microsoft’s migration tools. These companies often need to look for 3rd party solutions to run migrations.

This scenario provides a solution using existing Microsoft toolset to set up Hybrid configurations and subsequent mailbox migrations. This method has been verified to successfully work in a 

 :::image type="content" source="media/parallel-hybrid-migration/parallel-hybrid-1.png" alt-text="Diagram of the parallel hyrid migration scenario." lightbox="media/parallel-hybrid-migration/parallel-hybrid-1.png":::
