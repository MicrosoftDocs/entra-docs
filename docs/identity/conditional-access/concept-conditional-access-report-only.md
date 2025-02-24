---
title: Analyzing Conditional Access policy impact
description: Use available tools like report-only mode to analyze Conditional Access policy.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 02/26/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: kvenkit
---
# Conditional Access report-only mode and policy impact

Conditional Access helps organizations stay secure by applying the right security access controls under the right circumstances. One of the challenges organization have is understanding why existing policies behave in a way that you or your users might not expect. This challenge also appears when you deploy new policies and attempt to forcast their impact on users. Why did a policy apply to one user but not to another? Why did one get blocked and another not? 

There are several options availalbe to administrators based on report-only mode. Report-only mode is a policy state allowing administrators to test most Conditional Access policies before enabling them.

- Conditional Access policies can be evaluated in report-only mode except for items included in the "User Actions" scope.
- During sign-in, policies in report-only mode are evaluated but not enforced.
- Results are logged in the **Conditional Access** and **Report-only** tabs of the Sign-in log details.
- Customers with an Azure Monitor subscription can monitor the impact of their Conditional Access policies using the Conditional Access insights workbook.

> [!VIDEO https://www.youtube.com/embed/NZbPYfhb5Kc]

> [!WARNING]
> Policies in report-only mode that require a compliant device might prompt users on macOS, iOS, and Android devices to select a device certificate during policy evaluation, even though device compliance isn't enforced. These prompts might repeat until the device is made compliant. To prevent end users from receiving prompts during sign-in, exclude device platforms Mac, iOS, and Android from report-only policies that perform device compliance checks.

<a name='policy-results'></a>

## Results

When a policy in report-only mode is evaluated for a given sign-in, there are four possible results:

| Result | Description |
| --- | --- |
| Report-only: Success | All configured policy conditions, required non-interactive grant controls, and session controls were satisfied. For example, a multifactor authentication requirement is satisfied by an MFA claim already present in the token, or a compliant device policy is satisfied by performing a device check on a compliant device. |
| Report-only: Failure | All configured policy conditions were satisfied but not all the required non-interactive grant controls or session controls were satisfied. For example, a policy applies to a user where a block control is configured, or a device fails a compliant device policy. |
| Report-only: User action required | All configured policy conditions were satisfied but user action would be required to satisfy the required grant controls or session controls. With report-only mode, the user isn't prompted to satisfy the required controls. For example, users aren't prompted for multifactor authentication challenges or terms of use.   |
| Report-only: Not applied | Not all configured policy conditions were satisfied. For example, the user is excluded from the policy or the policy only applies to certain trusted named locations. |

## Reviewing results

There are several options administrators might use to review the potential results of policies in their environment:

- Workbooks
- Sign-in logs
- Policy impact (Preview)

### Policy impact (Preview)

The polcy impact view of Conditional Access allows those with at least the Security Reader role the ability to see a snapshot of information about the potential or existing impacts of policies in your organization. This functionality allows you to explore impact over a period of the past 24 hours, 7 days, or 1 month. In addition you can see and link to a sampling of sign-in events you can drill into.

:::image type="content" source="media/concept-conditional-access-report-only/policy-impact-example-report-only.png" alt-text="Screenshot of" lightbox="media/concept-conditional-access-report-only/policy-impact-example-report-only.png":::

<a name='conditional-access-insights-workbook'></a>

### Workbooks

Administrators have the capability to create multiple policies in report-only mode, so it's necessary to understand both the individual impact of each policy and the combined impact of multiple policies evaluated together. The [Conditional Access Insights and Reporting workbook](howto-conditional-access-insights-reporting) enables administrators to visualize Conditional Access queries and monitor the impact of a policy for a given time range, set of applications, and users. Administrators can customize workbooks to suit their speicfic needs.

### Sign-in logs

For much deeper evaluation of Conditional Access policies and their application at a specific sign-in, administrators might choose to investigate individual sign-in events. Each of these events includes details of what Conditional Access policies were enabled versus were in report-only mode, and applied or did not apply. 

![Screenshot showing the report-only tab in a sign-in log.](./media/concept-conditional-access-report-only/report-only-detail-in-sign-in-log.png)

## Using these options


After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

## Related content

- [Configure report-only mode on a Conditional Access policy](howto-conditional-access-insights-reporting.md)
