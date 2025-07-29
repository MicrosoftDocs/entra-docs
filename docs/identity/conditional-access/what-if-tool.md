---
title: The Conditional Access What If tool
description: Simulate Conditional Access policy results with the What If tool to troubleshoot and optimize your environment.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 04/28/2025
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: kvenkit
ms.custom: sfi-image-nochange
---
# Troubleshoot Conditional Access Policies with the What If Tool

The **Conditional Access What If policy tool** helps you understand the result of [Conditional Access](overview.md) policies in your environment. It can be useful when simulating uncommon scenarios, enabling you to design more comprehensive security policies. Instead of manually testing your policies with multiple sign-ins, this tool helps you simulate a sign-in for a user or service principal. The simulation estimates how your policies affect this sign-in and generates a report.

The **What If** tool and [APIs](/graph/api/conditionalaccessroot-evaluate) let you quickly determine the policies that apply to a specific user or single-tenant service principal. Use this information to troubleshoot issues, understand which policies apply to specific sign-in conditions, and test complex sign-in scenarios.

## How it works

The Conditional Access What If tool is powered by the [What If Evaluation API](/graph/api/conditionalaccessroot-evaluate). To use the tool, start by configuring the conditions of the sign-in scenario you want to simulate. The configuration should include:

- The user or single tenant service principal you want to test.
- The cloud apps, user action they would attempt to perform, or sensitive data protected by authentication context they would attempt to access.
- The sign-in conditions under which access would be attempted.

> [!IMPORTANT]
> The What If tool doesn't test for [Conditional Access service dependencies](service-dependencies.md). For example, if you're using **What If** to test a Conditional Access policy for Microsoft Teams, the result doesn't consider any policy that applies to Office 365 Exchange Online, a Conditional Access service dependency for Microsoft Teams.

Next, initiate a simulation run that evaluates your settings. Only policies that are enabled or in report-only mode are included in an evaluation run.

When the evaluation finishes, the tool generates a report of the affected policies. To gather more information about a Conditional Access policy, use [Conditional Access per-policy reporting](concept-conditional-access-report-only.md#policy-impact-preview) or the [Conditional Access insights and reporting workbook](howto-conditional-access-insights-reporting.md) for details about policies in report-only mode or currently enabled.

## Run the What If tool

You can find the **What If** tool in the **Microsoft Entra admin center** > **Entra ID** > **Conditional Access** > **Policies** > **What If**.

:::image type="content" source="./media/what-if-tool/portal-showing-location-of-what-if-tool.png" alt-text="Screenshot of the Conditional Access Policies page with the What If tool highlighted in the toolbar." border="false" lightbox="media/what-if-tool/portal-showing-location-of-what-if-tool.png":::

To run the What If evaluation, provide the conditions you want to evaluate.

## Conditions

The following conditions are required: identity, target resource, device platform, and client app. All other conditions are optional and are assumed to be set to **none** by default if no value is provided. For definitions of these conditions, see the article [Building a Conditional Access policy](concept-conditional-access-policies.md).

:::image type="content" source="./media/what-if-tool/supply-conditions-to-evaluate-in-the-what-if-tool.png" alt-text="Screenshot of the What If page showing fields for entering conditions." border="false" lightbox="media/what-if-tool/supply-conditions-to-evaluate-in-the-what-if-tool.png":::

## Evaluation

Start an evaluation by clicking **What If**. The evaluation result provides you with a report that consists of:

- An indicator showing whether classic policies exist in your environment.
- Policies that apply to your user or workload identity.
- Policies that don't apply to your user or workload identity.

:::image type="content" source="media/what-if-tool/conditional-access-what-if-evaluation-result-example.png" alt-text="Screenshot of an example of the policy evaluation in the What If tool showing policies that would apply." lightbox="media/what-if-tool/conditional-access-what-if-evaluation-result-example.png":::

The list of policies that apply also includes [grant controls](concept-conditional-access-grant.md) and [session controls](concept-conditional-access-session.md) that must be satisfied.

The list of policies that don't apply includes the reasons why these policies don't apply. For each listed policy, the reason represents the first condition that wasn't satisfied.

**Has filter** indicates whether the policy has app filters that use custom security attributes.

## Key differences between the What If evaluation API and the legacy experience 

The What If Evaluation API is a Microsoft Graph API that is called by the Conditional Access experience. The What If tool powered by the [What If Evaluation API](/graph/api/conditionalaccessroot-evaluate) is currently in public preview. The API is different from the legacy What If evaluation in a few ways:

1. The What-if API is a public and fully supported API (once the API is generally available). The API can be used through the Conditional Access UX and the MS Graph API.
1. The logic aligns with the authentication logic used during sign-in to provide more accurate policy evaluation.
1. The What-if API expects all sign-in parameters to be defined for the evaluation to provide the most accurate results. If your tenant has policies with specific conditions and the sign-in details for those conditions aren't provided, the What If API can't evaluate those conditions.

> [!NOTE]
> For application specification, provide the App ID. Groups of apps, such as **Office 365** or **Microsoft Admin Portals**, don't result in a match.

### Examples

This example highlights key differences:

Suppose you have a Conditional Access policy with the following configuration: 

- User: All users
- Resource: Office 365
- Location: United States
- Sign-in risk: High

| Example | Parameters | Result based on legacy What If evaluation | Result based on the new What If evaluation API |
| :---: | --- | :---: | :---: |
| 1 | UserId = “aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" | Applies | Does not apply |
| 2 | UserId = “aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" <br> ApplicationId = “00000003-0000-0ff1-ce00-000000000000" | Applies | Does not apply |
| 3 | UserId = “aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" <br> ApplicationId = “00000003-0000-0ff1-ce00-000000000000" <br> Location = “US” | Applies | Does not apply |
| 4 | UserId = “aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" <br> ApplicationId = “00000003-0000-0ff1-ce00-000000000000" <br> Location = “US” <br> Sign-in Risk = “High” <br> | Applies | Applies |

## Related content

- Learn more about Conditional Access policy application by using the policies report-only mode in [Conditional Access insights and reporting](howto-conditional-access-insights-reporting.md).
- To configure Conditional Access policies for your environment, see [Conditional Access common policies](concept-conditional-access-policy-common.md).
