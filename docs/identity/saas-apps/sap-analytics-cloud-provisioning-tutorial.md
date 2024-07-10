---
title: 'Tutorial: Configure SAP Analytics Cloud for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to SAP Analytics Cloud.

author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to SAP Analytics Cloud so that I can streamline the user management process and ensure that users have the appropriate access to SAP Analytics Cloud.
---

# Tutorial: Configure SAP Analytics Cloud for automatic user provisioning

This tutorial describes the steps you need to perform in SAP Cloud Identity Services, SAP Analytics Cloud, and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to [SAP Analytics Cloud](https://www.sapanalytics.cloud/) using the Microsoft Entra provisioning service and SAP Cloud Identity Services. For important details on what Microsoft Entra provisioning does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 

## Capabilities supported
> [!div class="checklist"]
> * Create users in SAP Analytics Cloud to enable [single sign-on](sapboc-tutorial.md) to SAP Analytics Cloud
> * Remove users in SAP Analytics Cloud when they do not require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and SAP Analytics Cloud

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* An SAP Analytics Cloud and SAP Cloud Identity Services tenant
* A user account on SAP Identity Provisioning admin console with Admin permissions. Make sure you have access to the proxy systems in the Identity Provisioning admin console. If you don't see the **Proxy Systems** tile, create an incident for component **BC-IAM-IPS** to request access to this tile.
* An OAuth client with authorization grant Client Credentials in SAP Analytics Cloud. For more information, see [Managing OAuth Clients and Trusted Identity Providers](https://help.sap.com/viewer/00f68c2e08b941f081002fd3691d86a7/release/en-US/4f43b54398fc4acaa5efa32badfe3df6.html)

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can follow the steps in this article and configure it in the same way as you do from public cloud.


## Step 1: Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and SAP Analytics Cloud](~/identity/app-provisioning/customize-application-attributes.md). 

## Step 2: Configure SAP Analytics Cloud to support SSO with Microsoft Entra ID

To configure single sign-on (SSO), follow the instructions in the [SAP Cloud Analytics SSO tutorial](sapboc-tutorial.md).


<a name='step-3-create-microsoft-entra-id-groups-for-your-sap-business-roles'></a>

## Step 3: Configure user and group provisioning

First, create Microsoft Entra groups for your SAP business roles used in SAP Analytics Cloud.

Then, in SAP Cloud Identity Services provisioning, [configure Microsoft Entra ID as a source](https://help.sap.com/docs/identity-provisioning/identity-provisioning/microsoft-azure-active-directory) to bring users and groups from Microsoft Entra ID to SAP Cloud Identity Services and map the created groups to your SAP business roles. For more information, see [provision users from Microsoft Azure AD to SAP Cloud Identity Services - Identity Authentication](https://blogs.sap.com/2022/02/04/provision-users-from-microsoft-azure-ad-to-sap-cloud-identity-services-identity-authentication/).

Select the users who need access to SAP Analytics Cloud. Give them app role assignments to the application used for SSO configured at step 2, and also assign them as members of the Microsoft Entra groups.

> [!NOTE]
> Start small. Test with a small set of users and groups before rolling out to everyone. Check the users have the right access in SAP downstream targets and when they sign in, they have the right roles.

## Next steps

* [Configure SAP Cloud Identity Services for automatic user provisioning with Microsoft Entra ID](sap-cloud-platform-identity-authentication-provisioning-tutorial.md)
