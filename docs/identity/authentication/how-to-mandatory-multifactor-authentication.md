---
title: How to verify that users are set up for mandatory Microsoft Entra multifactor authentication (MFA) 
description: Steps to verify mandatory multifactor authentication for users who sign in to Azure and other management portals.
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 10/08/2024
ms.author: justinha
author: najshahid
manager: amycolannino
ms.reviewer: nashahid, gkinasewitz

# Customer intent: As an identity administrator, I want to plan for mandatory MFA for users who sign in to Azure portal.
---
# How to verify that users are set up for mandatory MFA

This topic covers steps to verify that users in your organization are set up to meet requirements to use MFA to sign in to Microsoft admin portals. For more information about which applications and accounts are affected and how the rollout works, see [Planning for mandatory multifactor authentication for Azure and other admin portals](concept-mandatory-multifactor-authentication.md).

## Find users who sign in with and without MFA
Use the followng resources to find users who sign in with and without MFA: 

- To export a list of users and their authentication methods, use [PowerShell](https://aka.ms/AzMFA).
- If you run queries to analyze user sign-ins, use the application IDs of the [applications](#applications) listed previously. 

## Migrate user-based service accounts to workload identities

For more information about how to migrate from user-based service accounts to workload identities for authentication with these applications, see: 

- [Sign into Azure with a managed identity using the Azure CLI](/cli/azure/authenticate-azure-cli-managed-identity)
- [Sign into Azure with a service principal using the Azure CLI](/cli/azure/authenticate-azure-cli-service-principal)
- [Sign in to Azure PowerShell non-interactively for automation scenarios](/powershell/azure/authenticate-noninteractive) includes guidance for both managed identity and service principal use cases

Customers applying Conditional Access policies to the user based service accounts can reclaim this user based license and apply [workload identities](~/workload-id/workload-identities-overview.md) license to apply [Conditional Access for workload identities](~/identity/conditional-access/workload-identity.md). 


## Verify MFA enablement
Regardless of any roles they have or don't have, all users who access the admin portals and Azure clients listed in [applications](#applications) must be set up to use MFA. All users who access any administration portal should use MFA. Use the following steps to verify that MFA is set up for your users, or to enable it if needed. 

1. Sign in to Azure portal as a Global Reader.
1. Browse to Identity > Overview.
1. Check the license type for the tenant subscription. 
1. Follow the steps for your license type to verify MFA is enabled, or enable it if needed. To complete these steps, you need to sign out as a Global Reader, and sign back in with a more privileged role.

   - Microsoft Entra ID P1 or Microsoft Entra ID P2 
   - Microsoft 365 or Microsoft Entra ID Free 

### Verify MFA is enabled for Microsoft Entra ID P1 or Microsoft Entra ID P2 license

If you have a Microsoft Entra ID P1 or Microsoft Entra ID P2 license, you can create a Conditional Access policy to require MFA for users who access Microsoft admin portals:  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
1. Under **Include**, select **All users**, or a group of users who sign in to the [applications](#applications) listed previously.
1. Under **Target resources** > **Cloud apps** > **Include**, **Select apps**, select **Microsoft Admin Portals**.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require authentication strength**, select **Multifactor authentication**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

For more information, see [Common Conditional Access policy: Require multifactor authentication for admins accessing Microsoft admin portals](~/identity/conditional-access/how-to-policy-mfa-admin-portals.md). 

### Verify MFA is enabled for Microsoft 365 or Microsoft Entra ID Free

If you have a Microsoft 365 or Microsoft Entra ID Free license, you can enable MFA by using security defaults. Users are prompted for MFA as needed, but you can't define your own rules to control the behavior.
To enable security defaults:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Identity** > **Overview** > **Properties**.
1. Select **Manage security defaults**.
1. Set **Security defaults** to **Enabled**.
1. Select **Save**.

For more information about security defaults, see [Security defaults in Microsoft Entra ID](~/fundamentals/security-defaults.md).

If you don't want to use security defaults, you can enable per-user MFA. When you enable users individually, they perform MFA each time they sign in. An Authentication Administrator can enable some exceptions. To enable per-user MFA:
  
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select a user account, and click **Enable MFA**.
1. Confirm your selection in the pop-up window that opens.

After you enable users, notify them by email. Tell the users that a prompt is displayed to ask them to register the next time they sign in. For more information, see [Enable per-user Microsoft Entra multifactor authentication to secure sign-in events](howto-mfa-userstates.md).

- For a tutorial about how to set up Microsoft Entra MFA, see [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](~/identity/authentication/tutorial-enable-azure-mfa.md).
- If you don’t require MFA in your tenant today, there are several options available to set it up (listed in preferred order): 
  - Use [Conditional Access](~/identity/conditional-access/overview.md) policies. Start in [report-only mode](~/identity/conditional-access/concept-conditional-access-report-only.md) and target **All users**. In report-only mode, don't configure exceptions. This configuration more closely mirrors the enforcement pattern of Microsoft Entra MFA program. 
    - [Microsoft administration portals](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#microsoft-admin-portals) (includes portals in scope for this Microsoft Entra MFA enforcement) 
    - [Require multifactor authentication](~/identity/conditional-access/concept-conditional-access-grant.md#require-multifactor-authentication) or if you want more granular control, use [authentication strengths](~/identity/conditional-access/concept-conditional-access-grant.md#require-authentication-strength)
  - If you sign in to the Microsoft 365 admin center, use the [MFA wizard for Microsoft Entra ID](https://aka.ms/EntraIDMFAWizard).
  - If you don't have a Microsoft Entra ID P1 or P2 license, you can enable [security defaults](~/fundamentals/security-defaults.md). Users are prompted for MFA as needed, but you can't define your own rules to control the behavior.
  - If your license doesn't include Conditional Access and you don't want to use security defaults, you can configure [per-user MFA](~/identity/authentication/howto-mfa-userstates.md).

## Related content 

Review the following topics to learn more about MFA:

- [Planning for mandatory multifactor authentication for Azure and other admin portals](concept-mandatory-multifactor-authentication.md)
- [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Secure sign-in events with Microsoft Entra multifactor](~/identity/authentication/tutorial-enable-azure-mfa.md)
- [Plan a Microsoft Entra multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
- [Phishing-resistant MFA methods](~/identity/authentication/phishing-resistant-authentication-videos.md)
- [Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) 
- [Authentication methods](~/identity/authentication/concept-authentication-methods.md)