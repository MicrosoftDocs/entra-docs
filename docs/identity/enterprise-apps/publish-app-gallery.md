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

1. Completed the applicable SAML, OpenID Connect, or user provisioning validation.
1. A passed Test result from validating your app.
1. A Microsoft Partner Network ID associated with your organization.
1. A Microsoft Entra tenant.
1. Customer-facing configuration documentation.
1. The required application logos.
1. Accurate application, privacy, terms-of-use, and customer support information.
1. An application that is ready for customer use.

If your application supports both single sign-on and user provisioning, complete the validation requirements for both capabilities.

> [!IMPORTANT]
> The validation results must represent the integration that you intend to publish. If you materially change the integration after validation, repeat the applicable validation before submitting your application.

## Access the publishing experience

You can access the self-service publishing experience in three ways.

### Option 1: From the Microsoft Entra App Gallery

Use this option to start from the Gallery browsing experience.

1. Sign in to the Microsoft Entra admin center.
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select **Browse Microsoft Entra App Gallery**.
1. Select **Publish your application to gallery**.

### Option 2: When creating an enterprise application

Use this option when you start from the enterprise applications area.

1. Sign in to the Microsoft Entra admin center.
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select **New application**.
1. In the Microsoft Entra App Gallery, select **Publish your application to gallery**.

### Option 3: Resume an existing draft submission

Use this option if you previously created and saved a Gallery submission.

1. Open the self-service publishing experience.
1. Select **Your published applications**.
1. Select the draft application.
1. Continue the submission.

## Create a Gallery submission

To create a submission:

1. Open the self-service publishing experience.
1. Enter your application name.
1. Enter your Microsoft Partner Network ID.
1. Save the submission.

When you save the submission, the publishing experience creates a Submission ID.

> [!IMPORTANT]
> Keep your Submission ID available. It identifies your Gallery submission and is used throughout the publishing process. Include it when contacting support or providing feedback.

Creating a submission doesn't publish the application. The application remains in Draft status until you complete the requirements and submit it for Microsoft review.

## Select the capabilities to publish

Choose the identity capabilities that you want to include in the Gallery listing.

The available options are:

1. Single Sign-On
1. Single Sign-On + User Provisioning

If your application supports single sign-on and user provisioning, select **Single Sign-On + User Provisioning**.

Only include capabilities that:

1. Have been implemented and tested.
1. Have completed the applicable self-service validation.
1. Are documented for customers.
1. Are ready for customer use.

## Provide validation results

The publishing experience uses results from the applicable self-service validations to confirm the readiness of the capabilities included in your submission.

### Single sign-on

If your submission includes single sign-on:

1. Associate the applicable SAML or OIDC validation results with the Gallery submission.
1. Confirm that the validated configuration represents the integration you intend to publish.
1. Resolve any blocking issues displayed in the publishing experience.

For instructions, see:
- [Validate an OIDC multitenant application for the Microsoft Entra App Gallery](validate-oidc-multitenant-app-gallery.md)
- [Validate SAML single sign-on for the Microsoft Entra App Gallery](validate-saml-single-sign-on-app-gallery.md)

### User provisioning

If your submission includes user provisioning:

1. Provide the requested developer tenant information.
1. Confirm that the publishing experience displays the applicable provisioning validation results.
1. Resolve any blocking issues displayed in the publishing experience.

For validation instructions, see Validate user provisioning for the Microsoft Entra App Gallery.

If the application supports single sign-on and user provisioning, provide the required validation results for both capabilities. The publishing experience retrieves and displays provisioning validation results during review.

## Review and complete application information

The publishing experience prefills some application and publisher information from:

1. Information associated with your Microsoft Partner Network ID.
1. Application information and results from completed self-service validations.

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

1. A square application logo that is 215 by 215 pixels.
1. A rectangular application logo that is 150 by 122 pixels.

Make sure that each logo:

1. Has a transparent background.
1. Doesn't have a white background.
1. Uses a high-quality source image.
1. Has the required dimensions.
1. Clearly represents the application.

Preview the logos and verify that they display correctly.

## Review and submit your application

Before submitting the application, confirm that:

1. The application and publisher information is accurate.
1. The correct capabilities are selected.
1. The applicable validation results are present and represent the integrations being published.
1. Customer-facing documentation has been approved.
1. The required application logos have been uploaded.
1. All required fields are complete.
1. All blocking issues are resolved.

Open the submission summary, accept the applicable terms and conditions, and select **Submit**.

After submission, the application moves from Draft to Submitted and enters the Microsoft Entra App Gallery publishing workflow.

> [!NOTE]
> Submitting the application doesn't make it immediately available in the Gallery. Microsoft reviews the application before publication.

## Track your submission

To monitor the application and review feedback:

1. Open the self-service publishing experience.
1. Select **Your published applications**.
1. Select the application.
1. Review its status and any required actions.

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

1. The application name.
1. The Submission ID.
1. The capabilities included in the submission.
1. The step where the issue occurred.
1. The expected and actual results.
1. Relevant error messages.
1. Screenshots that don't expose credentials, secrets, or personal information.

