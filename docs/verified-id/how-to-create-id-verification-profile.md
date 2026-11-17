---
title: Create ID verification profiles in Microsoft Entra Verified ID
description: Create an ID verification profile in Microsoft Entra Verified ID. Configure user scope, verification methods, and claim matching, then deploy to production.
author: rogulati
ms.author: rogulati
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
#customer intent: As an identity administrator, I want to create and deploy an ID verification profile so that users can complete identity verification for recovery, onboarding, or verification at sign-in.
---

# Create an ID verification profile in Microsoft Entra Verified ID

ID verification profiles define how your organization verifies a user's identity for account recovery, onboarding, or verification at sign-in. Each profile specifies its purpose, users in scope, and verification method. It also defines claim-validation rules.

This guide helps identity administrators create and manage profiles in Microsoft Entra Verified ID. Configure account validation, check user readiness for recovery, and move from evaluation to production. Profile creation is separate from enabling the account recovery journey or configuring Conditional Access policies.

Before you begin, check your Verified ID and Face Check setup and the permissions listed in [Prerequisites](#prerequisites).

## Prerequisites

- Microsoft Entra ID P1 or an eligible higher license. See [Identity verification licensing](../fundamentals/licensing.md#identity-verification).
- A tenant in the Microsoft public cloud. This preview isn't available in national or sovereign clouds.
- [Verified ID](verifiable-credentials-configure-tenant-quick.md) enabled and [Face Check](using-facecheck.md) configured in your tenant.
- The [Authentication Policy Administrator](../identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) or [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) role in the tenant. Use Authentication Policy Administrator for least privilege. Use Global Administrator only if no other role combination meets your needs.
- The Contributor or Billing Administrator role for your Azure subscription (required for identity verification provider subscription).
- An identity verification provider configuration or a tenant-issued credential in Verified ID with required claims, such as a photo, depending on the profile purpose. Identity verification providers are configured and purchased through the [Microsoft Security Store](https://securitystore.microsoft.com/).

<!-- TODO: Confirm the target release availability before publication. -->

<a id="open-id-verification-profiles"></a>

## Get started with ID verification profiles

The **Getting started** tab shows the setup checklist and identity verification overview. Use it to review your tenant's setup before creating the first profile:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with the **Authentication Policy Administrator** or **Global Administrator** role.
1. Go to **Verified ID** > **ID verification profiles**.
1. On **Getting started**, review the checklist and complete any tasks needed for your scenario:

    | Setup task | What to configure |
    | --- | --- |
    | **Set up Face Check for Verified ID** | Configure [Face Check](using-facecheck.md) to match a live selfie to a verified credential. |
    | **Choose how to verify identities** | Subscribe to or select an identity verification provider through the [Microsoft Security Store](https://securitystore.microsoft.com/), or use a tenant-issued credential in Verified ID, depending on the profile purpose. |
    | **Turn on passkeys** | For account recovery, enable passkeys (FIDO2) in the Authentication methods policy so users can register a passkey after recovering access. |
    | **Create your first identity verification profile** | Start the wizard to configure the profile's purpose, mode, user groups, verification method, and account validation. |

    :::image type="content" source="media/how-to-create-id-verification-profile/getting-started.png" alt-text="Screenshot of the Getting started tab with the Face Check, verification method, passkeys, and first-profile setup checklist." lightbox="media/how-to-create-id-verification-profile/getting-started.png":::

1. Select **Create your first identity verification profile** to start the wizard. If you already have profiles, select **Profiles** > **Create profile** instead.

The checklist shows your tenant's setup status. The completed tasks in the screenshot are examples, not confirmation that those tasks are complete in your tenant. For account recovery, profile creation doesn't replace [enabling the tenant's Account recovery policy](../identity/authentication/how-to-account-recovery-enable.md).

> [!TIP]
> For account recovery, select **Estimate savings** on the Account recovery overview page to compare potential cost savings and time gained against help desk recovery. For details, see [Estimate cost savings for account recovery](../identity/authentication/how-to-account-recovery-cost-savings-estimator.md).

## Add profile details

Choose the purpose for the scenario you're configuring:

1. Enter a unique **Name** for the profile and, optionally, a **Description**.
1. Select **Profile purpose**.

    | Purpose | Verification method |
    | --- | --- |
    | **All**, **Onboarding**, or **Recovery** | **Identity Verification Provider** only. |
    | **Verification** | **Identity Verification Provider** or **Tenant issued credentials**. Choose one method per profile. |

    For account recovery, select **Recovery**. To use tenant-issued credentials for verification at sign-in, select **Verification**.

1. Select **Next**.

:::image type="content" source="media/how-to-create-id-verification-profile/profile-details.png" alt-text="Screenshot of profile details with name, description, and the four profile-purpose choices." lightbox="media/how-to-create-id-verification-profile/profile-details.png":::

## Choose a profile mode

On the profile mode step, choose how the profile participates in the selected journey:

1. Select a mode:

    | Mode | Behavior |
    | --- | --- |
    | **Evaluation** | Tests identity verification without completing account verification, recovery, or onboarding. Use this mode to validate configuration before production deployment. |
    | **Production** | Enables the end-to-end verification journey for users in scope. Use this mode after validating the profile and the applicable policies. |

1. Review the selected mode, then select **Next**.

> [!NOTE]
> Start with **Evaluation** mode and a small group of users. Successful evaluation doesn't recover an account or complete onboarding. Move the profile to **Production** when you're ready to enable the full journey.

:::image type="content" source="media/how-to-create-id-verification-profile/profile-mode.png" alt-text="Screenshot of Evaluation and Production modes showing their different verification and recovery outcomes." lightbox="media/how-to-create-id-verification-profile/profile-mode.png":::

## Select user groups

Choose the users who should participate in the profile's verification journey:

> [!IMPORTANT]
> **Exclude** applies globally across all identity verification profiles, not just the profile you're editing. These exclusions are also reflected in the **Verified ID** authentication methods policy. Use **Include** to scope a particular profile, and review the tenant-wide impact before changing exclusions.

1. On **User group selection**, use **Include** to choose **Select targets** > **Select groups**. Use **All users** only when you're ready to include the entire tenant.
1. Add the groups that should be in scope. Start with a small group before expanding the deployment.
1. Review **Exclude** carefully. Exclusions are feature-wide.
1. Select **Next**.

:::image type="content" source="media/how-to-create-id-verification-profile/user-groups.png" alt-text="Screenshot of user group selection with a selected group included in the profile." lightbox="media/how-to-create-id-verification-profile/user-groups.png":::

## Select a verification method

The available methods depend on the profile purpose:

1. For **All**, **Onboarding**, or **Recovery**, select **Identity Verification Provider**. Configure and purchase the provider through the Microsoft Security Store. Select the provider after its status shows **Subscribed**.
1. For **Verification**, choose either **Identity Verification Provider** or **Tenant issued credentials**.
1. If you choose **Tenant issued credentials**, select a credential configured in your tenant.
1. Select **Next**.

:::image type="content" source="media/how-to-create-id-verification-profile/verification-method.png" alt-text="Screenshot of the two verification methods available for a Verification-purpose profile.":::

:::image type="content" source="media/how-to-create-id-verification-profile/tenant-issued-credential.png" alt-text="Screenshot of the Tenant issued credentials method with Verified Employee selected.":::

Tenant-issued credentials aren't available for Onboarding or Recovery. If you need tenant-issued credentials, return to **Profile details** and confirm that **Verification** is selected. Create separate profiles if you need both verification methods.

<a id="review-claim-matching"></a>

## Configure account validation

Configure how claims from the selected verification method are matched against user properties in Microsoft Entra ID. You can also use a custom authentication extension to add checks or handle all claim mapping and validation without directory matching.

1. On **Configure account validation**, review the available claims. The claims shown depend on the verification method you selected:

    | Verification method | Claims available for mapping |
    | --- | --- |
    | **Identity Verification Provider** | Claims returned by the selected provider. |
    | **Tenant issued credentials** | Source claims from the Verified ID credential selected in the previous step. |

1. For directory matching, map each credential claim you want to validate to the corresponding Microsoft Entra directory attribute. For example, a provider-based profile can show these name mappings:

    | Verified credential claim | Microsoft Entra directory attribute |
    | --- | --- |
    | First name | `givenName` |
    | Last name | `surname` |

    For a tenant-issued credential, review the claims from that credential and choose the Microsoft Entra attributes to match them against. The available claims aren't limited to the provider-based name mappings shown in this example. If you don't want directory matching, use the [custom-extension-only option](#configure-an-optional-custom-extension) instead.

1. Under **Match confidence**, choose the match rule for each mapping based on your organization's account-validation requirements. **Matches exactly** requires identical values. The **Contains** option allows small name differences.
1. Before production deployment, validate the rules with matching and nonmatching data.

The screenshot shows a provider-based name-matching example. **Matches exactly** and **Contains** are example selections, not recommended defaults. Choose mappings and rules that work with the selected credential, your directory data, and your verification requirements.

:::image type="content" source="media/how-to-create-id-verification-profile/account-validation.png" alt-text="Screenshot of first-name and last-name mappings with example match rules and optional additional checks." lightbox="media/how-to-create-id-verification-profile/account-validation.png":::

For identity verification profiles that use directory matching, verify that the mapped user properties are populated and satisfy the configured match rules before enabling the journey. Blank or mismatched values can prevent account validation. If you use only a custom authentication extension, validate user readiness against the extension's requirements instead.

### Configure an optional custom extension

For account recovery, one custom authentication extension is currently supported. You can link the same extension to multiple identity verification profiles.

Use a custom authentication extension to validate verified claims against your organization's records. The extension can supplement directory matching or replace it entirely:

1. Turn on **Turn on additional checks**.
1. Select an existing **Custom authentication extension**. If you need a new extension, use **Create new extension** and follow [Create a custom authentication extension for account recovery claim validation](../identity-platform/tutorial-custom-authentication-extension-account-recovery.md).
1. Review the claims sent to the extension.
1. Choose how the extension participates in account validation:

    - Select **Use only the custom authentication extension to map and validate claims** if you don't want claims matched against Microsoft Entra directory attributes. The extension handles all claim mapping and validation instead.
    - Leave the checkbox cleared to use directory claim matching together with the extension's additional checks.

If you use only directory matching and don't need a custom extension, leave **Turn on additional checks** off. After reviewing the selected validation approach, select **Next**.

:::image type="content" source="media/how-to-create-id-verification-profile/custom-extension.png" alt-text="Screenshot of additional checks enabled with a custom extension and the extension-only validation option." lightbox="media/how-to-create-id-verification-profile/custom-extension.png":::

## Review Conditional Access

For a **Verification** profile to take effect at sign-in, a Conditional Access policy is required. Choose when to configure that policy:

1. Choose one of these options:

    - **Skip for now** — Complete profile creation and configure the required policy separately before deployment.
    - **Prefill a policy after I create this profile** — Open the Conditional Access policy editor after profile creation.

1. Select **Next** to review the profile.

Creating a profile doesn't automatically create a Conditional Access policy. If you choose to prefill a policy, review and save it separately after creating the profile. Choosing **Skip for now** doesn't remove the policy requirement for verification at sign-in.

:::image type="content" source="media/how-to-create-id-verification-profile/conditional-access.png" alt-text="Screenshot of the options to skip Conditional Access setup or prefill a policy after profile creation." lightbox="media/how-to-create-id-verification-profile/conditional-access.png":::

For recovery policy considerations, see [Protect onboarding and recovery with Conditional Access](../identity/conditional-access/policy-require-identity-verification.md).

<a id="create-and-validate-the-profile"></a>
<a id="review-and-create-the-profile"></a>

## Review and finalize

Review the tenant-wide effect before completing profile creation:

> [!IMPORTANT]
> Creating a profile also turns on Verified ID as an authentication method for all users. Review this tenant-wide change before selecting **Done**.

1. On **Review and finalize**, review each section:

    | Section | What to confirm |
    | --- | --- |
    | **Profile details** | Name, description, and purpose. |
    | **Profile mode** | Evaluation or Production, based on your deployment stage. |
    | **User group** | Included and excluded groups. |
    | **Verification method** | Selected provider or tenant-issued credential. |
    | **Account validation** | Claim mappings and match confidence. |
    | **Custom authentication extension** | Selected extension and whether it supplements or replaces directory matching. |

1. Select **edit** next to a section if you need to change its settings, then return to the review.
1. Confirm that the mode and audience match your deployment plan. The screenshot's **Production** mode and group are examples, not recommended defaults.
1. Select **Done**.
1. Confirm that the profile appears in **Profiles**.
1. Reopen the profile and verify that the saved settings match your choices.

:::image type="content" source="media/how-to-create-id-verification-profile/review-finalize.png" alt-text="Screenshot of a sample profile review with purpose, mode, user group, and verification provider." lightbox="media/how-to-create-id-verification-profile/review-finalize.png":::

:::image type="content" source="media/how-to-create-id-verification-profile/review-validation.png" alt-text="Screenshot of the review summary showing claim mappings, match confidence, and the selected custom authentication extension.":::

## Manage ID verification profiles

> [!NOTE]
> Changes to identity verification profiles can take 5-10 minutes to apply. After saving changes, allow time for them to take effect before testing the affected journey.

Use the **Profiles** tab to review existing profiles and maintain their configuration:

1. Go to **Verified ID** > **ID verification profiles** > **Profiles**.
1. Review each profile's purpose, priority, provider, mode, and status. Use **Search profiles** or **Add filter** to find a profile.
1. Select the profile name to open its configuration, or choose the action you need:

    | Action | Use |
    | --- | --- |
    | **Create profile** | Create another profile for a different configuration or user group. |
    | **Set priority** | Change the evaluation order when a user has access to multiple profiles. Lower numbers are evaluated first, such as 1 before 5. Priority numbers are unique; profiles can't share a priority. |
    | **View audit logs** | Review profile configuration changes. |
    | **Edit columns** | Choose which columns appear in the table. |
    | **Refresh** | Update the profiles list. |
    | Copy action | Duplicate a profile as a starting point for another profile. |
    | Delete action | Remove a profile you no longer need. |

:::image type="content" source="media/how-to-create-id-verification-profile/profiles-list.png" alt-text="Screenshot of the Profiles tab with profile priority, mode, status, management commands, and copy and delete actions." lightbox="media/how-to-create-id-verification-profile/profiles-list.png":::

<!-- TODO: Confirm the existing-profile editing entry point and the copy and delete confirmation controls in the shared-profile experience before publication. -->

## Verify user profiles are ready for account recovery

For recovery profiles that use directory matching, check the user properties mapped in the profile. The steps below apply to profiles that map first-name and last-name claims. For other directory mappings, check the corresponding user properties instead. If the profile uses only a custom authentication extension, validate readiness against the extension's requirements rather than this name-field checklist.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Go to **Entra ID** > **Users** > **All users**, and select a user in the recovery profile's scope.
1. Select **Edit properties**.
1. Confirm that **First name** and **Last name** are filled in and match the user's government-issued identification. Correct blank or inaccurate properties before enabling recovery for that user, and save any changes.
1. Repeat for the users who will participate in your initial rollout.

> [!IMPORTANT]
> For first-name and last-name directory matching, the display name isn't used. Check **First name** and **Last name** against the profile's account-validation rules. Configured custom authentication extensions can provide additional validation or replace directory matching.

<a id="move-a-profile-to-production"></a>

## Move a profile from evaluation to production

After evaluation confirms that verification works for your users, update the profile to enable the full journey:

1. Go to **Verified ID** > **ID verification profiles** > **Profiles** and open the profile.
1. Review its user groups, verification method, claim matching, and any custom extension configuration.
1. Before switching modes, confirm that the selected journey is configured:

    - For account recovery, enable the tenant's Account recovery policy and choose the actions after recovery.
    - For verification at sign-in, configure and save the required Conditional Access policy.
    - For onboarding, complete the onboarding configuration separately from profile creation.

1. Open **Profile mode** and select **Production**.
1. Review the updated configuration and save the profile. Return to **Profiles** and confirm that **Mode** shows **Production**.
1. Validate the complete journey with a small group of users before expanding the profile's scope.

> [!CAUTION]
> Review the users in scope before switching to **Production**. Confirm that only the intended users can participate in the verification journey.

<!-- TODO: Confirm the profile-mode editing and save controls in the shared-profile experience before publication. -->

For a recovery profile, Production mode alone doesn't enable the tenant's Account recovery policy. Configure tenant enablement, Temporary Access Pass (TAP) issuance, and stale-credential cleanup in Account recovery settings.

## Related content

- [Configure account recovery settings](../identity/authentication/how-to-account-recovery-enable.md).
- [Verified ID identity verification overview](../identity/authentication/concept-authentication-verified-id.md).
- [Explore identity verification partners](idv-partners.md).
