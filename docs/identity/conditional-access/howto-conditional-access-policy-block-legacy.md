---
title: Block legacy authentication with Conditional Access
description: Create a custom Conditional Access policy to block legacy authentication protocols.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 06/27/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: calebb, lhuangnorth
---
# Common Conditional Access policy: Block legacy authentication

Due to the increased risk associated with legacy authentication protocols, Microsoft recommends that organizations block authentication requests using these protocols and require modern authentication. For more information about why blocking legacy authentication is important, see the article [How to: Block legacy authentication to Microsoft Entra ID with Conditional Access](block-legacy-authentication.md).

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to block legacy authentication requests. This policy is put in to [Report-only mode](howto-conditional-access-insights-reporting.md) to start so administrators can determine the impact they have on existing users. When administrators are comfortable that the policy applies as they intend, they can switch to **On** or stage the deployment by adding specific groups and excluding others.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose any accounts that must maintain the ability to use legacy authentication. Microsoft recommends you exclude at least one account to prevent yourself from being locked out.
1. Under **Target resources** > **Cloud apps** > **Include**, select **All cloud apps**.
1. Under **Conditions** > **Client apps**, set **Configure** to **Yes**.
   1. Check only the boxes **Exchange ActiveSync clients** and **Other clients**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

> [!NOTE]
> Conditional Access policies are enforced after first-factor authentication is completed. Conditional Access isn't intended to be an organization's first line of defense for scenarios like denial-of-service (DoS) attacks, but it can use signals from these events to determine access.

## Next steps

[Conditional Access templates](concept-conditional-access-policy-common.md)

[Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

[How to set up a multifunction device or application to send email using Microsoft 365](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365)
