---
title: Migrate applications away from secret-based authentication
description: Migrate applications away from secret-based authentication to improve security and user experience.

author: garrodonnell
manager: dougeby
ms.service: entra-id

ms.topic: concept-article
ms.date: 03/19/2025
ms.author: godonnell
ms.subservice: enterprise-apps

#customer intent: As an IT admin currently using secret-based authentication, I want to migrate my applications to a more secure and user-friendly authentication method, so that I can improve security and user experience.
---


# Migrate applications away from secret-based authentication

Applications that use client secrets might store them in configuration files, hardcode them in scripts, or risk their exposure in other ways. Secret management complexities make secrets susceptible to leaks and attractive to attackers. Client secrets, when exposed, provide attackers with legitimate credentials to blend their activities with legitimate operations, making it easier to bypass security controls. If an attacker compromises an application’s client secret, they can escalate their privileges within the system, leading to broader access and control, depending on the permissions of the application. Replacing a compromised certificate can be incredibly time-consuming and disruptive. For these reasons, Microsoft recommends that all of our customers move away from password or certificate-based authentication to token-based authentication. 

In this article, we highlight resources and best practices to help you migrate your applications away from secret-based authentication to more secure and user-friendly authentication methods.

## Why migrate applications away from secret-based authentication?

Migrating applications away from secret-based authentication offers several benefits:

- **Improved security**: Secret-based authentication is susceptible to leaks and attacks. Migrating to more secure authentication methods, such as managed identities, improves security.  

- **Reduced complexity**: Managing secrets can be complex and error-prone. Migrating to more secure authentication methods reduces complexity and improves security.  

- **Scalability**: Migrating to more secure authentication methods helps you scale your applications securely.  

- **Compliance**: Migrating to more secure authentication methods helps you meet compliance requirements and security best practices.  


## Best practices for migrating applications away from secret-based authentication

To migrate applications away from secret-based authentication, consider the following best practices:

### Use managed identities for Azure resources

Managed identities are a secure way to authenticate applications to cloud services without the need to manage credentials or to have credentials in your code. Azure services use this identity to authenticate to services that support Microsoft Entra authentication. To learn more, see [Assign a managed identity access to an application role](../../identity/managed-identities-azure-resources/how-to-assign-app-role-managed-identity.md).  

For applications that can't be migrated in the short term, rotate the secret and ensure they use secure practices such as using Azure Key Vault. Azure Key Vault helps you safeguard cryptographic keys and secrets used by cloud applications and services. Keys, secrets, and certificates are protected without you having to write the code yourself, and you can easily use them from your applications. To learn more, see [Azure Key Vault](/azure/key-vault/general/developers-guide).  
    
### Deploy Conditional Access policies for workload identities

Conditional Access for workload identities enables you to block service principals from outside of known public IP ranges, based on risk detected by Microsoft Entra Protection or in combination with authentication contexts. To learn more, see [Conditional Access for workload identities](../conditional-access/workload-identity.md). 

> [!IMPORTANT]
> Workload Identities Premium licenses are required to create or modify Conditional Access policies scoped to service principals.
> In directories without appropriate licenses, existing Conditional Access policies for workload identities continue to function, but can't be modified. For more information, see [Microsoft Entra Workload ID](https://www.microsoft.com/security/business/identity-access/microsoft-entra-workload-identities#office-StandaloneSKU-k3hubfz).   

### Implement secret scanning

Secret scanning for your repository checks for any secrets that might already exist in your source code across history and push protection prevents any new secrets from being exposed in source code. To learn more, see [Secret scanning](/azure/devops/repos/security/github-advanced-security-secret-scanning).  

### Deploy application authentication policies to enforce secure authentication practices

Application management policies allow IT admins to enforce best practices for how apps in their organizations should be configured. For example, an admin might configure a policy to block the use or limit the lifetime of password secrets. To learn more, see [Tutorial: Enforce secret and certificate standards using application management policies](tutorial-enforce-secret-standards.md) and [Microsoft Entra application management policies API overview](/graph/api/resources/applicationauthenticationmethodpolicy).

> [!IMPORTANT]
> Premium licenses are required to implement application authentication policy management, for more information, see [Microsoft Entra licensing](../../fundamentals/licensing.md).   

### Use federated identity for service accounts

Identity federation allows you to access Microsoft Entra protected resources without needing to manage secrets (for supported scenarios) by creating a trust relationship between an external identity provider (IdP) and an app in Microsoft Entra ID by configuring a federated identity credential. To learn more, see [Overview of federated identity credentials in Microsoft Entra ID](/graph/api/resources/federatedidentitycredentials-overview).  

### Create a least-privileged custom role to rotate application credentials

Microsoft Entra roles allow you to grant granular permissions to your admins, abiding by the principle of least privilege. A custom role can be created to rotate application credentials, ensuring that only the necessary permissions are granted to complete the task. To learn more, see [Create a custom role in Microsoft Entra ID](../role-based-access-control/custom-create.md).

### Ensure you have a process to triage and monitor applications 

This process should include regular security assessments, vulnerability scanning, and incident response procedures. Awareness of the security posture of your applications is essential to maintaining a secure environment.  

## Related content

- [Develop using Zero Trust principles](/security/zero-trust/develop/overview).
- [Zero Trust identity and access management development best practices](/security/zero-trust/develop/identity-iam-development-best-practices)


