---
title: How and why apps are added to Microsoft Entra ID
description: What does it mean for an application to be added to Microsoft Entra ID and how do they get there?
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.date: 10/26/2022
ms.reviewer: sureshja
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an IT admin, I want to understand how and why applications are added to Microsoft Entra ID and the differences between application objects and service principals, so that I can effectively manage and configure applications in the directory.
---

# How and why applications are added to Microsoft Entra ID

There are two representations of applications in Microsoft Entra ID:

- [Application objects](app-objects-and-service-principals.md#application-object) - Although there are [exceptions](#notes-and-exceptions), application objects can be considered the definition of an application.
- [Service principals](app-objects-and-service-principals.md#service-principal-object) - Can be considered an instance of an application.
  Service principals generally reference an application object, and one application object can be referenced by multiple service principals across directories.

## What are application objects and where do they come from?

You can manage [application objects](app-objects-and-service-principals.md#application-object) in the Microsoft Entra admin center through the [App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade) experience. Application objects describe the application to Microsoft Entra ID and can be considered the definition of the application, allowing the service to know how to issue tokens to the application based on its settings. The application object will only exist in its home directory, even if it's a multi-tenant application supporting service principals in other directories. The application object may include (but not limited to) any of the following:

- Name, logo, and publisher
- Redirect URIs
- Secrets (symmetric and/or asymmetric keys used to authenticate the application)
- API dependencies (OAuth)
- Published APIs/resources/scopes (OAuth)
- App roles
- Single sign-on (SSO) metadata and configuration
- User provisioning metadata and configuration
- Proxy metadata and configuration

Application objects can be created through multiple pathways, including:

- Application registrations in the Microsoft Entra admin center
- Creating a new application using Visual Studio and configuring it to use Microsoft Entra authentication
- When an admin adds an application from the app gallery (which will also create a service principal)
- Using the Microsoft Graph API or PowerShell to create a new application
- Many others including various developer experiences in Azure and in API explorer experiences across developer centers

## What are service principals and where do they come from?

You can manage [service principals](app-objects-and-service-principals.md#service-principal-object) in the Microsoft Entra admin center through the [Enterprise Applications](https://entra.microsoft.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps/menuId/) experience. Service principals are what govern an application connecting to Microsoft Entra ID and can be considered the instance of the application in your directory. For any given application, it can have at most one application object (which is registered in a "home" directory), and one or more service principal objects representing instances of the application in every directory in which it acts.

The service principal can include:

- A reference back to an application object through the application ID property
- Records of local user and group application-role assignments
- Records of local user and admin permissions granted to the application
  - For example: permission for the application to access a particular user's email
- Records of local policies including Conditional Access policy
- Records of alternate local settings for an application
  - Claims transformation rules
  - Attribute mappings (User provisioning)
  - Directory-specific app roles (if the application supports custom roles)
  - Directory-specific name or logo

Like application objects, service principals can also be created through multiple pathways including:

- When users sign in to a third-party application integrated with Microsoft Entra ID
  - During sign-in, users are asked to give permission to the application to access their profile and other permissions. The first person to give consent causes a service principal that represents the application to be added to the directory.
- When users sign in to Microsoft online services like Microsoft 365.
  - When you subscribe to Microsoft 365 or begin a trial, one or more service principals are created in the directory representing the various services that are used to deliver all of the functionality associated with Microsoft 365.
  - Some Microsoft 365 services like SharePoint create service principals on an ongoing basis to allow secure communication between components including workflows.
- When an admin adds an application from the app gallery (this will also create an underlying app object)
- Add an application to use the [Microsoft Entra application proxy](/entra/identity/app-proxy)
- Connect an application for SSO using SAML or password SSO
- Programmatically via the Microsoft Graph API or PowerShell

## How are application objects and service principals related to each other?

An application has one application object in its home directory that is referenced by one or more service principals in each of the directories where it operates (including the application's home directory).

![Shows relationship between app objects and service principals][apps_service_principals_directory]

In the preceding diagram, Microsoft maintains two directories internally (shown on the left) that it uses to publish applications:

- One for Microsoft Apps (Microsoft services directory)
- One for pre-integrated third-party applications (App gallery directory)

Application publishers/vendors who integrate with Microsoft Entra ID are required to have a publishing directory (shown on the right as "Some software as a service (SaaS) Directory").

Applications that you add yourself (represented as **App (yours)** in the diagram) include:

- Apps you developed (integrated with Microsoft Entra ID)
- Apps you connected for SSO
- Apps you published using the Microsoft Entra application proxy

### Notes and exceptions

- Not all service principals point back to an application object. When Microsoft Entra ID was originally built the services provided to applications were more limited, and the service principal was sufficient for establishing an application identity. The original service principal was closer in shape to the Windows Server Active Directory service account. For this reason, it's still possible to create service principals through different pathways, such as using [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview), without first creating an application object. The Microsoft Graph API requires an application object before creating a service principal.
- Not all of the information described above is currently exposed programmatically. The following are only available in the UI:
  - Claims transformation rules
  - Attribute mappings (User provisioning)
- For more detailed information on the service principal and application objects, see the Microsoft Graph API reference documentation:
  - [Application](/graph/api/resources/application)
  - [Service Principal](/graph/api/resources/serviceprincipal)

<a name='why-do-applications-integrate-with-azure-ad'></a>

## Why do applications integrate with Microsoft Entra ID?

Applications are added to Microsoft Entra ID to use one or more of the services it provides including:

- Application authentication and authorization
- User authentication and authorization
- SSO using federation or password
- User provisioning and synchronization
- Role-based access control (RBAC) - Use the directory to define application roles to perform role-based authorization checks in an application
- OAuth authorization services - Used by Microsoft 365 and other Microsoft applications to authorize access to APIs/resources
- Application publishing and proxy - Publish an application from a private network to the internet
- Directory schema extension attributes - [Extend the schema of service principal and user objects](./schema-extensions.md) to store additional data in Microsoft Entra ID

<a name='who-has-permission-to-add-applications-to-my-azure-ad-instance'></a>

## Who has permission to add applications to my Microsoft Entra instance?

By default all users in your directory have rights to register application objects that they're developing and discretion over which applications they share/give access to their organizational data through consent. If a person is the first user in your directory to sign in to an application and grant consent, that will create a service principal in your tenant. Otherwise, the consent grant information will be stored on the existing service principal.

Allowing users to register and consent to applications might initially sound concerning, but keep the following reasons in mind:

- Applications have been able to use Windows Server Active Directory for user authentication for many years without requiring the application to be registered or recorded in the directory. Now the organization will have improved visibility to exactly how many applications are using the directory and for what purpose.
- Delegating these responsibilities to users negates the need for an admin-driven application registration and publishing process. With Active Directory Federation Services (ADFS) it was likely that an admin had to add an application as a relying party on behalf of their developers. Now developers can self-service.
- Users signing in to applications using their organization accounts for business purposes is a good thing. If they subsequently leave the organization they'll automatically lose access to their account in the application they were using.
- Having a record of what data was shared with which application is a good thing. Data is more transportable than ever and it's useful to have a clear record of who shared what data with which applications.
- API owners who use Microsoft Entra ID for OAuth decide exactly what permissions users are able to grant to applications and which permissions require an admin to agree to. Only admins can consent to larger scopes and more significant permissions, while user consent is scoped to the users' own data and capabilities.
- When a user adds or allows an application to access their data, the event can be audited so you can view the Audit Reports within the Microsoft Entra admin center to determine how an application was added to the directory.

If you still want to prevent users in your directory from registering applications and from signing in to applications without administrator approval, there are two settings that you can change to turn off those capabilities:

- To change the user consent settings in your organization, see [Configure how users consent to applications](~/identity/enterprise-apps/configure-user-consent.md).

- To prevent users from registering their own applications:
  1. In the Microsoft Entra admin center, browse to **Identity** > **Users** > **User settings**.
  2. Change **Users can register applications** to **No**.

<!--Image references-->

[apps_service_principals_directory]: ../media/entra-how-applications-are-added/HowAppsAreAddedToAAD.jpg
