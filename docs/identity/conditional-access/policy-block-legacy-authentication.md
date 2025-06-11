---
title: Block legacy authentication with Conditional Access
description: Create a custom Conditional Access policy to block legacy authentication protocols.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: calebb, lhuangnorth
---
# Block legacy authentication with Conditional Access

Microsoft recommends that organizations block authentication requests using legacy protocols that don't support multifactor authentication. Based on Microsoft's analysis more than 97 percent of credential stuffing attacks use legacy authentication and more than 99 percent of password spray attacks use legacy authentication protocols. These attacks would stop with basic authentication disabled or blocked.

Customers without licenses that include Conditional Access can make use of [security defaults](~/fundamentals/security-defaults.md) to block legacy authentication.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to block legacy authentication requests. This policy is put in to [Report-only mode](howto-conditional-access-insights-reporting.md) to start so administrators can determine the impact they have on existing users. When administrators are comfortable that the policy applies as they intend, they can switch to **On** or stage the deployment by adding specific groups and excluding others.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose any accounts that must maintain the ability to use legacy authentication. Microsoft recommends you exclude at least one account to prevent yourself from being locked out due to misconfiguration.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Client apps**, set **Configure** to **Yes**.
   1. Check only the boxes **Exchange ActiveSync clients** and **Other clients**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!NOTE]
> Conditional Access policies are enforced after first-factor authentication is completed. Conditional Access isn't intended to be an organization's first line of defense for scenarios like denial-of-service (DoS) attacks, but it can use signals from these events to determine access.

## Identify legacy authentication use

To understand if your users have client apps that use legacy authentication, administrators can check for indicators in the sign-in logs with the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Add the **Client App** column if it isn't shown by clicking on **Columns** > **Client App**.
1. Select **Add filters** > **Client App** > choose all of the legacy authentication protocols and select **Apply**.
1. Also perform these steps on the **User sign-ins (non-interactive)** tab.

Filtering shows you sign-in attempts made by legacy authentication protocols. Clicking on each individual sign-in attempt shows you more details. The **Client App** field under the **Basic Info** tab indicates which legacy authentication protocol was used. These logs indicate users who are using clients that depend on legacy authentication.

Additionally, to help triage legacy authentication within your tenant use the [Sign-ins using legacy authentication workbook](~/identity/monitoring-health/workbook-legacy-authentication.md).

## Related content

- [Deprecation of Basic authentication in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/deprecation-of-basic-authentication-exchange-online)
- [How to set up a multifunction device or application to send email using Microsoft 365](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365)
- [How modern authentication works for Office client apps](/microsoft-365/enterprise/modern-auth-for-office-2013-and-2016)
- [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell)
