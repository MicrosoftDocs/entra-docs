---
title: How to verify that users are set up for mandatory Microsoft Entra multifactor authentication (MFA) 
description: Steps to verify mandatory multifactor authentication for users who sign in to Azure and other management portals.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/31/2025
ms.author: justinha
author: najshahid
manager: dougeby
ms.reviewer: nashahid, gkinasewitz

# Customer intent: As an identity administrator, I want to plan for mandatory MFA for users who sign in to Azure portal.
---
# How to verify that users are set up for mandatory MFA

This topic covers steps to verify that users in your organization are set up to meet Azure's mandatory MFA requirements. For more information about which applications and accounts are affected and how the rollout works, see [Planning for mandatory multifactor authentication for Azure and other admin portals](concept-mandatory-multifactor-authentication.md). 

## Verify MFA for a personal account

A user might use their personal account to create a Microsoft Entra tenant for only a few users. If you used your personal account to subscribe to Azure, complete the following steps to confirm that your account is set up for MFA.

1. Sign in to your Microsoft account **Advanced security options**.
1. Under **Additional security** and **Two-step verification** choose **Turn on**.
1. Follow the instructions shown on the screen.

For more information, see [How to use two-step verification with your Microsoft account](https://support.microsoft.com/account-billing/how-to-use-two-step-verification-with-your-microsoft-account-c7910146-672f-01e9-50a0-93b4585e7eb4).

## Find users who sign in with and without MFA
Use the following resources to find users who sign in with and without MFA: 

- To export a list of users and their authentication methods, use [PowerShell](https://aka.ms/AzMFA).
- If you run queries to analyze user sign-ins, use the application IDs of the [applications that require MFA](concept-mandatory-multifactor-authentication.md#applications). 

## Verify MFA enablement
All users who access [applications that require MFA](concept-mandatory-multifactor-authentication.md#applications) must be set up to use MFA. Mandatory MFA isn't restricted to privileged roles. As a best practice, all users who access *any* administration portal should use MFA. 

Use the following steps to verify that MFA is set up for your users, or to enable it if needed. 

1. Sign in to Azure portal as a Global Reader.
1. Browse to **Entra ID** > **Overview**.
1. Check the license type for the tenant subscription. 
1. Follow the steps for your license type to verify MFA is enabled, or enable it if needed. To complete these steps, you need to sign out as a Global Reader, and sign back in with a more privileged role.

   - [Microsoft Entra ID P1 or Microsoft Entra ID P2](#verify-mfa-is-enabled-for-microsoft-entra-id-p1-or-microsoft-entra-id-p2-license) 
   - [Microsoft 365 or Microsoft Entra ID Free](#verify-mfa-is-enabled-for-microsoft-365-or-microsoft-entra-id-free)

### Verify MFA is enabled for Microsoft Entra ID P1 or Microsoft Entra ID P2 license

If you have a Microsoft Entra ID P1 or Microsoft Entra ID P2 license, you can create a Conditional Access policy to require MFA for users who access [applications that require MFA](concept-mandatory-multifactor-authentication.md#applications):  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
1. Under **Include**, select **All users**, or a group of users who sign in to the [applications that require MFA](concept-mandatory-multifactor-authentication.md#applications).
1. Under **Target resources** > **Cloud apps** > **Include**, **Select apps**, select **Microsoft Admin Portals** and **Windows Azure Service Management API**.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require authentication strength**, select **Multifactor authentication**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**. 
1. Select **Create** to create to enable your policy.

   >[!Important] 
   >Create the CA Policy in Report-Only mode to understand impact for your tenant so you don't get locked out.

For more information, see [Common Conditional Access policy: Require multifactor authentication for admins accessing Microsoft admin portals](~/identity/conditional-access/how-to-policy-mfa-admin-portals.md). 

You can use the Conditional Access insights and reporting workbook that contains sign-in logs to understand impact for your tenant. 
As a prerequisite, you need to: 

- [Create a workspace](/azure/azure-monitor/logs/quick-create-workspace).
- [Integrate activity logs with Azure Monitor](/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs).

Choose the following parameters to see how mandatory MFA affects your tenant:

- Select the previously created MFA Conditional Access policy
- Select a time range to evaluate the data
- Select **Data View** to see results in terms of number of users or number of sign-ins

You can query the sign-in details or download the sign-in logs to dive deeper into the data. For more information, see [Conditional Access insights and reporting](/entra/identity/conditional-access/howto-conditional-access-insights-reporting).



### Verify MFA is enabled for Microsoft 365 or Microsoft Entra ID Free

If you have a Microsoft 365 or Microsoft Entra ID Free license, you can enable MFA by using security defaults. Users are prompted for MFA as needed, but you can't define your own rules to control the behavior.

To enable security defaults:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Entra ID** > **Overview** > **Properties**.
1. Select **Manage security defaults**.
1. Set **Security defaults** to **Enabled**.
1. Select **Save**.

For more information about security defaults, see [Security defaults in Microsoft Entra ID](~/fundamentals/security-defaults.md).

If you don't want to use security defaults, you can enable per-user MFA. When you enable users individually, they perform MFA each time they sign in. An Authentication Administrator can enable some exceptions. To enable per-user MFA:
  
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select a user account, and click **Enable MFA**.
1. Confirm your selection in the pop-up window that opens.

After you enable users, notify them by email. Tell the users that a prompt is displayed to ask them to register the next time they sign in. For more information, see [Enable per-user Microsoft Entra multifactor authentication to secure sign-in events](howto-mfa-userstates.md).


## Related content 

Review the following topics to learn more about MFA:

- [How to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory multifactor authentication (MFA) requirement for the the Azure portal, Microsoft Entra admin center, or Microsoft Intune admin center](how-to-unlock-users-for-mandatory-multifactor-authentication.md)
- [Planning for mandatory multifactor authentication for Azure and other admin portals](concept-mandatory-multifactor-authentication.md)
- [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Secure sign-in events with Microsoft Entra multifactor](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Plan a Microsoft Entra multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
- [Phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md)
- [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) 
- [Authentication methods](~/identity/authentication/concept-authentication-methods.md)
