---
title: Learn how to migrate user to Microsoft Entra External ID
description: Learn how to migrate users from another identity provider to Microsoft Entra External ID.
 
author: garrodonnell   
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 02/27/2025
ms.author: godonnell
---

# Migrating users to Microsoft Entra External ID

In this article, you'll learn how to migrate users and credentials from another identity provider, including Azure AD B2C, to Microsoft Entra External ID. This guide will cover two migration methods: pre-migration and seamless migration. With either approach, you'll need to write an application or script that uses the [Microsoft Graph API](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview) to create user accounts in Azure AD B2C.

## Pre-requisites

Before you start migrating users to Microsoft Entra External ID, ensure you have the following:

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Pre-migration

In the pre migration flow, your migration application performs these steps for each user account: 

1. Read the user account from the old identity provider, including its current credentials (username and password). 
1. Create a corresponding account in your Microsoft Entra External ID directory with the current credentials. 

Use the pre migration flow in any of these situations: 

- You have access to a user's plaintext credentials (their username and password). 
- The credentials are encrypted, but you can decrypt them. 
- You do not have access to the user’s plaintext credentials, and will force users to reset their password on next logon. 

For information about programmatically creating user accounts, see [Manage Consumer user accounts with Microsoft Graph](/graph/api/user-post-users?view=graph-rest-1.0&tabs=http#example-2-create-a-user-with-social-and-local-account-identities-in-azure-ad-b2c&preserve-view=true).   

When following this approach to migrate from Azure AD B2C to Microsoft Entra External ID, users will be required to reset their passwords on first log-on to an application that is protected by Microsoft Entra External ID.

You may consider using Microsoft Entra External ID's password-less capabilities which would allow users to continue using applications without having to reset their password.  

When migrating users from Azure AD B2C, you can register the verified email address as a multifactor authentication method by adding the email authentication method to the user object. This can be added to the user object through the Microsoft Graph API [create emailMethod](/graph/api/resources/emailauthenticationmethod) operation.  

## Seamless migration

Use the seamless migration flow if plaintext passwords in the old identity provider are not accessible. For example, when: 

- The password is stored in Azure AD B2C. 
- The password is stored in a one-way encrypted format, such as with a hash function. 
- The password is stored by the legacy identity provider in a way that you can't access. For example, when the identity provider validates credentials by calling a web service. 

### Phase 1: Pre-migration 

In phase 1 of the seamless migration flow, your migration application performs these steps for each user account:

1. Read the user accounts from the old identity provider, including Azure AD B2C. 

1. Create the corresponding user accounts in your Microsoft Entra External ID directory, with random passwords that you generate. 

1. Add an extension attribute to the user account which flags the account for migration. 

### Phase 2: Credentials

In phase 2 of the seamless migration flow, your migration application performs these steps for each user account:

1. Read the Microsoft Entra External ID user account corresponding to the email address entered, and continue if the user requires migration. 

1. If the legacy IdP determines the password is incorrect, return a friendly error to the user. 

1. If the legacy IdP determines the password is correct, use the REST API to write the password to the Microsoft Entra External ID account and change the extension attribute to False. 

Credential migration happens over two stages. Legacy credentials are harvested and stored in Microsoft Entra External ID during Stage 1. After a sufficient number of users have logged in during Stage 1, applications can be migrated to authenticate directly with Microsoft Entra External ID, and the majority of users can continue to use their existing credentials. Users who do not login during Stage 1, would require to reset their password after moving to Stage 2.

The below diagrams illustrates the high level design:

Stage 1 – Harvest credentials from the legacy identity provider and update corresponding accounts in Microsoft Entra External ID.

:::image type="content" source="media/how-to-migrate-users/pre-migration-stage1.png" alt-text="A diagram showing the high level design for stage 1 of credential migration.":::

Stage 2 – Stop harvesting credentials and migrate applications to authenticate with Microsoft Entra External ID. Decommission the legacy identity provider.

:::image type="content" source="media/how-to-migrate-users/pre-migration-stage1.png" alt-text="A diagram showing the high level design for stage 2 of credential migration.":::

To see an example of an Azure AD B2C custom policy and REST API adaptor which follows this design, see the [seamless user migration](https://github.com/azure-ad-b2c/samples/tree/master/policies/migrate-to-entra-external-id-for-customers) sample on GitHub.

## Security

The seamless migration approach uses your own custom REST API to validate a user's credentials against the legacy identity provider.

You must protect your REST API against brute-force attacks. An attacker can submit several passwords in the hope of eventually guessing a user's credentials. To help defeat such attacks, stop serving requests to your REST API when the number of sign-in attempts passes a certain threshold. 

## User attributes

Not all information in the legacy identity provider should be migrated to your Microsoft Entra External ID directory. Identify the appropriate set of user attributes to store in Microsoft Entra External ID before migrating.

**DO** store in Microsoft Entra External ID:

- Username, password, email addresses, phone numbers, membership numbers/identifiers.

- Consent markers for privacy policy and end-user license agreements.

**DO NOT** store in Microsoft Entra External ID:

- Sensitive data like credit card numbers, social security numbers (SSN), medical records, or other data regulated by government or industry compliance bodies.

- Marketing or communication preferences, user behaviors, and insights.

## Directory cleanup

Before you start the migration process, take the opportunity to clean up your directory.

- Identify the set of user attributes to be stored in Microsoft Entra External ID, and migrate only what you need. If necessary, you can create custom attributes to store more data about a user.

- If you're migrating from an environment with multiple authentication sources (for example, each application has its own user directory), migrate to a unified account in Microsoft Entra External ID.

- If multiple applications have different usernames, you can store all of them in an Microsoft Entra External ID user account by using the identities collection. About the password, let the user choose one and set it in the directory. For example, with the seamless migration, only the chosen password should be stored in the Microsoft Entra External ID account.

- Remove unused user accounts, or don't migrate stale accounts.

## Password policy

If the accounts you're migrating have weaker password strength than the [strong password strength](/azure/active-directory/authentication/concept-sspr-policy) enforced by Microsoft Entra External ID, you can disable the strong password requirement. For more information, see [Password policy property](/azure/active-directory-b2c/user-profile-attributes#password-policy-attribute).

## Related content

If you are migrating from Azure AD B2C, the [seamless user migration sample](https://github.com/azure-ad-b2c/samples/tree/master/policies/migrate-to-entra-external-id-for-customers) repository on GitHub contains a seamless migration custom policy example and REST API code sample.
