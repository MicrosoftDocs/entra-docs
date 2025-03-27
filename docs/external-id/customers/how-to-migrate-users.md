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

In this guide, you'll learn the fundamentals of how to migrate users and credentials from your current identity provider, including Azure AD B2C, to Microsoft Entra External ID. This guide will cover a number of different solutions you can use depending on your current configuration. With each of these approaches, you'll need to write an application or script that uses the [Microsoft Graph API](/graph/api/resources/identity-network-access-overview) to create user accounts in External ID.

## Pre-requisites

Before you start migrating users to External ID, ensure you have the following:

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Preparation: Directory cleanup

Prior to starting your user migration process, you should take the time to clean up data in your legacy identity provider directory. This will help ensure that you only migrate the data you need and make the migration process smoother.

- Identify the set of user attributes to be stored in External ID, and migrate only what you need. If necessary, you can create custom attributes within External ID to store more data about a user.
- If you're migrating from an environment with multiple authentication sources (for example, each application has its own user directory), migrate to a unified account in External ID.
- If multiple applications have different usernames, you can store all of them in an External ID user account by using the identities collection. For the password, let the user choose one and set it in the directory. Only the chosen password should be stored in the External ID account.
- Remove unused user accounts, or don't migrate stale accounts.

## Stage 1: User Data Migration

The first step in the migration process is to migrate user data from your legacy identity provider to External ID. This includes usernames and any other relevant attributes. To do this, you will need to:

1. Read the user accounts from your legacy identity provider. 
1. Create the corresponding user accounts in your External ID directory.
1. If you have access to users' plaintext passwords, you can set them directly on the new accounts as you are migrating user data. If you don't have access to the plaintext passwords, you should set a random password for now that will be updated later as part of the password migration process. 

Not all information in your legacy identity provider will need to be migrated to your External ID directory. The following recommendations can help you determine the appropriate set of user attributes to store in External ID.

**DO** store in External ID:

- Username, password, email addresses, phone numbers, membership numbers/identifiers.
- Consent markers for privacy policy and end-user license agreements.

**DO NOT** store in External ID:

- Sensitive data like credit card numbers, social security numbers (SSN), medical records, or other data regulated by government or industry compliance bodies.
- Marketing or communication preferences, user behaviors, and insights.

For information about programmatically creating user accounts, see [Manage Consumer user accounts with Microsoft Graph](/graph/api/user-post-users?view=graph-rest-1.0&tabs=http#example-2-create-a-user-with-social-and-local-account-identities-in-azure-ad-b2c&preserve-view=true).  

## Stage 2: Password Migration

Once you have migrated user data, you'll need to migrate user passwords from the legacy identity provider to External ID. There are two recommended approaches for migrating user passwords: self-service password reset (SSPR) and seamless migration. You'll need to use one of these methods if plaintext user passwords aren't accessible. For example, if: 

- The password is stored in Azure AD B2C. 
- The password is stored in a one-way encrypted format, such as with a hash function. 
- The password is stored by the legacy identity provider in a way that you can't access. For example, when the identity provider validates credentials by calling a web service. 

### Self Service Password Reset (SSPR)

Using the Self Service Password Reset (SSPR) feature in External ID customers can manually set their password the first time they log in to the new system. This approach is simple to implement and doesn't require any custom code.  However, it does require users to reset their passwords manually, which may be inconvenient for some users.

To use this approach you'll first need to set up [SSPR](how-to-enable-password-reset-customers.md) in your External ID tenant and configure the password reset policies. You will then need to provide user with instructions on how to reset their passwords using SSPR when they log in for the first time.

### Seamless migration

If you have a large number of users, or if you want to provide a more seamless experience, you can use the seamless migration approach. This allows users to continue using their existing passwords while migrating their accounts to External ID. To do this you will need to build a custom REST API to validate credentials entered by users against the legacy identity provider during the sign-in process. 

The seamless migration process consists of the following steps:

1. Add an extension attribute to user accounts which flags their migration status. 
1. When a customer signs in, read the External ID user account corresponding to the email address entered. 
1. If a customers account is already flagged as migrated, continue with the sign-in process.
1. If the user's account has not been flagged as migrated, validate the password entered against the legacy identity provider. 
    1. If the legacy IdP determines the password is incorrect, return a friendly error to the user. 
    1. If the legacy IdP determines the password is correct, use the REST API to write the password to the External ID account and change the extension attribute to mark the account as migrated.

Seamless migration happens in two phases. First, legacy credentials are harvested and stored in External ID. Next, after this has been done for a sufficient number of users, applications can be migrated to authenticate directly with External ID. At this point migrated users can continue to use their existing credentials. Any users who have not yet been migrated will need to reset their password when they log in for the first time.

The high level design for the seamless migration process is shown below.

Harvest credentials from the legacy identity provider and update corresponding accounts in External ID.

:::image type="content" source="media/how-to-migrate-users/pre-migration-stage1.png" alt-text="A diagram showing the high level design for the first phase of credential migration.":::

Stop harvesting credentials and migrate applications to authenticate with External ID. Decommission the legacy identity provider.

:::image type="content" source="media/how-to-migrate-users/pre-migration-stage2.png" alt-text="A diagram showing the high level design for the second phase of credential migration.":::

> [!Note]
> If you are using this approach it's important to protect your REST API against brute-force attacks. An attacker can submit several passwords in the hope of eventually guessing a user's credentials. To help defeat such attacks, stop serving requests to your REST API when the number of sign-in attempts passes a certain threshold.

## Related content

If you are migrating from Azure AD B2C, the [seamless user migration sample](https://github.com/azure-ad-b2c/samples/tree/master/policies/migrate-to-entra-external-id-for-customers) repository on GitHub contains a seamless migration custom policy example and REST API code sample.
