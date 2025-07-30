---
title: Transitioning to Microsoft Entra External ID for CIAM
description: 'Transition to Microsoft Entra External ID for CIAM: Learn how to migrate your legacy customer identity solutions to enhance security, compliance, and scalability.'
ms.author: joflore
author: MicrosoftGuyJFlo
ms.date: 07/30/2025
ms.topic: conceptual
ms.collection:
  - migration
  - aws-to-azure
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:07/07/2025
  - ai-gen-description
---
# Plan and execute a migration to Microsoft Entra External ID

Developers building applications often control authentication and authorization for customers accessing their applications. They use customer identity access management (CIAM) solutions to avoid building and maintaining a full identity and access management (IAM) solution. Microsoft Entra External ID lets developers connect their applications to a customer-focused version of Microsoft Entra ID, a standard IAM solution. This guide gives a migration path and resources for developers and identity teams.

## What is Microsoft Entra External ID

For organizations and businesses that want to make their apps available to consumers and business customers, [Microsoft Entra External ID](overview-customers-ciam.md) lets you add CIAM features such as self-service registration, personalized sign-in experiences, and customer account management. Because these CIAM capabilities are built into Microsoft Entra ID, you benefit from platform features like enhanced security, compliance, and scalability.

## Why migrate from other CIAM solutions

Organizations might migrate to Microsoft Entra External ID from another tool based on strategic goals such as:

- Consolidate cloud identity providers
- Align with an existing enterprise identity solution
- Enhance security and compliance
- Access to [strong developer guidance and an active community](https://developer.microsoft.com/identity/external-id)
- [Feature availability](concept-supported-features-customers.md#general-feature-comparison)
- [Reduce costs](https://azure.microsoft.com/pricing/details/microsoft-entra-external-id )

## Plan your migration

The [Microsoft Entra External ID deployment guide](/entra/architecture/deployment-external-intro) helps organizations get started with their deployment if they're new to the concept of a CIAM solution. Following that along with the steps outlined in this article help organizations with existing CIAM deployments complete their migration to Microsoft Entra External ID. Organizations start by [determining if there are any feature gaps between products](concept-supported-features-customers.md#general-feature-comparison) that might block their migration.

### Migration steps

This guide helps you migrate legacy customer identity access management (CIAM) solutions to Microsoft Entra External ID. Follow this series of articles to navigate the steps in the migration process.

| Stage | Steps |
| --- | --- |
| Premigration planning | &#8226; Map legacy CIAM features to [Microsoft Entra External ID capabilities](overview-customers-ciam.md). </br>&#8226; Complete an [inventory of the existing CIAM solution](#inventory). |
| Microsoft Entra External ID setup | &#8226; [Create an external tenant](how-to-create-external-tenant-portal.md). </br>&#8226; [Add and manage admin accounts](how-to-manage-admin-accounts.md). </br>&#8226; [Enable other identity providers](concept-authentication-methods-customers.md). </br>&#8226; [Register all customer-facing applications](/entra/identity-platform/quickstart-register-app). </br>&#8226; [Add an application to the user flow](how-to-user-flow-add-application.md). </br>&#8226; [Test the user flow](how-to-test-user-flows.md).|
| Identity flows and branding | &#8226; [Add a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md) </br>&#8226; [Add an application to the user flow](how-to-user-flow-add-application.md) </br>&#8226; [Manage access](how-to-use-app-roles-customers.md) </br>&#8226; [Test the user flow](how-to-test-user-flows.md)  </br>&#8226; [Customize branding](how-to-customize-branding-customers.md) |
| Security and monitoring | &#8226; [Configure MFA](how-to-multifactor-authentication-customers.md) </br>&#8226; [Create dashboards](how-to-user-insights.md) </br>&#8226; [Set up Azure Monitor](how-to-azure-monitor.md) |
| Test and rollout | &#8226; Define your rollout strategy. </br>&#8226; Import the final batch of users if needed using the [Microsoft Graph API](/graph/api/user-post-users). </br>&#8226; Cut over live traffic to Microsoft Entra External ID. </br>&#8226; Monitor live authentication logs and error rates. </br>&#8226; Collect feedback. </br>&#8226; Decommission legacy solution. |

### Inventory

Take inventory of the existing configuration and architecture, including:

- Users
- Access and security groups
- Connected applications
- Sign-up and sign-in user flows
- Multifactor authentication mechanisms
- Social identity providers
- Any specific compliance or regulatory requirements

At this phase, determine if user data transformation is required, then complete [transformation and mapping](concept-user-attributes.md).

## Related content

- Learn more in [developer resources](https://developer.microsoft.com/identity/external-id)
- Review the [Microsoft Entra External ID deployment guide](/entra/architecture/deployment-external-intro)
- [Integrate authentication into your consumer and business customer applications](visual-studio-code-extension.md)
- [Compare AWS and Azure identity management solutions](/azure/architecture/aws-professional/security-identity)
- [Build a sample app to evaluate Microsoft Entra External ID](/training/entra-external-identities/)
