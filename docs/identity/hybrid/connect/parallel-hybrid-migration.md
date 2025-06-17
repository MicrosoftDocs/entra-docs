---
title: 'Multi-organizational on-premises Exchange mailbox migration for Hosters using Microsoft Entra Connect'
description: Scenario that describes how Hosters can do a multi-organizational mailbox migration with hybrid identity.
author: billmath
manager: femila
ms.service: entra-id-governance
ms.topic: overview
ms.date: 04/09/2025
ms.author: billmath
---

# Scenario: Multi-organizational on-premises Exchange mailbox migration for Hosters using Microsoft Entra Connect and parallel hybrid

Parallel multi-organizational mailbox migration can be performed from on-premises Exchange 
Server to Microsoft 365 cloud / Exchange Online using Microsoft Entra Connect. This method offers the following benefits:

 - No downtime.
 - Password synchronization for end-users.
 - Removes the need to reconfigure Outlook desktop apps on end-users devices post-migration.

## Overview
Some companies have unique Active Directory architectures, in which they support several smaller organizations with the same forest. An example is an on-premises Exchange Server hosting company.
 
These companies face challenges in migrating mailboxes from on-premises to cloud using Microsoft's migration tools. These companies often need to look for third party solutions to run migrations.

This scenario provides a solution using existing Microsoft toolset to set up Hybrid configurations and subsequent mailbox migrations. 

 :::image type="content" source="media/parallel-hybrid-migration/parallel-hybrid-1.png" alt-text="Diagram of the parallel hybrid migration scenario." lightbox="media/parallel-hybrid-migration/parallel-hybrid-1.png":::

## Prerequisites
- For each tenant you're migrating to, there needs to be one Microsoft Entra Connect server.
- You should create virtual machines for each of the Microsoft Entra Connect servers and they need to be domain joined.
- Users in your on-premises Active Directory should be in their own organizational unit (OU).
- Each Microsoft Entra Connect Server has its synchronization rules scoped to individual OUs.
- All of the migrating tenants primary domains must be added and verified in Microsoft 365.
- You should be familiar with [Exchange hybrid deployments](/exchange/exchange-hybrid).
- Ensure that you meet the [Microsoft Entra Connect prerequisites](how-to-connect-install-prerequisites.md).
- Ensure that you meet the [prerequisites for the Hybrid Configuration Wizard](/exchange/hybrid-deployment-prerequisites).

## Parallel Hybrid Migration 
The following outlines the steps for the multi-organizational on-premises Exchange mailbox migration with Microsoft Entra Connect using a parallel hybrid environment.  Each step must be completed for each tenant that you're migrating to.

### Step 1 - Microsoft Entra Connect

1. On each of the [virtual machines](/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v?tabs=hyper-v-manager) that were created, [download](https://www.microsoft.com/download/details.aspx?id=47594) Microsoft Entra Connect.
2. Install Microsoft Entra Connect using [custom settings](how-to-connect-install-custom.md). 
3. Configure scoping to the source [on-premises Organizational Unit](how-to-connect-sync-configure-filtering.md#organizational-unitbased-filtering) that corresponds to the tenant you're synchronizing Microsoft Entra Connect with.

   :::image type="content" source="media/parallel-hybrid-migration/scope-1.png" alt-text="Screenshot of scoping OU." lightbox="media/parallel-hybrid-migration/scope-1.png":::

4. Enable **Exchange Hybrid deployment** and **Password hash synchronization**

   :::image type="content" source="media/parallel-hybrid-migration/features-1.png" alt-text="Screenshot of optional features." lightbox="media/parallel-hybrid-migration/features-1.png":::

5. Follow the [post installation tasks](how-to-connect-post-installation.md) for Microsoft Entra Connect.
6. Verify all of the users are synchronized to the target tenant.  

### Step 2 - Hybrid Configuration Wizard
Once you've configured the Microsoft Entra Connect servers and synchronization has completed, use the following steps to download and configure the Exchange Hybrid Configuration Wizard.

1. On each of the virtual machines, [download](https://aka.ms/hybridwizard) and install the [Hybrid Configuration Wizard](/exchange/hybrid-deployment/deploy-hybrid).
2. On the installation, select [Minimal Hybrid](/exchange/mailbox-migration/use-minimal-hybrid-to-quickly-migrate).

   :::image type="content" source="media/parallel-hybrid-migration/minimal-hybrid-1.png" alt-text="Screenshot of minimal hybrid." lightbox="media/parallel-hybrid-migration/minimal-hybrid-1.png":::

 For additional information on Exchange Hybrid, see [Exchange hybrid deployments](/exchange/exchange-hybrid)

### Step 3 - Exchange Administrative Center

1. In [Exchange Admin Center](/exchange/exchange-admin-center), go to Migration and select the users to be migrated.   You can access the EAC using the URL https://admin.exchange.microsoft.com/
2. [Migrate users](/exchange/troubleshoot/move-or-migrate-mailboxes/migrate-data-with-admin-center).
3. Complete migration batches after mailboxes are fully transferred.
 
 >[!NOTE]
 > An endpoint should be created at the last step of the Hybrid Configuration Wizard and should be 
 available to create migration batch in the Exchange Admin Center. If not, create an endpoint manually.

>[!NOTE]
> Once user provisioning is completed by Microsoft Entra Connect, all users in the organization should be available as MailUser in the Exchange Admin Center and can be selected when creating migration batches.

### Step 4 - Uninstall Hybrid Configuration Wizard and Microsoft Entra Connect
Once you finish the migration, you can uninstall the HCW and Microsoft Entra Connect on the virtual server. At this point you can remove the server from the domain and turn it off.

### Step 5 - Repeat for each tenant
Once you finish the steps for migration, repeat the steps for all of your remaining tenants.


## Next steps

- [What is hybrid identity?](../whatis-hybrid-identity.md)
- [What is password hash synchronization?](whatis-phs.md)
- [What is the Exchange Hybrid Configuration Wizard?](/exchange/hybrid-deployment/deploy-hybrid)
- [What is the Exchange Admin Center?](/exchange/exchange-admin-center)
