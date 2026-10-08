---
title: Transfer user SOA to Microsoft Entra ID
description: Learn how to transfer user Source of Authority (SOA) to Microsoft Entra ID, minimize your AD DS footprint, and govern the full user lifecycle from the cloud.
author: dhanyahk
ms.author: dhanyahk
ms.service: entra-id
ms.topic: concept-article
ms.subservice: hybrid-cloud-sync
ms.date: 08/11/2026
ms.reviewer: dhanyahk
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1023
#customer intent: As an IT administrator, I want to learn about user Source of Authority (SOA) so that I can minimize my on-premises footprint.
---

# Transfer user Source of Authority (SOA) to Microsoft Entra ID

Organizations are increasingly adopting a cloud-first approach to modernize their Identity and Access Management (IAM) solutions. For the road to the cloud initiative, Microsoft has [modeled five states of transformation](/entra/architecture/road-to-the-cloud-posture#five-states-of-transformation) to align with customer business goals. Transitioning the Source of Authority (SOA) for users from on-premises Active Directory Domain Services (AD DS) to the cloud is a key step in this journey. This process, known as AD DS minimization, reduces the complexity of on-premises infrastructure by managing users directly in the cloud.

This article introduces the concept of user SOA, its benefits, and the scenarios it supports. It also outlines key considerations and prerequisites for IT administrators planning to shift user management to the cloud using Microsoft Entra ID. By using user SOA, organizations can manage the user lifecycle in the cloud with Microsoft Entra ID Governance. For users who still need access to on-premises resources, [provisioning from Microsoft Entra ID to Active Directory](cloud-sync/overview-provision-entra-id-to-active-directory.md) can maintain the required AD account while Microsoft Entra ID remains the source of authority. For guidance on using user SOA for IT architects, see [Microsoft Entra cloud-first identity guidance](guidance-it-architects-source-of-authority.md).



## Video: Microsoft Entra User Source of Authority


Check out this video for an introduction to SOA and how it can help you shift to the cloud:

> [!VIDEO https://www.youtube.com/embed/QnY-D5bdh4Y]

## User SOA scenario
 
The next sections explain more details about the scenario that User SOA supports.
 
### Minimizing AD users and governing user lifecycle with Microsoft Entra ID Governance
 
**Scenario**: You modernized some or all your applications and removed the need to use AD DS users for access. For example, these applications now use user [claims with Security Assertion Markup Language (SAML)](../../identity-platform/saml-claims-customization.md) or [OpenID Connect](../../identity-platform/v2-protocols-oidc.md) from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched user to manage access. By implementing User SOA, you can edit the user in the cloud, remove the AD DS user completely, and govern the user through Microsoft Entra ID Governance capabilities.
 
:::image type="content" source="media/user-source-of-authority-overview/user-source-of-authority-minimization.png" alt-text="Diagram that shows removing an AD DS user after transferring user SOA and governing the user through Microsoft Entra ID Governance." lightbox="media/user-source-of-authority-overview/user-source-of-authority-minimization.png":::
 
### Passwordless authentication of SOA transferred users
 
**Scenario**: You've transferred the SOA for users and want them to access both on-premises and cloud resources. Instead of removing the users from on-premises, use Cloud Kerberos Trust passwordless authentication to maintain their hybrid presence and access to on-premises resources.

Passwordless authentication methods, such as [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/configure) or [FIDO2 security keys](../../identity/authentication/how-to-authentication-passkeys-fido2.md), let these users access on-premises and cloud resources. For example, users can access [Azure Files](/azure/storage/files/storage-files-introduction) through [Microsoft Entra Private Access](../../global-secure-access/concept-private-access.md). These methods also enable multifactor authentication and Conditional Access policies for on-premises resources, which provides greater control and security. **The user account must remain in Active Directory for this scenario to work**.
 
:::image type="content" source="media/user-source-of-authority-overview/passwordless-authentication-source-of-authority.png" alt-text="Diagram that shows passwordless authentication for a user whose SOA is managed in Microsoft Entra ID." lightbox="media/user-source-of-authority-overview/passwordless-authentication-source-of-authority.png":::

### Provision users to Active Directory for Kerberos app access and lifecycle governance

**Scenario**: You transferred the SOA for users to Microsoft Entra ID, and those users still need to access on-premises applications that rely on Kerberos authentication while you govern their lifecycle from the cloud.

Configure [provisioning from Microsoft Entra ID to Active Directory](cloud-sync/overview-provision-entra-id-to-active-directory.md). Microsoft Entra Cloud Sync provisions the cloud-managed user back into AD, so the AD account exists for Kerberos-based single sign-on. That account supports passwordless authentication, such as Windows Hello for Business or Cloud Kerberos Trust. Microsoft Entra ID remains the source of authority, and attribute changes flow to AD automatically. You can govern the user lifecycle through Microsoft Entra ID Governance while Cloud Sync maintains the AD account.

:::image type="content" source="media/user-source-of-authority-overview/provision-users-for-kerberos-access-and-governance.png" alt-text="Diagram that shows provisioning SOA-converted users to Active Directory for Kerberos application access and lifecycle governance." lightbox="media/user-source-of-authority-overview/provision-users-for-kerberos-access-and-governance.png":::


## Prerequisites for transferring user SOA

Before you begin transferring the SOA for users in your organization, your environment must meet the following prerequisites:

- The Cloud HR system has been configured and successfully integrated with Microsoft Entra ID. Changes to users provisioned from the HR system should go directly Microsoft Entra ID. For more information, see: [Shift the configuration of users in provisioning from the HR system](prepare-user-source-of-authority-environment.md#shift-the-configuration-of-users-in-provisioning-from-the-hr-system).
- No on-premises Exchange workloads. If you're currently using on-premises Exchange server, shift the users and mailboxes to the cloud and then remove on-prem-exchange. For more information, see: [Prepare your Microsoft Exchange setup](prepare-user-source-of-authority-environment.md#prepare-your-microsoft-exchange-setup).
- Any authentication method works for cloud users. For Kerberos-based applications, use passwordless authentication, such as Windows Hello for Business with Cloud Kerberos Trust. The AD account provisioned by [provisioning to Active Directory](cloud-sync/overview-provision-entra-id-to-active-directory.md) enables Kerberos single sign-on.
- The [Cloud Kerberos Trust type](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust) must be used for passwordless authentication.
- Users intended for SOA transfer can't be associated with applications that require password-based authentication, including LDAP bind or Kerberos with a password.
- If users use federated authentication through [Active Directory Federation Services (AD FS)](/windows-server/identity/ad-fs/ad-fs-overview), transferring SOA isn't supported.
- If your organization uses a third-party federation identity provider, you must manage the Active Directory account manually and maintain the password by using the third-party sync tool.



## Related content

- [Overview of provisioning from Microsoft Entra ID to Active Directory](cloud-sync/overview-provision-entra-id-to-active-directory.md)
- [Configure User Source of Authority (SOA) in Microsoft Entra ID](how-to-user-source-of-authority-configure.md)
- [Prepare Your Environment for User SOA](prepare-user-source-of-authority-environment.md)
