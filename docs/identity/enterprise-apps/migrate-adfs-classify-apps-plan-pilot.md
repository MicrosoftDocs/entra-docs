---
title: 'Phase 2: Classify apps and plan pilot'
description: This article describes phase 2 of planning migration of applications from AD FS to Microsoft Entra ID

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: concept-article

ms.date: 05/30/2023
ms.author: jomondi
ms.reviewer: gasinh
ms.collection: M365-identity-device-management

#customer intent: As an IT admin responsible for app migration, I want to classify and prioritize apps based on business criticality, usage, and lifespan, so that I can plan a successful pilot and migration strategy.
---

# Phase 2: Classify apps and plan pilot

Classifying the migration of your apps is an important exercise. Not every app needs to be migrated and transitioned at the same time. Once you collect information about each of the apps, you can rationalize which apps should be migrated first and which might take added time.

## Classify in-scope apps

One way to think about this aspect is along the axes of business criticality, usage, and lifespan, each of which is dependent on multiple factors.

### Business criticality

Business criticality takes on different dimensions for each business, but the two measures that you should consider are **features and functionality** and **user profiles**. Assign apps with unique functionality a higher point value than apps with redundant or obsolete functionality.

:::image type="content" source="media/migrate-adfs-classify-apps-plan-pilot/functionality-user-profile.png" alt-text="Diagram showing the spectrums of features & functionality and user profiles.":::

### Usage

Applications with **high usage numbers** should receive a higher value than apps with low usage. Assign a higher value to apps with external, executive, or security team users. For each app in your migration portfolio, complete these assessments.

:::image type="content" source="media/migrate-adfs-classify-apps-plan-pilot/user-volume-breadth.png" alt-text="Diagram showing the spectrums of User Volume and User Breadth.":::

Once you determined values for business criticality and usage, you can then determine the **application lifespan**, and create a matrix of priority. The diagram shows the matrix.

:::image type="content" source="media/migrate-adfs-classify-apps-plan-pilot/triangular-diagram-showing-relationship.png" alt-text="Diagram of a triangle showing the relationships between Usage, Expected Lifespan, and Business Criticality.":::

> [!VIDEO https://www.youtube.com/embed/PxLIacDpHh4]

>[!NOTE]
> This video covers both phase 1 and 2 of the migration process.

## Prioritize apps for migration

You can choose to begin the app migration with either the lowest priority apps or the highest priority apps based on your organization’s needs.

In a scenario where you might not have experience using Microsoft Entra ID and Identity services, consider moving your **lowest priority apps** to Microsoft Entra first. This option minimizes your business impact, and you can build momentum. Once you successfully move these apps and gain the stakeholder’s confidence, you can continue to migrate the other apps.

If there's  no clear priority, you should consider moving the apps that are in the [Microsoft Entra Gallery](https://azuremarketplace.microsoft.com/marketplace/apps/category/azure-active-directory-apps) first and support multiple identity providers because they're easier to integrate. It's likely that these apps are the **highest-priority apps** in your organization. To help integrate your SaaS applications with Microsoft Entra ID, There's a collection of [tutorials](~/identity/saas-apps/tutorial-list.md) that walk you through configuration.

When you have a deadline to migrate the apps, these highest priority apps bucket takes the major workload. You can eventually select the lower priority apps as they don't change the cost even if you move the deadline.

In addition to this classification and depending on the urgency of your migration, you should publish a **migration schedule** within which app owners must engage to have their apps migrated. At the end of this process, you should have a list of all applications in prioritized buckets for migration.

## Document your apps

First, start by gathering key details about your applications. The [Application Discovery Worksheet](https://download.microsoft.com/download/2/8/3/283F995C-5169-43A0-B81D-B0ED539FB3DD/Application%20Discovery%20worksheet.xlsx) helps you to make your migration decisions quickly and get a recommendation out to your business group in no time at all.

Information that is important to making your migration decision includes:

- **App name** – what is this app known as to the business?
- **App type** – is it a third-party SaaS app? A custom line-of-business web app? An API?
- **Business criticality** – is its high criticality? Low? Or somewhere in between?
- **User access volume** – does everyone access this app or just a few people?
- **User access type**: who needs to access the application – Employees, business partners, or customers or perhaps all?
- **Planned lifespan** – how long it's availability? Less than six months? More than two years?
- **Current identity provider** – what is the primary IdP for this app? AD FS, Active Directory, or Ping Federate?
- **Security requirements** - does the application require MFA or that users be on the corporate network to access the application?
- **Method of authentication** – does the app authenticate using open standards?
- **Whether you plan to update the app code** – is the app under planned or active development?
- **Whether you plan to keep the app on-premises** – do you want to keep the app in your datacenter long term?
- **Whether the app depends on other apps or APIs** – does the app currently call into other apps or APIs?
- **Whether the app is in the Microsoft Entra gallery** – is the app currently already integrated with the [Microsoft Entra Gallery](https://azuremarketplace.microsoft.com/marketplace/apps/category/azure-active-directory-apps)?

Other data that helps you later, but that you don't need to make an immediate migration decision includes:

- **App URL** – where do users go to access the app?
- **Application Logo**: If migrating an application to Microsoft Entra ID that isn’t in the Microsoft Entra app gallery, we recommend you provide a descriptive logo
- **App description** – what is a brief description of what the app does?
- **App owner** – who in the business is the main POC for the app?
- **General comments or notes** – any other general information about the app or business ownership

Once you classify your application and documented the details, then be sure to gain business owner buy-in to your planned migration strategy.

## Application users

There are two main categories of users of your apps and resources that Microsoft Entra ID supports:

- **Internal:** Employees, contractors, and vendors that have accounts within your identity provider. This category might need further pivots with different rules for managers or leadership versus other employees.

- **External:** Vendors, suppliers, distributors, or other business partners that interact with your organization in the regular course of business with [Microsoft Entra B2B collaboration.](~/external-id/what-is-b2b.md)

You can define groups for these users and populate these groups in diverse ways. You might choose that an administrator must manually add members into a group, or you can enable self-service group membership. Rules can be established that automatically add members into groups based on the specified criteria using [dynamic groups](~/identity/users/groups-dynamic-membership.md).

External users might also refer to customers. [Azure AD B2C](/azure/active-directory-b2c/overview), a separate product supports customer authentication. However, it is outside the scope of this paper.

## Plan a pilot

The app(s) you select for the pilot should represent the key identity and security requirements of your organization, and you must have clear buy-in from the application owners. Pilots typically run in a separate test environment.

Don’t forget about your external partners. Make sure that they participate in migration schedules and testing. Finally, ensure they have a way to access your helpdesk if there were breaking issues.

## Plan for limitations

While some apps are easy to migrate, others might take longer due to multiple servers or instances. For example, SharePoint migration might take longer due to custom sign-in pages.

Many SaaS app vendors might not provide a self-service means to reconfigure the application and might charge for changing the SSO connection. Check with them and plan for limitation.

## App owner approval

Business critical and universally used applications might need a group of pilot users to test the app in the pilot stage. Once you test an app in the preproduction or pilot environment, ensure that app business owners give approval on performance prior to the migration of the app. You should also ensure that all users migrate to production use of Microsoft Entra ID for authentication.

## Plan the security posture

Before you initiate the migration process, take time to fully consider the security posture you wish to develop for your corporate identity system. This aspect is based on gathering these valuable sets of information: **Identities, devices, and locations that are accessing your applications and data.**

### Identities and data

Most organizations have specific requirements about identities and data protection that vary by industry segment and by job functions within organizations. Refer to [identity and device access configurations](/microsoft-365/security/office-365-security/microsoft-365-policies-configurations) for our recommendations. The recommendations include a prescribed set of [Conditional Access policies](~/identity/conditional-access/overview.md) and related capabilities.

You can use this information to protect access to all services integrated with Microsoft Entra ID. These recommendations are aligned with Microsoft Secure Score and the [identity score in Microsoft Entra ID](~/identity/monitoring-health/concept-identity-secure-score.md). The score helps you to:

- Objectively measure your identity security posture
- Plan identity security improvements
- Review the success of your improvements

The Microsoft Secure Score also helps you implement the [five steps to securing your identity  infrastructure](/azure/security/fundamentals/steps-secure-identity). Use the guidance as a starting point for your organization and adjust the policies to meet your organization's specific requirements.

### Device/location used to access data

The device and location that a user uses to access an app are also important. Devices physically connected to your corporate network are more secure. Connections from outside the network over VPN might need scrutiny.

:::image type="content" source="media/migrate-adfs-classify-apps-plan-pilot/user-location-data-access.png" alt-text="Diagram showing the relationship between User Location and Data Access.":::

With these aspects of resource, user, and device in mind, you might choose to use [Microsoft Entra Conditional Access](~/identity/conditional-access/overview.md) capabilities. Conditional Access goes beyond user permissions. It depends on a combination of factors such as:

- The identity of a user or group
- The network that the user is connected to
- The device and application the user is using
- The type of data the user is trying to access.

The access granted to the user adapts to this broader set of conditions.

## Exit criteria

You're successful in this phase when you have:

- Fully documented the apps you intend to migrate

- Prioritized apps based on business criticality, usage volume, and lifespan

- Selected apps that represent your requirements for a pilot

- Business-owner buy-in to your prioritization and strategy

- Understanding of your security posture needs and how to implement them

## Next steps

- [Phase 3 - Plan migration and testing](migrate-adfs-plan-migration-test.md)
