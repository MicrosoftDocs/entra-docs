---
title: Onboard users with identity verification (Preview)
description: Configure identity verification onboarding workflows, choose an inline or TAP registration path, and review device and guest-account constraints.
author: rogulati
ms.author: rogulati
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 11/12/2026
ms.custom: template-how-to, msecd-doc-authoring-1026
ai-usage: ai-generated
#customer intent: As an identity administrator, I want to configure identity verification during user onboarding so that users verify their identity before registering credentials through a supported flow.
---

# Onboard users with identity verification (Preview)

Use Lifecycle Workflows in Microsoft Entra ID Governance to initiate identity verification before onboarding and configure credential registration when users start. This guide covers pre-hire and new-hire identity-verification templates, inline passkey registration, and a Temporary Access Pass (TAP) alternative with recommended Conditional Access protection.

The identity-verification and passkey-registration walkthrough uses employee onboarding as its example. Guest onboarding is covered separately through the existing TAP flow; TAP support doesn't enable passkey registration for guest accounts.

Before you start, review the roles, policies, and pilot-account settings in [Prerequisites](#prerequisites).

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

- At least the [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) role to create and manage the workflows.
- An [ID verification profile](~/verified-id/how-to-create-id-verification-profile.md) with purpose set to `all` or `onboarding`, and the provider configuration required for your verification journey.
- Pilot user accounts with a populated `otherMails` attribute containing an email address each user can access. The employee example also uses `employeeHireDate` and a rule-based workflow scope.
- Microsoft Authenticator version 6.2610.7075 or later for Android, or version 6.8.58 or later for iOS, installed on pilot users' devices.
- A configured [passkey profile](~/identity/authentication/how-to-authentication-passkeys-fido2.md) for the pilot users. Review its **Enforce attestation** setting before choosing the registration path.
- For manager verification-status emails, a populated manager relationship and a mailbox for the manager.
- For the TAP alternative, an enabled [TAP authentication methods policy](~/identity/authentication/howto-authentication-temporary-access-pass.md#enable-the-temporary-access-pass-policy), eligible users in scope, and the [TAP task prerequisites](lifecycle-workflow-tasks.md#generate-temporary-access-pass-and-send-via-email-to-users-manager). Creating a TAP doesn't make an account eligible to use it.
- If you configure the recommended Conditional Access registration policy, at least the [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role.
- For the recommended Conditional Access-protected registration, an ID verification profile that targets the new-hire pilot group. Review profile priority if multiple profiles apply. Complete the [Verified ID and FaceCheck setup](~/verified-id/how-to-create-id-verification-profile.md#prerequisites) before testing that registration journey.
- For identity-verification status and history review, confirm that tenant-wide **Collect identity verification history** is enabled. Creating an ID verification profile enables collection automatically. See [Identity verification collection prerequisites](~/identity/authentication/concept-authentication-verified-id.md#prerequisites).

Before testing onboarding, review [Configure an onboarding and recovery policy](~/identity/conditional-access/policy-require-identity-verification.md#configure-an-onboarding-and-recovery-policy). The combined **Account onboarding and recovery** user action protects both bootstrap journeys. It is separate from the **Register security information** policy used for the TAP alternative in this guide.

Review the [global onboarding and recovery exclusion](~/identity/conditional-access/policy-require-identity-verification.md#enable-the-global-onboarding-and-recovery-exclusion-preview) with your Conditional Access policy owner. This tenant-wide setting excludes the combined user action from **All resources** policies. Policies targeting the user action still apply, and ordinary application access remains subject to resource-access policies. Configure and test the intended user-action policy rather than using the exclusion as a replacement for protecting onboarding.

## Check guest-account eligibility

Lifecycle Workflows supports [member and guest accounts](workflows-faqs.md#can-i-create-custom-workflows-for-guests), but authentication-method eligibility is separate from workflow support. Keep the guest TAP flow separate from the employee passkey-registration walkthrough. Selecting **User** and **otherMails** as email delivery settings doesn't change TAP eligibility.

1. Determine whether the guest account is internal or external. For the account-type distinctions, see [B2B guest user properties](~/external-id/user-properties.md).
1. Review the [TAP guest-access requirements](~/identity/authentication/howto-authentication-temporary-access-pass.md#guest-access).

    | Account type | TAP boundary |
    |--------------|--------------|
    | **Internal guest** | An internal guest can be issued a TAP, subject to the authentication methods policy. If you use the Lifecycle Workflows TAP task, its task prerequisites also apply. |
    | **External guest** | You can't issue a TAP to the external guest account in the resource tenant. A TAP issued by the user's home tenant can support sign-in under the documented home-tenant and cross-tenant trust conditions. This isn't the resource-tenant TAP task described in this guide. |

1. Use the existing [TAP setup and sign-in guidance](~/identity/authentication/howto-authentication-temporary-access-pass.md) for eligible internal guests. Don't apply the employee passkey-registration walkthrough to guest accounts. [Passkey (FIDO2) registration isn't supported for internal or external guests](~/identity/authentication/how-to-authentication-passkeys-fido2.md#guest-users), and the current preview doesn't add an exception.

The procedures below don't define a guest-specific Verified ID presentation journey.

## Choose a Day 1 registration path

Choose the registration path before creating the new-hire workflow. Day 0 refers to the pre-hire verification phase; Day 1 refers to credential registration when the user starts. These passkey-registration paths don't apply to guest accounts.

1. Review the user's device context and applicable passkey profile.
1. Select the path that matches the configuration.

    | Configuration | Registration path |
    |---------------|-------------------|
    | **A configuration that supports inline registration** | Use **Select verification for Verified ID presentation (Preview)** to present the Verified ID with FaceCheck and complete inline passkey registration. |
    | **iOS with Enforce attestation enabled** | Inline passkey registration through the presentation task isn't supported. Use the TAP alternative. Conditional Access protection for registration is recommended. |
    | **Android work-profile passkey registration** | The inline task doesn't register a passkey in the work profile. Use the TAP alternative in the required work-profile context. Conditional Access protection for registration is recommended. |
    | **A user with an existing strong authentication method** | The onboarding flow redirects to the standard My Sign-ins registration experience instead of inline registration. Don't remove existing authentication methods to force the inline experience. |

1. For the TAP alternative, check TAP task eligibility separately. The existing task documentation lists restrictions on other authentication methods, previous sign-ins, and Microsoft Entra role assignments; TAP isn't a general workaround for those restrictions.

On Android, the user receives the Verified ID in Microsoft Authenticator in the personal profile. The inline presentation task uses that Verified ID with FaceCheck and registers the passkey in the personal profile, not the work profile. This limitation doesn't mean that identity verification or every Android onboarding flow is unsupported.

Using TAP doesn't bypass passkey policy requirements. Keep the required attestation policy in place and use a registration method that satisfies it.

The following diagram summarizes the employee journey and its assurance outcomes. Conditional Access protection is recommended, not required, for using TAP. In the TAP path, completing the recommended CA-protected verification and passkey registration establishes the verified user state, verification event, and high-assurance passkey that TAP alone doesn't establish.

:::image type="complex" source="media/how-to-onboard-users-with-identity-verification/employee-identity-verification-diagram.png" alt-text="Diagram of employee onboarding showing user identity-verification and passkey credential-assurance stamps for inline and TAP paths." lightbox="media/how-to-onboard-users-with-identity-verification/employee-identity-verification-diagram.png":::
The shared pre-hire phase sends a verification invitation to the user's `otherMails` address. The user completes an email one-time passcode (OTP) check and identity verification, then receives a Verified ID in Microsoft Authenticator.

On Day 1, eligible employees follow one of two registration paths. In the inline path, the user opens a presentation invitation protected by email OTP, presents the Verified ID with FaceCheck, and registers a passkey. Completing this flow stamps the user's identity-verification attribute as verified, records the identity-verification event, and establishes High credential assurance for the new passkey. In the TAP path, the user receives a TAP by email and signs in to start security-information registration.

The TAP path shows recommended Conditional Access protection for **Register security information** with the **Require identity verification** grant control. Completing the required Verified ID presentation with FaceCheck and passkey registration stamps the user's identity-verification state as verified, records the identity-verification event, and establishes High credential assurance for the new passkey. A dashed route shows registration without that recommended policy; TAP alone doesn't establish those outcomes. The dashed route isn't a way to skip an enforced policy.

All routes end with an administrator reviewing the user's identity-verification state and events and the registered passkey's credential assurance and provenance. Lifecycle Workflows uses its explicitly selected profile. Conditional Access resolves the user's profile through group membership and profile priority. All paths remain subject to device, account, and passkey-policy eligibility. Guest TAP access follows separate guidance.
:::image-end:::

## Configure pre-hire identity verification

Configure the pre-hire workflow for the employee example. This verification stage is used before either Day 1 registration path.

> [!IMPORTANT]
> In the current release, `otherMails` is the only supported and recommended recipient email property for the two identity-verification link tasks. Other custom extension attributes can appear in the picker, but email one-time passcode (OTP) protection isn't supported for them. This link-protection statement doesn't establish OTP protection for the TAP email.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Lifecycle Workflows Administrator.
1. Browse to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.
1. Select **Pre-hire identity verification initiation (Preview)**.
1. On **Basics**, enter the workflow details and review **Trigger type**. The template's default timing is seven days before `employeeHireDate`; see [Lifecycle Workflows templates](lifecycle-workflow-templates.md) for customization options.
1. On **Configure scope**, define the rule for the intended users. Department values shown in screenshots are examples, not required scope settings.
1. On **Select identity verification profile**, select the profile from **Verified ID Profile**. Its purpose must be `all` or `onboarding`.

    :::image type="content" source="media/create-lifecycle-workflow/select-identity-verification-profile.png" alt-text="Screenshot of the identity verification profile selection page, with the Verified ID Profile dropdown and a link to create a profile." lightbox="media/create-lifecycle-workflow/select-identity-verification-profile.png":::

1. On **Review tasks**, review **Select verification profile for identity verification (Preview)** and **Send manager verification status email (Preview)**.
1. Open the identity-verification task. Set **To recipient** to **User** and **To recipient email address property** to **otherMails**. Select or change the verification profile at the workflow level, not in the task pane.
1. Review the workflow and create it with the scheduling checkbox cleared for the pilot. For the complete wizard procedure, see [Create a lifecycle workflow](create-lifecycle-workflow.md#create-a-lifecycle-workflow-by-using-a-template-in-the-microsoft-entra-admin-center).

The user opens the invitation sent to their `otherMails` address, completes the email OTP check to access the verification link, and completes the configured verification journey to receive a Verified ID in Microsoft Authenticator.

## Configure new-hire inline registration

Use this path only when the device, account, and passkey profile support inline registration.

1. Create a workflow from **New Hire employee onboarding with identity verification (Preview)**.
1. Configure the workflow details and intended scope. The template defaults to running on `employeeHireDate`; see [Lifecycle Workflows templates](lifecycle-workflow-templates.md).
1. On **Select identity verification profile**, select the profile used for the onboarding verification journey.
1. On **Review tasks**, review the default task order: **Enable User Account**, **Select verification for Verified ID presentation (Preview)**, and **Send manager verification status email (Preview)**.
1. Open **Select verification for Verified ID presentation (Preview)**. Set **To recipient** to **User** and **To recipient email address property** to **otherMails**.
1. Review and create the workflow with the scheduling checkbox cleared for the pilot.

The user opens the protected presentation link, presents their Verified ID with FaceCheck, and follows the inline passkey-registration experience. For iOS attestation or Android work-profile constraints, use the alternative below instead.

On successful completion of the inline flow, Microsoft Entra ID stamps the user's identity-verification attribute as `verified` and records the identity-verification event. The new passkey has identity-verified provenance and **High** credential assurance. Review all three outcomes after registration; the user-level state and events are separate from the credential-level assurance. For the shared definitions, see [Identity verification status and history](~/identity/authentication/concept-authentication-methods-manage.md#identity-verification-status-and-history) and [Credential assurance classification](~/identity/authentication/concept-authentication-passkeys-fido2.md#credential-assurance-classification-preview).

## Configure TAP with identity-verification-protected registration

For the employee walkthrough, use the existing TAP task instead of the Day 1 inline presentation task for eligible accounts that need the alternative path. Retain the pre-hire identity-verification workflow. This is a passkey-registration alternative, not the guest TAP access flow.

The recommended TAP onboarding configuration uses a Conditional Access policy with **Require identity verification** to protect security-information registration. This policy isn't required to use TAP. However, TAP issuance or sign-in alone doesn't stamp the user's identity-verification state or establish the new passkey's high-assurance credential stamp.

### Require identity verification for security-information registration

To configure the recommended protection, create this policy before sending the pilot user's TAP. The policy isn't a prerequisite for issuing or emailing a TAP.

Conditional Access doesn't prompt you to select an ID verification profile in the policy. It selects the user's targeted profile based on group membership and profile priority. This selection is separate from the profile explicitly selected in the Lifecycle Workflows wizard.

1. Sign in to the Microsoft Entra admin center as at least a Conditional Access Administrator.
1. Browse to **Entra ID** > **Conditional Access** > **Policies**, and create a policy for the pilot users. Keep your organization's approved emergency access exclusions.
1. Under **Target resources**, select **User actions** and **Register security information**.
1. Under **Grant**, select **Require identity verification**. With this policy configured, registration requires presentation of the user's Verified ID with FaceCheck. If you combine grant controls, don't provide an alternative that allows registration without identity verification.
1. Apply the policy to the pilot before testing the registration journey. A report-only policy doesn't enforce identity verification.

For the registration user action and policy structure, see [Protect security info registration with Conditional Access](~/identity/conditional-access/policy-all-users-security-info-registration.md). That article's existing example isn't the identity-verification policy described here.

### Configure the Day 1 TAP task

Change the registration task, not the pre-hire verification stage.

1. In the new-hire workflow's **Review tasks**, remove **Select verification for Verified ID presentation (Preview)** for this alternative path.
1. Add the existing [Generate Temporary Access Pass and send via email to user's manager](lifecycle-workflow-tasks.md#generate-temporary-access-pass-and-send-via-email-to-users-manager) task. Its settings pane can display **Generate TAP and Send Email**; despite the catalog name, the recipient is configurable.
1. In the TAP task, set **To recipient** to **User** and **To recipient email address property** to **otherMails**. Confirm that the user's address is populated and accessible.
1. Update **Task description** to reflect delivery to the user, for example, "Generate a Temporary Access Pass and email it to the user."
1. For the default TAP email body, confirm that the user's `manager` relationship is populated. Alternatively, provide a custom body under **Email Customization** to remove this default-body manager requirement. The manager's `mail` attribute isn't required for delivery to `otherMails`.
1. Set **Activation duration** and **One time use** within the tenant's TAP policy. Check the hire-date start time and TAP lifetime so that the code is valid when registration starts.
1. Review the remaining new-hire tasks, including account enablement and the manager notification, and create the workflow with the scheduling checkbox cleared for the pilot.

The user signs in with the TAP and starts standard security-information registration. If the recommended Conditional Access policy is configured, it requires the user to present the previously issued Verified ID with FaceCheck before completing credential registration. Completing this verification and passkey-registration journey stamps the user's identity-verification state as `verified`, records the identity-verification event, and establishes **High** credential assurance with identity-verified provenance for the new passkey. Adding a policy without completing the user journey doesn't establish these outcomes; issuing, emailing, or signing in with a TAP alone doesn't establish them either.

For Android work-profile registration, complete credential registration in the intended work-profile context rather than using the personal-profile inline link.

## Verify the onboarding journey

Check workflow execution and user completion separately before expanding beyond the pilot. Keep the pilot workflows enabled (`isEnabled` is `true`) with scheduling disabled (`isSchedulingEnabled` is `false`). Disabling scheduling doesn't prevent on-demand runs; disabling the workflow itself does.

1. [Run the pre-hire workflow on-demand](on-demand-workflow.md) for the pilot user.
1. Confirm that the user can access the invitation through email OTP, complete verification, and receive the Verified ID.
1. Run the selected Day 1 workflow on-demand and check [workflow and task status](check-status-workflow.md).
1. Complete the selected registration path as the pilot user. Confirm that the passkey is registered in the intended device/profile context. If you configured the recommended Conditional Access policy for the TAP alternative, confirm that it resolves the intended ID verification profile through group targeting and priority and requires Verified ID presentation with FaceCheck.
1. [Review the assurance stamps](#review-the-assurance-stamps) for the user and the newly registered passkey separately from the workflow's task status. Successful task execution or email delivery alone doesn't confirm these outcomes.
1. Enable scheduling only after validating the intended user scope and onboarding journey.

The three Preview identity-verification tasks are available in Microsoft Graph `/beta`, not `/v1.0`. Workflow configuration in this guide uses the Microsoft Entra admin center; the assurance review below also includes a Microsoft Graph beta query. For workflow API guidance, see [Create a lifecycle workflow by using Microsoft Graph](create-lifecycle-workflow.md#create-a-lifecycle-workflow-by-using-microsoft-graph).

### Review the assurance stamps

Review the user's current identity-verification state, verification events, and the new passkey's credential assurance separately. A `verified` user-level state doesn't establish the assurance of every credential on the account. The passkey's displayed **Credential assurance** classification is **High**, **Medium**, or **Low**, not a second user-level `verified` status.

Before reviewing these outcomes, confirm the following reporting prerequisites:

- **Licensing:** Confirm entitlement to identity-verification status, history, and credential-provenance reporting in [Identity verification licensing](~/fundamentals/licensing.md#identity-verification). A Lifecycle Workflows license alone doesn't establish entitlement to these reports.
- **Collection:** Confirm that tenant-wide **Collect identity verification history** is enabled. Creating an ID verification profile enables collection automatically. See [Identity verification collection prerequisites](~/identity/authentication/concept-authentication-verified-id.md#prerequisites).
- **Read access:** To review the user's **Identity verification** page, use an account assigned the [Security Reader](~/identity/role-based-access-control/permissions-reference.md#security-reader) role. Separately, confirm permission to read the user's passkey details. For the Graph review, also confirm the application's [permissions to read the user's FIDO2 methods](/graph/api/fido2authenticationmethod-list?view=graph-rest-beta&preserve-view=true#permissions). Don't assume the Lifecycle Workflows Administrator role grants these reporting or Graph permissions.

These checks establish whether you can view the outcomes; they don't establish that verification or registration succeeded. This read-only review doesn't require permissions to overwrite identity-verification events or credential provenance. An unavailable view isn't evidence that verification failed.

1. In the Microsoft Entra admin center, open the pilot user's **Identity verification** page. Review the current status and the verification event for the completed Day 1 journey. This page is separate from **Authentication methods**. See [Identity verification status and history](~/identity/authentication/concept-authentication-methods-manage.md#identity-verification-status-and-history).
1. On the user's **Authentication methods** page, open the passkey registered during this pilot. Review its **Credential assurance** classification and [credential provenance](~/identity/authentication/concept-authentication-passkeys-fido2.md#credential-provenance).
1. In Microsoft Graph Explorer, sign in to the same pilot tenant with the [permissions to read the user's FIDO2 methods](/graph/api/fido2authenticationmethod-list?view=graph-rest-beta&preserve-view=true#permissions). Run this preview query, replacing `{userObjectId}` with the pilot user's object ID:

    ```http
    GET https://graph.microsoft.com/beta/users/{userObjectId}/authentication/fido2methods?$select=provenance
    ```

1. Confirm that the newly registered method includes `provenance`. Check the credential's assurance outcome, not just the presence of that property. If you collect review evidence, redact the response and retain the request ID.
1. Compare the user state, verification event, and credential assurance with the expected outcome for the completed journey:

    | Completed journey | User identity-verification state | Identity-verification event | New passkey credential assurance |
    |-------------------|----------------------------------|-----------------------------|----------------------------------|
    | Inline Verified ID presentation with FaceCheck and passkey registration | Stamped as `verified`. | Recorded for the completed verification. | **High**, with identity-verified provenance. |
    | TAP sign-in followed by CA-required Verified ID presentation with FaceCheck and passkey registration | Stamped as `verified`. | Recorded for the completed verification. | **High**, with identity-verified provenance. |
    | TAP-only registration without the recommended identity-verification policy | TAP alone doesn't establish this stamp. | TAP alone isn't an identity-verification event. | TAP alone doesn't establish a high-assurance stamp. |

The TAP-only row describes what TAP establishes, not the user's existing verification state or the assurance of other passkeys. If an expected stamp is missing, don't treat workflow success or email delivery as confirmation of high-assurance onboarding.

For the shared reporting model and investigation guidance, see [Identity verification reporting](~/identity/authentication/howto-authentication-methods-activity.md#identity-verification-reporting). Registering a new passkey in an identity-verified journey is distinct from using an existing passkey with identity verification; see [Credential assurance classification](~/identity/authentication/concept-authentication-passkeys-fido2.md#credential-assurance-classification-preview).

## Related content

- [Lifecycle Workflows templates](lifecycle-workflow-templates.md)
- [Lifecycle workflow tasks](lifecycle-workflow-tasks.md)
- [Configure Temporary Access Pass](~/identity/authentication/howto-authentication-temporary-access-pass.md)
