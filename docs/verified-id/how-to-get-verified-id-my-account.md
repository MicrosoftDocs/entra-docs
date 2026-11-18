---
title: Get Microsoft Entra Verified ID from My Account
description: Get Microsoft Entra Verified ID credentials from My Account through existing VerifiedEmployee issuance or targeted ID verification profiles.
author: rogulati
ms.author: rogulati
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 10/30/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
#customer intent: As a user, I want to get a Verified ID available to my account so that I can present the credential my organization requests.
---

# Get your Microsoft Entra Verified ID from My Account

Use My Account to get Microsoft Entra Verified ID credentials that your organization makes available to you. This article explains which configuration controls each issuance path and how to get a credential in Microsoft Authenticator. Before you begin, review the account and Microsoft Authenticator requirements in Prerequisites.

My Account keeps the existing issuance flow for the tenant-issued `VerifiedEmployee` credential. For other tenant-issued credential types and identity verification provider Verified IDs, availability depends on ID verification profile configuration and user targeting.

My Account self-service issuance starts when you sign in and choose to get a credential. It isn't the My Access access-package request flow or inline issuance during a protected sign-in journey.

## Prerequisites

- An account that can sign in to [My Account](https://myaccount.microsoft.com).
- For `VerifiedEmployee`, access through your organization's existing My Account issuance settings.
- For other tenant-issued credentials or identity verification provider Verified IDs, an ID verification profile that enables self-service issuance and targets your account.
- Microsoft Authenticator to receive the credential.
- Access to the provider's or your organization's issuance site, when that credential uses an external issuance journey.

For administrator setup, prepare Microsoft Entra Verified ID and the applicable issuer or provider configuration. The [tenant setup guide](verifiable-credentials-configure-tenant-quick.md) describes existing workplace credential issuance. Use [Create an ID verification profile](how-to-create-id-verification-profile.md) for profile-based configuration.

Review the [identity verification licensing requirements](../fundamentals/licensing.md#identity-verification) for your intended scenario. Base Verified ID issuance and integrated onboarding or recovery have separate entitlement requirements; getting a credential in My Account doesn't establish eligibility for those integrated journeys.

## Make credentials available for self-service issuance

Administrator configuration controls which credentials My Account offers. `VerifiedEmployee` is a tenant-issued credential, but its discovery and issuance continue to use the existing My Account configuration. Other tenant-issued credential types and identity verification provider Verified IDs use ID verification profiles.

For the profile-based paths, a provider subscription or credential configuration alone isn't enough. The profile must enable self-service issuance and target the signed-in user.

1. Identify the credential you want to offer and its issuance route. Use the table below to select the corresponding configuration.
1. Configure the applicable issuance route:

    - For `VerifiedEmployee`, use the existing My Account issuance and group controls in [Quick Microsoft Entra Verified ID setup](verifiable-credentials-configure-tenant-quick.md#myaccount-available-now-to-simplify-issuance-of-workplace-credentials). This path doesn't move to ID verification profile targeting.
    - For a tenant-issued credential whose type isn't `VerifiedEmployee`, configure an ID verification profile with the **Tenant issued credentials** verification method. Select the credential type and configure the issuance URL for your organization's portal.
    - For an identity verification provider Verified ID, configure an ID verification profile with the **Identity Verification Provider** verification method. Configure the provider through Microsoft Security Store and select it in the profile.

1. For both profile-based paths, enable self-service issuance in the profile and configure the user groups in scope. See [Create an ID verification profile](how-to-create-id-verification-profile.md) for the shared profile setup. Review your organization's issuance destination before making it available to users.
1. Test with an eligible account and an account outside the configured scope. Check the credential offered and the destination reached, not just whether the My Account tile appears.

| Credential offered | Configuration used by My Account | Issuance experience |
| --- | --- | --- |
| Tenant-issued credential with type `VerifiedEmployee`. | Existing My Account issuance settings and group controls. | Continue the existing issuance flow and scan the QR code with Microsoft Authenticator. |
| Tenant-issued credential with a type other than `VerifiedEmployee`. | An ID verification profile using **Tenant issued credentials**, with self-service issuance enabled, an issuance URL, and the user in scope. | Continue to your organization's configured issuance portal to get the credential. |
| Identity verification provider Verified ID. | An ID verification profile using **Identity Verification Provider**, with the provider configured, self-service issuance enabled, and the user in scope. | Open the provider's issuance journey in a new browser tab and receive the provider-issued Verified ID in Microsoft Authenticator. |

## Get a credential from My Account

My Account shows the credentials available to you. A choice of credential isn't a guarantee that another scenario accepts it.

1. Sign in to [My Account](https://myaccount.microsoft.com) with the account your organization uses for this credential.
1. Select **Get my Verified ID**.
1. If more than one credential is offered, select the credential your organization asked you to get. When there's one eligible credential, continue directly to its issuance flow.
1. Complete the applicable issuance path:

    - For the tenant-issued `VerifiedEmployee` credential, scan the displayed QR code with Microsoft Authenticator and complete the existing issuance flow.
    - For a tenant-issued credential whose type isn't `VerifiedEmployee`, follow your organization's issuance portal instructions. The destination comes from the ID verification profile, and the portal handles issuance.
    - For an identity verification provider Verified ID, follow the provider's instructions in the new browser tab, then complete the credential receipt flow in Microsoft Authenticator.

1. Check that the credential is available in Microsoft Authenticator. When another journey requests a credential, present the credential that journey accepts.

> [!NOTE]
> Getting a Verified ID through My Account doesn't complete an identity verification request in another service. If a service asks you to present a Verified ID, follow that service's instructions.

## Troubleshoot getting a Verified ID

| Symptom | Check |
| --- | --- |
| The expected provider Verified ID or non-`VerifiedEmployee` tenant-issued credential isn't offered. | Ask your administrator to check the ID verification profile's credential or provider configuration, self-service issuance setting, and user targeting. |
| A `VerifiedEmployee` credential isn't offered. | Ask your administrator to check the existing My Account issuance settings and group controls, not ID verification profile targeting. |
| Issuance starts but the provider doesn't complete it. | Contact your administrator for help with the provider's issuance experience. |
| Your organization's portal doesn't issue the expected tenant-issued credential. | Contact the portal owner; the portal controls that issuance journey. |

## Related content

- [Plan a verification solution and choose the credential scenario](plan-verification-solution.md).
- [Configure your tenant for Microsoft Entra Verified ID](verifiable-credentials-configure-tenant-quick.md).
- [Configure Verified ID requirements for an access package](../id-governance/entitlement-management-verified-id-settings.md).
