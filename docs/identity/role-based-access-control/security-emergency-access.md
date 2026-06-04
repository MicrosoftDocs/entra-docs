---
title: Manage emergency access admin accounts
description: This article describes how to use emergency access accounts to help prevent being inadvertently locked out of your Microsoft Entra organization.
ms.date: 06/04/2026
ms.topic: how-to
ms.custom: it-pro, sfi-ga-nochange
ms.reviewer: mwahl
ai-usage: ai-assisted
---

# Manage emergency access accounts in Microsoft Entra ID

It's important to prevent accidentally locking yourself out of your Microsoft Entra organization because you can't sign in or activate a role. You can reduce the impact of accidental lack of administrative access by creating two or more *emergency access accounts* in your organization.

User accounts with the Global Administrator role have high privileges in the system, and this role includes emergency access accounts with the Global Administrator role. Use emergency access accounts only for emergency or "break glass" scenarios where normal administrative accounts can't be used. Restrict emergency account use to only the times when it's absolutely necessary.

This article provides guidelines for managing emergency access accounts in Microsoft Entra ID.

## Why use an emergency access account

An organization might need to use an emergency access account in the following situations:

- The user accounts are federated, and federation is currently unavailable because of a cell-network break or an identity-provider outage. For example, if the identity provider host in your environment goes down, users might be unable to sign in when Microsoft Entra ID redirects to their identity provider.
- The administrators register through Microsoft Entra multifactor authentication, and all their individual devices are unavailable or the service is unavailable. Users might be unable to complete multifactor authentication to activate a role. For example, a cell network outage is preventing them from answering phone calls or receiving text messages, the only two authentication mechanisms that they registered for their device.
- The person with the most recent Global Administrator access leaves the organization. Microsoft Entra ID prevents the last Global Administrator account from being deleted, but it doesn't prevent the account from being deleted or disabled on-premises. Either situation might make the organization unable to recover the account.
- Unforeseen circumstances such as a natural disaster emergency, during which a mobile phone or other networks might be unavailable.
- All Global Administrator and Privileged Role Administrator role assignments are eligible (not active), activation requires approval, and no approvers are selected (or all selected approvers were removed from the directory). Active Global Administrators and Privileged Role Administrators are the default approvers when none are selected, but because none are active, no one can approve activation and tenant administration is effectively locked.

## Create emergency access accounts

Create two or more emergency access accounts. These accounts should be cloud-only accounts that use the \*.onmicrosoft.com domain and that aren't federated or synchronized from an on-premises environment. At a high level, follow these steps.

1. Find your existing emergency access accounts or [create new cloud-only users](../../fundamentals/how-to-create-delete-users.md#create-a-new-user) and assign them the Global Administrator role.

1. Choose one of these passwordless authentication methods for your emergency access accounts. These methods satisfy the [mandatory multifactor authentication requirements](../authentication/concept-mandatory-multifactor-authentication.md).

    - [Passkey (FIDO2)](../authentication/concept-authentication-passkeys-fido2.md) (Recommended)
    - [Certificate-based authentication](../authentication/concept-authentication-passkeys-fido2.md) if your organization already has a Public Key Infrastructure (PKI) setup

1. Register credentials for the authentication method you chose in the previous step.

    - **Passkey (FIDO2)**: [Enable passkeys (FIDO2) for your organization](../authentication/how-to-authentication-passkeys-fido2.md), then [register a passkey (FIDO2)](../authentication/how-to-register-passkey-with-security-key.md)
    - **Certificate-based authentication**: [Configure certificate-based authentication](../authentication/concept-certificate-based-authentication.md)

1. Review your Conditional Access policies for administrators and ensure that emergency access accounts are explicitly excluded from all policies, including [phishing-resistant multifactor authentication](../conditional-access/policy-admin-phish-resistant-mfa.md) requirements.

    > [!IMPORTANT]
    > Exclude emergency access accounts from all Conditional Access policies. You use these accounts when normal sign-in methods or policies fail, so a Conditional Access policy could block access when you need it most. The phishing-resistant authentication method you registered in the previous step secures the account instead.

1. [Store account credentials safely](#store-account-credentials-safely).

1. [Monitor sign-in and audit logs](#monitor-sign-in-and-audit-logs).

1. [Validate accounts regularly](#validate-accounts-regularly).

## Configuration requirements

When you configure these accounts, ensure the following requirements are met:

- Don't associate emergency access accounts with any individual user in the organization. Store credentials in a known secure location that's available to multiple members of the administration team. Don't connect these accounts with any employee-supplied devices, such as phones. This approach unifies emergency access account management. Most organizations need emergency access accounts not only for Microsoft Cloud infrastructure, but also for on-premises environments, federated SaaS applications, and other critical systems.

    Alternatively, you can choose to create individual emergency access accounts for administrators. This solution promotes accountability and allows administrators to use emergency access accounts from remote locations.

- Use strong authentication for your emergency access accounts and make sure it doesn't use the same authentication methods as your other administrative accounts. For example, if your normal administrator account uses the Microsoft Authenticator app for strong authentication, use a FIDO2 security key for your emergency accounts. To avoid adding external requirements into the authentication process, consider the [dependencies of various authentication methods](~/architecture/resilience-in-credentials.md).

- The device or credential must not expire or be in scope of automated cleanup due to lack of use.  

- In Microsoft Entra Privileged Identity Management, make the Global Administrator role assignment active permanent rather than eligible for your emergency access accounts.

- Individuals authorized to use these emergency access accounts must utilize a designated, secure workstation or similar client computing environment, such as a Privileged Access Workstation. Use these workstations when interacting with the emergency access accounts. For more information about configuring a Microsoft Entra tenant where there are designated workstations, see [deploying a privileged access solution](/security/privileged-access-workstations/privileged-access-deployment).

## Federation guidance

Some organizations use Active Directory Domain Services and Active Directory Federation Service (AD FS) or similar identity provider to federate to Microsoft Entra ID. Keep the emergency access for on-premises systems and the emergency access for cloud services distinct, with no dependency of one on the other. Mastering or sourcing authentication for accounts with emergency access privileges from other systems adds unnecessary risk if an outage occurs in those systems.

## Store account credentials safely

Ensure that the credentials for emergency access accounts are kept secure and known only to individuals who are authorized to use them. For example, you might use [FIDO2 security keys](../authentication/how-to-authentication-passkeys-fido2.md) for Microsoft Entra ID or smartcards for Windows Server Active Directory. Store credentials in secure, fireproof safes that are in secure, separate locations.

## Monitor sign-in and audit logs

Monitor sign-in and audit log activity from the emergency accounts and trigger notifications to other administrators. When you monitor the activity for emergency access accounts, you can verify these accounts are only used for testing or actual emergencies. You can use Azure Monitor, Microsoft Sentinel, or other tools to monitor the sign-in logs and trigger email and SMS alerts to your administrators whenever emergency access accounts sign in. This section illustrates using Azure Monitor.

### Prerequisites

- [Send Microsoft Entra sign-in logs](~/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs.yml) to Azure Monitor.

### Obtain Object IDs of the emergency access accounts

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

1. Browse to **Entra ID** > **Users**.

1. Search for the emergency access account and select the user's name.

1. Copy and save the Object ID attribute so that you can use it later.

1. Repeat previous steps for second emergency access account.

### Create an alert rule

1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Monitoring Contributor](/azure/role-based-access-control/built-in-roles#monitoring-contributor).

1. Search for and open **Monitor**.

1. In the left menu, select **Alerts**.

1. Select **+ Create** > **Alert rule**. The **Create an alert rule** page opens.

1. On the **Scope** tab: 
    1. In the **Select a resource** pane, find and select your Log Analytics workspace.
    1. Verify that the subscription matches the workspace you configured in the prerequisites.
    1. Select **Apply**.

1. On the **Condition** tab:
    1. From the **Signal name** drop-down, select **Custom log search**.
    1. Set the **Query type** to **Aggregated logs**.
    1. Under **Search query**, enter one of the following queries, inserting the object IDs of the two emergency access accounts.
    
        > [!NOTE]
        > For each additional emergency access account you want to include, add another `or UserId == "ObjectGuid"` to the query.
                
        Sample queries:
        ```kusto
        // Search for a single Object ID (UserID)
        SigninLogs
        | where UserId == "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        | project TimeGenerated, UserPrincipalName, UserId, IPAddress, ResultType, ResultDescription
        ```
        
        ```kusto
        // Search for multiple Object IDs (UserIds)
        SigninLogs
        | where UserId == "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" or UserId == "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        | project TimeGenerated, UserPrincipalName, UserId, IPAddress, ResultType, ResultDescription
        ```
        
        ```kusto
        // Search for a single UserPrincipalName
        SigninLogs
        | where UserPrincipalName == "user@yourdomain.onmicrosoft.com"
        | project TimeGenerated, UserPrincipalName, UserId, IPAddress, ResultType, ResultDescription
        ```

    1. Under **Measurement**, set how to summarize the results of the query:
        1. Select the **Measure**.
        1. Select the **Aggregation type**.
        1. Select the **Aggregation granularity**.
    1. Under **Split by dimensions**, select the **Resource ID column**.
    1. Under **Alert logic**:
        1. Set the **Threshold type** to **Static**.
        1. Set the **Operator** to **Greater than**.
        1. Set the **Threshold value** to **0**.
        1. Set the **Frequency of evaluation** to how often you want the query to run.

        :::image type="content" source="./media/security-emergency-access/alert-logic.png" alt-text="Screenshot of Alert logic settings with example values for Threshold type, Operator, Threshold value, and Frequency of evaluation." lightbox="./media/security-emergency-access/alert-logic.png":::

    1. Select **Next** to proceed.

1. On the **Actions** tab, select an action group to be notified by the alert. If you want to create one, see [Create an action group](#create-an-action-group).

1. On the **Details** tab:
    1. Select the **Severity** of the event. Use **0 - Critical**.
    1. Enter the **Alert rule name** and add an optional description.
    1. Select the **Region**.
    1. Select which **Identity** to use when running the log query.
    1. Under **Advanced options**, select **Enable upon creation**.
    1. Select **Next** to proceed.

1. On the **Tags** tab, add any tags you want to associate with the alert rule.

1. Select **Review + create**, then select **Create**.

### Create an action group

1. Select **Create an action group**.

    :::image type="content" source="./media/security-emergency-access/create-action-group.png" alt-text="Screenshot of the Create an action group screen open to the Basics tab." lightbox="./media/security-emergency-access/create-action-group.png":::

1. On the **Basics** tab, enter the following information:

    - **Subscription** and **Resource group**: Select where to store the action group.
    - **Region**: Select the region for the action group.
    - **Action group name**: Enter a descriptive name.
    - **Display name**: Enter a short name (maximum 12 characters) that appears in notifications.

1. Select **Next: Notifications**.

1. Under **Notification type**, select **Email/SMS message/Push/Voice**.

1. Enter a notification name such as **Notify Global Administrator**.

1. Select **Edit details**, configure the notification methods and contact information, and then select **OK**.

1. Add any other notifications you want to trigger.

1. Select **Next: Actions** to configure any additional automated actions, or select **Review + create** to finish.

### Prepare a post-mortem team to evaluate each emergency access account credential use
 
If the alert is triggered, preserve the logs from Microsoft Entra and other workloads. Conduct a review of the circumstances and the results of the emergency access account usage. This review determines whether the account was used: 

- For a planned drill to validate its suitability
- In response to an actual emergency where no administrator could use their regular accounts
- As a result of misuse or unauthorized usage of the account
 
Next, examine the logs to determine what actions the individual with the emergency access account took to ensure that those actions align with the authorized use of the account. 

## Validate accounts regularly

In addition to training staff members to use emergency access accounts, have an ongoing process to validate that authorized staff can access the emergency access accounts. Regularly conduct drills to validate the functionality of the accounts and to confirm that monitoring and alerting rules are triggered in case an account is misused. At a minimum, perform the following steps at regular intervals:

- Ensure that security-monitoring staff are aware that the account-check activity is ongoing.
- Review and update the list of individuals authorized to use the emergency access account credentials.
- Ensure that the emergency break glass process to use these accounts is documented and current.
- Ensure that administrators and security officers who might need to perform these steps during an emergency are trained on the process.
- Validate that the emergency access accounts can sign in and perform administrative tasks.
- Ensure that users didn't register multifactor authentication or self-service password reset (SSPR) to any individual user's device or personal details. 
- If the accounts are registered for multifactor authentication to a device, for use during sign-in or role activation, ensure that the device is accessible to all administrators who might need to use it during an emergency. Also verify that the device can communicate through at least two network paths that don't share a common failure mode. For example, the device can communicate to the internet through both a facility's wireless network and a cell provider network.
- Regularly change the combinations on any safes and after someone with access leaves the organization.

Perform these steps at regular intervals and for key changes:

- At least every 90 days
- When there's a recent change in IT staff, such as after termination or position change
- When the Microsoft Entra subscriptions in the organization change

## Next steps

- [How to verify that users are set up for mandatory MFA](../authentication/how-to-mandatory-multifactor-authentication.md)
- [Require phishing-resistant multifactor authentication for administrators](../conditional-access/policy-admin-phish-resistant-mfa.md)
- [Securing privileged access for hybrid and cloud deployments in Microsoft Entra ID](security-planning.md)
- [Configure additional protections for privileged roles in Microsoft 365](/microsoft-365/enterprise/protect-your-global-administrator-accounts), if you're using Microsoft 365
- [Start an access review of privileged roles](../../id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md) and [transition existing privileged role assignments to more specific administrator roles](permissions-reference.md)
