---
title: Mutable subjects in federated identity credentials
description: Learn how mutable OIDC subject claims expose Microsoft Entra federated identity credentials to subject recycling, and how immutable claims reduce the risk.
author: ahmed-mohamed-msft
ms.author: ahmed.m
ms.topic: concept-article
ms.custom: msecd-doc-authoring-1018
ms.date: 07/28/2026
ai-usage: ai-generated

#customer intent: As an administrator, I want to understand mutable subjects in federated identity credentials so that I can configure trust in a way that resists subject recycling.

---

# Mutable subjects in federated identity credentials

A mutable subject is an OpenID Connect (OIDC) subject (`sub`) claim value that an external issuer builds from names it allows to change or reuse. Microsoft Entra federated identity credentials establish trust by matching claims from an external issuer's token, especially the `sub` claim. When that subject is derived from a mutable value, the trust relationship can become ambiguous, because the same identifier might later belong to a different workload.

This article explains what makes a subject mutable, the security risks that mutable subjects introduce, and how to anchor trust to an immutable subject so that your federated identity credentials keep trusting only the workload you intended.

## What makes a subject mutable

A subject is mutable when it's derived from values that an issuer allows to change or recycle. Common examples include:

- A project or repository that's renamed, transferred, or deleted and recreated with the same name.
- A group, namespace, or organization handle that's renamed and later reused.
- A user identifier based on a username instead of a stable internal ID.

By contrast, an immutable identifier can't be changed or recycled. It stays permanently anchored to the original resource or workload. Where an issuer exposes immutable identifiers, anchor trust to those values.

## Security risks of mutable subjects

Matching trust against a mutable subject exposes a federated identity credential to two related risks.

### Subject recycling

Subject recycling is the primary risk. It can unfold in the following way:

1. An administrator creates a federated identity credential that trusts a name-based subject.
1. The original resource is deleted, renamed, or transferred.
1. The identifier becomes available again.
1. Another party acquires that identifier.
1. The party's token now produces a subject that matches the existing federated identity credential.
1. The party gains access that was intended only for the original workload.

### Dangling federated identity credentials

A dangling federated identity credential is a credential that remains configured after the workload it trusted no longer exists. Dangling credentials are especially exposed to subject recycling: the trusted name might now be available for reuse, so a token from a different workload can satisfy the match.

## Recommended federated identity credential hygiene

Tenant administrators decide who to trust, and Microsoft Entra provides mechanisms to express that trust precisely. To keep your trust posture strong, follow these practices:

- **Prefer an immutable subject.** Where an issuer exposes an immutable subject, configure a federated identity credential, or a flexible federated identity credential, to match it instead of a name.
- **Delete dangling credentials.** Remove federated identity credentials whose workloads no longer exist.
- **Review regularly.** Audit your federated identity credentials periodically to confirm that they still correspond to the intended workloads and that the matched values remain immutable.
- **Scope least privilege.** Grant only the permissions that the workload requires, so that any mismatch has limited impact.

## Anchor trust to an immutable subject

The strongest way to resist subject recycling is to trust an immutable subject. Some issuers let a workload present a `sub` claim that's built from a stable internal ID instead of a name. When an issuer supports this option, configure your federated identity credential to match the immutable subject.

You can match an immutable subject in two ways:

- A standard federated identity credential matches the `sub` value exactly.
- A [flexible federated identity credential](workload-identities-flexible-federated-identity-credentials.md) matches the `sub` claim by using a claims matching expression, which supports wildcards for cases such as multiple branches or tags.

## GitLab: use an immutable subject

GitLab is an example issuer that historically produced a mutable subject and now offers an immutable option. By default, GitLab builds the `sub` claim from the project path, which is name-based and mutable:

```json
{
  "iss": "https://gitlab.com",
  "sub": "project_path:acme-group/billing-service:ref_type:branch:ref:main"
}
```

Because a group or project path can be renamed, transferred, or reclaimed, a subject that leads with `project_path` is exposed to subject recycling.

GitLab reduces this risk in two ways:

- **Platform protection.** GitLab blocks CI ID token issuance when a namespace path previously belonged to a different project that was deleted or renamed.
- **Immutable subject.** GitLab lets a project present a subject that leads with the immutable `project_id` instead of `project_path`. To enable it, set `ci_id_token_sub_claim_components` to a value such as `["project_id", "ref_type", "ref"]` through the GitLab Projects API. The subject then leads with the project ID:

```json
{
  "iss": "https://gitlab.com",
  "sub": "project_id:57382910:ref_type:branch:ref:main"
}
```

A GitLab subject leads with either `project_path` or `project_id`, never both. Because `project_id` is assigned once and never reused, a subject that leads with it stays bound to the original project even if the path is later renamed or reclaimed.

After a project presents the immutable subject, anchor your Microsoft Entra trust to it. A flexible federated identity credential can match the immutable subject and use a wildcard to cover every branch and tag:

```json
{
  "name": "gitlab-billing-service-immutable",
  "issuer": "https://gitlab.com",
  "claimsMatchingExpression": {
    "value": "claims['sub'] matches 'project_id:57382910:*'",
    "languageVersion": 1
  },
  "audiences": ["api://AzureADTokenExchange"]
}
```
### Add required immutable claims to a flexible federated identity credential

For GitLab, a flexible federated identity credential must match the `sub` claim and one or more of the following additional claims:

- `project_id` identifies the project that runs the job.
- `namespace_id` identifies the project's namespace.
- `user_id` identifies the user who runs the job.

These additional claims are required regardless of whether `sub` starts with `project_path` or `project_id`. Include the claims that represent the intended trust boundary.

The following credential matches an immutable project subject and separately verifies the project and namespace:

```json
{
  "name": "gitlab-billing-service-immutable",
  "issuer": "https://gitlab.com",
  "claimsMatchingExpression": {
    "value": "claims['sub'] matches 'project_id:57382910:*' and claims['project_id'] eq '57382910' and claims['namespace_id'] eq '<namespace-id>'",
    "languageVersion": 1
  },
  "audiences": ["api://AzureADTokenExchange"]
}
```

To restrict trust to jobs run by a specific user, also match `user_id`:

```json
{
  "name": "gitlab-billing-service-user",
  "issuer": "https://gitlab.com",
  "claimsMatchingExpression": {
    "value": "claims['sub'] matches 'project_id:57382910:*' and claims['project_id'] eq '57382910' and claims['namespace_id'] eq '<namespace-id>' and claims['user_id'] eq '<user-id>'",
    "languageVersion": 1
  },
  "audiences": ["api://AzureADTokenExchange"]
}
```

Replace the placeholder values with the IDs from the GitLab ID token. GitLab includes `project_id`, `namespace_id`, and `user_id` in every ID token.

### Create a flexible federated identity credential with the Azure CLI

To create a flexible federated identity credential with the Azure CLI, save the credential body to a file, such as `credential.json`, and post it to Microsoft Graph with `az rest`:

```azurecli
az rest --method POST \
  --uri "https://graph.microsoft.com/beta/applications/<app-object-id>/federatedIdentityCredentials" \
  --headers "Content-Type=application/json" \
  --body "@credential.json"
```

Replace `<app-object-id>` with the object ID of your app registration. Microsoft Graph returns the created credential, including the `claimsMatchingExpression` value, when the request succeeds.

To configure the GitLab subject and the Microsoft Entra credential, see the following resources:

- [GitLab: Connect to cloud services](https://docs.gitlab.com/ci/cloud_services/)
- [GitLab: Use the project ID as the subject](https://docs.gitlab.com/ci/cloud_services/#use-the-project-id-as-the-subject)
- [GitLab: Update a project](https://docs.gitlab.com/api/projects/#update-a-project)
- [Set up a flexible federated identity credential](workload-identities-set-up-flexible-federated-identity-credential.md)

## Related content

- [Flexible federated identity credentials (preview)](workload-identities-flexible-federated-identity-credentials.md)
- [Set up a flexible federated identity credential](workload-identities-set-up-flexible-federated-identity-credential.md)
- [Migrate GitHub Actions federated credentials to immutable subjects](workload-identities-github-immutable-subjects.md)
- [Workload identities](workload-identities-overview.md)
