---
title: Embrace cloud-first posture and transfer user Source of Authority (SOA) to the cloud (Preview)
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

# Embrace cloud-first posture: Transfer user Source of Authority (SOA) to the cloud (Preview)

Organizations are increasingly adopting a cloud-first approach to modernize their Identity and Access Management (IAM) solutions. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals. Transitioning the Source of Authority (SOA) for users from on-premises Active Directory Domain Services (AD DS) to the cloud is a key step in this journey. This process, known as AD DS minimization, reduces the complexity of on-premises infrastructure by managing users directly in the cloud.

This article introduces the concept of user SOA, its benefits, and the scenario it supports. It also outlines key considerations and prerequisites for IT administrators planning to shift user management to the cloud using Microsoft Entra ID. By using user SOA, organizations can streamline user lifecycle management, enable advanced governance capabilities, and fully embrace a cloud-first posture. For a guide on using user SOA for IT architects, see: [Cloud-First identity management: Guidance for IT architects](guidance-it-architects-source-of-authority.md).


## User SOA scenario
 
The next sections explain more details about the scenario that User SOA supports.
 
### Minimizing AD users and governing user lifecycle with Microsoft Entra ID Governance
 
**Scenario**: You modernized some or all your applications and removed the need to use AD DS users for access. For example, these applications now use user [claims with Security Assertion Markup Language (SAML)](../../identity-platform/saml-claims-customization.md) or [OpenID Connect](../../identity-platform/v2-protocols-oidc.md) from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched user to manage access. By implementing User SOA, you can edit the user in the cloud, remove the AD DS user completely, and govern the user through Microsoft Entra ID Governance capabilities.
 
:::image type="content" source="media/user-source-of-authority-overview/user-source-of-authority-minimization.png" alt-text="Screenshot of user SOA minimization.":::
 
### Password-less authentication of SOA transferred users
 
**Scenario**:  You’ve transferred the SOA for users and now want to allow them to access both on-premises, and cloud, resources. Instead of completely removing users from on-premises, introduce Cloud Kerberos Trust password-less authentication to allow them to maintain a hybrid presence allowing them to continue to access their on-premises resources, while also allowing them to access cloud resources. Password-less authentication methods, such as [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/configure) or [FIDO2 security keys](../../identity/authentication/how-to-enable-passkey-fido2.md), can be used to allow these users to access both their on-premises resources, and cloud resources such as [Azure Files](/azure/storage/files/storage-files-introduction) through [Microsoft Entra Private Access](../../global-secure-access/concept-private-access.md). Using Password-less authentication also enables Multifactor Authentication on the SOA transferred users increasing security. Password-less authentication also allows you to enable Conditional Access policies on the on-premises resources, allowing greater control and security over these resources. **The user account must remain in Active Directory for this scenario to work**.
 
:::image type="content" source="media/user-source-of-authority-overview/passwordless-authentication-source-of-authority.png" alt-text="Screenshot of the password-less authentication scenario for User SOA.":::

## Prerequisites for transferring user SOA

Before you begin transferring the SOA for users in your organization, your environment must meet the following prerequisites:

- The Cloud HR system has been configured and successfully integrated with Microsoft Entra ID. Changes to users provisioned from the HR system should go directly Microsoft Entra ID. For more information, see: [Shift the configuration of users in provisioning from the HR system](prepare-user-source-of-authority-environment.md#shift-the-configuration-of-users-in-provisioning-from-the-hr-system).
- No on-premises Exchange workloads. If you're currently using on-premises Exchange server, shift the users and mailboxes to the cloud and then remove on-prem-exchange. For more information, see: [Prepare your Microsoft Exchange setup](prepare-user-source-of-authority-environment.md#prepare-your-microsoft-exchange-setup).
- Password-less authentication utilizing [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/configure) or [FIDO2 security keys](../../identity/authentication/how-to-enable-passkey-fido2.md) is required.
- The [Cloud Kerberos Trust type](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust) must be utilized.
- The users intended for SOA transfer aren't associated with any applications that require password-based authentication. If any of the users you want to transfer SOA for have any password dependencies, then transferring SOA isn't supported. If users are using federated authentication using [Active Directory Federation Service](/windows-server/identity/ad-fs/ad-fs-overview), then transferring SOA isn't supported. If your organization uses a third-party federation authentication identity provider, and plan to transfer the SOA of users, you must manage the Active Directory account manually. With this process, you must maintain the password using the third-party sync tool.



## Related content

- [Configure User Source of Authority (SOA) in Microsoft Entra ID (Preview)](how-to-user-source-of-authority-configure.md)
- [Prepare Your Environment for User SOA (Preview)](prepare-user-source-of-authority-environment.md)
