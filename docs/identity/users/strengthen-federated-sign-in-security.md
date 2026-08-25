---
title: Strengthen federated sign-in security
description: Learn how Federated Token Validation Policy strengthens federated sign-in security by preventing cross-domain authentication in Microsoft Entra ID.
ms.topic: concept-article
ms.date: 08/18/2026
ai-usage: ai-assisted
# Customer intent: As an identity administrator, I want to understand and prepare for federated token domain validation so that I can prevent cross-domain sign-in without disrupting legitimate authentication.
---

# Strengthen federated sign-in security in Microsoft Entra ID

Organizations can configure Microsoft Entra ID to trust an external identity provider, such as Active Directory Federation Services (AD FS), for user authentication. In a federated sign-in, the identity provider authenticates the user and issues a federation token. Microsoft Entra ID validates the token, maps it to a user in the tenant, and completes the sign-in when all applicable checks succeed.

Federated Token Validation Policy adds a domain-consistency check. It can reject a sign-in when the root domain represented by the trusted federation realm doesn't match the root domain of the mapped Microsoft Entra user account. This check helps preserve the intended security boundary between federated domains in the same tenant.

> [!IMPORTANT]
> The `federatedTokenValidationPolicy` resource and its related Microsoft Graph APIs are available in preview through the `/beta` endpoint. Preview APIs are subject to change. Use of these APIs in production applications isn't supported.

## How federated domains work

A federated domain is a verified Microsoft Entra domain whose authentication is delegated to a trusted identity provider. Federation configuration is represented by an [`internalDomainFederation`](/graph/api/resources/internaldomainfederation) object. This object is typically created as part of federation setup, including common AD FS or other identity-provider configuration experiences. Administrators might not create it directly.

### What is cross-domain sign-in?

Cross-domain sign-in occurs when a federation token is accepted from one trusted federation realm but maps to a Microsoft Entra user whose user principal name (UPN) belongs to a different root domain. For example, a token issued through the trust for domain B maps to a user whose UPN belongs to domain A.

Without strict domain validation, Microsoft Entra ID can accept a token when the token is otherwise valid and the asserted identity maps to a user, even if the issuing trusted realm and the user UPN belong to different domains. In a tenant with multiple trusted federation realms, that behavior can weaken the intended separation between those realms.

> [!NOTE]
> The comparison is based on root domains. A UPN such as `user@child.contoso.com` has the root domain `contoso.com`. A child domain and its parent root domain aren't automatically treated as unrelated domains for this policy check.

### Simplified federated sign-in flow

1. A user enters a UPN, such as `user@contoso.com`.
1. Microsoft Entra ID identifies the domain as federated and directs authentication to the configured identity provider.
1. The identity provider authenticates the user and returns a signed federation token.
1. Microsoft Entra ID validates the token, including its signature and validity, and uses federation data in the token to map the assertion to a Microsoft Entra user.
1. Federated Token Validation Policy determines whether an additional domain-consistency rule should block the sign-in.

## How Federated Token Validation Policy works

The [`federatedTokenValidationPolicy`](/graph/api/resources/federatedtokenvalidationpolicy) resource controls validation of federation authentication tokens. It works with the `internalDomainFederation` object, which maps on-premises federated domains to their corresponding Microsoft Entra ID domains.

When validation is enforced, Microsoft Entra ID compares the federated account or trusted realm root domain with the root domain of the mapped Microsoft Entra account. Users can authenticate successfully only when the verified domain associated with the mapped Microsoft Entra user matches a verified federated domain associated with the authenticating identity provider or trusted realm.

If the root domains don't match, Microsoft Entra ID rejects the authentication request.

| Scenario | Expected result with strict domain matching |
| --- | --- |
| The federation realm root domain matches the user UPN root domain. | Sign-in can continue, subject to all other authentication and policy checks. |
| The federation realm root domain differs from the user UPN root domain. | Sign-in is blocked by Federated Token Validation Policy. |
| The user UPN uses a child domain of the same root domain. | The policy evaluates the root domain. The child domain isn't treated as a separate root domain. |
| A custom configuration explicitly permits cross-domain behavior. | Cross-domain sign-in can be allowed, but this behavior is less secure and is strongly discouraged. |

This protection is especially important in tenants with multiple federated domains because it prevents cross-domain sign-ins that could bypass domain-level trust boundaries.

### Subdomain sign-in behavior

Sign-ins from subdomains, such as `user@test.contoso.com`, aren't considered cross-domain sign-ins when the domains share the same root domain, such as `contoso.com`. These sign-ins continue to be allowed when Federated Token Validation Policy is enabled.

When a user signs in, Microsoft Entra ID extracts the root domain from the UPN and validates it against the root domain used by the federated identity provider. Sign-in is allowed when the root domains match. Otherwise, sign-in is blocked.

This approach provides appropriate security validation because subdomains typically share the same federation configuration and issuer as the root domain. If a distinct federation configuration is required, first [promote the subdomain to a root domain](domains-verify-custom-subdomain.md#change-subdomain-to-a-root-domain). The policy then validates it independently.

## Security risk without the policy

In hybrid identity environments, users are linked to their Microsoft Entra ID accounts by using an immutable ID, which serves as a persistent and unique identifier across both on-premises Active Directory and the cloud. This identifier is important for maintaining consistent identity mapping, especially in tenants with multiple federated domains where each domain is associated with a distinct realm and identity provider, such as AD FS or a SAML identity provider.

The immutable ID is typically stored in the `onPremisesImmutableId` property of the user object in Microsoft Entra ID. This property contains a Base64-encoded value that originates from the on-premises directory, most commonly derived from the `ms-DS-ConsistencyGuid` attribute. This value is known as the [source anchor](~/identity/hybrid/connect/plan-connect-design-concepts.md#sourceanchor) and is a foundational element in Microsoft Entra Connect synchronization and federation scenarios.

When Federated Token Validation Policy isn't enabled, an attacker can exploit cross-realm impersonation in tenants configured with at least two federated domains and two federated realms. If an attacker gains administrative control of a federated identity provider, or control of any identity store and claims-issuance process trusted by that identity provider, the attacker might be able to issue assertions that contain arbitrary identity attributes, including values used for account mapping.

For example, an attacker who controls realm A's identity provider and knows the immutable ID of a user in realm B could:

- Create a spoofed account in realm A that uses that immutable ID.
- Authenticate through realm A.
- Illegitimately access the user's account in realm B.

### Example cross-realm impersonation scenario

Assume a Microsoft Entra tenant contains the following configuration:

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

An attacker could create another user in identity provider B:

| Location | User | Source anchor |
| --- | --- | --- |
| Identity provider B | `user3@idpB.com` | `user1A` |

The legitimate setup between the Microsoft Entra tenant and identity provider A can be replicated in identity provider B if the federated identity provider permits an arbitrary source anchor to be configured. A bad actor can place the source anchor for `user1@idpA.com` on the `user3@idpB.com` user in the on-premises directory or identity store.

During authentication, a SAML token issued by identity provider B for `user3@idpB.com` matches the cloud account of `user1@idpA.com`. This gives the attacker access to that account without knowing credentials, such as a password, for the account in identity provider A.

Setting Federated Token Validation Policy to validate all root domains prevents this type of cross-domain access when the tenant domain of the mapped UPN and the identity provider domain don't match.

## How Microsoft is strengthening security

Microsoft uses a stricter default that blocks cross-domain sign-ins when the federation realm root domain and the mapped user UPN root domain don't match. The change applies to federated domains that have an associated `internalDomainFederation` object.

- A blocked authentication request is expected to return error `AADSTS5000820`: **Sign-in blocked by Federated Token Validation policy. Contact your administrator for details.**
- A custom configuration can permit cross-domain sign-in, but organizations lose an additional layer of domain validation that can help detect configuration issues or unexpected identities.

> [!IMPORTANT]
> A tenant can trust more than one federation realm. Strict domain matching helps ensure that a token from one trusted realm can't be used to sign in as an account assigned to another root domain simply because other token-validation and account-mapping checks succeed.

## Prepare for enforcement

### Review federated domains and federation configurations

Identify all federated domains in the tenant, and confirm which domains have an associated `internalDomainFederation` configuration.

### Identify cross-domain sign-in dependencies

Review intentional cross-domain sign-in scenarios, including:

- Mergers and acquisitions.
- Coexistence environments.
- Shared identity providers.
- Migration projects.
- Configurations where users might authenticate through a federation realm that differs from their UPN domain.

### Validate representative sign-in scenarios

Test representative users from parent domains and child domains to help identify common configuration issues. Root-domain comparison can cause a child domain to behave differently from a separate root domain.

Successful testing doesn't guarantee that every sign-in path in the tenant has been exercised or that all users will be unaffected after enforcement is enabled.

### Review domain and trust relationships

Examine:

- Domain hierarchies.
- Federation trust relationships.
- Identity-provider configurations.
- Scenarios in which users might authenticate through a domain other than their UPN domain.

### Monitor for AADSTS5000820

After enforcement is enabled, monitor Microsoft Entra sign-in logs for `AADSTS5000820` errors. Investigate affected users to identify previously undiscovered cross-domain sign-in dependencies or configuration issues.

### Avoid reducing policy protections

Configure less-restrictive validation settings only when there's a documented business requirement. Evaluate the associated security implications, and ensure that appropriate compensating controls are in place before you make policy exceptions.

> [!IMPORTANT]
> Validation and testing can help identify common configuration issues before enforcement is enabled, but they can't guarantee that all affected sign-in scenarios have been discovered.
>
> Some cross-domain sign-in dependencies might only be revealed during broader production usage. Treat successful testing as risk reduction, not as confirmation that the environment is free of potential `AADSTS5000820` impacts.

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

### `none`

Disables cross-domain validation completely. No root-domain matching occurs. This option is the least secure and is highly discouraged.

For example, `alice@domainB.com` signs in by using a token from identity provider A for `domainA.com`. The token is associated with `domainA.com`, but the mapped user account belongs to `domainB.com`. Because validation is disabled, sign-in is allowed.

> [!WARNING]
> With this option, Microsoft Entra ID doesn't verify that the sign-in domain matches an expected domain for authentication. Organizations lose an additional layer of domain validation that can help detect configuration issues or unexpected identities.
>
> If a federated identity provider is compromised or malicious, it could be abused to authenticate users beyond its authorized domain scope. This configuration can increase the impact of a federation compromise from a single domain to potentially the entire tenant.
>
> If you use this setting, use controls such as multifactor authentication, Conditional Access, trusted identity providers, and application-authorization policies to protect access.

Typical use cases include legacy tenants, complex acquisition scenarios, and organizations that rely on historical cross-domain federation behavior.

### `all`

Validates every verified domain in the tenant. This option is the strictest setting.

- `alice@domainA.com` signs in by using a token from identity provider A for `domainA.com`. The root domains match, so sign-in is allowed.
- `alice@domainB.com` signs in by using a token from identity provider A for `domainA.com`. The token is associated with `domainA.com`, but the mapped account belongs to `domainB.com`. Sign-in is blocked.

This option is appropriate for organizations that want to eliminate all cross-domain sign-in scenarios or require the highest security posture.

### `allFederated`

Validates only users whose mapped Microsoft Entra account domain is federated. Federated domains are protected, while managed domains are excluded from validation.

Assume that `domainA.com` and `domainB.com` are federated, and `domainC.com` is managed:

- `alice@domainB.com` has a token from identity provider A. The mapped account domain is federated, so validation applies. Because the root domains don't match, sign-in is blocked.
- `alice@domainA.com` has a token from identity provider A. The mapped account domain is federated, so validation applies. Because the root domains match, sign-in is allowed.
- `alice@domainC.com` has a token from identity provider A. The mapped account domain is managed, so validation doesn't apply and sign-in is allowed.

This option is appropriate for organizations that have many federated domains and want to protect federated trusts while leaving managed accounts unaffected.

### `allManaged`

Validates only users whose mapped Microsoft Entra account domain is managed. Managed domains are protected, while federated domains are excluded from validation.

- `alice@domainC.com` has a token from identity provider A. The mapped account domain is managed, so validation applies. Because the domains don't match, sign-in is blocked.
- `alice@domainD.com` has a token from identity provider A. The mapped account domain is managed, so validation applies. Because the domains don't match, sign-in is blocked.
- `alice@domainB.com` has a token from identity provider A. The mapped account domain is federated, so validation doesn't apply and sign-in is allowed.

This option is appropriate when an organization wants to protect managed identities from tokens from unrelated federated domains but has historical federated-to-federated cross-domain scenarios that it isn't ready to break.

### `enumerated`

Blocks sign-in if the user's mapped account domain is included in the specified domain list and the incoming token's root domain doesn't match.

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

This option supports a phased rollout. For example, an organization has 50 federated domains and has verified that 20 domains are ready for enforcement and should never allow cross-domain sign-in. The organization configures the 20 domains as validated and leaves the other 30 domains excluded. This configuration lets the organization gradually tighten security, avoid breaking acquisition or legacy trust models, and pilot enforcement before moving to `all`.

### `allManagedAndEnumeratedFederated`

Validates all managed domains and only the federated domains explicitly listed in the policy. Federated domains that aren't listed are excluded from validation.

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

Validation doesn't apply to `domainC.com` because it's federated but isn't included in the enumerated list.

This option provides immediate protection for all managed domains and a gradual rollout for federated domains. For example, an organization has 100 federated domains and 10 managed domains. The organization knows that managed domains should never participate in cross-domain sign-in, but only 15 federated domains have been fully validated for enforcement. The organization can validate all 10 managed domains and the 15 validated federated domains while excluding the remaining 85 federated domains until testing is complete.

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

Yes. An administrator can allow cross-domain sign-in by setting the `rootDomains` property of the `validatingDomains` resource to `none`. This configuration allows sign-in scenarios in which the authentication domain differs from the user's UPN domain.

When this option is enabled, Microsoft Entra ID doesn't verify that the sign-in domain matches an expected domain for authentication. If a federated identity provider is compromised or malicious, it might be able to authenticate users outside its intended domain scope. This configuration can increase the impact of a federation compromise from a single domain to potentially the entire tenant.

Organizations that use this setting should rely on controls such as multifactor authentication, Conditional Access, trusted identity providers, and application-authorization policies.

## Next steps

- [Federated Token Validation Policy resource](/graph/api/resources/federatedtokenvalidationpolicy)
- [Get Federated Token Validation Policy](/graph/api/federatedtokenvalidationpolicy-get)
- [Update Federated Token Validation Policy](/graph/api/federatedtokenvalidationpolicy-update)
- [Internal domain federation resource](/graph/api/resources/internaldomainfederation)
- [Microsoft Entra authentication and authorization error codes](~/identity-platform/reference-error-codes.md)
