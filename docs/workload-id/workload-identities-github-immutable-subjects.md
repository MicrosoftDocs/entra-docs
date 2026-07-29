---
title: Migrate GitHub Actions federated credentials to immutable subjects
description: Learn how to migrate a Microsoft Entra federated identity credential for GitHub Actions from a mutable subject to GitHub's immutable subject format.
author: ahmed-mohamed-msft
ms.author: ahmed.m
ms.topic: how-to
ms.custom: msecd-doc-authoring-1018
ms.date: 07/28/2026
ai-usage: ai-generated

#customer intent: As an administrator, I want to migrate my GitHub Actions federated identity credential to an immutable subject so that my trust relationship resists subject recycling.

---

# Migrate GitHub Actions federated credentials to immutable subjects

A Microsoft Entra federated identity credential trusts a GitHub Actions workflow by matching the subject (`sub`) claim in the OpenID Connect (OIDC) token that GitHub issues. GitHub's original subject was built from the repository and owner names, which can be renamed, transferred, or reused. A federated identity credential that trusts a name-based subject is exposed to *subject recycling*, where a different repository or owner later produces a token that matches your credential. To learn more about this risk, see [Mutable subjects in federated identity credentials](workload-identities-federated-credential-mutable-subjects.md).

GitHub now offers an immutable subject format that embeds the immutable repository and owner IDs. This article shows how to migrate an existing federated identity credential to that format without downtime: you create a new credential for the immutable subject, enable immutable subjects in GitHub, validate the workflow, and then remove the old credential.

## Understand the immutable subject format

GitHub's original subject is name-based. For example, a workflow running on the `main` branch of the `contoso/payments-api` repository produces this subject:

```text
repo:contoso/payments-api:ref:refs/heads/main
```

The immutable format keeps the names but appends the immutable owner ID and repository ID, separated by an `@` symbol:

```text
repo:<owner>@<owner_id>/<repo>@<repo_id>:ref:refs/heads/main
```

The owner ID and repository ID are assigned once and never reused, so renaming, transferring, or recreating the repository doesn't change them. A federated identity credential that trusts the immutable subject stays bound to the original repository.

> [!NOTE]
> Immutable subjects apply to GitHub.com. They aren't available on GitHub Enterprise Server.

## Get the immutable repository and owner IDs

To build the immutable subject, get the numeric owner ID and repository ID from GitHub. These IDs are available through GitHub's OIDC settings and REST API.

Combine the names and IDs to form the immutable subject. For example, if the owner `contoso` has the ID `5544123` and the repository `payments-api` has the ID `821093847`, the immutable subject for the `main` branch is:

```text
repo:contoso@5544123/payments-api@821093847:ref:refs/heads/main
```

## Create a federated identity credential for the immutable subject

Create a new federated identity credential for the immutable subject alongside the existing one. Keeping both credentials in place lets the workflow keep running while you validate the change.

Save the credential body to a file, such as `credential.json`, using the immutable subject you built:

```json
{
  "name": "payments-api-main-immutable",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:contoso@5544123/payments-api@821093847:ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}
```

Create the credential with the Azure CLI:

```azurecli
az ad app federated-credential create \
  --id <application-object-id> \
  --parameters ./credential.json
```

Replace `<application-object-id>` with the object ID of your app registration. Create one credential for each subject the workflow presents, such as a different branch or environment.

## Enable immutable subjects in GitHub

Opt the repository into the immutable subject format from the repository or organization OIDC settings. GitHub provides both UI and API controls, and a preview endpoint that shows the subject a workflow emits, so that you can confirm the value before you rely on it. For the current steps, see the [GitHub OpenID Connect reference](https://docs.github.com/en/actions/reference/security/oidc).

After you opt in, GitHub issues tokens that use the immutable subject you configured your credential to match.

> [!NOTE]
> Starting July 15, 2026, GitHub applies the immutable format automatically to repositories that are created, renamed, or transferred. Existing repositories keep the name-based format until you opt in. For details, see [Immutable subject claims for GitHub Actions OIDC tokens](https://github.blog/changelog/2026-04-23-immutable-subject-claims-for-github-actions-oidc-tokens/) in the GitHub Changelog.

## Validate and remove the old credential

After the new credential is in place and GitHub emits the immutable subject, confirm the workflow works and then retire the old credential:

1. Run the GitHub Actions workflow and confirm that it authenticates to Microsoft Entra with the new credential.
1. After the workflow succeeds against the immutable subject, remove the old name-based credential so that no mutable credential remains:

    ```azurecli
    az ad app federated-credential delete \
      --id <application-object-id> \
      --federated-credential-id <old-credential-id>
    ```

    Replace `<application-object-id>` with the object ID of your app registration and `<old-credential-id>` with the ID of the old name-based credential.

Removing the old credential eliminates the dangling, mutable-subject trust and completes the migration.

## Related content

- [Mutable subjects in federated identity credentials](workload-identities-federated-credential-mutable-subjects.md)
- [Configure an app to trust an external identity provider](workload-identity-federation-create-trust.md)
- [Federated identity credentials considerations and limitations](workload-identity-federation-considerations.md)
- [Immutable subject claims for GitHub Actions OIDC tokens (GitHub Changelog)](https://github.blog/changelog/2026-04-23-immutable-subject-claims-for-github-actions-oidc-tokens/)
