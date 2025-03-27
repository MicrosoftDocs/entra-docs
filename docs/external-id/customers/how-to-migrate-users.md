---
title: Learn how to migrate user to Microsoft Entra External ID
description: Learn how to migrate users from another identity provider to Microsoft Entra External ID.
 
author: garrodonnell   
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 04/01/2024
ms.author: godonnell
---

# Migrating users to Microsoft Entra External ID

In this article, you'll learn how to migrate users and credentials from another identity provider, including Azure AD B2C, to Microsoft Entra External ID. This guide will cover different migration methods. With each of these approaches, you'll need to write an application or script that uses the [Microsoft Graph API](/graph/api/resources/identity-network-access-overview) to create user accounts in External ID.



## Pre-requisites

Before you start migrating users to External ID, ensure you have the following:

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Stage 1: Directory cleanup

Before you start the migration process, take the opportunity to clean up your directory.

- Identify the set of user attributes to be stored in External ID, and migrate only what you need. If necessary, you can create custom attributes to store more data about a user.
- If you're migrating from an environment with multiple authentication sources (for example, each application has its own user directory), migrate to a unified account in External ID.
- If multiple applications have different usernames, you can store all of them in an External ID user account by using the identities collection. About the password, let the user choose one and set it in the directory. For example, with the seamless migration, only the chosen password should be stored in the External ID account.
- Remove unused user accounts, or don't migrate stale accounts.

## Stage 2: User Data Migration
In this stage, you will migrate user data from the legacy identity provider to External ID. This includes usernames and any other relevant attributes.

1. Read the user accounts from the old identity provider, including Azure AD B2C. 
1. Create the corresponding user accounts in your External ID directory, with random passwords that you generate. 
1. Add an extension attribute to the user account which flags the account for migration. 

Not all information in the legacy identity provider should be migrated to your External ID directory. Identify the appropriate set of user attributes to store in External ID before migrating.

**DO** store in External ID:

- Username, password, email addresses, phone numbers, membership numbers/identifiers.
- Consent markers for privacy policy and end-user license agreements.

**DO NOT** store in External ID:

- Sensitive data like credit card numbers, social security numbers (SSN), medical records, or other data regulated by government or industry compliance bodies.
- Marketing or communication preferences, user behaviors, and insights.

If you have access to your users' plaintext passwords, you can migrate them directly as part of the user data migration. If you do not have access to the plaintext passwords, you should set a random password for now. This will be updated as part of the credential migration process later. 

For information about programmatically creating user accounts, see [Manage Consumer user accounts with Microsoft Graph](/graph/api/user-post-users?view=graph-rest-1.0&tabs=http#example-2-create-a-user-with-social-and-local-account-identities-in-azure-ad-b2c&preserve-view=true).  

## Stage 3: Password Migration

Password migration is the process of moving user passwords from the legacy identity provider to External ID. You will need to follow this process if plaintext passwords in the old identity provider are not accessible. For example, if: 

- The password is stored in Azure AD B2C. 
- The password is stored in a one-way encrypted format, such as with a hash function. 
- The password is stored by the legacy identity provider in a way that you can't access. For example, when the identity provider validates credentials by calling a web service. 

### Self Service Password Reset (SSPR)
You can use the [Self Service Password Reset (SSPR)](how-to-enable-password-reset-customers.md) feature to allow users to reset their passwords. You will need to set up SSPR in your External ID tenant and configure the password reset policies. You will also need to provide user with instructions on how to reset their passwords using SSPR on first login to the new system.  

### Seamless migration
Seamless migration is a method of migrating user credentials from the legacy identity provider to External ID without requiring users to reset their passwords. This is done by using a custom REST API to validate user credentials against the legacy identity provider during the sign-in process.

This approach allows users to continue using their existing passwords while migrating their accounts to External ID. The seamless migration process consists of the following steps.

1. Add an extension attribute to all user account which flags the accounts for migration. 
1. Read the External ID user account corresponding to the email address entered, and continue if the user requires migration. 
1. If the legacy IdP determines the password is incorrect, return a friendly error to the user. 
1. If the legacy IdP determines the password is correct, use the REST API to write the password to the External ID account and change the extension attribute to False. 

Seamless migration happens over two stages. Legacy credentials are harvested and stored in External ID during Stage 1. After a sufficient number of users have logged in during Stage 1, applications can be migrated to authenticate directly with External ID, and the majority of users can continue to use their existing credentials. Users who do not login during Stage 1, would require to reset their password after moving to Stage 2.

The below diagrams illustrates the high level design:

Stage 1 – Harvest credentials from the legacy identity provider and update corresponding accounts in External ID.

:::image type="content" source="media/how-to-migrate-users/pre-migration-stage1.png" alt-text="A diagram showing the high level design for stage 1 of credential migration.":::

Stage 2 – Stop harvesting credentials and migrate applications to authenticate with External ID. Decommission the legacy identity provider.

:::image type="content" source="media/how-to-migrate-users/pre-migration-stage2.png" alt-text="A diagram showing the high level design for stage 2 of credential migration.":::

## Security

The seamless migration approach uses your own custom REST API to validate a user's credentials against the legacy identity provider.

You must protect your REST API against brute-force attacks. An attacker can submit several passwords in the hope of eventually guessing a user's credentials. To help defeat such attacks, stop serving requests to your REST API when the number of sign-in attempts passes a certain threshold. 

## Password policy

If the accounts you're migrating have weaker password strength than the [strong password strength](/azure/active-directory/authentication/concept-sspr-policy) enforced by External ID, you can disable the strong password requirement. For more information, see [Password policy property](/azure/active-directory-b2c/user-profile-attributes#password-policy-attribute).

## Related content

If you are migrating from Azure AD B2C, the [seamless user migration sample](https://github.com/azure-ad-b2c/samples/tree/master/policies/migrate-to-entra-external-id-for-customers) repository on GitHub contains a seamless migration custom policy example and REST API code sample.
