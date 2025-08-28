---
title: 'Conditional Access Templates: Simplify Security'
description: Learn how Conditional Access templates provide preconfigured policies to secure your environment, aligned with Microsoft recommendations.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: article
ms.date: 07/22/2025
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth
ms.custom:
  - sfi-image-nochange
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:07/22/2025
  - ai-gen-description
---
# Conditional Access policy templates

Conditional Access templates provide a convenient method to deploy new policies aligned with Microsoft recommendations. These templates are designed to provide maximum protection aligned with commonly used policies across various customer types and locations. 

:::image type="content" source="media/concept-conditional-access-policy-common/conditional-access-policies-azure-ad-listing.png" alt-text="Screenshot that shows Conditional Access policies and templates in the Microsoft Entra admin center." lightbox="media/concept-conditional-access-policy-common/conditional-access-policies-azure-ad-listing.png":::

## Template categories

Conditional Access policy templates are organized into the following categories:

# [Secure foundation](#tab/secure-foundation)

Microsoft recommends these policies as the base for all organizations. Deploy these policies as a group.

- [Require multifactor authentication for admins](policy-old-require-mfa-admin.md)
- [Securing security info registration](policy-all-users-security-info-registration.md)
- [Block legacy authentication](policy-block-legacy-authentication.md)
- [Require multifactor authentication for admins accessing Microsoft admin portals](policy-old-require-mfa-admin-portals.md)
- [Require multifactor authentication for all users](policy-all-users-mfa-strength.md)
- [Require multifactor authentication for Azure management](policy-old-require-mfa-azure-mgmt.md)
- [Require compliant or Microsoft Entra hybrid joined device or multifactor authentication for all users](policy-alt-all-users-compliant-hybrid-or-mfa.md)
- [Require compliant device](policy-all-users-device-compliance.md)

# [Zero Trust](#tab/zero-trust)

These policies help support a [Zero Trust architecture](/security/zero-trust/deploy/identity).

- [Require multifactor authentication for admins](policy-old-require-mfa-admin.md)
- [Securing security info registration](policy-all-users-security-info-registration.md)
- [Block legacy authentication](policy-block-legacy-authentication.md)
- [Require multifactor authentication for all users](policy-all-users-mfa-strength.md)
- [Require multifactor authentication for guest access](policy-old-require-mfa-guest.md)
- [Require multifactor authentication for Azure management](policy-old-require-mfa-azure-mgmt.md)
- [Require multifactor authentication for risky sign-ins](policy-risk-based-sign-in.md) **Requires Microsoft Entra ID P2**
- [Require password change for high-risk users](policy-risk-based-user.md) **Requires Microsoft Entra ID P2**
- [Block access for unknown or unsupported device platform](policy-all-users-device-unknown-unsupported.md)
- [No persistent browser session](policy-all-users-persistent-browser.md)
- [Require approved client apps or app protection policies](policy-all-users-device-compliance.md)
- [Require compliant or Microsoft Entra hybrid joined device or multifactor authentication for all users](policy-alt-all-users-compliant-hybrid-or-mfa.md)
- [Require multifactor authentication for admins accessing Microsoft admin portals](policy-old-require-mfa-admin-portals.md)
- [Block access for users with insider risk](policy-risk-based-insider-block.md) **Requires Microsoft Purview**

# [Remote work](#tab/remote-work)

These policies help secure organizations with remote workers.

- [Securing security info registration](policy-all-users-security-info-registration.md)
- [Block legacy authentication](policy-block-legacy-authentication.md)
- [Require multifactor authentication for all users](policy-all-users-mfa-strength.md)
- [Require multifactor authentication for guest access](policy-old-require-mfa-guest.md)
- [Require multifactor authentication for risky sign-ins](policy-risk-based-sign-in.md) **Requires Microsoft Entra ID P2**
- [Require password change for high-risk users](policy-risk-based-user.md) **Requires Microsoft Entra ID P2**
- [Require compliant or Microsoft Entra hybrid joined device for administrators](policy-alt-admin-device-compliand-hybrid.md)
- [Block access for unknown or unsupported device platform](policy-all-users-device-unknown-unsupported.md)
- [No persistent browser session](policy-all-users-persistent-browser.md)
- [Require compliant device](policy-all-users-device-compliance.md)
- [Require approved client apps or app protection policies](policy-all-users-device-compliance.md)
- [Use application enforced restrictions for unmanaged devices](policy-all-users-app-enforced-restrictions.md)

# [Protect administrator](#tab/protect-administrator)

These policies are for highly privileged administrators in your environment, where compromise might cause the most damage.

- [Require multifactor authentication for admins](policy-old-require-mfa-admin.md)
- [Block legacy authentication](policy-block-legacy-authentication.md)
- [Require multifactor authentication for Azure management](policy-old-require-mfa-azure-mgmt.md)
- [Require compliant or Microsoft Entra hybrid joined device for administrators](policy-alt-admin-device-compliand-hybrid.md)
- [Require compliant device](policy-all-users-device-compliance.md)
- [Require phishing-resistant multifactor authentication for administrators](policy-admin-phish-resistant-mfa.md)

# [Emerging threats](#tab/emerging-threats)

Policies in this category provide new ways to protect against compromise.

- [Require phishing-resistant multifactor authentication for administrators](policy-admin-phish-resistant-mfa.md)

---

Find these templates in the [Microsoft Entra admin center](https://entra.microsoft.com) > **Entra ID** > **Conditional Access** > **Create new policy from templates**. Select **Show more** to view all policy templates in each category.

:::image type="content" source="media/concept-conditional-access-policy-common/create-policy-from-template-identity.png" alt-text="Screenshot that shows how to create a Conditional Access policy from a preconfigured template in the Microsoft Entra admin center." lightbox="media/concept-conditional-access-policy-common/create-policy-from-template-identity.png":::

> [!IMPORTANT]
> Conditional Access template policies exclude only the user creating the policy from the template. If your organization needs to [exclude other accounts](~/identity/role-based-access-control/security-emergency-access.md), modify the policy after it's created. You can find these policies in the [Microsoft Entra admin center](https://entra.microsoft.com) > **Entra ID** > **Conditional Access** > **Policies**. Select a policy to open the editor and modify the excluded users and groups to select accounts you want to exclude.

By default, each policy is created in [report-only mode](concept-conditional-access-report-only.md). We recommend organizations test and monitor usage to ensure the intended result before turning on each policy.

Organizations can select individual policy templates and:

- View a summary of the policy settings.
- Edit, to customize based on organizational needs.
- Export the JSON definition for use in programmatic workflows.
   - These JSON definitions can be edited and then imported on the main Conditional Access policies page using the **Upload policy file** option.

## Other common policies

- [Require multifactor authentication for device registration](policy-all-users-device-registration.md)
- [Block access by location](policy-block-by-location.md)
- [Block access except specific apps](policy-block-example.md)

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

## Next steps

- [Simulate sign in behavior using the Conditional Access What If tool.](troubleshoot-conditional-access-what-if.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)
