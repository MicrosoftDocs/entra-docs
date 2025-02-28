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

Migrating from another identity provider, including Azure AD B2C, to Microsoft Entra External ID might also require migrating existing user accounts and credentials. Two migration methods are discussed here, pre migration and seamless migration.

## Pre-migration

In the pre migration flow, your migration application performs these steps for each user account: 

1. Read the user account from the old identity provider, including its current credentials (username and password). 
1. Create a corresponding account in your Entra External ID directory with the current credentials. 

Use the pre migration flow in any of these situations: 

- You have access to a user's plaintext credentials (their username and password). 
- The credentials are encrypted, but you can decrypt them. 
- You do not have access to the user’s plaintext credentials, and will force users to reset their password on next logon. 

For information about programmatically creating user accounts, see [Manage Consumer user accounts with Microsoft Graph](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0&tabs=http#example-2-create-a-user-with-social-and-local-account-identities-in-azure-ad-b2c).   

When following this approach to migrate from Azure AD B2C to Microsoft Entra External ID, users will be required to reset their passwords on first log-on to an application that is protected by External ID.

You may consider using External ID's password-less capabilities which would allow users to continue using applications without having to reset their password.  

When migrating users from Azure AD B2C, you can register the verified email address as a multi factor authentication method by adding the email authentication method to the user object. This can be added to the user object through the Microsoft Graph API [create emailMethod](https://learn.microsoft.com/en-us/graph/api/resources/emailauthenticationmethod?view=graph-rest-1.0) operation.  

## Seamless migration

Use the seamless migration flow if plaintext passwords in the old identity provider are not accessible. For example, when: 

- The password is stored in Azure AD B2C. 
- The password is stored in a one-way encrypted format, such as with a hash function. 
- The password is stored by the legacy identity provider in a way that you can't access. For example, when the identity provider validates credentials by calling a web service. 

### Phase 1: Pre migration 

1. Your migration application reads the user accounts from the old identity provider, including Azure AD B2C. 
1. The migration application creates the corresponding user accounts in your Entra External Id directory, with random passwords that you generate. 
1. The migration application adds an extension attribute to the user account which flags the account for migration. 

### Phase 2: Credentials

1. Read the Microsoft Entra External ID user account corresponding to the email address entered, and continue if the user requires migration. 

1. If the legacy IdP determines the password is incorrect, return a friendly error to the user. 

1. If the legacy IdP determines the password is correct, use the REST API to write the password to the Entra External Id account and change the extension attribute to False. git 

