---
title: Impact analysis of risk-based access policies workbook
description: Take a proactive look at the impact of risk-based policies in your environment.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 02/16/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: chuqiaoshi
---
# Workbook: Impact analysis of risk-based access policies

The Identity Protection risk analysis workbook helps administrators understand what would happen if you create and enable [Microsoft Entra ID Protection risk based Conditional Access policies](howto-identity-protection-configure-risk-policies.md) in your environment. [Workbooks](/entra/identity/monitoring-health/overview-workbooks) are a collection of information, including queries, tables, and visualizations over a period of time, to help you make sense of underlying data from an existing Log Analytics workspace.

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact.png" alt-text="A screenshot of the impact analysis of risk-based access policies workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact.png":::

## Description

The workbook helps you understand your environment before enabling policies that might block your users from signing in, require multifactor authentication, or perform a secure password change. It provides you with a breakdown based on a date range of your choosing of sign-ins including:

- An impact summary of recommended risk-based access policies including an overview of:
   - User risk scenarios
   - Sign-in risk and trusted network scenarios
- Impact details including details for unique users:
   - User risk scenarios like:
      - High risk users not being blocked by a risk-based access policy.
      - High risk users not being prompted to change their password by a risk-based access policy.
      - Users that changed their password due to a risk-based access policy.
      - Risky users not successfully signing-in due to a risk-based access policy.
      - Users who remediated risk by an on-premises password reset.
      - Users who remediated risk by remediated by a cloud-based password reset.
   - Sign-in risk policy scenarios like:
      - High risk sign-ins not being blocked by a risk-based access policy.
      - High risk sign-ins not self-remediating using multifactor authentication by a risk-based access policy.
      - Risky sign-ins that weren't successful due to a risk-based access policy.
      - Risky sign-ins remediated by multifactor authentication.
   - Network details including top IP addresses not listed as a trusted network.

Administrators can use this information to see which users might be impacted over a period of time if risk-based Conditional Access policies were enabled. 

## How to access the workbook

This workbook doesn't require that you create any Conditional Access policies, even ones in report-only mode. The only prerequisite is that you have your sign-in logs sent to a Log Analytics workspace. For more information about how to enable this prerequisite, see the article [How to use Microsoft Entra Workbooks](../identity/monitoring-health/howto-use-workbooks.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Identity** > **Monitoring & health** > **Workbooks**.
1. Select the **Impact analysis of risk-based access policies** workbook under **Identity Protection**.

## Next steps

- [What are Microsoft Entra workbooks?](../identity/monitoring-health/overview-workbooks.md)
- [How To: Investigate risk](howto-identity-protection-investigate-risk.md)
- [What are risk detections?](concept-identity-protection-risks.md)