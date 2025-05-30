---
title: Onboard external users with entitlement management
description: Learn how to simplify approving access to applications and resources for onboarding external users to your organization.
author: owinfreyatl
manager: femila
editor: markwahl-msft
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: conceptual
ms.date: 07/15/2024
ms.author: owinfrey
ms.reviewer: mwahl
#Customer intent: As an administrator, I want to simplify onboarding external users to resources using access governance features.
---

# Onboard external users with entitlement management

External user onboarding processes often involve collecting information about the users to guide decisions about whether to grant access, or how to set up their account properly for the apps and resources they use. For example, before granting an external user access to a particular team, you might want them to share their role in their organization, so the approver knows whether the team is right for them. You could need to set the location attribute for external users, the same way you do with employees, because they're using a specific application.

In the past, companies built custom forms to gather this information before setting up external users and granting access. These custom forms often were expensive to build, and hard to maintain. Entitlement management’s features automatically provide your approvers and apps with the information they need. This article walks you through how these features can be used to onboard an external user to your organization.

## Onboarding features

You're able to simplify the onboarding of external users to your organization using entitlement management by utilizing the following features:

- [Configure custom questions](entitlement-management-onboard.md#configure-custom-questions)
- [Verified IDs](entitlement-management-onboard.md#verified-ids)
- [Specify attributes](entitlement-management-onboard.md#specify-attributes)

The following sections show you how these features help you achieve this goal.

## Configure custom questions

The custom questions feature for access packages in entitlement management allows an access package creator to configure questions that the reviewer answers as part of the request process. These questions are useful in situations where the answers can be different on each request, such as a business justification an external user would have for requiring access to the specific access package. They're held on the request object, but are only available to applications that use MS Graph to query the request object. This feature allows reviewers to quickly approve, or reject, requests to resources.

:::image type="content" source="media/entitlement-management-onboard/requestor-information-question.png" alt-text="Screenshot of setting requestor information question in access package." lightbox="media/entitlement-management-onboard/requestor-information-question.png":::

This feature supports different types of questions that includes free form text or multiple choice, which can be localized for external users in different locales.

For a step by step guide on this process, see: [Add requestor information to an access package](entitlement-management-access-package-create.md#create-the-initial-policy).

## Verified IDs

The custom questions feature allows a requestor to answer questions during the request process for an access package, but you could require an extra layer of security before allowing the external user to access apps within the access package. With the verified IDs feature, you can require that requestors present a verified ID containing credentials from a trusted issuer. This feature allows an approver to quickly view if the external user’s verifiable credentials were validated when the user presented their credentials within their access package request.

:::image type="content" source="media/entitlement-management-verified-id-settings/select-issuer.png" alt-text="Screenshot showing pick issuer for Microsoft Entra Verified ID." lightbox="media/entitlement-management-verified-id-settings/select-issuer.png":::

For a step by step guide on this process, see: [Configure Verified ID settings for an access package in entitlement management](entitlement-management-verified-id-settings.md).

## Specify attributes

Your app will sometimes require an attribute that an external user doesn't have. With the specify attributes feature, you're able to save information for later use when they complete a request. For example, you could have a partner portal application that requires the external user's country code. Unlike with answers to custom questions, these answers should be expected to be permanent, and won't change with each request.

Configuring attributes is a similar experience as configuring custom questions, but it's surfaced on apps in the catalog rather than on individual access packages.

:::image type="content" source="media/entitlement-management-onboard/specify-attributes.png" alt-text="Screenshot of specifying attribute that persists on user object." lightbox="media/entitlement-management-onboard/specify-attributes.png":::

When an access package includes a resource configured for attribute collection, the external user is automatically asked for those values in addition to any custom questions specified for the access package itself. The information supplied for these attributes is also presented to the approver, and is written into the requestor’s User object if the request is approved. If your external users are only collaborating with Teams or SharePoint Online, you probably don't need attributes.

> [!NOTE]
> The specify attributes feature is cloud only as you are unable to write attributes onto on-premises synched users.

For a step by step guide on this process, see: [Add resource attributes in the catalog](entitlement-management-catalog-create.md#add-resource-attributes-in-the-catalog).

## Next steps

- [Tutorial - Onboard external users to Microsoft Entra ID through an approval process](entitlement-management-onboard-external-user.md)
- [Configure Verified ID settings for an access package in entitlement management](entitlement-management-verified-id-settings.md)
