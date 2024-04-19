---
title: Secure and govern a multi-tenant organization with Microsoft Defender XDR and Microsoft Entra Identity Governance
description: Learn about how to provide security operations analysts access to resources across tenants
author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: multitenant-organizations
ms.topic: overview
ms.date: 04/18/2024
ms.author: rolyon
ms.custom: it-pro
#Customer intent: As a dev, devops, or it admin, I want to
---

# <Input>

Managing multi-tenant environments can add an additional layer of complexity when it comes to keeping up with the ever-evolving security threats facing your enterprise. Navigating across multiple tenants can be time consuming and reduce the overall efficiency of security operation center (SOC) teams.
Multi-tenant management in Microsoft Defender XDR provides security operation teams with a single, unified view of all the tenants they manage. This view enables teams to quickly investigate incidents and perform advanced hunting across data from multiple tenants, improving their security operations.
Microsoft Entra enables you to govern the access and lifecycle of the SOC teams and threat hunters that secure your organization. In this document we will explore:
1. The controls you can put in place for SOC teams to securely access resources across tenants. 
2.	Example topologies for how you can implement your lifecycle and access controls.
3.	Deployment considerations.
  
# Controls 
Microsoft Entra provides the controls needed to govern the lifecycle of the user and to securely provide access to resources. This section describes some of the tools at your disposal to control both the user lifecycle and resource access. In this document the term source tenant refers to where the SOC users originate / authenticate against. Target tenant refers to the tenant that they are investigating when there is an incident. An organization will likely have several “target” tenants due to mergers and acquisitions, aligning tenants with business units, aligning tenants with geos, etc. 
## Lifecycle control
**Entitlement management (connected organizations)** – allows the target tenant admin to define collections of resources (ex: apps, roles, and groups) that users from the source tenant can request access to. If the user is approved for the resources they need, but don’t yet have a B2B account, entitlement management will automatically create a B2B account for the user in the target tenant, and even remove those accounts when the user doesn’t have any remaining entitlements in the target tenant. 
Learn more

**Cross-tenant synchronization** – allows the source tenant to automate creating, updating, and deleting B2B users across tenants in an organization. 
Learn more 
  
**Comparing entitlement management and cross-tenant synchronization**
	Entitlement management  connected orgs	Cross-tenant synchronization
Who controls the settings for provisioning the user accounts?	Target / resource tenant admin	Source / home tenant admin
Create users		
Update users		
Delete users		
Assign access to groups, roles, app		
Create a full user profile (directory extensions, manager, department, etc.)		

**Access control**
Entitlement management
Privileged accounts require additional monitoring with strong identity governance. To ensure least privilege and reduce the number of accounts that an attacker could target, Microsoft Entra provides just-in-time access capabilities.  
Learn more

**Cross-tenant access policies**
Use External Identities cross-tenant access settings to manage how you collaborate with other Microsoft Entra organizations through B2B collaboration. These settings determine both the level of inbound access users in external Microsoft Entra organizations have to your resources, and the level of outbound access your users have to external organizations. 
Learn more

# Topologies
In this section we will explore how you can use tools such as cross-tenant sync, entitlement management, cross-tenant access policies, and conditional access together. In both topologies, the target tenant has full control over access to resources. They differ in who manages provisioning and deprovisioning.   

## Topology 1 
In topology 1, the home tenant configures entitlement management and cross-tenant synchronization in the source tenant to facilitate provisioning accounts into the target tenant. Then, the admin of the target tenant configures access packages in the target tenant to provide access to the necessary roles. 

 
**Steps to configure topology 1**   
1.	In the source tenant, configure [cross-tenant synchronization]( https://learn.microsoft.com/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview) to push B2B accounts into the target tenant. As users are assigned to the cross-tenant synchronization configuration, they will automatically be provisioned into the target tenant. As they are removed from the configuration, they will automatically be deprovisioned. You can determine what users are in scope either by direct assignment to the cross-tenant synchronization service principal or by assignment of a group to the eservice principal. 
a.	As part of your attribute mappings, you can add a new mapping of type constant to provision a directory extension attribute on the user to indicate that they are a SOC administrator. Alternatively, if you have an attribute such as department that you can rely on for this step, you can skip creating the extension. This attribute will be used in the target tenant to provide them access to the necessary roles.
2.	In the source tenant, create an access package that includes the cross-tenant synchronization service principal as a resource. As users are granted access to the package, they will be assigned to the cross-tenant synchronization service principal. Cross-tenant synchronization automatically provisions the account in the target tenant. Ensure that you setup periodic access reviews of the access package to limit the number of users that are in scope for provisioning. 
3.	In the target tenant, create access packages to provide the necessary roles for investigating an incident. We recommend one auto-assigned access package to provide the Security Reader role and one role to provide the Security Operator and Security Admin roles. 
a.	Access package for the security reader role
i.	Approval settings: Automatically approve access when the user has an attribute indicating they are from the home tenant. This can be a directory extension that is stamped by cross-tenant synchronization.
b.	Access package for the security operator and security admin roles
i.	Approval settings:  
ii.	Expiration: X  days
iii.	Users can request a specific timeline: Yes


## Topology 2
In topology 2 the target tenant administrator defines the access packages and resources that the source users can request access to. If the source tenant admins would like to restrict which of their users can access the target tenant, you can use a cross-tenant access policy coupled with an access package to block all access to the target tenant, except for users that are part of a group that is included in an access package in the home tenant. 

 
**Steps to configure topology 2**
1.	In the target tenant, add the source tenant as a connected organization. This setting allows the target tenant admin to make access packages available to the source tenant. 
2.	In the target tenant, create an access package that provides the Security Reader, Security Admin, and Security Operator roles. 
a.	Users who can request access: “Specific connected organizations”
b.	Approval settings:  
c.	Expiration: X  days
d.	Users can request a specific timeline: Yes
e.	Resource roles: X, Y, Z 

**Topologies compared** 

	Topology 1	Topology  2
Lifecycle controls	Source pushes identities into the target.
Source defines when users are removed. 
	Target defines eligibility for provisioning.  
Target defines when accounts are removed (days, hours).
Access controls	Target reviews and approves access to resources. 	Target reviews and approves access to resources 
	Target controls access to sensitive resources (ex: CA policies).	Target can implement controls (ex: MFA for access to sensitive resources)

## Deployment considerations
**Monitoring**
All actions performed by a SOC analyst   in Entra are audited in the tenant that they are operating in. Organizations can maintain an audit trail of actions performed, generate alerts when specific actions are performed, and analyze actions performed by pushing audit logs into Azure Monitor.
Learn more

Critical actions in Microsoft Defender are audited. To understand auditing in Microsoft Defender, see here.
 Learn more

**Scaling deployment with PowerShell / APIs**
Every action performed through the user interface has accompanying MS Graph APIs and PowerShell commandlets, enabling you to deploy your desired policies/configuration across the tenants in your organization. 

Capability	MS Graph API Documentation	PowerShell documentation
Cross-tenant synchronization	Link
Link

Entitlement management		Link

Cross-tenant access policies	Link


**RBAC**
* Configuring cross-tenant access settings - Security administrator
* Configuring cross-tenant sync - Hybrid administrator
* Configuring Entitlement Management -  

Accessing defender relies on out of the box roles such as x,y,z and also supports custom roles. To  learn more about roles in defender, see here: 
https://learn.microsoft.com/en-us/microsoft-365/security/defender/m365d-permissions?view=o365-worldwide

**Limitations**  
* Cross-tenant sync – known issues
* EM – Is there a known issues doc? 

## Next steps

- [Plan for multitenant organizations in Microsoft 365 (Preview)](/microsoft-365/enterprise/plan-multi-tenant-org-overview)
- [What is cross-tenant synchronization?](cross-tenant-synchronization-overview.md)
