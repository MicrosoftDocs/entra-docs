---
title: 'Prerequisites for Microsoft Entra Cloud Sync in Microsoft Entra ID'
description: This article describes the prerequisites and hardware requirements you need for cloud sync.
ms.topic: how-to
ms.date: 07/27/2026
ms.subservice: hybrid-cloud-sync
---
# Prerequisites for Microsoft Entra Cloud Sync
This article provides guidance on using Microsoft Entra Cloud Sync as your identity solution.
## Cloud provisioning agent requirements
You need the following to use Microsoft Entra Cloud Sync:
- Domain Administrator or Enterprise Administrator credentials to create the Microsoft Entra Connect cloud sync gMSA (group managed service account) to run the agent service.
- A Hybrid Identity Administrator account for your Microsoft Entra tenant that isn't a guest user.
- Microsoft Entra Cloud Sync agent must be installed on a domain-joined server. We recommend using Windows Server 2025 or Windows Server 2022. You can also deploy Microsoft Entra Cloud Sync on older Windows Server versions that are in extended support; however, support for this configuration may require [a paid support program](/lifecycle/policies/fixed#extended-support).
  > [!IMPORTANT]  
> There is a known issue on Windows Server 2025 that can cause Microsoft Entra Cloud Sync to encounter synchronization problems. If you're running Windows Server 2025, make sure you have installed [October 20, 2025 - KB5070773](https://support.microsoft.com/topic/october-20-2025-kb5070773-os-build-26100-6901-out-of-band-f8effaa1-1c73-41e5-bcb3-e58a46c7601e) update, or later. After installing this update, restart the server for the changes to take effect.  
- This server should be a tier 0 server based on the [Active Directory administrative tier model](/security/privileged-access-workstations/privileged-access-access-model). Installing the agent on a domain controller is supported.  For more information, see [Harden your Microsoft Entra provisioning agent server](#harden-your-microsoft-entra-provisioning-agent-server)
- The Active Directory Schema is required to have the attribute msDS-ExternalDirectoryObjectId, which is available in Windows Server 2016 and later.
- The Windows Credential Manager service (VaultSvc) cannot be disabled as that prevents the provisioning agent from installing.
- High availability refers to the Microsoft Entra Cloud Sync's ability to operate continuously without failure for a long time. By having multiple active agents installed and running, Microsoft Entra Cloud Sync can continue to function even if one agent should fail. Microsoft recommends having 3 active agents installed for high availability.
- On-premises firewall configurations.

## Harden your Microsoft Entra provisioning agent server
We recommend that you harden your Microsoft Entra provisioning agent server to decrease the security attack surface for this critical component of your IT environment. Following these recommendations helps mitigate some security risks to your organization.
- We recommend hardening the Microsoft Entra provisioning agent server as a Control Plane (formerly Tier 0) asset by following the guidance provided in [Secure Privileged Access](/security/privileged-access-workstations/overview) and [Active Directory administrative tier model](/security/privileged-access-workstations/privileged-access-access-model).
- Restrict administrative access to the Microsoft Entra provisioning agent server to only domain administrators or other tightly controlled security groups.
- Create a [dedicated account for all personnel with privileged access](/windows-server/identity/securing-privileged-access/securing-privileged-access). Administrators shouldn't be browsing the web, checking their email, and doing day-to-day productivity tasks with highly privileged accounts.
