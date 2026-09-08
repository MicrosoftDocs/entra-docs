---
title: Publish your app to Microsoft Entra App Gallery
description: Learn how to publish a validated app to Microsoft Entra App Gallery.
author: HildaK-pm
manager: msteele
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: tutorial
ms.date: 08/24/2026
ms.author: hkinyunyu
ms.reviewer: hkinyunyu
ms.custom: enterprise-apps-article, msecd-doc-authoring-1013
ai-usage: ai-assisted
---

# Publish your app to Microsoft Entra App Gallery

After validating your application's supported identity integrations, use the self-service publishing experience to submit the application for publication in the Microsoft Entra App Gallery.

The publishing experience enables independent software vendors (ISVs) to:
- Create and manage a Gallery submission.
- Select the capabilities to include in the Gallery listing.
- Associate the applicable validation results with the submission.
- Provide application and publisher information.
- Upload customer-facing documentation and application logos.
- Submit the application for Microsoft review.
- Track the submission and respond to feedback.

> [!IMPORTANT]
> Self-service validation and self-service publishing are separate experiences. Before submitting an application for publication, complete the applicable validation for every identity capability that you want to include in the Gallery listing.

## Before you begin

Before starting the publishing process, make sure that you have:

- Completed the applicable SAML, OpenID Connect, or user provisioning validation.
- A passed Test result from validating your app.
- A Partner One ID (formerly Microsoft Partner Network (MPN) ID) associated with your organization.
- A Microsoft Entra tenant.
- Customer-facing configuration documentation.
- The required application logos.
- Accurate application, privacy, terms-of-use, and customer support information.
- An application that is ready for customer use.

If your application supports both single sign-on and user provisioning, complete the validation requirements for both capabilities.

> [!IMPORTANT]
> The validation results must represent the integration that you intend to publish. If you materially change the integration after validation, repeat the applicable validation before submitting your application.

## Access the publishing experience

You can access the self-service publishing experience in three ways.

### Option 1: From the Microsoft Entra App Gallery

Use this option to start from the Gallery browsing experience.

1. Sign in to the Microsoft Entra admin center.
2. Browse to **Identity** > **Applications** > **Enterprise applications**.
3. Select **Browse Microsoft Entra App Gallery**.
4. Select **Publish your application to gallery**.

### Option 2: When creating an enterprise application

Use this option when you start from the enterprise applications area.

1. Sign in to the Microsoft Entra admin center.
2. Browse to **Identity** > **Applications** > **Enterprise applications**.
3. Select **New application**.
4. In the Microsoft Entra App Gallery, select **Publish your application to gallery**.

### Option 3: Resume an existing draft submission

Use this option if you previously created and saved a Gallery submission.

1. Open the self-service publishing experience.
2. Select **Your published applications**.
3. Select the draft application.
4. Continue the submission.

## Create a Gallery submission

To create a submission:

1. Open the self-service publishing experience.
2. Enter your application name.
3. Enter your Microsoft Partner Network ID.
4. Save the submission.

When you save the submission, the publishing experience creates a Submission ID.

> [!IMPORTANT]
> Keep your Submission ID available. It identifies your Gallery submission and is used throughout the publishing process. Include it when contacting support or providing feedback.

Creating a submission doesn't publish the application. The application remains in Draft status until you complete the requirements and submit it for Microsoft review.

## Select the capabilities to publish

Choose the identity capabilities that you want to include in the Gallery listing.

The available options are:

- Single Sign-On
- Single Sign-On + User Provisioning

If your application supports single sign-on and user provisioning, select **Single Sign-On + User Provisioning**.

Only include capabilities that:

- Have been implemented and tested.
- Have completed the applicable self-service validation.
- Are documented for customers.
- Are ready for customer use.

## Provide validation results

The publishing experience uses results from the applicable self-service validations to confirm the readiness of the capabilities included in your submission.

### Single sign-on

If your submission includes single sign-on:

1. Associate the applicable SAML or OIDC validation results with the Gallery submission.
2. Confirm that the validated configuration represents the integration you intend to publish.
3. Resolve any blocking issues displayed in the publishing experience.

For instructions, see:
- [Validate an OIDC multitenant application for the Microsoft Entra App Gallery](validate-oidc-multitenant-app-gallery.md)
- [Validate SAML single sign-on for the Microsoft Entra App Gallery](validate-saml-single-sign-on-app-gallery.md)

### User provisioning

If your submission includes user provisioning:

1. Provide the requested developer tenant information.
2. Confirm that the publishing experience displays the applicable provisioning validation results.
3. Resolve any blocking issues displayed in the publishing experience.

For validation instructions, see [Validate user provisioning for Microsoft Entra App Gallery](validate-user-provisioning-app-gallery.md).

If the application supports single sign-on and user provisioning, provide the required validation results for both capabilities. The publishing experience retrieves and displays provisioning validation results during review.

## Review and complete application information

The publishing experience prefills some application and publisher information from:

- Information associated with your Microsoft Partner Network ID.
- Application information and results from completed self-service validations.

Review the prefilled information and complete any remaining required fields. This information can include application and publisher details, supported capabilities, application URLs, privacy and terms-of-use information, and customer support information.

If prefilled information is incorrect or outdated, update it where the publishing experience allows. If it comes from your Partner profile or validation results and can't be edited, correct it at the source before continuing.

> [!IMPORTANT]
> Make sure that the prefilled validation information corresponds to the integration you intend to publish. If the integration changed materially after validation, complete the applicable validation again.
>
> Don't include credentials, secrets, private tenant information, or internal-only instructions.

## Prepare and upload application documentation

Review the prefilled information and complete any remaining required fields. This information can include application and publisher details, supported capabilities, application URLs, privacy and terms-of-use information, and customer support information.

If prefilled information is incorrect or outdated, update it where the publishing experience allows. If it comes from your Partner profile or validation results and can't be edited, correct it at the source before continuing.

> [!IMPORTANT]
> Make sure that the prefilled validation information corresponds to the integration you intend to publish. If the integration changed materially after validation, complete the applicable validation again.
>
> Don't include credentials, secrets, private tenant information, or internal-only instructions.

## Upload application logos

Upload the required application logos in PNG format.

Provide:

- A square application logo that is 215 by 215 pixels.
- A rectangular application logo that is 150 by 122 pixels.

Make sure that each logo:

- Has a transparent background.
- Doesn't have a white background.
- Uses a high-quality source image.
- Has the required dimensions.
- Clearly represents the application.

Preview the logos and verify that they display correctly.

## Review and submit your application

Before submitting the application, confirm that:

- The application and publisher information is accurate.
- The correct capabilities are selected.
- The applicable validation results are present and represent the integrations being published.
- Customer-facing documentation has been approved.
- The required application logos have been uploaded.
- All required fields are complete.
- All blocking issues are resolved.

Open the submission summary, accept the applicable terms and conditions, and select **Submit**.

After submission, the application moves from Draft to Submitted and enters the Microsoft Entra App Gallery publishing workflow.

> [!NOTE]
> Submitting the application doesn't make it immediately available in the Gallery. Microsoft reviews the application before publication.

## Publishing workflow

A submission progresses through the following states:

1. **Draft** - You create and prepare your submission.
1. **Under Review** - Microsoft validates the submission, configuration, and required information.
1. **Approved** - The submission has successfully passed validation.
1. **In Preview** - The integration is available as a preview offering in the Microsoft Entra App Gallery.
1. **Published** - The integration is publicly available in the Microsoft Entra App Gallery.

> [!NOTE]
> Publishing timelines are measured in business days. Actual processing times can vary depending on submission completeness, validation outcomes, and whether additional information is required from the publisher.

### Timeline example

The following example shows a typical progression through the publishing process:

- A submission enters **Under Review** and is reviewed within **5 business days**.
- After approval, the integration can become available in **Preview** within **10 business days**.
- Once all publishing requirements are met, the integration can become **Publicly available** within **7 business days**.

> [!TIP]
> To help avoid delays, ensure that all required metadata, testing information, and validation requirements are completed before submitting your integration for review.

## Track your submission

To monitor the application and review feedback:

1. Open the self-service publishing experience.
2. Select **Your published applications**.
3. Select the application.
4. Review its status and any required actions.

If Microsoft requests changes, update the affected application information, documentation, logos, or integration. Repeat validation if the integration changed, and resubmit the affected content for review.

Include the Submission ID when contacting Microsoft about the submission.

## After publication

After Microsoft publishes the application, customers can discover it in the Microsoft Entra App Gallery and configure its supported identity capabilities.

To change the Gallery configuration or customer setup experience after publication, use the process for updating an existing application.

## Update or remove an existing application

The self-service publishing experience described in this article applies to new application submissions.

To change an application that is already published, see [Update an existing Microsoft Entra App Gallery application](update-or-remove-app-gallery.md).

To request removal of an existing application, see [Remove an application from the Microsoft Entra App Gallery](update-or-remove-app-gallery.md).

> [!IMPORTANT]
> Don't create a duplicate submission to replace an existing Gallery listing unless Microsoft directs you to do so.

## Get help

If you encounter an issue during publishing, use the Microsoft Entra App Gallery Self-Service Publishing Feedback form.

When requesting help, provide:

- The application name.
- The Submission ID.
- The capabilities included in the submission.
- The step where the issue occurred.
- The expected and actual results.
- Relevant error messages.
- Screenshots that don't expose credentials, secrets, or personal information.

