---
title: Configure Microsoft Entra Private Access sign-in every time
description: Configure, test, and deploy sign-in every time for selected Microsoft Entra Private Access apps with one Conditional Access policy and an enforced pilot.
ms.topic: how-to
ms.date: 11/02/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
ms.author: alexpav
# Customer intent: As an administrator, I want to configure and test sign-in every time for selected private applications so that I can deploy reauthentication with an appropriate scope.
---

# Configure sign-in every time for Microsoft Entra Private Access (preview)

As an administrator, use Microsoft Entra Private Access sign-in every time (preview) to require reauthentication for selected sensitive private applications. Select applications, configure one Conditional Access policy, test enforcement with a pilot group, and expand deployment.

Before you begin, review the prerequisites, including the Global Secure Access client for Windows, version 2.34.222 or later. Decide whether to exclude other platforms or block their access before you enable the policy.

## Prerequisites

- A configured Global Secure Access Private Access setup, using [Quick Access](how-to-configure-quick-access.md) or [per-app access](how-to-configure-per-app-access.md).
- A [Microsoft Entra Private Access license](overview-what-is-global-secure-access.md#licensing-overview).
- The [Global Secure Access client for Windows](how-to-install-windows-client.md), version **2.34.222 or later**, on supported pilot devices.
- At least the [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role to create and manage the policy.

## Select applications and pilot users

Start with specific higher-risk applications rather than all private applications. Choose applications where reauthentication adds protection and where the additional authentication prompts are appropriate for the users' work.

Sign-in every time works with both Quick Access and per-app access. We recommend per-app targeting to avoid unexpected prompts for other resources included in a broad Quick Access configuration. For example, Windows devices joined to an on-premises domain periodically check in with a domain controller, which may trigger a sign in frequency related authentication prompt without an explicit user action. Setting up sign-in every time for specific per-app resources that require it helps avoid unexpected sign in prompts.

As a deployment best practice, we also recommend following [Manage emergency access accounts in Microsoft Entra ID](~/identity/role-based-access-control/security-emergency-access.md). Your emergency access accounts should be excluded from blocking policies, including the 'sign-in every time' policies.

1. Work with application owners to identify the applications that need sign-in every time. For example:

    | Application | Example use |
    | --- | --- |
    | Administrator jump box | System administrators connect through SSH or RDP to manage sensitive infrastructure |
    | Financial system | Staff submit or approve payments or other financial transactions |
    | Healthcare system | Authorized staff access patient records or other sensitive clinical data |

1. Understand that this feature is triggered when a new network connection is established to the protected private application. It doesn't guarantee a fresh prompt for every command, transaction, or patient record. For the timing example, see [Reauthentication interval](concept-private-access-sign-in-every-time.md#reauthentication-interval).
1. Identify the corresponding Private Access enterprise applications. If the resources are part of a broad Quick Access configuration, consider [per-app access segmentation](tutorial-private-access-app-segmentation.md) to target them individually.
1. Select a small pilot group that represents the applications and client platforms you plan to support. Confirm that the sign-in frequency policies work as expected for these applications.
1. Optionally, you could use **Report Only** mode in Conditional Access to validate which users the policy would apply to, and then use the Global Secure Access Traffic Logs to validate the versions of GSA client that these users are using.

Use one Conditional Access policy for the selected applications that share this sign-in every time requirement and user scope.

## Choose the platform scope

Decide how to handle unsupported platforms before enforcement. The choice determines whether those users can connect without this policy's sign-in every time protection or are blocked.

1. Choose one of these approaches:

    | Approach | Policy scope | Expected behavior |
    | --- | --- | --- |
    | Enforce only on Windows | Use the **Device platforms** condition to include Windows and leave non-Windows platforms out of scope | Supported Windows clients use sign-in every time. Other platforms aren't subject to this policy and can connect if their other access requirements are satisfied. |
    | Require enforcement across targeted platforms  Don't exclude platforms from the policy | Supported Windows clients use sign-in every time. Global Secure Access blocks access from unsupported platforms or older Windows clients where enforcement applies. |


For more information, see [Supported clients and platforms](concept-private-access-sign-in-every-time.md#supported-clients-and-platforms) and [Conditional Access device platform conditions](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms).

## Create the Conditional Access policy

Create the policy in the **Off** state so you can review its scope before enabling the pilot:

> [!WARNING]
> Don't apply **Every time strict (preview)** to Office 365 applications or broadly to all resources.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a **Conditional Access Administrator**.
1. Browse to **Entra ID** > **Conditional Access** > **Policies** and select **New policy**.
1. Enter a descriptive name, such as **Private Access - Sign-in every time**.
1. Under **Assignments** > **Users**, include your selected pilot users or group.
1. Under **Users** > **Exclude**, configure your intended user or group exclusions. If you use emergency access accounts, we recommend excluding them or their dedicated group, following the [current emergency access guidance](~/identity/role-based-access-control/security-emergency-access.md#conditional-access-considerations).
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, choose **Select resources** and select the Private Access enterprise applications identified earlier.
1. Under **Conditions** > **Device platforms**, apply your platform decision:

    - For Windows-only enforcement, set **Configure** to **Yes**, choose **Select device platforms** under **Include**, and select **Windows**.
    - For enforcement across targeted platforms, leave the device platform condition unconfigured so it doesn't remove unsupported platforms from scope.

1. Under **Access controls** > **Session**, select **Sign-in frequency**, choose **Every time strict (preview)**, and select **Select**.
1. Set **Enable policy** to **Off** and select **Create**.
1. Review the saved policy's applications, pilot users, platform condition, and exclusions before enabling it.

> [!IMPORTANT]
> Select **Every time strict (preview)**. The **Every time** option does not apply to Global Secure Access private applications.

## Test with an enforced pilot

Enable the policy only for the selected pilot users and applications. Test actual access and prompts before expanding the policy.

1. Review your intended exclusions and verify that your recovery process works. If you use emergency access accounts, confirm that they're excluded as recommended. Notify pilot users and application owners before enforcement.
1. Open the saved policy, set **Enable policy** to **On**, and select **Save**.
1. Use a Windows pilot device with Global Secure Access client **2.34.222 or later**. Wait more than five minutes after the last sign-in to a selected private application, then connect to that application. Complete reauthentication and record the time.
1. Close the application connection. You need to ensure that the application process which initiated the connection is completely closed (this ensures that the network flow is terminated). Reconnect less than five minutes after that authentication and confirm that sign-in every time doesn't trigger another prompt.
1. Close the connection again, again ensuring that the application process exits. Reconnect more than five minutes after the recorded authentication and confirm that reauthentication is required.
1. Repeat the test for the selected applications and representative users. Confirm that users can complete their work after reauthentication.
1. Test the scope and compatibility cases in the following table.

    | Test case | Expected result from this policy |
    | --- | --- |
    | A targeted Windows user has a client earlier than 2.34.222. | Access is blocked where sign-in every time is enforced. |
    | A non-Windows platform is in scope. | Access is blocked because the platform doesn't support this feature. |
    | A non-Windows platform is outside scope under the Windows-only approach. | This policy doesn't enforce sign-in every time. Other policies and access requirements still apply. |
    | A user is excluded, or an application isn't targeted. | This policy doesn't enforce sign-in every time for that access. Other policies and access requirements still apply. |

1. In the Microsoft Entra admin center, browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**. Find the pilot sign-ins and review their **Conditional Access** details. Confirm the expected policy applies or is out of scope, and compare the results with access and prompts observed on the client.

For help investigating policy results, see [Troubleshoot Conditional Access](~/identity/conditional-access/troubleshoot-conditional-access.md). If an expected test fails, resolve it before expanding deployment.

## Expand deployment and monitor

Expand the same policy only after the enforced pilot confirms desired reauthentication behavior. Review client readiness and exclusions for each expansion.

1. Optionally, you could use **Report Only** mode in Conditional Access to validate which users the policy would apply to, and then use the Global Secure Access Traffic Logs to validate the versions of GSA client that these users are using. This will help you understand the impact of the broader enablement.
1. Add approved user groups to the policy in stages, retaining any configured emergency access exclusions. Notify each group about reauthentication and supported clients.
1. Add further selected Private Access applications under **Target resources** in the same policy as needed. Confirm that the policy's user and platform scope is appropriate for each addition, and repeat the pilot tests.
1. Monitor sign-in results, unexpected access failures, and user feedback. Check that platform exclusions remain consistent with the access requirements agreed with application owners.
1. If enforcement causes unexpected disruption, open the sign-in every time policy and set **Enable policy** to **Off**, then select **Save**. Alternatively, reduce its scope to the validated pilot users and applications. Leave other security policies in place and verify recovery before retrying rollout.

## Related content

- [Microsoft Entra Private Access sign-in every time overview](concept-private-access-sign-in-every-time.md).
- [Apply Conditional Access policies to Private Access apps](how-to-target-resource-private-access-apps.md).
- [Plan a Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md).
