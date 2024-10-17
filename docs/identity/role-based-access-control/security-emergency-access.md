---
title: Manage emergency access admin accounts
description: This article describes how to use emergency access accounts to help prevent being inadvertently locked out of your Microsoft Entra organization.

author: markwahl-msft
manager: amycolannino
ms.author: rolyon
ms.date: 10/01/2024
ms.topic: conceptual
ms.service: entra-id
ms.subservice: role-based-access-control
ms.custom: it-pro
ms.reviewer: mwahl

---

# Manage emergency access accounts in Microsoft Entra ID

It's important that you prevent being accidentally locked out of your Microsoft Entra organization because you can't sign in or activate another user's account as an administrator. You can mitigate the impact of accidental lack of administrative access by creating two or more *emergency access accounts* in your organization.

User accounts with the Global Administrator role have high privileges in the system, this includes emergency access accounts with the Global Administrator role. Emergency access accounts are limited to emergency or "break glass"' scenarios where normal administrative accounts can't be used. We recommend that you maintain a goal of restricting emergency account use to only the times when it's absolutely necessary.

This article provides guidelines for managing emergency access accounts in Microsoft Entra ID.

## Why use an emergency access account

An organization might need to use an emergency access account in the following situations:

- The user accounts are federated, and federation is currently unavailable because of a cell-network break or an identity-provider outage. For example, if the identity provider host in your environment has gone down, users might be unable to sign in when Microsoft Entra ID redirects to their identity provider.
- The administrators are registered through Microsoft Entra multifactor authentication, and all their individual devices are unavailable or the service is unavailable. Users might be unable to complete multifactor authentication to activate a role. For example, a cell network outage is preventing them from answering phone calls or receiving text messages, the only two authentication mechanisms that they registered for their device.
- The person with the most recent Global Administrator access has left the organization. Microsoft Entra ID prevents the last Global Administrator account from being deleted, but it doesn't prevent the account from being deleted or disabled on-premises. Either situation might make the organization unable to recover the account.
- Unforeseen circumstances such as a natural disaster emergency, during which a mobile phone or other networks might be unavailable.
- If role assignments for Global Administrator and Privileged Role Administrator roles are eligible, approval is required for activation, but no approvers are selected (or all approvers are removed from the directory). Active Global Administrators and Privileged Role Administrators are default approvers. But there will be no active Global Administrators and Privileged Role Administrators and administration of the tenant will be effectively be locked, unless emergency access accounts are used.

## Create emergency access accounts

Create two or more emergency access accounts. These accounts should be cloud-only accounts that use the \*.onmicrosoft.com domain and that aren't federated or synchronized from an on-premises environment. At a high level, you will follow these steps.

1. [Enable passkeys (FIDO2) for your organization](../authentication/how-to-enable-passkey-fido2.md).

1. [Create](#how-to-create-an-emergency-access-account) or [update](#how-to-update-an-existing-emergency-access-account) emergency accounts.

1. [Register a passkey (FIDO2)](../authentication/how-to-register-passkey-with-security-key.md).

1. [Exclude at least one account from Conditional Access policies](#exclude-at-least-one-account-from-conditional-access-policies).

1. [Store account credentials safely](#store-account-credentials-safely).

1. [Monitor sign-in and audit logs](#monitor-sign-in-and-audit-logs).

1. [Validate accounts regularly](#validate-accounts-regularly).

### How to create an emergency access account

Follow these steps to create new emergency access accounts that use FIDO2.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Privileged Role Administrator](../role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. If not already enabled, follow steps to [enable passkeys (FIDO2) for your organization](../authentication/how-to-enable-passkey-fido2.md).

1. Browse to **Identity** > **Users** > **All users**.

1. Select **New user** > **Create new user**.

1. On the **Basics** tab, give the account a **User principal name** and **Display name**.

1. Create a long and complex password for the account.

1. On the **Properties** tab, under **Usage location**, select the appropriate location.

1. On the **Assignments** tab, select **Add role**.

1. Select the **Global Administrator** role.

1. On the **Review + create** tab, select **Create**.

    :::image type="content" source="./media/security-emergency-access/create-emergency-access-account.png" alt-text="Creating an emergency access account in Microsoft Entra ID." lightbox="./media/security-emergency-access/create-emergency-access-account.png":::

1. Follow steps to [register a passkey (FIDO2)](../authentication/how-to-register-passkey-with-security-key.md).

### How to update an existing emergency access account

If you have existing emergency access accounts that only require a password to sign in, follow these steps to update these accounts to use FIDO2.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](../role-based-access-control/permissions-reference.md#global-administrator).

1. If not already enabled, follow steps to [enable passkeys (FIDO2) for your organization](../authentication/how-to-enable-passkey-fido2.md).

1. Follow steps to [register a passkey (FIDO2)](../authentication/how-to-register-passkey-with-security-key.md).

<a name='exclude-at-least-one-account-from-phone-based-multi-factor-authentication'></a>

### Exclude at least one account from Conditional Access policies

During an emergency, you don't want a policy to potentially block your access in the case of a misconfiguration or to fix an issue. If you use Conditional Access, at least one emergency access account needs to be excluded from all Conditional Access policies.

> [!NOTE]
> Starting July 2024, Azure teams will begin rolling out additional tenant-level security measures to require multifactor authentication (MFA) for all users signing in to the Azure portal, Microsoft Entra admin center, or Intune admin center. For more information, see [Planning for mandatory multifactor authentication for Azure and other admin portals](../authentication/concept-mandatory-multifactor-authentication.md).
> 
> As already documented, use strong authentication for your emergency access accounts. We recommend updating these accounts to use FIDO2 or certificate-based authentication (when configured as MFA) instead of relying only on a long password. Both methods will satisfy the MFA requirements.

## Configuration requirements

When you configure these accounts, the following requirements must be met:

- The emergency access accounts shouldn't be associated with any individual user in the organization. Make sure that your accounts aren't connected with any employee-supplied mobile phones, hardware tokens that travel with individual employees, or other employee-specific credentials. This precaution covers instances where an individual employee is unreachable when the credential is needed. It's important to ensure that any registered devices are kept in a known, secure location that has multiple means of communicating with Microsoft Entra ID.
- Use strong authentication for your emergency access accounts and make sure it doesn’t use the same authentication methods as your other administrative accounts. For example, if your normal administrator account uses the Microsoft Authenticator app for strong authentication, use a FIDO2 security key for your emergency accounts. Consider the [dependencies of various authentication methods](~/architecture/resilience-in-credentials.md), to avoid adding external requirements into the authentication process.
- The device or credential must not expire or be in scope of automated cleanup due to lack of use.  
- In Microsoft Entra Privileged Identity Management, you should make the Global Administrator role assignment permanent rather than eligible for your emergency access accounts. 

## Federation guidance

Some organizations use AD Domain Services and AD FS or similar identity provider to federate to Microsoft Entra ID. The emergency access for on-premises systems and the emergency access for cloud services should be kept distinct, with no dependency of one on the other. Mastering and or sourcing authentication for accounts with emergency access privileges from other systems adds unnecessary risk in the event of an outage of those systems.

## Store account credentials safely

Organizations need to ensure that the credentials for emergency access accounts are kept secure and known only to individuals who are authorized to use them. Some customers use a smartcard for Windows Server AD, a [FIDO2 security key](~/identity/authentication/howto-authentication-passwordless-security-key.md) for Microsoft Entra ID and others use passwords. A password for an emergency access account is usually separated into two or three parts, written on separate pieces of paper, and stored in secure, fireproof safes that are in secure, separate locations.

## Monitor sign-in and audit logs

Organizations should monitor sign-in and audit log activity from the emergency accounts and trigger notifications to other administrators. When you monitor the activity on break glass accounts, you can verify these accounts are only used for testing or actual emergencies. You can use Azure Log Analytics to monitor the sign-in logs and trigger email and SMS alerts to your admins whenever break glass accounts sign in.

### Prerequisites

1. [Send Microsoft Entra sign-in logs](~/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs.yml) to Azure Monitor.

### Obtain Object IDs of the break glass accounts

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

1. Browse to **Identity** > **Users** > **All users**.

1. Search for the break-glass account and select the user’s name.

1. Copy and save the Object ID attribute so that you can use it later.

1. Repeat previous steps for second break-glass account.

### Create an alert rule

1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Monitoring Contributor](/azure/role-based-access-control/built-in-roles#monitoring-contributor).

1. Browse to **Monitor** > **Log Analytics workspaces**.

1. Select a workspace.

1. In your workspace, select **Alerts** > **New alert rule**.

    1. Under **Resource**, verify that the subscription is the one with which you want to associate the alert rule.
    1. Under **Condition**, select **Add**.
    1. Select **Custom log search** under **Signal name**.
    1. Under **Search query**, enter the following query, inserting the object IDs of the two break glass accounts.
        > [!NOTE]
        > For each additional break glass account you want to include, add another "or UserId == "ObjectGuid"" to the query.
                
        Sample queries:
        ```kusto
        // Search for a single Object ID (UserID)
        SigninLogs
        | project UserId 
        | where UserId == "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        ```
        
        ```kusto
        // Search for multiple Object IDs (UserIds)
        SigninLogs
        | project UserId 
        | where UserId == "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" or UserId == "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        ```
        
        ```kusto
        // Search for a single UserPrincipalName
        SigninLogs
        | project UserPrincipalName 
        | where UserPrincipalName == "user@yourdomain.onmicrosoft.com"
        ```
        
        ![Add the object IDs of the break glass accounts to an alert rule](./media/security-emergency-access/query-image1.png)

    1. Under **Alert logic**, enter the following:

        - Based on: Number of results
        - Operator: Greater than
        - Threshold value: 0

    1. Under **Evaluated based on**, select the **Period (in minutes)** for how long you want the query to run, and the **Frequency (in minutes)** for how often you want the query to run. The frequency should be less than or equal to the period.

        ![alert logic](./media/security-emergency-access/alert-image2.png)

    1. Select **Done**. You can now view the estimated monthly cost of this alert.

1. Select an action group of users to be notified by the alert. If you want to create one, see [Create an action group](#create-an-action-group).

1. To customize the email notification sent to the members of the action group, select actions under **Customize Actions**.

1. Under **Alert Details**, specify the alert rule name and add an optional description.

1. Set the **Severity level** of the event. We recommend that you set it to **Critical(Sev 0)**.

1. Under **Enable rule upon creation**, leave it set as **yes**.

1. To turn off alerts for a while, select the **Suppress Alerts** check box and enter the wait duration before alerting again, and then select **Save**.

1. Click **Create alert rule**.

### Create an action group

1. Select **Create an action group**.

    ![create an action group for notification actions](./media/security-emergency-access/action-group-image3.png)

1. Enter the action group name and a short name.

1. Verify the subscription and resource group.

1. Under action type, select **Email/SMS/Push/Voice**.

1. Enter an action name such as **Notify Global Administrator**.

1. Select the **Action Type** as **Email/SMS/Push/Voice**.

1. Select **Edit details** to select the notification methods you want to configure and enter the required contact information, and then select **Ok** to save the details.

1. Add any additional actions you want to trigger.

1. Select **OK**.

## Validate accounts regularly

When you train staff members to use emergency access accounts and validate the emergency access accounts, at minimum do the following steps at regular intervals:

- Ensure that security-monitoring staff are aware that the account-check activity is ongoing.
- Ensure that the emergency break glass process to use these accounts is documented and current.
- Ensure that administrators and security officers who might need to perform these steps during an emergency are trained on the process.
- Update the account credentials, in particular any passwords, for your emergency access accounts, and then validate that the emergency access accounts can sign-in and perform administrative tasks.
- Ensure that users haven't registered multifactor authentication or self-service password reset (SSPR) to any individual user’s device or personal details. 
- If the accounts are registered for multifactor authentication to a device, for use during sign-in or role activation, ensure that the device is accessible to all administrators who might need to use it during an emergency. Also verify that the device can communicate through at least two network paths that don't share a common failure mode. For example, the device can communicate to the internet through both a facility's wireless network and a cell provider network.

These steps should be performed at regular intervals and for key changes:

- At least every 90 days
- When there has been a recent change in IT staff, such as a job change, a departure, or a new hire
- When the Microsoft Entra subscriptions in the organization have changed

## Next steps

- [Securing privileged access for hybrid and cloud deployments in Microsoft Entra ID](security-planning.md)
- [Add users using Microsoft Entra ID](~/fundamentals/add-users.md) and [assign roles to the new user](~/fundamentals/how-subscriptions-associated-directory.yml)
- [Sign up for Microsoft Entra ID P1 or P2](~/fundamentals/get-started-premium.md), if you haven’t signed up already
- [How to require two-step verification for a user](~/identity/authentication/howto-mfa-userstates.md)
- [Configure additional protections for privileged roles in Microsoft 365](/microsoft-365/enterprise/protect-your-global-administrator-accounts), if you're using Microsoft 365
- [Start an access review of privileged roles](~/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md) and [transition existing privileged role assignments to more specific administrator roles](permissions-reference.md)
