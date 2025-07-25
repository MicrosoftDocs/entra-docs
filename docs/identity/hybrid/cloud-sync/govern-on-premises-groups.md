---
title: 'Govern on-premises Active Directory(Kerberos) application access with groups from the cloud'
description: This article provides an overview of how to use cloud sync to govern on-premises application access using groups.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: conceptual
ms.date: 07/25/2025
ms.subservice: hybrid-cloud-sync
ms.author: jomondi
---

# Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance

[!INCLUDE [deprecation](~/includes/gwb-v2-deprecation.md)]

This article outlines the scenarios around governance of on-premises AD
based applications using Entra ID Governance capabilities.

**Scenario(s) covered:** Manage on-premises applications with Active
Directory groups that are provisioned from and managed in the cloud.
Microsoft Entra Cloud Sync allows you to fully govern application
assignments in AD while taking advantage of Microsoft Entra ID
Governance features to control and remediate any access related
requests.

For more information about how to govern applications that aren't AD-integrated, see [Govern access for applications in your environment](/entra/id-governance/identity-governance-applications-prepare).

## Supported scenarios

If you want to control whether a user is able to connect to an Active
Directory application that uses Windows authentication, you can use the
application proxy and a Microsoft Entra security group. If an
application checks a user's AD group memberships by using Kerberos or Lightweight Directory Access Protocol (LDAP),
then you can use cloud sync group provisioning to ensure an AD user has
those group memberships before the user accesses the applications.

The following sections discuss three options that are supported with
cloud sync group provisioning. The scenario options are meant to ensure
users assigned to the application have group memberships when they
authenticate to the application.

- Use Group Source of Authority to transfer the source of authority of groups in Active Directory that are synchronized to Microsoft Entra ID by using Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync.

- Create a new group and update the application, if it already exists,
  to check for the new group

- Create a new group and update the existing groups, the application was
  checked for, to include the new group as a member

Before you begin, ensure that you're a domain administrator in the
domain where the application is installed. Ensure you can sign into a
domain controller, or have the [Remote Server Administration tools](/troubleshoot/windows-server/system-management-components/remote-server-administration-tools) for
Active Directory Domain Services (AD DS) administration installed on
your Windows PC.

Microsoft Entra ID has an application proxy service that enables users
to access on-premises applications by signing in with their Microsoft
Entra account. For information on configuring app proxy, see [Add an on-premises application for remote access through application proxy in Microsoft Entra ID](/entra/identity/app-proxy/application-proxy-add-on-premises-application).




[!INCLUDE [governance-on-premises-active-directory-apps.md](~/includes/governance/governance-on-premises-active-directory-apps.md)]



## Related content
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Group provisioning to Active Directory using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md)
- [Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync migration](migrate-group-writeback.md)
