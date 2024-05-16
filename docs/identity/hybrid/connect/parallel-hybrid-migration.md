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
 - removes the need to reconfigure Outlook desktop apps on end-users devices post-migration

## Overview
Some companies have unique Active Directory architectures, in which they support several smaller organizations with the same forest. An example is an on-premises Exchange Server hosting company.
 
This poses some challenges in migrating mailboxes from on-premises to cloud using Microsoft's migration tools. These companies often need to look for third party solutions to run migrations.

This scenario provides a solution using existing Microsoft toolset to set up Hybrid configurations and subsequent mailbox migrations. 

 :::image type="content" source="media/parallel-hybrid-migration/parallel-hybrid-1.png" alt-text="Diagram of the parallel hybrid migration scenario." lightbox="media/parallel-hybrid-migration/parallel-hybrid-1.png":::

## Pre-requisites
- For each tenant you are migrating to, there needs to be one Micorosft Entra Connect server.
- You should create virtual machines for each of the Microsoft Entra Connect servers and they need to be domain joined.
- Users in your on-premises Active Directory, should be seperated in their own organizational unit (OU).
- Each Microsoft Entra Connect Server will have its synchronization rules scoped to individual OUs.
- All of the migrating tenants primary domains must be added and verified in M365
- You should be familiar with [Exchnage hybrid deployments](/exchange/exchange-hybrid)
- Make sure that you meet the [Microsoft Entra Connect pre-requisites](how-to-connect-install-prerequisites.md).
- Make sure that you meet the [pre-requisites for the Hybrid Configuration Wizard](/exchange/hybrid-deployment-prerequisites).

## Parallel Hybrid Migration 
The following outlines the steps for the multi-organizational on-premises Exchange mailbox migration with Microsoft Entra Connect using a parallel hybrid environment.  Each step must be completed for each tenant that you are migrating to.

### Step 1 - Microsoft Entra Connect

1. On each of the [virtual machines](/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v?tabs=hyper-v-manager) that were created, [download](https://www.microsoft.com/en-us/download/details.aspx?id=47594) Microsoft Entra Connect.
2. Install Microsoft Entra Connect using [custom settings](how-to-connect-install-custom.md). 
3. Scope to the source [on-prem Organizational Unit](how-to-connect-sync-configure-filtering.md#organizational-unitbased-filtering) to the OU that corresponds to the tenant you are synchronizing Micrsofot Entra Connect with.
4. Enable **Exchange Hybrid deployment** and **Password hash synchronization**
5. Follow the [post installation tasks](how-to-connect-post-installation.md) for Microsoft Entra Connect.
6. Verify all of the users have been synchronized to the target tenant.  

### Step 2 - Hybrid Configuration Wizard
Once you have configured the Microsoft Entra Connect servers and you have verified synchronization has occured, use the following steps to download and configure the Exchange Hybrid Configuration Wizard.

1. On each of the virtual machines, [download](https://aka.ms/hybridwizard) and install the [Hybrid Configuration Wizard](/exchange/hybrid-deployment/deploy-hybrid).
2. On the installation select [Minimal Hybrid](/exchange/mailbox-migration/use-minimal-hybrid-to-quickly-migrate).

 :::image type="content" source="media/parallel-hybrid-migration/minimal-hybrid-1.png" alt-text="Screenshot of minimal hybrid." lightbox="media/parallel-hybrid-migration/minimal-hybrid-1.png":::

 For additional infomation on Exchange Hybrid see [Exchange hybrid deployments](/exchange/exchange-hybrid)

### Step 3 - Exchange Admininstrative Center

1. In [Exchange Admin Center](/exchange/exchange-admin-center), go to Migration and select the users to be migrated.   You can access the EAC using the URL https://admin.exchange.microsoft.com
  > [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RWBuGs]  

2. [Migrate users](/exchange/troubleshoot/move-or-migrate-mailboxes/migrate-data-with-admin-center).
3. Complete migration batches after mailboxes are fully transferred.
 
 >[!NOTE]
 > An endpoint should be created at the last step of the Hybrid Configuration Wizard and should be 
 available to create migration batch in the Exchange Admin Center. If not, create an endpoint manually.

>[!NOTE]
> Once user provisioning is completed by Microsoft Entra Connect, all users in the organization should be available as MailUser in the Exchange Admin Center and can be selected when creating migration batches.

### Setp 4 - Uninstall Hybrid Configuration Wizard and Microsoft Entra Connect
Once you have complete the migration, you can uninstll tthe HCW and Microsoft Entra Connect on the virtual server. At this point you can remove the server from the domain and turn it off.

### Step 5 - Repeat for each tenant
Once you have completed the steps for migration, repeat the steps for all of your remaining tenants.


## Next Steps

- [What is hybrid identity?](../whatis-hybrid-identity.md)
- [What is password hash synchronization?](whatis-phs.md)
- [What is the Exchange Hybrid Configuration Wizard?](/exchange/hybrid-deployment/deploy-hybrid)
- [What is the Exchange Admin Center?](/exchange/exchange-admin-center)
