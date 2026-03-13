---
title: Migrate users and credentials to Microsoft Entra External ID
description: Learn how to migrate users and credentials from any legacy identity provider to Microsoft Entra External ID.
 
author: garrodonnell   
ms.topic: how-to
ms.date: 05/20/2025
ms.author: godonnell
---

# Migrate users and credentials to Microsoft Entra External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

In this guide, you learn the fundamentals of how to migrate users and credentials from your current identity provider to Microsoft Entra External ID. This guide applies to any legacy identity provider (including Azure AD B2C) and covers directory preparation, bulk user migration, credential migration setup, and the available credential migration approaches.

> [!TIP]
> If you're migrating from Azure AD B2C specifically, see [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md) for B2C-specific decision guidance, password preservation options, and implementation steps.

## Prerequisites

Before you start migrating users to External ID, you need:

- An external tenant. To create one, choose from the following methods:
  - Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Preparation: Directory cleanup

Before starting your user migration process, you should take the time to clean up data in your legacy identity provider directory. Doing this helps ensure that you only migrate the data you need and makes the migration process smoother.

- Identify the set of user attributes to be stored in External ID, and migrate only what you need. If necessary, you can [create custom attributes](concept-user-attributes.md) within External ID to store more data about a user.
- If you're migrating from an environment with multiple authentication sources (for example, each application has its own user directory), migrate to a unified account in External ID. You might need to apply your own business logic to merge and reconcile accounts for the same user from different sources.
- Usernames need to be unique per account in External. If multiple applications use different usernames, you need to apply your own business logic to reconcile and merge accounts. For the password, let the user choose one and set it in the directory. Only the chosen password should be stored in the External ID account.
- Remove unused user accounts, or don't migrate stale accounts.

## Stage 1: Migrate user data

The first step in the migration process is to migrate user data from your legacy identity provider to External ID. This includes usernames and any other relevant attributes. To do this, you need to:

1. Read the user accounts from your legacy identity provider. 
1. Create the corresponding user accounts in your External ID directory. For information about programmatically creating user accounts, see [Manage Consumer user accounts with Microsoft Graph](/graph/api/user-post-users?view=graph-rest-1.0&tabs=http#example-2-create-a-user-with-social-and-local-account-identities-in-azure-ad-b2c&preserve-view=true). 
1. If you have access to users' plaintext passwords, you can set them directly on the new accounts as you are migrating user data. If you don't have access to the plaintext passwords, you should set a random password for now that will be updated later as part of the password migration process. 

> [!NOTE]
> When migrating large numbers of objects, you might encounter throttling limits for Microsoft Graph. See [Throttling limits](/graph/throttling-limits) and [Throttling guidance](/graph/throttling) for best practices to handle or avoid throttling.

Not all information in your legacy identity provider needs to be migrated to your External ID directory. The following recommendations can help you determine the appropriate set of user attributes to store in External ID.

**DO** store in External ID:

- Username, password, email addresses, phone numbers, membership numbers/identifiers.
- Consent markers for privacy policy and end-user license agreements.

**DO NOT** store in External ID:

- Sensitive data like credit card numbers, social security numbers (SSN), medical records, or other data regulated by government or industry compliance bodies.
- Marketing or communication preferences, user behaviors, and insights.

## Alternatives to credential migration

Not every migration requires credential migration. If your users authenticate through social identity providers or enterprise federation, their passwords aren't stored in your directory and don't need to be migrated. You can also skip credential migration if you're moving to passwordless authentication or if you're comfortable having users reset their password via [self-service password reset (SSPR)](how-to-enable-password-reset-customers.md).

## Stage 2: Prepare for credential migration

If you need to preserve existing passwords, prepare user accounts for credential migration before implementing either migration approach. This setup is shared by both the JIT and legacy IdP-initiated approaches described in Stage 3.

### Define an extension property for tracking migration status

Define a directory extension property to track whether each user's credentials have been migrated from the legacy identity provider. Microsoft Graph supports adding custom properties to directory objects through [directory (Microsoft Entra ID) extensions](/graph/extensibility-overview#directory-microsoft-entra-id-extensions).

#### [Graph](#tab/graph)

Create an extension property using the Microsoft Graph API:

``` http
POST https://graph.microsoft.com/v1.0/applications/00001111-aaaa-2222-bbbb-3333cccc4444/extensionProperties 

{ 
    "name": "toBeMigrated", 
    "dataType": "Boolean",
    "targetObjects":[ 
        "User" 
    ] 
} 
```
Replace `00001111-aaaa-2222-bbbb-3333cccc4444` with the object ID of your `b2c-extensions-app` application. The value of this extension should be set to `true` for all users who require migration.

#### [Admin Center](#tab/admin-center)

To create an extension property using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Navigate to **Identity** > **External Identities** > **Custom user attributes**.
1. Select **Add**.
1. Enter the following values:
   - **Name**: Enter a name for the property (for example, `toBeMigrated`).
   - **Data Type**: Select **Boolean**.
   - **Description**: Enter a meaningful description (for example, "Tracks whether the user's password has been migrated from the legacy system").
1. Select **Create**.

---

#### Get the extension property ID

After creating the extension property, you need to retrieve its unique identifier to use in your credential migration implementation. The extension property ID follows this naming convention: `extension_{applicationId-without-hyphens}_{propertyName}`.

To construct your extension property ID:

1. Navigate to **Entra ID** > **App registrations** in the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Select **All applications** from above the application list.
1. Find the application named `b2c-extensions-app` and copy its **Application (client) ID** value.
1. Remove the hyphens from the application ID and combine it with your attribute name.

For example, if your application ID is `00001111-aaaa-2222-bbbb-3333cccc4444` and your attribute name is `toBeMigrated`, your extension property ID would be `extension_00001111aaaa2222bbbb3333cccc4444_toBeMigrated`.

### Generate random strong passwords

Before creating users, generate unique, strong temporary passwords for each user account. These are replaced with the user's actual password from the legacy identity provider once credential migration completes.

> [!IMPORTANT]
> Ensure that the temporary passwords are unique and strong to maintain security during the migration process. Consider using a password generation library or service that meets your organization's security requirements.

### Create users with the migration flag

Create user accounts in your External ID tenant. You can create users through the [Microsoft Entra admin center](https://entra.microsoft.com/) or programmatically using the [Microsoft Graph API](/graph/api/user-post-users). For detailed instructions on user creation, see [How to create, invite, and delete users](/entra/fundamentals/how-to-create-delete-users).

The following example demonstrates how to create a user with the migration extension property set to `true` using the Microsoft Graph API. Replace `{extension-property-id}` with the actual extension property ID you constructed in the previous step.

``` http
POST https://graph.microsoft.com/v1.0/users

{
    "creationType": "LocalAccount",
    "accountEnabled": true,
    "passwordProfile": {
        "forceChangePasswordNextSignIn": false,
        "password": "<unique-generated-random-strong-password>"
    },
    "{extension-property-id}": true
}
```

You can find sample code to support your user migration in the [B2C to MEEID migration tool](https://github.com/microsoft/b2c-to-meeid-migration-tool/).

## Stage 3: Migrate credentials

Once user accounts are prepared with the migration flag, choose a credential migration approach based on where applications authenticate during the migration.

### JIT password migration (External ID-initiated)

In JIT migration, applications have already moved to External ID endpoints. When a user signs in, External ID uses the `OnPasswordSubmit` custom authentication extension to validate the user's credentials against the legacy IdP, writes the password to the External ID account, and flags the account as migrated. Subsequent sign-ins authenticate directly against External ID.

For full implementation instructions, see [Just-in-time password migration](how-to-migrate-passwords-just-in-time.md).

### Legacy IdP-initiated credential harvesting

In this approach, applications remain on the legacy IdP endpoints while a custom policy or flow calls a REST API to validate each user's credentials and write them to the corresponding External ID account. Once enough credentials have been migrated, applications cut over to External ID.

This approach applies when plaintext passwords aren't accessible. For example, if:

- The password is stored by the legacy identity provider in a hashed or encrypted format.
- The password is managed by the legacy identity provider and can only be validated through its own authentication service.

The credential migration process consists of the following steps:

1. When a customer signs in, read the External ID user account corresponding to the email address entered.
1. If the account is already flagged as migrated, continue with normal sign-in.
1. If the account isn't flagged as migrated, validate the password against the legacy identity provider.
    1. If the legacy IdP determines the password is incorrect, return a friendly error to the user.
    1. If the legacy IdP determines the password is correct, write the password to the External ID account and update the migration flag.

Credential migration happens in two phases. First, legacy credentials are harvested and stored in External ID. Then, once credentials have been updated for a sufficient number of users, applications can be migrated to authenticate directly with External ID. Users who haven't been migrated need to reset their password when they sign in for the first time.

The high-level design for the credential migration process is shown in the following diagrams:

Harvest credentials from the legacy identity provider and update corresponding accounts in External ID.

:::image type="content" source="./media/how-to-migrate-users/pre-migration-stage1.png" alt-text="A diagram showing the high-level design for the first phase of credential migration.":::

Stop harvesting credentials and migrate applications to authenticate with External ID. Decommission the legacy identity provider.

:::image type="content" source="./media/how-to-migrate-users/pre-migration-stage2.png" alt-text="A diagram showing the high-level design for the second phase of credential migration.":::

> [!NOTE]
> If you're using this approach, it's important to protect your REST API against brute-force attacks. An attacker can submit several passwords in the hope of eventually guessing a user's credentials. To help defeat such attacks, stop serving requests to your REST API when the number of sign-in attempts passes a certain threshold.

## Related content

- [Migrate to External ID](migrate-to-external-id.md) – Overview of migrating from any legacy CIAM solution.
- [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md) – B2C-specific decision guidance and password preservation options.
- [Just-in-time password migration](how-to-migrate-passwords-just-in-time.md) – Preserve passwords during migration using custom authentication extensions.
- [Custom authentication extensions](/entra/identity-platform/custom-extension-overview) – Invoke external logic during authentication flows.
