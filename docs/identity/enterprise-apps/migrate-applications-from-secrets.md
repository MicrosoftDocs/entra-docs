---
title: Migrate applications away from secret-based authentication
description: Migrate applications away from secret-based authentication to improve security and user experience.

author: garrodonnell
manager: celested
ms.service: entra-id

ms.topic: how-to
ms.date: 11/13/2024
ms.author: godonnell
ms.subservice: enterprise-apps

#customer intent: As an IT admin currently using secret-based authentication, I want to migrate my applications to a more secure and user-friendly authentication method, so that I can improve security and user experience.
---

# Migrate applications away from secret-based authentication

Applications that use client secrets might store them in configuration files, hardcode them in scripts, or risk their exposure in other ways. Secret management complexities make secrets susceptible to leaks and attractive to attackers. Client secrets, when exposed, provide attackers with legitimate credentials to blend their activities with legitimate operations, making it easier to bypass security controls. If an attacker compromises an application’s client secret, they can escalate their privileges within the system, leading to broader access and control, depending on the permissions of the application. Replacing a compromised certificate can be incredibly time-consuming and disruptive. 

In this article, we will highlight resources and best practices to help you migrate your applications away from secret-based authentication to more secure and user-friendly authentication methods.

## Why migrate applications away from secret-based authentication?

Migrating applications away from secret-based authentication offers several benefits:

- **Improved security**: Secret-based authentication is susceptible to leaks and attacks. Migrating to more secure authentication methods, such as managed identities, can help improve security.  

- **Reduced complexity**: Managing secrets can be complex and error-prone. Migrating to more secure authentication methods can help reduce complexity and improve security.  

- **Scalability**: Migrating to more secure authentication methods can help you scale your applications securely.  

- **Compliance**: Migrating to more secure authentication methods can help you meet compliance requirements and security best practices.  


## How to migrate applications away from secret-based authentication

To migrate applications away from secret-based authentication, consider the following best practices:

### Use managed identities for Azure resources

Managed identities are a secure way to authenticate applications to cloud services without the need to manage credentials or to have credentials in your code. Azure services use this identity to authenticate to services that support Microsoft Entra authentication. To learn more see, [Assign a managed identity access to an application role](../../identity/managed-identities-azure-resources/how-to-assign-app-role-managed-identity.md).  

For applications that cannot be migrated in the short term, rotate the secret and ensure they use secure practices such as using Azure Key Vault. Azure Key Vault helps you safeguard cryptographic keys and secrets used by cloud applications and services. Keys, secrets, and certificates are protected without you're having to write the code yourself, and you can easily use them from your applications. To learn more see, [Azure Key Vault](/azure/key-vault/general/developers-guide).  
    
### Deploy conditional access policies for workload identities

Conditional Access for workload identities enables blocking service principals from outside of known public IP ranges, based on risk detected by Microsoft Entra ID Protection or in combination with authentication contexts. To learn more see, [Conditional Access for workload identities](../conditional-access/workload-identity.md).  

### Implement secret scanning

Secret scanning for your repository checks for any secrets that may already exist in your source code across history and push protection prevents any new secrets from being exposed in source code. To learn more see, [Secret scanning](/azure/devops/repos/security/github-advanced-security-secret-scanning).  

### Deploy application authentication policies to enforce secure authentication practices.

Application management policies allow IT admins to enforce best practices for how apps in their organizations should be configured. For example, an admin might configure a policy to block the use or limit the lifetime of password secrets. To learn more see, [Microsoft Entra application management policies API overview](/graph/api/resources/applicationauthenticationmethodpolicy).  

### Use federated identity for service accounts

Identity federation allows you to access Microsoft Entra protected resources without needing to manage secrets (for supported scenarios) by creating a trust relationship between an external identity provider (IdP) and an app in Microsoft Entra ID by configuring a federated identity credential. To learn more see, [Overview of federated identity credentials in Microsoft Entra ID](/graph/api/resources/federatedidentitycredentials-overview).  

### Create a least-privileged custom role to rotate application credentials

Microsoft Entra roles allow you to grant granular permissions to your admins, abiding by the principle of least privilege. A custom role can be created to rotate application credentials, ensuring that only the necessary permissions are granted to complete the task. To learn more see, [Create and assign a custom role in Microsoft Entra ID](../role-based-access-control/privileged-roles-permissions.md).  

### Ensure you have a process to triage and monitor applications 

This process should include regular security assessments, vulnerability scanning, and incident response procedures. Awareness of the security posture of your applications is essential to maintaining a secure environment.  

## Related content

- [Develop using Zero Trust principles](https://learn.microsoft.com/security/zero-trust/develop/overview).
- [Zero Trust identity and access management development best practices](https://learn.microsoft.com/security/zero-trust/develop/identity-iam-development-best-practices)


