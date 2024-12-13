---
title: Public and confidential client apps (MSAL)
description: Learn about public client and confidential client applications in the Microsoft Authentication Library (MSAL).
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: has-adal-ref
ms.date: 07/24/2024
ms.reviewer: iambmelt
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an application developer, I want to learn about the types of client apps so I can decide if this platform meets my app development requirements.
---

# Public client and confidential client applications

The Microsoft Authentication Library (MSAL) defines two types of clients; public clients and confidential clients. A client is a software entity that has a unique identifier assigned by an identity provider. The client types are distinguished by their ability to authenticate securely with the authorization server and to hold sensitive, identity proving information so that it can't be accessed or known to a user within the scope of its access.

  | Public client apps | Confidential client apps |
  | --- | --- | --- |
  | ![Desktop app](./media/hub/app-type-desktop.svg) Desktop app | ![Web app](./media/hub/app-type-web.svg) Web app |
  | ![Browserless API](./media/hub/app-type-daemon-console.svg) Browserless API | ![Web API](./media/hub/app-type-api.svg) Web API |
  | ![Mobile app](./media/hub/app-type-mobile.svg) Mobile app | ![Daemon/service](./media/hub/app-type-daemon-console.svg) Service/daemon |

## Public client and confidential client authorization

When examining the public or confidential nature of a given client, we're evaluating the ability of that client to prove its identity to the authorization server. This is important because the authorization server must be able to trust the identity of the client in order to issue access tokens.

- **Public client applications** run on devices, such as desktop, browserless APIs, mobile or client-side browser apps. They can't be trusted to safely keep application secrets, so they can only access web APIs on behalf of the user. Anytime the source or compiled bytecode of a given app is transmitted anywhere it can be read, disassembled, or otherwise inspected by untrusted parties, it's a public client. As they also only support public client flows and can't hold configuration-time secrets, they can't have client secrets.

- **Confidential client applications** run on servers, such as web apps, web API apps, or service/daemon apps. They're considered difficult to access by users or attackers, and therefore can adequately hold configuration-time secrets to assert proof of its identity. The client ID is exposed through the web browser, but the secret is passed only in the back channel and never directly exposed.

## When should you enable allow a public client flow in your app registration?

After determining the type of client application you're building, you can decide whether to enable the public client flow in your app registration. By default, allow public client flow in your app registration should be disabled unless you or your developer are building a public client application and using the following OAuth authorization protocol or features:

| OAuth Authorization protocol/Feature | Type of public client application | Examples/notes |
| --- | --- | --- |
| [Native Authentication](../external-id/customers/concept-native-authentication.md) | Microsoft Entra External ID application that requires full customization of the user interface, including design elements, logo placement, and layout, ensuring a consistent and branded look. | **Note:**  Native Authentication is only available for app registrations in Microsoft Entra External ID tenants. [Learn more here](../external-id/customers/concept-native-authentication.md) |
| [Device code flow](v2-oauth2-device-code.md) | Applications that run on input-constrained devices such as a smart TV, IoT device, or a printer |  |
| [Resource owner password credential flow](v2-oauth-ropc.md) | Applications that handles passwords users enter directly, instead of redirecting users to Entra hosted login website and letting Entra handle user password in a secure manner. | **Microsoft recommends you do not use the ROPC flow**. In most scenarios, more secure alternatives, such as the Authorization code flow, are available and recommended. |
| [Windows Integrated Auth Flow](/entra/msal/dotnet/acquiring-tokens/desktop-mobile/integrated-windows-authentication) | Desktop or mobile applications running on Windows or on a machine connected to a Windows domain (Microsoft Entra ID or Microsoft Entra joined) using Windows Integrated Auth Flow instead of Web account manager | A desktop or mobile application that should be automatically signed in after the user has signed into the windows PC system with a Microsoft Entra credential |

### Secrets and their importance in proving identity

The following are some examples of how a client can prove its identity to the authorization server:

- **Managed identities for Azure resources** – For app-only authentication scenarios, application and service developers building on Azure have the option to offload secret management, rotation, and protection to the platform itself. With managed identities, identities are provided and deleted with Azure resources and no one, including the [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator), can access the underlying credentials. By using managed identities, you can prevent the risk of leaking secrets and let the provider handle the security for you.
- **Client ID and secret** – In this pattern, a pair of values is generated by the authorization server when registering a client. The client ID is a public value that identifies the application, while the client secret is a confidential value used to prove the identity of the application.
- **Proving possession of a certificate** – Public Key Infrastructure (PKI), which includes standards such as [X.509](/azure/iot-hub/reference-x509-certificates), is the fundamental technology that enables secure communication over the internet and forms the backbone of internet privacy. PKI is used to issue digital certificates that verify the identity of parties involved in online communication and is the underlying technology that powers protocols such as HTTPS, which is widely used to secure web traffic. Similarly, certificates can be used to secure service-to-service (S2S) communication in Azure by enabling mutual authentication between the services. This involves each service presenting a certificate to the other as a means of proving its identity.
- **Presentation of a signed assertion** – Used in workload identity federation, signed assertions enable the exchange of a trusted third party identity provider token with the Microsoft identity platform to obtain access tokens to call Microsoft Entra protected resources. Workload identity federation can be used to enable various federation scenarios, including Azure Kubernetes Service, Amazon Web Services EKS, GitHub Actions, and more.

## When does proving client identity matter?

Proving client identity matters when there's a need to verify both the authenticity and authorization of a client application before granting access to sensitive data or resources. Some examples include:

- **Controlling API access** – If you have an API that is metered (such as for billing), or exposes sensitive data or resources, you'll verify the identity of the client before granting access. For example, this is important when ensuring that only authorized applications have access to the API, and that the correct customer is billed for their metered API usage.
- **Protecting users from app impersonation** – If you have a service-deployed, user-facing application (such as a backend-driven web app) that accesses sensitive data or services, using client secrets to protect the resources used by that application may prevent bad actors from impersonating a legitimate client to phish users and exfiltrate data or abuse access.
- **S2S communication** – If you have multiple backend services (such as downstream APIs) that need to communicate with each other, you can verify the identity of each service to ensure they're authorized to access only necessary resources to perform their function.

In general, proving client identity matters when there's a need to authenticate and authorize a client independent of or in addition to a user.

## Confidential clients: best practices for managing secrets

**Use managed identities to simplify deployment and security** – [Managed identities](../identity/managed-identities-azure-resources/overview.md) provide an automatically managed identity in Microsoft Entra ID for applications to use when connecting to resources that support Microsoft Entra authentication. Applications can use managed identities to obtain Microsoft Entra ID app-only tokens without having to manage credentials. This can remove many of the complexities associated with secret management, while increasing your security and resiliency. If you’re using managed identities, most, if not all of the following best practices are already taken care of for you.

**Use secure storage** – Store client secrets in a secure location, such as [Key Vault](https://azure.microsoft.com/products/key-vault/) or an [encrypted configuration file](/azure/devops/pipelines/process/set-secret-variables). Avoid storing client secrets in plaintext or as checked-in files to version control systems.

**Limit access** - Limit access to client secrets to only authorized personnel. Use [role-based access control](/azure/role-based-access-control/overview) to restrict access to client secrets to only those who need it to perform their operational duties.

**Rotate client secrets** – [Rotation of client secrets](/azure/key-vault/keys/how-to-configure-key-rotation) on an as-needed or scheduled basis, can minimize the risk of a compromised secret being used to gain unauthorized access. When applied, the time span during which a key is suggested to remain in use is influenced by the strength of the cryptographic algorithm used and/or the adherence to standards or regulatory compliance practices.

**Use long secrets and strong encryption** – Closely related to the previous point, using strong encryption algorithms for data both in-transit (on the wire) and at-rest (on disk) helps ensure that high-entropy secrets remain unlikely to be brute-forced. Algorithms such as AES-128 (or higher) can help protect data at rest, while RSA-2048 (or higher) can help efficiently protect data in transit. Due to the ever-evolving nature of cybersecurity, it's always best practice to consult your security experts and periodically review your algorithm selection.

**Avoid hardcoding secrets** – Do not hardcode client secrets in source code. Avoiding secrets in source code can minimize the value of bad actors gaining access to your source code. It can also prevent such secrets from accidentally being pushed to insecure repositories or made available to project contributors who could have source access, but not secret access.

**Monitor repositories for leaked secrets** – It’s an unfortunate fact that bad check-ins happen when dealing with source code. Git pre-commit hooks are a suggested way to prevent accidental check-ins, but isn't a substitute for monitoring as well. Automated monitoring of repositories can identify leaked secrets and, with a plan in place to rotate compromised credentials, can help reduce security incidents.

**Monitor for suspicious activity** – [Monitor](/azure/azure-monitor) logs and audit trails for suspicious activity related to client secrets. Where possible use automated alerts and response processes to notify personnel and define contingencies for unusual activity related to client secrets.

**Architect your applications with client secrecy in mind** – Your security model is only as strong as the weakest link in the chain. [Do not forward security credentials or tokens from confidential to public clients](v2-oauth2-on-behalf-of-flow.md#protocol-diagram), as this could move client secret data to a public client, allowing impersonation of the confidential client.

**Use up-to-date libraries and SDKs from trusted sources** – The Microsoft identity platform provides various client and server SDKs and middleware designed to boost your productivity while keeping your applications secure. Libraries such as [Microsoft.Identity.Web](/entra/msal/dotnet/microsoft-identity-web) simplify adding authentication and authorization to web apps and APIs on the Microsoft identity platform. Keeping dependencies updated helps ensure your applications and services benefit from the latest security innovations and updates.

## Comparing the client types and their capabilities

The following are some similarities and differences between public and confidential client apps:

- Both app types maintain a user token cache and can acquire a token silently (when the token is present in the cache). Confidential client apps also have an app token cache for tokens acquired by the app itself.
- Both app types can manage user accounts and get an account from the user token cache, get an account from its identifier, or remove an account.
- In MSAL, public client apps have four ways to acquire a token, through separate authentication flows. Confidential client apps only have three ways to acquire a token and one way to compute the URL of the identity provider authorize endpoint. The *client ID* is passed once at the construction of the application and doesn't need to be passed again when the app acquires a token. For more information, see [acquiring tokens](msal-acquire-cache-tokens.md).

Public clients are useful for enabling user-delegated access to protected resources but are unable to prove their own application identity. Confidential clients, on the other hand, can perform both user and application authentication and authorization and must be built with security in mind to ensure that their secrets aren't shared with public clients or other third parties.

In some cases, such as S2S communication, infrastructure like managed identities greatly helps to simplify the development and deployment of services and removes much of the complexity typically associated with secret management. When managed identities can't be used, it’s important to have policies, preventive measures, and contingencies in place for securing secrets and responding with security incidents related to them.

## See also

For more information about application configuration and instantiating, see:

- [Client application configuration options](msal-client-application-configuration.md)
- [Instantiating client applications by using MSAL.NET](/entra/msal/dotnet/getting-started/initializing-client-applications)
- [Instantiating client applications by using MSAL.js](msal-js-initializing-client-applications.md)
