---
title: Impact analysis of risk-based access policies workbook
description: Take a proactive look at the impact of risk-based policies in your environment.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 07/18/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: chuqiaoshi
---
# Workbook: Impact analysis of risk-based access policies

We recommend everyone enable [risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md), we understand this deployment requires time, change management, and sometimes careful scrutiny by leadership in order to understand any unwanted impact. We give administrators the power to confidently provide answers to those scenarios to adopt risk-based policies needed to protect their environment quickly. 

Instead of creating risk-based Conditional Access policies in report-only mode and waiting a few weeks/months to have results, you can use the **Impact analysis of risk-based access policies** [workbook](/entra/identity/monitoring-health/overview-workbooks), which lets you view the impact immediately based off sign-in logs. 

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact.png" alt-text="A screenshot of the impact analysis of risk-based access policies workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact.png":::

## Description

The workbook helps you understand your environment before enabling policies that might block your users from signing in, require multifactor authentication, or perform a secure password change. It provides you with a breakdown based on a date range of your choosing of sign-ins including:

- An impact summary of recommended risk-based access policies including an overview of:
   - User risk scenarios
   - Sign-in risk and trusted network scenarios
- Impact details including details for unique users:
   - User risk scenarios like:
      - High risk users not blocked by a risk-based access policy.
      - High risk users not prompted to change their password by a risk-based access policy.
      - Users that changed their password due to a risk-based access policy.
      - Risky users not successfully signing-in due to a risk-based access policy.
      - Users who remediated risk by an on-premises password reset.
      - Users who remediated risk by remediated by a cloud-based password reset.
   - Sign-in risk policy scenarios like:
      - High risk sign-ins not blocked by a risk-based access policy.
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

### Navigating the workbook

Once you are in the workbook, there are a couple of parameters on the top right corner. You can set from which workspace the workbook is populated, and turn the guide on or off. 

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-parameters.png" alt-text="Screenshot highlighting the parameters and guide section of the workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-parameters.png":::

Just like every workbook, you can view or edit the [Kusto Query Language (KQL)](/azure/data-explorer/kusto/query/) queries that are fueling the visuals. If you make changes, you can always revert to the original template. 

#### Summary

The first section is a summary and shows the aggregate number of users or sessions impacted during the time range selected. If you scroll further down, the associated details are available.

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-summary.png" alt-text="Screenshot showing the summary section of the workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-summary.png":::

The most important scenarios covered in the summary are scenarios one and two for user and sign-in risk scenarios. These show high users or sign-ins that weren't blocked, prompted for password change, or remediated by MFA; meaning high risk users might still be in your environment. 

You can then scroll down and see the details of exactly who those users would be. Every summary component has corresponding details that follow. 

#### User risk scenarios

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-user.png" alt-text="Screenshot showing the user risk sections of the workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-user.png":::

User risk scenarios three and four are going to help you if you already have some risk-based access policies enabled; they show users that changed their password or high-risk users that were blocked from signing in due to your risk-based access policies. If you still have high-risk users showing up in user risk scenarios one and two (not being blocked or not being prompted for password change) when you thought they would all fall in these buckets, there might be gaps in your policies. 

#### Sign-in risk scenarios

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-sign-in.png" alt-text="Screenshot showing the sign-in risk sections of the workbook" lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-sign-in.png":::

Next, let us look at sign-in risk scenarios three and four. If you use MFA, you'll likely have activity here even if you don't have any risk-based access policies enabled. Sign-in risks are automatically remediated when MFA is performed successfully. Scenario four looks at the high-risk sign-ins that weren't successful due to risk-based access policies. If you have policies enabled, but are still seeing sign-ins you expect to be blocked or remediated with MFA, you might have gaps in your policies. If that is the case, we recommend reviewing your policies and using the details section of this workbook to help investigate any gaps. 

Scenarios 5 and 6 for user risk scenarios show that remediation is happening. This section gives you insight into how many users are changing their password from on-premises or through self-service password reset (SSPR). If these numbers don't make sense for your environment, for example you didn't think SSPR was enabled, use the details to investigate. 

Sign-in scenario 5, **IP addresses not trusted**, surfaces the IP addresses from all the sign-ins in the time range selected and surfaces those IPs that aren't considered trusted. 

#### Federated sign-in risk policy scenarios

For customers using multiple identity providers, the next section will be useful to see if there are any risky sessions being redirected to those external providers for MFA or for other forms of remediation. This section can give you insight into where remediation is taking place and if it's happening as expected. For this data to populate, “federatedIdpMfaBehavior” needs to be set in your federated environment to enforce MFA coming from a federated identity provider. 

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-federated.png" alt-text="Screenshot showing the federated sign-in risk policy scenarios of the workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-federated.png":::

#### Legacy Identity Protection policies

The next section tracks how many legacy user and sign-in policies are still in your environment and must migrate by October 2026. It's important to be aware of this timeline and start migrating policies to the Conditional Access portal as soon as possible. You want enough time to test the new policies, clean any unneeded or duplicated policies, and verify there are no gaps in coverage. You can read more about migrating legacy policies by following this link, Migrate risk policies. 

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-legacy.png" alt-text="Screenshot showing the legacy Identity Protection policy section of the workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-legacy.png":::

#### Trusted network details

This section provides a detailed list of those IP addresses that aren't considered trusted. Where are these IPs coming from, who owns them? Should they be considered "trusted"? This exercise might be a cross-team effort with your Network admins; however, it’s beneficial to do since having an accurate trusted IP list helps to reduce false positive risk detections. If there's an IP address that looks questionable for your environment, it’s time to investigate.

:::image type="content" source="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-trusted-network.png" alt-text="Screenshot showing the trusted network section of the workbook." lightbox="media/workbook-risk-based-policy-impact/workbook-risk-based-impact-trusted-network.png":::

## FAQ: 

### What if I don’t use Microsoft Entra for multifactor authentication? 

If you don’t use Microsoft Entra multifactor authentication, you might still see sign-in risk remediated in your environment if you use a non-Microsoft MFA provider. External Authentication Methods make it possible to remediate risk when using external authentication methods. 

### What if I am in a hybrid environment? 

User risk can be self-remediated using a [secure password change](howto-identity-protection-remediate-unblock.md#self-remediation-with-risk-based-policy) if self-service password reset is enabled with password writeback. If only password hash sync is enabled, consider enabling [allow on-premises password reset to remediate user risk](howto-identity-protection-remediate-unblock.md#allow-on-premises-password-reset-to-remediate-user-risks). 

### I just received a high-risk alert but they aren't showing up in this report? 

If the user is assigned high risk, but hasn't signed-in yet, you don't see them in this report. The report only uses sign-in logs to populate this data. If you have high risk users that haven't signed in, they aren't counted in this report. 

## Next steps

- [What are Microsoft Entra workbooks?](../identity/monitoring-health/overview-workbooks.md)
- [How To: Investigate risk](howto-identity-protection-investigate-risk.md)
- [What are risk detections?](concept-identity-protection-risks.md)
