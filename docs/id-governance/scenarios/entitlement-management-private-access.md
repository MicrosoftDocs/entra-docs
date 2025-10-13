---
title: 'Entra Suite Scenario: Using Entra Private Access with Entitlement Management  '
description: Describes how to use Entitlement Management with Private Access
ms.service: entra-id-governance
ms.subservice:
author: billmath
manager: dougeby

ms.workload: identity
ms.topic: overview
ms.date: 04/09/2025
ms.author: billmath
---

# Entra Suite Scenario: Using Entra Private Access with Entitlement Management  

The Microsoft Entra Suite provides capabilities to deploy a robust solution to govern who can access on-premises and legacy applications in modern remote work scenarios. Microsoft Entra Private Access enables organizations to modernize how users securely connect to existing web apps, legacy apps and other resources on private networks whether the user is on-premises or accessing remotely. Entitlement management enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration. 

Similar to cloud apps, on-premises apps that support provisioning or federation, or security groups, apps that are configured for connection via Microsoft Entra Private Access can be integrated into Entitlement Management, allowing organizations to maintain a consistent governance process across resources of many types.  

:::image type="content" source="media/entitlement-management-private-access/private-access-1.png" alt-text="Conceptual drawing of private access." lightbox="media/entitlement-management-private-access/private-access-1.png":::

Traditionally, Entra Application Proxy has been used to provide secure remote access to on-premises web-based applications without requiring a VPN. Users working remotely may still need access to non-web-based apps which traditionally require a VPN for protocols like MSSQL, SSH, or RDP. This presents two key issues: 

 - Most VPNs give access to the entire network
 - Some VPNs historically give access to anyone with a client and don't check the user's authorized need for access. 

## Common Scenarios 

The following scenarios illustrate how the Microsoft Entra Suite can help modernize your environment by governing who can access applications on private networks.  

### Scenario 1: VPN replacement for non-Active Directory integrated applications 

Entra ID Governance can establish who should have access to an on-premises app, enabling users to securely access the app via Entra Private Access when the user isn't located on-premises.  

Many organizations have applications on private networks enabling assigned users to access those apps while users are on their organization’s network. Through Microsoft Entra’s provisioning connectors, Entra ID Governance can orchestrate the creation of user accounts in most on-premises systems, such as LDAP directories or SQL databases. ​ 

Depending on your scenario, there will be two or three objects in Entra representing your real-world application: 

- There will be an application object representing the Entra Private Access connection to that application's endpoints.
- If the application is federated to your Microsoft Entra directory as an identity provider, there will be an application object representing authenticating the user to the application's endpoint, such as using SAML, OAuth, or OpenID Connect. 
- If the application uses on-premises provisioning agent connectors to be provisioned via LDAP, SQL, PowerShell, SOAP, or REST, then there will be an application object representing that provisioning integration. 
- If the application uses an Active Directory group created by Microsoft Entra (see Scenario 3 below), then there will be a group 

:::image type="content" source="media/entitlement-management-private-access/private-access-2.png" alt-text="Conceptual drawing of scenario 1." lightbox="media/entitlement-management-private-access/private-access-2.png":::

Include the related application's resources in an access package, and when a user requests the package and is approved, they'll receive app role assignments in each app.  This will cause them to be provisioned to the app (if needed), have Microsoft Entra issue federation tokens for the user for the app upon request, and the user will be permitted to connect to the app with Entra Private Access. When the user’s access package assignment ends, their account is removed from the app, and their ability to connect to app is also revoked. 

:::image type="content" source="media/entitlement-management-private-access/private-access-3.png" alt-text="Conceptual drawing of scenario 1 with VPN replacement." lightbox="media/entitlement-management-private-access/private-access-3.png":::

### Scenario 2: VPN Replacement for on-premises Active Directory Integrated applications 

Organizations often face challenges in enabling secure access to AD-integrated applications for hybrid users—those whose identities exist both in the cloud and on-premises. By utilizing Entra Private Access, entitlement management, and group write-back, organizations can implement governed access for hybrid users to AD-integrated on-premises apps. 

A group in Entra is configured for group write-back, which synchronizes Entra group memberships with an on-premises AD group. A user initiates the process by submitting a request for an access package in Entra which contains the Entra security group. Once the request is approved, the user is assigned the access package and added to the group.  

Through group write-back, the user’s Entra group membership is reflected in the corresponding on-premises AD group. This synchronization ensures the on-premises AD group’s membership is always up to date with changes made in Entra. The on-premises AD group, in turn, is configured to provide access to the target on-premises application. The group membership has been configured with a private access scoping policy, which defines the conditions under which users can securely connect to the on-premises resource. 

With the user’s access provisioned, they can now securely connect to the on-premises application through Entra Private Access.  

:::image type="content" source="media/entitlement-management-private-access/private-access-4.png" alt-text="Conceptual drawing of scenario 2." lightbox="media/entitlement-management-private-access/private-access-4.png":::

### Scenario 3: VPN Replacement for disconnected apps 

Organizations may have legacy applications that don’t support any provisioning protocols or modern authentication protocols like Kerberos or SAML. ​In these scenarios, organizations can​ manually provision users to the app and then put the app into a separate network segment (a VLAN) along with its dependencies and the Entra Private Access proxy. This prevents users, even on premises, from connecting to the app. 

Users can then request access to the protected app. Once approved, Entra ID Governance opens a service ticket (e.g., in ServiceNow) for the app owner to manually give the employee [an account in that system](../entitlement-management-ticketed-provisioning.md). Entra ID Governance then assigns the user to the representation of the app in Entra.  
 
Now, when the employee connects to the app from their PC, Entra Private Access automatically tunnels their connection securely from their PC to the protected app.  
 
When the access assignment expires, Entra ID Governance will similarly open another ticket for the app owner to manually remove their account, removing the user’s ability to connect to that application. 

:::image type="content" source="media/entitlement-management-private-access/private-access-5.png" alt-text="Conceptual drawing of scenario 3." lightbox="media/entitlement-management-private-access/private-access-5.png":::

## Next steps

- [What is Microsoft Entra entitlement management?](../entitlement-management-overview.md)
- [What is Global Secure Access?](../../global-secure-access/overview-what-is-global-secure-access.md)
