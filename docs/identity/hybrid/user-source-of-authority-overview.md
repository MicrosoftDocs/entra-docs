---
title: Embrace cloud-first posture and convert User Source of Authority (SOA) to the cloud (Preview)
description: Learn about Source of Authority (SOA) for users, including prerequisites and supported scenarios.
author: owinfreyATL
ms.topic: conceptual
ms.service: entra-id
ms.subservice: hybrid
ms.date: 08/13/2025
ms.author: owinfrey
ms.reviewer: dhanyak

#CustomerIntent: As an IT administrator, I want to learn about user Source of Authority (SOA) so that I can minimize my on-premises footprint.
---

# Embrace cloud-first posture: Convert User Source of Authority (SOA) to the cloud (Preview)

Organizations are increasingly adopting a cloud-first approach to modernize their Identity and Access Management (IAM) solutions. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals. Transitioning the Source of Authority (SOA) for users from on-premises Active Directory Domain Services (AD DS) to the cloud is a key step in this journey. This process, known as AD DS minimization, reduces the complexity of on-premises infrastructure by managing users directly in the cloud.

This article introduces the concept of User SOA, its benefits, and the scenario it supports. It also outlines key considerations and prerequisites for IT administrators planning to shift user management to the cloud using Microsoft Entra ID. By using User SOA, organizations can streamline user lifecycle management, enable advanced governance capabilities, and fully embrace a cloud-first posture.


## User SOA Scenario

The next sections explain more details about the scenario that User SOA supports.

### Minimizing AD Users and Govern user lifecycle with Microsoft Entra ID Governance

**Scenario**: You modernized some or all your applications and removed the need to use AD DS users for access. For example, these applications now use user [claims with Security Assertion Markup Language (SAML)](/identity-platform/saml-claims-customization) or [OpenID Connect](/identity-platform/v2-protocols-oidc) from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched user to manage access. By implementing User SOA, you can edit the user in the cloud, remove the AD DS user completely, and govern the user through Microsoft Entra ID Governance capabilities.

:::image type="content" source="media/user-source-of-authority-overview/user-soa-minimization.jpg" alt-text="Screenshot of minimization of active directory using user SOA.":::

**Scenario**:  You’ve converted the SOA for Users and now want to allow them to access both on-premises, and cloud, resources. Instead of completely removing users from on-premises, introduce Cloud Kerberos Trust password-less authentication to allow them to maintain a hybrid presence allowing them to continue to access their on-premises resources, while also allowing them to access cloud resources. Password-less authentication methods, such as [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/configure) or [FIDO2 security keys](/identity/authentication/how-to-enable-passkey-fido2), can be used to allow these users to access both their on-prem resources, and cloud resources such as [Azure Files](/azure/storage/files/storage-files-introduction) through [Microsoft Entra Private Access](/global-secure-access/concept-private-access). Using Password-less authentication also enables Multifactor Authentication on the SOA converted users increasing security. Password-less authentication also allows you to enable Conditional Access policies on the on-premises resources, allowing greater control and security over these resources.

:::image type="content" source="media/user-source-of-authority-overview/password-less-authentication-SOA.png" alt-text="Screenshot of the password-less authentication scenario for User SOA.":::

## Consideration for User SOA

Before you begin converting the SOA for users in your organization, there are certain conditions within your environment that you must consider. The following sections provide specific details what you must consider before implementing User SOA based on your environment. 

### HR-driven Inbound Provisioning

If your organization is using Microsoft Entra HR inbound provisioning from any HR system, you must direct changes to those users directly to Microsoft Entra ID. For more information, see:  [Shift Your HR Integration To The Cloud](prepare-user-soa-environment.md#shift-your-hr-integration-to-the-cloud).

### Active Directory Users and Computers or the Active Directory module for PowerShell

If your organization is using AD management tools such as Active Directory Users and Computers, or the Active Directory module for PowerShell, then changes made using those tools to AD objects whose SOA has changed will cause an inconsistency with the Microsoft Entra representation. Prior to performing a SOA change, your organization should move those objects to a designated AD OU that signals those objects should no longer be managed via AD tools. If the user who’s SOA you want to convert is referenced in an on-premises managed group, then the user should remain in the sync scope. If you delete the on-premises user, then it is also removed from both the on-premises and Microsoft Entra group.

### Microsoft Identity Manager with the AD MA

If your organization is using Microsoft Identity Manager with the AD MA to manage AD users and groups, then before an SOA change, the organization must configure their sync logic to no longer export changes to those objects from MIM via AD MA. Instead of using the AD MA, you can have MIM update the objects in Microsoft Entra using the [MIM connector for Microsoft Graph](/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph) so that the changes made by MIM are first sent to Microsoft Entra, and then to Active Directory where needed. For more information, see: [Prepare your MIM setup](prepare-user-soa-environment.md#prepare-your-mim-setup).

### Applications

Your application must be modernized, and you should use [cloud authentication](/entra/architecture/authenticate-applications-and-users) for SOA to work. If you need to access on-premises resources, you can use Microsoft Entra Kerberos and [Microsoft Entra Private Access](/entra/global-secure-access/concept-private-access) to access Kerberos based AD apps. For LDAP based applications, we recommend using Microsoft Entra Domain Services.  

### Devices

We recommend that customers migrate their devices to the cloud, and use a Microsoft Entra Joined Device setup in order to fully use user SOA capabilities. For groups, there’s no prerequisites around devices.  

### Credentials





## Related content

- [Configure User Source of Authority (SOA) in Microsoft Entra ID (Preview)](how-to-user-source-of-authority-configure.md)
