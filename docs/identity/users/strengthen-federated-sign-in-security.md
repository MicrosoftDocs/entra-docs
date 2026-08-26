---
title: Strengthen federated sign-in security
description: Learn how Federated Token Validation Policy strengthens federated sign-in security by preventing cross-domain authentication in Microsoft Entra ID.
ms.topic: concept-article
ms.date: 08/25/2026
ai-usage: ai-assisted
# Customer intent: As an identity administrator, I want to understand and prepare for federated token domain validation so that I can prevent cross-domain sign-in without disrupting legitimate authentication.
---

# Strengthen federated sign-in security in Microsoft Entra ID

Organizations can configure Microsoft Entra ID to trust an external identity provider, such as Active Directory Federation Services (AD FS) or another SAML identity provider, for user authentication. Federated authentication remains a secure and recommended deployment model when configured and managed according to Microsoft guidance. In a federated sign-in, the identity provider authenticates the user and issues a federation token. Microsoft Entra ID validates the incoming token and maps it to a user account in the tenant. As part of this process, Entra performs a series of security and policy checks, including token signature validation, trusted issuer and federation trust verification, token lifetime validation, account mapping, and evaluation of applicable Conditional Access and multifactor authentication requirements. When all validations and policy requirements are successfully met, the sign-in is completed.

Federated Token Validation Policy adds an additional defense-in-depth control. The policy helps ensure that the root domain represented by the trusted federation realm is consistent with the root domain of the mapped Microsoft Entra user account. This added domain-consistency validation helps reinforce trust boundaries in tenants that use multiple federated domains.

> [!IMPORTANT]
> The `federatedTokenValidationPolicy` resource and its related Microsoft Graph APIs are available in preview through the `/beta` endpoint. Preview APIs are subject to change. Use of these APIs in production applications isn't supported.

## How federated domains work

A federated domain is a verified Microsoft Entra domain whose authentication is delegated to a trusted identity provider. Federation configuration is represented by an [`internalDomainFederation`](/graph/api/resources/internaldomainfederation) object. This object is typically created as part of federation setup, including common AD FS or other identity-provider configuration experiences. Administrators might not create it directly.

### Simplified federated sign-in flow

1. A user enters a UPN, such as `user@contoso.com`.
1. Microsoft Entra ID identifies the domain as federated and directs authentication to the configured identity provider.
1. The identity provider authenticates the user and returns a signed federation token.
1. Microsoft Entra ID validates the token, including its signature, issuer, validity period, and trust relationship.
1. Microsoft Entra ID maps the assertion to a Microsoft Entra user account.
1. Microsoft Entra ID applies applicable authentication, Conditional Access, and multifactor authentication requirements.
1. Federated Token Validation Policy can apply an additional domain-consistency validation before sign-in completes.

## Existing validation in federated sign-in

Federated authentication relies on established trust between Microsoft Entra ID and the configured identity provider. Before a federated sign-in succeeds, Microsoft Entra ID validates that the token was issued by a trusted federation configuration and that the token can be mapped to a user in the tenant.

Depending on tenant configuration and sign-in context, Microsoft Entra ID can also enforce additional controls such as Conditional Access, multifactor authentication, sign-in risk policies, device requirements, and application authorization. Federated Token Validation Policy doesn't replace these existing protections. It adds another validation layer that helps confirm the federated trust being used aligns with the domain of the Microsoft Entra account being accessed.

## How Federated Token Validation Policy strengthens federation security

The [`federatedTokenValidationPolicy`](/graph/api/resources/federatedtokenvalidationpolicy) resource controls additional validation of federation authentication tokens. It works with the `internalDomainFederation` object, which maps on-premises federated domains to their corresponding Microsoft Entra domains.

When validation is enforced, Microsoft Entra ID compares the federated account or trusted realm root domain with the root domain of the mapped Microsoft Entra account.

If the root domains match, sign-in can continue, subject to all other authentication and policy checks. If the root domains don't match, Microsoft Entra ID rejects the authentication request.

| Scenario | Expected result with strict domain matching |
| --- | --- |
| The federation realm root domain matches the user UPN root domain. | Sign-in can continue, subject to all other authentication and policy checks. |
| The federation realm root domain differs from the user UPN root domain. | Sign-in is blocked by Federated Token Validation Policy. |
| The user UPN uses a child domain of the same root domain. | The policy evaluates the root domain. The child domain isn't treated as a separate root domain. |
| A custom configuration explicitly permits cross-domain behavior. | Cross-domain sign-in can be allowed, but the tenant doesn't receive this additional domain-consistency protection. |

This protection is especially useful in tenants with multiple federated domains because it helps reduce the blast radius of a compromised or misconfigured federated identity provider. It also reinforces trust boundaries between independently managed federated domains in the same tenant.

### What is cross-domain sign-in?

Cross-domain sign-in occurs when a federation token is accepted from one trusted federation realm but maps to a Microsoft Entra user whose UPN belongs to a different root domain.

For example, a token issued through the trust for `domainB.com` maps to a user whose UPN belongs to `domainA.com`.

Some organizations intentionally rely on cross-domain behavior for legacy, merger, acquisition, coexistence, or migration scenarios. Federated Token Validation Policy helps administrators identify and control this behavior more explicitly.

> [!NOTE]
> The comparison is based on root domains. A UPN such as `user@child.contoso.com` has the root domain `contoso.com`. A child domain and its parent root domain aren't automatically treated as unrelated domains for this policy check.

## Additional protection provided by the policy

Federated Token Validation Policy helps prevent one trusted federation realm from being used to authenticate as users assigned to another root domain when those domains should be independently managed.

The relevant attack scenario requires several prerequisites, including:

- A tenant with multiple federated domains or federation realms.
- A compromised, malicious, or improperly controlled trusted identity provider.
- Knowledge of the target user's immutable ID or source anchor.
- An identity provider or identity store capable of issuing or configuring arbitrary source anchor values.

In hybrid identity environments, users are linked to their Microsoft Entra accounts by using an immutable ID, which serves as a persistent identifier across the on-premises directory and cloud. This identifier is commonly stored in the `onPremisesImmutableId` property of the user object in Microsoft Entra ID and often originates from the `ms-DS-ConsistencyGuid` attribute.

If all prerequisites are met, an attacker who controls one trusted federation realm might attempt to issue a token that maps to a user in another realm by asserting that user's [source anchor](~/identity/hybrid/connect/plan-connect-design-concepts.md#sourceanchor). Federated Token Validation Policy helps block this type of cross-domain access when the root domain of the trusted federation realm doesn't match the root domain of the mapped Microsoft Entra user.

### Example cross-realm impersonation scenario

Assume a Microsoft Entra tenant contains:

- Federated domain `idpA.com`.
- Federated domain `idpB.com`.
- A trusted realm object for `idpA.com`.
- A trusted realm object for `idpB.com`.
- External trusted identity provider A.
- External trusted identity provider B.

:::image type="content" source="./media/strengthen-federated-sign-in-security/federated-domain-configuration.png" alt-text="Diagram showing a Microsoft Entra tenant with federation trusts for idpA.com and idpB.com. Identity provider B contains user3 with the same source anchor as user1 from identity provider A.":::

The legitimate configuration includes:

| Location | User | Source anchor |
| --- | --- | --- |
| Microsoft Entra tenant | `user1@idpA.com` | `user1A` |
| Microsoft Entra tenant | `user2@idpB.com` | `user2B` |
| Identity provider A | `user1@idpA.com` | `user1A` |
| Identity provider B | `user2@idpB.com` | `user2B` |

If identity provider B is compromised or permits arbitrary source anchor values, an attacker could create another user:

| Location | User | Source anchor |
| --- | --- | --- |
| Identity provider B | `user3@idpB.com` | `user1A` |

A token issued by identity provider B for `user3@idpB.com` could map to the cloud account for `user1@idpA.com` if only the source anchor mapping succeeds and no domain-consistency validation is enforced.

Setting Federated Token Validation Policy to validate root domains helps prevent this cross-domain access because the token's federation realm root domain and the mapped user's UPN root domain don't match.

### Subdomain sign-in behavior

Sign-ins from subdomains, such as `user@test.contoso.com`, aren't considered cross-domain sign-ins when the domains share the same root domain, such as `contoso.com`. These sign-ins continue to be allowed when Federated Token Validation Policy is enabled.

When a user signs in, Microsoft Entra ID extracts the root domain from the UPN and validates it against the root domain used by the federated identity provider. Sign-in is allowed when the root domains match. Otherwise, sign-in is blocked.

This approach provides appropriate domain validation because subdomains typically share the same federation configuration and issuer as the root domain. If a distinct federation configuration is required, first [promote the subdomain to a root domain](domains-verify-custom-subdomain.md#change-subdomain-to-a-root-domain). The policy then validates it independently.

## How Microsoft is strengthening security

Microsoft uses a stricter default that blocks cross-domain sign-ins when the federation realm root domain and the mapped user UPN root domain don't match. The change applies to federated domains that have an associated `internalDomainFederation` object.

A blocked authentication request is expected to return error `AADSTS5000820`: **Sign-in blocked by Federated Token Validation policy. Contact your administrator for details.**

A custom configuration can permit cross-domain sign-in for intentional scenarios. However, allowing cross-domain sign-in restores previous behavior and removes this additional domain-consistency validation layer.

> [!IMPORTANT]
> A tenant can trust more than one federation realm. Strict domain matching helps ensure that a token from one trusted realm can't be used to sign in as an account assigned to another root domain simply because other token-validation and account-mapping checks succeed.

## Prepare for enforcement

### Review federated domains and federation configurations

Identify all federated domains in the tenant, and confirm which domains have an associated `internalDomainFederation` configuration.

### Identify intentional cross-domain sign-in dependencies

Review intentional cross-domain sign-in scenarios, including:

- Mergers and acquisitions.
- Coexistence environments.
- Shared identity providers.
- Migration projects.
- Configurations where users authenticate through a federation realm that differs from their UPN domain.

### Validate representative sign-in scenarios

Test representative users from parent domains and child domains to help identify common configuration issues. Root-domain comparison can cause a child domain to behave differently from a separate root domain.

Successful testing doesn't guarantee that every sign-in path in the tenant has been exercised or that all users are unaffected after enforcement is enabled.

### Monitor for AADSTS5000820

After enforcement is enabled, monitor Microsoft Entra sign-in logs for `AADSTS5000820` errors. Investigate affected users to identify previously undiscovered cross-domain sign-in dependencies or configuration issues.

### Evaluate policy exceptions carefully

Configure less-restrictive validation settings only when there's a documented business requirement. Disabling or narrowing validation can restore previous behavior for intentional cross-domain scenarios, but it also removes an additional layer of protection that helps reinforce domain trust boundaries.

Organizations that allow cross-domain sign-in should evaluate compensating controls such as multifactor authentication, Conditional Access, trusted identity-provider governance, privileged access controls, and application-authorization policies.

## Policy administration

Microsoft Graph preview provides [Get](/graph/api/federatedtokenvalidationpolicy-get), [List](/graph/api/policyroot-list-federatedtokenvalidationpolicy), and [Update](/graph/api/federatedtokenvalidationpolicy-update) operations for `federatedTokenValidationPolicy`.

For Get and List operations, the documented least-privileged permission is `Policy.Read.All`. The higher-privileged permission is `Policy.ReadWrite.FedTokenValidation`. Supported built-in roles for delegated access include:

- Security Administrator.
- Hybrid Identity Administrator.
- External Identity Provider Administrator.

The [`validatingDomains`](/graph/api/resources/validatingdomains) resource uses the following terminology:

- **Federated account or domain:** The domain associated with the incoming federated token, which is the identity-provider trust being used.
- **Mapped Microsoft Entra account or domain:** The UPN domain of the Microsoft Entra user to which the Microsoft Entra token service resolves the user.
- **Validation:** Verification that the two root domains match. If they don't match, sign-in is blocked.

The `rootDomains` property defines the types of domains to which validation applies.

### `all`

Validates every verified domain in the tenant. This option provides the broadest domain-consistency validation. This option is appropriate for organizations that want to block cross-domain sign-in scenarios or require the strongest validation posture.

- alice@domainA.com signs in by using a token from identity provider A for domainA.com. The root domains match, so sign-in is allowed.
- alice@domainB.com signs in by using a token from identity provider A for domainA.com. The token is associated with domainA.com, but the mapped account belongs to domainB.com. Sign-in is blocked.

### `allFederated`

Validates only users whose mapped Microsoft Entra account domain is federated. Federated domains are protected, while managed domains are excluded from validation. This option is appropriate for organizations that have many federated domains and want to protect federated trusts while leaving managed accounts unaffected.

Assume that domainA.com and domainB.com are federated, and domainC.com is managed:

- alice@domainB.com has a token from identity provider A. The mapped account domain is federated, so validation applies. Because the root domains don't match, sign-in is blocked.
- alice@domainA.com has a token from identity provider A. The mapped account domain is federated, so validation applies. Because the root domains match, sign-in is allowed.
- alice@domainC.com has a token from identity provider A. The mapped account domain is managed, so validation doesn't apply and sign-in is allowed.

### `allManaged`

Validates only users whose mapped Microsoft Entra account domain is managed. Managed domains are protected, while federated domains are excluded from validation. This option is appropriate when an organization wants to protect managed identities from tokens from unrelated federated domains but has historical federated-to-federated cross-domain scenarios that it isn't ready to break.

- alice@domainC.com has a token from identity provider A. The mapped account domain is managed, so validation applies. Because the domains don't match, sign-in is blocked.
- alice@domainD.com has a token from identity provider A. The mapped account domain is managed, so validation applies. Because the domains don't match, sign-in is blocked.
- alice@domainB.com has a token from identity provider A. The mapped account domain is federated, so validation doesn't apply and sign-in is allowed.

### `enumerated`

Blocks sign-in if the user's mapped account domain is included in the specified domain list and the incoming token's root domain doesn't match. This option supports phased rollout. For example, an organization can validate selected domains that are ready for enforcement while temporarily excluding domains that require additional testing or migration.

The following example validates three domains:

```json
{
  "validatingDomains": {
    "@odata.type": "#microsoft.graph.enumeratedDomains",
    "rootDomains": "enumerated",
    "domainNames": [
      "domainA.com",
      "domainB.com",
      "domainC.com"
    ]
  }
}
```

Assume that the tenant also contains `domainD.com` and `domainE.com`:

- `alice@domainA.com` has a token from identity provider B. The mapped account domain is in the enumerated list, so validation applies. Because the domains don't match, sign-in is blocked.
- `alice@domainD.com` has a token from identity provider B. The mapped account domain isn't in the enumerated list, so validation doesn't apply and sign-in is allowed.


### `allManagedAndEnumeratedFederated`

Validates all managed domains and only the federated domains explicitly listed in the policy. Federated domains that aren't listed are excluded from validation. This option provides immediate protection for all managed domains and gradual rollout for federated domains.

Assume that `domainA.com`, `domainB.com`, and `domainC.com` are federated, and `domainD.com` and `domainE.com` are managed. The following example enumerates two federated domains:

```json
{
  "validatingDomains": {
    "@odata.type": "#microsoft.graph.enumeratedDomains",
    "rootDomains": "allManagedAndEnumeratedFederated",
    "domainNames": [
      "domainA.com",
      "domainB.com"
    ]
  }
}
```

Validation applies to:

- `domainD.com` and `domainE.com`, because they're managed.
- `domainA.com` and `domainB.com`, because they're enumerated federated domains.

### `none`

Disables cross-domain validation. No root-domain matching occurs.
This setting can be used to preserve intentional cross-domain sign-in behavior, such as certain legacy, acquisition, coexistence, or migration scenarios. However, it removes the additional domain-consistency protection provided by Federated Token Validation Policy.

For example, `alice@domainB.com` signs in by using a token from identity provider A for `domainA.com`. The token is associated with `domainA.com`, but the mapped user account belongs to `domainB.com`. Because validation is disabled, sign-in is allowed.

> [!WARNING]
> With this option, Microsoft Entra ID doesn't apply the additional validation that checks whether the sign-in domain matches the expected root domain of the mapped account. If a trusted federated identity provider is compromised, malicious, or improperly configured, the impact could extend beyond its intended domain scope. Use this setting only when there's a documented business requirement and appropriate compensating controls are in place.

## Frequently asked questions

### Does this change how the identity provider authenticates the user?

No. The identity provider continues to perform its configured authentication. The additional protection is applied when Microsoft Entra ID validates and maps the returned federation token.

### Does the policy apply only when a tenant has multiple federated domains?

The `federatedTokenValidationPolicy` can exist regardless of the number of domains. Its cross-domain blocking behavior becomes relevant when a token's trusted realm root domain differs from the mapped user's UPN root domain.

### Are subdomains treated as separate domains?

No. Federated Token Validation Policy compares root domains. A child domain such as `child.contoso.com` resolves to the `contoso.com` root domain for this comparison.

### What happens when a sign-in is blocked?

The expected error is `AADSTS5000820`, which indicates that Federated Token Validation Policy blocked the sign-in.

### Can an administrator allow cross-domain sign-in?

Yes. An administrator can allow cross-domain sign-in by configuring the `validatingDomains` resource to use a less-restrictive setting, including [`none`](strengthen-federated-sign-in-security.md#none).

This configuration can be used for intentional cross-domain scenarios but removes the additional domain-consistency validation layer. Organizations should use less-restrictive settings only when required and should apply appropriate compensating controls.

## Next steps

- [Federated Token Validation Policy resource](/graph/api/resources/federatedtokenvalidationpolicy)
- [Get Federated Token Validation Policy](/graph/api/federatedtokenvalidationpolicy-get)
- [Update Federated Token Validation Policy](/graph/api/federatedtokenvalidationpolicy-update)
- [Internal domain federation resource](/graph/api/resources/internaldomainfederation)
- [Microsoft Entra authentication and authorization error codes](~/identity-platform/reference-error-codes.md)
