---
title: Prerequisites to validate and publish your app
description: Review the shared prerequisites for validating and publishing an application in Microsoft Entra App Gallery.
ms.topic: how-to
ms.date: 09/02/2026
ms.reviewer: hkinyunyu
ms.custom: kr2b-contr-experiment, enterprise-apps-article
ai-usage: ai-assisted

# Customer intent: As a developer, I want to understand the prerequisites for submitting my application to Microsoft Entra App Gallery so that customers can add it to their tenants.
---

# Prerequisites to validate and publish your app

Microsoft Entra App Gallery is a catalog of thousands of applications. When Microsoft publishes your application in the gallery, customers can discover it and add it to their tenants. For more information, see [Overview of Microsoft Entra App Gallery](overview-application-gallery.md).

Before you validate your application, review the shared prerequisites and the requirements for each capability that you plan to publish.

## Choose the capabilities to publish

Review the requirements that apply to your application:

- For Security Assertion Markup Language (SAML) or OpenID Connect (OIDC) integration, see [SSO requirements for Microsoft Entra App Gallery](app-gallery-sso-requirements.md).
- For System for Cross-Domain Identity Management (SCIM) integration, see [User provisioning requirements for Microsoft Entra App Gallery](app-gallery-user-provisioning-requirements.md).

If your application supports both SSO and user provisioning, complete the requirements and validation for both capabilities.

## Shared prerequisites

Before you submit an application, complete these prerequisites:

- Read and agree to the [Microsoft Entra App Gallery terms and conditions](https://azure.microsoft.com/support/legal/active-directory-app-gallery-terms/).
- Prepare a production-ready application that customers can access.
- Establish engineering and support contacts for onboarding and post-onboarding support.
- Prepare public customer documentation for each capability that you plan to publish.
- Create a test tenant and test accounts. You can join the [Microsoft 365 Developer Program](/office/developer-program/microsoft-365-developer-program) to get a renewable development subscription with Microsoft Entra features.
- [Associate your organization with the Microsoft AI Cloud Partner Program](https://partner.microsoft.com/en-US/partnership).
- Provide a **Partner One ID (formerly Microsoft Partner Network (MPN) ID)** associated with your organization. This identifier is used during the Microsoft Entra App Gallery onboarding and publishing process.

## Partner One ID

A Partner One ID identifies your organization in the Microsoft AI Cloud Partner Program. Provide the Partner One ID associated with the organization that will be listed as the application's publisher in Microsoft Entra App Gallery.

> [!NOTE]
> If you don't know your Partner One ID, contact your organization's Microsoft AI Cloud Partner Program administrator. For information about Partner One IDs and partner accounts, see [Partner Center documentation](/partner-center/).

## Prepare customer documentation

Clear documentation helps customers configure and support your integration. Include the following information:

- Supported capabilities, protocols, versions, and SKUs.
- Licensing requirements.
- Roles required to configure the integration.
- Configuration and testing steps.
- Troubleshooting information, including error codes and messages.
- Support options.

The SSO and user provisioning requirement articles describe the capability-specific information to include.

## Publish your application

After your application meets the applicable requirements and passes validation, see [Publish your app to Microsoft Entra App Gallery](publish-app-gallery.md).

## Next steps

- [Review SSO requirements for Microsoft Entra App Gallery](app-gallery-sso-requirements.md).
- [Review user provisioning requirements for Microsoft Entra App Gallery](app-gallery-user-provisioning-requirements.md).
- [Plan a single sign-on deployment](plan-sso-deployment.md).
