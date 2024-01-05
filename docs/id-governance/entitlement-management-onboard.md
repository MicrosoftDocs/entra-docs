---
title: Onboard partners with entitlement management
description: Learn how to simplify approving access to applications and resources for onboarding partners of your organization.
services: active-directory
documentationCenter: ''
author: owinfreyatl
manager: amycolannino
editor: markwahl-msft
ms.service: active-directory
ms.workload: identity
ms.tgt_pltfrm: na
ms.topic: conceptual
ms.subservice: compliance
ms.date: 01/04/2023
ms.author: owinfrey
ms.reviewer: mwahl
ms.collection: M365-identity-device-management


#Customer intent: As an administrator, I want to simplify onboarding partners to resources using access governance features.

---

# Onboard partners with entitlement management

Partner onboarding processes often involve collecting information about the partner to guide decisions about whether to grant access, or how to set up their account properly for the apps and resources they use. For example, before granting a partner access to a particular team, you might want them to share their role in their organization, so the approver knows whether the team is right for them. You could need to set the location attribute for partner guests, the same way you do with employees, because they're using a specific application.

In the past, companies built custom forms to gather this information before setting up partner guests and granting access, but those forms were expensive to build and hard to maintain. Entitlement management’s built-in capabilities automatically provide your approvers and apps with the information they need. This article walks you through how these features can be used to onboard a partner to your organization.

## Onboarding features

You're able to simplify the onboarding of partners to your organization using entitlement management by utilizing the following features:

- [Configure custom questions](entitlement-management-onboard.md#configure-custom-questions)
- [Specify built-in attributes](entitlement-management-onboard.md#specify-built-in-attributes)

The following sections show you how these features help you achieve this goal.

## Configure custom questions

The custom questions feature for access packages in entitlement management allows an access package creator to configure questions that the reviewer answers as part of the request process. This allows reviewers to quickly approve, or reject, requests to resources.

:::image type="content" source="media/entitlement-management-onboard/requestor-information-question.png" alt-text="Screenshot of setting requestor information question in access package.":::

This feature supports different types of questions that includes free form text or multiple choice, which can be localized for partners in different locales.

For a step by step guide on this process, see: [Add requestor information to an access package](entitlement-management-access-package-create.md#create-request-policies).

## Specify built-in attributes

When a partner completes a request, you're able to save partner information for later use. This can be done by specifying that built in, or custom attributes, persist on the requestor’s user object itself. This attribute collection feature is useful if an app requires the information to function properly, such as with an inventory app that needs the user’s region.

Configuring attributes is a similar experience as configuring custom questions, but it's surfaced on resources in the catalog rather than on individual access packages.

:::image type="content" source="media/entitlement-management-onboard/specify-attributes.png" alt-text="Screenshot of specifying attribute that persists on user object.":::

When an access package includes a resource configured for attribute collection, the partner is automatically asked for those values in addition to any custom questions specified for the access package itself. The information supplied for these attributes is also presented to the approver and is written into the requestor’s User object  if the request is approved.

For a step by step guide on this process, see: [Add resource attributes in the catalog](entitlement-management-catalog-create.md#add-resource-attributes-in-the-catalog).

## Next steps

- [Create an access package in entitlement management](entitlement-management-access-package-create.md)
