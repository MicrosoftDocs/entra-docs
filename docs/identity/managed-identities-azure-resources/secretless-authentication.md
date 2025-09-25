---
title: Secretless authentication in Azure
description: Learn about secretless authentication in Azure to reduce credential risks, enhance security, and streamline user experience with Zero Trust principles.

author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: concept-article
ms.reviewer: hosamsh
ms.date: 05/09/2025
ms.author: shermanouko


#Customer intent: As a Azure developer or IT admin, I'd like learn about secretless authentication in Azure so I can securely access Azure resources without managing or storing passwords or secrets.
---

# Secretless authentication for Azure resources

Passwords and security keys were the foundation of digital security for decades, but they can no longer keep up with modern threats. Secretless authentication, aligned with the Zero Trust model, shifts access control and user verification to a credential-free approach. Secretless authentication involves designing secure applications in the cloud without relying on traditional, shared credentials such as passwords, certificates, secrets, or security keys.  Secretless authentication provides the following benefits:

- Reduced credential risks: By eliminating passwords, secretless authentication mitigates risks associated with credential theft, phishing attacks, and brute force attacks. This approach uses verifiable identity elements such as biometrics, digital certificates, and hardware tokens.
- Streamlined access control: It enhances security and streamlines the user experience by relying on mechanisms that verify true identity rather than shared secrets. This aligns with the principles of Zero Trust by verifying every access request based on true identity.
- Improved end-user experience: Users benefit from a more seamless and secure authentication process, which reduces the need for password resets and improves overall user satisfaction.

This article explores secretless authentication in Azure, its benefits, and how to implement it across various scenarios, including client applications, Azure service-to-service communication, and external workloads.

### Security challenges of passwords and secrets

Passwords and other secrets should be used with caution, and developers must never place them in an unsecure location. Many apps connect to backend database, cache, messaging, and eventing services using usernames, passwords, and access keys. If exposed, these credentials could be used to gain unauthorized access to sensitive information such as a sales catalog that you built for an upcoming campaign, or customer data that must be private.

Embedding passwords in an application itself presents a huge security risk for many reasons, including discovery through a code repository. Many developers externalize such passwords using environment variables so that applications can load them from different environments. However, this only shifts the risk from the code itself to an execution environment. Anyone who gains access to the environment can steal passwords, which in turn, increases your data exfiltration risk.

### Security challenges of keys

Using cryptographic keys in Azure application development presents several challenges that can complicate both security and operational efficiency. One major issue is key management complexities, which involve the cumbersome tasks of rotating, distributing, and securely storing keys across various services and environments. This ongoing process requires dedicated resources and can significantly increase operational costs due to the need for regular maintenance and monitoring. Additionally, there are substantial security risks associated with key exposure or misuse, as unauthorized access due to leaked keys can compromise sensitive data. Furthermore, key-based authentication methods often lack the scalability and flexibility needed for dynamic environments, making it difficult to adapt to changing requirements and scale operations effectively. These challenges highlight the importance of adopting more secure and efficient authentication methods, such as managed identities, to mitigate risks and streamline operations.

## Client application (user-facing) accesses Microsoft Entra protected resources

Features like multifactor authentication (MFA) are a great way to secure your organization, but users often get frustrated with the extra security layer on top of having to remember their passwords. Passwordless authentication methods are more convenient because the password is removed and replaced with something you have or something you are or know.

Each organization has different needs when it comes to authentication. Microsoft Entra ID and Azure Government integrate the following passwordless authentication options:

- Windows Hello for Business
- Platform Credential for macOS
- Platform single sign-on (PSSO) for macOS with smart card authentication
- Microsoft Authenticator
- Passkeys (FIDO2)
- Certificate-based authentication

To learn more, read [Microsoft Entra passwordless sign-in](/entra/identity/authentication/concept-authentication-passwordless).

## Azure service-to-Azure service (within Azure)

When authenticating between Azure resources (service-to-service authentication), the recommended approach is to use [Managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview). When authenticating and accessing resources across tenants, however, you should set up a managed identity as a federated identity credential on an application.

### Accesses Microsoft Entra protected resources (same tenant)

For scenarios where you need service-to-service authentication between Azure resources and the resources are in the same tenant, 
managed identities and the `DefaultAzureCredential` class in the Azure Identity client library are the recommended option.

A managed identity is an identity that can be assigned to an Azure compute resource (for example Azure Virtual Machines, Azure Functions, or Azure Kubernetes) or any [Azure service that supports managed identities](/entra/identity/managed-identities-azure-resources/managed-identities-status). Once a managed identity is assigned on the compute resource, it can be authorized to access downstream dependency resources, such as a storage account, SQL database, Cosmos DB, and so on. Managed identities replace secrets such as access keys or passwords and certificates or other forms of authentication for service-to-service dependencies.

For more information, read [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview).

Implement `DefaultAzureCredential` and managed identities in your application to create passwordless connections to Azure services through Microsoft Entra ID and Role Based Access control (RBAC). `DefaultAzureCredential` supports multiple authentication methods and automatically determines which should be used at runtime. This approach enables your app to use different authentication methods in different environments (local dev vs. production) without implementing environment-specific code.

For more info on using `DefaultAzureCredential` and a managed identity in your application, read [Configure secretless connections between Azure apps and services](/azure/storage/common/multiple-identity-scenarios?toc=%2Fazure%2Fdeveloper%2Fintro%2Ftoc.json&bc=%2Fazure%2Fdeveloper%2Fbreadcrumb%2Ftoc.json&tabs=csharp).

### Accesses Microsoft Entra protected resources (across tenants)

Managed identities are recommended for scenarios where you need service-to-service authentication between Azure resources.  Managed identities are not supported, however, for when accessing resources across tenants (multitenant apps). Previously, you created a multitenant application with a client secret or certificate as credentials to authenticate and access resources in multiple tenants.  This leaves you with significant risks around secrets exposure and adds the burden of storing, rotating, and maintaining certificate lifecycles.

Azure workloads can now use managed identities as federated identity credentials to securely access Microsoft Entra protected resources across tenants without relying on secrets or certificates. 

To learn more, read [Configure an application to trust a managed identity](/entra/workload-id/workload-identity-federation-config-app-trust-managed-identity).

## Azure service accesses external or non-Microsoft Entra protected resources

For Azure workloads that authenticate and access resources that aren't protected by Microsoft Entra or Azure services that require a password, secret, key, or certificate for access you can't directly use managed identities.  In this case, use Azure Key Vault to store the credentials for the target resource.  Use a managed identity from your workload to retrieve the credentials from key vault and access the target resource using the credentials.  

For more information, read [Authenticate to Key Vault in code](/azure/key-vault/general/developers-guide#authenticate-to-key-vault-in-code).

## External workload (outside Azure) accesses Microsoft Entra protected resources

When a software workload is running outside of Azure (for example, on-premises datacenter, on a developer’s machine, or in another cloud) and needs to access Azure resources, you can’t use an Azure managed identity directly. In the past, you would register an application with the Microsoft identity platform and use a client secret or certificate for the external app to sign in.  These credentials pose a security risk and have to be stored securely and rotated regularly. You also run the risk of service downtime if the credentials expire.

You use workload identity federation to configure a user-assigned managed identity or app registration in Microsoft Entra ID to trust tokens from an external identity provider (IdP), such as GitHub or Google. Once that trust relationship is created, your external software workload exchanges trusted tokens from the external IdP for access tokens from Microsoft identity platform. Your software workload uses that access token to access the Microsoft Entra protected resources to which the workload has been granted access.  You eliminate the maintenance burden of manually managing credentials and eliminates the risk of leaking secrets or having certificates expire.

To learn more, read [Workload identity federation](/entra/workload-id/workload-identity-federation).

## Next steps

- [Managed identity best practice recommendations](/entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations)
- [Passwordless connections for Azure services](/azure/developer/intro/passwordless-overview)
- [Authenticate .NET apps to Azure services using the Azure Identity library](/dotnet/azure/sdk/authentication/)