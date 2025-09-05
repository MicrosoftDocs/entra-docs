---
title: Filter for applications in Conditional Access policy
description: Discover how to use Conditional Access filters for applications to streamline policy management and enhance security in Microsoft Entra ID.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 07/22/2025
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: calebb, oanae
ms.custom:
  - subject-rbac-steps
  - ai-gen-docs-bap
  - ai-gen-description
  - ai-seo-date:07/22/2025
---
# Conditional Access: Filter for applications

Currently Conditional Access policies can be applied to all apps or to individual apps. Organizations with a large number of apps might find this process difficult to manage across multiple Conditional Access policies.

Application filters for Conditional Access allow organizations to tag service principals with custom attributes. These custom attributes are then added to their Conditional Access policies. Filters for applications are evaluated at token issuance runtime, not configuration.

In this document, you create a custom attribute set, assign a custom security attribute to your application, and create a Conditional Access policy to secure the application.

## Assign roles

Custom security attributes are security sensitive and can only be managed by delegated users. One or more of the following roles should be assigned to the users who manage or report on these attributes.

| Role name | Description |
| --- | --- |
| [Attribute Assignment Administrator](../role-based-access-control/permissions-reference.md#attribute-assignment-administrator) | Assign custom security attribute keys and values to supported Microsoft Entra objects. |
| [Attribute Assignment Reader](../role-based-access-control/permissions-reference.md#attribute-assignment-reader) | Read custom security attribute keys and values for supported Microsoft Entra objects. |
| [Attribute Definition Administrator](../role-based-access-control/permissions-reference.md#attribute-definition-administrator) | Define and manage the definition of custom security attributes. |
| [Attribute Definition Reader](../role-based-access-control/permissions-reference.md#attribute-definition-reader) | Read the definition of custom security attributes. |

Assign the appropriate role to the users who manage or report on these attributes at the directory scope. For detailed steps, see [Assign Microsoft Entra roles](../role-based-access-control/manage-roles-portal.md#assign-roles-with-tenant-scope).

[!INCLUDE [security-attributes-roles](../../includes/security-attributes-roles.md)]

## Create custom security attributes

Follow the instructions in the article, [Add or deactivate custom security attributes in Microsoft Entra ID](~/fundamentals/custom-security-attributes-add.md) to add the following **Attribute set** and **New attributes**.

- Create an **Attribute set** named *ConditionalAccessTest*.
- Create **New attributes** named *policyRequirement* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**. We add the following predefined values:
   - legacyAuthAllowed
   - blockGuestUsers
   - requireMFA
   - requireCompliantDevice
   - requireHybridJoinedDevice
   - requireCompliantApp

:::image type="content" source="media/concept-filter-for-applications/custom-attributes.png" alt-text="A screenshot showing custom security attribute and predefined values in Microsoft Entra ID." lightbox="media/concept-filter-for-applications/custom-attributes.png":::

> [!NOTE]
> Conditional Access filters for applications only work with custom security attributes of type `string`. Custom Security Attributes support creation of Boolean data type but Conditional Access Policy only supports `string`.

## Create a Conditional Access policy

:::image type="content" source="media/concept-filter-for-applications/edit-filter-for-applications.png" alt-text="A screenshot showing a Conditional Access policy with the edit filter window showing an attribute of require MFA." lightbox="media/concept-filter-for-applications/edit-filter-for-applications.png":::

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Definition Reader](../role-based-access-control/permissions-reference.md#attribute-definition-reader).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
   1. Select **Done**.
1. Under **Target resources**, select the following options:
   1. Select what this policy applies to **Cloud apps**.
   1. Include **Select resources**.
   1. Select **Edit filter**.
   1. Set **Configure** to **Yes**.
   1. Select the **Attribute** we created earlier called *policyRequirement*.
   1. Set **Operator** to **Contains**.
   1. Set **Value** to **requireMFA**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require multifactor authentication**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Configure custom attributes

### Step 1: Set up a sample application

If you already have a test application that makes use of a service principal, you can skip this step.

Set up a sample application that, demonstrates how a job or a Windows service can run with an application identity, instead of a user's identity. Follow the instructions in the article [Quickstart: Get a token and call the Microsoft Graph API by using a console app's identity](~/identity-platform/quickstart-v2-netcore-daemon.md) to create this application.

### Step 2: Assign a custom security attribute to an application

When you don't have a service principal listed in your tenant, it can't be targeted. The Office 365 suite is an example of one such service principal.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator)~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Assignment Administrator](../role-based-access-control/permissions-reference.md#attribute-assignment-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Select the service principal you want to apply a custom security attribute to.
1. Under **Manage** > **Custom security attributes**, select **Add assignment**.
1. Under **Attribute set**, select **ConditionalAccessTest**.
1. Under **Attribute name**, select **policyRequirement**.
1. Under **Assigned values**, select **Add values**, select **requireMFA** from the list, then select **Done**.
1. Select **Save**.

### Step 3: Test the policy

Sign in as a user who the policy would apply to and test to see that MFA is required when accessing the application.

## Other scenarios

- Blocking legacy authentication
- Blocking external access to applications
- Requiring compliant device or Intune app protection policies
- Enforcing sign in frequency controls for specific applications
- Requiring a privileged access workstation for specific applications
- Require session controls for high risk users and specific applications

## Related content

[Conditional Access templates](concept-conditional-access-policy-common.md)

[Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)

[Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
