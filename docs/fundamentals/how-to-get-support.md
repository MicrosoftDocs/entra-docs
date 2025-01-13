---
title: Find help and get support for Microsoft Entra ID
description: Instructions about how to get help and open a support request for Microsoft Entra ID.
author: shlipsey3
manager: amycolannino
ms.service: entra
ms.topic: troubleshooting
ms.subservice: fundamentals
ms.date: 01/05/2024
ms.author: sarahlipsey
ms.reviewer: jeffsta
---

# Find help and get support for Microsoft Entra ID

Microsoft documentation and learning content provide quality support and troubleshooting information, but if you have a problem not covered in our content, there are several options to get help and support for Microsoft Entra ID.

This article provides the options to find support from the Microsoft community and how to submit a support request with Microsoft.

## Ask the Microsoft community

Start with our Microsoft community members who might have an answer to your question. These communities provide support, feedback, and general discussions on Microsoft products and services. Before creating a support request, check out the following resources for answers and information.

- For how-to information, quickstarts, or code samples for IT professionals and developers, see the [technical documentation at learn.microsoft.com](../index.yml).
- Post a question to [Microsoft Q&A](/answers/products/) to get answers to your identity and access questions directly from Microsoft engineers, Most Valuable Professionals (MVPs), and other members of our expert community.
- The [Microsoft Technical Community](https://techcommunity.microsoft.com/) is the place for our IT pro partners and customers to collaborate, share, and learn. Join the community to post questions and submit your ideas.
- The [Microsoft Technical Community Info Center](https://techcommunity.microsoft.com/t5/Community-Info-Center/ct-p/Community-Info-Center) is used for announcements, blog posts, ask-me-anything (AMA) interactions with experts, and more.
- The [Microsoft Developer Program](https://developer.microsoft.com/microsoft-365/dev-program) enables you to be your own administrator and prototype apps and solutions on your fully pre-provisioned sandbox subscription.

### Microsoft Q&A best practices

[Microsoft Q&A](/answers/products/) is Microsoft's recommended source for community support. From the Q&A home page, choose one of the following tabs:

- *Questions:* The main page for technical questions and answers at Microsoft.
- *Tags:* Use tags, which are keywords that categorize your question with other similar questions.
- *Help:* Get answers to frequently asked questions, troubleshoot common issues, and discover features related to Microsoft Q&A.

To ask a question, choose the **Ask a question** button at the top right of any Q&A page. You can also get your questions answered faster by using [AI Assist](https://aka.ms/learn-more-ai).

When asking a question, we recommend you follow these best practices:

- View the *Questions* and *Tags* pages first to search for product and service-related keywords, as you might find a solution that has already been posted. Consider using the filter option to narrow the search results.
- Submit your questions in the language of the Q&A site you are on. This helps ensure that our community of experts can provide accurate and helpful answers to your question.
- Use tags when posting a question. You can select up to 5 tags to describe your question. Choose tags that relate most closely to your scenario. This is important for discoverability of your question among the community experts on Q&A.
- Be sure to include all the details of your issue in the **Question details** field. Start by asking *one* question in the body to ensure the highest quality answers. Next, be sure to include the following details in your request:
   - A summary of what you are attempting to accomplish
   - Any steps that you've already been taken
   - Any relevant error messages
   - Unique aspects of your scenario or configuration
   - Any other pertinent information

For learn more, see [Tips for writing quality questions](/answers/support/quality-question).

## Open a support request

If you're unable to find answers by using the previously mentioned resources, you can open an online support request. You should open a support request for only a single problem, so that we can connect you to the support engineers who are subject matter experts for your problem. Microsoft Entra engineering teams prioritize their work based on incidents that are generated from support, so you're often contributing to service improvements.

Support is available online and by phone for Microsoft paid and trial subscriptions on global technical, pre-sales, billing, and subscription issues. Phone support and online billing support are available in additional languages.

Explore the range of [support options and choose the plan](https://azure.microsoft.com/support/plans) that best fits your scenario, whether you're an IT admin managing your organization's tenant, a developer just starting your cloud journey, or a large organization deploying business-critical, strategic applications. Microsoft customers can create and manage support requests in the Azure portal and the Microsoft Entra admin center.

> [!NOTE]
>
> - If you're using Microsoft Entra External ID in an external tenant, the support request feature is currently unavailable for external tenant technical issues. Instead, use the **Give Feedback** link on the **New support request** page. Or, switch to your Microsoft Entra workforce tenant and [open a support request](https://entra.microsoft.com/#view/Microsoft_Azure_Support/NewSupportRequestV3Blade/callerName/ActiveDirectory/issueType/technical).
> - If you're using Azure AD B2C, open a support ticket by first switching to a Microsoft Entra tenant that has an Azure subscription associated with it. Typically, this is your employee tenant or the default tenant created for you when you signed up for an Azure subscription. To learn more, see [how an Azure subscription is related to Microsoft Entra ID](./how-subscriptions-associated-directory.yml).

### To open a support request in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Service Support Administrator](~/identity/role-based-access-control/permissions-reference.md#service-support-administrator).

1. Browse to **Learn & support** > **New support request**.

1. Follow the prompts to provide us with information about the problem you're having.

Next, we'll walk you through some steps to gather information about your problem and help you solve it. Each step is described in the following sections.

### 1. Problem description

1. Select an **Issue type**.

   Options include **Billing**, **Service and subscription limits**, **Subscription management**, and **Technical**.

1. Select a **Subscription type**.

   If you don't see a subscription in the dropdown list, go to **Directory + subscription settings**, and select the subscription from the dropdown list.

1. Depending on the *Issue type* that you selected, you will be prompted to provide more details about the initial request.

   - For *Billing* and *Subscription management* issues, the **Summary** and **Problem type** fields appear.
   - For *Service and subscription limits*, the **Quota type** field appears.
   - For *Technical* issues, the **Service type** field appears.

1. When you're done, select **Next** at the bottom of the page to continue.

### 2. Recommended solution

Based on the information you provided, you'll be given recommended solutions that you can use try to resolve the problem. Solutions are written by Azure engineers and should resolve most common problems.

If you're still unable to resolve the issue, select **Next** to continue creating the support request.

### 3. Additional details

Next, we collect more details about the problem. Providing thorough and detailed information in this step helps us route your support request to the right engineer.

1. Complete the **Problem details** section so that we have more information about your issue. If possible, tell us when the problem started and any steps to reproduce it. You can upload a file, such as a log file or output from diagnostics. For more information on file uploads, see [File upload guidelines](/azure/azure-portal/supportability/how-to-manage-azure-support-request#file-upload-guidelines).

1. In the **Advanced diagnostic information** section, select **Yes** or **No**.

    - Selecting **Yes** allows support to gather [advanced diagnostic information](https://azure.microsoft.com/support/legal/support-diagnostic-information-collection/) from the subscriptions associated with your request.
    - If you prefer not to share this information, select **No**. For more information about the types of files we might collect, see [Advanced diagnostic information logs](/azure/azure-portal/supportability/how-to-create-azure-support-request#advanced-diagnostic-information-logs) section.
    - In some scenarios, an administrator in your tenant might need to approve Microsoft Support access to your Microsoft Entra identity data.

1. In the **Support method** section, select your preferred contact method and support language.
    - Some details are pre-selected for you.
    - The support plan and severity are populated based on your plan.
    - The maximum severity level depends on your [support plan](https://azure.microsoft.com/support/plans).

1. Next, complete the **Contact info** section so we know how to contact you.

Select **Next** when you've completed all of the necessary information.

### 4. Review + create

Before you create your request, review all of the details that you'll send to support. You can select **Previous** to return to any tab if you need to make changes. When you're satisfied the support request is complete, select **Create**.

A support engineer will contact you using the method you indicated. For information about initial response times, see [Support scope and responsiveness](https://azure.microsoft.com/support/plans/response/).

### Other options for creating a support request

If you already have an Azure Support plan, [open a support request here](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest).

If you're not an Azure customer, you can open a support request with [Microsoft Support for business](https://support.serviceshub.microsoft.com/supportforbusiness).

## Get Microsoft 365 admin center support

Support for Microsoft Entra ID in the [Microsoft 365 admin center](https://admin.microsoft.com) is offered for administrators through the admin center. Review the [support for Microsoft 365 for business article](/microsoft-365/admin/).

## Stay informed

Things can change quickly. The following resources provide updates and information on the latest releases.

- [What's new in Microsoft Entra ID](whats-new.md): Get to know what's new in Microsoft Entra ID including the latest release notes, known issues, bug fixes, deprecated functionality, and upcoming changes.
- [Microsoft Entra identity blog](https://techcommunity.microsoft.com/t5/azure-active-directory-identity/bg-p/Identity): Get news and information about Microsoft Entra ID.
- [Azure updates](https://azure.microsoft.com/updates/?category=identity): Learn about important product updates, roadmap, and announcements.

## Next steps

- [Post a question to Microsoft Q&A](/answers/products/)
- [Join the Microsoft Technical Community](https://techcommunity.microsoft.com/)
- Learn about the [diagnostic data Azure identity support can access](https://azure.microsoft.com/support/legal/support-diagnostic-information-collection/)
