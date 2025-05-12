---
title: Secretless authentication in Azure
description: 

author: rwike77
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: concept-article
ms.reviewer: hosamsh
ms.date: 05/09/2025
ms.author: ryanwi


#Customer intent: As a Azure developer or IT admin, I'd like learn about secretless authentication in Azure so I can securely access Azure resources without managing or storing passwords or secrets.
---

# Secretless authentication to Azure resources

Passwords and security keys have been the foundation of digital security for decades, but are no longer able to keep up with modern security threats.  Secretless, or credential-free authentication, associated with the zero-trust model, is a shift in how access control and user verification are handled within digital environments. Secretless authentication involves designing secure applications in the cloud without relying on traditional, shared credentials such as passwords, certificates, secrets, or security keys.  Secretless authentication provides the following benefits:

- Reduced credential risks: By eliminating passwords, secretless authentication mitigates risks associated with credential theft, phishing attacks, and brute force attacks. This approach uses verifiable identity elements such as biometrics, digital certificates, and hardware tokens.
- Streamlined access control: It enhances security and streamlines the user experience by relying on mechanisms that verify true identity rather than shared secrets. This aligns with the principles of zero trust by verifying every access request based on true identity.
- Improved end-user experience: Users benefit from a more seamless and secure authentication process, which reduces the need for password resets and improves overall user satisfaction.

This article explains secretless authentication options for different Azure application scenarios.

### Security challenges with passwords and secrets

Passwords and and other secrets should be used with caution, and developers must never place them in an unsecure location. Many apps connect to backend database, cache, messaging, and eventing services using usernames, passwords, and access keys. If exposed, these credentials could be used to gain unauthorized access to sensitive information such as a sales catalog that you built for an upcoming campaign, or customer data that must be private.

Embedding passwords in an application itself presents a huge security risk for many reasons, including discovery through a code repository. Many developers externalize such passwords using environment variables so that applications can load them from different environments. However, this only shifts the risk from the code itself to an execution environment. Anyone who gains access to the environment can steal passwords, which in turn, increases your data exfiltration risk.


### Security challenges with keys

Using cryptographic keys in Azure application development presents several challenges that can complicate both security and operational efficiency. One major issue is key management complexities, which involve the cumbersome tasks of rotating, distributing, and securely storing keys across various services and environments. This ongoing process requires dedicated resources and can significantly increase operational costs due to the need for regular maintenance and monitoring. Additionally, there are substantial security risks associated with key exposure or misuse, as unauthorized access due to leaked keys can compromise sensitive data. Furthermore, key-based authentication methods often lack the scalability and flexibility needed for dynamic environments, making it difficult to adapt to changing requirements and scale operations effectively. These challenges highlight the importance of adopting more secure and efficient authentication methods, such as managed identities, to mitigate risks and streamline operations.

## Client application (user-facing) accesses Microsof Entra protected resources

Features like multifactor authentication (MFA) are a great way to secure your organization, but users often get frustrated with the extra security layer on top of having to remember their passwords. Passwordless authentication methods are more convenient because the password is removed and replaced with something you have or something you are or know.

Each organization has different needs when it comes to authentication. Microsoft Entra ID and Azure Government integrate the following passwordless authentication options:

- Windows Hello for Business
- Platform Credential for macOS
- Platform single sign-on (PSSO) for macOS with smart card authentication
- Microsoft Authenticator
- Passkeys (FIDO2)
- Certificate-based authentication

To learn more, read [Microsoft Entra passwordles sign-in](/entra/identity/authentication/concept-authentication-passwordless).

## Azure service-to-Azure service (Within Azure)

For scenarios where one Azure resource needs to call another (for example, an Azure Function accessing an Azure Storage account, or an Azure VM calling Azure Key Vault), the recommended option is to use managed identities. This provides a completely passwordless, cloud-managed identity for your service with no secrets to worry about.

### Accesses Microsoft Entra protected resources (same tenant)

[Managed identities](/entra/identity/managed-identities-azure-resources/overview) and the `DefaultAzureCredential` class in the Azure Identity client library are the recommended authentication option for secure, passwordless connections between Azure resources.

For more info, read [Configure secretlesss connections between Azure apps and services](/azure/storage/common/multiple-identity-scenarios?toc=%2Fazure%2Fdeveloper%2Fintro%2Ftoc.json&bc=%2Fazure%2Fdeveloper%2Fbreadcrumb%2Ftoc.json&tabs=csharp).

### Accesses Microsoft Entra protected resources (across tenants)

In the past, you would have created a multi-tenant application with a client secret or certificate as credentials to authenticate and access resources in multiple tenants.  Using a managed identity as a federated identity credential allows your Azure hosted workload to access Microsoft Entra protected resources across tenants without managing secrets. 

To learn more, read [Configure an application to trust a managed identity](/entra/workload-id/workload-identity-federation-config-app-trust-managed-identity).

## Azure service accesses external or non-Microsoft Entra protected resources

Use Azure Keyvault if the target resource is not protected by Microsoft Entra or requires a password, secret, key, or certificate for access.  Store the credentials in a key vault and use a managed identity to retrieve the credentials and access the target resource.  For more informtaion, read [Authenticate to Key Vault in code](/azure/key-vault/general/developers-guide#authenticate-to-key-vault-in-code).

## External workload (outside Azure) acesses Microsoft Entra protected resources

When software is running outside of Azure (for example, on-premises datacenter, on a developer’s machine, or in another cloud) and needs to access Azure resources, you can’t use an Azure managed identity directly. In the past, you would register an Azure AD application and use a client secret or certificate for the external app to sign in – but that involves a secret. Workload identity federation allows an external app to access Microsoft Entra protected resources without managing secrets.

- Workload identity federation- [Configure an app to trust an external identity provider](/entra/workload-id/workload-identity-federation-create-trust)
- Workload identity federation- [Configure a user-assigned managed identity to trust an external identity provider](/entra/workload-id/workload-identity-federation-create-trust-user-assigned-managed-identity)

## Next steps